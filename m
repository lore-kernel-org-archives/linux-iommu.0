Return-Path: <SRS0=Pr8R=H6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC8A1C433E6
	for <iommu@archiver.kernel.org>; Sun, 28 Feb 2021 06:33:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F2C564E55
	for <iommu@archiver.kernel.org>; Sun, 28 Feb 2021 06:33:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F2C564E55
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 465A26F9CE;
	Sun, 28 Feb 2021 06:33:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xpKXDiaD8qDC; Sun, 28 Feb 2021 06:33:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id BDA606F991;
	Sun, 28 Feb 2021 06:33:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 49BB2C0015;
	Sun, 28 Feb 2021 06:33:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2D6C1C0017
 for <iommu@lists.linux-foundation.org>; Sun, 28 Feb 2021 06:33:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8278E6F5A8
 for <iommu@lists.linux-foundation.org>; Sun, 28 Feb 2021 06:33:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KWT5gyiC9XEJ for <iommu@lists.linux-foundation.org>;
 Sun, 28 Feb 2021 06:33:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AFA3A6F5BC
 for <iommu@lists.linux-foundation.org>; Sun, 28 Feb 2021 06:33:11 +0000 (UTC)
IronPort-SDR: vz9ZvR5c9FbJ1yqWkiICSboLnA8KBHJnmEz1y7AvgKC8FozXA+LVQWOtQxOVxV0vg/53Up2cAP
 hRFiS8rME5hw==
X-IronPort-AV: E=McAfee;i="6000,8403,9908"; a="247624809"
X-IronPort-AV: E=Sophos;i="5.81,211,1610438400"; d="scan'208";a="247624809"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Feb 2021 22:33:10 -0800
IronPort-SDR: wwnUe/gQ2DURd1fuukWv5FTP+PhsRLJQVbgzAvyohgvnXCCQ/Z/PK+ojVCBdGiyw0lBhOibOA2
 sZ4cXi7/Va0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,211,1610438400"; d="scan'208";a="517029718"
Received: from otc-wp-03.jf.intel.com ([10.54.39.79])
 by orsmga004.jf.intel.com with ESMTP; 27 Feb 2021 22:33:09 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
 "Lu Baolu" <baolu.lu@linux.intel.com>,
 David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux-foundation.org,
 cgroups@vger.kernel.org, Tejun Heo <tj@kernel.org>,
 Li Zefan <lizefan@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
Subject: [PATCH V4 08/18] iommu/ioasid: Introduce ioasid_set private ID
Date: Sat, 27 Feb 2021 14:01:16 -0800
Message-Id: <1614463286-97618-9-git-send-email-jacob.jun.pan@linux.intel.com>
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
 drivers/iommu/ioasid.c | 104 +++++++++++++++++++++++++++++++++++++++++
 include/linux/ioasid.h |  18 +++++++
 2 files changed, 122 insertions(+)

diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
index 9a3ba157dec3..7707bb608bdd 100644
--- a/drivers/iommu/ioasid.c
+++ b/drivers/iommu/ioasid.c
@@ -26,6 +26,7 @@ enum ioasid_state {
  * struct ioasid_data - Meta data about ioasid
  *
  * @id:		Unique ID
+ * @spid:	Private ID unique within a set
  * @refs:	Number of active users
  * @state:	Track state of the IOASID
  * @set:	ioasid_set of the IOASID belongs to
@@ -34,6 +35,7 @@ enum ioasid_state {
  */
 struct ioasid_data {
 	ioasid_t id;
+	ioasid_t spid;
 	enum ioasid_state state;
 	struct ioasid_set *set;
 	void *private;
@@ -413,6 +415,107 @@ void ioasid_detach_data(ioasid_t ioasid)
 }
 EXPORT_SYMBOL_GPL(ioasid_detach_data);
 
+static ioasid_t ioasid_find_by_spid_locked(struct ioasid_set *set, ioasid_t spid, bool get)
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
+			if (get)
+				refcount_inc(&entry->refs);
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
+	if (ioasid_find_by_spid_locked(data->set, spid, false) != INVALID_IOASID) {
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
+ * @get:	flag indicates whether to take a reference once found
+ *
+ * Given a set private ID and its IOASID set, find the system-wide IOASID. Take
+ * a reference upon finding the matching IOASID if @get is true. Return
+ * INVALID_IOASID if the IOASID is not found in the set or the set is not valid.
+ */
+ioasid_t ioasid_find_by_spid(struct ioasid_set *set, ioasid_t spid, bool get)
+{
+	ioasid_t ioasid;
+
+	spin_lock(&ioasid_allocator_lock);
+	ioasid = ioasid_find_by_spid_locked(set, spid, get);
+	spin_unlock(&ioasid_allocator_lock);
+	return ioasid;
+}
+EXPORT_SYMBOL_GPL(ioasid_find_by_spid);
+
 static inline bool ioasid_set_is_valid(struct ioasid_set *set)
 {
 	return xa_load(&ioasid_sets, set->id) == set;
@@ -616,6 +719,7 @@ ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
 	}
 	data->id = id;
 	data->state = IOASID_STATE_IDLE;
+	data->spid = INVALID_IOASID;
 
 	/* Store IOASID in the per set data */
 	if (xa_err(xa_store(&set->xa, id, data, GFP_ATOMIC))) {
diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
index e7f3e6108724..dcab02886cb5 100644
--- a/include/linux/ioasid.h
+++ b/include/linux/ioasid.h
@@ -81,6 +81,9 @@ int ioasid_register_allocator(struct ioasid_allocator_ops *allocator);
 void ioasid_unregister_allocator(struct ioasid_allocator_ops *allocator);
 int ioasid_attach_data(ioasid_t ioasid, void *data);
 void ioasid_detach_data(ioasid_t ioasid);
+int ioasid_attach_spid(ioasid_t ioasid, ioasid_t spid);
+void ioasid_detach_spid(ioasid_t ioasid);
+ioasid_t ioasid_find_by_spid(struct ioasid_set *set, ioasid_t spid, bool get);
 void ioasid_set_for_each_ioasid(struct ioasid_set *sdata,
 				void (*fn)(ioasid_t id, void *data),
 				void *data);
@@ -173,6 +176,21 @@ static inline struct ioasid_set *ioasid_find_set(ioasid_t ioasid)
 	return ERR_PTR(-ENOTSUPP);
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
+					   ioasid_t spid, bool get)
+{
+	return INVALID_IOASID;
+}
+
 static inline void ioasid_set_for_each_ioasid(struct ioasid_set *sdata,
 					      void (*fn)(ioasid_t id, void *data),
 					      void *data)
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
