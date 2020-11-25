Return-Path: <SRS0=GPDh=E7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F04C2D0E4
	for <iommu@archiver.kernel.org>; Wed, 25 Nov 2020 01:49:00 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BAB6208DB
	for <iommu@archiver.kernel.org>; Wed, 25 Nov 2020 01:48:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BAB6208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A12B686652;
	Wed, 25 Nov 2020 01:48:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 33QM6zWYlydA; Wed, 25 Nov 2020 01:48:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0C772857D1;
	Wed, 25 Nov 2020 01:48:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CF397C163C;
	Wed, 25 Nov 2020 01:48:57 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9F589C0052
 for <iommu@lists.linux-foundation.org>; Wed, 25 Nov 2020 01:48:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 92F0187388
 for <iommu@lists.linux-foundation.org>; Wed, 25 Nov 2020 01:48:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tdBT4rofxzoR for <iommu@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 01:48:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by hemlock.osuosl.org (Postfix) with ESMTPS id F3A5487385
 for <iommu@lists.linux-foundation.org>; Wed, 25 Nov 2020 01:48:54 +0000 (UTC)
IronPort-SDR: FSZ6zp14xXW7Wk2yBrW+TIFHee9/FhHDApf+A+qoQsj9laBWN+KGTlNqwxYTObeDQSNBfpIxD+
 rx8agQPUovqw==
X-IronPort-AV: E=McAfee;i="6000,8403,9815"; a="159091465"
X-IronPort-AV: E=Sophos;i="5.78,367,1599548400"; d="scan'208";a="159091465"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2020 17:48:54 -0800
IronPort-SDR: lLsI0hy9SsZX2QlnfXuv70HYqqiD3wE1AuChYo9GDZOlaJotK29qLJ3gTU5hLWAIPRKVFLktWB
 TimRb0p8obLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,367,1599548400"; d="scan'208";a="536689747"
Received: from allen-box.sh.intel.com ([10.239.159.28])
 by fmsmga005.fm.intel.com with ESMTP; 24 Nov 2020 17:48:51 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Ning Sun <ning.sun@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 1/1] x86/tboot: Don't disable swiotlb when iommu is forced on
Date: Wed, 25 Nov 2020 09:41:24 +0800
Message-Id: <20201125014124.4070776-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: Ashok Raj <ashok.raj@intel.com>, x86@kernel.org,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 tboot-devel@lists.sourceforge.net, Adrian Huang <ahuang12@lenovo.com>
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

After commit 327d5b2fee91c ("iommu/vt-d: Allow 32bit devices to uses DMA
domain"), swiotbl could also be used for direct memory access if IOMMU
is enabled but a device is configured to pass through the DMA translation.
Keep swiotlb when IOMMU is forced on, otherwise, some devices won't work
if "iommu=pt" kernel parameter is used.

Fixes: 327d5b2fee91c ("iommu/vt-d: Allow 32bit devices to uses DMA domain")
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=210237
Reported-and-tested-by: Adrian Huang <ahuang12@lenovo.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 arch/x86/kernel/tboot.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/x86/kernel/tboot.c b/arch/x86/kernel/tboot.c
index 420be871d9d4..ae64f98ec2ab 100644
--- a/arch/x86/kernel/tboot.c
+++ b/arch/x86/kernel/tboot.c
@@ -514,13 +514,10 @@ int tboot_force_iommu(void)
 	if (!tboot_enabled())
 		return 0;
 
-	if (no_iommu || swiotlb || dmar_disabled)
+	if (no_iommu || dmar_disabled)
 		pr_warn("Forcing Intel-IOMMU to enabled\n");
 
 	dmar_disabled = 0;
-#ifdef CONFIG_SWIOTLB
-	swiotlb = 0;
-#endif
 	no_iommu = 0;
 
 	return 1;
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
