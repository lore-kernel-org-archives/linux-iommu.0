Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793284080;
	b=cxzRceJDvnC+VTRBJNOvGkn0+OCEnVOUNmE+FgY3VzByTpvYbj0BEciWrYI8bIECpkRU
	 2XRS4KohNwydq7Qw5lcJ4TcpkGmpOUgh1xUdv1XvD7Sc6n/gVGH5TEW+SpQtthI9S5ah2
	 sLiU/JVCFHNXGYDRTSJO4JyDPJ+oDU63jQYLekoVDXk5bNtqnZTQu2QqSJqV3xXsshIoM
	 08NmK3KSroK5EvT0miljexzeh7f72IONWO/WU0++PYE+nfCvpt4riBhg3qBvCvMh3+mUH
	 CLgE0dCoqnwxIugsy3jiOcITMLOxy6hXP7ehiYHFJ+bm8G92B2k5E+3BobqKNUSX/4g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793284080;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=gO96Ic3QVCctvLn6OTuZFYeIzqeAoDK7wy79tyihoyk=;
	b=Zp3p6lHPgsA3VYkgD+N+7YuvgOaCrlhuV6tmmK0GH4A24CPmRtpeq8z9IpY7i/xgKAI9
	 uOcpcRYczVfepMqXtdi4NCGYz/dKdnkF2Iw9O+Bbx2kdK2KbHDpWTAbZrSwpqHXhQc92D
	 EK1MufqJ8QFSPuAh/KzvzFpB5jh3FWAs5qHUQyfPnvSJYm8VfUjjYZb4gvu61oSkoQZ8w
	 4SPJkKHnv6VwspLOzw5n7hm8Uoug3GO00jsTG2zG/3RYvQ1qi1OMx3ZPPF1U5vzZFMJyv
	 /ONHzI2F/PFoxKxYuPd4N3utDpZSgquDnJImTt6Jd85+tyaBQA12uEF1FAe71TOFbNg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fcnXFa9V;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63991606A322
	for <iommu@lists.linux.dev>; Thu, 29 Oct 2026 14:28:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63991606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fcnXFa9V
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6b1aa27963eso1308611a12.1
        for <iommu@lists.linux.dev>; Thu, 29 Oct 2026 07:28:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793284079; cv=none;
        d=google.com; s=arc-20260327;
        b=l8uOnWxzm2eMSpDSAUyGEq06EMFtY+bL4baTULo0N4ZU88MEu2ROsUwZ2eFU+ACkfY
         1Fp7v2mtbO3zfBaXMMMbqgP5TL8R4r1vEhrBXAwZIBUgcdp7D3fQ1OAOahiDKblxfJsy
         rOQxAfo7sWm+uu1betgPPoep6IFmzeMmD9QMXLWBSB3XdruKFLoPSer+UqpZ9rlzfmFx
         7inr0gTsi9OOo0NM+OpWOofcgDZY1MuUOvCR2YxoaIcurgDD0GX21KtoODfTZ4wWAosm
         LxaYXlNd85eFxi31bX/P5w8uplavUum0gNSg9GlUDuKjoK2bIDcCcKdbmTcXjrzmA/J2
         63wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gO96Ic3QVCctvLn6OTuZFYeIzqeAoDK7wy79tyihoyk=;
        fh=BE3jD1FSPRASDJIX8Zh0LRLwi2uwSaJbP9H38VbWBK0=;
        b=JgBKJ7/g8ZYaQ9Hf6hQPd1In3vZpZ0fLnbAYZGj0tkEZmvRRXPXjLYKLb/Ez7lwpZG
         0RjHQtgu5JVkKz7NvnAlMfvHmfJWb6cwthS9Hf4d9FXB1m2D71xKBRjF5Ou9z3B33U5X
         oZYJELNeulRfIPnBrU5w43MW4g6ZryY97vRdfWdctXbDhUT0syoKaxdy2/0HCPQ6zGtn
         EHKVao8SRt5utqzlGuP7DidKmb4K+S2w1thMsISHubwYgYNI2xy6PXAUvJ8/uKNnaDZv
         mPtpA42bOd6JPjqRIGxwO9Njm51osj8sg/07AuMr2LrlKfBJMVGrW+ERgbPX7vG0Hvv2
         /cvA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793284079; x=1793888879; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gO96Ic3QVCctvLn6OTuZFYeIzqeAoDK7wy79tyihoyk=;
        b=fcnXFa9Vjh9xwDqXCIn8UNLmlqUQITR4PtVSoAndC/wHr+lGNNfsLT0rGU65TyloCf
         +QNLBr/zN2v2HeZubeHUrTUS+g/uZ9qeQCvxf+UBsIOXQ1F7sO3yWNpiIvmnOzIeR3DM
         ZUnVdHjvFIWuZIDPdKfGsZua4wlzQ7gsjUjTb8GuF2XX6zeMU3ayvxJvjIDn45IA94kG
         k2+Os/MMlfmtRZ/gD0i5ZyL7JkYvm2vHkdIXuxtrndjOhMmel1SDi5BYkHQCqhj+8NIP
         v7aSsReo5LBtpxFFrWEE3mttTFjzHAUAG2HmVgk0i7N6+Rd6e7cPmgEoWNH3pWNEJimO
         z7Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793284079; x=1793888879;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gO96Ic3QVCctvLn6OTuZFYeIzqeAoDK7wy79tyihoyk=;
        b=o5RMJRCE9689jB+x3e7joIs81bfa6NLbnBcaY7oWLhFKDKqzuPd+ysZ2dfJhcv8RR0
         FpIw2IxsKg5ph5vJgAquW2IUtARG0QLE5fmP0ZFELmva8A7bG0+Ke0OEOonpEoxI+vo/
         4TQpBKegd2zGVlXIGB9fHqY+x95WLTnaccUIyjgN4KGjANXS4SEQa4xMFC4+2j1sCxWS
         v1RcU2d3+L/PnghulA3mvFuTh+zF/G0kyaFGzWuyRWtI9ZIZfr0OG+qZ56+FJxdHehlT
         1Wdz0GjcIKcKMuGD91d4DlId088w4McEc9eCDH5EygbsisYc/iM+7d0SDBu2bbtQjp2l
         30Ug==
