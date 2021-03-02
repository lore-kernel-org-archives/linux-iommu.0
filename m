Return-Path: <SRS0=VFJV=IA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC423C433E6
	for <iommu@archiver.kernel.org>; Tue,  2 Mar 2021 18:45:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36CC864F2A
	for <iommu@archiver.kernel.org>; Tue,  2 Mar 2021 18:45:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36CC864F2A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EBD1443197;
	Tue,  2 Mar 2021 18:45:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4CJ6xqxkdbIV; Tue,  2 Mar 2021 18:45:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 000B243183;
	Tue,  2 Mar 2021 18:45:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E08A5C000A;
	Tue,  2 Mar 2021 18:45:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6F6A8C0001
 for <iommu@lists.linux-foundation.org>; Tue,  2 Mar 2021 18:45:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4B8B76072A
 for <iommu@lists.linux-foundation.org>; Tue,  2 Mar 2021 18:45:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PZFQ3xcqVWjy for <iommu@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 18:45:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9787460713
 for <iommu@lists.linux-foundation.org>; Tue,  2 Mar 2021 18:45:47 +0000 (UTC)
IronPort-SDR: LY+w9KXOn3slwHfS6V19vZ2B6Ouz8Myi6g9ktk8L+d4pTxyfWHbto/WbWbSHsCXkr9weAH4XGQ
 XwzmFewBTbHQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9911"; a="174575577"
X-IronPort-AV: E=Sophos;i="5.81,217,1610438400"; d="scan'208";a="174575577"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Mar 2021 10:45:47 -0800
IronPort-SDR: gbFYMDzugxJODBT+rPNQAgb/NGNuRbUxTazH2uMYYilnnA+eOY4uct7JsTJzK9GJQH4VYIADd/
 sRM5pMA4jqDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,217,1610438400"; d="scan'208";a="406158803"
Received: from otc-wp-03.jf.intel.com ([10.54.39.79])
 by orsmga007.jf.intel.com with ESMTP; 02 Mar 2021 10:45:47 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Joerg Roedel <joro@8bytes.org>, "Lu Baolu" <baolu.lu@linux.intel.com>,
 David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH v2 1/4] iommu/vt-d: Enable write protect for supervisor SVM
Date: Tue,  2 Mar 2021 02:13:57 -0800
Message-Id: <1614680040-1989-2-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1614680040-1989-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1614680040-1989-1-git-send-email-jacob.jun.pan@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 Sanjay Kumar <sanjay.k.kumar@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
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

Write protect bit, when set, inhibits supervisor writes to the read-only
pages. In supervisor shared virtual addressing (SVA), where page tables
are shared between CPU and DMA, IOMMU PASID entry WPE bit should match
CR0.WP bit in the CPU.
This patch sets WPE bit for supervisor PASIDs if CR0.WP is set.

Signed-off-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel/pasid.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 0cceaabc3ce6..0b7e0e726ade 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -410,6 +410,15 @@ static inline void pasid_set_sre(struct pasid_entry *pe)
 	pasid_set_bits(&pe->val[2], 1 << 0, 1);
 }
 
+/*
+ * Setup the WPE(Write Protect Enable) field (Bit 132) of a
+ * scalable mode PASID entry.
+ */
+static inline void pasid_set_wpe(struct pasid_entry *pe)
+{
+	pasid_set_bits(&pe->val[2], 1 << 4, 1 << 4);
+}
+
 /*
  * Setup the P(Present) field (Bit 0) of a scalable mode PASID
  * entry.
@@ -553,6 +562,20 @@ static void pasid_flush_caches(struct intel_iommu *iommu,
 	}
 }
 
+static inline int pasid_enable_wpe(struct pasid_entry *pte)
+{
+	unsigned long cr0 = read_cr0();
+
+	/* CR0.WP is normally set but just to be sure */
+	if (unlikely(!(cr0 & X86_CR0_WP))) {
+		pr_err_ratelimited("No CPU write protect!\n");
+		return -EINVAL;
+	}
+	pasid_set_wpe(pte);
+
+	return 0;
+};
+
 /*
  * Set up the scalable mode pasid table entry for first only
  * translation type.
@@ -584,6 +607,9 @@ int intel_pasid_setup_first_level(struct intel_iommu *iommu,
 			return -EINVAL;
 		}
 		pasid_set_sre(pte);
+		if (pasid_enable_wpe(pte))
+			return -EINVAL;
+
 	}
 
 	if (flags & PASID_FLAG_FL5LP) {
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
