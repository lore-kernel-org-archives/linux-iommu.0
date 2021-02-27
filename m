Return-Path: <SRS0=Pr8R=H6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 396DEC43381
	for <iommu@archiver.kernel.org>; Sun, 28 Feb 2021 06:33:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2C6264E66
	for <iommu@archiver.kernel.org>; Sun, 28 Feb 2021 06:33:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2C6264E66
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B5F0E43150;
	Sun, 28 Feb 2021 06:33:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id n16SG6WQKImu; Sun, 28 Feb 2021 06:33:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9154E43344;
	Sun, 28 Feb 2021 06:33:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ED7C4C0018;
	Sun, 28 Feb 2021 06:33:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 49CB1C000B
 for <iommu@lists.linux-foundation.org>; Sun, 28 Feb 2021 06:33:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 36D836F845
 for <iommu@lists.linux-foundation.org>; Sun, 28 Feb 2021 06:33:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UGONA_J4b0y7 for <iommu@lists.linux-foundation.org>;
 Sun, 28 Feb 2021 06:33:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6A1AB6F5A8
 for <iommu@lists.linux-foundation.org>; Sun, 28 Feb 2021 06:33:11 +0000 (UTC)
IronPort-SDR: hJwA49gZC6pCXq6/OWszqghOQ6KdMeZivhQVyCkEwwdfnWnVrY/PaMBFpm+Qh24/4RZrebdDw3
 zDI0VRV87ZyQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9908"; a="247624806"
X-IronPort-AV: E=Sophos;i="5.81,211,1610438400"; d="scan'208";a="247624806"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Feb 2021 22:33:10 -0800
IronPort-SDR: uViKB7IpUnlUj71C+dfdHvaySm/kdSYhIWEQXMIrwmw5k196QwVOQ1eaDa11HjurQEQ606e+Cz
 Xd9N9SVSujtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,211,1610438400"; d="scan'208";a="517029715"
Received: from otc-wp-03.jf.intel.com ([10.54.39.79])
 by orsmga004.jf.intel.com with ESMTP; 27 Feb 2021 22:33:09 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
 "Lu Baolu" <baolu.lu@linux.intel.com>,
 David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux-foundation.org,
 cgroups@vger.kernel.org, Tejun Heo <tj@kernel.org>,
 Li Zefan <lizefan@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
Subject: [PATCH V4 07/18] iommu/ioasid: Add ioasid_set iterator helper
 functions
Date: Sat, 27 Feb 2021 14:01:15 -0800
Message-Id: <1614463286-97618-8-git-send-email-jacob.jun.pan@linux.intel.com>
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

Users of an ioasid_set may not keep track of all the IOASIDs allocated
under the set. When collective actions are needed for each IOASIDs, it
is useful to iterate over all the IOASIDs within the set. For example,
when the ioasid_set is freed, the user might perform the same cleanup
operation on each IOASID.

This patch adds an API to iterate all the IOASIDs within the set.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/ioasid.c | 84 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/ioasid.h | 20 ++++++++++
 2 files changed, 104 insertions(+)

diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
index a10f8154c680..9a3ba157dec3 100644
--- a/drivers/iommu/ioasid.c
+++ b/drivers/iommu/ioasid.c
@@ -700,6 +700,61 @@ void ioasid_free(struct ioasid_set *set, ioasid_t ioasid)
 	spin_unlock(&ioasid_allocator_lock);
 }
 EXPORT_SYMBOL_GPL(ioasid_free);
