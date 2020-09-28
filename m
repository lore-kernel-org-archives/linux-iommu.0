Return-Path: <SRS0=rmn6=DF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0574C4727C
	for <iommu@archiver.kernel.org>; Mon, 28 Sep 2020 21:36:54 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7A42208FE
	for <iommu@archiver.kernel.org>; Mon, 28 Sep 2020 21:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kb9q23sP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7A42208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7ED2F8707B;
	Mon, 28 Sep 2020 21:36:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id coMP8w8fQq1n; Mon, 28 Sep 2020 21:36:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 710678708E;
	Mon, 28 Sep 2020 21:36:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4ED52C1AD7;
	Mon, 28 Sep 2020 21:36:53 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8CEF8C0051
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 21:36:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 86E4385521
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 21:36:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2zEaDfRIyYEM for <iommu@lists.linux-foundation.org>;
 Mon, 28 Sep 2020 21:36:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com
 [209.85.216.67])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id F31E684DE6
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 21:36:48 +0000 (UTC)
Received: by mail-pj1-f67.google.com with SMTP id a9so1497231pjg.1
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 14:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=WrycSqfFwgro1544B9fdHLaLNfHVDac357G1kt17GJI=;
 b=Kb9q23sPGgUyP1xOwc0nnzQiUdt/USvAEWwpN+/lGcIlI6oMtrG86vMz3EyuyQqUjn
 g9Qm6QuwloJc1YYvC4woVROgE2cCnCEp6/3ZDlxttDDXXCTc+2kYbc8Ai0+kOkUfErzk
 xxvqeQOSAWD6qfw4taneDEwBsVN1wOeem3XuHcb0l9v0M3purNhB5gxZObpoznaQhtJl
 ink3pH9NrfwppGXN3UMO1ukXAXq1OBfm/6ShSgXeH99YFe10iVU9YG+E6EB7p0iKB2El
 p7L1Q8ACluZWnY+FgaLDwUzCkrhF4z/n5qHeq3BLs5w8VwbOmilgpZbOl5az3JvgqfK0
 yNSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=WrycSqfFwgro1544B9fdHLaLNfHVDac357G1kt17GJI=;
 b=W6/aBleg5VraUkNPVr7dHRukA0TxmQwHuXoDYEkCDILCDb65QktcgR1LO84ZnBs6+H
 OULqvBp/P4dye3cE52o/s0ZIlGQCFEcU93TMPUzy76riDtdlcW7Per8Rr/SU2+/c3483
 AlJsO3IddeZ2OAbt8veN0YoOd04mh6z2GbKCoc1WQV11/vnlCo/MsftK9vPdUHxnYLPj
 XUU6aMXEQoaU3GJJmueapUtftKHnkCMvw7ZZLd6uGx+92Gyubr9Z1l1/AoCuv1XwuDLJ
 cl/0EngHQgDTCnDcZoTKyTv8Fcngqsh/xeA4X1EVYWwgNBQ2WrVJMUZ90sBCyVILUE3G
 LzuA==
X-Gm-Message-State: AOAM531vWe3p9wwMCzl/AnkuOYLHLC74Ay+ipCKIEDbYSs7rvuPLXpgQ
 XQ3OD4SJTVlNHvoiVnfh9FKdZGYlu3A=
X-Google-Smtp-Source: ABdhPJwfpXpe8calsKuaQ30f9foaawWHO3e8GwjwWs2Wem/63O+55jMMYsxr2+0Ly3E5r4jzAJEM6Q==
X-Received: by 2002:a17:90a:e015:: with SMTP id
 u21mr1011131pjy.33.1601329008375; 
 Mon, 28 Sep 2020 14:36:48 -0700 (PDT)
Received: from jacob-builder.jf.intel.com (jfdmzpr04-ext.jf.intel.com.
 [134.134.137.73])
 by smtp.gmail.com with ESMTPSA id l11sm2220864pjf.17.2020.09.28.14.36.47
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 28 Sep 2020 14:36:47 -0700 (PDT)
From: Jacob Pan <jacob.pan.linux@gmail.com>
X-Google-Original-From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Lu Baolu" <baolu.lu@linux.intel.com>,
 David Woodhouse <dwmw2@infradead.org>, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v3 04/14] iommu/ioasid: Support setting system-wide capacity
