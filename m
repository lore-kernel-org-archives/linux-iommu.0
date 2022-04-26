Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A015CC433EF
	for <iommu@archiver.kernel.org>; Tue, 26 Apr 2022 04:20:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4C92D40178;
	Tue, 26 Apr 2022 04:20:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i4ovoOrwnkxO; Tue, 26 Apr 2022 04:20:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3310B4013B;
	Tue, 26 Apr 2022 04:20:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EB309C0039;
	Tue, 26 Apr 2022 04:20:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8C61CC002D
 for <iommu@lists.linux-foundation.org>; Tue, 26 Apr 2022 04:20:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 616C060D4D
 for <iommu@lists.linux-foundation.org>; Tue, 26 Apr 2022 04:20:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 38OloQ8eAiWy for <iommu@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 04:20:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9120560B95
 for <iommu@lists.linux-foundation.org>; Tue, 26 Apr 2022 04:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1650946810; x=1682482810;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=wRcUZ8Y/n8pAL9A/qgitFb6rt9lmE3TkOX7+yyhh2MA=;
 b=l7BVU6DbJLRuT6qXRaOIAQ0Gj0qL5WstjWMVx4g5awlpzU+Ho09Lahq3
 xmpVHRGXeIZ5guHRt+jy65Wud0JUr65hpOKDJulxJI2sGEZJSxLd/uypq
 mf7FIYgCr4josNY8v5mx+Wwn3tIcs+MMdjDnyoPdQG5Jtx8vJ6djyw9F8
 QbxtsDZErX045Fdmwh05lNT0ZGqnYn155EgVv6O4lgKoKe1CkPrG48syp
 XnuasyG6z39lyuJSrUQqKx2AGZF/87CSWl+Zzl/+DMNpLCr7dZhkCo++B
 FWoOD58+h8pC/NCkoh/+VNP/N4EtdFdCx8TGq5UYdiQAQsb4dCZAzYe50 A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="246009925"
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; d="scan'208";a="246009925"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Apr 2022 21:20:06 -0700
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; d="scan'208";a="730055827"
Received: from fyu1.sc.intel.com ([172.25.103.126])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Apr 2022 21:20:06 -0700
Date: Mon, 25 Apr 2022 21:20:36 -0700
From: Fenghua Yu <fenghua.yu@intel.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Message-ID: <YmdzFFx7fN586jcf@fyu1.sc.intel.com>
References: <tencent_7477100F8A445C6CAFA8F13601A55134480A@qq.com>
 <YmJ/WA6KAQU/xJjA@myrica>
 <tencent_A4E83BA6071B2204B6F5D4E69A50D21C1A09@qq.com>
 <YmLOznyBF0f7COYT@myrica>
 <tencent_2922DAB6F3D5789A1CD3A21A843B4007ED09@qq.com>
 <Yman5hLomw9/c+bi@myrica>
 <76ec6342-0d7c-7c7b-c132-2892e4048fa1@intel.com>
 <YmavoKkVu+hd+x0M@myrica> <20220425083444.00af5674@jacob-builder>
 <YmbIjnHtibY7n4Wb@myrica>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YmbIjnHtibY7n4Wb@myrica>
Cc: Ravi V Shankar <ravi.v.shankar@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, will@kernel.org,
 Dave Hansen <dave.hansen@linux.intel.com>, x86 <x86@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Dave Hansen <dave.hansen@intel.com>, iommu <iommu@lists.linux-foundation.org>,
 Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
 zhangfei.gao@linaro.org, Thomas Gleixner <tglx@linutronix.de>,
 robin.murphy@arm.com, Ingo Molnar <mingo@redhat.com>
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

Hi, Jean and Zhangfei,

On Mon, Apr 25, 2022 at 05:13:02PM +0100, Jean-Philippe Brucker wrote:
> Could we move mm_pasid_drop() to __mmdrop() instead of __mmput()?  For Arm
> we do need to hold the mm_count until unbind(), and mmgrab()/mmdrop() is
> also part of Lu's rework [1].

Is this a right fix for the issue? Could you please test it on ARM?
I don't have an ARM machine.

Thanks.

-Fenghua

From 84aa68f6174439d863c40cdc2db0e1b89d620dd0 Mon Sep 17 00:00:00 2001
From: Fenghua Yu <fenghua.yu@intel.com>
Date: Fri, 15 Apr 2022 00:51:33 -0700
Subject: [PATCH] iommu/sva: Fix PASID use-after-free issue

A PASID might be still used on ARM after it is freed in __mmput().

process:
	open()->sva_bind()->ioasid_alloc() = N; // Get PASID N for the mm
	exit();
	exit_mm()->__mmput()->mm_pasid_drop()->mm->pasid = -1; // PASID -1
	exit_files()->release(dev)->sva_unbind()->use mm->pasid; // Failure

To avoid the use-after-free issue, free the PASID after no device uses it,
i.e. after all devices are unbound from the mm.

sva_bind()/sva_unbind() call mmgrab()/mmdrop() to track mm->mm_count.
__mmdrop() is called only after mm->mm_count is zero. So freeing the PASID
in __mmdrop() guarantees the PASID is safely freed only after no device
is bound to the mm.

Fixes: 701fac40384f ("iommu/sva: Assign a PASID to mm on PASID allocation and free it on mm exit")

Reported-by: Zhangfei Gao <zhangfei.gao@foxmail.com>
Suggested-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Suggested-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 kernel/fork.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 9796897560ab..35a3beff140b 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -792,6 +792,7 @@ void __mmdrop(struct mm_struct *mm)
 	mmu_notifier_subscriptions_destroy(mm);
 	check_mm(mm);
 	put_user_ns(mm->user_ns);
+	mm_pasid_drop(mm);
 	free_mm(mm);
 }
 EXPORT_SYMBOL_GPL(__mmdrop);
@@ -1190,7 +1191,6 @@ static inline void __mmput(struct mm_struct *mm)
 	}
 	if (mm->binfmt)
 		module_put(mm->binfmt->module);
-	mm_pasid_drop(mm);
 	mmdrop(mm);
 }
 
-- 
2.32.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
