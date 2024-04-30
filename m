Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23816129E98
	for <iommu@lists.linux.dev>; Tue, 30 Apr 2024 10:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714472583; cv=none; b=XXxe2RM8zVcj/0TL6bilAp8ZwRFgbHNCxW9/n0qOz637f1wEiA57xb/e3sA7mo/TZfdfYBl7Xlvj+j+weE/2j7oSTkaQp0C3VU2EERUB8siOG4ZsmXNVfv+BtQ6+HdKVaSp4VxjQxP7abrqcxJVXC5ANr6ETdmNDY8LXhzzayAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714472583; c=relaxed/simple;
	bh=xJS0S4m90GREUy7If+cCVOuMtnC4RzsOIPANt9p9Qsg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IAZdNkjW1BzFH6UOxIWKokjq9/Z612DenRzz19R/hC9icdvbEItJ5jaF4qDzqIngeETdW4NBFogOAmFjzMmtPE1ZM37BPbZUG8B+E6hocYwSZC5Ro5QYrCFsL2JoFvLtKeIYftajeqo0bQJIt0RF3m60Ohoh7kqtg3wFV55I+rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0BF82339;
	Tue, 30 Apr 2024 03:23:28 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B03803F73F;
	Tue, 30 Apr 2024 03:23:00 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org
Cc: will@kernel.org,
	catalin.marinas@arm.com,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH] arm64: Properly clean up iommu-dma remnants
Date: Tue, 30 Apr 2024 11:22:53 +0100
Message-Id: <d4cc20cbb0c45175e98dd76bf187e2ad6421296d.1714472573.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks to the somewhat asymmetrical nature, while removing
iommu_setup_dma_ops() from the arch_setup_dma_ops() flow, I managed to
forget that arm64's teardown path was also specific to iommu-dma. Clean
that up to match, otherwise probe deferral will lead to the arch code
erroneously removing DMA ops set elsewhere.

Reported-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://lore.kernel.org/linux-iommu/Zi_LV28TR-P-PzXi@eriador.lumag.spb.ru/
Fixes: b67483b3c44e ("iommu/dma: Centralise iommu_setup_dma_ops()")
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 arch/arm64/Kconfig          | 1 -
 arch/arm64/mm/dma-mapping.c | 8 --------
 2 files changed, 9 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 7b11c98b3e84..8fe59fb9cb35 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -46,7 +46,6 @@ config ARM64
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select ARCH_HAS_SYSCALL_WRAPPER
-	select ARCH_HAS_TEARDOWN_DMA_OPS if IOMMU_SUPPORT
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_HAS_ZONE_DMA_SET if EXPERT
 	select ARCH_HAVE_ELF_PROT
diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 0b320a25a471..b2b5792b2caa 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -7,7 +7,6 @@
 #include <linux/gfp.h>
 #include <linux/cache.h>
 #include <linux/dma-map-ops.h>
-#include <linux/iommu.h>
 #include <xen/xen.h>
 
 #include <asm/cacheflush.h>
@@ -39,13 +38,6 @@ void arch_dma_prep_coherent(struct page *page, size_t size)
 	dcache_clean_poc(start, start + size);
 }
 
-#ifdef CONFIG_IOMMU_DMA
-void arch_teardown_dma_ops(struct device *dev)
-{
-	dev->dma_ops = NULL;
-}
-#endif
-
 void arch_setup_dma_ops(struct device *dev, bool coherent)
 {
 	int cls = cache_line_size_of_cpu();
-- 
2.39.2.101.g768bb238c484.dirty

