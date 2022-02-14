Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D881EC433FE
	for <iommu@archiver.kernel.org>; Mon, 14 Feb 2022 02:58:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9321C40469;
	Mon, 14 Feb 2022 02:58:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pu8XXbiLpV2T; Mon, 14 Feb 2022 02:58:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1B3F140463;
	Mon, 14 Feb 2022 02:58:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E7F3AC0021;
	Mon, 14 Feb 2022 02:58:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D2D65C000B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 02:58:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B3B3F40370
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 02:58:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YT5VnngFt8QJ for <iommu@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 02:58:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BC26640469
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 02:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1644807526; x=1676343526;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=QdYhx9EO4AI/TCmCtlewK7xJRADcHuvAfbD9DIvtaeM=;
 b=G7z5sAY1p60znGdGivYfTS9rBdCBbnqOlXVKWYAMnykLGbWCoZBpU1qe
 m6/sWx/iZ+sStBzFnZFrLER7zhzPOoREM96zlZLx9C7rdrm05VOenueE/
 IDIpZK0t2ylvB4QSjGiBBW/1yHekWXVaa14NyxgjgXzD0H8gtuz3PAs2R
 78siVy/dtiuH66Ef1io97ndBEDeRtE8lG8Prg0iyFM7YOVWTX9cqMlBqX
 eePeSemOIOwxFUbfp36k6p5/exu8Ti3P9SAx7vbwia78kChjP7085Ke/c
 MVd3GSCfqa2uRzun0yZEcjtr/K/rwy7A1Y1+2ouclOSwxbO00ntxjzOOr g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="230637524"
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; d="scan'208";a="230637524"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Feb 2022 18:58:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; d="scan'208";a="501514930"
Received: from allen-box.sh.intel.com ([10.239.159.118])
 by orsmga002.jf.intel.com with ESMTP; 13 Feb 2022 18:58:43 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v2 04/11] iommu/vt-d: Remove domain and devinfo mempool
Date: Mon, 14 Feb 2022 10:56:57 +0800
Message-Id: <20220214025704.3184654-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220214025704.3184654-1-baolu.lu@linux.intel.com>
References: <20220214025704.3184654-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Jason Gunthorpe <jgg@nvidia.com>, Robin Murphy <robin.murphy@arm.com>,
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

The domain and devinfo memory blocks are only allocated during device
probe and released during remove. There's no hot-path context, hence
no need for memory pools.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/intel/iommu.c | 104 ++----------------------------------
 1 file changed, 5 insertions(+), 99 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 7c2b427bea3b..51db26d8606c 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -452,9 +452,6 @@ static int __init intel_iommu_setup(char *str)
 }
 __setup("intel_iommu=", intel_iommu_setup);
 
-static struct kmem_cache *iommu_domain_cache;
-static struct kmem_cache *iommu_devinfo_cache;
-
 void *alloc_pgtable_page(int node)
 {
 	struct page *page;
@@ -471,26 +468,6 @@ void free_pgtable_page(void *vaddr)
 	free_page((unsigned long)vaddr);
 }
 
