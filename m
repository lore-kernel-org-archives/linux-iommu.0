Return-Path: <SRS0=kAxJ=B4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED2EC433DF
	for <iommu@archiver.kernel.org>; Tue, 18 Aug 2020 07:51:06 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6BEA2067C
	for <iommu@archiver.kernel.org>; Tue, 18 Aug 2020 07:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Oz+SgBPA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6BEA2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id C1B1987592;
	Tue, 18 Aug 2020 07:51:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aZzYN7QhRQPZ; Tue, 18 Aug 2020 07:51:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0DED18737E;
	Tue, 18 Aug 2020 07:51:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 06A27C07FF;
	Tue, 18 Aug 2020 07:51:05 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CA66DC0051
 for <iommu@lists.linux-foundation.org>; Tue, 18 Aug 2020 07:51:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 6347520365
 for <iommu@lists.linux-foundation.org>; Tue, 18 Aug 2020 07:51:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id k3NYYtelIQXA for <iommu@lists.linux-foundation.org>;
 Tue, 18 Aug 2020 07:50:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
 by silver.osuosl.org (Postfix) with ESMTPS id 7347220107
 for <iommu@lists.linux-foundation.org>; Tue, 18 Aug 2020 07:50:58 +0000 (UTC)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20200818075055epoutp026dad7fd28c18da5b93ad10ae1fa4d34a~sTWMgpGxN2900329003epoutp02i
 for <iommu@lists.linux-foundation.org>; Tue, 18 Aug 2020 07:50:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20200818075055epoutp026dad7fd28c18da5b93ad10ae1fa4d34a~sTWMgpGxN2900329003epoutp02i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1597737055;
 bh=NwOlS5cnBe1k4GJDW5Zv0HRcItTMtAfl5az4Un8KkCs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Oz+SgBPAdERFLHiA9ZsNCB1Msc7eDbYKaAx/JWym7tT7kuTAweDDbYEekpM+MEXMP
 8zyglECU4MFLlIbx8TcikAnYJs4K9lrkXRTdXYuLC9E9/GKIPNJRJdEVqxcx4Mk9IE
 cCp3MvuzKkE/yOXxDG0tHR018OauIglgMyUF7mA8=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas2p4.samsung.com (KnoxPortal) with ESMTP id
 20200818075055epcas2p435ef9a85a1e2f0dffe39d1c35136281e~sTWMA3WGs0451104511epcas2p4Y;
 Tue, 18 Aug 2020 07:50:55 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.40.186]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4BW34X0WfFzMqYkq; Tue, 18 Aug
 2020 07:50:52 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
 epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
 BE.30.27441.B588B3F5; Tue, 18 Aug 2020 16:50:52 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
 20200818075051epcas2p316edad6edd3df59444c08d392b075ea8~sTWIO-GKy2931529315epcas2p35;
 Tue, 18 Aug 2020 07:50:51 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20200818075050epsmtrp2e2eff35d365f0d3d2457bd13553c58d7~sTWHsNWs40185501855epsmtrp2B;
 Tue, 18 Aug 2020 07:50:50 +0000 (GMT)
X-AuditID: b6c32a47-fafff70000006b31-83-5f3b885b8fa4
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
 97.09.08303.A588B3F5; Tue, 18 Aug 2020 16:50:50 +0900 (KST)
