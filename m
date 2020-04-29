Return-Path: <SRS0=AFVC=6N=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E76EC8300F
	for <iommu@archiver.kernel.org>; Wed, 29 Apr 2020 13:38:41 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B16A21707
	for <iommu@archiver.kernel.org>; Wed, 29 Apr 2020 13:38:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B16A21707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E83D886A9D;
	Wed, 29 Apr 2020 13:38:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id blnKD1wkFTOQ; Wed, 29 Apr 2020 13:38:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id CDFA486A72;
	Wed, 29 Apr 2020 13:38:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B684AC0864;
	Wed, 29 Apr 2020 13:38:09 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 661FBC0864;
 Wed, 29 Apr 2020 13:37:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 550C086AC4;
 Wed, 29 Apr 2020 13:37:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BQCsm2GrLFUK; Wed, 29 Apr 2020 13:37:55 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 2D0AF86A54;
 Wed, 29 Apr 2020 13:37:55 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id A52A0F14; Wed, 29 Apr 2020 15:37:41 +0200 (CEST)
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
Subject: [PATCH v3 33/34] iommu: Move more initialization to
 __iommu_probe_device()
Date: Wed, 29 Apr 2020 15:37:11 +0200
Message-Id: <20200429133712.31431-34-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200429133712.31431-1-joro@8bytes.org>
References: <20200429133712.31431-1-joro@8bytes.org>
Cc: linux-s390@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Daniel Drake <drake@endlessm.com>, linux-rockchip@lists.infradead.org,
 iommu@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>,
 linux-mediatek@lists.infradead.org, linux-tegra@vger.kernel.org,
 virtualization@lists.linux-foundation.org, jonathan.derrick@intel.com
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

Move the calls to dev_iommu_get() and try_module_get() into
__iommu_probe_device(), so that the callers don't have to do it on
their own.

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/iommu.c | 47 +++++++++++++++++--------------------------
 1 file changed, 18 insertions(+), 29 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 7f99e5ae432c..48a95f7d7999 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -194,9 +194,19 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 	struct iommu_group *group;
 	int ret;
 
+	if (!dev_iommu_get(dev))
+		return -ENOMEM;
+
+	if (!try_module_get(ops->owner)) {
+		ret = -EINVAL;
+		goto err_free;
+	}
+
 	iommu_dev = ops->probe_device(dev);
-	if (IS_ERR(iommu_dev))
-		return PTR_ERR(iommu_dev);
+	if (IS_ERR(iommu_dev)) {
+		ret = PTR_ERR(iommu_dev);
+		goto out_module_put;
+	}
 
 	dev->iommu->iommu_dev = iommu_dev;
 
@@ -217,6 +227,12 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 out_release:
 	ops->release_device(dev);
 
+out_module_put:
+	module_put(ops->owner);
+
+err_free:
+	dev_iommu_free(dev);
+
 	return ret;
 }
 
@@ -226,14 +242,6 @@ int iommu_probe_device(struct device *dev)
 	struct iommu_group *group;
 	int ret;
 
-	if (!dev_iommu_get(dev))
-		return -ENOMEM;
-
-	if (!try_module_get(ops->owner)) {
-		ret = -EINVAL;
-		goto err_out;
-	}
-
 	ret = __iommu_probe_device(dev, NULL);
 	if (ret)
 		goto err_out;
@@ -1532,14 +1540,10 @@ struct iommu_domain *iommu_group_default_domain(struct iommu_group *group)
 
 static int probe_iommu_group(struct device *dev, void *data)
 {
-	const struct iommu_ops *ops = dev->bus->iommu_ops;
 	struct list_head *group_list = data;
 	struct iommu_group *group;
 	int ret;
 
-	if (!dev_iommu_get(dev))
-		return -ENOMEM;
-
 	/* Device is probed already if in a group */
 	group = iommu_group_get(dev);
 	if (group) {
@@ -1547,22 +1551,7 @@ static int probe_iommu_group(struct device *dev, void *data)
 		return 0;
 	}
 
-	if (!try_module_get(ops->owner)) {
-		ret = -EINVAL;
-		goto err_free_dev_iommu;
-	}
-
 	ret = __iommu_probe_device(dev, group_list);
-	if (ret)
-		goto err_module_put;
-
-	return 0;
-
-err_module_put:
-	module_put(ops->owner);
-err_free_dev_iommu:
-	dev_iommu_free(dev);
-
 	if (ret == -ENODEV)
 		ret = 0;
 
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
