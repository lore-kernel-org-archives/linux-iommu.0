Return-Path: <SRS0=rmn6=DF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F0CC4727F
	for <iommu@archiver.kernel.org>; Mon, 28 Sep 2020 21:37:01 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 343282083B
	for <iommu@archiver.kernel.org>; Mon, 28 Sep 2020 21:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MhU9Pjhy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 343282083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0F77085817;
	Mon, 28 Sep 2020 21:37:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lol8PhCI-vkM; Mon, 28 Sep 2020 21:36:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7EA5C858C6;
	Mon, 28 Sep 2020 21:36:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 69D2DC1AD6;
	Mon, 28 Sep 2020 21:36:59 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 96730C016F
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 21:36:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 7E77C86645
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 21:36:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8jwXIUe9kKNC for <iommu@lists.linux-foundation.org>;
 Mon, 28 Sep 2020 21:36:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com
 [209.85.210.195])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 8790A86661
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 21:36:53 +0000 (UTC)
Received: by mail-pf1-f195.google.com with SMTP id d6so2389615pfn.9
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 14:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=yei0j16GxAwc2LYHNKX/wuGB6g/wxiefyuN8CN5KOhA=;
 b=MhU9PjhyMf7MNclmE9Russh4LvaKfSInVEGZrrRsaACtJ7o+CqjrM2qqEXHfugFxcx
 4xmexKD6I9SIlhcjT14ashIvfQNP+Mn/+h+YB2GdlcEyo3aZD4VvMzpSpcWPh3MMbeYo
 wJcqiGj0Hx/DMgX/Gn6XAGtxJ3jPcAnQq4c68DEfsK+QZ/p49Dei9QbC1clDBGzRsBcb
 eCkyGtYhHXHnVM03n5tktZUnX4EPhMkYuCjnm7K2fX6Uemncm3a3NNrav3IAXKRDPbAK
 NRlW9IDDF4X+qHKz4qD12xSgbVxqKcb/NnKdw8j50diHXE8o0ZTLTSI7b4K5UbrZQUHe
 zpQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=yei0j16GxAwc2LYHNKX/wuGB6g/wxiefyuN8CN5KOhA=;
 b=FNY6joemebk+/wQPws1kvFEsa/q/dG2Rr8uCnFHJ8cZGmSRdgVavwJ0KpwEGCCvxhQ
 0KW6qIEg/4lB2mbirl6XeVlawI1QpDa+hA3UfYkUnMuIqI7OTGEtm5U7mOE7nJv9qFFB
 Jg5i/jq6kAXvgyS+2t+s/8NEW94PxGPMZcnBiEg4oF0q4z/Mmh4VxRO9XZ++ERPKfSEG
 i8ZMmon6zunsIU9GMTY05OHgxCOZhUMys2Y4dDa0QX3uFU1h4+/u1fViEHZgt7vHjjhK
 lwgM4WUvJnSz38gEen1m5GpyoBm6jmMAXDqB8sq2ayU3wsfRy8zosHsUYikXoOZEKdGf
 uXGA==
X-Gm-Message-State: AOAM531swtj6z2nsTruXFG/VGJY4+bSTVa1lV5D//9S/7UHpDujrdXLY
 MAvb2UixeVuz5Vd4Zl+F3+2GWyB2tik=
X-Google-Smtp-Source: ABdhPJx9T9NnJRyW+H0loFWwDE01pVod4Mng5pPkleA/hyh82iEdSLAAucXmylihIEBsiFhDJDFuZg==
X-Received: by 2002:a63:784:: with SMTP id 126mr792741pgh.428.1601329012945;
 Mon, 28 Sep 2020 14:36:52 -0700 (PDT)
