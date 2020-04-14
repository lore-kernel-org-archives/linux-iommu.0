Return-Path: <SRS0=5SFN=56=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B29BC2BBC7
	for <iommu@archiver.kernel.org>; Tue, 14 Apr 2020 13:16:25 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF2642075E
	for <iommu@archiver.kernel.org>; Tue, 14 Apr 2020 13:16:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF2642075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id C09EE87D0B;
	Tue, 14 Apr 2020 13:16:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Xib+1OEpzf1e; Tue, 14 Apr 2020 13:16:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id D53C387D6A;
	Tue, 14 Apr 2020 13:16:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BF024C1D8D;
	Tue, 14 Apr 2020 13:16:12 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5666CC1D8E;
 Tue, 14 Apr 2020 13:16:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 4BA5987D14;
 Tue, 14 Apr 2020 13:16:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mtW2VsjdWEs7; Tue, 14 Apr 2020 13:16:03 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 214E587A33;
 Tue, 14 Apr 2020 13:16:02 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 3E7BB60E; Tue, 14 Apr 2020 15:15:54 +0200 (CEST)
From: Joerg Roedel <joro@8bytes.org>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Kukjin Kim <kgene@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>,
 Andy Gross <agross@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Rob Clark <robdclark@gmail.com>,
 Heiko Stuebner <heiko@sntech.de>,
 Gerald Schaefer <gerald.schaefer@de.ibm.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v2 15/33] iommu/amd: Convert to probe/release_device()
 call-backs
Date: Tue, 14 Apr 2020 15:15:24 +0200
Message-Id: <20200414131542.25608-16-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200414131542.25608-1-joro@8bytes.org>
References: <20200414131542.25608-1-joro@8bytes.org>
Cc: linux-s390@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-rockchip@lists.infradead.org,
 iommu@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>,
 linux-mediatek@lists.infradead.org, linux-tegra@vger.kernel.org
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: Joerg Roedel <jroedel@suse.de>

Convert the AMD IOMMU Driver to use the probe_device() and
release_device() call-backs of iommu_ops, so that the iommu core code
does the group and sysfs setup.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/amd_iommu.c | 71 ++++++++++++---------------------------
 1 file changed, 22 insertions(+), 49 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 0b4b4faa876d..c30367413683 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -343,21 +343,9 @@ static bool check_device(struct device *dev)
 	return true;
 }
 
-static void init_iommu_group(struct device *dev)
-{
-	struct iommu_group *group;
-
-	group = iommu_group_get_for_dev(dev);
-	if (IS_ERR(group))
-		return;
-
-	iommu_group_put(group);
-}
-
 static int iommu_init_device(struct device *dev)
 {
 	struct iommu_dev_data *dev_data;
-	struct amd_iommu *iommu;
 	int devid;
 
 	if (dev->archdata.iommu)
@@ -367,8 +355,6 @@ static int iommu_init_device(struct device *dev)
 	if (devid < 0)
 		return devid;
 
-	iommu = amd_iommu_rlookup_table[devid];
-
 	dev_data = find_dev_data(devid);
 	if (!dev_data)
 		return -ENOMEM;
@@ -391,8 +377,6 @@ static int iommu_init_device(struct device *dev)
 
 	dev->archdata.iommu = dev_data;
 
-	iommu_device_link(&iommu->iommu, dev);
-
 	return 0;
 }
 
@@ -410,7 +394,7 @@ static void iommu_ignore_device(struct device *dev)
 	setup_aliases(dev);
 }
 
-static void iommu_uninit_device(struct device *dev)
+static void amd_iommu_uninit_device(struct device *dev)
 {
 	struct iommu_dev_data *dev_data;
 	struct amd_iommu *iommu;
@@ -429,13 +413,6 @@ static void iommu_uninit_device(struct device *dev)
 	if (dev_data->domain)
 		detach_device(dev);
 
-	iommu_device_unlink(&iommu->iommu, dev);
-
-	iommu_group_remove_device(dev);
-
-	/* Remove dma-ops */
-	dev->dma_ops = NULL;
-
 	/*
 	 * We keep dev_data around for unplugged devices and reuse it when the
 	 * device is re-plugged - not doing so would introduce a ton of races.
@@ -2152,55 +2129,50 @@ static void detach_device(struct device *dev)
 	spin_unlock_irqrestore(&domain->lock, flags);
 }
 
-static int amd_iommu_add_device(struct device *dev)
+static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 {
-	struct iommu_dev_data *dev_data;
-	struct iommu_domain *domain;
+	struct iommu_device *iommu_dev;
 	struct amd_iommu *iommu;
 	int ret, devid;
 
-	if (get_dev_data(dev))
-		return 0;
-
 	if (!check_device(dev))
-		return -ENODEV;
+		return ERR_PTR(-ENODEV);
 
 	devid = get_device_id(dev);
 	if (devid < 0)
-		return devid;
+		return ERR_PTR(devid);
 
 	iommu = amd_iommu_rlookup_table[devid];
 
+	if (get_dev_data(dev))
+		return &iommu->iommu;
+
 	ret = iommu_init_device(dev);
 	if (ret) {
 		if (ret != -ENOTSUPP)
 			dev_err(dev, "Failed to initialize - trying to proceed anyway\n");
-
+		iommu_dev = ERR_PTR(ret);
 		iommu_ignore_device(dev);
-		dev->dma_ops = NULL;
-		goto out;
+	} else {
+		iommu_dev = &iommu->iommu;
 	}
-	init_iommu_group(dev);
 
-	dev_data = get_dev_data(dev);
+	iommu_completion_wait(iommu);
 
-	BUG_ON(!dev_data);
+	return iommu_dev;
+}
 
-	if (dev_data->iommu_v2)
-		iommu_request_dm_for_dev(dev);
+static void amd_iommu_probe_finalize(struct device *dev)
+{
+	struct iommu_domain *domain;
 
 	/* Domains are initialized for this device - have a look what we ended up with */
 	domain = iommu_get_domain_for_dev(dev);
 	if (domain->type == IOMMU_DOMAIN_DMA)
 		iommu_setup_dma_ops(dev, IOVA_START_PFN << PAGE_SHIFT, 0);
-
-out:
-	iommu_completion_wait(iommu);
-
-	return 0;
 }
 
-static void amd_iommu_remove_device(struct device *dev)
+static void amd_iommu_release_device(struct device *dev)
 {
 	struct amd_iommu *iommu;
 	int devid;
@@ -2214,7 +2186,7 @@ static void amd_iommu_remove_device(struct device *dev)
 
 	iommu = amd_iommu_rlookup_table[devid];
 
-	iommu_uninit_device(dev);
+	amd_iommu_uninit_device(dev);
 	iommu_completion_wait(iommu);
 }
 
@@ -2687,8 +2659,9 @@ const struct iommu_ops amd_iommu_ops = {
 	.map = amd_iommu_map,
 	.unmap = amd_iommu_unmap,
 	.iova_to_phys = amd_iommu_iova_to_phys,
-	.add_device = amd_iommu_add_device,
-	.remove_device = amd_iommu_remove_device,
+	.probe_device = amd_iommu_probe_device,
+	.release_device = amd_iommu_release_device,
+	.probe_finalize = amd_iommu_probe_finalize,
 	.device_group = amd_iommu_device_group,
 	.domain_get_attr = amd_iommu_domain_get_attr,
 	.get_resv_regions = amd_iommu_get_resv_regions,
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
