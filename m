Return-Path: <SRS0=fUNI=5K=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC2EC2D0E8
	for <iommu@archiver.kernel.org>; Wed, 25 Mar 2020 17:49:57 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92EBB206F6
	for <iommu@archiver.kernel.org>; Wed, 25 Mar 2020 17:49:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92EBB206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8671586D19;
	Wed, 25 Mar 2020 17:49:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k4lLjMTS7BTN; Wed, 25 Mar 2020 17:49:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E003986D5B;
	Wed, 25 Mar 2020 17:49:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CE1D3C1D88;
	Wed, 25 Mar 2020 17:49:54 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 302EDC1D88
 for <iommu@lists.linux-foundation.org>; Wed, 25 Mar 2020 17:49:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 2274E203C8
 for <iommu@lists.linux-foundation.org>; Wed, 25 Mar 2020 17:49:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id O+4rPB20vdNQ for <iommu@lists.linux-foundation.org>;
 Wed, 25 Mar 2020 17:49:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by silver.osuosl.org (Postfix) with ESMTPS id B623C20551
 for <iommu@lists.linux-foundation.org>; Wed, 25 Mar 2020 17:49:50 +0000 (UTC)
IronPort-SDR: JCYEkEfPqEDBVV6Dhm7m5ZEg7B7Bmj5a+JUGmFMe65E8C9XAnCIf8Ut8+1A3hu4ft0v4em1u3o
 DnC6Mn1DPH3g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2020 10:49:49 -0700
IronPort-SDR: qKTvv5GSnA5h7dqv9DnrGdJZqJU8gD7hexGiDDXFQy5yYIbC1AU2gRqGWsrAJcoHVEJFEkb3MK
 ICEdMvGeLV8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,305,1580803200"; d="scan'208";a="393702216"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
 by orsmga004.jf.intel.com with ESMTP; 25 Mar 2020 10:49:48 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Lu Baolu" <baolu.lu@linux.intel.com>, iommu@lists.linux-foundation.org,
 LKML <linux-kernel@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
Subject: [PATCH 09/10] iommu/ioasid: Support ioasid_set quota adjustment
Date: Wed, 25 Mar 2020 10:55:30 -0700
Message-Id: <1585158931-1825-10-git-send-email-jacob.jun.pan@linux.intel.com>
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

IOASID set is allocated with an initial quota, at runtime there may be
needs to balance IOASID resources among different VMs/sets.

This patch adds a new API to adjust per set quota.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/ioasid.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/ioasid.h |  6 ++++++
 2 files changed, 50 insertions(+)

diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
index 27dce2cb5af2..5ac28862a1db 100644
--- a/drivers/iommu/ioasid.c
+++ b/drivers/iommu/ioasid.c
@@ -578,6 +578,50 @@ void ioasid_free_set(int sid, bool destroy_set)
 }
 EXPORT_SYMBOL_GPL(ioasid_free_set);
 
+/**
+ * ioasid_adjust_set - Adjust the quota of an IOASID set
+ * @quota:	Quota allowed in this set
+ * @sid:	IOASID set ID to be assigned
+ *
+ * Return 0 on success. If the new quota is smaller than the number of
+ * IOASIDs already allocated, -EINVAL will be returned. No change will be
+ * made to the existing quota.
+ */
+int ioasid_adjust_set(int sid, int quota)
+{
+	struct ioasid_set_data *sdata;
+	int ret = 0;
+
+	mutex_lock(&ioasid_allocator_lock);
+	sdata = xa_load(&ioasid_sets, sid);
+	if (!sdata || sdata->nr_ioasids > quota) {
+		pr_err("Failed to adjust IOASID set %d quota %d\n",
+			sid, quota);
+		ret = -EINVAL;
+		goto done_unlock;
+	}
+
+	if (quota >= ioasid_capacity_avail) {
+		ret = -ENOSPC;
+		goto done_unlock;
+	}
+
+	/* Return the delta back to system pool */
+	ioasid_capacity_avail += sdata->size - quota;
+
+	/*
+	 * May have a policy to prevent giving all available IOASIDs
+	 * to one set. But we don't enforce here, it should be in the
+	 * upper layers.
+	 */
+	sdata->size = quota;
+
+done_unlock:
+	mutex_unlock(&ioasid_allocator_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(ioasid_adjust_set);
 
 /**
  * ioasid_find - Find IOASID data
diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
index 32d032913828..6e7de6fb91bf 100644
--- a/include/linux/ioasid.h
+++ b/include/linux/ioasid.h
@@ -73,6 +73,7 @@ int ioasid_alloc_set(struct ioasid_set *token, ioasid_t quota, int *sid);
 void ioasid_free_set(int sid, bool destroy_set);
 int ioasid_find_sid(ioasid_t ioasid);
 int ioasid_notify(ioasid_t id, enum ioasid_notify_val cmd);
+int ioasid_adjust_set(int sid, int quota);
 
 #else /* !CONFIG_IOASID */
 static inline ioasid_t ioasid_alloc(int sid, ioasid_t min,
@@ -136,5 +137,10 @@ static inline int ioasid_alloc_system_set(int quota)
 	return -ENOTSUPP;
 }
 
+static inline int ioasid_adjust_set(int sid, int quota)
+{
+	return -ENOTSUPP;
+}
+
 #endif /* CONFIG_IOASID */
 #endif /* __LINUX_IOASID_H */
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
