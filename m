Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD544801
	for <iommu@lists.linux.dev>; Wed, 17 Apr 2024 00:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713314387; cv=none; b=A6D8kVN+/aoFcLBtfN43vsEwzCNvptxSptqkgFtWhFcNDXx7NfRWxI+ItnH+5JiLc94KN0/6mpNB5BfNBordM0Dv43Po8HxSdT9soK6zoTSxD9zFENew533rXkHOae9qGn4q1dhKmrXmQNb7HTyl+kGMQ5PBpKTds72MQdFrK4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713314387; c=relaxed/simple;
	bh=FbyNbtK36AqmEzY194l7ZNmnDo1F52tA9CX+PzaMTXY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MfG7GxZd5WjCwyn4r7AjNRytURm17WtrmaskeokRXSvXFeY+3I/U4acxdHpCDNpOEKLkfhvLDykQeJF/ha4yg3P1UAxtYFNZKsD9TWlYWBVpZoN9RL8EN0wfK4YKqMs8v5VTkth1we6HcP8MT5j76MQJVKSxCHxEnsdXVKCQ9j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JMQuDiwy; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JMQuDiwy"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61ac7b815e5so47292117b3.0
        for <iommu@lists.linux.dev>; Tue, 16 Apr 2024 17:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713314384; x=1713919184; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vnQ65n10C6Pq0ZkKHds3ZlpX5TuDQlyTU6+t/yldsJg=;
        b=JMQuDiwybXRArRCGdv9kBbFHQ9anhswVvsWSEpPh6nq50w87y3uuN0GbEfX2eSFPZR
         iNsPCC9RYsbtbr9A0f2xRlsFuCLlNFgvs9Q6dv6d5k8wYvcC0UX3M5fHC3xCiYTRNX4Z
         Ciu9P8cfwg5HB6xmQpYxux66z8/fsNEXhy6weglNtg1R5Yapk7Su9ObdFaZTuRjF6Tpd
         UDDIn2nEgHNK8RgfNbr3Z/z4w42HrOhmuN3IVvWMIHRHclnIKzRGIPx8kkfl3ADLKarE
         jKVwi8fble2dSSl5TLZl34++tbj3EkVaA37+ProRCtpyge/qHC4LGz1cgnOkGjRtNCzR
         7ESA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713314384; x=1713919184;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vnQ65n10C6Pq0ZkKHds3ZlpX5TuDQlyTU6+t/yldsJg=;
        b=rUFGSbM+WH680DI31aYQqhRjwYNJooE5xt3N5P6o0zQWSX/hlIF0RHo/cnWGI6VBeR
         +U5vjcRmn56ke3Pv7j+x1/vyVuMYfFKvNSquXgtbjdqvANFKLWhxjl+6lX4u3HEFg+YL
         deTX5D0w1T5J9xbP3n84lpfEBQHaKXd5lIkz9Xmp/JWK0ybn2UlL4cjUWz7a4tO9OQZb
         oMw/PXZ7ZTjGJlIAsmhDTLcxo7NsYWvSxgGOojzNKMcb0IjYuDRyEmTKOvlD+iKGYItI
         WSFlC+yrA/qjIv3BbfyTLA2/BAydbHPpBQN3dXJgoCiFfxNtUby4MDEh7aRwH0ZDU7mc
         2dUA==
X-Forwarded-Encrypted: i=1; AJvYcCXVPQAypMZvrXrxRC1t87QtHbrODXIoAEIHAS3MMhYD5hTHY16qrtavOtdpwjRFPm2Cdh6nAA8vFBTnHXfPp/66vJ+3UPQ=
X-Gm-Message-State: AOJu0Yz6xkMGD6vZ7ohkSkZcL0wyvJYfqeSFMgYrbLZiKthisf7Z3ogV
	0Cwe1APX7pI7iBYJAcFZ4b7K3l+e8XNJc0o1cRLb5RBOC8r44FVgFtGPJa+yEpCUkhdpJ7bn7vh
	3ZQ==
X-Google-Smtp-Source: AGHT+IFwI0Wtw33+GURLOQF//ea8KMM5/5ZtkJss0iAPKibWoLIvmvqUy3HJlRJSnH442r8pov1BHfB/nsA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1081:b0:dc7:8e30:e2e3 with SMTP id
 v1-20020a056902108100b00dc78e30e2e3mr4432687ybu.2.1713314384627; Tue, 16 Apr
 2024 17:39:44 -0700 (PDT)
