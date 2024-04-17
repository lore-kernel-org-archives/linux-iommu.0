Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DF6172BAB
	for <iommu@lists.linux.dev>; Wed, 17 Apr 2024 17:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713376621; cv=none; b=kvN5uZ/pRNlwKf4XSt683Uek6UMx0TzIsFGYoo4gqbSZvw+kTPKkXqff6FztY7s+FeC3FNuSPYZZMMravIKpwqAJybGwmIugXYVfCbEq6uW/lFZLvWwGUL0NlipU5+xl89KuIEDMzcx0yO3OTWkBh1f0cyJ6vISAmoqjS6eS7dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713376621; c=relaxed/simple;
	bh=WXUa5tohdk1r7nUGvbGwoYha5kf7ooi8ivIRxl3Pxi8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LZ9cThddlthCj3BY6Rpyx0KfU86HziP1cSWW5nQK23HAZw+sQXaHgLseJLkI1eVdJxgdSft+pzj0v+ztmmT8f8nphSRkw35qdT+nEdiHElwUankbiT3vbYl/7WyHMWewRiSB+lMUlf4GnS92wrjOP4buAXwdTALW/eqlmKt3P8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BE44GfYu; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BE44GfYu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713376620; x=1744912620;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WXUa5tohdk1r7nUGvbGwoYha5kf7ooi8ivIRxl3Pxi8=;
  b=BE44GfYuxg96ZGQ+K9PZwaER5FjVxPh7HNiEnoazRdYbdDYbLla0IuWz
   71NXZyBpfdYwKXPZeqwu/CC1F/HUShXkAH/lrnZWbX7qiIxNLcnoDXBaV
   oQo0RLjnDXG8jDpAmUjkWsV0sI5/928WTy6DUuYTsCzG/o3JD3SQ4WAll
   kMYlgtVzsyiPBBjryMTP8w8l98+n6FnW1Kt8A801Tic2fI+XZMqGRCejo
   gKcyNDQpvJukiugGFJeIUKZVd63Ov/7A8dXZH6+OtgaAZd25+T2Srp4eL
   z8WKT8SxgeLovBbsYEIWWQjp4fUg0cI/YCT5nUQzPBSLGPQ/zddyAXPtK
   w==;
X-CSE-ConnectionGUID: qLnMMhhJR+a/0nv/P1rKQQ==
X-CSE-MsgGUID: lbucJOWpRj6JV2THt/Ng0Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="8761727"
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="8761727"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 10:56:59 -0700
X-CSE-ConnectionGUID: kfPlYqsPQTm4xccB4wiK4w==
X-CSE-MsgGUID: VaHKegyoRWW3og1F8h5p6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="23294846"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.54.39.125])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 10:56:58 -0700
Date: Wed, 17 Apr 2024 11:01:31 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Sean Christopherson <seanjc@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, X86 Kernel <x86@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, iommu@lists.linux.dev, Thomas Gleixner
 <tglx@linutronix.de>, Lu Baolu <baolu.lu@linux.intel.com>,
 kvm@vger.kernel.org, Dave Hansen <dave.hansen@intel.com>, Joerg Roedel
 <joro@8bytes.org>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov
 <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>, Paul Luse
 <paul.e.luse@intel.com>, Dan Williams <dan.j.williams@intel.com>, Jens
 Axboe <axboe@kernel.dk>, Raj Ashok <ashok.raj@intel.com>, Kevin Tian
 <kevin.tian@intel.com>, maz@kernel.org, Robin Murphy
 <robin.murphy@arm.com>, jim.harris@samsung.com, a.manzanares@samsung.com,
 Bjorn Helgaas <helgaas@kernel.org>, guang.zeng@intel.com,
 robert.hoo.linux@gmail.com, jacob.jun.pan@linux.intel.com,
 oliver.sang@intel.com
Subject: Re: [PATCH v2 03/13] x86/irq: Remove bitfields in posted interrupt
 descriptor
Message-ID: <20240417110131.4aaf1d66@jacob-builder>
In-Reply-To: <Zh8aTitLwSYYlZW5@google.com>
References: <20240405223110.1609888-1-jacob.jun.pan@linux.intel.com>
	<20240405223110.1609888-4-jacob.jun.pan@linux.intel.com>
	<Zh8aTitLwSYYlZW5@google.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Sean,

On Tue, 16 Apr 2024 17:39:42 -0700, Sean Christopherson <seanjc@google.com>
wrote:

