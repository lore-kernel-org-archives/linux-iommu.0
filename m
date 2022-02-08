Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64FCCC433F5
	for <iommu@archiver.kernel.org>; Tue,  8 Feb 2022 01:27:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1F41F40400;
	Tue,  8 Feb 2022 01:27:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BPiiq6j7la2p; Tue,  8 Feb 2022 01:27:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DD2C6404CF;
	Tue,  8 Feb 2022 01:27:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C80DFC001A;
	Tue,  8 Feb 2022 01:27:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 206BAC000B
 for <iommu@lists.linux-foundation.org>; Tue,  8 Feb 2022 01:27:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B076140136
 for <iommu@lists.linux-foundation.org>; Tue,  8 Feb 2022 01:27:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id f4v5YQz0YGtQ for <iommu@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 01:27:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EF21A4028D
 for <iommu@lists.linux-foundation.org>; Tue,  8 Feb 2022 01:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1644283667; x=1675819667;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=yrnVpbUTBJshPuiouZjgXbQVpQ4Ovq0yS3i0Rg1TiQc=;
 b=HKmrFx8+qmZVLNkaZImlLxJFCQ7gyrKTkhlc7qnoneQB3Bi8WERDq7Fj
 iebOresJeUSYK/IL5HOBGSCDR1+sP0un6KLZKznJ9UGD/bZq5SOR8gINo
 yQr5WKrVkZErSjcac+Bv5Pl1BHGXcqwG++hZ6PuH5oGEnvfb2TklpaW7g
 VAPczsCvaKm7WXFTRiEq2DHYLmcatEf/QrkvxtZ5C+nnycO8JsM3efcdL
 0etnzdZ5Jkz1atRiGT8wpvXxlgXYylulqwK+G/WeVPDUO03dDSc6BKx2C
 EuHXJfNN4J9RZ2z7qveJ/H6c1M/5LlNoR6UyhV6BrfLj8YBaWLXPSZVY4 g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="228816295"
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; d="scan'208";a="228816295"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Feb 2022 17:27:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; d="scan'208";a="677948831"
Received: from allen-box.sh.intel.com ([10.239.159.118])
 by fmsmga001.fm.intel.com with ESMTP; 07 Feb 2022 17:27:44 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>, Ben Skeggs <bskeggs@redhat.com>,
 Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v2 05/10] iommu: Remove apply_resv_region
Date: Tue,  8 Feb 2022 09:25:54 +0800
Message-Id: <20220208012559.1121729-6-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220208012559.1121729-1-baolu.lu@linux.intel.com>
References: <20220208012559.1121729-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Jonathan Hunter <jonathanh@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jacob jun Pan <jacob.jun.pan@intel.com>, Daniel Vetter <daniel@ffwll.ch>
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
index cf54dc925827..df6bd1d58c74 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -785,9 +785,6 @@ static int iommu_create_device_direct_mappings(struct iommu_group *group,
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
