Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 455B5C433FE
	for <iommu@archiver.kernel.org>; Tue, 12 Apr 2022 00:55:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DE85F8333E;
	Tue, 12 Apr 2022 00:55:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OaRM4qqdFel9; Tue, 12 Apr 2022 00:55:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A38D8827B5;
	Tue, 12 Apr 2022 00:55:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 84988C002F;
	Tue, 12 Apr 2022 00:55:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 900B2C002C;
 Tue, 12 Apr 2022 00:05:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6DEE6409DA;
 Tue, 12 Apr 2022 00:05:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hPGbblYMKN28; Tue, 12 Apr 2022 00:05:45 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1E532409BC;
 Tue, 12 Apr 2022 00:05:45 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="244126092"
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; d="scan'208";a="244126092"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Apr 2022 17:05:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; d="scan'208";a="526213233"
Received: from rlcp.bj.intel.com ([10.238.158.160])
 by orsmga006.jf.intel.com with ESMTP; 11 Apr 2022 17:05:43 -0700
From: Tina Zhang <"tina.zhang@"@intel.corp-partner.google.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [RFC] iommu/virtio: Add map/unmap_pages() callbacks implementation
Date: Tue, 12 Apr 2022 08:03:22 +0800
Message-Id: <20220412000322.285601-1-user@RLCP>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 12 Apr 2022 00:55:30 +0000
Cc: iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org,
 David Stevens <stevensd@chromium.org>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: Tina Zhang <tina.zhang@intel.com>

Map/unmap_pags() allows map and unmap multiple pages of the same size
in one call, which can improve performance by reducing the numbers of
vmexits. With map/unmap_pages() implemented, the prior map/unmap()
callbacks are deprecated.

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 drivers/iommu/virtio-iommu.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 25be4b822aa0..f6e672b13bdc 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -1006,6 +1006,33 @@ static int viommu_of_xlate(struct device *dev, struct of_phandle_args *args)
 	return iommu_fwspec_add_ids(dev, args->args, 1);
 }
 
+static int viommu_map_pages(struct iommu_domain *domain,
+				 unsigned long iova, phys_addr_t paddr,
+				 size_t pgsize, size_t pgcount,
+				 int prot, gfp_t gfp, size_t *mapped)
+{
+	unsigned long pgshift = __ffs(pgsize);
+	size_t size = pgcount << pgshift;
+	int ret;
+
+	ret = viommu_map(domain, iova, paddr, size, prot, gfp);
+	if (!ret && mapped)
+		*mapped = size;
+
+	return ret;
+}
+
+static size_t viommu_unmap_pages(struct iommu_domain *domain,
+				      unsigned long iova,
+				      size_t pgsize, size_t pgcount,
+				      struct iommu_iotlb_gather *gather)
+{
+	unsigned long pgshift = __ffs(pgsize);
+	size_t size = pgcount << pgshift;
+
+	return viommu_unmap(domain, iova, size, gather);
+}
+
 static struct iommu_ops viommu_ops = {
 	.domain_alloc		= viommu_domain_alloc,
 	.probe_device		= viommu_probe_device,
@@ -1018,8 +1045,8 @@ static struct iommu_ops viommu_ops = {
 	.owner			= THIS_MODULE,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev		= viommu_attach_dev,
-		.map			= viommu_map,
-		.unmap			= viommu_unmap,
+		.unmap_pages		= viommu_unmap_pages,
+		.map_pages		= viommu_map_pages,
 		.iova_to_phys		= viommu_iova_to_phys,
 		.iotlb_sync		= viommu_iotlb_sync,
 		.free			= viommu_domain_free,
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
