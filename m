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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC07AC47426
	for <iommu@archiver.kernel.org>; Mon, 28 Sep 2020 21:36:56 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65C802083B
	for <iommu@archiver.kernel.org>; Mon, 28 Sep 2020 21:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BLa1n7jG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65C802083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 50BAE87090;
	Mon, 28 Sep 2020 21:36:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jriy-IRdKAZ8; Mon, 28 Sep 2020 21:36:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id B6B1187092;
	Mon, 28 Sep 2020 21:36:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9BCAEC0891;
	Mon, 28 Sep 2020 21:36:55 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C82F2C0051
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 21:36:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id C3A0286661
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 21:36:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w5Zh-e5ssby6 for <iommu@lists.linux-foundation.org>;
 Mon, 28 Sep 2020 21:36:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com
 [209.85.216.67])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 4DDC38665D
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 21:36:51 +0000 (UTC)
Received: by mail-pj1-f67.google.com with SMTP id fa1so1502592pjb.0
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 14:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=k4Am4rbSCn6s1LkiSoS1FQPjQrgQdxus6zxqbBBGArU=;
 b=BLa1n7jGZg/z/AUQhN1k1olzszjlGtanGPHXCxNRPvd1gwLxEQQE3EeiKA12Gq27x9
 pfkzTNhUWeK9uuZXFNLNsypwqnJXbyrClkTc2gNuacrAxshq+hYNNZZoEKJL8PXdjBQI
 gnp5UkwcdgU252d0esse9WI/D4jqX1yCT+ajbHg1rkQ9fscftyHh2ucis/aRf8TyP+Iu
 clw1O4Jms6UvgXvyxcWlTt0qXWPssWIcWPy+KSil9l7e1rB53dafFf5qN3fMtjtdolsz
 arJhJ+Yokn9KIRMB4FDebkuocwFmWHH3OjWc2qXGe2EPwlI9EzqF0txHvpktDhZabNys
 Arjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=k4Am4rbSCn6s1LkiSoS1FQPjQrgQdxus6zxqbBBGArU=;
 b=G2kVGPHiB6Hn48IwSpLcH/tOLLfgnYPHT/bSl5QDQDAXdRzzSKsuTvXAQ05HVAYWW9
 lkPDWnrV8kcSwaqPnW8MZMTQ0Gx4v92sKZvzxxTJSfaM8Fy81gj/vTBDYIOIOZ6nHoCV
 yMGStOnS2PqS3Z5NexaTHmo0BWi2LvOIfcqHhqxB6Onf7IJ2jodLENn6VvKsr3alOtXE
 0Qrtruuk8He8F3+UpxIbuMqMSx4bglcix+mOUubaLtCv4XRSZRgx5lH4GBjDg9dx886E
 IndksUiHrBBRkAVZNHoY4RrKk03GOpaaeT3Ap43lx5QNkEhAvdY/GqPI0RiiM7c/7EkB
 0Svw==
X-Gm-Message-State: AOAM531sq6Y4lXo95cK+3m9PFJStUW6orGgsC6cLJ0bviY846gvy4NSR
 cI1gB04ZwF1/keUEW6tuM/2yuHB9fYk=
X-Google-Smtp-Source: ABdhPJxD+IuFyRv5MbubVmcGTE/u2MkQTy5kQKm9WQW6pH4E0JT2qRuHJfzZN2fc4ohYKFdfxuqF1g==
X-Received: by 2002:a17:90b:611:: with SMTP id
 gb17mr1013905pjb.71.1601329010674; 
 Mon, 28 Sep 2020 14:36:50 -0700 (PDT)
