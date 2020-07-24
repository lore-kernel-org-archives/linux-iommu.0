Return-Path: <SRS0=ASoY=BD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 098BFC433EB
	for <iommu@archiver.kernel.org>; Fri, 24 Jul 2020 01:54:43 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA6062064B
	for <iommu@archiver.kernel.org>; Fri, 24 Jul 2020 01:54:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA6062064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id BA0EF86DF3;
	Fri, 24 Jul 2020 01:54:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7EhpdFavu_5u; Fri, 24 Jul 2020 01:54:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 06F7B86DD1;
	Fri, 24 Jul 2020 01:54:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 00B85C004E;
	Fri, 24 Jul 2020 01:54:42 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 98BEBC004C
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jul 2020 01:54:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 87AA687E76
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jul 2020 01:54:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ey7-fFWmB6td for <iommu@lists.linux-foundation.org>;
 Fri, 24 Jul 2020 01:54:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by whitealder.osuosl.org (Postfix) with ESMTPS id B4F8288227
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jul 2020 01:54:38 +0000 (UTC)
IronPort-SDR: C/qCs7F9tIMBsv8fPHm+kXZWQypHc6i5kklwZjUsVigb9rla6MSw64/Mi7ZgaCNzeworXiOplh
 ik+ltl+5SClA==
X-IronPort-AV: E=McAfee;i="6000,8403,9691"; a="168778784"
X-IronPort-AV: E=Sophos;i="5.75,388,1589266800"; d="scan'208";a="168778784"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2020 18:54:38 -0700
IronPort-SDR: K5pii7V/yxjaWFj/DsuM0l6qAP9jortaWYeRVg5oSP/Lickni3UWXqCpRzkHTFrAKqq2lO/Cte
 T+wx+LnUWEaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,388,1589266800"; d="scan'208";a="488576762"
Received: from allen-box.sh.intel.com ([10.239.159.139])
 by fmsmga006.fm.intel.com with ESMTP; 23 Jul 2020 18:54:37 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 08/12] iommu/vt-d: Refactor device_to_iommu() helper
Date: Fri, 24 Jul 2020 09:49:21 +0800
Message-Id: <20200724014925.15523-9-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200724014925.15523-1-baolu.lu@linux.intel.com>
References: <20200724014925.15523-1-baolu.lu@linux.intel.com>
Cc: iommu@lists.linux-foundation.org
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

It is refactored in two ways:

- Make it global so that it could be used in other files.

- Make bus/devfn optional so that callers could ignore these two returned
values when they only want to get the coresponding iommu pointer.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/intel/iommu.c | 55 +++++++++++--------------------------
 drivers/iommu/intel/svm.c   |  8 +++---
 include/linux/intel-iommu.h |  3 +-
 3 files changed, 21 insertions(+), 45 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 592869ce2a0f..097a71b3b75d 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -779,16 +779,16 @@ is_downstream_to_pci_bridge(struct device *dev, struct device *bridge)
 	return false;
 }
 
