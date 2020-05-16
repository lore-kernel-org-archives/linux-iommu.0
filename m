Return-Path: <SRS0=RRah=66=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 329C2C433E1
	for <iommu@archiver.kernel.org>; Sat, 16 May 2020 06:24:45 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0644020709
	for <iommu@archiver.kernel.org>; Sat, 16 May 2020 06:24:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0644020709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id DB7FC898C0;
	Sat, 16 May 2020 06:24:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rQ2xHtLsu77R; Sat, 16 May 2020 06:24:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id BA61D898C5;
	Sat, 16 May 2020 06:24:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A7767C088E;
	Sat, 16 May 2020 06:24:43 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EC356C016F
 for <iommu@lists.linux-foundation.org>; Sat, 16 May 2020 06:24:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id E8CA987E33
 for <iommu@lists.linux-foundation.org>; Sat, 16 May 2020 06:24:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tePUBS42EjDV for <iommu@lists.linux-foundation.org>;
 Sat, 16 May 2020 06:24:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id BA6F587E34
 for <iommu@lists.linux-foundation.org>; Sat, 16 May 2020 06:24:40 +0000 (UTC)
IronPort-SDR: Kkag/YCe83crNpGYDhlYqxYmai058VhjOUY6al15cjLAVHu9F2Lua97Y57ksDkyp42YC56aiUp
 6eHCBzbdpL1g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2020 23:24:40 -0700
IronPort-SDR: V2emez/zc9aIlYyMrNm7l7miGk7ZvDkiA5cHCfilhPfQmZfQkqrK1epovUyq0VMeGNl3WEJEB4
 oIaVin3AfNCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,398,1583222400"; d="scan'208";a="281442406"
Received: from allen-box.sh.intel.com ([10.239.159.139])
 by orsmga002.jf.intel.com with ESMTP; 15 May 2020 23:24:38 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 04/18] iommu/vt-d: Add bind guest PASID support
Date: Sat, 16 May 2020 14:20:47 +0800
Message-Id: <20200516062101.29541-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200516062101.29541-1-baolu.lu@linux.intel.com>
References: <20200516062101.29541-1-baolu.lu@linux.intel.com>
Cc: iommu@lists.linux-foundation.org, Tom Murphy <murphyt7@tcd.ie>
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

From: Jacob Pan <jacob.jun.pan@linux.intel.com>

When supporting guest SVA with emulated IOMMU, the guest PASID
table is shadowed in VMM. Updates to guest vIOMMU PASID table
will result in PASID cache flush which will be passed down to
the host as bind guest PASID calls.

For the SL page tables, it will be harvested from device's
default domain (request w/o PASID), or aux domain in case of
mediated device.

    .-------------.  .---------------------------.
    |   vIOMMU    |  | Guest process CR3, FL only|
    |             |  '---------------------------'
    .----------------/
    | PASID Entry |--- PASID cache flush -
    '-------------'                       |
    |             |                       V
    |             |                CR3 in GPA
    '-------------'
Guest
------| Shadow |--------------------------|--------
      v        v                          v
Host
    .-------------.  .----------------------.
    |   pIOMMU    |  | Bind FL for GVA-GPA  |
    |             |  '----------------------'
    .----------------/  |
    | PASID Entry |     V (Nested xlate)
    '----------------\.------------------------------.
    |             |   |SL for GPA-HPA, default domain|
    |             |   '------------------------------'
    '-------------'
Where:
 - FL = First level/stage one page tables
 - SL = Second level/stage two page tables

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c |   4 +
 drivers/iommu/intel-svm.c   | 200 ++++++++++++++++++++++++++++++++++++
 include/linux/intel-iommu.h |   6 +-
 include/linux/intel-svm.h   |  12 +++
 4 files changed, 221 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 7e85c09eec71..f42c548f8421 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5780,6 +5780,10 @@ const struct iommu_ops intel_iommu_ops = {
 	.is_attach_deferred	= intel_iommu_is_attach_deferred,
 	.def_domain_type	= device_def_domain_type,
 	.pgsize_bitmap		= INTEL_IOMMU_PGSIZES,
+#ifdef CONFIG_INTEL_IOMMU_SVM
+	.sva_bind_gpasid	= intel_svm_bind_gpasid,
+	.sva_unbind_gpasid	= intel_svm_unbind_gpasid,
+#endif
 };
 
 static void quirk_iommu_igfx(struct pci_dev *dev)
diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index 2998418f0a38..7d3405c5a198 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -226,6 +226,206 @@ static LIST_HEAD(global_svm_list);
 	list_for_each_entry((sdev), &(svm)->devs, list)	\
 		if ((d) != (sdev)->dev) {} else
 
