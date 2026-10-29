Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793293675;
	b=o6S6hLZouw4Eose9qpYbrKMKq1fpwZT8g3b/r2vFeShQhn6FB/mzQW1+sa45+FIi31nI
	 ugwN8IXD8e2er6ktYIJSn19zUmao1UlIoer92Af1GRSwFz0EQf+Bx4KpXN7LgXDDNw1yT
	 01W9nnAkthYNabO8hXHM1tTGyPvVD4ltUeTcoDxeQmOeA7aowZHLSGmB3aqr70AvB4NLk
	 g3nfQ02HKvBxxY1HE2l6FO/sraUHmXViIt3gSCUw4PRxR8R1LyMD0Tk9yaPuvUlUMkCnS
	 VUoKD/yHzSEdFDswwtCtQKP5HlvINBtpGj96V4LePyxNPOss+jFOYc7XKUkYX3atyDA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793293675;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=0YjGbXSGdFWqGTw7iXBWdHWj/MRYXXZreyMjEGvCLmY=;
	b=yoEHhOMiDl6PY+OGTArcBRJQauf/mMXCfjxxFnY00IINy20ouLzyzlV48ZWQ4pl1pC/S
	 MQB3d+kO1cAzqEDTr8dGOUlN065vHkpK4Vzf2uFd8qbuyaZt2QFLzVvImrU+2rI13jY1x
	 qViEWiRnRah/TI2bKgfBAIcpThxeUPUFQQMsKkU9mDPeF/wiWt6ZhrXCIpS72rrVJdUVR
	 lkK1R+P7xx1X16mWIdIp2zTZwNVPVbclNJI59jP8BX4D1/ldj5MGa0SGhNdaTsg6eFKdR
	 dWIgTR8QPqn3WDL7kPL9ZptZOV79BQYRA7NFwCVxZp/YI7JJpivHcGjWEapUIundOhQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GpSvzAUB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED9F606A31F
	for <iommu@lists.linux.dev>; Thu, 29 Oct 2026 17:07:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3ED9F606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GpSvzAUB
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c43fbcb4393so384331266b.0
        for <iommu@lists.linux.dev>; Thu, 29 Oct 2026 10:07:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793293672; cv=none;
        d=google.com; s=arc-20260327;
        b=jx1EE0GTw/RAZOuX+cPeaIpyqdA0Qy8q2hAUH1ttoQciI74Qhc8mHNUmRR+nUwFpkT
         LN5nn1ARAOk11mYD+JsWTJQlcL3Y5+4z9MB/c3euExom1ZAQgY65pkb68Kq617vcsQWA
         h9VLHXCxSH4Alq8dJuDQFBo51+7KkQ/nl0hAMQh40r8XpLlW/HFowqPhvvqX/B/ABQqA
         D1HofN/OWdQy2abcuL9cUCz9cbVAZ+gVsciySVRuToIwVXPAOTGeRNI2+Z12q3+P85ua
         F+xqn/4ED/OkhC0bv4JyQ85VIFzh4vg8k5aXCbabtBBfC5UT/2+rpbiz0MnHGuqVe9pA
         St7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0YjGbXSGdFWqGTw7iXBWdHWj/MRYXXZreyMjEGvCLmY=;
        fh=XGrTX5CU/p1f8vAGCtzTE7d/YBuF8ay+NGNaSxACvbY=;
        b=chF4wq2vTc3GYyDSk+dP7XmA5xYRovQuu/qWy8Bbc1WeVTv9TNkZFfz2KMSm3oDaHS
         jveA83ujjRPHWDSYLj24qG77dB9rmwDEwX2xgp0oJNILsFal3verbgFPEduJXAo4w6DN
         urbUGpDUZUZsCTVgi9dl1llfOCwL4ekBn4gC4YWYCbUSKtzIC1MsZ8pVfjtXAbTnhPzp
         szD3HzWw/xdudiGG+OOv9UtgCeZ/qMDpVOxleBiN0sBdV7UDo5ATg3jLvIWuRNAo3Xr0
         9TUcrB7Emm76SvYgPQ7nuy+KE4Zmt9Uaf1da/tk66IVCaoI4JeLYBX7N+aeqmv57SvLT
         3sgg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793293672; x=1793898472; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0YjGbXSGdFWqGTw7iXBWdHWj/MRYXXZreyMjEGvCLmY=;
        b=GpSvzAUBXmt6WMDqX0vRUW/nrcU3oeD6EwyzUXPt0EXbwzV1z9pWNqTeOKCholoS+g
         0/F67iAqxeavczt2b/TpCA405MJ4dNjFykcLHr6QZvqJCTKOURpgQ8b3Hhyq17QP/Lwj
         JxEknQIS2iK6I8bbXc2DeBMX53nL7VKDIDynIRxIV9oNSbux7TLMlBM2eUZhH4dfVCBU
         /yKkGQCOXYKSDCBH8hcGTTr/YCru6VA2o4PsAdfU6zdCZMwZSe5EyvxTtI2KXAaPy8cC
         AykEcyv10d6YtwjZ8Yzi4GQp8cO+FBoKtuIZTVooHBGhzt17skt7EtdH4jsudRogYUUC
         ox/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793293672; x=1793898472;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0YjGbXSGdFWqGTw7iXBWdHWj/MRYXXZreyMjEGvCLmY=;
        b=CVh3AdfCivKvbkW5LBr2a8cpjeNJ56/dd5CTJ76ro0RNrxCA2cd845aRbd0ot2WIBG
         1VdaslidYnUPDxzhTOutwYy/r5U84jsAU3JLjIoR8vio1BqW+DNTzEimISuD2CNWZiot
         QRvvcJOjNnsRAGsApSjfqeb9y6Ku8qvZnrnbgSa0pOvnObbT6x8E1SJpgePXzfZ3Gwp2
         RLmYYpEcnC8w9Mqf6pY07rCJ4VZDhdabVbUREsTLaWiLgHR0yD6S1nMC14yI4ccqgOBp
         mhrCeeIqVib2X1OqShfAQQPm+DS5L0g17TP0eL5zYMmjt9oJeS82vlF/WfugEur9r4xC
         T8rQ==
