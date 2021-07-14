Return-Path: <SRS0=i+j8=MG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92EFBC07E9C
	for <iommu@archiver.kernel.org>; Wed, 14 Jul 2021 10:42:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B4E961369
	for <iommu@archiver.kernel.org>; Wed, 14 Jul 2021 10:42:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B4E961369
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2C3FE415A6;
	Wed, 14 Jul 2021 10:42:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mmijWiJVLdiW; Wed, 14 Jul 2021 10:42:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A673E4149E;
	Wed, 14 Jul 2021 10:42:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 83537C001A;
	Wed, 14 Jul 2021 10:42:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BF9ACC000E
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 10:42:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AF2C683BF1
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 10:42:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oRqDTDSxvTZH for <iommu@lists.linux-foundation.org>;
 Wed, 14 Jul 2021 10:42:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A96B983BFB
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 10:42:14 +0000 (UTC)
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.206])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GPv143K7Xz6L810;
 Wed, 14 Jul 2021 18:31:04 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 14 Jul 2021 12:42:12 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 14 Jul 2021 11:42:08 +0100
From: John Garry <john.garry@huawei.com>
To: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
 <baolu.lu@linux.intel.com>
Subject: [PATCH v4 5/6] iova: Add iova_len argument to init_iova_domain()
Date: Wed, 14 Jul 2021 18:36:42 +0800
Message-ID: <1626259003-201303-6-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1626259003-201303-1-git-send-email-john.garry@huawei.com>
References: <1626259003-201303-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: linux-kernel@vger.kernel.org, sakari.ailus@linux.intel.com, mst@redhat.com,
 airlied@linux.ie, gregkh@linuxfoundation.org, jasowang@redhat.com,
 linuxarm@huawei.com, jonathanh@nvidia.com, iommu@lists.linux-foundation.org,
 thierry.reding@gmail.com, daniel@ffwll.ch, bingbu.cao@intel.com,
 digetx@gmail.com, mchehab@kernel.org, tian.shu.qiu@intel.com
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

Add max opt argument to init_iova_domain(), and use it to set the rcaches
range.

Also fix up all users to set this value (at 0, meaning use default).

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/gpu/drm/tegra/drm.c              |  2 +-
 drivers/gpu/host1x/dev.c                 |  2 +-
 drivers/iommu/dma-iommu.c                |  2 +-
 drivers/iommu/iova.c                     | 18 +++++++++++++-----
 drivers/staging/media/ipu3/ipu3-dmamap.c |  2 +-
 drivers/staging/media/tegra-vde/iommu.c  |  2 +-
 drivers/vdpa/vdpa_sim/vdpa_sim.c         |  2 +-
 include/linux/iova.h                     |  5 +++--
 8 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/tegra/drm.c b/drivers/gpu/drm/tegra/drm.c
index f96c237b2242..c5fb2396ac81 100644
--- a/drivers/gpu/drm/tegra/drm.c
+++ b/drivers/gpu/drm/tegra/drm.c
@@ -1164,7 +1164,7 @@ static int host1x_drm_probe(struct host1x_device *dev)
 
 		order = __ffs(tegra->domain->pgsize_bitmap);
 		init_iova_domain(&tegra->carveout.domain, 1UL << order,
-				 carveout_start >> order);
+				 carveout_start >> order, 0);
 
 		tegra->carveout.shift = iova_shift(&tegra->carveout.domain);
 		tegra->carveout.limit = carveout_end >> tegra->carveout.shift;
diff --git a/drivers/gpu/host1x/dev.c b/drivers/gpu/host1x/dev.c
index fbb6447b8659..3cd02ffbd50e 100644
--- a/drivers/gpu/host1x/dev.c
+++ b/drivers/gpu/host1x/dev.c
@@ -278,7 +278,7 @@ static struct iommu_domain *host1x_iommu_attach(struct host1x *host)
 		end = geometry->aperture_end & host->info->dma_mask;
 
 		order = __ffs(host->domain->pgsize_bitmap);
-		init_iova_domain(&host->iova, 1UL << order, start >> order);
+		init_iova_domain(&host->iova, 1UL << order, start >> order, 0);
 		host->iova_end = end;
 
 		domain = host->domain;
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 4772278aa5da..b540b586fe37 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -368,7 +368,7 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 		return 0;
 	}
 
