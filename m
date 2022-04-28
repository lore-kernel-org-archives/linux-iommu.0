Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64863C433EF
	for <iommu@archiver.kernel.org>; Thu, 28 Apr 2022 15:08:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0510440374;
	Thu, 28 Apr 2022 15:08:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4JSapeCC8Wdy; Thu, 28 Apr 2022 15:08:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D5275401C9;
	Thu, 28 Apr 2022 15:08:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AF3D2C0039;
	Thu, 28 Apr 2022 15:08:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C017DC002D
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 15:08:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9F74340374
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 15:08:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Hu8o10RwcyVf for <iommu@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 15:08:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp2.osuosl.org (Postfix) with ESMTPS id ED744401C9
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 15:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651158530; x=1682694530;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=WjpidTVz5lUtD/efh8OlqCuRXiLpHTD6QLqjLK1bhbg=;
 b=bdOq83igN1k7VnIiYq+cLNdkntR8qBSyEbuz6EKWMWW2Y0htyIU+vWzm
 /KRgC2l3eA2FjEUR6lohXoKZ2tx8OzvUchwEWBjE3LCsFjeDPMMX/7qyL
 c2frS6vjjAQ9CFRbJ9Y9grqkFCTmrAtDrlSdh/FfBpYAzN5gOBQo5brwo
 jZqM3lJ65ZhNdsrXJgbkJdzNgREFCZlqo/v7RQLs7z+RsRm/OvUdYpajX
 vvgF2BLHw0CS2DbEfJuZ55wg/ovJ4eU1a8tbVBo4jhK2OD6rebcaN+lgj
 LUz0wSYSiCsVA5paQTPWm6LWAG+ZLUiwDkGZRujvci3MynvrIPnqGcu+d Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10330"; a="266477282"
X-IronPort-AV: E=Sophos;i="5.91,295,1647327600"; d="scan'208";a="266477282"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2022 08:08:50 -0700
X-IronPort-AV: E=Sophos;i="5.91,295,1647327600"; d="scan'208";a="559713585"
Received: from mpoursae-mobl2.amr.corp.intel.com (HELO [10.212.0.84])
 ([10.212.0.84])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2022 08:08:48 -0700
Message-ID: <bc18351c-27f2-17ae-e781-6b60fbb72541@intel.com>
Date: Thu, 28 Apr 2022 08:09:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Content-Language: en-US
To: Fenghua Yu <fenghua.yu@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <tencent_7477100F8A445C6CAFA8F13601A55134480A@qq.com>
 <YmJ/WA6KAQU/xJjA@myrica>
 <tencent_A4E83BA6071B2204B6F5D4E69A50D21C1A09@qq.com>
 <YmLOznyBF0f7COYT@myrica>
 <tencent_2922DAB6F3D5789A1CD3A21A843B4007ED09@qq.com>
 <Yman5hLomw9/c+bi@myrica> <76ec6342-0d7c-7c7b-c132-2892e4048fa1@intel.com>
 <YmavoKkVu+hd+x0M@myrica> <20220425083444.00af5674@jacob-builder>
 <YmbIjnHtibY7n4Wb@myrica> <YmdzFFx7fN586jcf@fyu1.sc.intel.com>
From: Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <YmdzFFx7fN586jcf@fyu1.sc.intel.com>
Cc: Ravi V Shankar <ravi.v.shankar@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, will@kernel.org,
 Dave Hansen <dave.hansen@linux.intel.com>, x86 <x86@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 iommu <iommu@lists.linux-foundation.org>, Tony Luck <tony.luck@intel.com>,
 Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, zhangfei.gao@linaro.org,
 Thomas Gleixner <tglx@linutronix.de>, robin.murphy@arm.com,
 Ingo Molnar <mingo@redhat.com>
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

On 4/25/22 21:20, Fenghua Yu wrote:
>>From 84aa68f6174439d863c40cdc2db0e1b89d620dd0 Mon Sep 17 00:00:00 2001
> From: Fenghua Yu <fenghua.yu@intel.com>
> Date: Fri, 15 Apr 2022 00:51:33 -0700
> Subject: [PATCH] iommu/sva: Fix PASID use-after-free issue
> 
> A PASID might be still used on ARM after it is freed in __mmput().

Is it really just ARM?

> process:
> 	open()->sva_bind()->ioasid_alloc() = N; // Get PASID N for the mm
> 	exit();
> 	exit_mm()->__mmput()->mm_pasid_drop()->mm->pasid = -1; // PASID -1
> 	exit_files()->release(dev)->sva_unbind()->use mm->pasid; // Failure
> 
> To avoid the use-after-free issue, free the PASID after no device uses it,
> i.e. after all devices are unbound from the mm.
> 
> sva_bind()/sva_unbind() call mmgrab()/mmdrop() to track mm->mm_count.
> __mmdrop() is called only after mm->mm_count is zero. So freeing the PASID
> in __mmdrop() guarantees the PASID is safely freed only after no device
> is bound to the mm.

Does this changelog work for everyone?

==

tl;dr: The PASID is being freed too early.  It needs to stay around
until after device drivers that might be using it have had a chance to
clear it out of the hardware.

--

As a reminder:

mmget() /mmput()  refcount the mm's address space
mmgrab()/mmdrop() refcount the mm itself

The PASID is currently tied to the life of the mm's address space and
freed in __mmput().  This makes logical sense because the PASID can't be
used once the address space is gone.

But, this misses an important point: even after the address space is
gone, the PASID will still be programmed into a device.  Device drivers
might, for instance, still need to flush operations that are outstanding
and need to use that PASID.  They do this at ->release() time.

Device drivers hold a reference on the mm itself and drop it at
->release() time.  But, the device driver holds a reference mm itself,
not the address space.  The address space (and the PASID) is long gone
by the time the driver tries to clean up.  This is effectively a
use-after-free bug on the PASID.

To fix this, move the PASID free operation from __mmput() to __mmdrop().
 This ensures that the device drivers' existing mmgrab() keeps the PASID
allocated until they drop their mm reference.

>  kernel/fork.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 9796897560ab..35a3beff140b 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -792,6 +792,7 @@ void __mmdrop(struct mm_struct *mm)
>  	mmu_notifier_subscriptions_destroy(mm);
>  	check_mm(mm);
>  	put_user_ns(mm->user_ns);
> +	mm_pasid_drop(mm);
>  	free_mm(mm);
>  }
>  EXPORT_SYMBOL_GPL(__mmdrop);
> @@ -1190,7 +1191,6 @@ static inline void __mmput(struct mm_struct *mm)
>  	}
>  	if (mm->binfmt)
>  		module_put(mm->binfmt->module);
> -	mm_pasid_drop(mm);
>  	mmdrop(mm);
>  }
>  

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
