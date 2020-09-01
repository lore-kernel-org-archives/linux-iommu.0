Return-Path: <SRS0=Ln9J=CK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D197C433E6
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 17:13:25 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FADC20767
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 17:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l84FgiKA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FADC20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 0933121561;
	Tue,  1 Sep 2020 17:13:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id inxwkPbG8fEm; Tue,  1 Sep 2020 17:13:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 7636C1FD90;
	Tue,  1 Sep 2020 17:13:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5B7BBC07FF;
	Tue,  1 Sep 2020 17:13:22 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 96183C0051
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 17:13:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 85666861C7
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 17:13:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pv7vM0qobkCb for <iommu@lists.linux-foundation.org>;
 Tue,  1 Sep 2020 17:13:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f194.google.com (mail-lj1-f194.google.com
 [209.85.208.194])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 69BB385082
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 17:13:20 +0000 (UTC)
Received: by mail-lj1-f194.google.com with SMTP id b19so2449230lji.11
 for <iommu@lists.linux-foundation.org>; Tue, 01 Sep 2020 10:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=3kru/vXmr5CdV8GPE7Nxa8VE3jBFKfjYIQykf9k91YA=;
 b=l84FgiKAtD5+Ha0Covd8cFFEjrFJl6FaJFKH/zfknuXvESg44OAWDLkyFg3UXPT+/W
 6CdI4iQUESWd7MDCSXbdR2QZUnb9XeSqMBdvsJi5a3XLBr6aMY0QnZBw9tpkhoGNxRIP
 oBLcL3uXI2bV0wagms2VVRP3uIcm5+aPA+YNTxYBk0gf2kUKNGDNrRGDoJSb5Y1Un+6g
 QmOVAUoNsQ6fT2bT2DK4cX7dhen9Dtl3DJV2/67gzLiPpjDsrbvN96uZGXEU+rfy0ahF
 HSPfZFFuPJh5JWiKVKhcgo0EnGbnJg732EMIP33DYlDmukQCfYMNXpOvtKgoo16lZeUH
 zuUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=3kru/vXmr5CdV8GPE7Nxa8VE3jBFKfjYIQykf9k91YA=;
 b=VUirTFQoSuQwB5fgB92Q8DIGKgx19YJIElm8e9V8JNZt0Z4DKgHYrtkEpK8zFeaLWO
 lV0r/TdrEeg9Ob6bXnA6j9pyAs8/0GrxlapdNtwOpAlcCxl4CP9wUE4EPM7NNUwp/4v3
 WsGKpoTRGZRIPSA2cTHjO0FlypTN2Pl5fMolGYkSgX7ir7e68x0kMyGofT+kNaIEfrhq
 gMwBpfelEyOfFJs2u4rXFmjE7GFGPodVPAYnv5hzYPQw859nXsXvxMVSxzQbYphkkpWV
 F7Hkk7EcOMUvLwKhTULvFSuTGzT7T+wtnWE6VruyEhGzVdxW5LpDdqIbvOvqQbs8gT2q
 41qw==
X-Gm-Message-State: AOAM5338hhcEGlUvhMzps9j9I5awp0+iksIFdVs0G587Z1eBtAwM1kdZ
 CIchiddh8WUrUquUpG36WlE=
X-Google-Smtp-Source: ABdhPJyTBeZBHi28hVErfPFczRQ31FuTSKFV/K2tDXxd0Gd8X0UOmLI9YMHe0qConm3UAnJw6aTsHg==
X-Received: by 2002:a2e:7210:: with SMTP id n16mr1187428ljc.262.1598980398199; 
 Tue, 01 Sep 2020 10:13:18 -0700 (PDT)
Received: from localhost.localdomain (109-252-170-211.dynamic.spd-mgts.ru.
 [109.252.170.211])
 by smtp.gmail.com with ESMTPSA id s127sm384512lja.119.2020.09.01.10.13.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 10:13:17 -0700 (PDT)
From: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>, Joerg Roedel <joro@8bytes.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, Krishna Reddy <vdumpa@nvidia.com>
Subject: [PATCH v4] iommu/tegra-smmu: Add locking around mapping operations
Date: Tue,  1 Sep 2020 20:13:05 +0300
Message-Id: <20200901171305.6929-1-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Cc: linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
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

The mapping operations of the Tegra SMMU driver are subjected to a race
condition issues because SMMU Address Space isn't allocated and freed
atomically, while it should be. This patch makes the mapping operations
atomic, it fixes an accidentally released Host1x Address Space problem
which happens while running multiple graphics tests in parallel on
Tegra30, i.e. by having multiple threads racing with each other in the
Host1x's submission and completion code paths, performing IOVA mappings
and unmappings in parallel.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---

Changelog:

v4: - Returned to use spinlock, but now using a smarter allocation
      logic that performs allocation in a sleeping context whenever
      possible.

    - Removed the stable tag because patch isn't portable as-is
      since the arguments of map/unmap() callbacks changed recently.
      Perhaps we could just ignore older kernels for now. It will be
      possible to fix older kernels with a custom patch if will be needed.

v3: - No changes. Resending for visibility.

v2: - Now using mutex instead of spinlock.

    - The _locked postfix is replaced with the underscores prefix.

 drivers/iommu/tegra-smmu.c | 95 +++++++++++++++++++++++++++++++++-----
 1 file changed, 84 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 124c8848ab7e..b5914356b878 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -12,6 +12,7 @@
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
+#include <linux/spinlock.h>
 #include <linux/dma-mapping.h>
 
 #include <soc/tegra/ahb.h>
