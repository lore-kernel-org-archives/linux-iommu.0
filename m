Return-Path: <SRS0=KEvp=CA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 374C5C433DF
	for <iommu@archiver.kernel.org>; Sat, 22 Aug 2020 07:09:37 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05BE920724
	for <iommu@archiver.kernel.org>; Sat, 22 Aug 2020 07:09:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M6lPzDEH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05BE920724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id C053187A0D;
	Sat, 22 Aug 2020 07:09:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1K4LCuXioAeR; Sat, 22 Aug 2020 07:09:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 23F5387CE4;
	Sat, 22 Aug 2020 07:09:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 17BB6C07FF;
	Sat, 22 Aug 2020 07:09:34 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 347D8C0051
 for <iommu@lists.linux-foundation.org>; Sat, 22 Aug 2020 04:28:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 2008C203F1
 for <iommu@lists.linux-foundation.org>; Sat, 22 Aug 2020 04:28:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id p4zmN6sDumCq for <iommu@lists.linux-foundation.org>;
 Sat, 22 Aug 2020 04:28:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com
 [209.85.214.193])
 by silver.osuosl.org (Postfix) with ESMTPS id 4EC59203AE
 for <iommu@lists.linux-foundation.org>; Sat, 22 Aug 2020 04:28:30 +0000 (UTC)
Received: by mail-pl1-f193.google.com with SMTP id k13so1773430plk.13
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 21:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=fpF0Th5lLUO36CqDBVFyDlq5hvY4EE8QAVEqPKtMLqA=;
 b=M6lPzDEHKZbJWURiDOYBdH6Rzq5aLQW0NdQyGZRqZGcfHNnp5LoLfzhJ5fqhi/hDfU
 1DPj1heTzGWr99YG95x5/sS8PdBxgMEhfh1eLhd/rGnNYdRsL3SBnY4tHcaqn+55bN0S
 Q8a5ZZURiQ8/cmmSf8V8scON60KGpNbuSJ+vQG0Yyoz+ifkdvrDCKsn7Y4kIw8dgKtoq
 SRR1OHhOheDjbf/yQoChtJySv+8qY93gMRfw2mzTv6mn4vP3nWhexhwQJHQPoAzpAo9x
 F0z1qSZPZiIi0ZlxToWFtnxg8laGjYpD2Y6JNHUtqyz82j5LtDXjW9bIl+SO1Ef0NxPO
 ntBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=fpF0Th5lLUO36CqDBVFyDlq5hvY4EE8QAVEqPKtMLqA=;
 b=loI18P4G06CKJJ5A79gk3Si2zPWnuvPUGfVRTCZcjz++BNH0cCKfK71DlnIshzf32w
 pvFozq0YW2BoZ5+aKXJpAhZq2DlQ4VG80AxaJ6SZs0h898ecJPTZQhwwJSubAzVWGoc6
 WaiZ3vk5jLmqQGxHf0ezyDJm/c6XjsixD+zStV+hqzv30Wb1BG8cjMYNlPN/fwN+CGWT
 HcSKhwHBUCVKsQt0Qwly6SPdgqgofx46jchOB5QQkkEYmDd1xBGQfvUkRMdTqd06YJdx
 cwx+Tzs5vH/pnde442nYgplkhctT4sWCSE9gr2HmI9AwXTtfZQ4cOIlzLZc0zXfHIVGF
 Etdw==
X-Gm-Message-State: AOAM533vjwDJN2FLS0kTjMUaAMm/sl/u3/oNNHGV/c0xLcpbp5RIqGxq
 de8hr+NQvqmehVYY5KNoa540Pe7jZyoh7X5h
X-Google-Smtp-Source: ABdhPJzxEre7Xz6k4NV7lxKTwBithgZmi3bIbCB5yzDOkKpqjHbdllVFF9Rw3eMEz6nn09MwfIrdzw==
X-Received: by 2002:a17:902:a50e:: with SMTP id
 s14mr4666810plq.164.1598070509598; 
 Fri, 21 Aug 2020 21:28:29 -0700 (PDT)
Received: from jacob-builder.jf.intel.com ([192.55.55.43])
 by smtp.gmail.com with ESMTPSA id q5sm3341582pgi.31.2020.08.21.21.28.28
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 21 Aug 2020 21:28:29 -0700 (PDT)
From: Jacob Pan <jacob.pan.linux@gmail.com>
X-Google-Original-From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 "Lu Baolu" <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH v2 5/9] iommu/ioasid: Introduce ioasid_set private ID
Date: Fri, 21 Aug 2020 21:35:14 -0700
Message-Id: <1598070918-21321-6-git-send-email-jacob.jun.pan@linux.intel.com>
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