-static inline void *alloc_domain_mem(void)
-{
-	return kmem_cache_alloc(iommu_domain_cache, GFP_ATOMIC);
-}
-
-static void free_domain_mem(void *vaddr)
-{
-	kmem_cache_free(iommu_domain_cache, vaddr);
-}
-
-static inline void * alloc_devinfo_mem(void)
-{
-	return kmem_cache_alloc(iommu_devinfo_cache, GFP_ATOMIC);
-}
-
-static inline void free_devinfo_mem(void *vaddr)
-{
-	kmem_cache_free(iommu_devinfo_cache, vaddr);
-}
-
 static inline int domain_type_is_si(struct dmar_domain *domain)
 {
 	return domain->domain.type == IOMMU_DOMAIN_IDENTITY;
@@ -1885,11 +1862,10 @@ static struct dmar_domain *alloc_domain(unsigned int type)
 {
 	struct dmar_domain *domain;
 
-	domain = alloc_domain_mem();
+	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
 	if (!domain)
 		return NULL;
 
-	memset(domain, 0, sizeof(*domain));
 	domain->nid = NUMA_NO_NODE;
 	if (first_level_by_default(type))
 		domain->flags |= DOMAIN_FLAG_USE_FIRST_LEVEL;
@@ -1973,7 +1949,7 @@ static void domain_exit(struct dmar_domain *domain)
 		put_pages_list(&freelist);
 	}
 
-	free_domain_mem(domain);
+	kfree(domain);
 }
 
 /*
@@ -2558,7 +2534,7 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 	unsigned long flags;
 	int ret;
 
-	info = alloc_devinfo_mem();
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
 	if (!info)
 		return NULL;
 
@@ -2574,13 +2550,9 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 		info->segment = pci_domain_nr(pdev->bus);
 	}
 
-	info->ats_supported = info->pasid_supported = info->pri_supported = 0;
-	info->ats_enabled = info->pasid_enabled = info->pri_enabled = 0;
-	info->ats_qdep = 0;
 	info->dev = dev;
 	info->domain = domain;
 	info->iommu = iommu;
-	info->pasid_table = NULL;
 
 	if (dev && dev_is_pci(dev)) {
 		struct pci_dev *pdev = to_pci_dev(info->dev);
@@ -2610,7 +2582,7 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 
 	if (ret) {
 		spin_unlock_irqrestore(&device_domain_lock, flags);
-		free_devinfo_mem(info);
+		kfree(info);
 		return NULL;
 	}
 
@@ -3343,65 +3315,6 @@ static int __init init_dmars(void)
 	return ret;
 }
 
-static inline int iommu_domain_cache_init(void)
-{
-	int ret = 0;
-
-	iommu_domain_cache = kmem_cache_create("iommu_domain",
-					 sizeof(struct dmar_domain),
-					 0,
-					 SLAB_HWCACHE_ALIGN,
-
-					 NULL);
-	if (!iommu_domain_cache) {
-		pr_err("Couldn't create iommu_domain cache\n");
-		ret = -ENOMEM;
-	}
-
-	return ret;
-}
-
-static inline int iommu_devinfo_cache_init(void)
-{
-	int ret = 0;
-
-	iommu_devinfo_cache = kmem_cache_create("iommu_devinfo",
-					 sizeof(struct device_domain_info),
-					 0,
-					 SLAB_HWCACHE_ALIGN,
-					 NULL);
-	if (!iommu_devinfo_cache) {
-		pr_err("Couldn't create devinfo cache\n");
-		ret = -ENOMEM;
-	}
-
-	return ret;
-}
-
-static int __init iommu_init_mempool(void)
-{
-	int ret;
-
-	ret = iommu_domain_cache_init();
-	if (ret)
-		goto domain_error;
-
-	ret = iommu_devinfo_cache_init();
-	if (!ret)
-		return ret;
-
-	kmem_cache_destroy(iommu_domain_cache);
-domain_error:
-
-	return -ENOMEM;
-}
-
-static void __init iommu_exit_mempool(void)
-{
-	kmem_cache_destroy(iommu_devinfo_cache);
-	kmem_cache_destroy(iommu_domain_cache);
-}
-
 static void __init init_no_remapping_devices(void)
 {
 	struct dmar_drhd_unit *drhd;
@@ -4253,12 +4166,6 @@ int __init intel_iommu_init(void)
 	force_on = (!intel_iommu_tboot_noforce && tboot_force_iommu()) ||
 		    platform_optin_force_iommu();
 
-	if (iommu_init_mempool()) {
-		if (force_on)
-			panic("tboot: Failed to initialize iommu memory\n");
-		return -ENOMEM;
-	}
-
 	down_write(&dmar_global_lock);
 	if (dmar_table_init()) {
 		if (force_on)
@@ -4379,7 +4286,6 @@ int __init intel_iommu_init(void)
 out_free_dmar:
 	intel_iommu_free_dmars();
 	up_write(&dmar_global_lock);
-	iommu_exit_mempool();
 	return ret;
 }
 
@@ -4436,7 +4342,7 @@ static void __dmar_remove_one_dev_info(struct device_domain_info *info)
 	domain_detach_iommu(domain, iommu);
 	spin_unlock_irqrestore(&iommu->lock, flags);
 
-	free_devinfo_mem(info);
+	kfree(info);
 }
 
 static void dmar_remove_one_dev_info(struct device *dev)
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
