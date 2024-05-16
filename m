Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E591C147C6E
	for <iommu@lists.linux.dev>; Thu, 16 May 2024 14:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715868427; cv=none; b=Yo8fGSvLAIYOZF1VSevtDtzldF+Ctum++yUGkuKy/FcB35fJqRP5ButfJptnBo5M+Hwtntv6FtG1EKMm3pu8T1dV7CKu1Rhx/dXWYc37pvLsPPsXDL2+1gmHtl+UP/7ftbmnz0t5zmnuSEr6uXECNWHr1KlssrOqO+nMpba9Cns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715868427; c=relaxed/simple;
	bh=tWr3SDz/keT0AUPlOI26qivjzXaj1FzjL66/DGqh04E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VHSkbw8Mv6tWy27SXVjROawPuyHEk9MXgl84Iu2ei06cfJYJC70qxyTrCvtgFtOYmmUM828+HWDbQRFWaGxAnBljgpkBZocOR2FFzT5xmg+xTx3q6V5X3QcZZj+CtoL80yDacIUeuBRNRPr/86+gJtu2akeokpU19HNRTkfctts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0kXybwv2; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0kXybwv2"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b269686aso12123992276.1
        for <iommu@lists.linux.dev>; Thu, 16 May 2024 07:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715868425; x=1716473225; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cgdQVmJ7EdgxAUQ+Mn5lPrLPnO4lZEwTEM15imrbXrA=;
        b=0kXybwv2MOqdMz5BCR2Uj/lc/UMTjQB0hN2J51KcCppPPr2Yi00RKUEoBDWiJ84LBL
         YDIHuEokpgBKkEJAz0XBKnqq5uO2dnS+MJFLVZXQ9T/x6hU2wDH7LcHkmj1SqJVDOJCT
         Dd9dLGCLoAk+VMcKxy0GotdDIPdLJWDaiA7w3EQe1ipJ+HUUIoUyidlFgKJqz3cBs8YU
         t8rfl8hv047oIYLiayzAM6L8GE4lQxwLM/77mt4Wd2ztuio6+rk9PZvrZbGifwYmLxbj
         78rj8pJ9h/ZQWBHrUC6ZycGMGH3rjhpveNWSCIhrngEQYGaRLFM49OZm80OWB1Fo/Cio
         LcEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715868425; x=1716473225;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cgdQVmJ7EdgxAUQ+Mn5lPrLPnO4lZEwTEM15imrbXrA=;
        b=G/e5AfgMX1MuVUeaJNpCiPcgmM5O7r3n4a2I+d/QvlGE3U28xTiYper13LBNb+jGJy
         TxbSZ2aTOMhsPYSPPuKbaZqEvLWeMhVDmpVWVjXAVX2eEWF2C+/5RuR710BzE853HHSQ
         Of55rZFanKb+aD2I0Er+6XqngpVfRv3c4l3f4fxSQ77jax4omfe9ORPIlpAlGV4OWz1w
         89nQ+Jkqc7TkwZBZx0atQA016N2nFx/92IjFWYPXqXS0RuHka8gPRMlDJ5+iR55uoWo8
         x52ThvYGMNf2dlwTa6Bf8v/Al6Dsdvh6kRQW25r+HeX3oOizdYXsKHbZNDyd70lSJcOp
         LUdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWj3PK44JemMEUzvG73kkBE4VxXALuYRv6lIbHN63LSopYgPDcbhn0WhOTLJJFUaDmzDYtSgUUcw3HcRimAaH4Ot3ayhY0=
X-Gm-Message-State: AOJu0YyV2KRYuZ8ZO5lVVaHcuGJ32MaaowfIdxAhVNyua6sMpiFPQlaG
	vTJdFqKGk+XGYq0Fp1Cj2SWqOHEstFqHwbxqXcbUb5HrZz/cVrZq54SiavQorBfjdUhPNQJmpmF
	4OQ==
X-Google-Smtp-Source: AGHT+IEDBtrDbkovNrhAV/lyqKo9e3I9oLyUsaLll6pFh8+GoJQSddiJzF1Cv5ysvpR9u6J0VFHg196pMTA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1025:b0:de5:3003:4b83 with SMTP id
 3f1490d57ef6-dee4f4fbce6mr1659030276.8.1715868424907; Thu, 16 May 2024
 07:07:04 -0700 (PDT)
