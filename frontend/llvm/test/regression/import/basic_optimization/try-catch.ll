; ModuleID = 'try-catch.cpp.pp.bc'
source_filename = "try-catch.cpp"
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.13.0"

; CHECK-LABEL: Bundle
; CHECK: target-endianness = little-endian
; CHECK: target-pointer-size = 64 bits
; CHECK: target-triple = x86_64-apple-macosx10.13.0

%class.A = type { i32 (...)** }
%class.B = type { %class.A }
%class.C = type { %class.B }

@G = global i32 0, align 4, !dbg !0
; CHECK: define si32* @G, align 4, init {
; CHECK: #1 !entry !exit {
; CHECK:   store @G, 0, align 1
; CHECK: }
; CHECK: }

@_ZTI1A = linkonce_odr constant { i8*, i8* } { i8* bitcast (i8** getelementptr inbounds (i8*, i8** @_ZTVN10__cxxabiv117__class_type_infoE, i64 2) to i8*), i8* getelementptr inbounds ([3 x i8], [3 x i8]* @_ZTS1A, i32 0, i32 0) }
; CHECK: define {0: si8*, 8: si8*}* @_ZTI1A, init {
; CHECK: #1 !entry !exit {
; CHECK:   si8** %1 = ptrshift @_ZTVN10__cxxabiv117__class_type_infoE, 8 * 2
; CHECK:   si8* %2 = ptrshift @_ZTS1A, 3 * 0, 1 * 0
; CHECK:   si8* %3 = bitcast %1
; CHECK:   store @_ZTI1A, {0: %3, 8: %2}, align 1
; CHECK: }
; CHECK: }

@_ZTI1B = linkonce_odr constant { i8*, i8*, i8* } { i8* bitcast (i8** getelementptr inbounds (i8*, i8** @_ZTVN10__cxxabiv120__si_class_type_infoE, i64 2) to i8*), i8* getelementptr inbounds ([3 x i8], [3 x i8]* @_ZTS1B, i32 0, i32 0), i8* bitcast ({ i8*, i8* }* @_ZTI1A to i8*) }
; CHECK: define {0: si8*, 8: si8*, 16: si8*}* @_ZTI1B, init {
; CHECK: #1 !entry !exit {
; CHECK:   si8** %1 = ptrshift @_ZTVN10__cxxabiv120__si_class_type_infoE, 8 * 2
; CHECK:   si8* %2 = bitcast @_ZTI1A
; CHECK:   si8* %3 = ptrshift @_ZTS1B, 3 * 0, 1 * 0
; CHECK:   si8* %4 = bitcast %1
; CHECK:   store @_ZTI1B, {0: %4, 8: %3, 16: %2}, align 1
; CHECK: }
; CHECK: }

@_ZTI1C = linkonce_odr constant { i8*, i8*, i8* } { i8* bitcast (i8** getelementptr inbounds (i8*, i8** @_ZTVN10__cxxabiv120__si_class_type_infoE, i64 2) to i8*), i8* getelementptr inbounds ([3 x i8], [3 x i8]* @_ZTS1C, i32 0, i32 0), i8* bitcast ({ i8*, i8*, i8* }* @_ZTI1B to i8*) }
; CHECK: define {0: si8*, 8: si8*, 16: si8*}* @_ZTI1C, init {
; CHECK: #1 !entry !exit {
; CHECK:   si8** %1 = ptrshift @_ZTVN10__cxxabiv120__si_class_type_infoE, 8 * 2
; CHECK:   si8* %2 = bitcast @_ZTI1B
; CHECK:   si8* %3 = ptrshift @_ZTS1C, 3 * 0, 1 * 0
; CHECK:   si8* %4 = bitcast %1
; CHECK:   store @_ZTI1C, {0: %4, 8: %3, 16: %2}, align 1
; CHECK: }
; CHECK: }

@_ZTS1A = linkonce_odr constant [3 x i8] c"1A\00"
; CHECK: define [3 x si8]* @_ZTS1A, init {
; CHECK: #1 !entry !exit {
; CHECK:   store @_ZTS1A, [49, 65, 0], align 1
; CHECK: }
; CHECK: }

@_ZTS1B = linkonce_odr constant [3 x i8] c"1B\00"
; CHECK: define [3 x si8]* @_ZTS1B, init {
; CHECK: #1 !entry !exit {
; CHECK:   store @_ZTS1B, [49, 66, 0], align 1
; CHECK: }
; CHECK: }

@_ZTS1C = linkonce_odr constant [3 x i8] c"1C\00"
; CHECK: define [3 x si8]* @_ZTS1C, init {
; CHECK: #1 !entry !exit {
; CHECK:   store @_ZTS1C, [49, 67, 0], align 1
; CHECK: }
; CHECK: }

@_ZTV1A = linkonce_odr unnamed_addr constant { [4 x i8*] } { [4 x i8*] [i8* null, i8* bitcast ({ i8*, i8* }* @_ZTI1A to i8*), i8* bitcast (void (%class.A*, i32)* @_ZN1A1fEi to i8*), i8* bitcast (i32 (%class.A*)* @_ZN1A1gEv to i8*)] }, align 8
; CHECK: define {0: [4 x si8*]}* @_ZTV1A, align 8, init {
; CHECK: #1 !entry !exit {
; CHECK:   si8* %1 = bitcast @_ZN1A1gEv
; CHECK:   si8* %2 = bitcast @_ZN1A1fEi
; CHECK:   si8* %3 = bitcast @_ZTI1A
; CHECK:   store @_ZTV1A, {0: [null, %3, %2, %1]}, align 1
; CHECK: }
; CHECK: }

