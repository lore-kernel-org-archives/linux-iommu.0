Return-Path: <SRS0=szPT=AU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA8BC433E0
	for <iommu@archiver.kernel.org>; Thu,  9 Jul 2020 07:10:20 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8649D2073A
	for <iommu@archiver.kernel.org>; Thu,  9 Jul 2020 07:10:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8649D2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 52A1687A4E;
	Thu,  9 Jul 2020 07:10:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2gu4Xchid40P; Thu,  9 Jul 2020 07:10:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9886587A44;
	Thu,  9 Jul 2020 07:10:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7AC75C077B;
	Thu,  9 Jul 2020 07:10:19 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 613CEC08A5
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jul 2020 07:10:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 4F1DD20487
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jul 2020 07:10:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id y7EmmANZHRoT for <iommu@lists.linux-foundation.org>;
 Thu,  9 Jul 2020 07:10:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by silver.osuosl.org (Postfix) with ESMTPS id C9FF522268
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jul 2020 07:10:16 +0000 (UTC)
IronPort-SDR: ZsFbpKm+/XXYpOY6cz11aySJHEdZJ4adkoZ+7VqwoMaN+fCfKBhMgVfhdHH9iUOGM+4FEhmn2W
 zs2f9mIeDlHg==
X-IronPort-AV: E=McAfee;i="6000,8403,9676"; a="136178173"
X-IronPort-AV: E=Sophos;i="5.75,331,1589266800"; d="scan'208";a="136178173"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2020 00:10:16 -0700
IronPort-SDR: gSJNJ4lHerAL0VOyfAiB4ahrn95XWSkCgs6gRGgMB+pLcgq4vyAfVdHw1R8K7/l4xd0ZqNS1uZ
 sAcHFigkEjiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,331,1589266800"; d="scan'208";a="316138834"
Received: from allen-box.sh.intel.com ([10.239.159.139])
 by fmsmga002.fm.intel.com with ESMTP; 09 Jul 2020 00:10:14 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: iommu@lists.linux-foundation.org
Subject: [PATCH v3 1/4] iommu/vt-d: Refactor device_to_iommu() helper
Date: Thu,  9 Jul 2020 15:05:34 +0800
Message-Id: <20200709070537.18473-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200709070537.18473-1-baolu.lu@linux.intel.com>
References: <20200709070537.18473-1-baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
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
index 2ce490c2eab8..4a6b6960fc32 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -778,16 +778,16 @@ is_downstream_to_pci_bridge(struct device *dev, struct device *bridge)
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
@@ -818,8 +818,10 @@ static struct intel_iommu *device_to_iommu(struct device *dev, u8 *bus, u8 *devf
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
 
@@ -829,8 +831,10 @@ static struct intel_iommu *device_to_iommu(struct device *dev, u8 *bus, u8 *devf
 
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
@@ -5146,11 +5150,10 @@ static int aux_domain_add_dev(struct dmar_domain *domain,
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
 
@@ -5236,9 +5239,8 @@ static int prepare_domain_attach_device(struct iommu_domain *domain,
 	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
 	struct intel_iommu *iommu;
 	int addr_width;
-	u8 bus, devfn;
 
-	iommu = device_to_iommu(dev, &bus, &devfn);
+	iommu = device_to_iommu(dev, NULL, NULL);
 	if (!iommu)
 		return -ENODEV;
 
@@ -5658,9 +5660,8 @@ static bool intel_iommu_capable(enum iommu_cap cap)
 static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 {
 	struct intel_iommu *iommu;
-	u8 bus, devfn;
 
-	iommu = device_to_iommu(dev, &bus, &devfn);
+	iommu = device_to_iommu(dev, NULL, NULL);
 	if (!iommu)
 		return ERR_PTR(-ENODEV);
 
@@ -5673,9 +5674,8 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 static void intel_iommu_release_device(struct device *dev)
 {
 	struct intel_iommu *iommu;
-	u8 bus, devfn;
 
-	iommu = device_to_iommu(dev, &bus, &devfn);
+	iommu = device_to_iommu(dev, NULL, NULL);
 	if (!iommu)
 		return;
 
@@ -5825,37 +5825,14 @@ static struct iommu_group *intel_iommu_device_group(struct device *dev)
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
index 6c87c807a0ab..25dd74f27252 100644
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
@@ -373,7 +373,7 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
 
 int intel_svm_unbind_gpasid(struct device *dev, int pasid)
 {
-	struct intel_iommu *iommu = intel_svm_device_to_iommu(dev);
+	struct intel_iommu *iommu = device_to_iommu(dev, NULL, NULL);
 	struct intel_svm_dev *sdev;
 	struct intel_svm *svm;
 	int ret = -EINVAL;
@@ -430,7 +430,7 @@ static int
 intel_svm_bind_mm(struct device *dev, int flags, struct svm_dev_ops *ops,
 		  struct mm_struct *mm, struct intel_svm_dev **sd)
 {
-	struct intel_iommu *iommu = intel_svm_device_to_iommu(dev);
+	struct intel_iommu *iommu = device_to_iommu(dev, NULL, NULL);
 	struct device_domain_info *info;
 	struct intel_svm_dev *sdev;
 	struct intel_svm *svm = NULL;
@@ -608,7 +608,7 @@ static int intel_svm_unbind_mm(struct device *dev, int pasid)
 	struct intel_svm *svm;
 	int ret = -EINVAL;
 
-	iommu = intel_svm_device_to_iommu(dev);
+	iommu = device_to_iommu(dev, NULL, NULL);
 	if (!iommu)
 		goto out;
 
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 3e8fa1c7a1e6..fc2cfc3db6e1 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -728,6 +728,7 @@ void iommu_flush_write_buffer(struct intel_iommu *iommu);
 int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct device *dev);
 struct dmar_domain *find_domain(struct device *dev);
 struct device_domain_info *get_domain_info(struct device *dev);
+struct intel_iommu *device_to_iommu(struct device *dev, u8 *bus, u8 *devfn);
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
 extern void intel_svm_check(struct intel_iommu *iommu);
@@ -766,8 +767,6 @@ struct intel_svm {
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
