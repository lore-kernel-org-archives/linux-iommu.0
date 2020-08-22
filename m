Return-Path: <SRS0=KEvp=CA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A70C433E4
	for <iommu@archiver.kernel.org>; Sat, 22 Aug 2020 07:09:42 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7876A20724
	for <iommu@archiver.kernel.org>; Sat, 22 Aug 2020 07:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SFwC1zQ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7876A20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6128187A24;
	Sat, 22 Aug 2020 07:09:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nUx3QWzc4lIq; Sat, 22 Aug 2020 07:09:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9A08087797;
	Sat, 22 Aug 2020 07:09:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7D6ACC088B;
	Sat, 22 Aug 2020 07:09:34 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7F532C0051
 for <iommu@lists.linux-foundation.org>; Sat, 22 Aug 2020 04:28:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 6EDE4861C7
 for <iommu@lists.linux-foundation.org>; Sat, 22 Aug 2020 04:28:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iGup60qo7JPa for <iommu@lists.linux-foundation.org>;
 Sat, 22 Aug 2020 04:28:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com
 [209.85.210.194])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 28AEF85FA6
 for <iommu@lists.linux-foundation.org>; Sat, 22 Aug 2020 04:28:32 +0000 (UTC)
Received: by mail-pf1-f194.google.com with SMTP id u128so2060400pfb.6
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 21:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=E3HId+HfWao520tWHgO6sDwvEB7GBdka4MZTGhAcw2M=;
 b=SFwC1zQ8oG0FOLtA15YqioSMWIAGMXRANolas6dXnsn2bORTaXTGGoc0vUBPRFrmHE
 GQ1nuf6OOOxjjnyQR3NFuc0V/no89iilR18+mL3/1hjl+KFA3j1Hq21xOEh/NAhGNB3R
 RyPXuPGLyPCenAlSWsICJrUucTNrn6wX0agYHxjfeM7uwp8cGwB8/UaGd0MdWg/Gwgs7
 ZehYFPx+VvnkUcrWPPp2yuBqTX/zaRyWlHSzFkcpNKjlQNCoioPtoTz19hRAxvAnxVzk
 +Xsep8/1Sj0+/9v5uQYAPrFhdVH/EGhPc22PS2Rwupagpb3Gd1cerPS837qUGxC9O0yA
 B5HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=E3HId+HfWao520tWHgO6sDwvEB7GBdka4MZTGhAcw2M=;
 b=DCiaaTuywcWqZYxhPodelW3a7fjLBw9o56zTJu15XVHCgwgGBuu7Bsl8l3kZqobDHz
 xKL//To4unOMsfIcG3RRZU2M7y2RMfhnlQ2zpDzsj/XcxP++pWD6AxKKSA1fFuFxoPVt
 na21SavWSrd7xbSw2llQkz8CPyZ243OjxTi1cDIjs1IzmJFc4vUADoghwcUakhauQshd
 tGVjZkgIMNKROqv4MshY0wXvkJUvrZtGdkLgwf+Hy8G6mGigUGr4p322aRsWNFZ3EMjm
 N08seppgE8hKD53VOYnaZti6DeBwgMTBdojdRygQEuUE1L32qgL0Y11FtHgkGYmvRbL+
 3cWw==
X-Gm-Message-State: AOAM533Z/ZBW8+eaCu48Acv7NZvDAiEQdQwrMKMnJ1RyD5j12o6ewJrH
 iZAlcbN1blsaMb9dfqxUKgq52ttn5S9mfj9S
X-Google-Smtp-Source: ABdhPJyfc6T5AqDEzBlfMcOO+k5fXdlfwI9d0AcvD8e5fbNEN8g49w24vrTphAyob8NNCYNBN5FJRg==
X-Received: by 2002:a05:6a00:7c7:: with SMTP id
 n7mr5001758pfu.291.1598070511113; 
 Fri, 21 Aug 2020 21:28:31 -0700 (PDT)
