Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0574B4057
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 11:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790596335; cv=none; b=AjB7O23B5o9n2A22oCJNIhn2yu9xaGG7OGAqAmsZGazJw+VV6BhgrkQechnzYIsXAI8AUtQ3RqX1Y4Dkjj2Yhc8K2eAmpbETivouQUbrgcqqnGvNDl43o2Uiwsy6rEqC361DDXIHnwNcsxPW8sfD72NukAA2wqbxP2HVuuMbB7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790596335; c=relaxed/simple;
	bh=WZtpKmiSKC6Dc+CdkK6BcpkUdhJuCQXb2v7RNg07wV8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IamwFYQAS32CnGtMAc8vRmjMhQTZ0VTdbVyPKV9saClKRKWba1TqHmasvStGYK+/nc6Xspi+oqSs5HDY1nRmfv5cTo7Cb5jkzTvx0TLi2vUvXOw+PFkQBviL1ZCwJLn79F1+PSHK1nMfbNDVnBFAHFrIMTWQAqMZeWzwnFx4UQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=W3wGEcst; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="W3wGEcst"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A2C261570;
	Mon, 28 Sep 2026 04:52:08 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 54BF53F763;
	Mon, 28 Sep 2026 04:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790596332; bh=WZtpKmiSKC6Dc+CdkK6BcpkUdhJuCQXb2v7RNg07wV8=;
	h=From:To:Cc:Subject:Date:From;
	b=W3wGEcstljIdqt/gWRdkAwHbMkwojtpv2e4W2a4y4ieTceqP0acoVEpTME4nTkLgk
	 MzeBuFPQTytSXwzodo3ovjkO36SxuNDoWKu+D+Fwv5OB1EcV7rDJnwcB1ob114owUX
	 SqCUTRxD37BHFQ7Y3CV9S8qRoVvNfAe2bwgR09kw=
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org,
	will@kernel.org
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iommu: Make iommu-dma helpers private
Date: Mon, 28 Sep 2026 12:51:47 +0100
Message-ID: <ddcc6f8487366211af0d81ad9af2376ec29d8460.1790596307.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.54.0.dirty
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Most of iommu-dma's own internals were privatised a while ago, but
there are still a couple of DMA-domain-specific helpers provided
by the core code. These now definitely have no reason to be exposed
publicly, so move their declarations into the private header.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/dma-iommu.c  | 1 +
 drivers/iommu/iommu-priv.h | 4 ++++
 include/linux/iommu.h      | 2 --
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 58c624513cd4..1b8012123232 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -37,6 +37,7 @@
 
 #include "dma-iommu.h"
 #include "iommu-pages.h"
+#include "iommu-priv.h"
 
 struct iommu_dma_msi_page {
 	struct list_head	list;
diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
index aaffad5854fc..1f9f886b2c10 100644
--- a/drivers/iommu/iommu-priv.h
+++ b/drivers/iommu/iommu-priv.h
@@ -30,6 +30,10 @@ static inline const struct iommu_ops *iommu_fwspec_ops(struct iommu_fwspec *fwsp
 
 void iommu_fwspec_free(struct device *dev);
 
+int iommu_deferred_attach(struct device *dev, struct iommu_domain *domain);
+
+struct iommu_domain *iommu_get_dma_domain(struct device *dev);
+
 int iommu_device_register_bus(struct iommu_device *iommu,
 			      const struct iommu_ops *ops,
 			      const struct bus_type *bus,
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index ac43b8b93f14..95e32c78dcb7 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -898,7 +898,6 @@ int  iommu_device_sysfs_add(struct iommu_device *iommu,
 void iommu_device_sysfs_remove(struct iommu_device *iommu);
 int  iommu_device_link(struct iommu_device   *iommu, struct device *link);
 void iommu_device_unlink(struct iommu_device *iommu, struct device *link);
-int iommu_deferred_attach(struct device *dev, struct iommu_domain *domain);
 
 static inline struct iommu_device *dev_to_iommu_device(struct device *dev)
 {
@@ -943,7 +942,6 @@ extern void iommu_detach_device(struct iommu_domain *domain,
 				struct device *dev);
 extern struct iommu_domain *iommu_get_domain_for_dev(struct device *dev);
 struct iommu_domain *iommu_driver_get_domain_for_dev(struct device *dev);
-extern struct iommu_domain *iommu_get_dma_domain(struct device *dev);
 extern int iommu_map(struct iommu_domain *domain, unsigned long iova,
 		     phys_addr_t paddr, size_t size, int prot, gfp_t gfp);
 int iommu_map_nosync(struct iommu_domain *domain, unsigned long iova,
-- 
2.54.0.dirty

