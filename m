Return-Path: <SRS0=fUNI=5K=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F9EAC2D0E7
	for <iommu@archiver.kernel.org>; Wed, 25 Mar 2020 17:49:59 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 458712077D
	for <iommu@archiver.kernel.org>; Wed, 25 Mar 2020 17:49:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 458712077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2A04D86D26;
	Wed, 25 Mar 2020 17:49:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dlSLpBUE5oba; Wed, 25 Mar 2020 17:49:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6E2FE86D80;
	Wed, 25 Mar 2020 17:49:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5D05BC1D7C;
	Wed, 25 Mar 2020 17:49:55 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 261F0C0177
 for <iommu@lists.linux-foundation.org>; Wed, 25 Mar 2020 17:49:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 11484203C8
 for <iommu@lists.linux-foundation.org>; Wed, 25 Mar 2020 17:49:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BjJrhNpHbpy4 for <iommu@lists.linux-foundation.org>;
 Wed, 25 Mar 2020 17:49:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by silver.osuosl.org (Postfix) with ESMTPS id 3C4DC20416
 for <iommu@lists.linux-foundation.org>; Wed, 25 Mar 2020 17:49:50 +0000 (UTC)
IronPort-SDR: bhmc10PKFwCJeHwABbwTlOMWi6j2VTfWHrWHZVen+YGSN481w25jWmCaSQBboxLEO2KjlAgr3X
 T35JpKD33rCg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2020 10:49:49 -0700
IronPort-SDR: 1+YANSLLV374xiq6lk/dJ8fY/SL1DEs+8AaEHdzAxY1YSS60j4C2mosuJhvt+JPLqabOk9WPqs
 53XQ8/sWchgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,305,1580803200"; d="scan'208";a="393702207"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
 by orsmga004.jf.intel.com with ESMTP; 25 Mar 2020 10:49:48 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Lu Baolu" <baolu.lu@linux.intel.com>, iommu@lists.linux-foundation.org,
 LKML <linux-kernel@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
Subject: [PATCH 06/10] iommu/ioasid: Convert to set aware allocations
Date: Wed, 25 Mar 2020 10:55:27 -0700
Message-Id: <1585158931-1825-7-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585158931-1825-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1585158931-1825-1-git-send-email-jacob.jun.pan@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 Jonathan Cameron <jic23@kernel.org>
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

The current ioasid_alloc function takes a token/ioasid_set then record it
on the IOASID being allocated. There is no alloc/free on the ioasid_set.

With the IOASID set APIs, callers must allocate an ioasid_set before
allocate IOASIDs within the set. Quota and other ioasid_set level
activities can then be enforced.

This patch converts existing API to the new ioasid_set model.

Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 10 +++---
 drivers/iommu/intel-svm.c   | 10 +++---
 drivers/iommu/ioasid.c      | 78 +++++++++++++++++++++++++++++++++------------
 include/linux/ioasid.h      | 11 +++----
 4 files changed, 72 insertions(+), 37 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index af7a1ef7b31e..c571cc8d9e57 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3323,11 +3323,11 @@ static void intel_ioasid_free(ioasid_t ioasid, void *data)
 	if (!iommu)
 		return;
 	/*
-	 * Sanity check the ioasid owner is done at upper layer, e.g. VFIO
-	 * We can only free the PASID when all the devices are unbound.
+	 * In the guest, all IOASIDs belong to the system_ioasid set.
+	 * Sanity check against the system set.
 	 */
