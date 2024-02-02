Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057E11474A2
	for <iommu@lists.linux.dev>; Fri,  2 Feb 2024 16:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706890962; cv=none; b=kiceFoUxd8VLsTZCjpyeNmsadILy0QWwnVvuZmKFu5Oti39yu3v4kVxqD1Hqw+N1CUEWtVfbKD9LJhyL18koOBDBkyFhnuEr/KQPNWhFJvuuaxdp1gXQKiJ/lFSSUQcbjy6xnUeP5vkZDFn1Ngu6ryP4wIoF/JNweVP7TxA7yAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706890962; c=relaxed/simple;
	bh=+HK3TCtP7QCQZPyoTqhbwad/Bt2qOpO6afXcp1KlkLk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ozfOSPGAuCiZQZbZYKCD0KzrwbQUjnEdU33yD/bWcPoTuuqMa7X0RfOHYRnEFhg1vNYNihajj8WDXil8MoZUID4H3fk8iePhkBzs5xjYQKqYuheCF0vkgbY7Gfr2p8FodUx0kELWZTW8pgSGbJ020cpmLw/3IhsMFuGGS8qTs0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gEXGzKI8; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gEXGzKI8"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-42a8900bb93so17254931cf.1
        for <iommu@lists.linux.dev>; Fri, 02 Feb 2024 08:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706890956; x=1707495756; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/K3Nq70zFGvyKDwU3ZY65DWbsfqM8JJCUVupC8As58c=;
        b=gEXGzKI8I6J3ooAM83RYGJd5A0jgdC4HQ77ykP0YdVNi4FYb/iNFaslwYXNSNPew+T
         Hs26xK6tg++gChVv2nJ3ESH+PTYDgojW/WAFqLJtMeVoO68AHOUVSRJpurU/hJqlBrJn
         AIAS3pOXU52gSGPuNzjAkjHoJ0pp5H+FxRUtdaTpha6D9Q5AJ7fbVhQQJzfEoAjvEWce
         awAnutHeGyA0cRNMceCTZkZY2pwjHPyblUSfGR0VLxBqDvUhSTnTpZVuWNJfddufqpy4
         sk9dQ9y3oTQIQufSsMMJaLBwY+LUSXEiCCzkQnkMECFHoC2VmCUmqk27QrPn2Oik1zyv
         10Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706890956; x=1707495756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/K3Nq70zFGvyKDwU3ZY65DWbsfqM8JJCUVupC8As58c=;
        b=gq5F8iIOfGzELcgZK1WQF6bY5XCn9HEAfV3j2tR1n/2HDhfor04oM16ffjlCuvjRPk
         tx/8Du6Td5tVNx0aGyA0znQdZ9omYTNdlVWz+kosZsbMFUVxZv6L3J+CvzVPiKvZcPea
         r2DO37oYl5QzVP2dDyYWx/ga074EocmtPlF8ATBiz9+14Js4L6q0RETl9fID0UudBC6n
         5qD4jdM5HdVmE4eTCRxdqh5Spvz3GNOOG4ZXFyZGOD+scUvcVbbgehxzwR26cyw/A/V2
         g1usdZWL41TTGoC1yM1Fx84zD5BDqCwKyoCGlel45KfBT4Y0oaxQBnRqDWCyXaa6DdlJ
         Ll0g==
X-Gm-Message-State: AOJu0YxEEWH1znwOkuD4vanqIwqtiuwB69vO/yJd95diz1ySQ2JSIeYd
	xNggbmKI60lDozBsvCd/GxL2XDKU4CUNaohTStGOk2e4eUAoGBR1Y73W8U/t9U1aVBiWLjiqjG3
	sRbPYQo/a01O/jGIf4Hp5YgDBjJIqr57MRceJ
