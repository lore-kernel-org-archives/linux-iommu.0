Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45B41C433FE
	for <iommu@archiver.kernel.org>; Thu, 28 Apr 2022 16:02:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DEB5183E00;
	Thu, 28 Apr 2022 16:02:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FYUjF3SYF2Gj; Thu, 28 Apr 2022 16:02:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A898683E28;
	Thu, 28 Apr 2022 16:02:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5725BC0039;
	Thu, 28 Apr 2022 16:02:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D34CDC002D
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 16:02:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C205C83E28
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 16:02:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Yr2yqivxW4zK for <iommu@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 16:02:14 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B168283E00
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 16:02:13 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id y21so3217055wmi.2
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 09:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=qmZUiFUPP8wYUiHrUlqJhgO7VbVwKJAKpj8W10R2YOQ=;
 b=y5cpmqg5E14QepqUlmfEMAz04fMm1zi45VxE4Ue0OGvGJ8fM1byvnMaqzHq+ppFs3w
 JnxbtA7kJWWMJJl3ouYlk3AjbA1cNCJDRpij/RajvJyXZrjpRcWwJb48vIKt715o3OVF
 PiE80uXqVgbGn4QJruJfxuffMm6Q6uOUcMoqYYU16QEIgZiLU5jMiTcEbvCW+yaAPQah
 IY2aBbMlrYGbhf4frrMPrU8x7Cpu22G5C5go8JIScX3x5GfM5NDkTkHNuImPEbvB8QqP
 ZZtnGEAWAdCdDemlhaX2h2bCpVvoHRDUcI3MYsD8hLtLB3bIBaKZvTnJTd9PhFL5UdXN
 FQeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=qmZUiFUPP8wYUiHrUlqJhgO7VbVwKJAKpj8W10R2YOQ=;
 b=ggx5XE1ApEe1MX8eGBreLBefqRc/pTWlOoHjxpdtPz18OJoUsxQXRi1+hzEEr+Vxrk
 YTyaEUNO3rbzTqVpTZi+RARuwMYOvNI49p3ekBUswKKe01pK4ak8bdU36YNJqYgPJ7py
 fpKtaLwafMDoVwYp7nfV85/mVL6MmfeIwzXXfQlK9fwbHl8ZTCz8Z2tc1kqSkKXgK7ft
 3CsVr3m2pgt2ID42HtIuR6mpVTxIp9DcvxDOeHar3g/MBC2Qf2I/eOEg/ankQv2+VVsB
 6m3o6l4bZh4vGtbPOz22WvnIolnLxXUnBfVd/GD5RkiMCtgO3ID4glgf3FxCJ5FsdPTg
 Gu+g==
X-Gm-Message-State: AOAM533lKXMIIqxuWBhuZonvzhxdH8loDUKPolovlUQoyru6BgyZaPOo
 v9PIw/CWNyIeeOz272TeJq6dSA==
X-Google-Smtp-Source: ABdhPJxL4jzSFoCLq25i5k8etbhswfCdtRlZ7uAjJ5s+YgxKJFIWI2qzwygKSC+xkj15A4B9LX8IYA==
X-Received: by 2002:a05:600c:590:b0:38c:804e:4197 with SMTP id
 o16-20020a05600c059000b0038c804e4197mr31616563wmd.22.1651161731620; 
 Thu, 28 Apr 2022 09:02:11 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168]) by smtp.gmail.com with ESMTPSA id
 q1-20020a1c4301000000b00394145534bbsm325283wma.9.2022.04.28.09.02.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Apr 2022 09:02:10 -0700 (PDT)
Date: Thu, 28 Apr 2022 17:01:45 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Message-ID: <Ymq6aZCTdrOE60cn@myrica>
References: <tencent_A4E83BA6071B2204B6F5D4E69A50D21C1A09@qq.com>
 <YmLOznyBF0f7COYT@myrica>
 <tencent_2922DAB6F3D5789A1CD3A21A843B4007ED09@qq.com>
 <Yman5hLomw9/c+bi@myrica>
 <76ec6342-0d7c-7c7b-c132-2892e4048fa1@intel.com>
 <YmavoKkVu+hd+x0M@myrica> <20220425083444.00af5674@jacob-builder>
 <YmbIjnHtibY7n4Wb@myrica> <YmdzFFx7fN586jcf@fyu1.sc.intel.com>
 <bc18351c-27f2-17ae-e781-6b60fbb72541@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <bc18351c-27f2-17ae-e781-6b60fbb72541@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Ravi V Shankar <ravi.v.shankar@intel.com>,
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