@_ZTV1B = linkonce_odr unnamed_addr constant { [4 x i8*] } { [4 x i8*] [i8* null, i8* bitcast ({ i8*, i8*, i8* }* @_ZTI1B to i8*), i8* bitcast (void (%class.B*, i32)* @_ZN1B1fEi to i8*), i8* bitcast (i32 (%class.B*)* @_ZN1B1gEv to i8*)] }, align 8
; CHECK: define {0: [4 x si8*]}* @_ZTV1B, align 8, init {
; CHECK: #1 !entry !exit {
; CHECK:   si8* %1 = bitcast @_ZN1B1gEv
; CHECK:   si8* %2 = bitcast @_ZN1B1fEi
; CHECK:   si8* %3 = bitcast @_ZTI1B
; CHECK:   store @_ZTV1B, {0: [null, %3, %2, %1]}, align 1
; CHECK: }
; CHECK: }

@_ZTV1C = linkonce_odr unnamed_addr constant { [4 x i8*] } { [4 x i8*] [i8* null, i8* bitcast ({ i8*, i8*, i8* }* @_ZTI1C to i8*), i8* bitcast (void (%class.C*, i32)* @_ZN1C1fEi to i8*), i8* bitcast (i32 (%class.C*)* @_ZN1C1gEv to i8*)] }, align 8
; CHECK: define {0: [4 x si8*]}* @_ZTV1C, align 8, init {
; CHECK: #1 !entry !exit {
; CHECK:   si8* %1 = bitcast @_ZN1C1gEv
; CHECK:   si8* %2 = bitcast @_ZN1C1fEi
; CHECK:   si8* %3 = bitcast @_ZTI1C
; CHECK:   store @_ZTV1C, {0: [null, %3, %2, %1]}, align 1
; CHECK: }
; CHECK: }

@_ZTVN10__cxxabiv117__class_type_infoE = external global i8*
; CHECK: declare si8** @_ZTVN10__cxxabiv117__class_type_infoE

@_ZTVN10__cxxabiv120__si_class_type_infoE = external global i8*
; CHECK: declare si8** @_ZTVN10__cxxabiv120__si_class_type_infoE

; Function Attrs: noinline nounwind ssp uwtable
define void @_Z1hi(i32) #0 !dbg !12 {
  call void @llvm.dbg.value(metadata i32 %0, metadata !15, metadata !DIExpression()), !dbg !16
  ret void, !dbg !17
}
; CHECK: define void @_Z1hi(si32 %1) {
; CHECK: #1 !entry !exit {
; CHECK:   return
; CHECK: }
; CHECK: }

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind ssp uwtable
define i32 @_Z2hhi(i32) #0 !dbg !18 {
  call void @llvm.dbg.value(metadata i32 %0, metadata !21, metadata !DIExpression()), !dbg !22
  %2 = mul nsw i32 %0, %0, !dbg !23
  ret i32 %2, !dbg !24
}
; CHECK: define si32 @_Z2hhi(si32 %1) {
; CHECK: #1 !entry !exit {
; CHECK:   si32 %2 = %1 smul.nw %1
; CHECK:   return %2
; CHECK: }
; CHECK: }

; Function Attrs: noinline ssp uwtable
define void @_Z3runP1A(%class.A*) #2 !dbg !25 {
  call void @llvm.dbg.value(metadata %class.A* %0, metadata !43, metadata !DIExpression()), !dbg !44
  %2 = bitcast %class.A* %0 to void (%class.A*, i32)***, !dbg !45
  %3 = load void (%class.A*, i32)**, void (%class.A*, i32)*** %2, align 8, !dbg !45
  %4 = getelementptr inbounds void (%class.A*, i32)*, void (%class.A*, i32)** %3, i64 0, !dbg !45
  %5 = load void (%class.A*, i32)*, void (%class.A*, i32)** %4, align 8, !dbg !45
  call void %5(%class.A* %0, i32 12), !dbg !45
  %6 = bitcast %class.A* %0 to i32 (%class.A*)***, !dbg !46
  %7 = load i32 (%class.A*)**, i32 (%class.A*)*** %6, align 8, !dbg !46
  %8 = getelementptr inbounds i32 (%class.A*)*, i32 (%class.A*)** %7, i64 1, !dbg !46
  %9 = load i32 (%class.A*)*, i32 (%class.A*)** %8, align 8, !dbg !46
  %10 = call i32 %9(%class.A* %0), !dbg !46
  call void @llvm.dbg.value(metadata i32 %10, metadata !47, metadata !DIExpression()), !dbg !48
  call void @_Z1hi(i32 14), !dbg !49
  %11 = call i32 @_Z2hhi(i32 15), !dbg !50
  call void @llvm.dbg.value(metadata i32 %11, metadata !47, metadata !DIExpression()), !dbg !48
  ret void, !dbg !51
}
; CHECK: define void @_Z3runP1A({0: si32 (...)**}* %1) {
; CHECK: #1 !entry !exit {
; CHECK:   void ({0: si32 (...)**}*, si32)*** %2 = bitcast %1
; CHECK:   void ({0: si32 (...)**}*, si32)** %3 = load %2, align 8
; CHECK:   void ({0: si32 (...)**}*, si32)** %4 = ptrshift %3, 8 * 0
; CHECK:   void ({0: si32 (...)**}*, si32)* %5 = load %4, align 8
; CHECK:   call %5(%1, 12)
; CHECK:   si32 ({0: si32 (...)**}*)*** %6 = bitcast %1
; CHECK:   si32 ({0: si32 (...)**}*)** %7 = load %6, align 8
; CHECK:   si32 ({0: si32 (...)**}*)** %8 = ptrshift %7, 8 * 1
; CHECK:   si32 ({0: si32 (...)**}*)* %9 = load %8, align 8
; CHECK:   si32 %10 = call %9(%1)
; CHECK:   call @_Z1hi(14)
; CHECK:   si32 %11 = call @_Z2hhi(15)
; CHECK:   return
; CHECK: }
; CHECK: }