Received: from jacob-builder.jf.intel.com (jfdmzpr04-ext.jf.intel.com.
 [134.134.137.73])
 by smtp.gmail.com with ESMTPSA id l11sm2220864pjf.17.2020.09.28.14.36.52
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 28 Sep 2020 14:36:52 -0700 (PDT)
From: Jacob Pan <jacob.pan.linux@gmail.com>
X-Google-Original-From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Lu Baolu" <baolu.lu@linux.intel.com>,
 David Woodhouse <dwmw2@infradead.org>, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v3 08/14] iommu/ioasid: Add reference couting functions
Date: Mon, 28 Sep 2020 14:38:35 -0700
Message-Id: <1601329121-36979-9-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1601329121-36979-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1601329121-36979-1-git-send-email-jacob.jun.pan@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Raj Ashok <ashok.raj@intel.com>, linux-api@vger.kernel.org,
 Randy Dunlap <rdunlap@infradead.org>, Yi Sun <yi.y.sun@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>, Wu Hao <hao.wu@intel.com>
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

There can be multiple users of an IOASID, each user could have hardware
contexts associated with the IOASID. In order to align lifecycles,
reference counting is introduced in this patch. It is expected that when
an IOASID is being freed, each user will drop a reference only after its
context is cleared.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/ioasid.c | 117 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/ioasid.h |  24 ++++++++++
 2 files changed, 141 insertions(+)

diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
index 9628e78b2ab4..828cc44b1b1c 100644
--- a/drivers/iommu/ioasid.c
+++ b/drivers/iommu/ioasid.c
@@ -16,8 +16,26 @@ static ioasid_t ioasid_capacity = PCI_PASID_MAX;
 static ioasid_t ioasid_capacity_avail = PCI_PASID_MAX;
 static DEFINE_XARRAY_ALLOC(ioasid_sets);
 
+enum ioasid_state {
+	IOASID_STATE_INACTIVE,
+	IOASID_STATE_ACTIVE,
+	IOASID_STATE_FREE_PENDING,
+};
+
+/**
+ * struct ioasid_data - Meta data about ioasid
+ *
+ * @id:		Unique ID
+ * @users:	Number of active users
+ * @state:	Track state of the IOASID
+ * @set:	ioasid_set of the IOASID belongs to
+ * @private:	Private data associated with the IOASID
+ * @rcu:	For free after RCU grace period
+ */
 struct ioasid_data {
 	ioasid_t id;
+	refcount_t users;
+	enum ioasid_state state;
 	struct ioasid_set *set;
 	void *private;
 	struct rcu_head rcu;
@@ -511,6 +529,8 @@ ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
 		goto exit_free;
 	}
 	data->id = id;
+	data->state = IOASID_STATE_ACTIVE;
+	refcount_set(&data->users, 1);
 
 	/* Store IOASID in the per set data */
 	if (xa_err(xa_store(&set->xa, id, data, GFP_ATOMIC))) {
@@ -560,6 +580,14 @@ static void ioasid_free_locked(struct ioasid_set *set, ioasid_t ioasid)
 	if (WARN_ON(!xa_load(&ioasid_sets, data->set->id)))
 		return;
 
+	/* Free is already in progress */
+	if (data->state == IOASID_STATE_FREE_PENDING)
+		return;
+
+	data->state = IOASID_STATE_FREE_PENDING;
+	if (!refcount_dec_and_test(&data->users))
+		return;
+
 	ioasid_do_free_locked(data);
 }
 
@@ -717,6 +745,95 @@ void ioasid_set_for_each_ioasid(struct ioasid_set *set,
 }
 EXPORT_SYMBOL_GPL(ioasid_set_for_each_ioasid);
 
