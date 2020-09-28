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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E968C47425
	for <iommu@archiver.kernel.org>; Mon, 28 Sep 2020 21:37:02 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05F312083B
	for <iommu@archiver.kernel.org>; Mon, 28 Sep 2020 21:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IB+nqXH8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05F312083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A5CCC858C6;
	Mon, 28 Sep 2020 21:37:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tJmzL-9-LDMX; Mon, 28 Sep 2020 21:37:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C6E08858F7;
	Mon, 28 Sep 2020 21:36:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A9623C1AD7;
	Mon, 28 Sep 2020 21:36:59 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ECDAFC1AD7
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 21:36:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id DBF3487093
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 21:36:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lc1x0ORGB7u5 for <iommu@lists.linux-foundation.org>;
 Mon, 28 Sep 2020 21:36:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com
 [209.85.215.194])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 36BD08708F
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 21:36:54 +0000 (UTC)
Received: by mail-pg1-f194.google.com with SMTP id 34so2034109pgo.13
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 14:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=0VNflzOyKJDouCud0picP6wYZjX9Ua4i7l764OZICM8=;
 b=IB+nqXH8/Ev0X4HeTmPN8SZYS754bLGnkBj5Lct14pNRT9/UKsRz/V2LFPn7LOceQG
 vVqrkkz1/puqoi5Zf8iKXrlYx6uByFULsgSrfVmraZdegMB2VT46QxW1vndMFwErgXTj
 MIcgza7ehvpAtNYqB95pGnpzB/UYUlsbY/oEkw3Gntnxcpz/ZZG+Kc/8vqS74k9uUPOb
 b1rppJF7KgTmvH+CbQkgiL5wX6tt9hNXXxeH3vSZfy6GHYWXYJM5uq41mwr8ehTTI5KT
 TQ14n8IxwP1lgQNvit4P2QB5rdUA2JzPrv2QTg3ZfcSR/nXyI1/rs8MuWDYJjjJps90N
 +0YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=0VNflzOyKJDouCud0picP6wYZjX9Ua4i7l764OZICM8=;
 b=eRB+USALaibrUP+QgzjOEo68Rh29EVwKF+NX+hZHJh9vM0kpvB0pQUN2fEsFwhJ0il
 BttRoFi3kW+eCQG7qsEyGud/L08nkua3eUL0LGZ73MRwTWnhxkE1si9hxsN6PtC62pKK
 0VArNY7I8FB/rIdx1RFlTqpogAqWDwWde1eeMmJXYddtupA4uOKFlV1Nys2Gs8KiVfoi
 dLEc1JdpHnoD4Ymc1bDSN16BAh4Ml39fU957sowMV8O0zEfn6ZnnyEudFcymYrQntmwA
 Lq8vo9SyshTiSYJIinDpIkZpA2A8L920bsU4JYbQTcJcQVEp+2vPuMNcGBv2sSpDPjwR
 /0mA==
X-Gm-Message-State: AOAM530txgMnin3wzWxwkrogHHP5STTHLOJWSRNX5x6uBWw/+5OvG9us
 pnmBCElRADclUN98R4+gUYuFHLw3P80=
X-Google-Smtp-Source: ABdhPJyN0AGs4yJhjYycm/0Nepx35dklx4xC7RepgnKoEUnRZq4rWEiBGv96T2lnza4ujIwp6Fksbw==
X-Received: by 2002:a65:5902:: with SMTP id f2mr725734pgu.379.1601329013998;
 Mon, 28 Sep 2020 14:36:53 -0700 (PDT)
Received: from jacob-builder.jf.intel.com (jfdmzpr04-ext.jf.intel.com.
 [134.134.137.73])
 by smtp.gmail.com with ESMTPSA id l11sm2220864pjf.17.2020.09.28.14.36.53
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 28 Sep 2020 14:36:53 -0700 (PDT)
From: Jacob Pan <jacob.pan.linux@gmail.com>
X-Google-Original-From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Lu Baolu" <baolu.lu@linux.intel.com>,
 David Woodhouse <dwmw2@infradead.org>, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v3 09/14] iommu/ioasid: Introduce ioasid_set private ID
Date: Mon, 28 Sep 2020 14:38:36 -0700
Message-Id: <1601329121-36979-10-git-send-email-jacob.jun.pan@linux.intel.com>
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

When an IOASID set is used for guest SVA, each VM will acquire its
ioasid_set for IOASID allocations. IOASIDs within the VM must have a
host/physical IOASID backing, mapping between guest and host IOASIDs can
be non-identical. IOASID set private ID (SPID) is introduced in this
patch to be used as guest IOASID. However, the concept of ioasid_set
specific namespace is generic, thus named SPID.

As SPID namespace is within the IOASID set, the IOASID core can provide
lookup services at both directions. SPIDs may not be available when its
IOASID is allocated, the mapping between SPID and IOASID is usually
established when a guest page table is bound to a host PASID.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/ioasid.c | 102 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/ioasid.h |  19 +++++++++
 2 files changed, 121 insertions(+)

diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
index 828cc44b1b1c..378fef8f23d9 100644
--- a/drivers/iommu/ioasid.c
+++ b/drivers/iommu/ioasid.c
@@ -26,6 +26,7 @@ enum ioasid_state {
  * struct ioasid_data - Meta data about ioasid
  *
  * @id:		Unique ID
+ * @spid:	Private ID unique within a set
  * @users:	Number of active users
  * @state:	Track state of the IOASID
  * @set:	ioasid_set of the IOASID belongs to
@@ -34,6 +35,7 @@ enum ioasid_state {
  */
 struct ioasid_data {
 	ioasid_t id;
+	ioasid_t spid;
 	refcount_t users;
 	enum ioasid_state state;
 	struct ioasid_set *set;
@@ -363,6 +365,105 @@ void ioasid_detach_data(ioasid_t ioasid)
 }
 EXPORT_SYMBOL_GPL(ioasid_detach_data);
 
+static ioasid_t ioasid_find_by_spid_locked(struct ioasid_set *set, ioasid_t spid)
+{
+	ioasid_t ioasid = INVALID_IOASID;
+	struct ioasid_data *entry;
+	unsigned long index;
+
+	if (!xa_load(&ioasid_sets, set->id)) {
+		pr_warn("Invalid set\n");
+		goto done;
+	}
+
+	xa_for_each(&set->xa, index, entry) {
+		if (spid == entry->spid) {
+			refcount_inc(&entry->users);
+			ioasid = index;
+		}
+	}
+done:
+	return ioasid;
+}
+
+/**
+ * ioasid_attach_spid - Attach ioasid_set private ID to an IOASID
+ *
+ * @ioasid: the system-wide IOASID to attach
+ * @spid:   the ioasid_set private ID of @ioasid
+ *
+ * After attching SPID, future lookup can be done via ioasid_find_by_spid().
+ */
+int ioasid_attach_spid(ioasid_t ioasid, ioasid_t spid)
+{
+	struct ioasid_data *data;
+	int ret = 0;
+
+	if (spid == INVALID_IOASID)
+		return -EINVAL;
+
+	spin_lock(&ioasid_allocator_lock);
+	data = xa_load(&active_allocator->xa, ioasid);
+
+	if (!data) {
+		pr_err("No IOASID entry %d to attach SPID %d\n",
+			ioasid, spid);
+		ret = -ENOENT;
+		goto done_unlock;
+	}
+	/* Check if SPID is unique within the set */
+	if (ioasid_find_by_spid_locked(data->set, spid) != INVALID_IOASID) {
+		ret = -EINVAL;
+		goto done_unlock;
+	}
+	data->spid = spid;
+
+done_unlock:
+	spin_unlock(&ioasid_allocator_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(ioasid_attach_spid);
+
+void ioasid_detach_spid(ioasid_t ioasid)
+{
+	struct ioasid_data *data;
+
+	spin_lock(&ioasid_allocator_lock);
+	data = xa_load(&active_allocator->xa, ioasid);
+
+	if (!data || data->spid == INVALID_IOASID) {
+		pr_err("Invalid IOASID entry %d to detach\n", ioasid);
+		goto done_unlock;
+	}
+	data->spid = INVALID_IOASID;
+
+done_unlock:
+	spin_unlock(&ioasid_allocator_lock);
+}
+EXPORT_SYMBOL_GPL(ioasid_detach_spid);
+
+/**
+ * ioasid_find_by_spid - Find the system-wide IOASID by a set private ID and
+ * its set.
+ *
+ * @set:	the ioasid_set to search within
+ * @spid:	the set private ID
+ *
+ * Given a set private ID and its IOASID set, find the system-wide IOASID. Take
+ * a reference upon finding the matching IOASID. Return INVALID_IOASID if the
+ * IOASID is not found in the set or the set is not valid.
+ */
+ioasid_t ioasid_find_by_spid(struct ioasid_set *set, ioasid_t spid)
+{
+	ioasid_t ioasid;
+
+	spin_lock(&ioasid_allocator_lock);
+	ioasid = ioasid_find_by_spid_locked(set, spid);
+	spin_unlock(&ioasid_allocator_lock);
+	return ioasid;
+}
+EXPORT_SYMBOL_GPL(ioasid_find_by_spid);
+
 static inline bool ioasid_set_is_valid(struct ioasid_set *set)
 {
 	return xa_load(&ioasid_sets, set->id) == set;
@@ -529,6 +630,7 @@ ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
 		goto exit_free;
 	}
 	data->id = id;
+	data->spid = INVALID_IOASID;
 	data->state = IOASID_STATE_ACTIVE;
 	refcount_set(&data->users, 1);
 
diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
index 16d421357173..2dfe85e6cb7e 100644
--- a/include/linux/ioasid.h
+++ b/include/linux/ioasid.h
@@ -79,6 +79,10 @@ bool ioasid_put(struct ioasid_set *set, ioasid_t ioasid);
 bool ioasid_put_locked(struct ioasid_set *set, ioasid_t ioasid);
 int ioasid_attach_data(ioasid_t ioasid, void *data);
 void ioasid_detach_data(ioasid_t ioasid);
+int ioasid_attach_spid(ioasid_t ioasid, ioasid_t spid);
+void ioasid_detach_spid(ioasid_t ioasid);
+ioasid_t ioasid_find_by_spid(struct ioasid_set *set, ioasid_t spid);
+
 void ioasid_set_for_each_ioasid(struct ioasid_set *sdata,
 				void (*fn)(ioasid_t id, void *data),
 				void *data);
@@ -159,6 +163,21 @@ static inline void ioasid_detach_data(ioasid_t ioasid)
 {
 }
 
+static inline int ioasid_attach_spid(ioasid_t ioasid, ioasid_t spid)
+{
+	return -ENOTSUPP;
+}
+
+static inline void ioasid_detach_spid(ioasid_t ioasid)
+{
+}
+
+static inline ioasid_t ioasid_find_by_spid(struct ioasid_set *set,
+					   ioasid_t spid)
+{
+	return INVALID_IOASID;
+}
+
 static inline void ioasid_set_for_each_ioasid(struct ioasid_set *sdata,
 					      void (*fn)(ioasid_t id, void *data),
 					      void *data)
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