X-Forwarded-Encrypted: i=1; AKwUvBwzZ15zpEOS3fsglVr0ZSa+m3ASSJi+v4iAC9lFyEWtJ+WZefhGFZmQsf5rH3Onypj9jrC1vw==@lists.linux.dev
X-Gm-Message-State: AFq9FYJquMuHWrX11f84t+1dna2UsB/5hwXb34f+MAXO5IWNU1GMRLLV
	rxpf8RNtV0wHah0JMfjpEMKqxRprGaq1Z+klhUsk0KEKV8QgQvzh6dt/tocPsL6xuFsATnYfp8H
	G9j/+EXaW9x57O5NWRbWkzuyROQ70bIE=
X-Gm-Gg: AYBFou3AFkeXLW2JcqH1glxKOyuba5M76rY5j2h1rXn4r1xMq2Kfpc7Fn1aIHMC+3Ie
	NL6EIxMueOMAcOwQoyA+1N9X2Nql5jKRishIlnZ38e9qlR70eQWx/g6+bYHVaa24xdrbaodV98j
	YJ70EwCKn6sNEYCrjMJUgYSKrQjKajkyJXqwP2PvD3of2WBR6/2kI64RK+ThsvAWSS5vVeY4qCE
	5DZX1MxYX/znfR1svZj2gtLU9n6tWS6hDL0p8hT/fOOyYFdrHYl2JwlRPE0glX17krL/9R+9LQL
	xh3b14HYG37ydBMcjbom8Wu9ACq8DUe1KNV76TXQs4zkE1T8/5J0N/f9cNu3XR62NzYsyaESoP9
	UUe1dbQjHEVYf6LHrvNVZjZInF7p0cLyAGtm9Ma8rNOZgSbebjEv5p0u/0lKmQcrXcw4RhA==
X-Received: by 2002:a05:6402:4508:b0:6b1:bb19:de98 with SMTP id
 4fb4d7f45d1cf-6b4b0b09dcemr2163933a12.1.1793284076799; Thu, 29 Oct 2026
 07:27:56 -0700 (PDT)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261022-gmem-alternative-providers-v2-0-5dd1dc6c660a@google.com>
 <20261027154649.91571-1-griffoul@gmail.com> <20261027154649.91571-12-griffoul@gmail.com>
 <CAEvNRgGn09qrCZjUM5sdqQohPWE62GN4c52iK7ZV_gi5wro_Ww@mail.gmail.com>
In-Reply-To: <CAEvNRgGn09qrCZjUM5sdqQohPWE62GN4c52iK7ZV_gi5wro_Ww@mail.gmail.com>
From: Frederic Griffoul <griffoul@gmail.com>
Date: Thu, 29 Oct 2026 14:27:45 +0000
X-Gm-Features: AclHuK_kIg9XZ2cFnZL0tpsqSJGFt3xKJOd_xbKB2NrNWZ3oy-bCAgu9pf3hZSM
Message-ID: <CAF2vKzOTd=0rmMXvtAE_SzbbZ3C9n9jTcjM+Rj=ovFoYBsXCKA@mail.gmail.com>
Subject: Re: [RFC PATCH 11/14] KVM: guest_memfd: Add kvm_gmem_restore() for
 PFN mode providers