+int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
+			  struct iommu_gpasid_bind_data *data)
+{
+	struct intel_iommu *iommu = intel_svm_device_to_iommu(dev);
+	struct dmar_domain *dmar_domain;
+	struct intel_svm_dev *sdev;
+	struct intel_svm *svm;
+	int ret = 0;
+
+	if (WARN_ON(!iommu) || !data)
+		return -EINVAL;
+
+	if (data->version != IOMMU_GPASID_BIND_VERSION_1 ||
+	    data->format != IOMMU_PASID_FORMAT_INTEL_VTD)
+		return -EINVAL;
+
+	if (!dev_is_pci(dev))
+		return -ENOTSUPP;
+
+	/* VT-d supports devices with full 20 bit PASIDs only */
+	if (pci_max_pasids(to_pci_dev(dev)) != PASID_MAX)
+		return -EINVAL;
+
+	/*
+	 * We only check host PASID range, we have no knowledge to check
+	 * guest PASID range.
+	 */
+	if (data->hpasid <= 0 || data->hpasid >= PASID_MAX)
+		return -EINVAL;
+
+	dmar_domain = to_dmar_domain(domain);
+
+	mutex_lock(&pasid_mutex);
+	svm = ioasid_find(NULL, data->hpasid, NULL);
+	if (IS_ERR(svm)) {
+		ret = PTR_ERR(svm);
+		goto out;
+	}
+
+	if (svm) {
+		/*
+		 * If we found svm for the PASID, there must be at
+		 * least one device bond, otherwise svm should be freed.
+		 */
+		if (WARN_ON(list_empty(&svm->devs))) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		for_each_svm_dev(sdev, svm, dev) {
+			/*
+			 * For devices with aux domains, we should allow
+			 * multiple bind calls with the same PASID and pdev.
+			 */
+			if (iommu_dev_feature_enabled(dev,
+						      IOMMU_DEV_FEAT_AUX)) {
+				sdev->users++;
+			} else {
+				dev_warn_ratelimited(dev,
+						     "Already bound with PASID %u\n",
+						     svm->pasid);
+				ret = -EBUSY;
+			}
+			goto out;
+		}
+	} else {
+		/* We come here when PASID has never been bond to a device. */
+		svm = kzalloc(sizeof(*svm), GFP_KERNEL);
+		if (!svm) {
+			ret = -ENOMEM;
+			goto out;
+		}
+		/* REVISIT: upper layer/VFIO can track host process that bind
+		 * the PASID. ioasid_set = mm might be sufficient for vfio to
+		 * check pasid VMM ownership. We can drop the following line
+		 * once VFIO and IOASID set check is in place.
+		 */
+		svm->mm = get_task_mm(current);
+		svm->pasid = data->hpasid;
+		if (data->flags & IOMMU_SVA_GPASID_VAL) {
+			svm->gpasid = data->gpasid;
+			svm->flags |= SVM_FLAG_GUEST_PASID;
+		}
+		ioasid_set_data(data->hpasid, svm);
+		INIT_LIST_HEAD_RCU(&svm->devs);
+		mmput(svm->mm);
+	}
+	sdev = kzalloc(sizeof(*sdev), GFP_KERNEL);
+	if (!sdev) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	sdev->dev = dev;
+
+	/* Only count users if device has aux domains */
+	if (iommu_dev_feature_enabled(dev, IOMMU_DEV_FEAT_AUX))
+		sdev->users = 1;
+
+	/* Set up device context entry for PASID if not enabled already */
+	ret = intel_iommu_enable_pasid(iommu, sdev->dev);
+	if (ret) {
+		dev_err_ratelimited(dev, "Failed to enable PASID capability\n");
+		kfree(sdev);
+		goto out;
+	}
+
+	/*
+	 * PASID table is per device for better security. Therefore, for
+	 * each bind of a new device even with an existing PASID, we need to
+	 * call the nested mode setup function here.
+	 */
+	spin_lock(&iommu->lock);
+	ret = intel_pasid_setup_nested(iommu, dev, (pgd_t *)data->gpgd,
+				       data->hpasid, &data->vtd, dmar_domain,
+				       data->addr_width);
+	spin_unlock(&iommu->lock);
+	if (ret) {
+		dev_err_ratelimited(dev, "Failed to set up PASID %llu in nested mode, Err %d\n",
+				    data->hpasid, ret);
+		/*
+		 * PASID entry should be in cleared state if nested mode
+		 * set up failed. So we only need to clear IOASID tracking
+		 * data such that free call will succeed.
+		 */
+		kfree(sdev);
+		goto out;
+	}
+
+	svm->flags |= SVM_FLAG_GUEST_MODE;
+
+	init_rcu_head(&sdev->rcu);
+	list_add_rcu(&sdev->list, &svm->devs);
+ out:
+	if (!IS_ERR_OR_NULL(svm) && list_empty(&svm->devs)) {
+		ioasid_set_data(data->hpasid, NULL);
+		kfree(svm);
+	}
+
+	mutex_unlock(&pasid_mutex);
+	return ret;
+}
+
+int intel_svm_unbind_gpasid(struct device *dev, int pasid)
+{
+	struct intel_iommu *iommu = intel_svm_device_to_iommu(dev);
+	struct intel_svm_dev *sdev;
+	struct intel_svm *svm;
+	int ret = -EINVAL;
+
+	if (WARN_ON(!iommu))
+		return -EINVAL;
+
+	mutex_lock(&pasid_mutex);
+	svm = ioasid_find(NULL, pasid, NULL);
+	if (!svm) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (IS_ERR(svm)) {
+		ret = PTR_ERR(svm);
+		goto out;
+	}
+
+	for_each_svm_dev(sdev, svm, dev) {
+		ret = 0;
+		if (iommu_dev_feature_enabled(dev, IOMMU_DEV_FEAT_AUX))
+			sdev->users--;
+		if (!sdev->users) {
+			list_del_rcu(&sdev->list);
+			intel_pasid_tear_down_entry(iommu, dev, svm->pasid);
+			intel_flush_svm_range_dev(svm, sdev, 0, -1, 0);
+			/* TODO: Drain in flight PRQ for the PASID since it
+			 * may get reused soon, we don't want to
+			 * confuse with its previous life.
+			 * intel_svm_drain_prq(dev, pasid);
+			 */
+			kfree_rcu(sdev, rcu);
+
+			if (list_empty(&svm->devs)) {
+				/*
+				 * We do not free the IOASID here in that
+				 * IOMMU driver did not allocate it.
+				 * Unlike native SVM, IOASID for guest use was
+				 * allocated prior to the bind call.
+				 * In any case, if the free call comes before
+				 * the unbind, IOMMU driver will get notified
+				 * and perform cleanup.
+				 */
+				ioasid_set_data(pasid, NULL);
+				kfree(svm);
+			}
+		}
+		break;
+	}
+out:
+	mutex_unlock(&pasid_mutex);
+	return ret;
+}
+
 int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_ops *ops)
 {
 	struct intel_iommu *iommu = intel_svm_device_to_iommu(dev);
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index e0d1fed7cbe4..3dfd426dfb03 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -698,7 +698,9 @@ struct dmar_domain *find_domain(struct device *dev);
 extern void intel_svm_check(struct intel_iommu *iommu);
 extern int intel_svm_enable_prq(struct intel_iommu *iommu);
 extern int intel_svm_finish_prq(struct intel_iommu *iommu);
-
+int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
+			  struct iommu_gpasid_bind_data *data);
+int intel_svm_unbind_gpasid(struct device *dev, int pasid);
 struct svm_dev_ops;
 
 struct intel_svm_dev {
@@ -715,9 +717,11 @@ struct intel_svm_dev {
 struct intel_svm {
 	struct mmu_notifier notifier;
 	struct mm_struct *mm;
+
 	struct intel_iommu *iommu;
 	int flags;
 	int pasid;
+	int gpasid; /* In case that guest PASID is different from host PASID */
 	struct list_head devs;
 	struct list_head list;
 };
diff --git a/include/linux/intel-svm.h b/include/linux/intel-svm.h
index d7c403d0dd27..1b47ca46373e 100644
--- a/include/linux/intel-svm.h
+++ b/include/linux/intel-svm.h
@@ -44,6 +44,18 @@ struct svm_dev_ops {
  * do such IOTLB flushes automatically.
  */
 #define SVM_FLAG_SUPERVISOR_MODE	(1<<1)
+/*
+ * The SVM_FLAG_GUEST_MODE flag is used when a PASID bind is for guest
+ * processes. Compared to the host bind, the primary differences are:
+ * 1. mm life cycle management
+ * 2. fault reporting
+ */
+#define SVM_FLAG_GUEST_MODE		(1<<2)
+/*
+ * The SVM_FLAG_GUEST_PASID flag is used when a guest has its own PASID space,
+ * which requires guest and host PASID translation at both directions.
+ */
+#define SVM_FLAG_GUEST_PASID		(1<<3)
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
 
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