; Function Attrs: noinline nounwind ssp uwtable
define linkonce_odr void @_ZN1A1fEi(%class.A*, i32) unnamed_addr #0 align 2 !dbg !125 {
  call void @llvm.dbg.value(metadata %class.A* %0, metadata !126, metadata !DIExpression()), !dbg !127
  call void @llvm.dbg.value(metadata i32 %1, metadata !128, metadata !DIExpression()), !dbg !129
  ret void, !dbg !130
}
; CHECK: define void @_ZN1A1fEi({0: si32 (...)**}* %1, si32 %2) {
; CHECK: #1 !entry !exit {
; CHECK:   return
; CHECK: }
; CHECK: }

; Function Attrs: noinline nounwind ssp uwtable
define linkonce_odr i32 @_ZN1A1gEv(%class.A*) unnamed_addr #0 align 2 !dbg !131 {
  call void @llvm.dbg.value(metadata %class.A* %0, metadata !132, metadata !DIExpression()), !dbg !133
  ret i32 0, !dbg !134
}
; CHECK: define si32 @_ZN1A1gEv({0: si32 (...)**}* %1) {
; CHECK: #1 !entry !exit {
; CHECK:   return 0
; CHECK: }
; CHECK: }

; Function Attrs: noinline nounwind ssp uwtable
define linkonce_odr void @_ZN1AC2Ev(%class.A*) unnamed_addr #0 align 2 !dbg !107 {
  call void @llvm.dbg.value(metadata %class.A* %0, metadata !111, metadata !DIExpression()), !dbg !112
  %2 = bitcast %class.A* %0 to i32 (...)***, !dbg !113
  %3 = getelementptr inbounds { [4 x i8*] }, { [4 x i8*] }* @_ZTV1A, i32 0, i32 0, i32 2, !dbg !113
  %4 = bitcast i8** %3 to i32 (...)**, !dbg !113
  store i32 (...)** %4, i32 (...)*** %2, align 8, !dbg !113
  ret void, !dbg !113
}
; CHECK: define void @_ZN1AC2Ev({0: si32 (...)**}* %1) {
; CHECK: #1 !entry !exit {
; CHECK:   si32 (...)*** %2 = bitcast %1
; CHECK:   si8** %3 = ptrshift @_ZTV1A, 32 * 0, 1 * 0, 8 * 2
; CHECK:   si32 (...)** %4 = bitcast %3
; CHECK:   store %2, %4, align 8
; CHECK:   return
; CHECK: }
; CHECK: }

; Function Attrs: noinline nounwind ssp uwtable
define linkonce_odr void @_ZN1B1fEi(%class.B*, i32) unnamed_addr #0 align 2 !dbg !114 {
  call void @llvm.dbg.value(metadata %class.B* %0, metadata !115, metadata !DIExpression()), !dbg !116
  call void @llvm.dbg.value(metadata i32 %1, metadata !117, metadata !DIExpression()), !dbg !118
  store i32 %1, i32* @G, align 4, !dbg !119
  ret void, !dbg !120
}
; CHECK: define void @_ZN1B1fEi({0: {0: si32 (...)**}}* %1, si32 %2) {
; CHECK: #1 !entry !exit {
; CHECK:   store @G, %2, align 4
; CHECK:   return
; CHECK: }
; CHECK: }

; Function Attrs: noinline nounwind ssp uwtable
define linkonce_odr i32 @_ZN1B1gEv(%class.B*) unnamed_addr #0 align 2 !dbg !121 {
  call void @llvm.dbg.value(metadata %class.B* %0, metadata !122, metadata !DIExpression()), !dbg !123
  ret i32 0, !dbg !124
}
; CHECK: define si32 @_ZN1B1gEv({0: {0: si32 (...)**}}* %1) {
; CHECK: #1 !entry !exit {
; CHECK:   return 0
; CHECK: }
; CHECK: }

; Function Attrs: noinline nounwind ssp uwtable
define linkonce_odr void @_ZN1BC1Ev(%class.B*) unnamed_addr #0 align 2 !dbg !87 {
  call void @llvm.dbg.value(metadata %class.B* %0, metadata !91, metadata !DIExpression()), !dbg !93
  call void @_ZN1BC2Ev(%class.B* %0) #5, !dbg !94
  ret void, !dbg !94
}
; CHECK: define void @_ZN1BC1Ev({0: {0: si32 (...)**}}* %1) {
; CHECK: #1 !entry !exit {
; CHECK:   call @_ZN1BC2Ev(%1)
; CHECK:   return
; CHECK: }
; CHECK: }