@@ -49,6 +50,7 @@ struct tegra_smmu_as {
 	struct iommu_domain domain;
 	struct tegra_smmu *smmu;
 	unsigned int use_count;
+	spinlock_t lock;
 	u32 *count;
 	struct page **pts;
 	struct page *pd;
@@ -308,6 +310,8 @@ static struct iommu_domain *tegra_smmu_domain_alloc(unsigned type)
 		return NULL;
 	}
 
+	spin_lock_init(&as->lock);
+
 	/* setup aperture */
 	as->domain.geometry.aperture_start = 0;
 	as->domain.geometry.aperture_end = 0xffffffff;
@@ -569,19 +573,14 @@ static u32 *tegra_smmu_pte_lookup(struct tegra_smmu_as *as, unsigned long iova,
 }
 
 static u32 *as_get_pte(struct tegra_smmu_as *as, dma_addr_t iova,
-		       dma_addr_t *dmap)
+		       dma_addr_t *dmap, struct page *page)
 {
 	unsigned int pde = iova_pd_index(iova);
 	struct tegra_smmu *smmu = as->smmu;
 
 	if (!as->pts[pde]) {
-		struct page *page;
 		dma_addr_t dma;
 
-		page = alloc_page(GFP_KERNEL | __GFP_DMA | __GFP_ZERO);
-		if (!page)
-			return NULL;
-
 		dma = dma_map_page(smmu->dev, page, 0, SMMU_SIZE_PT,
 				   DMA_TO_DEVICE);
 		if (dma_mapping_error(smmu->dev, dma)) {
@@ -655,15 +654,61 @@ static void tegra_smmu_set_pte(struct tegra_smmu_as *as, unsigned long iova,
 	smmu_flush(smmu);
 }
 
-static int tegra_smmu_map(struct iommu_domain *domain, unsigned long iova,
-			  phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
+static struct page *as_get_pde_page(struct tegra_smmu_as *as,
+				    unsigned long iova, gfp_t gfp,
+				    unsigned long *flags)
+{
+	unsigned int pde = iova_pd_index(iova);
+	struct page *page = as->pts[pde];
+
+	/* at first check whether allocation needs to be done at all */
+	if (page)
+		return page;
+
+	/*
+	 * In order to prevent exhaustion of the atomic memory pool, we
+	 * allocate page in a sleeping context if GFP flags permit. Hence
+	 * spinlock needs to be unlocked and re-locked after allocation.
+	 */
+	if (!(gfp & GFP_NOWAIT))
+		spin_unlock_irqrestore(&as->lock, *flags);
+
+	page = alloc_page(gfp | __GFP_DMA | __GFP_ZERO);
+
+	if (!(gfp & GFP_NOWAIT))
+		spin_lock_irqsave(&as->lock, *flags);
+
+	/*
+	 * In a case of blocking allocation, a concurrent mapping may win
+	 * the PDE allocation. In this case the allocated page isn't needed
+	 * if allocation succeeded and the allocation failure isn't fatal.
+	 */
+	if (as->pts[pde]) {
+		if (page)
+			__free_page(page);
+
+		page = as->pts[pde];
+	}
+
+	return page;
+}
+
+static int
+__tegra_smmu_map(struct iommu_domain *domain, unsigned long iova,
+		 phys_addr_t paddr, size_t size, int prot, gfp_t gfp,
+		 unsigned long *flags)
 {
 	struct tegra_smmu_as *as = to_smmu_as(domain);
 	dma_addr_t pte_dma;
+	struct page *page;
 	u32 pte_attrs;
 	u32 *pte;
 
-	pte = as_get_pte(as, iova, &pte_dma);
+	page = as_get_pde_page(as, iova, gfp, flags);
+	if (!page)
+		return -ENOMEM;
+
+	pte = as_get_pte(as, iova, &pte_dma, page);
 	if (!pte)
 		return -ENOMEM;
 
@@ -685,8 +730,9 @@ static int tegra_smmu_map(struct iommu_domain *domain, unsigned long iova,
 	return 0;
 }
 
-static size_t tegra_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
-			       size_t size, struct iommu_iotlb_gather *gather)
+static size_t
+__tegra_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
+		   size_t size, struct iommu_iotlb_gather *gather)
 {
 	struct tegra_smmu_as *as = to_smmu_as(domain);
 	dma_addr_t pte_dma;
@@ -702,6 +748,33 @@ static size_t tegra_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
 	return size;
 }
 
+static int tegra_smmu_map(struct iommu_domain *domain, unsigned long iova,
+			  phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
+{
+	struct tegra_smmu_as *as = to_smmu_as(domain);
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&as->lock, flags);
+	ret = __tegra_smmu_map(domain, iova, paddr, size, prot, gfp, &flags);
+	spin_unlock_irqrestore(&as->lock, flags);
+
+	return ret;
+}
+
+static size_t tegra_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
+			       size_t size, struct iommu_iotlb_gather *gather)
+{
+	struct tegra_smmu_as *as = to_smmu_as(domain);
+	unsigned long flags;
+
+	spin_lock_irqsave(&as->lock, flags);
+	size = __tegra_smmu_unmap(domain, iova, size, gather);
+	spin_unlock_irqrestore(&as->lock, flags);
+
+	return size;
+}
+
 static phys_addr_t tegra_smmu_iova_to_phys(struct iommu_domain *domain,
 					   dma_addr_t iova)
 {
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
