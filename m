Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FAF352030
	for <iommu@lists.linux.dev>; Thu, 23 Jul 2026 16:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784822517; cv=pass; b=eebYU6EAD4RAcbLcSsOE/X1kw+wWQlaAhenyQUljGxpqSq7yM7wpR0r14mJuqafJoGqUwZgv7+AaOUlK0bYdonLqYGH185nguVRdRqUJ+g1tjvHoyN1MnSlFe9swBBD1birxgCB1MLlgoSeW4TtQaMFqovVgjme8dWu+zc1A/Pg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784822517; c=relaxed/simple;
	bh=SzUUVckqYsDvAqBaHY0hD3E/5RcsItKvUC4bmUYmzx0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RNElmsgVPd37rLpilT3830Oqqg3u0CH4Oj7H71WQywaBqQLQ4qnVpiSxm20mEJtI4W3W3UjPB9XiIKSIY7pzAAP1R5qzZqWVwiG7eXBFc5jMWfb7pF8PCf10Kqd3+NhIgm8WF4LKnI9Igmx4izJoI8HXykG2UNtoWT9RU80J7XU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VVEGnKvz; arc=pass smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VVEGnKvz"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38759bcd877so755852a91.2
        for <iommu@lists.linux.dev>; Thu, 23 Jul 2026 09:01:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784822514; cv=none;
        d=google.com; s=arc-20260327;
        b=X4hk0Fax1JgjaoIoXA5dYi/zgR4hvCBsln181v8RfFhmW/NzzMfsgsVJFvuZTBRr+8
         BQzMlJXKRzyO72C+XK7cCCYiRX+l4QHDAA0Bbj3+PLubaXH1sMg05QvHTRy2gEM3EXN6
         dceR07MVp/W9PYQZ5u7gHiIf50oukhO8dpvQGXP2ChrWSHVU+x33eAi5ISKaJNBa02AU
         lbJSAZoqWI8VLll4eVPMgCgBRNV6kqFydJKXNa6qanFaaW9fv31JFNEyICQ8nuuMMEQc
         hT+PZ7YZmAkAoRxCdngisrJAaGpRFiUi6sOWwX4TsN8IqAuefGrWh6xHl/fsHsfs1TPv
         wM6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:dkim-signature;
        bh=SzUUVckqYsDvAqBaHY0hD3E/5RcsItKvUC4bmUYmzx0=;
        fh=XJGhA/LJxPtMMif2He0p82SmsSmdCVGP0a+CgzSvEQY=;
        b=Fnp/uDtnhoRS/QMVMlqdKmcN22nbKO4UCZT8brdGXUNx4X05aUdrWImZtVSnOIeFHU
         bW6xhzkY67/3YDyYVjbOaebkJPxqV7pvSiF63vH+6pF4St8Ha5apq66t/p2bB1T6VE6v
         N8209UzhMfJjRtR0IIvemy4qtMKsd2BNvuQ3zfxm8OXGr795+oLn4KsfUF+KnUMaCcTm
         cZSq8NY/edrttBXc1E6+rhLUmTNF3Oloprgzz1BUFfmzIoGnGTivqlU5nF+h/1ylgl+9
         PLDvhITtlk1SacuXJYKPvq5Q8ouacva4VRtA1/9lSC63WYIqX0okUfQW6E3SXoyVeiEx
         pMYg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784822514; x=1785427314; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:mime-version:references:in-reply-to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SzUUVckqYsDvAqBaHY0hD3E/5RcsItKvUC4bmUYmzx0=;
        b=VVEGnKvzAlmZjAiDCQIC+L/B3OXV5n2oE3eYYDXJnas18R37YQVCpklsH3SKiR/P1e
         wKKhj+VpD2726VTb0mZ5306dCe3X5kixaLGBvNpVUX4h2s62Mj9hv/CykGqCIyk8y7RZ
         GjBek6vup3CWEbvIGNEWxvFwNZhWYmd7Rz6XUZ4sabvxX6nSq/NnukYnRMmBt79EZwuz
         ncPWH61X6+W1DXuBkmc9ouwb/txKrs82dphQYFLfrWSXT2zQKF3fC+id6K0s0r6tXsIN
         AjN4cjSyHd8iUG7VpyG6a0ryzrWRdmqo6wKPCO1i4hKnMFLbwUwKpigvzRSOpF63jRZC
         2ZsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784822514; x=1785427314;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:mime-version:references:in-reply-to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SzUUVckqYsDvAqBaHY0hD3E/5RcsItKvUC4bmUYmzx0=;
        b=TP7pY1U9vagzs3kYbVkEgLKNhmXF6RWfdMQJvWNd80Pd9M5FGhQohETh1EcE6mEyh5
         1FaOluq9saN1xd791QkTaAIyeyBXhXoZLlbn5vtkwgkLRM0G6FEYklI1YqedfzFfMgjv
         rdCMyE97APFK5QXbC0WVkhcijDeZ6U7aVdRgVHXsrmV0QJGvq2k+sZ6FJ405eII5ruSy
         SVK6bdgS4bxPPVlp91gosgY9XORWmku3v5Uzcck8VC2MUsZbCTRcRZoo224MRnwU2Js5
         3Z0m8J/FlVWAqmo5KqKYa6YwBNzhvLAbGAdvxac778ApcHl9AtVrBA3Mr9Y1lj4ZNn1c
         ceWA==
