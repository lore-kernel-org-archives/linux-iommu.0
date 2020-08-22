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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F7CC433E1
	for <iommu@archiver.kernel.org>; Sat, 22 Aug 2020 07:09:38 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5353720724
	for <iommu@archiver.kernel.org>; Sat, 22 Aug 2020 07:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RV1DpLQk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5353720724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3A31D876DD;
	Sat, 22 Aug 2020 07:09:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3KQmu4vP7ioO; Sat, 22 Aug 2020 07:09:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 63BD387DA4;
	Sat, 22 Aug 2020 07:09:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 47AC3C088B;
	Sat, 22 Aug 2020 07:09:34 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 76361C0051
 for <iommu@lists.linux-foundation.org>; Sat, 22 Aug 2020 04:28:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 72F288869C
 for <iommu@lists.linux-foundation.org>; Sat, 22 Aug 2020 04:28:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rA5vkTQKRi9L for <iommu@lists.linux-foundation.org>;
 Sat, 22 Aug 2020 04:28:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com
 [209.85.210.194])
 by whitealder.osuosl.org (Postfix) with ESMTPS id F16F288691
 for <iommu@lists.linux-foundation.org>; Sat, 22 Aug 2020 04:28:28 +0000 (UTC)
Received: by mail-pf1-f194.google.com with SMTP id m8so2067362pfh.3
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 21:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=w7TbhItqwKixGiLvRC8dSaYe7kOA0K/CzHhPkWQGXvU=;
 b=RV1DpLQkpXzX35TlE91Ha03BuzgdBScDmkACaJqRjpLSeoB0IM1HGpcTnZwEArhZnL
 Pn4VrlsO/3QxDUCkMwgTkNqOC338rfS6UUbu145dBhoufkjzuZnNbW3DoWCb+1UuYIJ/
 1NOtV5B4rEO0UE+ndv2JctfFNW+SSHNMLpKd02hodc+BkBOS5cZMMbjoawe+xQMN8rMo
 YjTtzLdYN/KmqzQbpEStt32JsMJs0YS0woeR2+yoC1BDq6ruAakB0V6omRDgONiesk9U
 IElpJPeaVS9SHa7VhxLJ34rMWIdocxLVl3CScs9t/ruOPqX6FaMzbEmnNLLDDt4DeQ0Q
 1zBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=w7TbhItqwKixGiLvRC8dSaYe7kOA0K/CzHhPkWQGXvU=;
 b=P//G/jRVuvBivAls7+xpbV4ULILkTQ/0vGptUVc8K4GokTq7FetlACRm/Hh3VB9zSm
 FDuyr75ShiAq88HCm/j4pbG8CMQe36XUr/ADtSkgVx8UqfURPAfDkygez4fHQ9eklmB0
 ddkx2WqbRq3d3XaEtdU38pgYEiiYMgwoCvD6Ha9Zyb7dt8EkeHAgcRt8Ng7fJTvLj0R8
 4Um7JM1fna7vbW9Zre9ZZnysJw+kbHaCd6kz+evUNo9OX3Gh8vH+akzUISAKXKla0MzJ
 DkIh9ock68L2+UmwD70t/vnALDid+jujiJPySgmu6iKnirYY82mZg8YAYAaxzYYQ/VUz
 YGTg==
X-Gm-Message-State: AOAM5309/XvC+7faxgTivzWWXV0uloAPVcgZ7Gha8hIw/lrlfl4pojwB
 jDLGjR2yH7lYZxzHSIF1Gh47mKxtz+bQHhQL
X-Google-Smtp-Source: ABdhPJw8P/fGA7/XuCnSjCYDxJ7ntitIW85diUbooJayDLaJ9qWQzAPLK1euI9maNeQkFz49VlE5Bg==
X-Received: by 2002:aa7:8608:: with SMTP id p8mr4912348pfn.62.1598070508123;
 Fri, 21 Aug 2020 21:28:28 -0700 (PDT)
Received: from jacob-builder.jf.intel.com ([192.55.55.43])
 by smtp.gmail.com with ESMTPSA id q5sm3341582pgi.31.2020.08.21.21.28.26
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 21 Aug 2020 21:28:27 -0700 (PDT)
From: Jacob Pan <jacob.pan.linux@gmail.com>
X-Google-Original-From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 "Lu Baolu" <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH v2 4/9] iommu/ioasid: Add reference couting functions
Date: Fri, 21 Aug 2020 21:35:13 -0700
Message-Id: <1598070918-21321-5-git-send-email-jacob.jun.pan@linux.intel.com>
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

There can be multiple users of an IOASID, each user could have hardware
contexts associated with the IOASID. In order to align lifecycles,
reference counting is introduced in this patch. It is expected that when
an IOASID is being freed, each user will drop a reference only after its
context is cleared.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/ioasid.c | 113 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/ioasid.h |   4 ++
 2 files changed, 117 insertions(+)

diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
index f73b3dbfc37a..5f31d63c75b1 100644
--- a/drivers/iommu/ioasid.c
+++ b/drivers/iommu/ioasid.c
@@ -717,6 +717,119 @@ int ioasid_set_for_each_ioasid(struct ioasid_set *set,
 EXPORT_SYMBOL_GPL(ioasid_set_for_each_ioasid);
 
 /**
+ * IOASID refcounting rules
+ * - ioasid_alloc() set initial refcount to 1
+ *
+ * - ioasid_free() decrement and test refcount.
+ *     If refcount is 0, ioasid will be freed. Deleted from the system-wide
+ *     xarray as well as per set xarray. The IOASID will be returned to the
+ *     pool and available for new allocations.
+ *
+ *     If recount is non-zero, mark IOASID as IOASID_STATE_FREE_PENDING.
+ *     No new reference can be added. The IOASID is not returned to the pool
+ *     for reuse.
+ *     After free, ioasid_get() will return error but ioasid_find() and other
+ *     non refcount adding APIs will continue to work until the last reference
+ *     is dropped
+ *
+ * - ioasid_get() get a reference on an active IOASID
+ *
+ * - ioasid_put() decrement and test refcount of the IOASID.
+ *     If refcount is 0, ioasid will be freed. Deleted from the system-wide
+ *     xarray as well as per set xarray. The IOASID will be returned to the
+ *     pool and available for new allocations.
+ *     Do nothing if refcount is non-zero.
+ *
+ * - ioasid_find() does not take reference, caller must hold reference
+ *
+ * ioasid_free() can be called multiple times without error until all refs are
+ * dropped.
+ */
+
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
+	if (set && data->set != set) {
+		pr_err("Trying to get IOASID not in set%u\n", ioasid);
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
+ * ioasid_get - Obtain a reference of an ioasid
+ * @set
+ * @ioasid
+ *
+ * Check set ownership if @set is non-null.
+ */
+int ioasid_get(struct ioasid_set *set, ioasid_t ioasid)
+{
+	int ret = 0;
+
+	spin_lock(&ioasid_allocator_lock);
+	ret = ioasid_get_locked(set, ioasid);
+	spin_unlock(&ioasid_allocator_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(ioasid_get);
+
+void ioasid_put_locked(struct ioasid_set *set, ioasid_t ioasid)
+{
+	struct ioasid_data *data;
+
+	data = xa_load(&active_allocator->xa, ioasid);
+	if (!data) {
+		pr_err("Trying to put unknown IOASID %u\n", ioasid);
+		return;
+	}
+
+	if (set && data->set != set) {
+		pr_err("Trying to drop IOASID not in the set %u\n", ioasid);
+		return;
+	}
+
+	if (!refcount_dec_and_test(&data->users)) {
+		pr_debug("%s: IOASID %d has %d remainning users\n",
+			__func__, ioasid, refcount_read(&data->users));
+		return;
+	}
+	ioasid_do_free(data);
+}
+EXPORT_SYMBOL_GPL(ioasid_put_locked);
+
+/**
+ * ioasid_put - Drop a reference of an ioasid
+ * @set
+ * @ioasid
+ *
+ * Check set ownership if @set is non-null.
+ */
+void ioasid_put(struct ioasid_set *set, ioasid_t ioasid)
+{
+	spin_lock(&ioasid_allocator_lock);
+	ioasid_put_locked(set, ioasid);
+	spin_unlock(&ioasid_allocator_lock);
+}
+EXPORT_SYMBOL_GPL(ioasid_put);
+
+/**
  * ioasid_find - Find IOASID data
  * @set: the IOASID set
  * @ioasid: the IOASID to find
diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
index 412d025d440e..310abe4187a3 100644
--- a/include/linux/ioasid.h
+++ b/include/linux/ioasid.h
@@ -76,6 +76,10 @@ int ioasid_attach_data(ioasid_t ioasid, void *data);
 int ioasid_register_allocator(struct ioasid_allocator_ops *allocator);
 void ioasid_unregister_allocator(struct ioasid_allocator_ops *allocator);
 void ioasid_is_in_set(struct ioasid_set *set, ioasid_t ioasid);
+int ioasid_get(struct ioasid_set *set, ioasid_t ioasid);
+int ioasid_get_locked(struct ioasid_set *set, ioasid_t ioasid);
+void ioasid_put(struct ioasid_set *set, ioasid_t ioasid);
+void ioasid_put_locked(struct ioasid_set *set, ioasid_t ioasid);
 int ioasid_set_for_each_ioasid(struct ioasid_set *sdata,
 			       void (*fn)(ioasid_t id, void *data),
 			       void *data);
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
