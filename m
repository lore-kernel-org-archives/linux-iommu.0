Return-Path: <SRS0=VQ5+=43=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA629C3F2D0
	for <iommu@archiver.kernel.org>; Tue, 10 Mar 2020 09:12:50 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C86320674
	for <iommu@archiver.kernel.org>; Tue, 10 Mar 2020 09:12:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C86320674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 72FEA87290;
	Tue, 10 Mar 2020 09:12:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H59LCHEOI1P1; Tue, 10 Mar 2020 09:12:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C122F86739;
	Tue, 10 Mar 2020 09:12:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AF901C18D3;
	Tue, 10 Mar 2020 09:12:45 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BED22C18D3;
 Tue, 10 Mar 2020 09:12:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id A8F7820427;
 Tue, 10 Mar 2020 09:12:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CB4jab3Uou50; Tue, 10 Mar 2020 09:12:42 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by silver.osuosl.org (Postfix) with ESMTPS id D5C422043D;
 Tue, 10 Mar 2020 09:12:41 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 92FC870B; Tue, 10 Mar 2020 10:12:32 +0100 (CET)
From: Joerg Roedel <joro@8bytes.org>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 05/15] iommu: Rename struct iommu_param to dev_iommu
Date: Tue, 10 Mar 2020 10:12:19 +0100
Message-Id: <20200310091229.29830-6-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200310091229.29830-1-joro@8bytes.org>
References: <20200310091229.29830-1-joro@8bytes.org>
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

The term dev_iommu aligns better with other existing structures and
their accessor functions.

Tested-by: Will Deacon <will@kernel.org> # arm-smmu
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/iommu.c  | 28 ++++++++++++++--------------
 include/linux/device.h |  6 +++---
 include/linux/iommu.h  |  4 ++--
 3 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 3e3528436e0b..beac2ef063dd 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -152,9 +152,9 @@ void iommu_device_unregister(struct iommu_device *iommu)
 }
 EXPORT_SYMBOL_GPL(iommu_device_unregister);
 
-static struct iommu_param *iommu_get_dev_param(struct device *dev)
+static struct dev_iommu *dev_iommu_get(struct device *dev)
 {
-	struct iommu_param *param = dev->iommu_param;
+	struct dev_iommu *param = dev->iommu;
 
 	if (param)
 		return param;
@@ -164,14 +164,14 @@ static struct iommu_param *iommu_get_dev_param(struct device *dev)
 		return NULL;
 
 	mutex_init(&param->lock);
-	dev->iommu_param = param;
+	dev->iommu = param;
 	return param;
 }
 
-static void iommu_free_dev_param(struct device *dev)
+static void dev_iommu_free(struct device *dev)
 {
-	kfree(dev->iommu_param);
-	dev->iommu_param = NULL;
+	kfree(dev->iommu);
+	dev->iommu = NULL;
 }
 
 int iommu_probe_device(struct device *dev)
@@ -183,7 +183,7 @@ int iommu_probe_device(struct device *dev)
 	if (!ops)
 		return -EINVAL;
 
-	if (!iommu_get_dev_param(dev))
+	if (!dev_iommu_get(dev))
 		return -ENOMEM;
 
 	if (!try_module_get(ops->owner)) {
@@ -200,7 +200,7 @@ int iommu_probe_device(struct device *dev)
 err_module_put:
 	module_put(ops->owner);
 err_free_dev_param:
-	iommu_free_dev_param(dev);
+	dev_iommu_free(dev);
 	return ret;
 }
 
@@ -211,9 +211,9 @@ void iommu_release_device(struct device *dev)
 	if (dev->iommu_group)
 		ops->remove_device(dev);
 
-	if (dev->iommu_param) {
+	if (dev->iommu) {
 		module_put(ops->owner);
-		iommu_free_dev_param(dev);
+		dev_iommu_free(dev);
 	}
 }
 
@@ -972,7 +972,7 @@ int iommu_register_device_fault_handler(struct device *dev,
 					iommu_dev_fault_handler_t handler,
 					void *data)
 {
-	struct iommu_param *param = dev->iommu_param;
+	struct dev_iommu *param = dev->iommu;
 	int ret = 0;
 
 	if (!param)
@@ -1015,7 +1015,7 @@ EXPORT_SYMBOL_GPL(iommu_register_device_fault_handler);
  */
 int iommu_unregister_device_fault_handler(struct device *dev)
 {
-	struct iommu_param *param = dev->iommu_param;
+	struct dev_iommu *param = dev->iommu;
 	int ret = 0;
 
 	if (!param)
@@ -1055,7 +1055,7 @@ EXPORT_SYMBOL_GPL(iommu_unregister_device_fault_handler);
  */
 int iommu_report_device_fault(struct device *dev, struct iommu_fault_event *evt)
 {
-	struct iommu_param *param = dev->iommu_param;
+	struct dev_iommu *param = dev->iommu;
 	struct iommu_fault_event *evt_pending = NULL;
 	struct iommu_fault_param *fparam;
 	int ret = 0;
@@ -1104,7 +1104,7 @@ int iommu_page_response(struct device *dev,
 	int ret = -EINVAL;
 	struct iommu_fault_event *evt;
 	struct iommu_fault_page_request *prm;
-	struct iommu_param *param = dev->iommu_param;
+	struct dev_iommu *param = dev->iommu;
 	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
 
 	if (!domain || !domain->ops->page_response)
diff --git a/include/linux/device.h b/include/linux/device.h
index fa04dfd22bbc..405a8f11bec1 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -44,7 +44,7 @@ struct iommu_ops;
 struct iommu_group;
 struct iommu_fwspec;
 struct dev_pin_info;
-struct iommu_param;
+struct dev_iommu;
 
 /**
  * struct subsys_interface - interfaces to device functions
@@ -514,7 +514,7 @@ struct dev_links_info {
  * 		device (i.e. the bus driver that discovered the device).
  * @iommu_group: IOMMU group the device belongs to.
  * @iommu_fwspec: IOMMU-specific properties supplied by firmware.
- * @iommu_param: Per device generic IOMMU runtime data
+ * @iommu:	Per device generic IOMMU runtime data
  *
  * @offline_disabled: If set, the device is permanently online.
  * @offline:	Set after successful invocation of bus type's .offline().
@@ -614,7 +614,7 @@ struct device {
 	void	(*release)(struct device *dev);
 	struct iommu_group	*iommu_group;
 	struct iommu_fwspec	*iommu_fwspec;
-	struct iommu_param	*iommu_param;
+	struct dev_iommu	*iommu;
 
 	bool			offline_disabled:1;
 	bool			offline:1;
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 3c4ca041d7a2..1c9fa5c1174b 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -365,7 +365,7 @@ struct iommu_fault_param {
 };
 
 /**
- * struct iommu_param - collection of per-device IOMMU data
+ * struct dev_iommu - Collection of per-device IOMMU data
  *
  * @fault_param: IOMMU detected device fault reporting data
  *
@@ -373,7 +373,7 @@ struct iommu_fault_param {
  *	struct iommu_group	*iommu_group;
  *	struct iommu_fwspec	*iommu_fwspec;
  */
-struct iommu_param {
+struct dev_iommu {
 	struct mutex lock;
 	struct iommu_fault_param *fault_param;
 };
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
