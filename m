Received: from pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com [34.218.115.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5703357C724
	for <iommu@lists.linux.dev>; Tue,  8 Sep 2026 16:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.218.115.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788883379; cv=none; b=rvvPe8A9nc7ep04Wsi6pPxrQh4ZfrEv2D7nQMqmwAfugrzDPioAsz/rB8eMvTfNtFKjBAvwczI+fmm7yWQ3tshxB22L104Sh3ru7NifMExRiqs925w/WUBzhKAYUpW4tB1m/QmhB7RrSQgdt1WAGLLSW5Udehy344InBynkQBfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788883379; c=relaxed/simple;
	bh=YPPG7mGDH5Gt2hIBfA30lIj49aJvABa4xtEKMraKBgU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=D5Jk1FHaBwzbx2seJaZkFoyACJFHcoIFW+JgZhTJtBX050ShuPFdReLmj3VAYnyPYhJRp4dxVf/I8LjvzUq41BFHzcHHC7DLzYUECnT+37F8yhsFYsfZxalR5mnhDJOZD6PCAapTG5mWRiHSsbBhhfEpyJvVkqOskH/TpB9YTBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=HPsks8IC; arc=none smtp.client-ip=34.218.115.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="HPsks8IC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1788883377; x=1820419377;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wyrp65su9krdNFJRiUJxVNjQuYFB+0tAdojc3S8S0uU=;
  b=HPsks8ICZgVTvSpCnVWLyfBPLyN+q6jvteDAZkJxbGmgjhRgEzlpoyat
   gAKeqxktbAjrHC5ox5jvI2FKq42TaHWST9lx9p86IDdi1Na2XGFpgtwHu
   Wdgrqwhd476B8Mhek6AYB08rZnCSFnKuABAiFd3mBSxhmBM8fmv9H2KND
   V/Po3nc1mmlOuQxj7lRn/BXVN24B4km2iGn10CpVI6D/OhEOcG5UkoSbX
   oA/cBT62pZFVwBJuSFBEbViQSYEExMQ5OZ7SEAkugg4vzUNa3SpDrDU65
   V7uCe4DXfljU9vt64HKZD4NDe5uLZgMSDhXlDFH21tfS9pFMvXlCfnGBx
   w==;
X-CSE-ConnectionGUID: fNyCOxl0Qx2W1YWVfHfBWw==
X-CSE-MsgGUID: DVPmOfs8TZmXEvt+vX/a/g==
X-IronPort-AV: E=Sophos;i="6.25,269,1779148800"; 
   d="scan'208";a="27917537"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 16:02:54 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:30167]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.37.238:2525] with esmtp (Farcaster)
 id ca9330a7-2a4e-490a-9189-ff7824e49092; Tue, 8 Sep 2026 16:02:54 +0000 (UTC)
X-Farcaster-Flow-ID: ca9330a7-2a4e-490a-9189-ff7824e49092
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Tue, 8 Sep 2026 16:02:53 +0000
Received: from dev-dsk-fparola-1b-85ea2014.eu-west-1.amazon.com
 (10.13.236.104) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.46; Tue, 8 Sep 2026
 16:02:52 +0000
From: Federico Parola <fparola@amazon.de>
To: Robin Murphy <robin.murphy@arm.com>, "Joerg Roedel (AMD)"
	<joro@8bytes.org>, Will Deacon <will@kernel.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
CC: <nh-open-source@amazon.com>
Subject: [PATCH] iommu/dma: Finalize deferred attachments when mapping MSI pages
Date: Tue, 8 Sep 2026 16:01:56 +0000
Message-ID: <20260908160218.62322-1-fparola@amazon.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWB003.ant.amazon.com (10.13.138.85) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

When a device's attachment to its default domain is deferred, the IOMMU
is still translating the device with the tables inherited from the
previous kernel. Any mapping installed in that domain does not take
effect until the deferred attachment is finalized.
iommu_deferred_attach() covers the DMA mapping paths, but nothing covers
iommu_dma_sw_msi(): programming an MSI installs the MSI page in
group->domain and hands the resulting IOVA to the irqchip, so an MSI
programmed before the first DMA map is written using an IOVA that the
hardware does not yet translate.

This issue is currently not triggerable as the two IOMMU implementations
supporting deferred attachments, Intel and AMD, do not rely on DMA
translations for MSI transactions. However, the Arm implementation being
introduced in [1] will be subject to it.