; Function Attrs: noinline nounwind ssp uwtable
define linkonce_odr void @_ZN1BC2Ev(%class.B*) unnamed_addr #0 align 2 !dbg !103 {
  call void @llvm.dbg.value(metadata %class.B* %0, metadata !104, metadata !DIExpression()), !dbg !105
  %2 = bitcast %class.B* %0 to %class.A*, !dbg !106
  call void @_ZN1AC2Ev(%class.A* %2) #5, !dbg !106
  %3 = bitcast %class.B* %0 to i32 (...)***, !dbg !106
  %4 = getelementptr inbounds { [4 x i8*] }, { [4 x i8*] }* @_ZTV1B, i32 0, i32 0, i32 2, !dbg !106
  %5 = bitcast i8** %4 to i32 (...)**, !dbg !106
  store i32 (...)** %5, i32 (...)*** %3, align 8, !dbg !106
  ret void, !dbg !106
}
; CHECK: define void @_ZN1BC2Ev({0: {0: si32 (...)**}}* %1) {
; CHECK: #1 !entry !exit {
; CHECK:   {0: si32 (...)**}* %2 = bitcast %1
; CHECK:   call @_ZN1AC2Ev(%2)
; CHECK:   si32 (...)*** %3 = bitcast %1
; CHECK:   si8** %4 = ptrshift @_ZTV1B, 32 * 0, 1 * 0, 8 * 2
; CHECK:   si32 (...)** %5 = bitcast %4
; CHECK:   store %3, %5, align 8
; CHECK:   return
; CHECK: }
; CHECK: }

; Function Attrs: noinline nounwind ssp uwtable
define linkonce_odr void @_ZN1C1fEi(%class.C*, i32) unnamed_addr #0 align 2 !dbg !139 {
  call void @llvm.dbg.value(metadata %class.C* %0, metadata !140, metadata !DIExpression()), !dbg !141
  call void @llvm.dbg.value(metadata i32 %1, metadata !142, metadata !DIExpression()), !dbg !143
  %3 = sub nsw i32 0, %1, !dbg !144
  store i32 %3, i32* @G, align 4, !dbg !145
  ret void, !dbg !146
}
; CHECK: define void @_ZN1C1fEi({0: {0: {0: si32 (...)**}}}* %1, si32 %2) {
; CHECK: #1 !entry !exit {
; CHECK:   si32 %3 = 0 ssub.nw %2
; CHECK:   store @G, %3, align 4
; CHECK:   return
; CHECK: }
; CHECK: }

; Function Attrs: noinline nounwind ssp uwtable
define linkonce_odr i32 @_ZN1C1gEv(%class.C*) unnamed_addr #0 align 2 !dbg !147 {
  call void @llvm.dbg.value(metadata %class.C* %0, metadata !148, metadata !DIExpression()), !dbg !149
  ret i32 1, !dbg !150
}
; CHECK: define si32 @_ZN1C1gEv({0: {0: {0: si32 (...)**}}}* %1) {
; CHECK: #1 !entry !exit {
; CHECK:   return 1
; CHECK: }
; CHECK: }

; Function Attrs: noinline nounwind ssp uwtable
define linkonce_odr void @_ZN1CC1Ev(%class.C*) unnamed_addr #0 align 2 !dbg !95 {
  call void @llvm.dbg.value(metadata %class.C* %0, metadata !99, metadata !DIExpression()), !dbg !101
  call void @_ZN1CC2Ev(%class.C* %0) #5, !dbg !102
  ret void, !dbg !102
}
; CHECK: define void @_ZN1CC1Ev({0: {0: {0: si32 (...)**}}}* %1) {
; CHECK: #1 !entry !exit {
; CHECK:   call @_ZN1CC2Ev(%1)
; CHECK:   return
; CHECK: }
; CHECK: }

; Function Attrs: noinline nounwind ssp uwtable
define linkonce_odr void @_ZN1CC2Ev(%class.C*) unnamed_addr #0 align 2 !dbg !135 {
  call void @llvm.dbg.value(metadata %class.C* %0, metadata !136, metadata !DIExpression()), !dbg !137
  %2 = bitcast %class.C* %0 to %class.B*, !dbg !138
  call void @_ZN1BC2Ev(%class.B* %2) #5, !dbg !138
  %3 = bitcast %class.C* %0 to i32 (...)***, !dbg !138
  %4 = getelementptr inbounds { [4 x i8*] }, { [4 x i8*] }* @_ZTV1C, i32 0, i32 0, i32 2, !dbg !138
  %5 = bitcast i8** %4 to i32 (...)**, !dbg !138
  store i32 (...)** %5, i32 (...)*** %3, align 8, !dbg !138
  ret void, !dbg !138
}
; CHECK: define void @_ZN1CC2Ev({0: {0: {0: si32 (...)**}}}* %1) {
; CHECK: #1 !entry !exit {
; CHECK:   {0: {0: si32 (...)**}}* %2 = bitcast %1
; CHECK:   call @_ZN1BC2Ev(%2)
; CHECK:   si32 (...)*** %3 = bitcast %1
; CHECK:   si8** %4 = ptrshift @_ZTV1C, 32 * 0, 1 * 0, 8 * 2
; CHECK:   si32 (...)** %5 = bitcast %4
; CHECK:   store %3, %5, align 8
; CHECK:   return
; CHECK: }
; CHECK: }

declare i32 @__gxx_personality_v0(...)
; CHECK: declare si32 @__gxx_personality_v0(...)

; Function Attrs: nounwind readnone
declare i32 @llvm.eh.typeid.for(i8*) #4
; CHECK: declare si32 @ar.eh.typeid.for(si8*)