X-Forwarded-Encrypted: i=1; AHgh+RqT2dN+HrIvZF2tJP1ieQg7i8tNKQDakCbGYICLMyqtkKnih8tZRTXN51FG8JRTTJX/Ek/L+g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yylf8mJIt5lv3zsYD/6ICBL/bted0q03jQh6UZISobTRwO1W1Ww
	rGLE4qa6ZvYP0UV0F7bQDlEaQu3kPFvErgOfZCMpX4Sl+wAKtBkB92QMPz4hsBY+I6zOGXWsvfB
	va9I/VKij7uEoGAQxdjC/M4TeoeoGu4Va/Z4EKDEM
X-Gm-Gg: AR+sD10G0mKDz+SHQeFgbVfTLOPWyXQKi/hZcslcGmNJ5qf8drQYADiUMReGE2wBXZa
	2wVS6ckqrTjaocQSGPxPFW74GDIWFjn+XIul0Pg/aplFzEzGsXlE3shMPVePnioilTaDo/we2Hu
	sJ+SsRGY/485LwLgBQR55FtlAk9sO9b+xRyMz2co7U2t+AceWDUAaxCga1Cr1kq18VL93I+gjNJ
	hGzWDdoPTqxe+gtXXsdj2uT/Yfmcr5B/DGbKssiZ8ilEqvCUf2N7b2f/v9JLFdsnnpcqiP1cg3R
	1puC5+umdg3FA/wRyc5dKS2gCP71egE+25pNvUYudhHM3yc+
X-Received: by 2002:a17:90b:4b49:b0:38e:4482:ab14 with SMTP id
 98e67ed59e1d1-38ec6a83858mr3735973a91.32.1784822512910; Thu, 23 Jul 2026
 09:01:52 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 23 Jul 2026 09:01:51 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 23 Jul 2026 09:01:51 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <1dc299af6b795a40c8887b3d84f915024f6446a9.camel@infradead.org>
References: <20260720111259.122911-1-dwmw2@infradead.org> <CAEvNRgG-K2HOJoMmdMSH0gEuLNhgX2tqUAakoRqEx6noNyU3vg@mail.gmail.com>
 <1dc299af6b795a40c8887b3d84f915024f6446a9.camel@infradead.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Thu, 23 Jul 2026 09:01:51 -0700
X-Gm-Features: AUfX_myTsSnhFM4SYFjmYfmScbccXbA1Oof3z74v9KJmENsO0cIiQ5ipcuK-Wcg
Message-ID: <CAEvNRgEWOnZqiXMijZqggEi1hm14HxZ++9GpDRXUHqoE4UD6Bg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/11] KVM: Allow alternative providers of
 guest_memfd backed by PFNMAP memory
To: David Woodhouse <dwmw2@infradead.org>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	Xu Yilun <yilun.xu@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, 
	Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Tycho Andersen <tycho@kernel.org>, Kees Cook <kees@kernel.org>, 
	Ashish Kalra <ashish.kalra@amd.com>, Connor Williamson <connordw@amazon.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Zhou Yuhang <zhouyuhang@kylinos.cn>, 
	Zi Li <zi.li@linux.dev>, Dan Williams <djbw@kernel.org>, Eric Biggers <ebiggers@kernel.org>, 
	Colin Ian King <colin.i.king@gmail.com>, connordw@amazon.co.uk, graf@amazon.de, 
	fgriffo@amazon.co.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

David Woodhouse <dwmw2@infradead.org> writes:

> On Wed, 2026-07-22 at 17:24 -0700, Ackerley Tng wrote:
>> David Woodhouse <dwmw2@infradead.org> writes:
>>
>> > For dedicated hosting environments, there are a few reasons to prefer
>> > using external PFNMAP memory for guests, rather than kernel-managed
>> > memory:
>> >
>> > =C2=A0=E2=80=A2 No struct page overheads
>> >
>> > =C2=A0=E2=80=A2 Easily managed in 1GiB pages (or larger chunks); no fr=
agmentation/THP
>> >
>> > =C2=A0=E2=80=A2 Faster kexec/KHO live update (every millisecond spent =
faffing around
>> > =C2=A0=C2=A0 with memory management is an extra millisecond of steal t=
ime taken
>> > =C2=A0=C2=A0 from guests)
>> >
>>
>> Also, no need to split/merge pages when converting from private to
>> shared if the host mappings can't depend on the refcounts in struct
>> pages :).
>>
>> > Today, there is only one implementation of guest_memfd: the internal
>> > shmem-based page cache in virt/kvm/guest_memfd.c. This series allows
>> > for other code to provide "a guest_memfd". This is an early path-
>> > finding proof of concept tested with AMD SEV-SNP as well as non-CoCo
>> > guests on x86 and arm64. I'm planning to build a memory-based file
>> > system which gives files for both guest_memfd as well as memory-based
>> > storage to allow things like userspace VM and orchestrator state
>> > to be passed over KHO/kexec.
>> >
>>
>> Thanks for raising this, good to know that there is more interest!
>>
>> Vishal and I have been working on guest_memfd with HugeTLB for a while
>> now. I'll be restarting upstream work on HugeTLB after the conversions
>> series merges.
>>
>> Vishal, Frank and I brought up having guest_memfd with HugeTLB with
>> VM_PFNMAP mappings at a guest_memfd biweekly meeting a while ago. The
>> consensus was that guest_memfd HugeTLB must support GUP and so VM_PFNMAP
>> can't be the only way that guest_memfd supports HugeTLB.
>>
>> Your proposal is true non-page-struct memory, which has been on the
>> discussion guest_memfd biweekly discussion backlog for a while
>> now. Google is definitely also interested in this.
>>
>> Frank also described some use cases [1] other than HugeTLB and the
>> regular PAGE_SIZE pages from the buddy that is currently supported.
>>
>> I submitted a proposal for LPC 2026 to discuss the interface. What I had
>> in mind was to have the KVM_GUEST_MEMFD_CREATE ioctl take a "template"
>> fd. guest_memfd will then read off what it needs from the "template" fd
>> (ops, like you have here), and the "template" fd could be VFIO [2] or
>> HugeTLB.
>>
>> You have a provider_fd =3D open("/dev/gmem_provider"), how about passing
>> that provider_fd to guest_memfd, where /dev/gmem_provider could
>> represent the page-less memory, like:
>>
>> =C2=A0 ioctl(kvm_fd, KVM_GUEST_MEMFD_CREATE, provider_fd);
>>
>> It would be cool if the fallback could be set up flexibly, like:
>>
>> =C2=A0 ioctl(kvm_fd, KVM_GUEST_MEMFD_CREATE,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [provider_fd, fallback_provid=
er_fd, ...]);
>>
>> I think guest_memfd should be the wrapper around other memory providers
>> because then the CoCo shared/private logic and special page table
>> handling for both host and stage 2 page tables is centralized in
>> guest_memfd, and also, KVM doesn't have to understand other, different
>> kinds of fds other than guest_memfd.
>
> Yeah. My approach was to make those "other kinds of fds" essentially
> the same =E2=80=94 they are "a guest_memfd", and KVM didn't have to under=
stand
> anything else (after a little bit of rework to have the generic ops so
> that other code can create its own guest_memfds). As opposed to the
> approach in Xu Yilun's TDISP series, which did teach KVM about a new
> kind of memslot.
>
> Likewise, I used dma-buf so that IOMMUFD didn't have to understand
> anything new either.
>
> I like your approach, inverting the wrapping of guest_memfd/dma-buf.
> The provider then gives a plain dma-buf (not associated with any KVM as
> it is in my current code). Userspace can use that *directly* with the
> IOMMU,

A wrinkle we will have to iron out is kind of the opposite problem, to
make sure that while guest_memfd thinks a range of offsets (PAGE_SIZE or
larger) is CoCo-private, the PFNs in that range must not be mapped
anywhere else in the host, or IOMMU.

One of the options I was thinking of was to seal off the template fd,
perhaps with an inode flag like S_IMMUTABLE, but not even allow reads,
and unlike S_IMMUTABLE, the (new) flag must not be changeable by
userspace.

Another option would be to just close the template fd so it'll not be
used, and the PFNs behind that template fd would just be completely in
guest_memfd ownership.

All non-guest_memfd paths to access the PFNs must be closed off, or
perhaps more precisely, any path that is not checked for
CoCo-shared/private status before building page table entries must be
closed off.

For CoCo-shared memory as tracked by guest_memfd (or non-CoCo, which
would use SHARED), the PFNs can still be mmap()-ed and actually set up
in userspace page tables.

Then, to use CoCo-shared memory for IO, IOMMUFD would also have to take
the guest_memfd (which IOMMUFD probably has to do, for CoCo-private
memory for Confidential IO, since CoCo-private memory can't be mapped to
userspace). Perhaps through IOMMU_IOAS_MAP_FILE?

