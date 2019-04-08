Return-Path: <SRS0=6I1K=SK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6679C282CE
	for <iommu@archiver.kernel.org>; Mon,  8 Apr 2019 23:58:32 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A630E20863
	for <iommu@archiver.kernel.org>; Mon,  8 Apr 2019 23:58:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A630E20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id AEC9EDB6;
	Mon,  8 Apr 2019 23:57:15 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 76898CD5
	for <iommu@lists.linux-foundation.org>;
	Mon,  8 Apr 2019 23:57:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id A34BA76D
	for <iommu@lists.linux-foundation.org>;
	Mon,  8 Apr 2019 23:57:11 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	08 Apr 2019 16:57:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,327,1549958400"; d="scan'208";a="149169985"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
	by orsmga002.jf.intel.com with ESMTP; 08 Apr 2019 16:57:08 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: [PATCH 15/18] iommu/vt-d: Add bind guest PASID support
Date: Mon,  8 Apr 2019 16:59:30 -0700
Message-Id:
 <1554767973-30125-16-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554767973-30125-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1554767973-30125-1-git-send-email-jacob.jun.pan@linux.intel.com>
Cc: Yi L <yi.l.liu@linux.intel.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	Raj Ashok <ashok.raj@intel.com>, Liu@mail.linuxfoundation.org,
	Andriy Shevchenko <andriy.shevchenko@linux.intel.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190408235930.RGdSl3MO58oRFcqBUq56zN21aBFARGYmZhRYT3GaGiI@z>

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
Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c |   4 +
 drivers/iommu/intel-svm.c   | 176 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/intel-iommu.h |  10 ++-
 include/linux/intel-svm.h   |   7 ++
 4 files changed, 195 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 6d3d426..d43b87d 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5446,6 +5446,10 @@ const struct iommu_ops intel_iommu_ops = {
 	.put_resv_regions	= intel_iommu_put_resv_regions,
 	.device_group		= pci_device_group,
 	.pgsize_bitmap		= INTEL_IOMMU_PGSIZES,
+#ifdef CONFIG_INTEL_IOMMU_SVM
+	.sva_bind_gpasid	= intel_svm_bind_gpasid,
+	.sva_unbind_gpasid	= intel_svm_unbind_gpasid,
+#endif
 };
 
 static void quirk_iommu_g4x_gfx(struct pci_dev *dev)
diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index 595ea0a..e304fdb 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -228,6 +228,182 @@ static const struct mmu_notifier_ops intel_mmuops = {
 static DEFINE_MUTEX(pasid_mutex);
 static LIST_HEAD(global_svm_list);
 
+int intel_svm_bind_gpasid(struct iommu_domain *domain,
+			struct device *dev,
+			struct gpasid_bind_data *data)
+{
+	struct intel_iommu *iommu = intel_svm_device_to_iommu(dev);
+	struct intel_svm_dev *sdev;
+	struct intel_svm *svm = NULL;
+	struct dmar_domain *ddomain;
+	int pasid_max;
+	int ret = 0;
+
+	if (WARN_ON(!iommu) || !data)
+		return -EINVAL;
+
+	if (dev_is_pci(dev)) {
+		pasid_max = pci_max_pasids(to_pci_dev(dev));
+		if (pasid_max < 0)
+			return -EINVAL;
+	} else
+		pasid_max = 1 << 20;
+
+	if (data->pasid <= 0 || data->pasid >= pasid_max)
+		return -EINVAL;
+
+	ddomain = to_dmar_domain(domain);
+	/* REVISIT:
+	 * Sanity check adddress width and paging mode support
+	 * width matching in two dimensions:
+	 * 1. paging mode CPU <= IOMMU
+	 * 2. address width Guest <= Host.
+	 */
+	mutex_lock(&pasid_mutex);
+	svm = ioasid_find(NULL, data->pasid, NULL);
+	if (IS_ERR(svm)) {
+		ret = PTR_ERR(svm);
+		goto out;
+	}
+	if (svm) {
+		if (list_empty(&svm->devs)) {
+			dev_err(dev, "GPASID %d has no devices bond but SVA is allocated\n",
+				data->pasid);
+			ret = -ENODEV; /*
+					* If we found svm for the PASID, there must be at
+					* least one device bond, otherwise svm should be freed.
+					*/
+			goto out;
+		}
+
+		list_for_each_entry(sdev, &svm->devs, list) {
+			if (dev == sdev->dev) {
+				/* In case of multiple sub-devices of the same pdev assigned, we should
+				 * allow multiple bind calls with the same PASID and pdev.
+				 */
+				sdev->users++;
+				goto out;
+			}
+		}
+	} else {
+		/* We come here when PASID has never been bond to a device. */
+		svm = kzalloc(sizeof(*svm), GFP_KERNEL);
+		if (!svm) {
+			ret = -ENOMEM;
+			goto out;
+		}
+		/* REVISIT: upper layer/VFIO can track host process that bind the PASID.
+		 * ioasid_set = mm might be sufficient for vfio to check pasid VMM
+		 * ownership.
+		 */
+		svm->mm = get_task_mm(current);
+		svm->pasid = data->pasid;
+		refcount_set(&svm->refs, 0);
+		ioasid_set_data(data->pasid, svm);
+		INIT_LIST_HEAD_RCU(&svm->devs);
+		INIT_LIST_HEAD(&svm->list);
+
+		mmput(svm->mm);
+	}
+	svm->flags |= SVM_FLAG_GUEST_MODE;
+	sdev = kzalloc(sizeof(*sdev), GFP_KERNEL);
+	if (!sdev) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	sdev->dev = dev;
+	sdev->users = 1;
+
+	/* Set up device context entry for PASID if not enabled already */
+	ret = intel_iommu_enable_pasid(iommu, sdev);
+	if (ret) {
+		dev_err(dev, "Failed to enable PASID capability\n");
+		kfree(sdev);
+		goto out;
+	}
+
+	/*
+	 * For guest bind, we need to set up PASID table entry as follows:
+	 * - FLPM matches guest paging mode
+	 * - turn on nested mode
+	 * - SL guest address width matching
+	 */
+	ret = intel_pasid_setup_nested(iommu,
+				dev,
+				(pgd_t *)data->gcr3,
+				data->pasid,
+				data->flags,
+				ddomain,
+				data->addr_width);
+	if (ret) {
+		dev_err(dev, "Failed to set up PASID %d in nested mode, Err %d\n",
+			data->pasid, ret);
+		kfree(sdev);
+		goto out;
+	}
+
+	init_rcu_head(&sdev->rcu);
+	refcount_inc(&svm->refs);
+	list_add_rcu(&sdev->list, &svm->devs);
+ out:
+	mutex_unlock(&pasid_mutex);
+	return ret;
+}
+
+int intel_svm_unbind_gpasid(struct device *dev, int pasid)
+{
+	struct intel_svm_dev *sdev;
+	struct intel_iommu *iommu;
+	struct intel_svm *svm;
+	int ret = -EINVAL;
+
+	mutex_lock(&pasid_mutex);
+	iommu = intel_svm_device_to_iommu(dev);
+	if (!iommu)
+		goto out;
+
+	svm = ioasid_find(NULL, pasid, NULL);
+	if (IS_ERR(svm)) {
+		ret = PTR_ERR(svm);
+		goto out;
+	}
+
+	if (!svm)
+		goto out;
+
+	list_for_each_entry(sdev, &svm->devs, list) {
+		if (dev == sdev->dev) {
+			ret = 0;
+			sdev->users--;
+			if (!sdev->users) {
+				list_del_rcu(&sdev->list);
+				intel_pasid_tear_down_entry(iommu, dev, svm->pasid);
+				/* TODO: Drain in flight PRQ for the PASID since it
+				 * may get reused soon, we don't want to
+				 * confuse with its previous live.
+				 * intel_svm_drain_prq(dev, pasid);
+				 */
+				kfree_rcu(sdev, rcu);
+
+				if (list_empty(&svm->devs)) {
+					list_del(&svm->list);
+					kfree(svm);
+					/*
+					 * We do not free PASID here until explicit call
+					 * from the guest to free.
+					 */
+					ioasid_set_data(pasid, NULL);
+				}
+			}
+			break;
+		}
+	}
+ out:
+	mutex_unlock(&pasid_mutex);
+
+	return ret;
+}
+
 int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_ops *ops)
 {
 	struct intel_iommu *iommu = intel_svm_device_to_iommu(dev);
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 650cf98..29a615b 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -664,7 +664,9 @@ void iommu_flush_write_buffer(struct intel_iommu *iommu);
 int intel_svm_init(struct intel_iommu *iommu);
 extern int intel_svm_enable_prq(struct intel_iommu *iommu);
 extern int intel_svm_finish_prq(struct intel_iommu *iommu);
-
+extern int intel_svm_bind_gpasid(struct iommu_domain *domain,
+		struct device *dev, struct gpasid_bind_data *data);
+extern int intel_svm_unbind_gpasid(struct device *dev, int pasid);
 struct svm_dev_ops;
 
 struct intel_svm_dev {
@@ -680,12 +682,16 @@ struct intel_svm_dev {
 
 struct intel_svm {
 	struct mmu_notifier notifier;
-	struct mm_struct *mm;
+	union {
+		struct mm_struct *mm;
+		u64 gcr3;
+	};
 	struct intel_iommu *iommu;
 	int flags;
 	int pasid;
 	struct list_head devs;
 	struct list_head list;
+	refcount_t refs; /* # of devs bond to the PASID */
 };
 
 extern int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct intel_svm_dev *sdev);
diff --git a/include/linux/intel-svm.h b/include/linux/intel-svm.h
index e3f7631..34b0a3b 100644
--- a/include/linux/intel-svm.h
+++ b/include/linux/intel-svm.h
@@ -52,6 +52,13 @@ struct svm_dev_ops {
  * do such IOTLB flushes automatically.
  */
 #define SVM_FLAG_SUPERVISOR_MODE	(1<<1)
+/*
+ * The SVM_FLAG_GUEST_MODE flag is used when a guest process bind to a device.
+ * In this case the mm_struct is in the guest kernel or userspace, its life
+ * cycle is managed by VMM and VFIO layer. For IOMMU driver, this API provides
+ * means to bind/unbind guest CR3 with PASIDs allocated for a device.
+ */
+#define SVM_FLAG_GUEST_MODE	(1<<2)
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
 
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
