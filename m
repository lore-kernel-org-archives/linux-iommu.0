Return-Path: <SRS0=eHMU=2G=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9DD9C2D0BF
	for <iommu@archiver.kernel.org>; Mon, 16 Dec 2019 19:19:28 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9680020717
	for <iommu@archiver.kernel.org>; Mon, 16 Dec 2019 19:19:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9680020717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 735038691C;
	Mon, 16 Dec 2019 19:19:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SpFZpiaQXlR6; Mon, 16 Dec 2019 19:19:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 33BCC86928;
	Mon, 16 Dec 2019 19:19:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0C586C1D87;
	Mon, 16 Dec 2019 19:19:27 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 104D0C1AE8
 for <iommu@lists.linux-foundation.org>; Mon, 16 Dec 2019 19:19:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id F222F881AB
 for <iommu@lists.linux-foundation.org>; Mon, 16 Dec 2019 19:19:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id T937s5Psv+YR for <iommu@lists.linux-foundation.org>;
 Mon, 16 Dec 2019 19:19:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 447088815E
 for <iommu@lists.linux-foundation.org>; Mon, 16 Dec 2019 19:19:24 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 16 Dec 2019 11:19:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,322,1571727600"; d="scan'208";a="209411664"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
 by orsmga008.jf.intel.com with ESMTP; 16 Dec 2019 11:19:23 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>, "Lu Baolu" <baolu.lu@linux.intel.com>,
 David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH v8 09/10] iommu/ioasid: Add notifier for status change
Date: Mon, 16 Dec 2019 11:24:11 -0800
Message-Id: <1576524252-79116-10-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576524252-79116-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1576524252-79116-1-git-send-email-jacob.jun.pan@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>
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

IOASIDs are system resources that can be shared by multiple drivers or
subsystems. When status of an IOASID changes at runtime, there is need
to notify all current users such that proper actions can be taken.

For example, an IOASID can be used by IOMMU subsystem for guest SVM as
well as KVM. When the guest is terminating unexpectedly, both KVM and
IOMMU need to perform clean up action before the IOASID is reclaimed.

This patch adds a per IOASID notifier that can be registered by
interesting parties.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/ioasid.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/ioasid.h | 20 ++++++++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
index 0f8dd377aada..53a2ab287f7d 100644
--- a/drivers/iommu/ioasid.c
+++ b/drivers/iommu/ioasid.c
@@ -15,6 +15,7 @@ struct ioasid_data {
 	struct ioasid_set *set;
 	void *private;
 	struct rcu_head rcu;
+	struct atomic_notifier_head notifications;
 };
 
 /*
@@ -314,6 +315,7 @@ ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
 
 	data->set = set;
 	data->private = private;
+	ATOMIC_INIT_NOTIFIER_HEAD(&data->notifications);
 
 	/*
 	 * Custom allocator needs allocator data to perform platform specific
@@ -360,6 +362,9 @@ void ioasid_free(ioasid_t ioasid)
 		goto exit_unlock;
 	}
 
+	/* Notify all users that this IOASID is being freed */
+	atomic_notifier_call_chain(&ioasid_data->notifications, IOASID_FREE,
+				     &ioasid);
 	active_allocator->ops->free(ioasid, active_allocator->ops->pdata);
 	/* Custom allocator needs additional steps to free the xa element */
 	if (active_allocator->flags & IOASID_ALLOCATOR_CUSTOM) {
@@ -416,6 +421,44 @@ void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
 }
 EXPORT_SYMBOL_GPL(ioasid_find);
 
+int ioasid_add_notifier(ioasid_t ioasid, struct notifier_block *nb)
+{
+	struct ioasid_allocator_data *idata;
+	struct ioasid_data *data;
+	int ret = 0;
+
+	rcu_read_lock();
+	idata = rcu_dereference(active_allocator);
+	data = xa_load(&idata->xa, ioasid);
+	if (!data) {
+		ret = -ENOENT;
+		goto unlock;
+	}
+	ret = atomic_notifier_chain_register(&data->notifications, nb);
+unlock:
+	rcu_read_unlock();
+	return ret;
+}
+EXPORT_SYMBOL_GPL(ioasid_add_notifier);
+
+void ioasid_remove_notifier(ioasid_t ioasid, struct notifier_block *nb)
+{
+	struct ioasid_allocator_data *idata;
+	struct ioasid_data *data;
+
+	rcu_read_lock();
+	idata = rcu_dereference(active_allocator);
+	data = xa_load(&idata->xa, ioasid);
+	rcu_read_unlock();
+	if (!data) {
+		pr_err("IOASID %d not found\n", ioasid);
+		return;
+	}
+	/* Unregister can sleep, called outside RCU critical section. */
+	atomic_notifier_chain_unregister(&data->notifications, nb);
+}
+EXPORT_SYMBOL_GPL(ioasid_remove_notifier);
+
 MODULE_AUTHOR("Jean-Philippe Brucker <jean-philippe.brucker@arm.com>");
 MODULE_AUTHOR("Jacob Pan <jacob.jun.pan@linux.intel.com>");
 MODULE_DESCRIPTION("IO Address Space ID (IOASID) allocator");
diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
index 6f000d7a0ddc..4517c4be4088 100644
--- a/include/linux/ioasid.h
+++ b/include/linux/ioasid.h
@@ -4,6 +4,7 @@
 
 #include <linux/types.h>
 #include <linux/errno.h>
+#include <linux/notifier.h>
 
 #define INVALID_IOASID ((ioasid_t)-1)
 typedef unsigned int ioasid_t;
@@ -29,6 +30,12 @@ struct ioasid_allocator_ops {
 	void *pdata;
 };
 
+/* Notification data when IOASID status changed */
+enum ioasid_notify_val {
+	IOASID_FREE = 1,
+	IOASID_SUSPEND,
+};
+
 #define DECLARE_IOASID_SET(name) struct ioasid_set name = { 0 }
 
 #if IS_ENABLED(CONFIG_IOASID)
@@ -40,6 +47,8 @@ void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
 int ioasid_register_allocator(struct ioasid_allocator_ops *allocator);
 void ioasid_unregister_allocator(struct ioasid_allocator_ops *allocator);
 int ioasid_set_data(ioasid_t ioasid, void *data);
+int ioasid_add_notifier(ioasid_t ioasid, struct notifier_block *nb);
+void ioasid_remove_notifier(ioasid_t ioasid, struct notifier_block *nb);
 
 #else /* !CONFIG_IOASID */
 static inline ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min,
@@ -58,6 +67,17 @@ static inline void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
 	return NULL;
 }
 
+static inline int ioasid_add_notifier(ioasid_t ioasid,
+				      struct notifier_block *nb)
+{
+	return -ENOTSUPP;
+}
+
+static inline void ioasid_remove_notifier(ioasid_t ioasid,
+				       struct notifier_block *nb)
+{
+}
+
 static inline int ioasid_register_allocator(struct ioasid_allocator_ops *allocator)
 {
 	return -ENOTSUPP;
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