Received: from KEI.dsn.sec.samsung.com (unknown [12.36.155.227]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200818075050epsmtip13728894ac95b41ac3557af485c3cde3d~sTWHbvejq2278422784epsmtip1r;
 Tue, 18 Aug 2020 07:50:50 +0000 (GMT)
From: Cho KyongHo <pullip.cho@samsung.com>
To: joro@8bytes.org, catalin.marinas@arm.com, will@kernel.org
Subject: [PATCH 2/2] arm64: dma-mapping: add relaxed DMA sync
Date: Tue, 18 Aug 2020 16:43:11 +0900
Message-Id: <1597736591-20457-2-git-send-email-pullip.cho@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597736591-20457-1-git-send-email-pullip.cho@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKKsWRmVeSWpSXmKPExsWy7bCmmW5Mh3W8wbtEi/fLehgt/nZeYLVY
 sN/aYvOcYovO2RvYLTY9vsZqcXnXHDaLtUfuslv86z3IaHHwwxNWi5Y7pg7cHk8OzmPyWDNv
 DaPHplWdbB6bl9R7TL6xnNGjb8sqRo/Pm+QC2KNybDJSE1NSixRS85LzUzLz0m2VvIPjneNN
 zQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOA7lNSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2Cql
 FqTkFBgaFugVJ+YWl+al6yXn51oZGhgYmQJVJuRk7Fh4g61gg0XFn9lXWBoYZ+p1MXJySAiY
 SOx7uIGxi5GLQ0hgB6NE648XUM4nRomV3U/ZIZzPjBInjl1lhGlZcm0qG0RiF6PEi6VzoKq+
 MkrcvvGBHaSKTUBLYvXc42AdIgK2Ej+/T2QGKWIW+MYosevHXSaQhDBQ4nL3IqAEBweLgKrE
 6w1cIGFeATeJS1chSiQE5CRunusEK+EUcJdonKAEMkZC4CO7xJuzX9khalwkTnbcg6oXlnh1
 fAtUXEri87u9bBAN0xkl3s0/xAaR2Mwo8W23IIRtLDHrWTsjyAJmAU2J9bv0QUwJAWWJI7dY
 QCqYBfgkOg7/ZYcI80p0tAlBNKpI7Jx6jQVmU9/eG1C2h8S+K1PAPhcSmMUo8X6X/ARGuVkI
 8xcwMq5iFEstKM5NTy02KjBGjrBNjOD0p+W+g3HG2w96hxiZOBgPMUpwMCuJ8CadMI8X4k1J
 rKxKLcqPLyrNSS0+xGgKDLmJzFKiyfnABJxXEm9oamRmZmBpamFqZmShJM5bbHUhTkggPbEk
 NTs1tSC1CKaPiYNTqoHJn+n/NC/1CR+fvYw5GCs81Y9zgnWmzamKw2vEDhnsfeW+S+qKQ/qz
 D4+zN+69IrbG/7L/08m7Olf6lE2o1bC7mJIl+qOA5csFw1Wq/C0vZU63aC8W3NR2X8RcMlR/
 O2OKqHeLrswZBYstCl2HVtUyyX6xW6qj91Jlg3Iyp1LkxNNb2vXebb5YvWmfWuTjm6Iyq1jY
 NW8VPLii9+/epYuHJASnvnt2eMHtz/Y1OsrshVJySikv7deZvFjI8X/qnc9Cza9k//wpuq+T
 ai0p2rE9W+6/07aTnie8WXfPUfnDt9rNvfvx8x2R/Pm9rzn4CnvMVq2dFr0wjMeicPuSg/4+
 V/q3CW85f+zNhpcOd2quKbEUZyQaajEXFScCAPCD1ocIBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPLMWRmVeSWpSXmKPExsWy7bCSnG5Uh3W8wbHl6hbvl/UwWvztvMBq
 sWC/tcXmOcUWnbM3sFtsenyN1eLyrjlsFmuP3GW3+Nd7kNHi4IcnrBYtd0wduD2eHJzH5LFm
 3hpGj02rOtk8Ni+p95h8YzmjR9+WVYwenzfJBbBHcdmkpOZklqUW6dslcGXsWHiDrWCDRcWf
 2VdYGhhn6nUxcnJICJhILLk2la2LkYtDSGAHo8SFlr3MEAkpiXnda5kgbGGJ+y1HWCGKPjNK
 zJ3UzgKSYBPQklg99zhjFyMHh4iAo0TDexOQGmaBf4wSR690gw0SFrCVuNy9iBmkhkVAVeL1
 Bi6QMK+Am8Slq3eh5stJ3DzXCVbCKeAu0ThBCSQsBFQy8dp0pgmMfAsYGVYxSqYWFOem5xYb
 FhjlpZbrFSfmFpfmpesl5+duYgSHqZbWDsY9qz7oHWJk4mA8xCjBwawkwpt0wjxeiDclsbIq
 tSg/vqg0J7X4EKM0B4uSOO/XWQvjhATSE0tSs1NTC1KLYLJMHJxSDUxrYgJ9RDLPPdruU+3z
 kO2YU2ZW45kyt/6sf6untO/N45e8NS1Zkt3HvfHbMo79WZv2h+aH3zy6dWHS9MMO4WJbmy+x
 53zodBP4tN6m02Pz1QXtRTfv9qxnjy1wf23I8D3z0JOl696L9O09MI2BtVHjkXe8oHzbmS+m
 J/7XvzeK3Vc5zfDMRl6/ud8zJjB52xmkvgnxnCJ4cY/Vw1wvVdmZqctSKyKTNKreXEw5nuBu
 z3UkV8RixtpZKZXOCvIKMxYH1Gp9umVzN/x7fN6Kmpcvqx/I3EhjlDVrt2TsX7BvV/GMD3uO
 ZIV+Ljq08Mi3trMTlp1d2xBs/oDdPm6CwcQ/F7e6WzBLyPy5vt92A58SS3FGoqEWc1FxIgDG
 OMHdwgIAAA==
X-CMS-MailID: 20200818075051epcas2p316edad6edd3df59444c08d392b075ea8
X-Msg-Generator: CA
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200818075051epcas2p316edad6edd3df59444c08d392b075ea8
References: <1597736591-20457-1-git-send-email-pullip.cho@samsung.com>
 <CGME20200818075051epcas2p316edad6edd3df59444c08d392b075ea8@epcas2p3.samsung.com>
Cc: janghyuck.kim@samsung.com, linux-kernel@vger.kernel.org,
 hyesoo.yu@samsung.com, iommu@lists.linux-foundation.org,
 Cho KyongHo <pullip.cho@samsung.com>, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

__dma_[un]map_area() is the implementation of cache maintenance
operations for DMA in arm64. 'dsb sy' in the subroutine guarantees the
view of given memory area is consistent to all memory observers. So,
it is required.
However, dma_sync_sg_for_{device|cpu}() and dma_[un]map_sg() calls
__dma_[un]map_area() nents number of times and 'dsb sy' instruction is
executed the same number of times. We have observed that 'dsb sy'
consumes more time than cleaning or invalidating 4KiB area.
arch_sync_dma_for_{device|cpu}_relaxed() and
arch_sync_barrier_for_{device|cpu}() are introduced since commit
6a9356234 ("dma-mapping: introduce relaxed version of dma sync") to
reduce redundant memory barriers in sg versions of DMA sync API.
Implementing relaxed version of DMA sync API will dramatically increase
the performance of dma_sync_sg_for_{device|cpu}().

Signed-off-by: Cho KyongHo <pullip.cho@samsung.com>
---
 arch/arm64/Kconfig                 |  4 ++--
 arch/arm64/include/asm/assembler.h | 33 ++++++++++++++++++++++++++++++++-
 arch/arm64/include/asm/barrier.h   | 13 +++++++++++++
 arch/arm64/mm/cache.S              | 34 +++++++++++-----------------------
 arch/arm64/mm/dma-mapping.c        |  4 ++--
 include/linux/dma-noncoherent.h    |  1 +
 6 files changed, 61 insertions(+), 28 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 6d23283..4fc7ef4 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -31,8 +31,8 @@ config ARM64
 	select ARCH_HAS_SET_MEMORY
 	select ARCH_HAS_STRICT_KERNEL_RWX
 	select ARCH_HAS_STRICT_MODULE_RWX
-	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
-	select ARCH_HAS_SYNC_DMA_FOR_CPU
+	select ARCH_HAS_SYNC_DMA_FOR_DEVICE_RELAXED
+	select ARCH_HAS_SYNC_DMA_FOR_CPU_RELAXED
 	select ARCH_HAS_SYSCALL_WRAPPER
 	select ARCH_HAS_TEARDOWN_DMA_OPS if IOMMU_SUPPORT
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 54d1811..1f87d98 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -345,6 +345,33 @@ alternative_endif
 	.endm
 
 /*
+ * Macro to perform a data cache invalidation for the interval
+ * [kaddr, kaddr + size)
+ *
+ *	kaddr:		starting virtual address of the region
+ *	size:		size of the region
+ *	Corrupts:	kaddr, size, tmp1, tmp2
+ */
+	.macro __dcache_inv_by_line kaddr, size, tmp1, tmp2
+	add	\size, \size, \kaddr
+	dcache_line_size \tmp1, \tmp2
+	sub	\tmp2, \tmp1, #1
+	tst	\size, \tmp2		// end cache line aligned?
+	bic	\size, \size, \tmp2
+	b.eq	9997f
+	dc	civac, \size		// clean & invalidate D / U line
+9997:	tst	\kaddr, \tmp2		// start cache line aligned?
+	bic	\kaddr, \kaddr, \tmp2
+	b.eq	9998f
+	dc	civac, \kaddr		// clean & invalidate D / U line
+	b	9999f
+9998:	dc	ivac, \kaddr		// invalidate D / U line
+9999:	add	\kaddr, \kaddr, \tmp1
+	cmp	\kaddr, \size
+	b.lo	9998b
+	.endm
+
+/*
  * Macro to perform a data cache maintenance for the interval
  * [kaddr, kaddr + size)
  *
@@ -362,7 +389,7 @@ alternative_else
 alternative_endif
 	.endm
 
-	.macro dcache_by_line_op op, domain, kaddr, size, tmp1, tmp2
+	.macro __dcache_by_line_op op, kaddr, size, tmp1, tmp2
 	dcache_line_size \tmp1, \tmp2
 	add	\size, \kaddr, \size
 	sub	\tmp2, \tmp1, #1
@@ -388,6 +415,10 @@ alternative_endif
 	add	\kaddr, \kaddr, \tmp1
 	cmp	\kaddr, \size
 	b.lo	9998b
+	.endm
+
+	.macro dcache_by_line_op op, domain, kaddr, size, tmp1, tmp2
+	__dcache_by_line_op \op, \kaddr, \size, \tmp1, \tmp2
 	dsb	\domain
 	.endm
 
diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
index fb4c275..96bbbf6 100644
--- a/arch/arm64/include/asm/barrier.h
+++ b/arch/arm64/include/asm/barrier.h
@@ -167,6 +167,19 @@ do {									\
 
 #include <asm-generic/barrier.h>
 
+#include <linux/dma-direction.h>
+
+static inline void arch_sync_barrier_for_device(enum dma_data_direction dir)
+{
+	dsb(sy);
+}
+
+static inline void arch_sync_barrier_for_cpu(enum dma_data_direction dir)
+{
+	if (dir == DMA_FROM_DEVICE)
+		dsb(sy);
+}
+
 #endif	/* __ASSEMBLY__ */
 
 #endif	/* __ASM_BARRIER_H */
diff --git a/arch/arm64/mm/cache.S b/arch/arm64/mm/cache.S
index 2d881f3..7180256 100644
--- a/arch/arm64/mm/cache.S
+++ b/arch/arm64/mm/cache.S
@@ -138,34 +138,20 @@ SYM_FUNC_END(__clean_dcache_area_pou)
  *	- kaddr   - kernel address
  *	- size    - size in question
  */
-SYM_FUNC_START_LOCAL(__dma_inv_area)
 SYM_FUNC_START_PI(__inval_dcache_area)
-	/* FALLTHROUGH */
+	__dcache_inv_by_line x0, x1, x2, x3
+	dsb	sy
+	ret
+SYM_FUNC_END_PI(__inval_dcache_area)
 
 /*
  *	__dma_inv_area(start, size)
  *	- start   - virtual start address of region
  *	- size    - size in question
  */
-	add	x1, x1, x0
-	dcache_line_size x2, x3
-	sub	x3, x2, #1
-	tst	x1, x3				// end cache line aligned?
-	bic	x1, x1, x3
-	b.eq	1f
-	dc	civac, x1			// clean & invalidate D / U line
-1:	tst	x0, x3				// start cache line aligned?
-	bic	x0, x0, x3
-	b.eq	2f
-	dc	civac, x0			// clean & invalidate D / U line
-	b	3f
-2:	dc	ivac, x0			// invalidate D / U line
-3:	add	x0, x0, x2
-	cmp	x0, x1
-	b.lo	2b
-	dsb	sy
+SYM_FUNC_START_LOCAL(__dma_inv_area)
+	__dcache_inv_by_line x0, x1, x2, x3
 	ret
-SYM_FUNC_END_PI(__inval_dcache_area)
 SYM_FUNC_END(__dma_inv_area)
 
 /*
@@ -177,16 +163,18 @@ SYM_FUNC_END(__dma_inv_area)
  *	- kaddr   - kernel address
  *	- size    - size in question
  */
-SYM_FUNC_START_LOCAL(__dma_clean_area)
 SYM_FUNC_START_PI(__clean_dcache_area_poc)
-	/* FALLTHROUGH */
+	dcache_by_line_op cvac, sy, x0, x1, x2, x3
+	ret
+SYM_FUNC_END_PI(__clean_dcache_area_poc)
 
 /*
  *	__dma_clean_area(start, size)
  *	- start   - virtual start address of region
  *	- size    - size in question
  */
-	dcache_by_line_op cvac, sy, x0, x1, x2, x3
+SYM_FUNC_START_LOCAL(__dma_clean_area)
+	__dcache_by_line_op cvac, x0, x1, x2, x3
 	ret
 SYM_FUNC_END_PI(__clean_dcache_area_poc)
 SYM_FUNC_END(__dma_clean_area)
diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 6c45350..12943b3 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -13,13 +13,13 @@
 
 #include <asm/cacheflush.h>
 
-void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
+void arch_sync_dma_for_device_relaxed(phys_addr_t paddr, size_t size,
 		enum dma_data_direction dir)
 {
 	__dma_map_area(phys_to_virt(paddr), size, dir);
 }
 
-void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
+void arch_sync_dma_for_cpu_relaxed(phys_addr_t paddr, size_t size,
 		enum dma_data_direction dir)
 {
 	__dma_unmap_area(phys_to_virt(paddr), size, dir);
diff --git a/include/linux/dma-noncoherent.h b/include/linux/dma-noncoherent.h
index 0a31e6c..f88fc0f 100644
--- a/include/linux/dma-noncoherent.h
+++ b/include/linux/dma-noncoherent.h
@@ -5,6 +5,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/pgtable.h>
 
+#include <asm/barrier.h>
 #ifdef CONFIG_ARCH_HAS_DMA_COHERENCE_H
 #include <asm/dma-coherence.h>
 #elif defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
