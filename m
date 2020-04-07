Return-Path: <SRS0=p9ZB=5X=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2336BC2D0EC
	for <iommu@archiver.kernel.org>; Tue,  7 Apr 2020 18:38:18 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC0AD20771
	for <iommu@archiver.kernel.org>; Tue,  7 Apr 2020 18:38:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC0AD20771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id BF34A2420F;
	Tue,  7 Apr 2020 18:38:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aGVrkYvAUqft; Tue,  7 Apr 2020 18:38:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 6E8FC221D2;
	Tue,  7 Apr 2020 18:38:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6329CC1D85;
	Tue,  7 Apr 2020 18:38:08 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C7CD3C0177;
 Tue,  7 Apr 2020 18:38:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id AF3B988045;
 Tue,  7 Apr 2020 18:38:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7xpVfmgASBaC; Tue,  7 Apr 2020 18:38:02 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by hemlock.osuosl.org (Postfix) with ESMTPS id DD49487E14;
 Tue,  7 Apr 2020 18:37:59 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 3FD6B46B; Tue,  7 Apr 2020 20:37:51 +0200 (CEST)
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
Subject: [RFC PATCH 16/34] iommu/vt-d: Convert to probe/release_device()
 call-backs
Date: Tue,  7 Apr 2020 20:37:24 +0200
Message-Id: <20200407183742.4344-17-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200407183742.4344-1-joro@8bytes.org>
References: <20200407183742.4344-1-joro@8bytes.org>
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

Convert the Intel IOMMU driver to use the probe_device() and
release_device() call-backs of iommu_ops, so that the iommu core code
does the group and sysfs setup.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/intel-iommu.c | 67 ++++---------------------------------
 1 file changed, 6 insertions(+), 61 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index b9f905a55dda..b906727f5b85 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5781,78 +5781,27 @@ static bool intel_iommu_capable(enum iommu_cap cap)
 	return false;
 }
 
-static int intel_iommu_add_device(struct device *dev)
+static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 {
-	struct dmar_domain *dmar_domain;
-	struct iommu_domain *domain;
 	struct intel_iommu *iommu;
-	struct iommu_group *group;
 	u8 bus, devfn;
-	int ret;
 
 	iommu = device_to_iommu(dev, &bus, &devfn);
 	if (!iommu)
-		return -ENODEV;
-
-	iommu_device_link(&iommu->iommu, dev);
+		return ERR_PTR(-ENODEV);
 
 	if (translation_pre_enabled(iommu))
 		dev->archdata.iommu = DEFER_DEVICE_DOMAIN_INFO;
 
-	group = iommu_group_get_for_dev(dev);
-
-	if (IS_ERR(group)) {
-		ret = PTR_ERR(group);
-		goto unlink;
-	}
-
-	iommu_group_put(group);
-
-	domain = iommu_get_domain_for_dev(dev);
-	dmar_domain = to_dmar_domain(domain);
-	if (domain->type == IOMMU_DOMAIN_DMA) {
-		if (device_def_domain_type(dev) == IOMMU_DOMAIN_IDENTITY) {
-			ret = iommu_request_dm_for_dev(dev);
-			if (ret) {
-				dmar_remove_one_dev_info(dev);
-				dmar_domain->flags |= DOMAIN_FLAG_LOSE_CHILDREN;
-				domain_add_dev_info(si_domain, dev);
-				dev_info(dev,
-					 "Device uses a private identity domain.\n");
-			}
-		}
-	} else {
-		if (device_def_domain_type(dev) == IOMMU_DOMAIN_DMA) {
-			ret = iommu_request_dma_domain_for_dev(dev);
-			if (ret) {
-				dmar_remove_one_dev_info(dev);
-				dmar_domain->flags |= DOMAIN_FLAG_LOSE_CHILDREN;
-				if (!get_private_domain_for_dev(dev)) {
-					dev_warn(dev,
-						 "Failed to get a private domain.\n");
-					ret = -ENOMEM;
-					goto unlink;
-				}
-
-				dev_info(dev,
-					 "Device uses a private dma domain.\n");
-			}
-		}
-	}
-
 	if (device_needs_bounce(dev)) {
 		dev_info(dev, "Use Intel IOMMU bounce page dma_ops\n");
 		set_dma_ops(dev, &bounce_dma_ops);
 	}
 
-	return 0;
-
-unlink:
-	iommu_device_unlink(&iommu->iommu, dev);
-	return ret;
+	return &iommu->iommu;
 }
 
-static void intel_iommu_remove_device(struct device *dev)
+static void intel_iommu_release_device(struct device *dev)
 {
 	struct intel_iommu *iommu;
 	u8 bus, devfn;
@@ -5863,10 +5812,6 @@ static void intel_iommu_remove_device(struct device *dev)
 
 	dmar_remove_one_dev_info(dev);
 
-	iommu_group_remove_device(dev);
-
-	iommu_device_unlink(&iommu->iommu, dev);
-
 	if (device_needs_bounce(dev))
 		set_dma_ops(dev, NULL);
 }
@@ -6198,8 +6143,8 @@ const struct iommu_ops intel_iommu_ops = {
 	.map			= intel_iommu_map,
 	.unmap			= intel_iommu_unmap,
 	.iova_to_phys		= intel_iommu_iova_to_phys,
-	.add_device		= intel_iommu_add_device,
-	.remove_device		= intel_iommu_remove_device,
+	.probe_device		= intel_iommu_probe_device,
+	.release_device		= intel_iommu_release_device,
 	.get_resv_regions	= intel_iommu_get_resv_regions,
 	.put_resv_regions	= generic_iommu_put_resv_regions,
 	.apply_resv_region	= intel_iommu_apply_resv_region,
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
