Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16CBDC433F5
	for <iommu@archiver.kernel.org>; Mon, 14 Feb 2022 02:58:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 931584029F;
	Mon, 14 Feb 2022 02:58:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oyPfxgR2d8ds; Mon, 14 Feb 2022 02:58:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 79B7F40147;
	Mon, 14 Feb 2022 02:58:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 562BEC001A;
	Mon, 14 Feb 2022 02:58:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CAE73C000B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 02:58:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id ABA3C40370
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 02:58:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wjnnC-mx8kRK for <iommu@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 02:58:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B127F40139
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 02:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1644807517; x=1676343517;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=MLEjABaPQRpMPylojsaUggRqEABq92P6LcGDfuqAl7Y=;
 b=PVOwouWk+CM4BPzM551G0XLNuJUEq60rF2z1ikz/5L2j0omCiSFKa/1m
 pQTxGn12A2wbIUqhRQZiY9Y29/NgAEB82ygHhpRmQv+2NcT3ZMcASc5ip
 jT+gU0pvohonmpFjTPDPuXjE4LRxEV4q4yp3UPCbgvuYkL2LsaUYBX/ua
 m1xXDZOiPLaC146vXLn4K8g6Wyi4RBEzShidDcRc20axp+4J019D6LJe3
 5uTWrfaq4AJ9Gs4Xrv6LdqNcT5TSy0eU7NooIxOu0CCTlMTuop7cTWoOk
 JyF/+oqA6cwg0nu+wYJmmjRrw2eFdDZh0LRqCghz5nxPs3XX+Tj/33noF g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="230637513"
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; d="scan'208";a="230637513"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Feb 2022 18:58:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; d="scan'208";a="501514901"
Received: from allen-box.sh.intel.com ([10.239.159.118])
 by orsmga002.jf.intel.com with ESMTP; 13 Feb 2022 18:58:34 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v2 01/11] iommu/vt-d: Remove intel_iommu::domains
Date: Mon, 14 Feb 2022 10:56:54 +0800
Message-Id: <20220214025704.3184654-2-baolu.lu@linux.intel.com>
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

The "domains" field of the intel_iommu structure keeps the mapping of
domain_id to dmar_domain. This information is not used anywhere. Remove
and cleanup it to avoid unnecessary memory consumption.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/intel-iommu.h |  1 -
 drivers/iommu/intel/iommu.c | 68 ++-----------------------------------
 2 files changed, 3 insertions(+), 66 deletions(-)

diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 5cfda90b2cca..8c7591b5f3e2 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -578,7 +578,6 @@ struct intel_iommu {
 
 #ifdef CONFIG_INTEL_IOMMU
 	unsigned long 	*domain_ids; /* bitmap of domains */
-	struct dmar_domain ***domains; /* ptr to domains */
 	spinlock_t	lock; /* protect context, domain ids */
 	struct root_entry *root_entry; /* virtual address */
 
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index b549172e88ef..e3b04d5d87b0 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -455,36 +455,6 @@ __setup("intel_iommu=", intel_iommu_setup);
 static struct kmem_cache *iommu_domain_cache;
 static struct kmem_cache *iommu_devinfo_cache;
 
-static struct dmar_domain* get_iommu_domain(struct intel_iommu *iommu, u16 did)
-{
-	struct dmar_domain **domains;
-	int idx = did >> 8;
-
-	domains = iommu->domains[idx];
-	if (!domains)
-		return NULL;
-
-	return domains[did & 0xff];
-}
-
-static void set_iommu_domain(struct intel_iommu *iommu, u16 did,
-			     struct dmar_domain *domain)
-{
-	struct dmar_domain **domains;
-	int idx = did >> 8;
-
-	if (!iommu->domains[idx]) {
-		size_t size = 256 * sizeof(struct dmar_domain *);
-		iommu->domains[idx] = kzalloc(size, GFP_ATOMIC);
-	}
-
-	domains = iommu->domains[idx];
-	if (WARN_ON(!domains))
-		return;
-	else
-		domains[did & 0xff] = domain;
-}
-
 void *alloc_pgtable_page(int node)
 {
 	struct page *page;
@@ -1751,8 +1721,7 @@ static void intel_flush_iotlb_all(struct iommu_domain *domain)
 						 DMA_TLB_DSI_FLUSH);
 
 		if (!cap_caching_mode(iommu->cap))
-			iommu_flush_dev_iotlb(get_iommu_domain(iommu, did),
-					      0, MAX_AGAW_PFN_WIDTH);
+			iommu_flush_dev_iotlb(dmar_domain, 0, MAX_AGAW_PFN_WIDTH);
 	}
 }
 
