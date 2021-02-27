Return-Path: <SRS0=Pr8R=H6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A49CC433DB
	for <iommu@archiver.kernel.org>; Sun, 28 Feb 2021 06:33:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C8C864E56
	for <iommu@archiver.kernel.org>; Sun, 28 Feb 2021 06:33:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C8C864E56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E95AB6F845;
	Sun, 28 Feb 2021 06:33:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZWuGSCkUZDZa; Sun, 28 Feb 2021 06:33:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 88B326F991;
	Sun, 28 Feb 2021 06:33:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0F1DAC0015;
	Sun, 28 Feb 2021 06:33:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 109B3C000E
 for <iommu@lists.linux-foundation.org>; Sun, 28 Feb 2021 06:33:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E93036F893
 for <iommu@lists.linux-foundation.org>; Sun, 28 Feb 2021 06:33:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wj9YT8MrgbrN for <iommu@lists.linux-foundation.org>;
 Sun, 28 Feb 2021 06:33:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1F8236F5A4
 for <iommu@lists.linux-foundation.org>; Sun, 28 Feb 2021 06:33:11 +0000 (UTC)
IronPort-SDR: oX7elOYCwTqhSciLSBN0P5/0apppA6pXSCHRxrIRZpIeFGoq4LrScqVpnsQXZtQaRZsoMvVO+W
 jDyQO8JccFng==
X-IronPort-AV: E=McAfee;i="6000,8403,9908"; a="247624804"
X-IronPort-AV: E=Sophos;i="5.81,211,1610438400"; d="scan'208";a="247624804"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Feb 2021 22:33:10 -0800
IronPort-SDR: OlMZLxJr4usjBYjQLafwEmc8+hyWUvMMEUh25wap14Nsvg8M73cK2FlaDV+SBWS9dhiJ/6dlVw
 50492sCfZbJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,211,1610438400"; d="scan'208";a="517029712"
Received: from otc-wp-03.jf.intel.com ([10.54.39.79])
 by orsmga004.jf.intel.com with ESMTP; 27 Feb 2021 22:33:09 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
 "Lu Baolu" <baolu.lu@linux.intel.com>,
 David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux-foundation.org,
 cgroups@vger.kernel.org, Tejun Heo <tj@kernel.org>,
 Li Zefan <lizefan@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
Subject: [PATCH V4 06/18] iommu/ioasid: Add free function and states
Date: Sat, 27 Feb 2021 14:01:14 -0800
Message-Id: <1614463286-97618-7-git-send-email-jacob.jun.pan@linux.intel.com>
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

When an actively used IOASID is freed due to exceptions, users must be
notified to perform the cleanup. The IOASID shall be put in a pending
state until all users completed their cleanup work.

This patch adds ioasid_free() function to let the caller initiate the
freeing process. Both ioasid_free() and ioasid_put() decrements
reference counts. Unlike ioasid_put(), the ioasid_free() function also
transition the IOASID to the free pending state where further
ioasid_get() is prohibited. This paves the way for FREE event
notifications that will be introduced next.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/ioasid.c | 73 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/ioasid.h |  5 +++
 2 files changed, 78 insertions(+)

diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
index d7b476651027..a10f8154c680 100644
--- a/drivers/iommu/ioasid.c
+++ b/drivers/iommu/ioasid.c
@@ -15,8 +15,26 @@
 static ioasid_t ioasid_capacity = PCI_PASID_MAX;
 static ioasid_t ioasid_capacity_avail = PCI_PASID_MAX;
 static DEFINE_XARRAY_ALLOC(ioasid_sets);
+
+enum ioasid_state {
+	IOASID_STATE_IDLE,
+	IOASID_STATE_ACTIVE,
+	IOASID_STATE_FREE_PENDING,
+};
+
+/**
+ * struct ioasid_data - Meta data about ioasid
+ *
+ * @id:		Unique ID
+ * @refs:	Number of active users
+ * @state:	Track state of the IOASID
+ * @set:	ioasid_set of the IOASID belongs to
+ * @private:	Private data associated with the IOASID
+ * @rcu:	For free after RCU grace period
+ */
 struct ioasid_data {
 	ioasid_t id;
+	enum ioasid_state state;
 	struct ioasid_set *set;
 	void *private;
 	struct rcu_head rcu;
@@ -597,6 +615,7 @@ ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
 		goto exit_free;
 	}
 	data->id = id;