Received: from jacob-builder.jf.intel.com ([192.55.55.43])
 by smtp.gmail.com with ESMTPSA id q5sm3341582pgi.31.2020.08.21.21.28.29
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 21 Aug 2020 21:28:30 -0700 (PDT)
From: Jacob Pan <jacob.pan.linux@gmail.com>
X-Google-Original-From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 "Lu Baolu" <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH v2 6/9] iommu/ioasid: Introduce notification APIs
Date: Fri, 21 Aug 2020 21:35:15 -0700
Message-Id: <1598070918-21321-7-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598070918-21321-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1598070918-21321-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailman-Approved-At: Sat, 22 Aug 2020 07:09:31 +0000
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
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

Relations among IOASID users largely follow a publisher-subscriber
pattern. E.g. to support guest SVA on Intel Scalable I/O Virtualization
(SIOV) enabled platforms, VFIO, IOMMU, device drivers, KVM are all users
of IOASIDs. When a state change occurs, VFIO publishes the change event
that needs to be processed by other users/subscribers.

This patch introduced two types of notifications: global and per
ioasid_set. The latter is intended for users who only needs to handle
events related to the IOASID of a given set.
For more information, refer to the kernel documentation at
Documentation/ioasid.rst.

Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/ioasid.c | 280 ++++++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/ioasid.h |  70 +++++++++++++
 2 files changed, 348 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
index c0aef38a4fde..6ddc09a7fe74 100644
--- a/drivers/iommu/ioasid.c
+++ b/drivers/iommu/ioasid.c
@@ -9,8 +9,35 @@
 #include <linux/spinlock.h>
 #include <linux/xarray.h>
 #include <linux/ioasid.h>
+#include <linux/sched/mm.h>
 
 static DEFINE_XARRAY_ALLOC(ioasid_sets);
+/*
+ * An IOASID could have multiple consumers where each consumeer may have
+ * hardware contexts associated with IOASIDs.
+ * When a status change occurs, such as IOASID is being freed, notifier chains
+ * are used to keep the consumers in sync.
+ * This is a publisher-subscriber pattern where publisher can change the
+ * state of each IOASID, e.g. alloc/free, bind IOASID to a device and mm.
+ * On the other hand, subscribers gets notified for the state change and
+ * keep local states in sync.
+ *
+ * Currently, the notifier is global. A further optimization could be per
+ * IOASID set notifier chain.
+ */
+static ATOMIC_NOTIFIER_HEAD(ioasid_chain);
+
+/* List to hold pending notification block registrations */
+static LIST_HEAD(ioasid_nb_pending_list);
+static DEFINE_SPINLOCK(ioasid_nb_lock);
+struct ioasid_set_nb {
+	struct list_head	list;
+	struct notifier_block	*nb;
+	void			*token;
+	struct ioasid_set	*set;
+	bool			active;
+};
+
 enum ioasid_state {
 	IOASID_STATE_INACTIVE,
 	IOASID_STATE_ACTIVE,
@@ -394,6 +421,7 @@ EXPORT_SYMBOL_GPL(ioasid_find_by_spid);
 ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
 		      void *private)
 {
+	struct ioasid_nb_args args;
 	struct ioasid_data *data;
 	void *adata;
 	ioasid_t id = INVALID_IOASID;
@@ -445,8 +473,14 @@ ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
 		goto exit_free;
 	}
 	set->nr_ioasids++;
-	goto done_unlock;
+	args.id = id;
+	/* Set private ID is not attached during allocation */
+	args.spid = INVALID_IOASID;
+	args.set = set;
+	atomic_notifier_call_chain(&set->nh, IOASID_ALLOC, &args);
 
+	spin_unlock(&ioasid_allocator_lock);
+	return id;
 exit_free:
 	kfree(data);
 done_unlock:
@@ -479,6 +513,7 @@ static void ioasid_do_free(struct ioasid_data *data)
 
 static void ioasid_free_locked(struct ioasid_set *set, ioasid_t ioasid)
 {
+	struct ioasid_nb_args args;
 	struct ioasid_data *data;
 
 	data = xa_load(&active_allocator->xa, ioasid);
@@ -491,7 +526,16 @@ static void ioasid_free_locked(struct ioasid_set *set, ioasid_t ioasid)
 		pr_warn("Cannot free IOASID %u due to set ownership\n", ioasid);
 		return;
 	}
+
 	data->state = IOASID_STATE_FREE_PENDING;
+	/* Notify all users that this IOASID is being freed */
+	args.id = ioasid;
+	args.spid = data->spid;
+	args.pdata = data->private;
+	args.set = data->set;
+	atomic_notifier_call_chain(&ioasid_chain, IOASID_FREE, &args);
+	/* Notify the ioasid_set for per set users */
+	atomic_notifier_call_chain(&set->nh, IOASID_FREE, &args);
 
 	if (!refcount_dec_and_test(&data->users))
 		return;
@@ -514,6 +558,28 @@ void ioasid_free(struct ioasid_set *set, ioasid_t ioasid)
 }
 EXPORT_SYMBOL_GPL(ioasid_free);
 
