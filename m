Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13829C43219
	for <iommu@archiver.kernel.org>; Fri, 17 Dec 2021 22:02:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CC1C6421DA;
	Fri, 17 Dec 2021 22:02:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F-ar4LUXouas; Fri, 17 Dec 2021 22:02:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C30DD41E14;
	Fri, 17 Dec 2021 22:02:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D53ADC0076;
	Fri, 17 Dec 2021 22:02:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2329BC007D
 for <iommu@lists.linux-foundation.org>; Fri, 17 Dec 2021 22:02:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 53DB261168
 for <iommu@lists.linux-foundation.org>; Fri, 17 Dec 2021 22:01:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yEuDysT9W-Hl for <iommu@lists.linux-foundation.org>;
 Fri, 17 Dec 2021 22:01:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AA7336117D
 for <iommu@lists.linux-foundation.org>; Fri, 17 Dec 2021 22:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1639778518; x=1671314518;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=38m/Q2AQH9Kv2z7BUSt3cLQo4zzkwKxvDeDlsUIPs6Y=;
 b=SbgRRyDgsz81E/3stmYZ3cPyshNkGkKOJ238XffLewpAl05n9MqJWX02
 2MJ8NkgK9HwqXKDO/xekWoJ1p4b05I+ypHu7DgJMQQRhoiZESdTyahXrE
 4CjNEuhHDxO41Z2VPFlQ5EPUSrr/x3sqO05VO8pQfB36hKX6bPJltYfzJ
 MNkOA4Z2W2iDz92OT+Bv/G6zqswu3BqYglj6bajZeljWdEDW2VwW3z/i+
 9fliBFlxYA5CIu5CuDjeOZUzHdgWpz9dKRbkQiZ6JovvOKIJ8OsGVrtc1
 PYidlUNY1g3ANwreKUFzXOIgAtpGTDNQet01gy8t3ZjIUNkqkLp5UUZ0G Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10201"; a="239793595"
X-IronPort-AV: E=Sophos;i="5.88,214,1635231600"; d="scan'208";a="239793595"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Dec 2021 14:01:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,214,1635231600"; d="scan'208";a="506928107"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
 by orsmga007.jf.intel.com with ESMTP; 17 Dec 2021 14:01:51 -0800
From: Fenghua Yu <fenghua.yu@intel.com>
To: "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>, "Peter Zijlstra" <peterz@infradead.org>,
 "Andy Lutomirski" <luto@kernel.org>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "Tony Luck" <tony.luck@intel.com>, "Lu Baolu" <baolu.lu@linux.intel.com>,
 "Joerg Roedel" <joro@8bytes.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
 "Jacob Pan" <jacob.jun.pan@linux.intel.com>,
 "Ashok Raj" <ashok.raj@intel.com>,
 "Ravi V Shankar" <ravi.v.shankar@intel.com>
Subject: [PATCH v2 09/11] x86/cpufeatures: Re-enable ENQCMD
Date: Fri, 17 Dec 2021 22:01:34 +0000
Message-Id: <20211217220136.2762116-10-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211217220136.2762116-1-fenghua.yu@intel.com>
References: <20211217220136.2762116-1-fenghua.yu@intel.com>
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

The ENQCMD feature can only be used if CONFIG_INTEL_IOMMU_SVM is set. Add
X86_FEATURE_ENQCMD to the disabled features mask as appropriate so that
cpu_feature_enabled() can be used to check the feature.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
v2:
- Update the commit message (Tony).

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
2.34.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