> "KVM" here would be nice too.
> 
> On Fri, Apr 05, 2024, Jacob Pan wrote:
> > Mixture of bitfields and types is weird and really not intuitive, remove
> > bitfields and use typed data exclusively.
> > 
> > Link:
> > https://lore.kernel.org/all/20240404101735.402feec8@jacob-builder/T/#mf66e34a82a48f4d8e2926b5581eff59a122de53a
> > Suggested-by: Sean Christopherson <seanjc@google.com> Suggested-by:
> > Thomas Gleixner <tglx@linutronix.de> Signed-off-by: Jacob Pan
> > <jacob.jun.pan@linux.intel.com>
> > 
> > ---
> > v2:
> > 	- Replace bitfields, no more mix.
> > ---
> >  arch/x86/include/asm/posted_intr.h | 10 +---------
> >  arch/x86/kvm/vmx/posted_intr.c     |  4 ++--
> >  arch/x86/kvm/vmx/vmx.c             |  2 +-
> >  3 files changed, 4 insertions(+), 12 deletions(-)
> > 
> > diff --git a/arch/x86/include/asm/posted_intr.h
> > b/arch/x86/include/asm/posted_intr.h index acf237b2882e..c682c41d4e44
> > 100644 --- a/arch/x86/include/asm/posted_intr.h
> > +++ b/arch/x86/include/asm/posted_intr.h
> > @@ -15,17 +15,9 @@ struct pi_desc {
> >  	};
> >  	union {
> >  		struct {
> > -				/* bit 256 - Outstanding Notification
> > */
> > -			u16	on	: 1,
> > -				/* bit 257 - Suppress Notification */
> > -				sn	: 1,
> > -				/* bit 271:258 - Reserved */
> > -				rsvd_1	: 14;
> > -				/* bit 279:272 - Notification Vector */
> > +			u16	notif_ctrl; /* Suppress and
> > outstanding bits */ u8	nv;
> > -				/* bit 287:280 - Reserved */
> >  			u8	rsvd_2;
> > -				/* bit 319:288 - Notification
> > Destination */ u32	ndst;
> >  		};
> >  		u64 control;
> > diff --git a/arch/x86/kvm/vmx/posted_intr.c
> > b/arch/x86/kvm/vmx/posted_intr.c index af662312fd07..592dbb765675 100644
> > --- a/arch/x86/kvm/vmx/posted_intr.c
> > +++ b/arch/x86/kvm/vmx/posted_intr.c
> > @@ -107,7 +107,7 @@ void vmx_vcpu_pi_load(struct kvm_vcpu *vcpu, int
> > cpu)
> >  		 * handle task migration (@cpu != vcpu->cpu).
> >  		 */
> >  		new.ndst = dest;
> > -		new.sn = 0;
> > +		new.notif_ctrl &= ~POSTED_INTR_SN;  
> 
> At the risk of creating confusing, would it make sense to add
> double-underscore, non-atomic versions of the set/clear helpers for ON
> and SN?
> 
> I can't tell if that's a net positive versus open coding clear() and
> set() here and below.
IMHO, we can add non-atomic helpers when we have more than one user for
each operation.

I do have a stupid bug here, it should be:
-               new.notif_ctrl &= ~POSTED_INTR_SN;
+               new.notif_ctrl &= ~BIT(POSTED_INTR_SN);
Same as below.

Thanks to Oliver(LKP kvm self test). I didn't catch that in my VFIO device
assignment test.

> 
> >  		/*
> >  		 * Restore the notification vector; in the blocking
> > case, the @@ -157,7 +157,7 @@ static void
> > pi_enable_wakeup_handler(struct kvm_vcpu *vcpu)
> > &per_cpu(wakeup_vcpus_on_cpu, vcpu->cpu));
> > raw_spin_unlock(&per_cpu(wakeup_vcpus_on_cpu_lock, vcpu->cpu)); 
> > -	WARN(pi_desc->sn, "PI descriptor SN field set before
> > blocking");
> > +	WARN(pi_desc->notif_ctrl & POSTED_INTR_SN, "PI descriptor SN
> > field set before blocking");  
> 
> This can use pi_test_sn(), as test_bit() isn't atomic, i.e. doesn't incur
> a LOCK.
make sense. will do.

> >  
> >  	old.control = READ_ONCE(pi_desc->control);
> >  	do {
> > diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> > index d94bb069bac9..50580bbfba5d 100644
> > --- a/arch/x86/kvm/vmx/vmx.c
> > +++ b/arch/x86/kvm/vmx/vmx.c
> > @@ -4843,7 +4843,7 @@ static void __vmx_vcpu_reset(struct kvm_vcpu
> > *vcpu)
> >  	 * or POSTED_INTR_WAKEUP_VECTOR.
> >  	 */
> >  	vmx->pi_desc.nv = POSTED_INTR_VECTOR;
> > -	vmx->pi_desc.sn = 1;
> > +	vmx->pi_desc.notif_ctrl |= POSTED_INTR_SN;  


Thanks,

Jacob
