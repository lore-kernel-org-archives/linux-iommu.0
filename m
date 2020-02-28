Return-Path: <SRS0=BxgK=4Q=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A343C3F2D2
	for <iommu@archiver.kernel.org>; Fri, 28 Feb 2020 15:09:00 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE7F02469F
	for <iommu@archiver.kernel.org>; Fri, 28 Feb 2020 15:08:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE7F02469F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id DDD2F86E09;
	Fri, 28 Feb 2020 15:08:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kyDOP_YkpnFq; Fri, 28 Feb 2020 15:08:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 93C5D86E9F;
	Fri, 28 Feb 2020 15:08:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7F09FC1D84;
	Fri, 28 Feb 2020 15:08:47 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 25666C0177;
 Fri, 28 Feb 2020 15:08:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 0593D20499;
 Fri, 28 Feb 2020 15:08:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iGerzlAKqQBV; Fri, 28 Feb 2020 15:08:36 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by silver.osuosl.org (Postfix) with ESMTPS id 1B311204A8;
 Fri, 28 Feb 2020 15:08:36 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 8952E63F; Fri, 28 Feb 2020 16:08:30 +0100 (CET)
From: Joerg Roedel <joro@8bytes.org>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 11/14] iommu/mediatek: Use accessor functions for iommu
 private data
Date: Fri, 28 Feb 2020 16:08:17 +0100
Message-Id: <20200228150820.15340-12-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200228150820.15340-1-joro@8bytes.org>
References: <20200228150820.15340-1-joro@8bytes.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
 Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Thierry Reding <thierry.reding@gmail.com>, linux-mediatek@lists.infradead.org,
 Andy Gross <agross@kernel.org>, Joerg Roedel <jroedel@suse.de>,
 Hanjun Guo <guohanjun@huawei.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, Sean Paul <sean@poorly.run>,
 Robin Murphy <robin.murphy@arm.com>
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

Make use of dev_iommu_priv_set/get() functions.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/mtk_iommu.c    | 13 ++++++-------
 drivers/iommu/mtk_iommu_v1.c | 14 +++++++-------
 2 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 95945f467c03..5f4d6df59cf6 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -358,8 +358,8 @@ static void mtk_iommu_domain_free(struct iommu_domain *domain)
 static int mtk_iommu_attach_device(struct iommu_domain *domain,
 				   struct device *dev)
 {
+	struct mtk_iommu_data *data = dev_iommu_priv_get(dev);
 	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
-	struct mtk_iommu_data *data = dev_iommu_fwspec_get(dev)->iommu_priv;
 
 	if (!data)
 		return -ENODEV;
@@ -378,7 +378,7 @@ static int mtk_iommu_attach_device(struct iommu_domain *domain,
 static void mtk_iommu_detach_device(struct iommu_domain *domain,
 				    struct device *dev)
 {
-	struct mtk_iommu_data *data = dev_iommu_fwspec_get(dev)->iommu_priv;
+	struct mtk_iommu_data *data = dev_iommu_priv_get(dev);
 
 	if (!data)
 		return;
@@ -450,7 +450,7 @@ static int mtk_iommu_add_device(struct device *dev)
 	if (!fwspec || fwspec->ops != &mtk_iommu_ops)
 		return -ENODEV; /* Not a iommu client device */
 
-	data = fwspec->iommu_priv;
+	data = dev_iommu_priv_get(dev);
 	iommu_device_link(&data->iommu, dev);
 
 	group = iommu_group_get_for_dev(dev);
@@ -469,7 +469,7 @@ static void mtk_iommu_remove_device(struct device *dev)
 	if (!fwspec || fwspec->ops != &mtk_iommu_ops)
 		return;
 
-	data = fwspec->iommu_priv;
+	data = dev_iommu_priv_get(dev);
 	iommu_device_unlink(&data->iommu, dev);
 
 	iommu_group_remove_device(dev);
@@ -496,7 +496,6 @@ static struct iommu_group *mtk_iommu_device_group(struct device *dev)
 
 static int mtk_iommu_of_xlate(struct device *dev, struct of_phandle_args *args)
 {
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct platform_device *m4updev;
 
 	if (args->args_count != 1) {
@@ -505,13 +504,13 @@ static int mtk_iommu_of_xlate(struct device *dev, struct of_phandle_args *args)
 		return -EINVAL;
 	}
 
-	if (!fwspec->iommu_priv) {
+	if (!dev_iommu_priv_get(dev)) {
 		/* Get the m4u device */
 		m4updev = of_find_device_by_node(args->np);
 		if (WARN_ON(!m4updev))
 			return -EINVAL;
 
-		fwspec->iommu_priv = platform_get_drvdata(m4updev);
+		dev_iommu_priv_set(dev, platform_get_drvdata(m4updev));
 	}
 
 	return iommu_fwspec_add_ids(dev, args->args, 1);
diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index e93b94ecac45..9930ac7413cc 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -263,8 +263,8 @@ static void mtk_iommu_domain_free(struct iommu_domain *domain)
 static int mtk_iommu_attach_device(struct iommu_domain *domain,
 				   struct device *dev)
 {
+	struct mtk_iommu_data *data = dev_iommu_priv_get(dev);
 	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
-	struct mtk_iommu_data *data = dev_iommu_fwspec_get(dev)->iommu_priv;
 	int ret;
 
 	if (!data)
@@ -286,7 +286,7 @@ static int mtk_iommu_attach_device(struct iommu_domain *domain,
 static void mtk_iommu_detach_device(struct iommu_domain *domain,
 				    struct device *dev)
 {
-	struct mtk_iommu_data *data = dev_iommu_fwspec_get(dev)->iommu_priv;
+	struct mtk_iommu_data *data = dev_iommu_priv_get(dev);
 
 	if (!data)
 		return;
@@ -387,20 +387,20 @@ static int mtk_iommu_create_mapping(struct device *dev,
 		return -EINVAL;
 	}
 
-	if (!fwspec->iommu_priv) {
+	if (!dev_iommu_priv_get(dev)) {
 		/* Get the m4u device */
 		m4updev = of_find_device_by_node(args->np);
 		if (WARN_ON(!m4updev))
 			return -EINVAL;
 
-		fwspec->iommu_priv = platform_get_drvdata(m4updev);
+		dev_iommu_priv_set(dev, platform_get_drvdata(m4updev));
 	}
 
 	ret = iommu_fwspec_add_ids(dev, args->args, 1);
 	if (ret)
 		return ret;
 
-	data = fwspec->iommu_priv;
+	data = dev_iommu_priv_get(dev);
 	m4udev = data->dev;
 	mtk_mapping = m4udev->archdata.iommu;
 	if (!mtk_mapping) {
@@ -459,7 +459,7 @@ static int mtk_iommu_add_device(struct device *dev)
 	if (err)
 		return err;
 
-	data = fwspec->iommu_priv;
+	data = dev_iommu_priv_get(dev)
 	mtk_mapping = data->dev->archdata.iommu;
 	err = arm_iommu_attach_device(dev, mtk_mapping);
 	if (err) {
@@ -478,7 +478,7 @@ static void mtk_iommu_remove_device(struct device *dev)
 	if (!fwspec || fwspec->ops != &mtk_iommu_ops)
 		return;
 
-	data = fwspec->iommu_priv;
+	data = dev_iommu_priv_get(dev)
 	iommu_device_unlink(&data->iommu, dev);
 
 	iommu_group_remove_device(dev);
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