To: Ackerley Tng <ackerleytng@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, 
	Alexander Graf <graf@amazon.de>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Alexey Kardashevskiy <aik@amd.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>, Ashish Kalra <ashish.kalra@amd.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Baolu Lu <baolu.lu@linux.intel.com>, 
	Bill Wendling <morbo@google.com>, Borislav Petkov <bp@alien8.de>, 
	Catalin Marinas <catalin.marinas@arm.com>, Christian Brauner <brauner@kernel.org>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Connor Williamson <connordw@amazon.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, David Hildenbrand <david@kernel.org>, 
	David Rientjes <rientjes@google.com>, David Woodhouse <dwmw2@infradead.org>, 
	Erdem Aktas <erdemaktas@google.com>, Frank van der Linden <fvdl@google.com>, 
	Gregory Price <gourry@gourry.net>, "H . Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>, 
	Ingo Molnar <mingo@redhat.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	James Houghton <jthoughton@google.com>, Jan Kara <jack@suse.cz>, Jianxiong Gao <jxgao@google.com>, 
	Joerg Roedel <joro@8bytes.org>, Joey Gouly <joey.gouly@arm.com>, 
	John Starks <John.Starks@microsoft.com>, Jonathan Corbet <corbet@lwn.net>, 
	Justin Stitt <justinstitt@google.com>, Lorenzo Stoakes <ljs@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Michael Roth <michael.roth@amd.com>, Mike Rapoport <rppt@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Oliver Upton <oupton@kernel.org>, 
	Pratyush Yadav <pratyush@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Robin Murphy <robin.murphy@arm.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <shuah@kernel.org>, Steffen Eiden <seiden@linux.ibm.com>, 
	Steven Price <steven.price@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Tarun Sahu <tarunsahu@google.com>, Thomas Gleixner <tglx@kernel.org>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Tycho Andersen <tycho@kernel.org>, 
	Vishal Annapurve <vannapurve@google.com>, Vlastimil Babka <vbabka@kernel.org>, Will Deacon <will@kernel.org>, 
	Xu Yilun <yilun.xu@linux.intel.com>, Yan Zhao <yan.y.zhao@intel.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, x86@kernel.org, 
	Shuah Khan <skhan@linuxfoundation.org>, Fuad Tabba <fuad.tabba@linux.dev>, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, llvm@lists.linux.dev, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Thu, Oct 29, 2026 at 05:52:40AM -0700, Ackerley Tng wrote:
> Fred Griffoul <griffoul@gmail.com> writes:
>
> > kvm_gmem_revoke() does not fit: it would
> > zap the guest's and the VMM's mappings and reclaim frames that a guest
> > may already use.
> >
>
> I'd drop this paragraph from the commit message, kvm_gmem_revoke() is
> the complete opposite and isn't a candidate at all for the goal, which
> is to notify importers that a page is now available (and they can map it
> in).

Sure, I'll drop it.

> provider --1--> guest_memfd --2--> IOMMU
>
> 2 is definitely required, but why is 1 required?
>
> Between the first .get_pfn() or .lookup_pfn_range() () and
> .put_pfn_range() or kvm_gmem_revoke(), the provider should consider the
> memory in-use by guest_memfd.
>
> When it's in-use by guest_memfd, then guest_memfd should use --2--> to
> map into IOMMU page tables as necessary.
>
> When it's not in-use by guest_memfd, why would the provider force it
> into guest_memfd?
>
> If the guest VM knows that the page is now usable (some other
> communication channel), it would touch the memory and do a .get_pfn(),
> that would be successful this time. Perhaps that's when --2--> needs to
> be performed?

The IOMMU never asks, and the CPU may not touch the page before a
device does. A few cases where only the provider knows:

- The provider gives frames back with no guest involved: a page that
  arrives during post-copy, a range moved back to the VM, memory given
  to an overcommitted VM.

- The guest already gave that IOVA to a device as a DMA buffer. The
  device writes it without any CPU access, so there is no .get_pfn()
  from a stage-2 fault, and most devices cannot fault.

- A read-only frame becomes writable. KVM finds out on the next write
  fault, but a device write to a read-only IOPTE just fails.

kvm_gmem_restore() doesn't push the memory into guest_memfd: guest_memfd
only passes it on to its exports. Stage-2 and userspace mappings stay
lazy, and iommufd looks the range up again and maps it.

I'll make that clear in the kernel-doc and the commit message. Would
that work for you?

Fred
