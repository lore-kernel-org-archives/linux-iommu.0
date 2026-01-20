Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9F02C11DF;
	Tue, 20 Jan 2026 07:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768892482; cv=none; b=qPUBo0dd7xgvfjl6m4XI9/usRewgKhraReaK8EzgMU8rYg9/vc/R5wnxOhpJprxqtU3LaR67nW1pzeiG8nJUYdbMPzKJrrpb2GY08V2LMQcQKcyFmU1lbnOJ7m6V91p9/eEffFPamAcXEjK9v1vWmgbETkLvhGVHt9pwhTdXLYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768892482; c=relaxed/simple;
	bh=Ka2VmzEd9yItw/Rs1DcMA39bphAvE5HWx2Aao3EwXjs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KkFSM7dTUH0sqf3b1jW9l2M2vF/TgJUEw+64axK1nufczMtjQgW4+6HLDGrQyhIIa8W6/KfgL5StdvV0h2gPjuS0Rlw54WE6auEOkUBcxYTCu3ersgl67j57upWXogRfpQ06opqmn4jOR56I/5IoZrPbMNZEZz2gO1J4kReyUsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h5W5hgNs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h5W5hgNs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB5FBC16AAE;
	Tue, 20 Jan 2026 07:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768892481;
	bh=Ka2VmzEd9yItw/Rs1DcMA39bphAvE5HWx2Aao3EwXjs=;
	h=From:To:Cc:Subject:Date:From;
	b=h5W5hgNsxyxwQdq8nNyCppH5wxO+ejIAuT+vvDykcH5xl3sGiW7mMyoruOJWOdp1m
	 NE/7NzT1SewLuSkLJQOadlfN2fo9MD5ip3v/u6F3CpM4bLneD/8nEUeiq6RHsAQRJg
	 YHfjjpqelvigz1jRWo+EIZz6gzk4Tmh+MS0zmvHXYSWTky3olccqcBYsBw7mggawsX
	 Xykr24qlby4gufIxI8XDA3E/4ur2GVP0KAQ8VfAUNwKhYy6e84q+6CNvzuYTZeILk3
	 MGvrUlaCvimcgNowPjGBQgUwCktIoLALg3FnymZrDGIlQBseFSDd2+5NlCkRAzYi70
	 OA2ZycH7U789g==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	suzuki.poulose@arm.com,
	steven.price@arm.com,
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Subject: [PATCH] arm64: swiotlb: Don’t shrink default buffer when bounce is forced
Date: Tue, 20 Jan 2026 12:31:02 +0530
Message-ID: <20260120070102.182977-1-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

arm64 reduces the default swiotlb size (for unaligned kmalloc()
bouncing) when it detects that no swiotlb bouncing is needed.

If swiotlb bouncing is explicitly forced via the command line
(swiotlb=force), this heuristic must not apply. Add a swiotlb helper to
query the forced-bounce state and use it to skip the resize when
bouncing is forced.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 arch/arm64/mm/init.c    | 3 ++-
 include/linux/swiotlb.h | 7 +++++++
 kernel/dma/swiotlb.c    | 5 +++++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 524d34a0e921..7046241b47b8 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -345,7 +345,8 @@ void __init arch_mm_preinit(void)
 		flags |= SWIOTLB_FORCE;
 	}
 
-	if (IS_ENABLED(CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC) && !swiotlb) {
+	if (IS_ENABLED(CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC) &&
+	    !(swiotlb || force_swiotlb_bounce())) {
 		/*
 		 * If no bouncing needed for ZONE_DMA, reduce the swiotlb
 		 * buffer for kmalloc() bouncing to 1MB per 1GB of RAM.
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 3dae0f592063..513a93dcbdbc 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -185,6 +185,7 @@ bool is_swiotlb_active(struct device *dev);
 void __init swiotlb_adjust_size(unsigned long size);
 phys_addr_t default_swiotlb_base(void);
 phys_addr_t default_swiotlb_limit(void);
+bool force_swiotlb_bounce(void);
 #else
 static inline void swiotlb_init(bool addressing_limited, unsigned int flags)
 {
@@ -234,6 +235,12 @@ static inline phys_addr_t default_swiotlb_limit(void)
 {
 	return 0;
 }
+
+static inline bool force_swiotlb_bounce(void)
+{
+	return false;
+}
+
 #endif /* CONFIG_SWIOTLB */
 
 phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t phys,
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 0d37da3d95b6..85e31f228cc9 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -1646,6 +1646,11 @@ phys_addr_t default_swiotlb_base(void)
 	return io_tlb_default_mem.defpool.start;
 }
 
+bool force_swiotlb_bounce(void)
+{
+	return swiotlb_force_bounce;
+}
+
 /**
  * default_swiotlb_limit() - get the address limit of the default SWIOTLB
  *
-- 
2.43.0

