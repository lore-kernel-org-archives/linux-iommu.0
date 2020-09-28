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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12CCAC47427
	for <iommu@archiver.kernel.org>; Mon, 28 Sep 2020 21:36:57 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABF8021531
	for <iommu@archiver.kernel.org>; Mon, 28 Sep 2020 21:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XPHtpj/x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABF8021531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9127D87098;
	Mon, 28 Sep 2020 21:36:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XUIegXTF1nTh; Mon, 28 Sep 2020 21:36:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 02D088708F;
	Mon, 28 Sep 2020 21:36:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DA5D1C0891;
	Mon, 28 Sep 2020 21:36:55 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 58624C0051
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 21:36:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 3E79286668
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 21:36:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uNVou-OcQsTn for <iommu@lists.linux-foundation.org>;
 Mon, 28 Sep 2020 21:36:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com
 [209.85.215.193])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 70DB48665F
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 21:36:52 +0000 (UTC)
Received: by mail-pg1-f193.google.com with SMTP id 197so2052573pge.8
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 14:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=JJmT+wXDNgmHpDjA6Wjx651ekcEY2yxOz6JsHoiTC2s=;
 b=XPHtpj/xAaJjyziV9uUCZbopBjydUsAQm85HbGN9XN242XTj1VTZmgInoTDzMvtpjj
 SO75OlJk1Qqps448QZahHPvBHDaYYTNC3m+f1+7FMcb2upRsU9xA+n3wDJUChaVMv0G8
 tGWUmLpKn10ZWyqw/N2p2nUPjyIskGbVs//ejlAXtyMMAh/h5I4vvVUjOYCWkYgHwybQ
 iWTP5MZk71it+JLkusmAIW+j4u5M/Wh1w3b+D0VVAxl8dkKm0p7Yjlfz5qnm9w23lLjz
 nRYC9cY8T0j+hwpDfsiMWhlXr9sTxf0Q4y0GYzCGmEBBYI1FzoW5VxJRM0vrCjCXCao6
 zc5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=JJmT+wXDNgmHpDjA6Wjx651ekcEY2yxOz6JsHoiTC2s=;
 b=Cg54ypSdPh2pWcPfxFxMfyxLIP6D0fRbOfNPjvYOfjE7NbNpuIe1I2tAL77UyNn2Mi
 W5FQNSTv9f1QJEn+3+j0nDn7aP83LxL/wLNZ/oF4D/gVnreLi/do64NdFzAG8sgjcxqC
 CqwrQaypqxAG/UfP/n0HH4+U0D91o+RYI/BglTlfF5QjV+niST0pQ/WsNtp6Mdzu/NX2
 i5a3ZieQ1eXOg1NoJ6o0ntF1a9KPEwzg6a+NqmIzOJIIbx7zIhTVqNU9UanE9WMH1imi
 /A0pvn9JAvtZyg4fEswiXwvGTLzCH9C1tR/QXuthoDF0TNnlf+1lyC4CQ1S+N5S8S4yE
 o4jw==
X-Gm-Message-State: AOAM533dmQ1sPXmu+hEwBJrPqF0Yf5ImqZojZetaET6jzAlzm4nwup0D
 FBWS7mwBcpE/e3rZFPKy4Us9DMxp2UE=
X-Google-Smtp-Source: ABdhPJz2pmATJMgyHqSyYo2SPSRnU2JNB0/L1WajIRXqX0MDjnmGUy7mo2PGrKAkolcH0IWcZPipFg==
X-Received: by 2002:aa7:83d9:0:b029:138:b217:f347 with SMTP id
 j25-20020aa783d90000b0290138b217f347mr1356862pfn.0.1601329011768; 
 Mon, 28 Sep 2020 14:36:51 -0700 (PDT)
Received: from jacob-builder.jf.intel.com (jfdmzpr04-ext.jf.intel.com.
 [134.134.137.73])
 by smtp.gmail.com with ESMTPSA id l11sm2220864pjf.17.2020.09.28.14.36.50
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 28 Sep 2020 14:36:51 -0700 (PDT)
From: Jacob Pan <jacob.pan.linux@gmail.com>
X-Google-Original-From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Lu Baolu" <baolu.lu@linux.intel.com>,
 David Woodhouse <dwmw2@infradead.org>, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v3 07/14] iommu/ioasid: Add an iterator API for ioasid_set
Date: Mon, 28 Sep 2020 14:38:34 -0700
Message-Id: <1601329121-36979-8-git-send-email-jacob.jun.pan@linux.intel.com>
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

Users of an ioasid_set may not keep track of all the IOASIDs allocated
under the set. When collective actions are needed for each IOASIDs, it
is useful to iterate over all the IOASIDs within the set. For example,
when the ioasid_set is freed, the user might perform the same cleanup
operation on each IOASID.

This patch adds an API to iterate all the IOASIDs within the set.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/ioasid.c | 17 +++++++++++++++++
 include/linux/ioasid.h |  9 +++++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
index cf8c7d34e2de..9628e78b2ab4 100644
--- a/drivers/iommu/ioasid.c
+++ b/drivers/iommu/ioasid.c
@@ -701,6 +701,23 @@ int ioasid_adjust_set(struct ioasid_set *set, int quota)
 EXPORT_SYMBOL_GPL(ioasid_adjust_set);
 
 /**
+ * ioasid_set_for_each_ioasid - Iterate over all the IOASIDs within the set
+ *
+ * Caller must hold a reference of the set and handles its own locking.
+ */
+void ioasid_set_for_each_ioasid(struct ioasid_set *set,
+				void (*fn)(ioasid_t id, void *data),
+				void *data)
+{
+	struct ioasid_data *entry;
+	unsigned long index;
+
+	xa_for_each(&set->xa, index, entry)
+		fn(index, data);
+}
+EXPORT_SYMBOL_GPL(ioasid_set_for_each_ioasid);
+
+/**
  * ioasid_find - Find IOASID data
  * @set: the IOASID set
  * @ioasid: the IOASID to find
diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
index 0a5e82148eb9..aab58bc26714 100644
--- a/include/linux/ioasid.h
+++ b/include/linux/ioasid.h
@@ -75,6 +75,9 @@ int ioasid_register_allocator(struct ioasid_allocator_ops *allocator);
 void ioasid_unregister_allocator(struct ioasid_allocator_ops *allocator);
 int ioasid_attach_data(ioasid_t ioasid, void *data);
 void ioasid_detach_data(ioasid_t ioasid);
+void ioasid_set_for_each_ioasid(struct ioasid_set *sdata,
+				void (*fn)(ioasid_t id, void *data),
+				void *data);
 #else /* !CONFIG_IOASID */
 static inline void ioasid_install_capacity(ioasid_t total)
 {
@@ -131,5 +134,11 @@ static inline int ioasid_attach_data(ioasid_t ioasid, void *data)
 static inline void ioasid_detach_data(ioasid_t ioasid)
 {
 }
+
+static inline void ioasid_set_for_each_ioasid(struct ioasid_set *sdata,
+					      void (*fn)(ioasid_t id, void *data),
+					      void *data)
+{
+}
 #endif /* CONFIG_IOASID */
 #endif /* __LINUX_IOASID_H */
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