+static void ioasid_add_pending_nb(struct ioasid_set *set)
+{
+	struct ioasid_set_nb *curr;
+
+	if (set->type != IOASID_SET_TYPE_MM)
+		return;
+
+	/*
+	 * Check if there are any pending nb requests for the given token, if so
+	 * add them to the notifier chain.
+	 */
+	spin_lock(&ioasid_nb_lock);
+	list_for_each_entry(curr, &ioasid_nb_pending_list, list) {
+		if (curr->token == set->token && !curr->active) {
+			atomic_notifier_chain_register(&set->nh, curr->nb);
+			curr->set = set;
+			curr->active = true;
+		}
+	}
+	spin_unlock(&ioasid_nb_lock);
+}
+
 /**
  * ioasid_alloc_set - Allocate a new IOASID set for a given token
  *
@@ -601,6 +667,13 @@ struct ioasid_set *ioasid_alloc_set(void *token, ioasid_t quota, int type)
 	sdata->quota = quota;
 	sdata->sid = id;
 	refcount_set(&sdata->ref, 1);
+	ATOMIC_INIT_NOTIFIER_HEAD(&sdata->nh);
+
+	/*
+	 * Check if there are any pending nb requests for the given token, if so
+	 * add them to the notifier chain.
+	 */
+	ioasid_add_pending_nb(sdata);
 
 	/*
 	 * Per set XA is used to store private IDs within the set, get ready
@@ -617,6 +690,30 @@ struct ioasid_set *ioasid_alloc_set(void *token, ioasid_t quota, int type)
 }
 EXPORT_SYMBOL_GPL(ioasid_alloc_set);
 
+
+/*
+ * ioasid_find_mm_set - Retrieve IOASID set with mm token
+ * Take a reference of the set if found.
+ */
+static struct ioasid_set *ioasid_find_mm_set(struct mm_struct *token)
+{
+	struct ioasid_set *sdata, *set = NULL;
+	unsigned long index;
+
+	spin_lock(&ioasid_allocator_lock);
+
+	xa_for_each(&ioasid_sets, index, sdata) {
+		if (sdata->type == IOASID_SET_TYPE_MM && sdata->token == token) {
+			refcount_inc(&sdata->ref);
+			set = sdata;
+			goto exit_unlock;
+		}
+	}
+exit_unlock:
+	spin_unlock(&ioasid_allocator_lock);
+	return set;
+}
+
 void ioasid_set_get_locked(struct ioasid_set *set)
 {
 	if (WARN_ON(xa_load(&ioasid_sets, set->sid) != set)) {
@@ -638,6 +735,8 @@ EXPORT_SYMBOL_GPL(ioasid_set_get);
 
 void ioasid_set_put_locked(struct ioasid_set *set)
 {
+	struct ioasid_nb_args args = { 0 };
+	struct ioasid_set_nb *curr;
 	struct ioasid_data *entry;
 	unsigned long index;
 
@@ -673,8 +772,24 @@ void ioasid_set_put_locked(struct ioasid_set *set)
 done_destroy:
 	/* Return the quota back to system pool */
 	ioasid_capacity_avail += set->quota;
-	kfree_rcu(set, rcu);
 
+	/* Restore pending status of the set NBs */
+	spin_lock(&ioasid_nb_lock);
+	list_for_each_entry(curr, &ioasid_nb_pending_list, list) {
+		if (curr->token == set->token) {
+			if (curr->active)
+				curr->active = false;
+			else
+				pr_warn("Set token exists but not active!\n");
+		}
+	}
+	spin_unlock(&ioasid_nb_lock);
+
+	args.set = set;
+	atomic_notifier_call_chain(&ioasid_chain, IOASID_SET_FREE, &args);
+
+	kfree_rcu(set, rcu);
+	pr_debug("Set freed %d\n", set->sid);
 	/*
 	 * Token got released right away after the ioasid_set is freed.
 	 * If a new set is created immediately with the newly released token,
@@ -927,6 +1042,167 @@ void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
 }
 EXPORT_SYMBOL_GPL(ioasid_find);
 
+int ioasid_register_notifier(struct ioasid_set *set, struct notifier_block *nb)
+{
+	if (set)
+		return atomic_notifier_chain_register(&set->nh, nb);
+	else
+		return atomic_notifier_chain_register(&ioasid_chain, nb);
+}
+EXPORT_SYMBOL_GPL(ioasid_register_notifier);
+
+void ioasid_unregister_notifier(struct ioasid_set *set,
+				struct notifier_block *nb)
+{
+	struct ioasid_set_nb *curr;
+
+	spin_lock(&ioasid_nb_lock);
+	/*
+	 * Pending list is registered with a token without an ioasid_set,
+	 * therefore should not be unregistered directly.
+	 */
+	list_for_each_entry(curr, &ioasid_nb_pending_list, list) {
+		if (curr->nb == nb) {
+			pr_warn("Cannot unregister NB from pending list\n");
+			spin_unlock(&ioasid_nb_lock);
+			return;
+		}
+	}
+	spin_unlock(&ioasid_nb_lock);
+
+	if (set)
+		atomic_notifier_chain_unregister(&set->nh, nb);
+	else
+		atomic_notifier_chain_unregister(&ioasid_chain, nb);
+}
+EXPORT_SYMBOL_GPL(ioasid_unregister_notifier);
+
+int ioasid_register_notifier_mm(struct mm_struct *mm, struct notifier_block *nb)
+{
+	struct ioasid_set_nb *curr;
+	struct ioasid_set *set;
+	int ret = 0;
+
+	if (!mm)
+		return -EINVAL;
+
+	spin_lock(&ioasid_nb_lock);
+
+	/* Check for duplicates, nb is unique per set */
+	list_for_each_entry(curr, &ioasid_nb_pending_list, list) {
+		if (curr->token == mm && curr->nb == nb) {
+			ret = -EBUSY;
+			goto exit_unlock;
+		}
+	}
+
+	/* Check if the token has an existing set */
+	set = ioasid_find_mm_set(mm);
+	if (IS_ERR_OR_NULL(set)) {
+		/* Add to the rsvd list as inactive */
+		curr->active = false;
+	} else {
+		/* REVISIT: Only register empty set for now. Can add an option
+		 * in the future to playback existing PASIDs.
+		 */
+		if (set->nr_ioasids) {
+			pr_warn("IOASID set %d not empty\n", set->sid);
+			ret = -EBUSY;
+			goto exit_unlock;
+		}
+		curr = kzalloc(sizeof(*curr), GFP_ATOMIC);
+		if (!curr) {
+			ret = -ENOMEM;
+			goto exit_unlock;
+		}
+		curr->token = mm;
+		curr->nb = nb;
+		curr->active = true;
+		curr->set = set;
+
+		/* Set already created, add to the notifier chain */
+		atomic_notifier_chain_register(&set->nh, nb);
+		/*
+		 * Do not hold a reference, if the set gets destroyed, the nb
+		 * entry will be marked inactive.
+		 */
+		ioasid_set_put(set);
+	}
+
+	list_add(&curr->list, &ioasid_nb_pending_list);
+
+exit_unlock:
+	spin_unlock(&ioasid_nb_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(ioasid_register_notifier_mm);
+
+void ioasid_unregister_notifier_mm(struct mm_struct *mm, struct notifier_block *nb)
+{
+	struct ioasid_set_nb *curr;
+
+	spin_lock(&ioasid_nb_lock);
+	list_for_each_entry(curr, &ioasid_nb_pending_list, list) {
+		if (curr->token == mm && curr->nb == nb) {
+			list_del(&curr->list);
+			goto exit_free;
+		}
+	}
+	pr_warn("No ioasid set found for mm token %llx\n",  (u64)mm);
+	goto done_unlock;
+
+exit_free:
+	if (curr->active) {
+		pr_debug("mm set active, unregister %llx\n",
+			(u64)mm);
+		atomic_notifier_chain_unregister(&curr->set->nh, nb);
+	}
+	kfree(curr);
+done_unlock:
+	spin_unlock(&ioasid_nb_lock);
+	return;
+}
+EXPORT_SYMBOL_GPL(ioasid_unregister_notifier_mm);
+
+/**
+ * ioasid_notify - Send notification on a given IOASID for status change.
+ *                 Used by publishers when the status change may affect
+ *                 subscriber's internal state.
+ *
+ * @ioasid:	The IOASID to which the notification will send
+ * @cmd:	The notification event
+ * @flags:	Special instructions, e.g. notify with a set or global
+ */
+int ioasid_notify(ioasid_t ioasid, enum ioasid_notify_val cmd, unsigned int flags)
+{
+	struct ioasid_data *ioasid_data;
+	struct ioasid_nb_args args = { 0 };
+	int ret = 0;
+
+	spin_lock(&ioasid_allocator_lock);
+	ioasid_data = xa_load(&active_allocator->xa, ioasid);
+	if (!ioasid_data) {
+		pr_err("Trying to notify unknown IOASID %u\n", ioasid);
+		spin_unlock(&ioasid_allocator_lock);
+		return -EINVAL;
+	}
+
+	args.id = ioasid;
+	args.set = ioasid_data->set;
+	args.pdata = ioasid_data->private;
+	args.spid = ioasid_data->spid;
+	if (flags & IOASID_NOTIFY_ALL) {
+		ret = atomic_notifier_call_chain(&ioasid_chain, cmd, &args);
+	} else if (flags & IOASID_NOTIFY_SET) {
+		ret = atomic_notifier_call_chain(&ioasid_data->set->nh,
+						 cmd, &args);
+	}
+	spin_unlock(&ioasid_allocator_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(ioasid_notify);
+
 MODULE_AUTHOR("Jean-Philippe Brucker <jean-philippe.brucker@arm.com>");
 MODULE_AUTHOR("Jacob Pan <jacob.jun.pan@linux.intel.com>");
 MODULE_DESCRIPTION("IO Address Space ID (IOASID) allocator");
diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
index d4b3e83672f6..572111cd3b4b 100644
--- a/include/linux/ioasid.h
+++ b/include/linux/ioasid.h
@@ -23,6 +23,7 @@ enum ioasid_set_type {
  * struct ioasid_set - Meta data about ioasid_set
  * @type:	Token types and other features
  * @token:	Unique to identify an IOASID set
+ * @nh:		Notifier for IOASID events within the set
  * @xa:		XArray to store ioasid_set private IDs, can be used for
  *		guest-host IOASID mapping, or just a private IOASID namespace.
  * @quota:	Max number of IOASIDs can be allocated within the set
@@ -32,6 +33,7 @@ enum ioasid_set_type {
  */
 struct ioasid_set {
 	void *token;
+	struct atomic_notifier_head nh;
 	struct xarray xa;
 	int type;
 	int quota;
@@ -56,6 +58,49 @@ struct ioasid_allocator_ops {
 	void *pdata;
 };
 
+/* Notification data when IOASID status changed */
+enum ioasid_notify_val {
+	IOASID_ALLOC = 1,
+	IOASID_FREE,
+	IOASID_BIND,
+	IOASID_UNBIND,
+	IOASID_SET_ALLOC,
+	IOASID_SET_FREE,
+};
+
+#define IOASID_NOTIFY_ALL BIT(0)
+#define IOASID_NOTIFY_SET BIT(1)
+/**
+ * enum ioasid_notifier_prios - IOASID event notification order
+ *
+ * When status of an IOASID changes, users might need to take actions to
+ * reflect the new state. For example, when an IOASID is freed due to
+ * exception, the hardware context in virtual CPU, DMA device, and IOMMU
+ * shall be cleared and drained. Order is required to prevent life cycle
+ * problems.
+ */
+enum ioasid_notifier_prios {
+	IOASID_PRIO_LAST,
+	IOASID_PRIO_DEVICE,
+	IOASID_PRIO_IOMMU,
+	IOASID_PRIO_CPU,
+};
+
+/**
+ * struct ioasid_nb_args - Argument provided by IOASID core when notifier
+ * is called.
+ * @id:		The IOASID being notified
+ * @spid:	The set private ID associated with the IOASID
+ * @set:	The IOASID set of @id
+ * @pdata:	The private data attached to the IOASID
+ */
+struct ioasid_nb_args {
+	ioasid_t id;
+	ioasid_t spid;
+	struct ioasid_set *set;
+	void *pdata;
+};
+
 #if IS_ENABLED(CONFIG_IOASID)
 void ioasid_install_capacity(ioasid_t total);
 ioasid_t ioasid_get_capacity(void);
@@ -75,8 +120,16 @@ void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid, bool (*getter)(void *
 int ioasid_attach_data(ioasid_t ioasid, void *data);
 int ioasid_attach_spid(ioasid_t ioasid, ioasid_t spid);
 ioasid_t ioasid_find_by_spid(struct ioasid_set *set, ioasid_t spid);
+
+int ioasid_register_notifier(struct ioasid_set *set,
+			struct notifier_block *nb);
+void ioasid_unregister_notifier(struct ioasid_set *set,
+				struct notifier_block *nb);
+
 int ioasid_register_allocator(struct ioasid_allocator_ops *allocator);
 void ioasid_unregister_allocator(struct ioasid_allocator_ops *allocator);
+
+int ioasid_notify(ioasid_t ioasid, enum ioasid_notify_val cmd, unsigned int flags);
 void ioasid_is_in_set(struct ioasid_set *set, ioasid_t ioasid);
 int ioasid_get(struct ioasid_set *set, ioasid_t ioasid);
 int ioasid_get_locked(struct ioasid_set *set, ioasid_t ioasid);
@@ -85,6 +138,9 @@ void ioasid_put_locked(struct ioasid_set *set, ioasid_t ioasid);
 int ioasid_set_for_each_ioasid(struct ioasid_set *sdata,
 			       void (*fn)(ioasid_t id, void *data),
 			       void *data);
+int ioasid_register_notifier_mm(struct mm_struct *mm, struct notifier_block *nb);
+void ioasid_unregister_notifier_mm(struct mm_struct *mm, struct notifier_block *nb);
+
 #else /* !CONFIG_IOASID */
 static inline void ioasid_install_capacity(ioasid_t total)
 {
@@ -124,6 +180,20 @@ static inline void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid, bool (*
 	return NULL;
 }
 
+static inline int ioasid_register_notifier(struct notifier_block *nb)
+{
+	return -ENOTSUPP;
+}
+
+static inline void ioasid_unregister_notifier(struct notifier_block *nb)
+{
+}
+
+static inline int ioasid_notify(ioasid_t ioasid, enum ioasid_notify_val cmd, unsigned int flags)
+{
+	return -ENOTSUPP;
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
