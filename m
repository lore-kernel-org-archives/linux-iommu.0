Return-Path: <SRS0=Pr8R=H6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E33C433E0
	for <iommu@archiver.kernel.org>; Sun, 28 Feb 2021 06:33:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2222D64E51
	for <iommu@archiver.kernel.org>; Sun, 28 Feb 2021 06:33:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2222D64E51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6EFA44F117;
	Sun, 28 Feb 2021 06:33:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 594DPacQacpb; Sun, 28 Feb 2021 06:33:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 68E144F0BC;
	Sun, 28 Feb 2021 06:33:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9DDA6C001D;
	Sun, 28 Feb 2021 06:33:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 21395C000E
 for <iommu@lists.linux-foundation.org>; Sun, 28 Feb 2021 06:33:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 807194F062
 for <iommu@lists.linux-foundation.org>; Sun, 28 Feb 2021 06:33:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FFKXD_dy_f1e for <iommu@lists.linux-foundation.org>;
 Sun, 28 Feb 2021 06:33:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 263DB4F078
 for <iommu@lists.linux-foundation.org>; Sun, 28 Feb 2021 06:33:11 +0000 (UTC)
IronPort-SDR: 5jafcyvdLH+CDZrj9isF1lFY+Vqbm7PCvu3vQZ7p4LX0q3tw45AO3AjpRXc2X+TVkkkwv5w2Dz
 x4Uqrvpl/F+Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9908"; a="183755899"
X-IronPort-AV: E=Sophos;i="5.81,211,1610438400"; d="scan'208";a="183755899"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Feb 2021 22:33:09 -0800
IronPort-SDR: wi+8gDcvTp+PYBd2kCqS1qKX1EMyAg50s+8OiqJ/CBjarsQbElQOz4f1VxZQtliU86DxIu04u5
 xk+d67aqFX2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,211,1610438400"; d="scan'208";a="517029703"
Received: from otc-wp-03.jf.intel.com ([10.54.39.79])
 by orsmga004.jf.intel.com with ESMTP; 27 Feb 2021 22:33:09 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
 "Lu Baolu" <baolu.lu@linux.intel.com>,
 David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux-foundation.org,
 cgroups@vger.kernel.org, Tejun Heo <tj@kernel.org>,
 Li Zefan <lizefan@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
Subject: [PATCH V4 03/18] iommu/ioasid: Add a separate function for detach data
Date: Sat, 27 Feb 2021 14:01:11 -0800
Message-Id: <1614463286-97618-4-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Raj Ashok <ashok.raj@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Alex Williamson <alex.williamson@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Wu Hao <hao.wu@intel.com>
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

IOASID private data can be cleared by ioasid_attach_data() with a NULL
data pointer. A common use case is for a caller to free the data
afterward. ioasid_attach_data() calls synchronize_rcu() before return
such that free data can be sure without outstanding readers.
However, since synchronize_rcu() may sleep, ioasid_attach_data() cannot
be used under spinlocks.

This patch adds ioasid_detach_data() as a separate API where
synchronize_rcu() is called only in this case. ioasid_attach_data() can
then be used under spinlocks. In addition, this change makes the API
symmetrical.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel/svm.c |  4 +--
 drivers/iommu/ioasid.c    | 54 +++++++++++++++++++++++++++++++--------
 include/linux/ioasid.h    |  5 +++-
 3 files changed, 50 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 0053df9edffc..68372a7eb8b5 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -425,7 +425,7 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
 	list_add_rcu(&sdev->list, &svm->devs);
  out:
 	if (!IS_ERR_OR_NULL(svm) && list_empty(&svm->devs)) {
-		ioasid_attach_data(data->hpasid, NULL);
+		ioasid_detach_data(data->hpasid);
 		kfree(svm);
 	}
 
@@ -468,7 +468,7 @@ int intel_svm_unbind_gpasid(struct device *dev, u32 pasid)
 				 * the unbind, IOMMU driver will get notified
 				 * and perform cleanup.
 				 */
-				ioasid_attach_data(pasid, NULL);
+				ioasid_detach_data(pasid);
 				kfree(svm);
 			}
 		}
diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
index eeadf4586e0a..4eb9b3dd1b85 100644
--- a/drivers/iommu/ioasid.c
+++ b/drivers/iommu/ioasid.c
@@ -273,23 +273,57 @@ int ioasid_attach_data(ioasid_t ioasid, void *data)
 
 	spin_lock(&ioasid_allocator_lock);
 	ioasid_data = xa_load(&active_allocator->xa, ioasid);
-	if (ioasid_data)
-		rcu_assign_pointer(ioasid_data->private, data);
-	else
+
+	if (!ioasid_data) {
 		ret = -ENOENT;
-	spin_unlock(&ioasid_allocator_lock);
+		goto done_unlock;
+	}
 
-	/*
-	 * Wait for readers to stop accessing the old private data, so the
-	 * caller can free it.
-	 */
-	if (!ret)
-		synchronize_rcu();
+	if (ioasid_data->private) {
+		ret = -EBUSY;
+		goto done_unlock;
+	}
+	rcu_assign_pointer(ioasid_data->private, data);
+
+done_unlock:
+	spin_unlock(&ioasid_allocator_lock);
 
 	return ret;
 }
 EXPORT_SYMBOL_GPL(ioasid_attach_data);
 
+/**
+ * ioasid_detach_data - Clear the private data of an ioasid
+ *
+ * @ioasid: the IOASIDD to clear private data
+ */
+void ioasid_detach_data(ioasid_t ioasid)
+{
+	struct ioasid_data *ioasid_data;
+
+	spin_lock(&ioasid_allocator_lock);
+	ioasid_data = xa_load(&active_allocator->xa, ioasid);
+
+	if (!ioasid_data) {
+		pr_warn("IOASID %u not found to detach data from\n", ioasid);
+		goto done_unlock;
+	}
+
+	if (ioasid_data->private) {
+		rcu_assign_pointer(ioasid_data->private, NULL);
+		goto done_unlock;
+	}
+
+done_unlock:
+	spin_unlock(&ioasid_allocator_lock);
+	/*
+	 * Wait for readers to stop accessing the old private data,
+	 * so the caller can free it.
+	 */
+	synchronize_rcu();
+}
+EXPORT_SYMBOL_GPL(ioasid_detach_data);
+
 /**
  * ioasid_alloc - Allocate an IOASID
  * @set: the IOASID set
diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
index 60ea279802b8..f6e705f832f0 100644
--- a/include/linux/ioasid.h
+++ b/include/linux/ioasid.h
@@ -41,7 +41,7 @@ void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
 int ioasid_register_allocator(struct ioasid_allocator_ops *allocator);
 void ioasid_unregister_allocator(struct ioasid_allocator_ops *allocator);
 int ioasid_attach_data(ioasid_t ioasid, void *data);
-
+void ioasid_detach_data(ioasid_t ioasid);
 #else /* !CONFIG_IOASID */
 static inline ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min,
 				    ioasid_t max, void *private)
@@ -78,5 +78,8 @@ static inline int ioasid_attach_data(ioasid_t ioasid, void *data)
 	return -ENOTSUPP;
 }
 
+static inline void ioasid_detach_data(ioasid_t ioasid)
+{
+}
 #endif /* CONFIG_IOASID */
 #endif /* __LINUX_IOASID_H */
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