-static struct intel_iommu *device_to_iommu(struct device *dev, u8 *bus, u8 *devfn)
+struct intel_iommu *device_to_iommu(struct device *dev, u8 *bus, u8 *devfn)
 {
 	struct dmar_drhd_unit *drhd = NULL;
+	struct pci_dev *pdev = NULL;
 	struct intel_iommu *iommu;
 	struct device *tmp;
-	struct pci_dev *pdev = NULL;
 	u16 segment = 0;
 	int i;
 
-	if (iommu_dummy(dev))
+	if (!dev || iommu_dummy(dev))
 		return NULL;
 
 	if (dev_is_pci(dev)) {
@@ -819,8 +819,10 @@ static struct intel_iommu *device_to_iommu(struct device *dev, u8 *bus, u8 *devf
 				if (pdev && pdev->is_virtfn)
 					goto got_pdev;
 
-				*bus = drhd->devices[i].bus;
-				*devfn = drhd->devices[i].devfn;
+				if (bus && devfn) {
+					*bus = drhd->devices[i].bus;
+					*devfn = drhd->devices[i].devfn;
+				}
 				goto out;
 			}
 
@@ -830,8 +832,10 @@ static struct intel_iommu *device_to_iommu(struct device *dev, u8 *bus, u8 *devf
 
 		if (pdev && drhd->include_all) {
 		got_pdev:
-			*bus = pdev->bus->number;
-			*devfn = pdev->devfn;
+			if (bus && devfn) {
+				*bus = pdev->bus->number;
+				*devfn = pdev->devfn;
+			}
 			goto out;
 		}
 	}
@@ -5152,11 +5156,10 @@ static int aux_domain_add_dev(struct dmar_domain *domain,
 			      struct device *dev)
 {
 	int ret;
-	u8 bus, devfn;
 	unsigned long flags;
 	struct intel_iommu *iommu;
 
-	iommu = device_to_iommu(dev, &bus, &devfn);
+	iommu = device_to_iommu(dev, NULL, NULL);
 	if (!iommu)
 		return -ENODEV;
 
@@ -5242,9 +5245,8 @@ static int prepare_domain_attach_device(struct iommu_domain *domain,
 	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
 	struct intel_iommu *iommu;
 	int addr_width;
-	u8 bus, devfn;
 
-	iommu = device_to_iommu(dev, &bus, &devfn);
+	iommu = device_to_iommu(dev, NULL, NULL);
 	if (!iommu)
 		return -ENODEV;
 
@@ -5674,9 +5676,8 @@ static bool intel_iommu_capable(enum iommu_cap cap)
 static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 {
 	struct intel_iommu *iommu;
-	u8 bus, devfn;
 
-	iommu = device_to_iommu(dev, &bus, &devfn);
+	iommu = device_to_iommu(dev, NULL, NULL);
 	if (!iommu)
 		return ERR_PTR(-ENODEV);
 
@@ -5689,9 +5690,8 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 static void intel_iommu_release_device(struct device *dev)
 {
 	struct intel_iommu *iommu;
-	u8 bus, devfn;
 
-	iommu = device_to_iommu(dev, &bus, &devfn);
+	iommu = device_to_iommu(dev, NULL, NULL);
 	if (!iommu)
 		return;
 
@@ -5841,37 +5841,14 @@ static struct iommu_group *intel_iommu_device_group(struct device *dev)
 	return generic_device_group(dev);
 }
 
-#ifdef CONFIG_INTEL_IOMMU_SVM
-struct intel_iommu *intel_svm_device_to_iommu(struct device *dev)
-{
-	struct intel_iommu *iommu;
-	u8 bus, devfn;
-
-	if (iommu_dummy(dev)) {
-		dev_warn(dev,
-			 "No IOMMU translation for device; cannot enable SVM\n");
-		return NULL;
-	}
-
-	iommu = device_to_iommu(dev, &bus, &devfn);
-	if ((!iommu)) {
-		dev_err(dev, "No IOMMU for device; cannot enable SVM\n");
-		return NULL;
-	}
-
-	return iommu;
-}
-#endif /* CONFIG_INTEL_IOMMU_SVM */
-
 static int intel_iommu_enable_auxd(struct device *dev)
 {
 	struct device_domain_info *info;
 	struct intel_iommu *iommu;
 	unsigned long flags;
-	u8 bus, devfn;
 	int ret;
 
-	iommu = device_to_iommu(dev, &bus, &devfn);
+	iommu = device_to_iommu(dev, NULL, NULL);
 	if (!iommu || dmar_disabled)
 		return -EINVAL;
 
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index d386853121a2..65d2327dcd0d 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -231,7 +231,7 @@ static LIST_HEAD(global_svm_list);
 int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
 			  struct iommu_gpasid_bind_data *data)
 {
-	struct intel_iommu *iommu = intel_svm_device_to_iommu(dev);
+	struct intel_iommu *iommu = device_to_iommu(dev, NULL, NULL);
 	struct dmar_domain *dmar_domain;
 	struct intel_svm_dev *sdev;
 	struct intel_svm *svm;
@@ -369,7 +369,7 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
 
 int intel_svm_unbind_gpasid(struct device *dev, int pasid)
 {
-	struct intel_iommu *iommu = intel_svm_device_to_iommu(dev);
+	struct intel_iommu *iommu = device_to_iommu(dev, NULL, NULL);
 	struct intel_svm_dev *sdev;
 	struct intel_svm *svm;
 	int ret = -EINVAL;
@@ -426,7 +426,7 @@ static int
 intel_svm_bind_mm(struct device *dev, int flags, struct svm_dev_ops *ops,
 		  struct mm_struct *mm, struct intel_svm_dev **sd)
 {
-	struct intel_iommu *iommu = intel_svm_device_to_iommu(dev);
+	struct intel_iommu *iommu = device_to_iommu(dev, NULL, NULL);
 	struct device_domain_info *info;
 	struct intel_svm_dev *sdev;
 	struct intel_svm *svm = NULL;
@@ -604,7 +604,7 @@ static int intel_svm_unbind_mm(struct device *dev, int pasid)
 	struct intel_svm *svm;
 	int ret = -EINVAL;
 
-	iommu = intel_svm_device_to_iommu(dev);
+	iommu = device_to_iommu(dev, NULL, NULL);
 	if (!iommu)
 		goto out;
 
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 383847b859a1..7e69aec60592 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -729,6 +729,7 @@ void iommu_flush_write_buffer(struct intel_iommu *iommu);
 int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct device *dev);
 struct dmar_domain *find_domain(struct device *dev);
 struct device_domain_info *get_domain_info(struct device *dev);
+struct intel_iommu *device_to_iommu(struct device *dev, u8 *bus, u8 *devfn);
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
 extern void intel_svm_check(struct intel_iommu *iommu);
@@ -767,8 +768,6 @@ struct intel_svm {
 	struct list_head devs;
 	struct list_head list;
 };
-
-extern struct intel_iommu *intel_svm_device_to_iommu(struct device *dev);
 #else
 static inline void intel_svm_check(struct intel_iommu *iommu) {}
 #endif
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