X-Google-Smtp-Source: AGHT+IEE5ISkbNXS6VfuxQo8VaEvgYlkPxi3PutlXh2ql5op0O+Q2FYYlI8Syviuws5w/gDm1/LIWZi6AuNnpgHXhRU=
X-Received: by 2002:a05:6214:2f08:b0:68c:8ae0:b413 with SMTP id
 od8-20020a0562142f0800b0068c8ae0b413mr1374192qvb.30.1706890955573; Fri, 02
 Feb 2024 08:22:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240112055251.36101-1-vannapurve@google.com> <20240112055251.36101-6-vannapurve@google.com>
 <6709a57c-48a0-4ddd-b64e-a1e34ae2b763@intel.com> <CAGtprH_ANUVU+Dh1KOq0vpT7BGbCEvD2ab9B=sxjzHYsKxFGeA@mail.gmail.com>
 <1d9d3372-825a-417a-8811-ffa501c83936@linux.microsoft.com>
 <CAGtprH8r0kYYqGoumsVeZq42cX8CN3cchkuRYhQULqtb-1nKww@mail.gmail.com> <3313c886-e964-48c3-8277-b47cb1955de9@linux.microsoft.com>
In-Reply-To: <3313c886-e964-48c3-8277-b47cb1955de9@linux.microsoft.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Fri, 2 Feb 2024 21:52:21 +0530
Message-ID: <CAGtprH9X0Yz_Z+QaYcLpLNXtY_Ye68aqvx-G1pOWZxv9SiRRoQ@mail.gmail.com>
Subject: Re: [RFC V1 5/5] x86: CVMs: Ensure that memory conversions happen at
 2M alignment
To: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
Cc: Dave Hansen <dave.hansen@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org, 
	pbonzini@redhat.com, rientjes@google.com, seanjc@google.com, 
	erdemaktas@google.com, ackerleytng@google.com, jxgao@google.com, 
	sagis@google.com, oupton@google.com, peterx@redhat.com, vkuznets@redhat.com, 
	dmatlack@google.com, pgonda@google.com, michael.roth@amd.com, 
	kirill@shutemov.name, thomas.lendacky@amd.com, dave.hansen@linux.intel.com, 
	linux-coco@lists.linux.dev, chao.p.peng@linux.intel.com, 
	isaku.yamahata@gmail.com, andrew.jones@linux.dev, corbet@lwn.net, hch@lst.de, 
	m.szyprowski@samsung.com, rostedt@goodmis.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 1:30=E2=80=AFPM Jeremi Piotrowski
<jpiotrowski@linux.microsoft.com> wrote:
>
> On 02/02/2024 06:08, Vishal Annapurve wrote:
> > On Thu, Feb 1, 2024 at 5:32=E2=80=AFPM Jeremi Piotrowski
> > <jpiotrowski@linux.microsoft.com> wrote:
> >>
> >> On 01/02/2024 04:46, Vishal Annapurve wrote:
> >>> On Wed, Jan 31, 2024 at 10:03=E2=80=AFPM Dave Hansen <dave.hansen@int=
el.com> wrote:
> >>>>
> >>>> On 1/11/24 21:52, Vishal Annapurve wrote:
> >>>>> @@ -2133,8 +2133,10 @@ static int __set_memory_enc_pgtable(unsigned=
 long addr, int numpages, bool enc)
