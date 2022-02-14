Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF7F3C433EF
	for <iommu@archiver.kernel.org>; Mon, 14 Feb 2022 01:57:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3600281497;
	Mon, 14 Feb 2022 01:57:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 08Y8xD3OCnL0; Mon, 14 Feb 2022 01:57:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id AD7C28145D;
	Mon, 14 Feb 2022 01:57:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 595C7C0070;
	Mon, 14 Feb 2022 01:57:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E6C10C007C
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 01:57:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CF09640353
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 01:57:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Sm2h3CcPFCUH for <iommu@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 01:57:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 44AB84033C
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 01:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1644803871; x=1676339871;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=QPnDGZYqEL8lzJ/a++F6WRyRimejmxMhswRnFUkhPWs=;
 b=WSPMZGIabZWMFHlVT0bXqDOloZbakjBMz2uAwQmUZ1a8pkCEHCl4EA65
 2lq/xaBiL1JL4BMFhdu0hUAzdp80k7VKYFUHtactWm6kYDqWO/Z39/XTf
 8ecOZAWriP9g/lWs9iof8RWiLEziAhp5Nq9QHCb2wrCx+xKM3W674gRET
 NEAnslPewixgU+UhGxmAcd7RQJZDYAT+M4okzJB+mo/WzmcpUg+Rvl7kp
 dAPrKB6IXV/WFKgtE00ijrGJYgNnzXBYO9QIxGAco6kIWhaQ3+XyJy1ZC
 +kth0qiwmNbJWhoGkLjtWGUNRY5mIrMvNnG2uXCjlWGr6FMaL7iaCu7nB A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="249938516"
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; d="scan'208";a="249938516"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Feb 2022 17:57:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; d="scan'208";a="680137286"
Received: from allen-box.sh.intel.com ([10.239.159.118])
 by fmsmga001.fm.intel.com with ESMTP; 13 Feb 2022 17:57:47 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>, Ben Skeggs <bskeggs@redhat.com>,
 Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v3 05/10] iommu: Remove apply_resv_region
Date: Mon, 14 Feb 2022 09:55:33 +0800
Message-Id: <20220214015538.2828933-6-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220214015538.2828933-1-baolu.lu@linux.intel.com>
References: <20220214015538.2828933-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Jonathan Hunter <jonathanh@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jacob jun Pan <jacob.jun.pan@intel.com>, Daniel Vetter <daniel@ffwll.ch>,
 Christoph Hellwig <hch@lst.de>
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

The apply_resv_region callback in iommu_ops was introduced to reserve an
IOVA range in the given DMA domain when the IOMMU driver manages the IOVA
by itself. As all drivers converted to use dma-iommu in the core, there's
no driver using this anymore. Remove it to avoid dead code.

Suggested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 include/linux/iommu.h | 4 ----
 drivers/iommu/iommu.c | 3 ---
 2 files changed, 7 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 9983a01373b2..9ffa2e88f3d0 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -214,7 +214,6 @@ struct iommu_iotlb_gather {
  * @set_pgtable_quirks: Set io page table quirks (IO_PGTABLE_QUIRK_*)
  * @get_resv_regions: Request list of reserved regions for a device
  * @put_resv_regions: Free list of reserved regions for a device
- * @apply_resv_region: Temporary helper call-back for iova reserved ranges
  * @of_xlate: add OF master IDs to iommu grouping
  * @is_attach_deferred: Check if domain attach should be deferred from iommu
  *                      driver init to device driver init (default no)
@@ -268,9 +267,6 @@ struct iommu_ops {
 	/* Request/Free a list of reserved regions for a device */
 	void (*get_resv_regions)(struct device *dev, struct list_head *list);
 	void (*put_resv_regions)(struct device *dev, struct list_head *list);
-	void (*apply_resv_region)(struct device *dev,
-				  struct iommu_domain *domain,
-				  struct iommu_resv_region *region);
 
 	int (*of_xlate)(struct device *dev, struct of_phandle_args *args);
 	bool (*is_attach_deferred)(struct iommu_domain *domain, struct device *dev);
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 0ebaf561a70e..7cf073c56036 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -790,9 +790,6 @@ static int iommu_create_device_direct_mappings(struct iommu_group *group,
 		dma_addr_t start, end, addr;
 		size_t map_size = 0;
 
-		if (domain->ops->apply_resv_region)
-			domain->ops->apply_resv_region(dev, domain, entry);
-
 		start = ALIGN(entry->start, pg_size);
 		end   = ALIGN(entry->start + entry->length, pg_size);
 
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