X-Forwarded-Encrypted: i=1; AKwUvBzwLHggELSDawY7ZCf9FDRPbQmSG4S/+lSP/GzNZHWEXx98fie32oYCUkGBk463AFnfKWd2WQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYINm5kHU2UI+dU25+B2Er7HGyQC7wAYTnXIFY0kOIJOQyAnkEtQ
	LmKxLvsind2kwicWSII/eYtHNDp4kSuNBWzV1oCKX4TZh0/52d8n1VJOUeuc6Kky1OqVUcSL9h+
	eXdXVWbZY1lUNsd3+rhPjaHkvWnQg4VU=
X-Gm-Gg: AYBFou0gLHrkSHerdeUz+ANkaCwkPJcAEjZ+Xftvpt1kYwi68GAsYGow8+UEw6RD4Pj
	xwNqBsjxKXsJMWXWF1nuh6JJm6Devou4CYUuVazq3VcENQfIoemf7vRZIn+E9weDTWdUkd3QGgT
	kAskp2Xau4jheUYSv0tSuw6gAAdamhNe4iBqicIhHHgLdmimiLnIpl8BXl/BcfAgGgFLGKUlOCS
	7/LV6TrdvRzNBmpTpkvxaVoCmeCs7YDbq4GsufV4QkIlNiImQqIHx2C5dRu2OENyFnHdac99QPk
	rQhKtcyTJdvjQaPuWER35T3dEb3AaS7pa3EDVUcG1NXzNV+Kv86H6VWZWcL1DADyeMmeG2oUoA0
	58mw/lSkE4Y1xT9HnLYM6EofEWgakaOcS1s/lJUQLfleXA+Y4Mis+FwsBpIkd7ZsuGL+pymz4Ar
	jEpQSik0xHrBwr9Kg=
X-Received: by 2002:a17:906:7313:b0:c45:c030:732c with SMTP id
 a640c23a62f3a-c49be03a73amr610119866b.41.1793293672256; Thu, 29 Oct 2026
 10:07:52 -0700 (PDT)
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
 <20261027154649.91571-1-griffoul@gmail.com> <20261027154649.91571-2-griffoul@gmail.com>
 <CAEvNRgGvxtgT=x3sLcasLZzCrtX+qEkHjPgs2yFRY0HRJvodag@mail.gmail.com>
In-Reply-To: <CAEvNRgGvxtgT=x3sLcasLZzCrtX+qEkHjPgs2yFRY0HRJvodag@mail.gmail.com>
From: Frederic Griffoul <griffoul@gmail.com>
Date: Thu, 29 Oct 2026 17:07:41 +0000
X-Gm-Features: AclHuK-XOTTZ577Y9tlQyUF1DU-1w6QS3FSXEW1jGcpzGvSeAxBjghFI3p-6WVU
Message-ID: <CAF2vKzP7mKAsbDFfj-ndoYSxxZYbNzVO7uysb-XtKytR4zuC7w@mail.gmail.com>
Subject: Re: [RFC PATCH 01/14] KVM: guest_memfd: Clamp the order of PFN mode
 blocks to what KVM can map
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
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 06:25:49AM -0700, Ackerley Tng wrote:
> Fred Griffoul <griffoul@gmail.com> writes:
>
> > +        kvm_mmu_invalidate_range_add(kvm,
> > +                         round_down(gfn_range.start, blk),
> > +                         round_up(gfn_range.end, blk));
> > +
>
> Yes, we want to make the invalidation range larger, but not the range
> being zapped. We can't over-zap for CoCo VMs.
>
> Would it be better to refactor kvm_mmu_unmap_gfn_range() instead of
> doing kvm_mmu_invalidate_range_add() twice?