> >>>>>       int ret;
> >>>>>
> >>>>>       /* Should not be working on unaligned addresses */
> >>>>> -     if (WARN_ONCE(addr & ~PAGE_MASK, "misaligned address: %#lx\n"=
, addr))
> >>>>> -             addr &=3D PAGE_MASK;
> >>>>> +     if (WARN_ONCE(addr & ~HPAGE_MASK, "misaligned address: %#lx\n=
", addr)
> >>>>> +             || WARN_ONCE((numpages << PAGE_SHIFT) & ~HPAGE_MASK,
> >>>>> +                     "misaligned numpages: %#lx\n", numpages))
> >>>>> +             return -EINVAL;
> >>>>
> >>>> This series is talking about swiotlb and DMA, then this applies a
> >>>> restriction to what I *thought* was a much more generic function:
> >>>> __set_memory_enc_pgtable().  What prevents this function from gettin=
g
> >>>> used on 4k mappings?
> >>>>
> >>>>
> >>>
> >>> The end goal here is to limit the conversion granularity to hugepage
> >>> sizes. SWIOTLB allocations are the major source of unaligned
> >>> allocations(and so the conversions) that need to be fixed before
> >>> achieving this goal.
> >>>
> >>> This change will ensure that conversion fails for unaligned ranges, a=
s
> >>> I don't foresee the need for 4K aligned conversions apart from DMA
> >>> allocations.
> >>
> >> Hi Vishal,
> >>
> >> This assumption is wrong. set_memory_decrypted is called from various
> >> parts of the kernel: kexec, sev-guest, kvmclock, hyperv code. These co=
nversions
> >> are for non-DMA allocations that need to be done at 4KB granularity
> >> because the data structures in question are page sized.
> >>
> >> Thanks,
> >> Jeremi
> >
> > Thanks Jeremi for pointing out these usecases.
> >
> > My brief analysis for these call sites:
> > 1) machine_kexec_64.c, realmode/init.c, kvm/mmu/mmu.c - shared memory
> > allocation/conversion happens when host side memory encryption
> > (CC_ATTR_HOST_MEM_ENCRYPT) is enabled.
> > 2) kernel/kvmclock.c -  Shared memory allocation can be made to align
> > 2M even if the memory needed is lesser.
> > 3) drivers/virt/coco/sev-guest/sev-guest.c,
> > drivers/virt/coco/tdx-guest/tdx-guest.c - Shared memory allocation can
> > be made to align 2M even if the memory needed is lesser.
> >
> > I admit I haven't analyzed hyperv code in context of these changes,
> > but will take a better look to see if the calls for memory conversion
> > here can fit the category of "Shared memory allocation can be made to
> > align 2M even if the memory needed is lesser".
> >
> > Agree that this patch should be modified to look something like
> > (subject to more changes on the call sites)
>
> No, this patch is still built on the wrong assumptions. You're trying
> to alter a generic function in the guest for the constraints of a very
> specific hypervisor + host userspace + memory backend combination.
> That's not right.

Agree on the fact that I focussed on a KVM for these changes. I plan
to spend some time understanding guest memfd relevance for other
hypervisors when dealing with CoCo VMs.

>
> Is the numpages check supposed to ensure that the guest *only* toggles
> visibility in chunks of 2MB?

Yes.

> Then you're exposing more memory to the host than the guest intends.

The goal of the series is to ensure that the CoCo VMs convert memory
at hugepage granularity. So such guests would need to allocate any
memory to be converted to shared, at hugepage granularity. This would
not expose any guest memory that needs to be used privately.

I agree about the fact that extra memory that needs to be allocated
for 2M alignment is effectively  getting wasted. Optimizing this extra
memory usage can be pursued further depending on how significant this
wastage is. One possible way could be to preallocate large enough
shared memory and use it to back smaller allocations from these call
sites (very similar to SWIOTLB).

>
> If you must - focus on getting swiotlb conversions to happen at the desir=
ed
> granularity but don't try to force every single conversion to be >4K.

If any conversion within a guest happens at 4K granularity, then this
will effectively cause non-hugepage aligned EPT/NPT entries. This
series is trying to get all private and shared memory regions to be
hugepage aligned to address the problem statement.

>
> Thanks,
> Jeremi
>
>
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.=
c
> > index e9b448d1b1b7..8c608d6913c4 100644
> > --- a/arch/x86/mm/pat/set_memory.c
> > +++ b/arch/x86/mm/pat/set_memory.c
> > @@ -2132,10 +2132,15 @@ static int __set_memory_enc_pgtable(unsigned
> > long addr, int numpages, bool enc)
> >         struct cpa_data cpa;
> >         int ret;
> >
> >         /* Should not be working on unaligned addresses */
> >         if (WARN_ONCE(addr & ~PAGE_MASK, "misaligned address: %#lx\n", =
addr))
> >                 addr &=3D PAGE_MASK;
> >
> > +       if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) &&
> > +               (WARN_ONCE(addr & ~HPAGE_MASK, "misaligned address:
> > %#lx\n", addr)
> > +                       || WARN_ONCE((numpages << PAGE_SHIFT) & ~HPAGE_=
MASK,
> > +                               "misaligned numpages: %#lx\n", numpages=
)))
> > +               return -EINVAL;
> > +
> >         memset(&cpa, 0, sizeof(cpa));
> >         cpa.vaddr =3D &addr;
> >         cpa.numpages =3D numpages;
>