-	if (ioasid_find(NULL, ioasid, NULL)) {
-		pr_alert("Cannot free active IOASID %d\n", ioasid);
+	if (IS_ERR(ioasid_find(system_ioasid_sid, ioasid, NULL))) {
+		pr_err("Cannot free IOASID %d, not in system set\n", ioasid);
 		return;
 	}
 	vcmd_free_pasid(iommu, ioasid);
@@ -5541,7 +5541,7 @@ static int aux_domain_add_dev(struct dmar_domain *domain,
 		int pasid;
 
 		/* No private data needed for the default pasid */
-		pasid = ioasid_alloc(NULL, PASID_MIN,
+		pasid = ioasid_alloc(system_ioasid_sid, PASID_MIN,
 				     pci_max_pasids(to_pci_dev(dev)) - 1,
 				     NULL);
 		if (pasid == INVALID_IOASID) {
diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index 1991587fd3fd..f511855d187b 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -268,7 +268,7 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain,
 	}
 
 	mutex_lock(&pasid_mutex);
-	svm = ioasid_find(NULL, data->hpasid, NULL);
+	svm = ioasid_find(INVALID_IOASID_SET, data->hpasid, NULL);
 	if (IS_ERR(svm)) {
 		ret = PTR_ERR(svm);
 		goto out;
@@ -401,7 +401,7 @@ int intel_svm_unbind_gpasid(struct device *dev, int pasid)
 		return -EINVAL;
 
 	mutex_lock(&pasid_mutex);
-	svm = ioasid_find(NULL, pasid, NULL);
+	svm = ioasid_find(INVALID_IOASID_SET, pasid, NULL);
 	if (!svm) {
 		ret = -EINVAL;
 		goto out;
@@ -559,7 +559,7 @@ static int intel_svm_bind_mm(struct device *dev, int flags, struct svm_dev_ops *
 			pasid_max = intel_pasid_max_id;
 
 		/* Do not use PASID 0, reserved for RID to PASID */
-		svm->pasid = ioasid_alloc(NULL, PASID_MIN,
+		svm->pasid = ioasid_alloc(system_ioasid_sid, PASID_MIN,
 					  pasid_max - 1, svm);
 		if (svm->pasid == INVALID_IOASID) {
 			kfree(svm);
@@ -642,7 +642,7 @@ int intel_svm_unbind_mm(struct device *dev, int pasid)
 	if (!iommu)
 		goto out;
 
-	svm = ioasid_find(NULL, pasid, NULL);
+	svm = ioasid_find(system_ioasid_sid, pasid, NULL);
 	if (!svm)
 		goto out;
 
@@ -778,7 +778,7 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 
 		if (!svm || svm->pasid != req->pasid) {
 			rcu_read_lock();
-			svm = ioasid_find(NULL, req->pasid, NULL);
+			svm = ioasid_find(INVALID_IOASID_SET, req->pasid, NULL);
 			/* It *can't* go away, because the driver is not permitted
 			 * to unbind the mm while any page faults are outstanding.
 			 * So we only need RCU to protect the internal idr code. */
diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
index 9135af171a7c..f89a595f6978 100644
--- a/drivers/iommu/ioasid.c
+++ b/drivers/iommu/ioasid.c
@@ -31,7 +31,7 @@ struct ioasid_set_data {
 
 struct ioasid_data {
 	ioasid_t id;
-	struct ioasid_set *set;
+	struct ioasid_set_data *sdata;
 	void *private;
 	struct rcu_head rcu;
 };
@@ -334,7 +334,7 @@ EXPORT_SYMBOL_GPL(ioasid_attach_data);
 
 /**
  * ioasid_alloc - Allocate an IOASID
- * @set: the IOASID set
+ * @sid: the IOASID set ID
  * @min: the minimum ID (inclusive)
  * @max: the maximum ID (inclusive)
  * @private: data private to the caller
@@ -344,18 +344,30 @@ EXPORT_SYMBOL_GPL(ioasid_attach_data);
  *
  * Return: the allocated ID on success, or %INVALID_IOASID on failure.
  */
-ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
-		      void *private)
+ioasid_t ioasid_alloc(int sid, ioasid_t min, ioasid_t max, void *private)
 {
+	struct ioasid_set_data *sdata;
 	struct ioasid_data *data;
 	void *adata;
 	ioasid_t id;
 
-	data = kzalloc(sizeof(*data), GFP_ATOMIC);
+	/* Check if the IOASID set has been allocated and initialized */
+	sdata = xa_load(&ioasid_sets, sid);
+	if (!sdata) {
+		pr_err("Invalid IOASID set %d to allocate from\n", sid);
+		return INVALID_IOASID;
+	}
+
+	if (sdata->size <= sdata->nr_ioasids) {
+		pr_err("IOASID set %d out of quota\n", sid);
+		return INVALID_IOASID;
+	}
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return INVALID_IOASID;
 
-	data->set = set;
+	data->sdata = sdata;
 	data->private = private;
 
 	/*
@@ -379,6 +391,9 @@ ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
 	}
 	data->id = id;
 
+	/* Store IOASID in the per set data */
+	xa_store(&sdata->xa, id, data, GFP_KERNEL);
+	sdata->nr_ioasids++;
 	spin_unlock(&ioasid_allocator_lock);
 	return id;
 exit_free:
@@ -388,19 +403,15 @@ ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
 }
 EXPORT_SYMBOL_GPL(ioasid_alloc);
 
-/**
- * ioasid_free - Free an IOASID
- * @ioasid: the ID to remove
- */
-void ioasid_free(ioasid_t ioasid)
+static void ioasid_free_locked(ioasid_t ioasid)
 {
 	struct ioasid_data *ioasid_data;
+	struct ioasid_set_data *sdata;
 
-	spin_lock(&ioasid_allocator_lock);
 	ioasid_data = xa_load(&active_allocator->xa, ioasid);
 	if (!ioasid_data) {
 		pr_err("Trying to free unknown IOASID %u\n", ioasid);
-		goto exit_unlock;
+		return;
 	}
 
 	active_allocator->ops->free(ioasid, active_allocator->ops->pdata);
@@ -410,7 +421,27 @@ void ioasid_free(ioasid_t ioasid)
 		kfree_rcu(ioasid_data, rcu);
 	}
 
-exit_unlock:
+	sdata = xa_load(&ioasid_sets, ioasid_data->sdata->sid);
+	if (!sdata) {
+		pr_err("No set %d for IOASID %d\n", ioasid_data->sdata->sid,
+		       ioasid);
+		return;
+	}
+	xa_erase(&sdata->xa, ioasid);
+	sdata->nr_ioasids--;
+}
+
+/**
+ * ioasid_free - Free an IOASID and notify users who registered a notifier
+ *               on the IOASID set.
+ *               IOASID can be re-allocated upon return
+ *
+ * @ioasid: the ID to remove
+ */
+void ioasid_free(ioasid_t ioasid)
+{
+	spin_lock(&ioasid_allocator_lock);
+	ioasid_free_locked(ioasid);
 	spin_unlock(&ioasid_allocator_lock);
 }
 EXPORT_SYMBOL_GPL(ioasid_free);
@@ -499,8 +530,12 @@ void ioasid_free_set(int sid, bool destroy_set)
 		goto done_destroy;
 	}
 
-	/* Just a place holder for now */
 	xa_for_each(&sdata->xa, index, entry) {
+		/*
+		 * Free from system-wide IOASID pool, all subscribers gets
+		 * notified and do cleanup.
+		 */
+		ioasid_free_locked(index);
 		/* Free from per sub-set pool */
 		xa_erase(&sdata->xa, index);
 	}
@@ -508,7 +543,6 @@ void ioasid_free_set(int sid, bool destroy_set)
 done_destroy:
 	if (destroy_set) {
 		xa_erase(&ioasid_sets, sid);
-
 		/* Return the quota back to system pool */
 		ioasid_capacity_avail += sdata->size;
 		kfree_rcu(sdata, rcu);
@@ -522,7 +556,7 @@ EXPORT_SYMBOL_GPL(ioasid_free_set);
 
 /**
  * ioasid_find - Find IOASID data
- * @set: the IOASID set
+ * @sid: the IOASID set ID
  * @ioasid: the IOASID to find
  * @getter: function to call on the found object
  *
@@ -532,10 +566,12 @@ EXPORT_SYMBOL_GPL(ioasid_free_set);
  *
  * If the IOASID exists, return the private pointer passed to ioasid_alloc.
  * Private data can be NULL if not set. Return an error if the IOASID is not
- * found, or if @set is not NULL and the IOASID does not belong to the set.
+ * found.
+ *
+ * If sid is INVALID_IOASID_SET, it will skip set ownership checking. Otherwise,
+ * error is returned even if the IOASID is found but does not belong the set.
  */
-void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
-		  bool (*getter)(void *))
+void *ioasid_find(int sid, ioasid_t ioasid, bool (*getter)(void *))
 {
 	void *priv;
 	struct ioasid_data *ioasid_data;
@@ -548,7 +584,7 @@ void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
 		priv = ERR_PTR(-ENOENT);
 		goto unlock;
 	}
-	if (set && ioasid_data->set != set) {
+	if (sid != INVALID_IOASID_SET && ioasid_data->sdata->sid != sid) {
 		/* data found but does not belong to the set */
 		priv = ERR_PTR(-EACCES);
 		goto unlock;
diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
index 097b1cc043a3..e19c0ad93bd7 100644
--- a/include/linux/ioasid.h
+++ b/include/linux/ioasid.h
@@ -6,6 +6,7 @@
 #include <linux/errno.h>
 
 #define INVALID_IOASID ((ioasid_t)-1)
+#define INVALID_IOASID_SET (-1)
 typedef unsigned int ioasid_t;
 typedef ioasid_t (*ioasid_alloc_fn_t)(ioasid_t min, ioasid_t max, void *data);
 typedef void (*ioasid_free_fn_t)(ioasid_t ioasid, void *data);
@@ -35,11 +36,10 @@ extern int system_ioasid_sid;
 #define DECLARE_IOASID_SET(name) struct ioasid_set name = { 0 }
 
 #if IS_ENABLED(CONFIG_IOASID)
-ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
+ioasid_t ioasid_alloc(int sid, ioasid_t min, ioasid_t max,
 		      void *private);
 void ioasid_free(ioasid_t ioasid);
-void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
-		  bool (*getter)(void *));
+void *ioasid_find(int sid, ioasid_t ioasid, bool (*getter)(void *));
 int ioasid_register_allocator(struct ioasid_allocator_ops *allocator);
 void ioasid_unregister_allocator(struct ioasid_allocator_ops *allocator);
 int ioasid_attach_data(ioasid_t ioasid, void *data);
@@ -49,7 +49,7 @@ int ioasid_alloc_set(struct ioasid_set *token, ioasid_t quota, int *sid);
 void ioasid_free_set(int sid, bool destroy_set);
 int ioasid_find_sid(ioasid_t ioasid);
 #else /* !CONFIG_IOASID */
-static inline ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min,
+static inline ioasid_t ioasid_alloc(int sid, ioasid_t min,
 				    ioasid_t max, void *private)
 {
 	return INVALID_IOASID;
@@ -68,8 +68,7 @@ static inline void ioasid_free_set(int sid, bool destroy_set)
 {
 }
 
-static inline void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
-				bool (*getter)(void *))
+static inline void *ioasid_find(int sid, ioasid_t ioasid, bool (*getter)(void *))
 {
 	return NULL;
 }
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