+
+/**
+ * ioasid_free_all_in_set
+ *
+ * @brief
+ * Free all PASIDs from system-wide IOASID pool, all subscribers gets
+ * notified and do cleanup of their own.
+ * Note that some references of the IOASIDs within the set can still
+ * be held after the free call. This is OK in that the IOASIDs will be
+ * marked inactive, the only operations can be done is ioasid_put.
+ * No need to track IOASID set states since there is no reclaim phase.
+ *
+ * @param
+ * struct ioasid_set where all IOASIDs within the set will be freed.
+ */
+void ioasid_free_all_in_set(struct ioasid_set *set)
+{
+	struct ioasid_data *entry;
+	unsigned long index;
+
+	if (!ioasid_set_is_valid(set))
+		return;
+
+	if (xa_empty(&set->xa))
+		return;
+
+	if (!atomic_read(&set->nr_ioasids))
+		return;
+	spin_lock(&ioasid_allocator_lock);
+	xa_for_each(&set->xa, index, entry) {
+		ioasid_free_locked(set, index);
+		/* Free from per set private pool */
+		xa_erase(&set->xa, index);
+	}
+	spin_unlock(&ioasid_allocator_lock);
+}
+EXPORT_SYMBOL_GPL(ioasid_free_all_in_set);
+
+/**
+ * ioasid_set_for_each_ioasid
+ * @brief
+ * Iterate over all the IOASIDs within the set
+ */
+void ioasid_set_for_each_ioasid(struct ioasid_set *set,
+				void (*fn)(ioasid_t id, void *data),
+				void *data)
+{
+	struct ioasid_data *entry;
+	unsigned long index;
+
+	xa_for_each(&set->xa, index, entry)
+		fn(index, data);
+}
+EXPORT_SYMBOL_GPL(ioasid_set_for_each_ioasid);
+
 int ioasid_get_locked(struct ioasid_set *set, ioasid_t ioasid)
 {
 	struct ioasid_data *data;
@@ -789,6 +844,35 @@ bool ioasid_put(struct ioasid_set *set, ioasid_t ioasid)
 }
 EXPORT_SYMBOL_GPL(ioasid_put);
 
+/**
+ * @brief
+ * Find the ioasid_set of an IOASID. As long as the IOASID is valid,
+ * the set must be valid since the refcounting is based on the number of IOASID
+ * in the set.
+ *
+ * @param ioasid
+ * @return struct ioasid_set*
+ */
+struct ioasid_set *ioasid_find_set(ioasid_t ioasid)
+{
+	struct ioasid_allocator_data *idata;
+	struct ioasid_data *ioasid_data;
+	struct ioasid_set *set = NULL;
+
+	rcu_read_lock();
+	idata = rcu_dereference(active_allocator);
+	ioasid_data = xa_load(&idata->xa, ioasid);
+	if (!ioasid_data) {
+		set = ERR_PTR(-ENOENT);
+		goto unlock;
+	}
+	set = ioasid_data->set;
+unlock:
+	rcu_read_unlock();
+	return set;
+}
+EXPORT_SYMBOL_GPL(ioasid_find_set);
+
 /**
  * ioasid_find - Find IOASID data
  * @set: the IOASID set
diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
index cabaf0b0348f..e7f3e6108724 100644
--- a/include/linux/ioasid.h
+++ b/include/linux/ioasid.h
@@ -73,12 +73,17 @@ int ioasid_get_locked(struct ioasid_set *set, ioasid_t ioasid);
 bool ioasid_put(struct ioasid_set *set, ioasid_t ioasid);
 bool ioasid_put_locked(struct ioasid_set *set, ioasid_t ioasid);
 void ioasid_free(struct ioasid_set *set, ioasid_t ioasid);
+void ioasid_free_all_in_set(struct ioasid_set *set);
 void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
 		  bool (*getter)(void *));
+struct ioasid_set *ioasid_find_set(ioasid_t ioasid);
 int ioasid_register_allocator(struct ioasid_allocator_ops *allocator);
 void ioasid_unregister_allocator(struct ioasid_allocator_ops *allocator);
 int ioasid_attach_data(ioasid_t ioasid, void *data);
 void ioasid_detach_data(ioasid_t ioasid);
+void ioasid_set_for_each_ioasid(struct ioasid_set *sdata,
+				void (*fn)(ioasid_t id, void *data),
+				void *data);
 #else /* !CONFIG_IOASID */
 static inline void ioasid_install_capacity(ioasid_t total)
 {
@@ -158,5 +163,20 @@ static inline int ioasid_attach_data(ioasid_t ioasid, void *data)
 static inline void ioasid_detach_data(ioasid_t ioasid)
 {
 }
+
+static inline void ioasid_free_all_in_set(struct ioasid_set *set)
+{
+}
+
+static inline struct ioasid_set *ioasid_find_set(ioasid_t ioasid)
+{
+	return ERR_PTR(-ENOTSUPP);
+}
+
+static inline void ioasid_set_for_each_ioasid(struct ioasid_set *sdata,
+					      void (*fn)(ioasid_t id, void *data),
+					      void *data)
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