When an IOASID set is used for guest SVA, each VM will acquire its
ioasid_set for IOASID allocations. IOASIDs within the VM must have a
host/physical IOASID backing, mapping between guest and host IOASIDs can
be non-identical. IOASID set private ID (SPID) is introduced in this
patch to be used as guest IOASID. However, the concept of ioasid_set
specific namespace is generic, thus named SPID.

As SPID namespace is within the IOASID set, the IOASID core can provide
lookup services at both directions. SPIDs may not be allocated when its
IOASID is allocated, the mapping between SPID and IOASID is usually
established when a guest page table is bound to a host PASID.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/ioasid.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/ioasid.h | 12 +++++++++++
 2 files changed, 66 insertions(+)

diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
index 5f31d63c75b1..c0aef38a4fde 100644
--- a/drivers/iommu/ioasid.c
+++ b/drivers/iommu/ioasid.c
@@ -21,6 +21,7 @@ enum ioasid_state {
  * struct ioasid_data - Meta data about ioasid
  *
  * @id:		Unique ID
+ * @spid:	Private ID unique within a set
  * @users	Number of active users
  * @state	Track state of the IOASID
  * @set		Meta data of the set this IOASID belongs to
@@ -29,6 +30,7 @@ enum ioasid_state {
  */
 struct ioasid_data {
 	ioasid_t id;
+	ioasid_t spid;
 	struct ioasid_set *set;
 	refcount_t users;
 	enum ioasid_state state;
@@ -326,6 +328,58 @@ int ioasid_attach_data(ioasid_t ioasid, void *data)
 EXPORT_SYMBOL_GPL(ioasid_attach_data);
 
 /**
+ * ioasid_attach_spid - Attach ioasid_set private ID to an IOASID
+ *
+ * @ioasid: the ID to attach
+ * @spid:   the ioasid_set private ID of @ioasid
+ *
+ * For IOASID that is already allocated, private ID within the set can be
+ * attached via this API. Future lookup can be done via ioasid_find.
+ */
+int ioasid_attach_spid(ioasid_t ioasid, ioasid_t spid)
+{
+	struct ioasid_data *ioasid_data;
+	int ret = 0;
+
+	spin_lock(&ioasid_allocator_lock);
+	ioasid_data = xa_load(&active_allocator->xa, ioasid);
+
+	if (!ioasid_data) {
+		pr_err("No IOASID entry %d to attach SPID %d\n",
+			ioasid, spid);
+		ret = -ENOENT;
+		goto done_unlock;
+	}
+	ioasid_data->spid = spid;
+
+done_unlock:
+	spin_unlock(&ioasid_allocator_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(ioasid_attach_spid);
+
+ioasid_t ioasid_find_by_spid(struct ioasid_set *set, ioasid_t spid)
+{
+	struct ioasid_data *entry;
+	unsigned long index;
+
+	if (!xa_load(&ioasid_sets, set->sid)) {
+		pr_warn("Invalid set\n");
+		return INVALID_IOASID;
+	}
+
+	xa_for_each(&set->xa, index, entry) {
+		if (spid == entry->spid) {
+			pr_debug("Found ioasid %lu by spid %u\n", index, spid);
+			refcount_inc(&entry->users);
+			return index;
+		}
+	}
+	return INVALID_IOASID;
+}
+EXPORT_SYMBOL_GPL(ioasid_find_by_spid);
+
+/**
  * ioasid_alloc - Allocate an IOASID
  * @set: the IOASID set
  * @min: the minimum ID (inclusive)
diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
index 310abe4187a3..d4b3e83672f6 100644
--- a/include/linux/ioasid.h
+++ b/include/linux/ioasid.h
@@ -73,6 +73,8 @@ bool ioasid_is_active(ioasid_t ioasid);
 
 void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid, bool (*getter)(void *));
 int ioasid_attach_data(ioasid_t ioasid, void *data);
+int ioasid_attach_spid(ioasid_t ioasid, ioasid_t spid);
+ioasid_t ioasid_find_by_spid(struct ioasid_set *set, ioasid_t spid);
 int ioasid_register_allocator(struct ioasid_allocator_ops *allocator);
 void ioasid_unregister_allocator(struct ioasid_allocator_ops *allocator);
 void ioasid_is_in_set(struct ioasid_set *set, ioasid_t ioasid);
@@ -136,5 +138,15 @@ static inline int ioasid_attach_data(ioasid_t ioasid, void *data)
 	return -ENOTSUPP;
 }
 
+staic inline int ioasid_attach_spid(ioasid_t ioasid, ioasid_t spid)
+{
+	return -ENOTSUPP;
+}
+
+static inline ioasid_t ioasid_find_by_spid(struct ioasid_set *set, ioasid_t spid)
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