Good point. As far as I can see, kvm_mmu_unmap_gfn_range() is only
kvm_mmu_invalidate_range_add() plus kvm_unmap_gfn_range(), so
guest_memfd could do the two steps itself: add the blocks around the
range, then unmap the exact range. The zap stays exact and the range is
added once. Or am I missing something about kvm_mmu_unmap_gfn_range()
that a refactor would need to keep?

> So I think we should follow the same model:
>
> + The provider reports the max_order based on it's contiguity
>   information, which is the actual contiguity of memory and
>   read-only attributes
> + guest_memfd further reduces max_order due to shared/private contiguity
> + After handing it to KVM, KVM further reduces the max order based on
>   the above.
>
> I think mappings for all other page tables (userspace and IOMMU) should
> also follow this approach.

Agreed. guest_memfd should then only reduce the order for shared and
private pages, and drop the gfn alignment and the rounding to a
page-table size, which KVM does. For the provider, "contiguity" would
mean a naturally aligned block of contiguous frames with the same
attributes, the frames aligned to the block too, so a mapping of that
size is valid as is.

One gap: KVM does not cover a memslot whose gfn and guest_memfd offset
are not aligned to each other. On x86, kvm_alloc_memslot_metadata()
disallows large pages when base_gfn and userspace_addr are misaligned,
but nothing compares base_gfn with gmem.pgoff, and kvm_gmem_bind()
takes any page-aligned offset. A gmem.pgoff check next to the
userspace_addr one would keep that in KVM too.

The export lookup in the series already works this way: it reports the
provider's block, reduced for shared and private pages. iommufd maps
PAGE_SIZE IOPTEs in this series, and will pick larger IOPTEs from that
block later.

> I guess the kvm_gmem_fault_user_mapping() equivalent of this max_order
> tuning is missing from this series. :) I think we should defer order >
> 0 to a later series though. I think read-only-ness should be part of
> the first PFN mode series.

Right, userspace mappings are PAGE_SIZE for now.

Deferring order > 0 for KVM and userspace is fine with me. I'd like to
keep the order in the export lookup, though: large IOPTEs matter for
device performance, and I'm preparing iommupt changes to split and merge
them in place.

Fred