On Thu, Apr 28, 2022 at 08:09:04AM -0700, Dave Hansen wrote:
> On 4/25/22 21:20, Fenghua Yu wrote:
> >>From 84aa68f6174439d863c40cdc2db0e1b89d620dd0 Mon Sep 17 00:00:00 2001
> > From: Fenghua Yu <fenghua.yu@intel.com>
> > Date: Fri, 15 Apr 2022 00:51:33 -0700
> > Subject: [PATCH] iommu/sva: Fix PASID use-after-free issue
> > 
> > A PASID might be still used on ARM after it is freed in __mmput().
> 
> Is it really just ARM?
> 
> > process:
> > 	open()->sva_bind()->ioasid_alloc() = N; // Get PASID N for the mm
> > 	exit();
> > 	exit_mm()->__mmput()->mm_pasid_drop()->mm->pasid = -1; // PASID -1
> > 	exit_files()->release(dev)->sva_unbind()->use mm->pasid; // Failure
> > 
> > To avoid the use-after-free issue, free the PASID after no device uses it,
> > i.e. after all devices are unbound from the mm.
> > 
> > sva_bind()/sva_unbind() call mmgrab()/mmdrop() to track mm->mm_count.
> > __mmdrop() is called only after mm->mm_count is zero. So freeing the PASID
> > in __mmdrop() guarantees the PASID is safely freed only after no device
> > is bound to the mm.
> 
> Does this changelog work for everyone?
> 
> ==
> 
> tl;dr: The PASID is being freed too early.  It needs to stay around
> until after device drivers that might be using it have had a chance to
> clear it out of the hardware.
> 
> --
> 
> As a reminder:
> 
> mmget() /mmput()  refcount the mm's address space
> mmgrab()/mmdrop() refcount the mm itself
> 
> The PASID is currently tied to the life of the mm's address space and
> freed in __mmput().  This makes logical sense because the PASID can't be
> used once the address space is gone.
> 
> But, this misses an important point: even after the address space is
> gone, the PASID will still be programmed into a device.  Device drivers
> might, for instance, still need to flush operations that are outstanding
> and need to use that PASID.  They do this at ->release() time.

It's not really clear which release() this is. For us it's file descriptor
release() (not MMU notifier release(), which is how I initially understood
this sentence)

> 
> Device drivers hold a reference on the mm itself and drop it at
> ->release() time.  But, the device driver holds a reference mm itself,

"to the mm"

(To be pendantic it's the IOMMU driver that holds this reference, and
the device driver calls the IOMMU driver to release it, but the idea is
the same.)

> not the address space.  The address space (and the PASID) is long gone
> by the time the driver tries to clean up.  This is effectively a
> use-after-free bug on the PASID.
> 
> To fix this, move the PASID free operation from __mmput() to __mmdrop().
>  This ensures that the device drivers' existing mmgrab() keeps the PASID
> allocated until they drop their mm reference.

Good changelog otherwise

Thanks,
Jean

> 
> >  kernel/fork.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/fork.c b/kernel/fork.c
> > index 9796897560ab..35a3beff140b 100644
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -792,6 +792,7 @@ void __mmdrop(struct mm_struct *mm)
> >  	mmu_notifier_subscriptions_destroy(mm);
> >  	check_mm(mm);
> >  	put_user_ns(mm->user_ns);
> > +	mm_pasid_drop(mm);
> >  	free_mm(mm);
> >  }
> >  EXPORT_SYMBOL_GPL(__mmdrop);
> > @@ -1190,7 +1191,6 @@ static inline void __mmput(struct mm_struct *mm)
> >  	}
> >  	if (mm->binfmt)
> >  		module_put(mm->binfmt->module);
> > -	mm_pasid_drop(mm);
> >  	mmdrop(mm);
> >  }
> >  
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
