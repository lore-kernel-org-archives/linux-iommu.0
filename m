Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1592DC433F5
	for <iommu@archiver.kernel.org>; Mon,  7 Feb 2022 14:13:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B07F18176F;
	Mon,  7 Feb 2022 14:13:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PUIQLw3N_5el; Mon,  7 Feb 2022 14:13:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9714881400;
	Mon,  7 Feb 2022 14:13:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 61603C0011;
	Mon,  7 Feb 2022 14:13:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4BDBEC000B
 for <iommu@lists.linux-foundation.org>; Mon,  7 Feb 2022 14:13:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2398C40153
 for <iommu@lists.linux-foundation.org>; Mon,  7 Feb 2022 14:13:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id B944jzDtbdt2 for <iommu@lists.linux-foundation.org>;
 Mon,  7 Feb 2022 14:13:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C535C40148
 for <iommu@lists.linux-foundation.org>; Mon,  7 Feb 2022 14:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1644243180; x=1675779180;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=hGogMlAz2ABL6mZ3F5RdiX3bnIRNxQzIMwuH0LxLLDw=;
 b=RevW5eBUxPYciAYKsdQxCB5P2nDuV35wQzGyd/OD5GBWBmcesd4RwOyf
 LapcAyGqjWXVYUXCdajjZBuf5hhL+dU1fOnIZk1jYPt+tj28gPrKUecuf
 d1DqBKLtpsBopqsOpljSgY7OVU6xFsHnWjWkRLzmlVnxthpI5SVKxZmKq
 MQ7dj+rxdRWHn8nMwUnG4q4qEV/M0Dy1W4Y5qNj1gT5XZMgBN/BZzFHt3
 0BJCiP3AkPGXRy/V4gArxZFwImPCG0K8zzsxN87vLZDjwwvquPZQyGtpO
 54DGIM2u3q7Df0X8soVnAng8YNlrzgRnop0R+ElvLZQYog737HGZ8CNCF A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10250"; a="309466366"
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; d="scan'208";a="309466366"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Feb 2022 06:12:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; d="scan'208";a="481594287"
Received: from black.fi.intel.com ([10.237.72.28])
 by orsmga003.jf.intel.com with ESMTP; 07 Feb 2022 06:12:34 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
 id DF32A31D; Mon,  7 Feb 2022 16:12:48 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Joerg Roedel <jroedel@suse.de>, Lu Baolu <baolu.lu@linux.intel.com>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] iommu/vt-d: Move intel_iommu_ops to header file
Date: Mon,  7 Feb 2022 16:12:40 +0200
Message-Id: <20220207141240.8253-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Cc: Will Deacon <will@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 David Woodhouse <dwmw2@infradead.org>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Compiler is not happy about hidden declaration of intel_iommu_ops.

.../iommu.c:414:24: warning: symbol 'intel_iommu_ops' was not declared. Should it be static?

Move declaration to header file to make compiler happy.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: made sure it compiles with IRQ_REMAP=y, INTEL_IOMMU=n (Lu)
 drivers/iommu/intel/dmar.c  | 2 --
 include/linux/intel-iommu.h | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 915bff76fe96..b114e09a647d 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -66,8 +66,6 @@ static unsigned long dmar_seq_ids[BITS_TO_LONGS(DMAR_UNITS_SUPPORTED)];
 static int alloc_iommu(struct dmar_drhd_unit *drhd);
 static void free_iommu(struct intel_iommu *iommu);
 
-extern const struct iommu_ops intel_iommu_ops;
-
 static void dmar_register_drhd_unit(struct dmar_drhd_unit *drhd)
 {
 	/*
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 69230fd695ea..1036c1900b5c 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -813,6 +813,8 @@ bool context_present(struct context_entry *context);
 struct context_entry *iommu_context_addr(struct intel_iommu *iommu, u8 bus,
 					 u8 devfn, int alloc);
 
+extern const struct iommu_ops intel_iommu_ops;
+
 #ifdef CONFIG_INTEL_IOMMU
 extern int iommu_calculate_agaw(struct intel_iommu *iommu);
 extern int iommu_calculate_max_sagaw(struct intel_iommu *iommu);
-- 
2.34.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