Date: Thu, 16 May 2024 07:07:03 -0700
In-Reply-To: <BN9PR11MB527614E72C1DF467FF3F4C948CED2@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240507061802.20184-1-yan.y.zhao@intel.com> <20240507061924.20251-1-yan.y.zhao@intel.com>
 <BN9PR11MB5276DA8F389AAE7237C7F48E8CE42@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZjnwiKcmdpDAjMQ5@yzhao56-desk.sh.intel.com> <BN9PR11MB527614E72C1DF467FF3F4C948CED2@BN9PR11MB5276.namprd11.prod.outlook.com>
Message-ID: <ZkYTByuHu_IptChR@google.com>
Subject: Re: [PATCH 1/5] x86/pat: Let pat_pfn_immune_to_uc_mtrr() check MTRR
 for untracked PAT range
From: Sean Christopherson <seanjc@google.com>
To: Kevin Tian <kevin.tian@intel.com>
Cc: Yan Y Zhao <yan.y.zhao@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, 
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, 
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "luto@kernel.org" <luto@kernel.org>, 
	"peterz@infradead.org" <peterz@infradead.org>, "tglx@linutronix.de" <tglx@linutronix.de>, 
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>, 
	"corbet@lwn.net" <corbet@lwn.net>, "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>, 
	"robin.murphy@arm.com" <robin.murphy@arm.com>, 
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, Yi L Liu <yi.l.liu@intel.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="us-ascii"

+Tom

On Thu, May 16, 2024, Kevin Tian wrote:
> > From: Zhao, Yan Y <yan.y.zhao@intel.com>
> > Sent: Tuesday, May 7, 2024 5:13 PM
> > 
> > On Tue, May 07, 2024 at 04:26:37PM +0800, Tian, Kevin wrote:
> > > > From: Zhao, Yan Y <yan.y.zhao@intel.com>
> > > > Sent: Tuesday, May 7, 2024 2:19 PM
> > > >
> > > > @@ -705,7 +705,17 @@ static enum page_cache_mode
> > > > lookup_memtype(u64 paddr)
> > > >   */
> > > >  bool pat_pfn_immune_to_uc_mtrr(unsigned long pfn)
> > > >  {
> > > > -	enum page_cache_mode cm = lookup_memtype(PFN_PHYS(pfn));
> > > > +	u64 paddr = PFN_PHYS(pfn);
> > > > +	enum page_cache_mode cm;
> > > > +
> > > > +	/*
> > > > +	 * Check MTRR type for untracked pat range since lookup_memtype()
> > > > always
> > > > +	 * returns WB for this range.
> > > > +	 */
> > > > +	if (x86_platform.is_untracked_pat_range(paddr, paddr + PAGE_SIZE))
> > > > +		cm = pat_x_mtrr_type(paddr, paddr + PAGE_SIZE,
> > > > _PAGE_CACHE_MODE_WB);
> > >
> > > doing so violates the name of this function. The PAT of the untracked
> > > range is still WB and not immune to UC MTRR.
> > Right.
> > Do you think we can rename this function to something like
> > pfn_of_uncachable_effective_memory_type() and make it work under
> > !pat_enabled() too?
> 
> let's hear from x86/kvm maintainers for their opinions.
> 
> My gut-feeling is that kvm_is_mmio_pfn() might be moved into the
> x86 core as the logic there has nothing specific to kvm itself. Also
> naming-wise it doesn't really matter whether the pfn is mmio. The
> real point is to find the uncacheble memtype in the primary mmu
> and then follow it in KVM.

Yeaaaah, we've got an existing problem there.  When AMD's SME is enabled, KVM
uses kvm_is_mmio_pfn() to determine whether or not to map memory into the guest
as encrypted or plain text.  I.e. KVM really does try to use this helper to
detect MMIO vs. RAM.  I highly doubt that actually works in all setups.

For SME, it seems like the best approach would be grab the C-Bit from the host
page tables, similar to how KVM uses host_pfn_mapping_level().

SME aside, I don't have objection to moving kvm_is_mmio_pfn() out of KVM.

> from that point probably a pfn_memtype_uncacheable() reads clearer.

or even just pfn_is_memtype_uc()?