@@ -1815,7 +1784,6 @@ static void iommu_disable_translation(struct intel_iommu *iommu)
 static int iommu_init_domains(struct intel_iommu *iommu)
 {
 	u32 ndomains;
-	size_t size;
 
 	ndomains = cap_ndoms(iommu->cap);
 	pr_debug("%s: Number of Domains supported <%d>\n",
@@ -1827,24 +1795,6 @@ static int iommu_init_domains(struct intel_iommu *iommu)
 	if (!iommu->domain_ids)
 		return -ENOMEM;
 
-	size = (ALIGN(ndomains, 256) >> 8) * sizeof(struct dmar_domain **);
-	iommu->domains = kzalloc(size, GFP_KERNEL);
-
-	if (iommu->domains) {
-		size = 256 * sizeof(struct dmar_domain *);
-		iommu->domains[0] = kzalloc(size, GFP_KERNEL);
-	}
-
-	if (!iommu->domains || !iommu->domains[0]) {
-		pr_err("%s: Allocating domain array failed\n",
-		       iommu->name);
-		bitmap_free(iommu->domain_ids);
-		kfree(iommu->domains);
-		iommu->domain_ids = NULL;
-		iommu->domains    = NULL;
-		return -ENOMEM;
-	}
-
 	/*
 	 * If Caching mode is set, then invalid translations are tagged
 	 * with domain-id 0, hence we need to pre-allocate it. We also
@@ -1871,7 +1821,7 @@ static void disable_dmar_iommu(struct intel_iommu *iommu)
 	struct device_domain_info *info, *tmp;
 	unsigned long flags;
 
-	if (!iommu->domains || !iommu->domain_ids)
+	if (!iommu->domain_ids)
 		return;
 
 	spin_lock_irqsave(&device_domain_lock, flags);
@@ -1892,15 +1842,8 @@ static void disable_dmar_iommu(struct intel_iommu *iommu)
 
 static void free_dmar_iommu(struct intel_iommu *iommu)
 {
-	if ((iommu->domains) && (iommu->domain_ids)) {
-		int elems = ALIGN(cap_ndoms(iommu->cap), 256) >> 8;
-		int i;
-
-		for (i = 0; i < elems; i++)
-			kfree(iommu->domains[i]);
-		kfree(iommu->domains);
+	if (iommu->domain_ids) {
 		bitmap_free(iommu->domain_ids);
-		iommu->domains = NULL;
 		iommu->domain_ids = NULL;
 	}
 
@@ -1978,11 +1921,8 @@ static int domain_attach_iommu(struct dmar_domain *domain,
 		}
 
 		set_bit(num, iommu->domain_ids);
-		set_iommu_domain(iommu, num, domain);
-
 		domain->iommu_did[iommu->seq_id] = num;
 		domain->nid			 = iommu->node;
-
 		domain_update_iommu_cap(domain);
 	}
 
@@ -2001,8 +1941,6 @@ static void domain_detach_iommu(struct dmar_domain *domain,
 	if (domain->iommu_refcnt[iommu->seq_id] == 0) {
 		num = domain->iommu_did[iommu->seq_id];
 		clear_bit(num, iommu->domain_ids);
-		set_iommu_domain(iommu, num, NULL);
-
 		domain_update_iommu_cap(domain);
 		domain->iommu_did[iommu->seq_id] = 0;
 	}
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
