; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes=loop-vectorize -force-vector-width=1 -force-vector-interleave=2 -S %s | FileCheck %s

define void @test1_select_invariant(ptr %src.1, ptr %src.2, ptr %dst, i1 %c, i8 %n) {
; CHECK-LABEL: @test1_select_invariant(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[PTR_SEL:%.*]] = select i1 [[C:%.*]], ptr [[SRC_1:%.*]], ptr [[SRC_2:%.*]]
; CHECK-NEXT:    [[TMP0:%.*]] = add i8 [[N:%.*]], -1
; CHECK-NEXT:    [[TMP1:%.*]] = zext i8 [[TMP0]] to i32
; CHECK-NEXT:    [[TMP2:%.*]] = add nuw nsw i32 [[TMP1]], 1
; CHECK-NEXT:    [[MIN_ITERS_CHECK:%.*]] = icmp ult i32 [[TMP2]], 2
; CHECK-NEXT:    br i1 [[MIN_ITERS_CHECK]], label %scalar.ph, label %vector.memcheck
; CHECK:       vector.memcheck:
; CHECK-NEXT:    [[TMP3:%.*]] = add i8 [[N]], -1
; CHECK-NEXT:    [[TMP4:%.*]] = zext i8 [[TMP3]] to i64
; CHECK-NEXT:    [[TMP5:%.*]] = add nuw nsw i64 [[TMP4]], 1
; CHECK-NEXT:    [[UGLYGEP:%.*]] = getelementptr i8, ptr [[DST:%.*]], i64 [[TMP5]]
; CHECK-NEXT:    [[UGLYGEP1:%.*]] = getelementptr i8, ptr [[PTR_SEL]], i64 1
; CHECK-NEXT:    [[BOUND0:%.*]] = icmp ult ptr [[DST]], [[UGLYGEP1]]
; CHECK-NEXT:    [[BOUND1:%.*]] = icmp ult ptr [[PTR_SEL]], [[UGLYGEP]]
; CHECK-NEXT:    [[FOUND_CONFLICT:%.*]] = and i1 [[BOUND0]], [[BOUND1]]
; CHECK-NEXT:    br i1 [[FOUND_CONFLICT]], label %scalar.ph, label %vector.ph
;
entry:
  %ptr.sel = select i1 %c, ptr %src.1, ptr %src.2
  br label %loop

loop:
  %iv = phi i8 [ 0, %entry ], [ %iv.next, %loop ]
  %l.1 = load i8, ptr %ptr.sel, align 8
  %gep.dst = getelementptr i8, ptr %dst, i8 %iv
  store i8 %l.1, ptr %gep.dst, align 2
  %iv.next = add nsw nuw i8 %iv, 1
  %ec = icmp eq i8 %iv.next, %n
  br i1 %ec, label %exit, label %loop

exit:
  ret void
}

define void @test_loop_dependent_select1(ptr %src.1, ptr %src.2, ptr %dst, i1 %c, i8 %n) {
; CHECK-LABEL: @test_loop_dependent_select1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label %loop
; CHECK-NOT: vector.body:
;
entry:
  br label %loop

loop:
  %iv = phi i8 [ 0, %entry ], [ %iv.next, %loop ]
  %gep.src.1 = getelementptr i8, ptr %src.1, i8 %iv
  %gep.src.2 = getelementptr i8, ptr %src.2, i8 %iv
  %ptr.sel = select i1 %c, ptr %gep.src.1, ptr %gep.src.2
  %l.1 = load i8, ptr %ptr.sel, align 8
  %gep.dst = getelementptr i8, ptr %dst, i8 %iv
  store i8 %l.1, ptr %gep.dst, align 2
  %iv.next = add nsw nuw i8 %iv, 1
  %ec = icmp eq i8 %iv.next, %n
  br i1 %ec, label %exit, label %loop

exit:
  ret void
}


define void @test_loop_dependent_select2(ptr %src.1, ptr %src.2, ptr %dst, i8 %n, i8 %x) {
; CHECK-LABEL: @test_loop_dependent_select2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label %loop
; CHECK-NOT: vector.body:
;
entry:
  br label %loop

loop:
  %iv = phi i8 [ 0, %entry ], [ %iv.next, %loop ]
  %c = icmp ult i8 %iv, %x
  %ptr.sel = select i1 %c, ptr %src.1, ptr %src.2
  %l.1 = load i8, ptr %ptr.sel, align 8
  %gep.dst = getelementptr i8, ptr %dst, i8 %iv
  store i8 %l.1, ptr %gep.dst, align 2
  %iv.next = add nsw nuw i8 %iv, 1
  %ec = icmp eq i8 %iv.next, %n
  br i1 %ec, label %exit, label %loop

exit:
  ret void
}

define void @test_loop_dependent_select_first_ptr_noundef(ptr noundef %src.1, ptr %src.2, ptr %dst, i8 %n, i8 %x) {
; CHECK-LABEL: @test_loop_dependent_select_first_ptr_noundef(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label %loop
; CHECK-NOT: vector.body:
;
entry:
  br label %loop

loop:
  %iv = phi i8 [ 0, %entry ], [ %iv.next, %loop ]
  %c = icmp ult i8 %iv, %x
  %ptr.sel = select i1 %c, ptr %src.1, ptr %src.2
  %l.1 = load i8, ptr %ptr.sel, align 8
  %gep.dst = getelementptr i8, ptr %dst, i8 %iv
  store i8 %l.1, ptr %gep.dst, align 2
  %iv.next = add nsw nuw i8 %iv, 1
  %ec = icmp eq i8 %iv.next, %n
  br i1 %ec, label %exit, label %loop

exit:
  ret void
}

define void @test_loop_dependent_select_second_ptr_noundef(ptr %src.1, ptr noundef %src.2, ptr %dst, i8 %n, i8 %x) {
; CHECK-LABEL: @test_loop_dependent_select_second_ptr_noundef(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label %loop
; CHECK-NOT: vector.body:
;
entry:
  br label %loop

loop:
  %iv = phi i8 [ 0, %entry ], [ %iv.next, %loop ]
  %c = icmp ult i8 %iv, %x
  %ptr.sel = select i1 %c, ptr %src.1, ptr %src.2
  %l.1 = load i8, ptr %ptr.sel, align 8
  %gep.dst = getelementptr i8, ptr %dst, i8 %iv
  store i8 %l.1, ptr %gep.dst, align 2
  %iv.next = add nsw nuw i8 %iv, 1
  %ec = icmp eq i8 %iv.next, %n
  br i1 %ec, label %exit, label %loop

exit:
  ret void
}