Received: from jacob-builder.jf.intel.com (jfdmzpr04-ext.jf.intel.com.
 [134.134.137.73])
 by smtp.gmail.com with ESMTPSA id l11sm2220864pjf.17.2020.09.28.14.36.49
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 28 Sep 2020 14:36:50 -0700 (PDT)
From: Jacob Pan <jacob.pan.linux@gmail.com>
X-Google-Original-From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Lu Baolu" <baolu.lu@linux.intel.com>,
 David Woodhouse <dwmw2@infradead.org>, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v3 06/14] iommu/ioasid: Introduce API to adjust the quota of
 an ioasid_set
Date: Mon, 28 Sep 2020 14:38:33 -0700
Message-Id: <1601329121-36979-7-git-send-email-jacob.jun.pan@linux.intel.com>
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

Each ioasid_set is given a quota during allocation. As system
administrators balance resources among VMs, we shall support the
adjustment of quota at runtime. The new quota cannot be less than the
outstanding IOASIDs already allocated within the set. The extra quota
will be returned to the system-wide IOASID pool if the new quota is
smaller than the existing one.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/ioasid.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/ioasid.h |  6 ++++++
 2 files changed, 53 insertions(+)

diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
index 61e25c2375ab..cf8c7d34e2de 100644
--- a/drivers/iommu/ioasid.c
+++ b/drivers/iommu/ioasid.c
@@ -654,6 +654,53 @@ void ioasid_set_put(struct ioasid_set *set)
 EXPORT_SYMBOL_GPL(ioasid_set_put);
 
 /**
+ * ioasid_adjust_set - Adjust the quota of an IOASID set
+ * @set:	IOASID set to be assigned
+ * @quota:	Quota allowed in this set
+ *
+ * Return 0 on success. If the new quota is smaller than the number of
+ * IOASIDs already allocated, -EINVAL will be returned. No change will be
+ * made to the existing quota.
+ */
+int ioasid_adjust_set(struct ioasid_set *set, int quota)
+{
+	int ret = 0;
+
+	if (quota <= 0)
+		return -EINVAL;
+
+	spin_lock(&ioasid_allocator_lock);
+	if (set->nr_ioasids > quota) {
+		pr_err("New quota %d is smaller than outstanding IOASIDs %d\n",
+			quota, set->nr_ioasids);
+		ret = -EINVAL;
+		goto done_unlock;
+	}
+
+	if ((quota > set->quota) &&
+		(quota - set->quota > ioasid_capacity_avail)) {
+		ret = -ENOSPC;
+		goto done_unlock;
+	}
+
+	/* Return the delta back to system pool */
+	ioasid_capacity_avail += set->quota - quota;
+
+	/*
+	 * May have a policy to prevent giving all available IOASIDs
+	 * to one set. But we don't enforce here, it should be in the
+	 * upper layers.
+	 */
+	set->quota = quota;
+
+done_unlock:
+	spin_unlock(&ioasid_allocator_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(ioasid_adjust_set);
+
+/**
  * ioasid_find - Find IOASID data
  * @set: the IOASID set
  * @ioasid: the IOASID to find
diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
index 1ae213b660f0..0a5e82148eb9 100644
--- a/include/linux/ioasid.h
+++ b/include/linux/ioasid.h
@@ -62,6 +62,7 @@ struct ioasid_allocator_ops {
 void ioasid_install_capacity(ioasid_t total);
 ioasid_t ioasid_get_capacity(void);
 struct ioasid_set *ioasid_set_alloc(void *token, ioasid_t quota, int type);
+int ioasid_adjust_set(struct ioasid_set *set, int quota);
 void ioasid_set_get(struct ioasid_set *set);
 void ioasid_set_put(struct ioasid_set *set);
 
@@ -99,6 +100,11 @@ static inline struct ioasid_set *ioasid_set_alloc(void *token, ioasid_t quota, i
 	return ERR_PTR(-ENOTSUPP);
 }
 
+static inline int ioasid_adjust_set(struct ioasid_set *set, int quota)
+{
+	return -ENOTSUPP;
+}
+
 static inline void ioasid_set_put(struct ioasid_set *set)
 {
 }
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