Date: Tue, 16 Apr 2024 17:39:42 -0700
In-Reply-To: <20240405223110.1609888-4-jacob.jun.pan@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240405223110.1609888-1-jacob.jun.pan@linux.intel.com> <20240405223110.1609888-4-jacob.jun.pan@linux.intel.com>
Message-ID: <Zh8aTitLwSYYlZW5@google.com>
Subject: Re: [PATCH v2 03/13] x86/irq: Remove bitfields in posted interrupt descriptor
From: Sean Christopherson <seanjc@google.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, X86 Kernel <x86@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, iommu@lists.linux.dev, 
	Thomas Gleixner <tglx@linutronix.de>, Lu Baolu <baolu.lu@linux.intel.com>, kvm@vger.kernel.org, 
	Dave Hansen <dave.hansen@intel.com>, Joerg Roedel <joro@8bytes.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>, 
	Paul Luse <paul.e.luse@intel.com>, Dan Williams <dan.j.williams@intel.com>, 
	Jens Axboe <axboe@kernel.dk>, Raj Ashok <ashok.raj@intel.com>, Kevin Tian <kevin.tian@intel.com>, 
	maz@kernel.org, Robin Murphy <robin.murphy@arm.com>, jim.harris@samsung.com, 
	a.manzanares@samsung.com, Bjorn Helgaas <helgaas@kernel.org>, guang.zeng@intel.com, 
	robert.hoo.linux@gmail.com
Content-Type: text/plain; charset="us-ascii"

"KVM" here would be nice too.

On Fri, Apr 05, 2024, Jacob Pan wrote:
> Mixture of bitfields and types is weird and really not intuitive, remove
> bitfields and use typed data exclusively.
> 
> Link: https://lore.kernel.org/all/20240404101735.402feec8@jacob-builder/T/#mf66e34a82a48f4d8e2926b5581eff59a122de53a
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> 
> ---
> v2:
> 	- Replace bitfields, no more mix.
> ---
>  arch/x86/include/asm/posted_intr.h | 10 +---------
>  arch/x86/kvm/vmx/posted_intr.c     |  4 ++--
>  arch/x86/kvm/vmx/vmx.c             |  2 +-
>  3 files changed, 4 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/x86/include/asm/posted_intr.h b/arch/x86/include/asm/posted_intr.h
> index acf237b2882e..c682c41d4e44 100644
> --- a/arch/x86/include/asm/posted_intr.h
> +++ b/arch/x86/include/asm/posted_intr.h
> @@ -15,17 +15,9 @@ struct pi_desc {
>  	};
>  	union {
>  		struct {
> -				/* bit 256 - Outstanding Notification */
> -			u16	on	: 1,
> -				/* bit 257 - Suppress Notification */
> -				sn	: 1,
> -				/* bit 271:258 - Reserved */
> -				rsvd_1	: 14;
> -				/* bit 279:272 - Notification Vector */
> +			u16	notif_ctrl; /* Suppress and outstanding bits */
>  			u8	nv;
> -				/* bit 287:280 - Reserved */
>  			u8	rsvd_2;
> -				/* bit 319:288 - Notification Destination */
>  			u32	ndst;
>  		};
>  		u64 control;
> diff --git a/arch/x86/kvm/vmx/posted_intr.c b/arch/x86/kvm/vmx/posted_intr.c
> index af662312fd07..592dbb765675 100644
> --- a/arch/x86/kvm/vmx/posted_intr.c
> +++ b/arch/x86/kvm/vmx/posted_intr.c
> @@ -107,7 +107,7 @@ void vmx_vcpu_pi_load(struct kvm_vcpu *vcpu, int cpu)
>  		 * handle task migration (@cpu != vcpu->cpu).
>  		 */
>  		new.ndst = dest;
> -		new.sn = 0;
> +		new.notif_ctrl &= ~POSTED_INTR_SN;

At the risk of creating confusing, would it make sense to add double-underscore,
non-atomic versions of the set/clear helpers for ON and SN?

I can't tell if that's a net positive versus open coding clear() and set() here
and below.

>  		/*
>  		 * Restore the notification vector; in the blocking case, the
> @@ -157,7 +157,7 @@ static void pi_enable_wakeup_handler(struct kvm_vcpu *vcpu)
>  		      &per_cpu(wakeup_vcpus_on_cpu, vcpu->cpu));
>  	raw_spin_unlock(&per_cpu(wakeup_vcpus_on_cpu_lock, vcpu->cpu));
>  
> -	WARN(pi_desc->sn, "PI descriptor SN field set before blocking");
> +	WARN(pi_desc->notif_ctrl & POSTED_INTR_SN, "PI descriptor SN field set before blocking");

This can use pi_test_sn(), as test_bit() isn't atomic, i.e. doesn't incur a LOCK.

>  
>  	old.control = READ_ONCE(pi_desc->control);
>  	do {
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index d94bb069bac9..50580bbfba5d 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -4843,7 +4843,7 @@ static void __vmx_vcpu_reset(struct kvm_vcpu *vcpu)
>  	 * or POSTED_INTR_WAKEUP_VECTOR.
>  	 */
>  	vmx->pi_desc.nv = POSTED_INTR_VECTOR;
> -	vmx->pi_desc.sn = 1;
> +	vmx->pi_desc.notif_ctrl |= POSTED_INTR_SN;
