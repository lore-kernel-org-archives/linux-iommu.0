Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52CB19D067
	for <iommu@lists.linux.dev>; Tue, 11 Mar 2025 14:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741702564; cv=none; b=W1tlXBQey1+8yrwjR6C5lgZuQy9Xr2BPVwlbW9ZwxlNHeKlR9imhYiytGdCLSRzh28wD5U5kvHHhmB4yTi034jM7KPloiUnophRKNEInpVUWqcf38k0yV1g00WC8dYoM+uHVEXF6qQthrXWxcvFQxlkl1/6B/qzQGafwZrUewq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741702564; c=relaxed/simple;
	bh=rjAwrS9wYUAJfA4IDE4KYHuqVTyezINURsev7gBQT3M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ms7nkQvWw/Hj+wPl4NdtFswIAqC++cRTrqN+rohfIr5atBOcJiTC4AyoK6Cvq3KAGCIQrGIJzSVnp+5X3Epb9c7sV8/g0MQoOrfGD7M0xgh8l5v0bqhQt/x9MBXPnaEqEsBSjRKpMvzSxTufE9mdLAf6iJf2jILAQXCqCgOq+ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 097451516;
	Tue, 11 Mar 2025 07:16:13 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 120FE3F694;
	Tue, 11 Mar 2025 07:16:00 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org,
	will@kernel.org
Cc: iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	yong.wu@mediatek.com
Subject: [PATCH] iommu/mediatek-v1: Support COMPILE_TEST
Date: Tue, 11 Mar 2025 14:15:56 +0000
Message-Id: <a8d7c0b4393b360ce556f5f15e229d1e2fe73c83.1741702556.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add COMPILE_TEST support to Mediatek v1 so I have less chance of
breaking it again in future. This just needs the ARM dma-iommu API
stubbing out for now.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/Kconfig        |  3 +--
 drivers/iommu/mtk_iommu_v1.c | 11 ++++++++++-
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index ec1b5e32b972..d935b59abb35 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -483,8 +483,7 @@ config MTK_IOMMU
 
 config MTK_IOMMU_V1
 	tristate "MediaTek IOMMU Version 1 (M4U gen1) Support"
-	depends on ARM
-	depends on ARCH_MEDIATEK || COMPILE_TEST
+	depends on (ARCH_MEDIATEK && ARM) || COMPILE_TEST
 	select ARM_DMA_USE_IOMMU
 	select IOMMU_API
 	select MEMORY
diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index 3e724e7f10f0..66824982e05f 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -27,11 +27,20 @@
 #include <linux/spinlock.h>
 #include <linux/string_choices.h>
 #include <asm/barrier.h>
-#include <asm/dma-iommu.h>
 #include <dt-bindings/memory/mtk-memory-port.h>
 #include <dt-bindings/memory/mt2701-larb-port.h>
 #include <soc/mediatek/smi.h>
 
+#if defined(CONFIG_ARM)
+#include <asm/dma-iommu.h>
+#else
+#define arm_iommu_create_mapping(...) NULL
+#define arm_iommu_attach_device(...)	-ENODEV
+struct dma_iommu_mapping {
+	struct iommu_domain *domain;
+};
+#endif
+
 #define REG_MMU_PT_BASE_ADDR			0x000
 
 #define F_ALL_INVLD				0x2
-- 
2.39.2.101.g768bb238c484.dirty