declare i8* @__cxa_begin_catch(i8*)
; CHECK: declare si8* @ar.libcpp.begincatch(si8*)

declare void @__cxa_end_catch()
; CHECK: declare void @ar.libcpp.endcatch()

; Function Attrs: noinline norecurse ssp uwtable
define i32 @main() #3 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) !dbg !52 {
  %1 = alloca %class.B, align 8
  %2 = alloca %class.C, align 8
  call void @llvm.dbg.declare(metadata %class.B* %1, metadata !53, metadata !DIExpression()), !dbg !64
  call void @_ZN1BC1Ev(%class.B* %1) #5, !dbg !64
  call void @llvm.dbg.declare(metadata %class.C* %2, metadata !65, metadata !DIExpression()), !dbg !76
  call void @_ZN1CC1Ev(%class.C* %2) #5, !dbg !76
  %3 = bitcast %class.B* %1 to %class.A*, !dbg !77
  invoke void @_Z3runP1A(%class.A* %3)
          to label %4 unwind label %7, !dbg !79

; <label>:4:                                      ; preds = %0
  %5 = bitcast %class.C* %2 to %class.A*, !dbg !80
  invoke void @_Z3runP1A(%class.A* %5)
          to label %6 unwind label %7, !dbg !81

; <label>:6:                                      ; preds = %4
  br label %17, !dbg !82

; <label>:7:                                      ; preds = %4, %0
  %8 = landingpad { i8*, i32 }
          catch i8* bitcast ({ i8*, i8* }* @_ZTI1A to i8*), !dbg !83
  %9 = extractvalue { i8*, i32 } %8, 0, !dbg !83
  %10 = extractvalue { i8*, i32 } %8, 1, !dbg !83
  br label %11, !dbg !83

; <label>:11:                                     ; preds = %7
  %12 = bitcast { i8*, i8* }* @_ZTI1A to i8*, !dbg !82
  %13 = call i32 @llvm.eh.typeid.for(i8* %12) #5, !dbg !82
  %14 = icmp eq i32 %10, %13, !dbg !82
  br i1 %14, label %15, label %18, !dbg !82

; <label>:15:                                     ; preds = %11
  %16 = call i8* @__cxa_begin_catch(i8* %9) #5, !dbg !82
  call void @__cxa_end_catch(), !dbg !84
  br label %17, !dbg !84

; <label>:17:                                     ; preds = %15, %6
  ret i32 0, !dbg !86

; <label>:18:                                     ; preds = %11
  %19 = insertvalue { i8*, i32 } undef, i8* %9, 0, !dbg !82
  %20 = insertvalue { i8*, i32 } %19, i32 %10, 1, !dbg !82
  resume { i8*, i32 } %20, !dbg !82
}
; CHECK: define si32 @main() {
; CHECK: #1 !entry successors={#2, #3} {
; CHECK:   {0: {0: si32 (...)**}}* $1 = allocate {0: {0: si32 (...)**}}, 1, align 8
; CHECK:   {0: {0: {0: si32 (...)**}}}* $2 = allocate {0: {0: {0: si32 (...)**}}}, 1, align 8
; CHECK:   call @_ZN1BC1Ev($1)
; CHECK:   call @_ZN1CC1Ev($2)
; CHECK:   {0: si32 (...)**}* %3 = bitcast $1
; CHECK:   invoke @_Z3runP1A(%3) normal=#2 exc=#3
; CHECK: }
; CHECK: #2 predecessors={#1} successors={#4, #5} {
; CHECK:   {0: si32 (...)**}* %4 = bitcast $2
; CHECK:   invoke @_Z3runP1A(%4) normal=#4 exc=#5
; CHECK: }
; CHECK: #3 predecessors={#1} successors={#6} {
; CHECK: }
; CHECK: #4 predecessors={#2} successors={#7} {
; CHECK: }
; CHECK: #5 predecessors={#2} successors={#6} {
; CHECK: }
; CHECK: #6 predecessors={#3, #5} successors={#8, #9} {
; CHECK:   {0: si8*, 8: si32} %5 = landingpad
; CHECK:   si8* %6 = extractelement %5, 0
; CHECK:   si32 %7 = extractelement %5, 8
; CHECK:   si8* %8 = bitcast @_ZTI1A
; CHECK:   si32 %9 = call @ar.eh.typeid.for(%8)
; CHECK: }
; CHECK: #8 predecessors={#6} successors={#7} {
; CHECK:   %7 sieq %9
; CHECK:   si8* %10 = call @ar.libcpp.begincatch(%6)
; CHECK:   call @ar.libcpp.endcatch()
; CHECK: }
; CHECK: #9 !ehresume predecessors={#6} {
; CHECK:   %7 sine %9
; CHECK:   {0: si8*, 8: si32} %11 = insertelement undef, 0, %6
; CHECK:   {0: si8*, 8: si32} %12 = insertelement %11, 8, %7
; CHECK:   resume %12
; CHECK: }
; CHECK: #7 !exit predecessors={#4, #8} {
; CHECK:   return 0
; CHECK: }
; CHECK: }

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.value(metadata, metadata, metadata) #1