On Thu, Oct 29, 2026 at 1:25=E2=80=AFPM Ackerley Tng <ackerleytng@google.co=
m> wrote:
>
> Fred Griffoul <griffoul@gmail.com> writes:
>
> > From: Fred Griffoul <fgriffo@amazon.co.uk>
> >
> > KVM maps guest memory in 4K, 2M or 1G blocks, and uses guest_memfd's
> > max_order to choose. A folio of order N is physically aligned and never
> > mixes shared and private pages, so the order needs no check. A PFN mode
> > provider's frames need not be aligned
>
> I'll need to think about max_order > 0 more for PFNs. I put it out of my
> mind because my frame of mind is that only order-0 folios are supported
> today. Perhaps with PFNs it's actually a lot easier to support order >
> 0.
>
> > and the provider does not know
> > which pages are private, yet kvm_gmem_get_pfn() passes its order to KVM
> > unchanged. KVM can then map a block over the wrong frames, or with one
> > attribute over shared and private pages.
> >
>
> Yes, makes sense that private/shared contiguity needs to be taken into
> account. I didn't consider this because order-0 is always safe to
> map. Thank you!
>
> >
> > [...snip...]
> >
> > -static void __kvm_gmem_invalidate_start(struct gmem_file *f, pgoff_t s=
tart,
> > +static void __kvm_gmem_invalidate_start(struct inode *inode,
> > +                                     struct gmem_file *f, pgoff_t star=
t,
> >                                       pgoff_t end,
> >                                       enum kvm_gfn_range_filter attr_fi=
lter)
> >  {
> > +     const gfn_t blk =3D kvm_gmem_is_pfn_mode(GMEM_I(inode)) ?
> > +                       1UL << PUD_ORDER : 1;
> >       bool flush =3D false, found_memslot =3D false;
> >       struct kvm_memory_slot *slot;
> >       struct kvm *kvm =3D f->kvm;
> > @@ -355,6 +360,16 @@ static void __kvm_gmem_invalidate_start(struct gme=
m_file *f, pgoff_t start,
> >
> >               flush |=3D kvm_mmu_unmap_gfn_range(kvm, &gfn_range);
> >
> > +             /*
> > +              * In PFN mode, a fault may map a block of up to PUD_ORDE=
R
> > +              * pages, sized before this invalidation (see
> > +              * kvm_gmem_pfn_map_order()): make faults anywhere in the
> > +              * blocks around the range retry.
> > +              */
> > +             kvm_mmu_invalidate_range_add(kvm,
> > +                                          round_down(gfn_range.start, =
blk),
> > +                                          round_up(gfn_range.end, blk)=
);
> > +
>
> Yes, we want to make the invalidation range larger, but not the range
> being zapped. We can't over-zap for CoCo VMs.
>
> Would it be better to refactor kvm_mmu_unmap_gfn_range() instead of
> doing kvm_mmu_invalidate_range_add() twice?
>
> >  #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
> >               kvm_arch_gmem_invalidate_range(kvm, &gfn_range);
> >  #endif
> > @@ -374,7 +389,7 @@ static void kvm_gmem_invalidate_start(struct inode =
*inode, pgoff_t start,
> >       struct gmem_file *f;
> >
> >       kvm_gmem_for_each_file(f, inode)
> > -             __kvm_gmem_invalidate_start(f, start, end, filter);
> > +             __kvm_gmem_invalidate_start(inode, f, start, end, filter)=
;
> >  }
> >
> >  static void __kvm_gmem_invalidate_end(struct gmem_file *f, pgoff_t sta=
rt,
> > @@ -670,7 +685,7 @@ static int kvm_gmem_release(struct inode *inode, st=
ruct file *file)
> >        * Zap all SPTEs pointed at by this file.  Do not free the backin=
g
> >        * memory, as its lifetime is associated with the inode, not the =
file.
> >        */
> > -     __kvm_gmem_invalidate_start(f, 0, -1ul,
> > +     __kvm_gmem_invalidate_start(inode, f, 0, -1ul,
> >                                   kvm_gmem_get_all_gfns_filter(inode));
> >       __kvm_gmem_invalidate_end(f, 0, -1ul);
> >
> > @@ -1535,6 +1550,44 @@ static struct folio *__kvm_gmem_get_pfn(struct f=
ile *file,
> >       return folio;
> >  }
> >
> > +/*
> > + * The order a PFN mode block can be mapped at: the provider's order, =
no
> > + * larger than the alignment of @gfn and @pfn to @index allows, rounde=
d down to
> > + * a page-table size, and never over pages that are not all shared or =
all
> > + * private, since KVM maps a block with a single attribute.  Called wi=
th the
> > + * invalidate lock held; an invalidation of any page of the block make=
s the
> > + * fault retry (see __kvm_gmem_invalidate_start()).
> > + */
> > +static int kvm_gmem_pfn_map_order(struct inode *inode, pgoff_t index,
> > +                               gfn_t gfn, kvm_pfn_t pfn, int order)
> > +{
> > +     u64 misalign =3D (gfn ^ index) | (pfn ^ index);
> > +     u64 attrs;
> > +
> > +     if (WARN_ON_ONCE(order < 0))
> > +             return 0;
> > +
> > +     order =3D min(order, PUD_ORDER);
> > +     if (misalign)
> > +             order =3D min_t(int, order, __ffs64(misalign));
> > +
> > +     if (order >=3D PUD_ORDER)
> > +             order =3D PUD_ORDER;
> > +     else if (order >=3D PMD_ORDER)
> > +             order =3D PMD_ORDER;
> > +     else
> > +             return 0;
> > +
> > +     attrs =3D kvm_gmem_get_attributes(inode,
> > +                                     mtree_load(&GMEM_I(inode)->attrib=
utes, index));
> > +     while (order &&
> > +            !kvm_gmem_range_has_attributes(inode,
> > +                                           ALIGN_DOWN(index, 1UL << or=
der),
> > +                                           1UL << order, attrs))
> > +             order =3D order =3D=3D PUD_ORDER ? PMD_ORDER : 0;
> > +     return order;
> > +}
> > +
>
> I'll review this function more closely again. I think the mapping order
> should fit into how KVM does it. After taking guest_memfd's input on
> max_order, KVM then lets these parties possibly tune the max order down:
>
> 1. lpage_info contains information about highest order due to memslot
>    alignment and alignment due to VM-level memory attributes
> 2. CoCo platform can impose a max order
> 3. Userspace mappings can impose a max order too.
>
> So I think we should follow the same model:
>
> + The provider reports the max_order based on it's contiguity
>   information, which is the actual contiguity of memory and
>   read-only attributes
> + guest_memfd further reduces max_order due to shared/private contiguity
> + After handing it to KVM, KVM further reduces the max order based on
>   the above.
>
> I think mappings for all other page tables (userspace and IOMMU) should
> also follow this approach.
>
> I guess the kvm_gmem_fault_user_mapping() equivalent of this max_order
> tuning is missing from this series. :) I think we should defer order > 0
> to a later series though. I think read-only-ness should be part of the
> first PFN mode series.
>
> >
> > [...snip...]
> >