Finalize the deferred attachment from iommu_dma_sw_msi() too, right
before the MSI page is mapped. iommu_dma_prepare_msi() already holds
group->mutex across the call, so factor the locked part of
iommu_deferred_attach() out into __iommu_deferred_attach() and call that
instead of taking the mutex recursively. The static branch on
iommu_deferred_attach_enabled can be omitted as MSI page allocation is
not on a fast path.

The behaviour of a rejected attach changes slightly: an attach refused
because the device is being reset (-EBUSY) now fails MSI setup rather
than only the first DMA map.

Link: https://lore.kernel.org/linux-iommu/cover.1788130528.git.nicolinc@nvidia.com/ [1]
Signed-off-by: Federico Parola <fparola@amazon.de>
---
 drivers/iommu/dma-iommu.c  |  7 +++++++
 drivers/iommu/iommu-priv.h |  2 ++
 drivers/iommu/iommu.c      | 25 ++++++++++++++++++-------
 3 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 58c624513cd4..fa7de1b3d538 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -37,6 +37,7 @@
 
 #include "dma-iommu.h"
 #include "iommu-pages.h"
+#include "iommu-priv.h"
 
 struct iommu_dma_msi_page {
 	struct list_head	list;
@@ -2247,6 +2248,7 @@ int iommu_dma_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
 {
 	struct device *dev = msi_desc_to_dev(desc);
 	const struct iommu_dma_msi_page *msi_page;
+	int ret;
 
 	if (!has_msi_cookie(domain)) {
 		msi_desc_set_iommu_msi_iova(desc, 0, 0);
@@ -2254,6 +2256,11 @@ int iommu_dma_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
 	}
 
 	iommu_group_mutex_assert(dev);
+
+	ret = __iommu_deferred_attach(dev, domain);
+	if (ret)
+		return ret;
+
 	msi_page = iommu_dma_get_msi_page(dev, msi_addr, domain);
 	if (!msi_page)
 		return -ENOMEM;
diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
index aaffad5854fc..ba72f9a03b0b 100644
--- a/drivers/iommu/iommu-priv.h
+++ b/drivers/iommu/iommu-priv.h
@@ -21,6 +21,8 @@ static inline const struct iommu_ops *dev_iommu_ops(struct device *dev)
 
 void dev_iommu_free(struct device *dev);
 
+int __iommu_deferred_attach(struct device *dev, struct iommu_domain *domain);
+
 const struct iommu_ops *iommu_ops_from_fwnode(const struct fwnode_handle *fwnode);
 
 static inline const struct iommu_ops *iommu_fwspec_ops(struct iommu_fwspec *fwspec)
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index cd1bca7ede9a..d7d70689c784 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2214,19 +2214,15 @@ int iommu_attach_device(struct iommu_domain *domain, struct device *dev)
 }
 EXPORT_SYMBOL_GPL(iommu_attach_device);
 
-int iommu_deferred_attach(struct device *dev, struct iommu_domain *domain)
+/* Caller must hold dev->iommu_group->mutex */
+int __iommu_deferred_attach(struct device *dev, struct iommu_domain *domain)
 {
 	struct group_device *gdev;
 
-	/*
-	 * This is called on the dma mapping fast path so avoid locking. This is
-	 * racy, but we have an expectation that the driver will setup its DMAs
-	 * inside probe while being single threaded to avoid racing.
-	 */
 	if (!dev->iommu || !dev->iommu->attach_deferred)
 		return 0;
 
-	guard(mutex)(&dev->iommu_group->mutex);
+	lockdep_assert_held(&dev->iommu_group->mutex);
 
 	gdev = __dev_to_gdev(dev);
 	if (WARN_ON(!gdev))
@@ -2244,6 +2240,21 @@ int iommu_deferred_attach(struct device *dev, struct iommu_domain *domain)
 	return __iommu_attach_device(domain, dev, NULL);
 }
 
+int iommu_deferred_attach(struct device *dev, struct iommu_domain *domain)
+{
+	/*
+	 * This is called on the dma mapping fast path so avoid locking. This is
+	 * racy, but we have an expectation that the driver will setup its DMAs
+	 * inside probe while being single threaded to avoid racing.
+	 */
+	if (!dev->iommu || !dev->iommu->attach_deferred)
+		return 0;
+
+	guard(mutex)(&dev->iommu_group->mutex);
+
+	return __iommu_deferred_attach(dev, domain);
+}
+
 void iommu_detach_device(struct iommu_domain *domain, struct device *dev)
 {
 	/* Caller must be a probed driver on dev */
-- 
2.47.3

