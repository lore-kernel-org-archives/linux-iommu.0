Return-Path: <SRS0=fDzP=OK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EBEDC433F5
	for <iommu@archiver.kernel.org>; Mon, 20 Sep 2021 20:02:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5F1761242
	for <iommu@archiver.kernel.org>; Mon, 20 Sep 2021 20:02:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A5F1761242
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 47969404CF;
	Mon, 20 Sep 2021 20:02:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9fKinxBCdMEv; Mon, 20 Sep 2021 20:02:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0041040364;
	Mon, 20 Sep 2021 20:02:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CB21FC0011;
	Mon, 20 Sep 2021 20:02:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 52FEEC0011
 for <iommu@lists.linux-foundation.org>; Mon, 20 Sep 2021 20:02:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 292DD4039C
 for <iommu@lists.linux-foundation.org>; Mon, 20 Sep 2021 20:02:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bNf4wzzVky93 for <iommu@lists.linux-foundation.org>;
 Mon, 20 Sep 2021 20:02:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 733DC400F7
 for <iommu@lists.linux-foundation.org>; Mon, 20 Sep 2021 20:02:16 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10113"; a="220033644"
X-IronPort-AV: E=Sophos;i="5.85,309,1624345200"; d="scan'208";a="220033644"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2021 13:02:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,309,1624345200"; d="scan'208";a="473779498"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
 by fmsmga007.fm.intel.com with ESMTP; 20 Sep 2021 13:02:15 -0700
From: Fenghua Yu <fenghua.yu@intel.com>
To: "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>, "Peter Zijlstra" <peterz@infradead.org>,
 "Andy Lutomirski" <luto@kernel.org>, "Dave Hansen" <dave.hansen@intel.com>,
 "Tony Luck" <tony.luck@intel.com>, "Lu Baolu" <baolu.lu@linux.intel.com>,
 "Joerg Roedel" <joro@8bytes.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
 "Dave Jiang" <dave.jiang@intel.com>,
 "Jacob Jun Pan" <jacob.jun.pan@intel.com>,
 "Ashok Raj" <ashok.raj@intel.com>,
 "Ravi V Shankar" <ravi.v.shankar@intel.com>
Subject: [PATCH 6/8] x86/cpufeatures: Re-enable ENQCMD
Date: Mon, 20 Sep 2021 19:23:47 +0000
Message-Id: <20210920192349.2602141-7-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210920192349.2602141-1-fenghua.yu@intel.com>
References: <20210920192349.2602141-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Cc: Fenghua Yu <fenghua.yu@intel.com>, iommu@lists.linux-foundation.org,
 x86 <x86@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
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

Since ENQCMD is handled by #GP fix up, it can be re-enabled.

The ENQCMD feature cannot be used if CONFIG_INTEL_IOMMU_SVM
is not set. Add X86_FEATURE_ENQCMD to the disabled features mask as
appropriate and use cpu_feature_enabled() to check the feature.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/include/asm/disabled-features.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
index 8f28fafa98b3..1231d63f836d 100644
--- a/arch/x86/include/asm/disabled-features.h
+++ b/arch/x86/include/asm/disabled-features.h
@@ -56,8 +56,11 @@
 # define DISABLE_PTI		(1 << (X86_FEATURE_PTI & 31))
 #endif
 
-/* Force disable because it's broken beyond repair */
-#define DISABLE_ENQCMD		(1 << (X86_FEATURE_ENQCMD & 31))
+#ifdef CONFIG_INTEL_IOMMU_SVM
+# define DISABLE_ENQCMD		0
+#else
+# define DISABLE_ENQCMD		(1 << (X86_FEATURE_ENQCMD & 31))
+#endif
 
 #ifdef CONFIG_X86_SGX
 # define DISABLE_SGX	0
-- 
2.33.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