+int ioasid_get_locked(struct ioasid_set *set, ioasid_t ioasid)
+{
+	struct ioasid_data *data;
+
+	data = xa_load(&active_allocator->xa, ioasid);
+	if (!data) {
+		pr_err("Trying to get unknown IOASID %u\n", ioasid);
+		return -EINVAL;
+	}
+	if (data->state == IOASID_STATE_FREE_PENDING) {
+		pr_err("Trying to get IOASID being freed%u\n", ioasid);
+		return -EBUSY;
+	}
+
+	/* Check set ownership if the set is non-null */
+	if (set && data->set != set) {
+		pr_err("Trying to get IOASID %u outside the set\n", ioasid);
+		/* data found but does not belong to the set */
+		return -EACCES;
+	}
+	refcount_inc(&data->users);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ioasid_get_locked);
+
+/**
+ * ioasid_get - Obtain a reference to an ioasid
+ * @set:	the ioasid_set to check permission against if not NULL
+ * @ioasid:	the ID to remove
+ *
+ *
+ * Return: 0 on success, error if failed.
+ */
+int ioasid_get(struct ioasid_set *set, ioasid_t ioasid)
+{
+	int ret;
+
+	spin_lock(&ioasid_allocator_lock);
+	ret = ioasid_get_locked(set, ioasid);
+	spin_unlock(&ioasid_allocator_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(ioasid_get);
+
+bool ioasid_put_locked(struct ioasid_set *set, ioasid_t ioasid)
+{
+	struct ioasid_data *data;
+
+	data = xa_load(&active_allocator->xa, ioasid);
+	if (!data) {
+		pr_err("Trying to put unknown IOASID %u\n", ioasid);
+		return false;
+	}
+	if (set && data->set != set) {
+		pr_err("Trying to drop IOASID %u outside the set\n", ioasid);
+		return false;
+	}
+	if (!refcount_dec_and_test(&data->users))
+		return false;
+
+	ioasid_do_free_locked(data);
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(ioasid_put_locked);
+
+/**
+ * ioasid_put - Release a reference to an ioasid
+ * @set:	the ioasid_set to check permission against if not NULL
+ * @ioasid:	the ID to remove
+ *
+ * Put a reference to the IOASID, free it when the number of references drops to
+ * zero.
+ *
+ * Return: %true if the IOASID was freed, %false otherwise.
+ */
+bool ioasid_put(struct ioasid_set *set, ioasid_t ioasid)
+{
+	bool ret;
+
+	spin_lock(&ioasid_allocator_lock);
+	ret = ioasid_put_locked(set, ioasid);
+	spin_unlock(&ioasid_allocator_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(ioasid_put);
+
 /**
  * ioasid_find - Find IOASID data
  * @set: the IOASID set
diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
index aab58bc26714..16d421357173 100644
--- a/include/linux/ioasid.h
+++ b/include/linux/ioasid.h
@@ -73,6 +73,10 @@ void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
 		  bool (*getter)(void *));
 int ioasid_register_allocator(struct ioasid_allocator_ops *allocator);
 void ioasid_unregister_allocator(struct ioasid_allocator_ops *allocator);
+int ioasid_get(struct ioasid_set *set, ioasid_t ioasid);
+int ioasid_get_locked(struct ioasid_set *set, ioasid_t ioasid);
+bool ioasid_put(struct ioasid_set *set, ioasid_t ioasid);
+bool ioasid_put_locked(struct ioasid_set *set, ioasid_t ioasid);
 int ioasid_attach_data(ioasid_t ioasid, void *data);
 void ioasid_detach_data(ioasid_t ioasid);
 void ioasid_set_for_each_ioasid(struct ioasid_set *sdata,
@@ -112,6 +116,26 @@ static inline void ioasid_set_put(struct ioasid_set *set)
 {
 }
 
+static inline int ioasid_get(struct ioasid_set *set, ioasid_t ioasid)
+{
+	return -ENOTSUPP;
+}
+
+static inline int ioasid_get_locked(struct ioasid_set *set, ioasid_t ioasid)
+{
+	return -ENOTSUPP;
+}
+
+static inline bool ioasid_put(struct ioasid_set *set, ioasid_t ioasid)
+{
+	return false;
+}
+
+static inline bool ioasid_put_locked(struct ioasid_set *set, ioasid_t ioasid)
+{
+	return false;
+}
+
 static inline void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid, bool (*getter)(void *))
 {
 	return NULL;
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