Date: Mon, 28 Sep 2020 14:38:31 -0700
Message-Id: <1601329121-36979-5-git-send-email-jacob.jun.pan@linux.intel.com>
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

IOASID is a system-wide resource that could vary on different systems.
The default capacity is 20 bits as defined in the PCI-E specifications.
This patch adds a function to allow adjusting system IOASID capacity.
For VT-d this is set during boot as part of the Intel IOMMU
initialization.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel/iommu.c |  5 +++++
 drivers/iommu/ioasid.c      | 20 ++++++++++++++++++++
 include/linux/ioasid.h      | 11 +++++++++++
 3 files changed, 36 insertions(+)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 18ed3b3c70d7..e7bcb299e51e 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -42,6 +42,7 @@
 #include <linux/crash_dump.h>
 #include <linux/numa.h>
 #include <linux/swiotlb.h>
+#include <linux/ioasid.h>
 #include <asm/irq_remapping.h>
 #include <asm/cacheflush.h>
 #include <asm/iommu.h>
@@ -3331,6 +3332,10 @@ static int __init init_dmars(void)
 	if (ret)
 		goto free_iommu;
 
+	/* PASID is needed for scalable mode irrespective to SVM */
+	if (intel_iommu_sm)
+		ioasid_install_capacity(intel_pasid_max_id);
+
 	/*
 	 * for each drhd
 	 *   enable fault log
diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
index 6cfbdfb492e0..4277cb17e15b 100644
--- a/drivers/iommu/ioasid.c
+++ b/drivers/iommu/ioasid.c
@@ -10,6 +10,10 @@
 #include <linux/spinlock.h>
 #include <linux/xarray.h>
 
+/* Default to PCIe standard 20 bit PASID */
+#define PCI_PASID_MAX 0x100000
+static ioasid_t ioasid_capacity = PCI_PASID_MAX;
+static ioasid_t ioasid_capacity_avail = PCI_PASID_MAX;
 struct ioasid_data {
 	ioasid_t id;
 	struct ioasid_set *set;
@@ -17,6 +21,22 @@ struct ioasid_data {
 	struct rcu_head rcu;
 };
 
+void ioasid_install_capacity(ioasid_t total)
+{
+	if (ioasid_capacity && ioasid_capacity != PCI_PASID_MAX) {
+		pr_warn("IOASID capacity is already set.\n");
+		return;
+	}
+	ioasid_capacity = ioasid_capacity_avail = total;
+}
+EXPORT_SYMBOL_GPL(ioasid_install_capacity);
+
+ioasid_t ioasid_get_capacity(void)
+{
+	return ioasid_capacity;
+}
+EXPORT_SYMBOL_GPL(ioasid_get_capacity);
+
 /*
  * struct ioasid_allocator_data - Internal data structure to hold information
  * about an allocator. There are two types of allocators:
diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
index c7f649fa970a..7fc320656be2 100644
--- a/include/linux/ioasid.h
+++ b/include/linux/ioasid.h
@@ -32,6 +32,8 @@ struct ioasid_allocator_ops {
 #define DECLARE_IOASID_SET(name) struct ioasid_set name = { 0 }
 
 #if IS_ENABLED(CONFIG_IOASID)
+void ioasid_install_capacity(ioasid_t total);
+ioasid_t ioasid_get_capacity(void);
 ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
 		      void *private);
 void ioasid_free(ioasid_t ioasid);
@@ -42,6 +44,15 @@ void ioasid_unregister_allocator(struct ioasid_allocator_ops *allocator);
 int ioasid_attach_data(ioasid_t ioasid, void *data);
 void ioasid_detach_data(ioasid_t ioasid);
 #else /* !CONFIG_IOASID */
+static inline void ioasid_install_capacity(ioasid_t total)
+{
+}
+
+static inline ioasid_t ioasid_get_capacity(void)
+{
+	return 0;
+}
+
 static inline ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min,
 				    ioasid_t max, void *private)
 {
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