In the process of mapping, IOMMUFD would tell guest_memfd "I have some
of your PFNs mapped.", and when guest_memfd gets a private->shared
conversion request, guest_memfd would get IOMMUFD to drop the
mappings. (perhaps some kind of MMU notifier setup)

Do you plan to use this for non-CoCo?

> and passes it to your KVM_GUEST_MEMFD_CREATE in order to get a
> guest_memfd for use with a given KVM. I think a lot of the warts in my
> series fall away if we do it that way round.
>
> I'll have a go at reworking it that way round... and see what different
> warts it ends up with. The interesting part will be getting actual PFNs
> out of the dma-buf (which is already under active discussion).
>

If we go with the above, IOMMUFD would get PFNs from guest_memfd instead
of dma-buf.

> I'm not sure I understand the 'fallback provider' part. If one provider
> doesn't have a page for a given address, KVM would iterate over them
> all until it finds one that does?

If each provider provides a .get_pfn() op, guest_memfd's
kvm_gmem_get_pfn() would try the first provider's .get_pfn() and if that
errors out, try the next one.

guest_memfd today uses a standard struct address_space to track the
pages that it owns. guest_memfd will have to use something else that can
track both pages and PFNs, and probably which provider it came from.

The more you probe me, the more complicated it's sounding. :) Still
worth pursuing if it's good to have though.

> Is that about falling back from one
> THP pool to another? Is this something that the generic KVM code needs
> to know about, or could it be handled *within* a provider, which can
> chain to the next pool if it can't find a page?

Handling that within a provider could be nice too, so instead of
guest_memfd trying .get_pfn()s in series, the provider will try a
hard-coded pair/list of PFN sources and then deal with the complexity
on behalf guest_memfd?

The flipside is for every combination of providers, the owner of the
virtualization service would have to maintain a custom kernel module for
the managing pages?

Maybe the flipside isn't too bad, actually, to provide more flexibility.

> Wouldn't we want that
> done transparently for both KVM and IOMMU consumers?
>
>>
>> [1] https://lore.kernel.org/all/CAPTztWajm_JLpp9BjRcX=3Dh72r25ELrXeGkOXV=
achybBxLJGS=3Dg@mail.gmail.com/
>> [2] https://lore.kernel.org/all/CAEvNRgFpJWQ5M5sQhGpQUV3GbBq9N+MQhhaxdxa=
=3DD8ky94SCsw@mail.gmail.com/
>>
>> > This series lifts guest_memfd's operations into a small ops struct and
>> > converts KVM's own gmem to use it, so it becomes one implementation
>> > among peers rather than the only game in town.=C2=A0 It also adapts th=
e
>> > SEV-SNP fast paths to page-less operation, plumbs iommufd to map a
>> > guest_memfd-backing dma-buf as CPU RAM (not MMIO), and adds the
>> > provider->KVM revocation primitive that makes overcommit-style reclaim
>> > possible.
>> >
>> > It's largely AI-built at the moment. My main design concerns are aroun=
d
>> > how we tell that a given file is "a guest_memfd", and how we plug into
>> > IOMMUFD. Presenting a dma-buf was the less intrusive choice because th=
at
>> > path already has support for taking pages away, but I'm less convinced
>> > that it's the cleaner choice in the long term.
>> >
>>
>> IIUC from this series, you're creating a dmabuf fd out of a guest_memfd,
>> what does "taking pages away" mean, in this case, from where/who?
>
> Taken away from the guest. Ballooning pages out, either for traditional
> memory overcommit, or for the models where a guest donates some of its
> pages to the system to run a "child" which is properly isolated from
> the guest.
>
> The physical page is reclaimed and needs to be taken out of the KVM and
> IOMMU stage2 mappings.

Will the VMM be doing a PUNCH_HOLE on the dma-buf fd or guest_memfd to
actually reclaim the page, or do you have something else in mind?

> If KVM wants to touch it again it must call the
> provider to get a new PFN for that range. This is roughly equivalent to
> the MMU notifier path on userspace VMAs in the normal memslot case.
> IOMMUFD has no equivalent of that for userspace addresses =E2=80=94
> IOMMU_IOAS_MAP pins the pages so they *can't* go away, which is why I
> used dma-buf for the IOMMUFD interface.
>
> I've actually been fleshing out the overcommit path a bit more,
> experimenting with adding async-pf support to guest_memfd in
> https://git.infradead.org/?p=3Dusers/dwmw2/linux.git;a=3Dcommitdiff;h=3D8=
94dd0fcb34
> (the sample provider just pretends its pages are slow to populate, so
> the guest gets to run something else while a "reclaimed" page comes
> back).