-	init_iova_domain(iovad, 1UL << order, base_pfn);
+	init_iova_domain(iovad, 1UL << order, base_pfn, 0);
 
 	if (!cookie->fq_domain && (!dev || !dev_is_untrusted(dev)) &&
 	    domain->ops->flush_iotlb_all && !iommu_get_dma_strict(domain)) {
diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 07ce73fdd8c1..0c26aeada1ac 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -23,7 +23,7 @@ static bool iova_rcache_insert(struct iova_domain *iovad,
 static unsigned long iova_rcache_get(struct iova_domain *iovad,
 				     unsigned long size,
 				     unsigned long limit_pfn);
-static void init_iova_rcaches(struct iova_domain *iovad);
+static void init_iova_rcaches(struct iova_domain *iovad, unsigned long iova_len);
 static void free_cpu_cached_iovas(unsigned int cpu, struct iova_domain *iovad);
 static void free_iova_rcaches(struct iova_domain *iovad);
 static void fq_destroy_all_entries(struct iova_domain *iovad);
@@ -48,7 +48,7 @@ static struct iova *to_iova(struct rb_node *node)
 
 void
 init_iova_domain(struct iova_domain *iovad, unsigned long granule,
-	unsigned long start_pfn)
+	unsigned long start_pfn, unsigned long iova_len)
 {
 	/*
 	 * IOVA granularity will normally be equal to the smallest
@@ -71,7 +71,7 @@ init_iova_domain(struct iova_domain *iovad, unsigned long granule,
 	rb_link_node(&iovad->anchor.node, NULL, &iovad->rbroot.rb_node);
 	rb_insert_color(&iovad->anchor.node, &iovad->rbroot);
 	cpuhp_state_add_instance_nocalls(CPUHP_IOMMU_IOVA_DEAD, &iovad->cpuhp_dead);
-	init_iova_rcaches(iovad);
+	init_iova_rcaches(iovad, iova_len);
 }
 EXPORT_SYMBOL_GPL(init_iova_domain);
 
@@ -876,14 +876,22 @@ static void iova_magazine_push(struct iova_magazine *mag, unsigned long pfn)
 	mag->pfns[mag->size++] = pfn;
 }
 
-static void init_iova_rcaches(struct iova_domain *iovad)
+static unsigned long iova_len_to_rcache_max(unsigned long iova_len)
+{
+	return order_base_2(iova_len) + 1;
+}
+
+static void init_iova_rcaches(struct iova_domain *iovad, unsigned long iova_len)
 {
 	struct iova_cpu_rcache *cpu_rcache;
 	struct iova_rcache *rcache;
 	unsigned int cpu;
 	int i;
 
-	iovad->rcache_max_size = IOVA_RANGE_CACHE_MAX_SIZE;
+	if (iova_len)
+		iovad->rcache_max_size = iova_len_to_rcache_max(iova_len);
+	else
+		iovad->rcache_max_size = IOVA_RANGE_CACHE_MAX_SIZE;
 
 	iovad->rcaches = kcalloc(iovad->rcache_max_size,
 				 sizeof(*iovad->rcaches), GFP_KERNEL);
diff --git a/drivers/staging/media/ipu3/ipu3-dmamap.c b/drivers/staging/media/ipu3/ipu3-dmamap.c
index 8a19b0024152..dad8789873e8 100644
--- a/drivers/staging/media/ipu3/ipu3-dmamap.c
+++ b/drivers/staging/media/ipu3/ipu3-dmamap.c
@@ -238,7 +238,7 @@ int imgu_dmamap_init(struct imgu_device *imgu)
 
 	order = __ffs(IPU3_PAGE_SIZE);
 	base_pfn = max_t(unsigned long, 1, imgu->mmu->aperture_start >> order);
-	init_iova_domain(&imgu->iova_domain, 1UL << order, base_pfn);
+	init_iova_domain(&imgu->iova_domain, 1UL << order, base_pfn, 0);
 
 	return 0;
 }
diff --git a/drivers/staging/media/tegra-vde/iommu.c b/drivers/staging/media/tegra-vde/iommu.c
index adf8dc7ee25c..8d351a4f8608 100644
--- a/drivers/staging/media/tegra-vde/iommu.c
+++ b/drivers/staging/media/tegra-vde/iommu.c
@@ -89,7 +89,7 @@ int tegra_vde_iommu_init(struct tegra_vde *vde)
 		goto free_domain;
 
 	order = __ffs(vde->domain->pgsize_bitmap);
-	init_iova_domain(&vde->iova, 1UL << order, 0);
+	init_iova_domain(&vde->iova, 1UL << order, 0, 0);
 
 	err = iommu_attach_group(vde->domain, vde->group);
 	if (err)
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 14e024de5cbf..a4bdff10157f 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -292,7 +292,7 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr)
 		goto err_iommu;
 
 	/* For simplicity we use an IOVA allocator with byte granularity */
-	init_iova_domain(&vdpasim->iova, 1, 0);
+	init_iova_domain(&vdpasim->iova, 1, 0, 0);
 
 	vdpasim->vdpa.dma_dev = dev;
 
diff --git a/include/linux/iova.h b/include/linux/iova.h
index 9974e1d3e2bc..591c736fdb7f 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -152,7 +152,7 @@ unsigned long alloc_iova_fast(struct iova_domain *iovad, unsigned long size,
 struct iova *reserve_iova(struct iova_domain *iovad, unsigned long pfn_lo,
 	unsigned long pfn_hi);
 void init_iova_domain(struct iova_domain *iovad, unsigned long granule,
-	unsigned long start_pfn);
+	unsigned long start_pfn, unsigned long iova_len);
 int init_iova_flush_queue(struct iova_domain *iovad,
 			  iova_flush_cb flush_cb, iova_entry_dtor entry_dtor);
 struct iova *find_iova(struct iova_domain *iovad, unsigned long pfn);
@@ -212,7 +212,8 @@ static inline struct iova *reserve_iova(struct iova_domain *iovad,
 
 static inline void init_iova_domain(struct iova_domain *iovad,
 				    unsigned long granule,
-				    unsigned long start_pfn)
+				    unsigned long start_pfn,
+				    unsigned long iova_len)
 {
 }
 
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