+	data->state = IOASID_STATE_IDLE;
 
 	/* Store IOASID in the per set data */
 	if (xa_err(xa_store(&set->xa, id, data, GFP_ATOMIC))) {
@@ -631,6 +650,56 @@ static void ioasid_do_free_locked(struct ioasid_data *data)
 		ioasid_set_free_locked(data->set);
 }
 
+static void ioasid_free_locked(struct ioasid_set *set, ioasid_t ioasid)
+{
+	struct ioasid_data *data;
+
+	data = xa_load(&active_allocator->xa, ioasid);
+	if (!data) {
+		pr_err_ratelimited("Trying to free unknown IOASID %u\n", ioasid);
+		return;
+	}
+	if (data->set != set) {
+		pr_warn("Cannot free IOASID %u due to set ownership\n", ioasid);
+		return;
+	}
+	/* Check if the set exists */
+	if (WARN_ON(!xa_load(&ioasid_sets, data->set->id)))
+		return;
+
+	/* Free is already in progress */
+	if (data->state == IOASID_STATE_FREE_PENDING)
+		return;
+
+	data->state = IOASID_STATE_FREE_PENDING;
+	/*
+	 * If the refcount is 1, it means there is no other users of the IOASID
+	 * other than IOASID core itself. There is no need to notify anyone.
+	 */
+	if (!refcount_dec_and_test(&data->refs))
+		return;
+
+	ioasid_do_free_locked(data);
+}
+
+/**
+ * ioasid_free - Drop reference on an IOASID. Free if refcount drops to 0,
+ *               including free from its set and system-wide list.
+ * @set:	The ioasid_set to check permission with. If not NULL, IOASID
+ *		free will fail if the set does not match.
+ * @ioasid:	The IOASID to remove
+ *
+ * TODO: return true if all references dropped, false if async work is in
+ * progress, IOASID is in FREE_PENDING state. wait queue to be used for blocking
+ * free task.
+ */
+void ioasid_free(struct ioasid_set *set, ioasid_t ioasid)
+{
+	spin_lock(&ioasid_allocator_lock);
+	ioasid_free_locked(set, ioasid);
+	spin_unlock(&ioasid_allocator_lock);
+}
+EXPORT_SYMBOL_GPL(ioasid_free);
 int ioasid_get_locked(struct ioasid_set *set, ioasid_t ioasid)
 {
 	struct ioasid_data *data;
@@ -640,6 +709,10 @@ int ioasid_get_locked(struct ioasid_set *set, ioasid_t ioasid)
 		pr_err("Trying to get unknown IOASID %u\n", ioasid);
 		return -EINVAL;
 	}
+	if (data->state == IOASID_STATE_FREE_PENDING) {
+		pr_err("Trying to get IOASID being freed%u\n", ioasid);
+		return -EBUSY;
+	}
 
 	/* Check set ownership if the set is non-null */
 	if (set && data->set != set) {
diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
index 095f4e50dc58..cabaf0b0348f 100644
--- a/include/linux/ioasid.h
+++ b/include/linux/ioasid.h
@@ -72,6 +72,7 @@ int ioasid_get(struct ioasid_set *set, ioasid_t ioasid);
 int ioasid_get_locked(struct ioasid_set *set, ioasid_t ioasid);
 bool ioasid_put(struct ioasid_set *set, ioasid_t ioasid);
 bool ioasid_put_locked(struct ioasid_set *set, ioasid_t ioasid);
+void ioasid_free(struct ioasid_set *set, ioasid_t ioasid);
 void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
 		  bool (*getter)(void *));
 int ioasid_register_allocator(struct ioasid_allocator_ops *allocator);
@@ -105,6 +106,10 @@ static inline struct ioasid_set *ioasid_set_alloc(void *token, ioasid_t quota,
 	return ERR_PTR(-ENOTSUPP);
 }
 
+static inline void ioasid_free(struct ioasid_set *set, ioasid_t ioasid)
+{
+}
+
 static inline struct ioasid_set *ioasid_find_mm_set(struct mm_struct *token)
 {
 	return NULL;
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