attributes #0 = { noinline nounwind ssp uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { noinline ssp uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { noinline norecurse ssp uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind readnone }
attributes #5 = { nounwind }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!7, !8, !9, !10}
!llvm.ident = !{!11}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "G", scope: !2, file: !3, line: 1, type: !6, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus, file: !3, producer: "clang version 6.0.1 (tags/RELEASE_601/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, globals: !5)
!3 = !DIFile(filename: "try-catch.cpp", directory: "/Users/marthaud/ikos/ikos-git/frontend/llvm/test/regression/import/basic_optimization")
!4 = !{}
!5 = !{!0}
!6 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!7 = !{i32 2, !"Dwarf Version", i32 4}
!8 = !{i32 2, !"Debug Info Version", i32 3}
!9 = !{i32 1, !"wchar_size", i32 4}
!10 = !{i32 7, !"PIC Level", i32 2}
!11 = !{!"clang version 6.0.1 (tags/RELEASE_601/final)"}
!12 = distinct !DISubprogram(name: "h", linkageName: "_Z1hi", scope: !3, file: !3, line: 21, type: !13, isLocal: false, isDefinition: true, scopeLine: 21, flags: DIFlagPrototyped, isOptimized: false, unit: !2, variables: !4)
!13 = !DISubroutineType(types: !14)
!14 = !{null, !6}
!15 = !DILocalVariable(name: "x", arg: 1, scope: !12, file: !3, line: 21, type: !6)
!16 = !DILocation(line: 21, column: 12, scope: !12)
!17 = !DILocation(line: 21, column: 16, scope: !12)
!18 = distinct !DISubprogram(name: "hh", linkageName: "_Z2hhi", scope: !3, file: !3, line: 23, type: !19, isLocal: false, isDefinition: true, scopeLine: 23, flags: DIFlagPrototyped, isOptimized: false, unit: !2, variables: !4)
!19 = !DISubroutineType(types: !20)
!20 = !{!6, !6}
!21 = !DILocalVariable(name: "x", arg: 1, scope: !18, file: !3, line: 23, type: !6)
!22 = !DILocation(line: 23, column: 12, scope: !18)
!23 = !DILocation(line: 24, column: 12, scope: !18)
!24 = !DILocation(line: 24, column: 3, scope: !18)
!25 = distinct !DISubprogram(name: "run", linkageName: "_Z3runP1A", scope: !3, file: !3, line: 27, type: !26, isLocal: false, isDefinition: true, scopeLine: 27, flags: DIFlagPrototyped, isOptimized: false, unit: !2, variables: !4)
!26 = !DISubroutineType(types: !27)
!27 = !{null, !28}
!28 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !29, size: 64)
!29 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "A", file: !3, line: 3, size: 64, elements: !30, vtableHolder: !29, identifier: "_ZTS1A")
!30 = !{!31, !36, !40}
!31 = !DIDerivedType(tag: DW_TAG_member, name: "_vptr$A", scope: !3, file: !3, baseType: !32, size: 64, flags: DIFlagArtificial)
!32 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !33, size: 64)
!33 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "__vtbl_ptr_type", baseType: !34, size: 64)
!34 = !DISubroutineType(types: !35)
!35 = !{!6}
!36 = !DISubprogram(name: "f", linkageName: "_ZN1A1fEi", scope: !29, file: !3, line: 5, type: !37, isLocal: false, isDefinition: false, scopeLine: 5, containingType: !29, virtuality: DW_VIRTUALITY_virtual, virtualIndex: 0, flags: DIFlagPublic | DIFlagPrototyped, isOptimized: false)
!37 = !DISubroutineType(types: !38)
!38 = !{null, !39, !6}
!39 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !29, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!40 = !DISubprogram(name: "g", linkageName: "_ZN1A1gEv", scope: !29, file: !3, line: 6, type: !41, isLocal: false, isDefinition: false, scopeLine: 6, containingType: !29, virtuality: DW_VIRTUALITY_virtual, virtualIndex: 1, flags: DIFlagPublic | DIFlagPrototyped, isOptimized: false)
!41 = !DISubroutineType(types: !42)
!42 = !{!6, !39}
!43 = !DILocalVariable(name: "p", arg: 1, scope: !25, file: !3, line: 27, type: !28)
!44 = !DILocation(line: 27, column: 13, scope: !25)
!45 = !DILocation(line: 29, column: 6, scope: !25)
!46 = !DILocation(line: 30, column: 10, scope: !25)
!47 = !DILocalVariable(name: "x", scope: !25, file: !3, line: 28, type: !6)
!48 = !DILocation(line: 28, column: 7, scope: !25)
!49 = !DILocation(line: 31, column: 3, scope: !25)
!50 = !DILocation(line: 32, column: 7, scope: !25)
!51 = !DILocation(line: 33, column: 1, scope: !25)
!52 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 35, type: !34, isLocal: false, isDefinition: true, scopeLine: 35, flags: DIFlagPrototyped, isOptimized: false, unit: !2, variables: !4)
!53 = !DILocalVariable(name: "b", scope: !52, file: !3, line: 36, type: !54)
!54 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "B", file: !3, line: 9, size: 64, elements: !55, vtableHolder: !29, identifier: "_ZTS1B")
!55 = !{!56, !57, !61}
!56 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !54, baseType: !29, flags: DIFlagPublic)
!57 = !DISubprogram(name: "f", linkageName: "_ZN1B1fEi", scope: !54, file: !3, line: 11, type: !58, isLocal: false, isDefinition: false, scopeLine: 11, containingType: !54, virtuality: DW_VIRTUALITY_virtual, virtualIndex: 0, flags: DIFlagPublic | DIFlagPrototyped, isOptimized: false)
!58 = !DISubroutineType(types: !59)
!59 = !{null, !60, !6}
!60 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !54, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!61 = !DISubprogram(name: "g", linkageName: "_ZN1B1gEv", scope: !54, file: !3, line: 12, type: !62, isLocal: false, isDefinition: false, scopeLine: 12, containingType: !54, virtuality: DW_VIRTUALITY_virtual, virtualIndex: 1, flags: DIFlagPublic | DIFlagPrototyped, isOptimized: false)
!62 = !DISubroutineType(types: !63)
!63 = !{!6, !60}
!64 = !DILocation(line: 36, column: 5, scope: !52)
!65 = !DILocalVariable(name: "c", scope: !52, file: !3, line: 37, type: !66)
!66 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "C", file: !3, line: 15, size: 64, elements: !67, vtableHolder: !29, identifier: "_ZTS1C")
!67 = !{!68, !69, !73}
!68 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !66, baseType: !54, flags: DIFlagPublic)
!69 = !DISubprogram(name: "f", linkageName: "_ZN1C1fEi", scope: !66, file: !3, line: 17, type: !70, isLocal: false, isDefinition: false, scopeLine: 17, containingType: !66, virtuality: DW_VIRTUALITY_virtual, virtualIndex: 0, flags: DIFlagPublic | DIFlagPrototyped, isOptimized: false)
!70 = !DISubroutineType(types: !71)
!71 = !{null, !72, !6}
!72 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !66, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!73 = !DISubprogram(name: "g", linkageName: "_ZN1C1gEv", scope: !66, file: !3, line: 18, type: !74, isLocal: false, isDefinition: false, scopeLine: 18, containingType: !66, virtuality: DW_VIRTUALITY_virtual, virtualIndex: 1, flags: DIFlagPublic | DIFlagPrototyped, isOptimized: false)
!74 = !DISubroutineType(types: !75)
!75 = !{!6, !72}
!76 = !DILocation(line: 37, column: 5, scope: !52)
!77 = !DILocation(line: 39, column: 9, scope: !78)
!78 = distinct !DILexicalBlock(scope: !52, file: !3, line: 38, column: 7)
!79 = !DILocation(line: 39, column: 5, scope: !78)
!80 = !DILocation(line: 40, column: 9, scope: !78)
!81 = !DILocation(line: 40, column: 5, scope: !78)
!82 = !DILocation(line: 41, column: 3, scope: !78)
!83 = !DILocation(line: 44, column: 1, scope: !78)
!84 = !DILocation(line: 42, column: 3, scope: !85)
!85 = distinct !DILexicalBlock(scope: !52, file: !3, line: 41, column: 18)
!86 = !DILocation(line: 43, column: 3, scope: !52)
!87 = distinct !DISubprogram(name: "B", linkageName: "_ZN1BC1Ev", scope: !54, file: !3, line: 9, type: !88, isLocal: false, isDefinition: true, scopeLine: 9, flags: DIFlagArtificial | DIFlagPrototyped, isOptimized: false, unit: !2, declaration: !90, variables: !4)
!88 = !DISubroutineType(types: !89)
!89 = !{null, !60}
!90 = !DISubprogram(name: "B", scope: !54, type: !88, isLocal: false, isDefinition: false, flags: DIFlagPublic | DIFlagArtificial | DIFlagPrototyped, isOptimized: false)
!91 = !DILocalVariable(name: "this", arg: 1, scope: !87, type: !92, flags: DIFlagArtificial | DIFlagObjectPointer)
!92 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !54, size: 64)
!93 = !DILocation(line: 0, scope: !87)
!94 = !DILocation(line: 9, column: 7, scope: !87)
!95 = distinct !DISubprogram(name: "C", linkageName: "_ZN1CC1Ev", scope: !66, file: !3, line: 15, type: !96, isLocal: false, isDefinition: true, scopeLine: 15, flags: DIFlagArtificial | DIFlagPrototyped, isOptimized: false, unit: !2, declaration: !98, variables: !4)
!96 = !DISubroutineType(types: !97)
!97 = !{null, !72}
!98 = !DISubprogram(name: "C", scope: !66, type: !96, isLocal: false, isDefinition: false, flags: DIFlagPublic | DIFlagArtificial | DIFlagPrototyped, isOptimized: false)
!99 = !DILocalVariable(name: "this", arg: 1, scope: !95, type: !100, flags: DIFlagArtificial | DIFlagObjectPointer)
!100 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !66, size: 64)
!101 = !DILocation(line: 0, scope: !95)
!102 = !DILocation(line: 15, column: 7, scope: !95)
!103 = distinct !DISubprogram(name: "B", linkageName: "_ZN1BC2Ev", scope: !54, file: !3, line: 9, type: !88, isLocal: false, isDefinition: true, scopeLine: 9, flags: DIFlagArtificial | DIFlagPrototyped, isOptimized: false, unit: !2, declaration: !90, variables: !4)
!104 = !DILocalVariable(name: "this", arg: 1, scope: !103, type: !92, flags: DIFlagArtificial | DIFlagObjectPointer)
!105 = !DILocation(line: 0, scope: !103)
!106 = !DILocation(line: 9, column: 7, scope: !103)
!107 = distinct !DISubprogram(name: "A", linkageName: "_ZN1AC2Ev", scope: !29, file: !3, line: 3, type: !108, isLocal: false, isDefinition: true, scopeLine: 3, flags: DIFlagArtificial | DIFlagPrototyped, isOptimized: false, unit: !2, declaration: !110, variables: !4)
!108 = !DISubroutineType(types: !109)
!109 = !{null, !39}
!110 = !DISubprogram(name: "A", scope: !29, type: !108, isLocal: false, isDefinition: false, flags: DIFlagPublic | DIFlagArtificial | DIFlagPrototyped, isOptimized: false)
!111 = !DILocalVariable(name: "this", arg: 1, scope: !107, type: !28, flags: DIFlagArtificial | DIFlagObjectPointer)
!112 = !DILocation(line: 0, scope: !107)
!113 = !DILocation(line: 3, column: 7, scope: !107)
!114 = distinct !DISubprogram(name: "f", linkageName: "_ZN1B1fEi", scope: !54, file: !3, line: 11, type: !58, isLocal: false, isDefinition: true, scopeLine: 11, flags: DIFlagPrototyped, isOptimized: false, unit: !2, declaration: !57, variables: !4)
!115 = !DILocalVariable(name: "this", arg: 1, scope: !114, type: !92, flags: DIFlagArtificial | DIFlagObjectPointer)
!116 = !DILocation(line: 0, scope: !114)
!117 = !DILocalVariable(name: "x", arg: 2, scope: !114, file: !3, line: 11, type: !6)
!118 = !DILocation(line: 11, column: 22, scope: !114)
!119 = !DILocation(line: 11, column: 29, scope: !114)
!120 = !DILocation(line: 11, column: 34, scope: !114)
!121 = distinct !DISubprogram(name: "g", linkageName: "_ZN1B1gEv", scope: !54, file: !3, line: 12, type: !62, isLocal: false, isDefinition: true, scopeLine: 12, flags: DIFlagPrototyped, isOptimized: false, unit: !2, declaration: !61, variables: !4)
!122 = !DILocalVariable(name: "this", arg: 1, scope: !121, type: !92, flags: DIFlagArtificial | DIFlagObjectPointer)
!123 = !DILocation(line: 0, scope: !121)
!124 = !DILocation(line: 12, column: 21, scope: !121)
!125 = distinct !DISubprogram(name: "f", linkageName: "_ZN1A1fEi", scope: !29, file: !3, line: 5, type: !37, isLocal: false, isDefinition: true, scopeLine: 5, flags: DIFlagPrototyped, isOptimized: false, unit: !2, declaration: !36, variables: !4)
!126 = !DILocalVariable(name: "this", arg: 1, scope: !125, type: !28, flags: DIFlagArtificial | DIFlagObjectPointer)
!127 = !DILocation(line: 0, scope: !125)
!128 = !DILocalVariable(name: "x", arg: 2, scope: !125, file: !3, line: 5, type: !6)
!129 = !DILocation(line: 5, column: 22, scope: !125)
!130 = !DILocation(line: 5, column: 26, scope: !125)
!131 = distinct !DISubprogram(name: "g", linkageName: "_ZN1A1gEv", scope: !29, file: !3, line: 6, type: !41, isLocal: false, isDefinition: true, scopeLine: 6, flags: DIFlagPrototyped, isOptimized: false, unit: !2, declaration: !40, variables: !4)
!132 = !DILocalVariable(name: "this", arg: 1, scope: !131, type: !28, flags: DIFlagArtificial | DIFlagObjectPointer)
!133 = !DILocation(line: 0, scope: !131)
!134 = !DILocation(line: 6, column: 21, scope: !131)
!135 = distinct !DISubprogram(name: "C", linkageName: "_ZN1CC2Ev", scope: !66, file: !3, line: 15, type: !96, isLocal: false, isDefinition: true, scopeLine: 15, flags: DIFlagArtificial | DIFlagPrototyped, isOptimized: false, unit: !2, declaration: !98, variables: !4)
!136 = !DILocalVariable(name: "this", arg: 1, scope: !135, type: !100, flags: DIFlagArtificial | DIFlagObjectPointer)
!137 = !DILocation(line: 0, scope: !135)
!138 = !DILocation(line: 15, column: 7, scope: !135)
!139 = distinct !DISubprogram(name: "f", linkageName: "_ZN1C1fEi", scope: !66, file: !3, line: 17, type: !70, isLocal: false, isDefinition: true, scopeLine: 17, flags: DIFlagPrototyped, isOptimized: false, unit: !2, declaration: !69, variables: !4)
!140 = !DILocalVariable(name: "this", arg: 1, scope: !139, type: !100, flags: DIFlagArtificial | DIFlagObjectPointer)
!141 = !DILocation(line: 0, scope: !139)
!142 = !DILocalVariable(name: "x", arg: 2, scope: !139, file: !3, line: 17, type: !6)
!143 = !DILocation(line: 17, column: 22, scope: !139)
!144 = !DILocation(line: 17, column: 31, scope: !139)
!145 = !DILocation(line: 17, column: 29, scope: !139)
!146 = !DILocation(line: 17, column: 35, scope: !139)
!147 = distinct !DISubprogram(name: "g", linkageName: "_ZN1C1gEv", scope: !66, file: !3, line: 18, type: !74, isLocal: false, isDefinition: true, scopeLine: 18, flags: DIFlagPrototyped, isOptimized: false, unit: !2, declaration: !73, variables: !4)
!148 = !DILocalVariable(name: "this", arg: 1, scope: !147, type: !100, flags: DIFlagArtificial | DIFlagObjectPointer)
!149 = !DILocation(line: 0, scope: !147)
!150 = !DILocation(line: 18, column: 21, scope: !147)
