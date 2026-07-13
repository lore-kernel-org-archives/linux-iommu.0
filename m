Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1D23624C5
	for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 22:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783982424; cv=pass; b=KURovblIaUr3CnJLT+b16yLaebRTgeFzmwRNvAzVkBB8BCc+UJKJ3rFOnkXetXR5JJCyt0jgoAf5wU3devBsKNVfXM+7YyFVOoJMhAuh1fGSXM02uqszHhkCRk64X48x6djCrmNKMTyWHM+QsNcUvmVeWdHWxWD5piGqWOi7YrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783982424; c=relaxed/simple;
	bh=7LkfD6aXl9dK90wHStXoX1dSfuVb2Ck7kctZehI6Xxk=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qIqhvCieTlIDAuxPGnEBvvF+X0xUfc9Y7PEI0bSilrIpCQHnO0MgsL1n9B8EM04OU65nQ7yW1XIWPFfi4/T8LVnukLySiEh9kBYHYbGcnQvx6sMrANpIcNY2BnE8CTOqJO1vIDPkBEXkXGiP9/9SGobIeL1WYdjm6mfwM6TiKLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lQdRmQZ0; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lQdRmQZ0"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c15f47e6297so48451566b.0
        for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 15:40:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783982421; cv=none;
        d=google.com; s=arc-20260327;
        b=XVW6eBGClwNY0lTgQMz6nPMr5Kp80QfdAHthKn5RQslYm8JUGG1hN0Isg2hqnnjv/r
         /m9dfM6nXQ2e34wvPKyrdXLqwOQeUxarzKhHs/wtVmraR1r/X9XsTNv0FDHjBJPIQy+N
         KHD4SEHgSgHSJ5K5kj6p2pA7D0dlLVwTBr+FvkkfZLN7hk0ZgDo/Ij8+BKTZoGoRJEnG
         EUENwOyW48EBdmHDZ83WN3kI5vnTs1BB204PJODf59V3au2fUZ5nctHhD97veMR0dYVs
         a/Uc9lCJhQGcAEeuMxi2uabnw5IrvjDc995LIoyM53aBcynko+AJp5GgXqG98RAMzvQ1
         mrEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=7LkfD6aXl9dK90wHStXoX1dSfuVb2Ck7kctZehI6Xxk=;
        fh=OVlBUWQlXXQmg38dFFEzazI+Q5Rv4PR/2FpqzQQ1Duo=;
        b=dMQw1dNBvC6OdD20L8L0Z8gYnbMziD3h2sxwG17HtL22a76kE6EsYxRF7jRGoXneXL
         8kgQXd7W8cxxdYN36YITOTSA10a+KrGmiZAki1p/2bWuxa4oPW5AMxzWL+H3/gVRWvYk
         zRa8VtoPg5PRwDTtJ5enph/RTumkaXkuBvPO6d34r9aTQr06/Ufv0hnQCVBCaf/xdLfp
         4IBgyZdXlb3MP6MuKkICc69uHCStXS0PHFsOyU73L+K5so63d1JZ0ODku6MgYdlQZYDV
         2zGrHHHwQffRoGagxX5ZZm+9AHJZRZF+kakHkg+5AIigQnPbExCIl2Fp3zEtK/iKXy5u
         fu4A==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783982421; x=1784587221; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7LkfD6aXl9dK90wHStXoX1dSfuVb2Ck7kctZehI6Xxk=;
        b=lQdRmQZ0weChvZ2e+odDAbnTiM3ZvFnJIQAK8wPeiKYMtCBuEuyWa889Db9ttX7rIy
         QeJcwWyTmxN//SeyQy5ZWp4mSenAkfZ1W5VuOeUDf5XuK+DiVVDoypoQeXkhMf69G9GF
         lAHV8Su9r9V14C1aiajNAfx5YnYKxlj962NMG8PqxK6iq5G30zPzUszct04Zep+0d26C
         hBEZZligxFi5CFfNGCznc9ad4OuEkyrcCvu7XtRE2GlV8fiXgLdFC3v43UcOzQV43nrk
         bNaX8sF5wlbGJhAjjnwWAo33qRxdlANP7uCf806X54V9XB9dUwdx77BRyyrG6OsPpHkW
         lOZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783982421; x=1784587221;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7LkfD6aXl9dK90wHStXoX1dSfuVb2Ck7kctZehI6Xxk=;
        b=T5WHTpWLWWRTBrG2Wfex5vxiCSRy7/bRuWIdbE2wAaUPL41EcT1sMRiccFBoWelyIs
         u5C5UMD7nAztq6pBEDFzqD/IgyDx/knuA2dp3/xUIY3+LTmiFUjyYR/MQcLtXDa8UV6Z
         8dAD4JVLZUD8/OqkZvQi3c6Uqw5+SaMxBsy6p1J7uFRWesJu+imBnn4vLUaOKcyaA5Xx
         OrgvIokoOm1cAc1n4Vle2JNxpmtiQ2t4MB3GuYNBY/1PnN6xIx5GhLlgQ7a3zgMDwNcU
         eWQR10jSBk73ygZCjob0DTeV6EDTZe/fcr9iOQ7r4RDKG+6FSftTwbba4E14/LHIhntt
         3Tvw==
X-Forwarded-Encrypted: i=1; AHgh+Rqc3jsIHVQnRn7nA086UeROKPMl9hykZUAfPUDP9WYXHOHuR8jv7YXxug/ecSS/HYs8D+NYLg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw0AalUNhn5M+hHFWBuKx9FI/6vpNcGAMulNBwBo1Zkexlif7yh
	Crtu69wrT1Y2SDqE+GUDHIUpCm9awLXd8PZv9lbPlIiJRfU6PaAgUMDTTI7U2//B5t0cgQsoN7I
	gQrgHsuswicoNN1i3VwvOaJ4CYk6cM0rPssES/mIH
X-Gm-Gg: AfdE7cnugq0w0uXBJ5YlzhBKaAglycoo9Ie63ttv3hQ9Kuid+nl6nLfrEu651u8cP6V
	UfxQBxcqPgM+pTtAm62DklAnPVi8yBhLjShJI8c9QlZLbmA/hXAf0G6D1VOiVP5+Fe1QNH9U0I3
	Ic+Yi4tdvtfdWzq/GvAr9xBd+PqmXlWExat7H+pz55xyDV4U36oXGJqtF4hkNYiPr94DWX/9miX
	EqW7HDIODN43+HbiPT8LPpWNniX1q/R5k4fmxRCQ915LcBFzX2lnnaWpEQOR74tUYS7NVh2JKV6
	hpWLto66znBANaYGKRJT6mhn/qYOcIv/YxrwEfXR+mVOhYC7O80+yJ+o3X4=
X-Received: by 2002:a17:907:398c:b0:c16:13e7:fd63 with SMTP id
 a640c23a62f3a-c161de05ceemr462764166b.0.1783982420699; Mon, 13 Jul 2026
 15:40:20 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 13 Jul 2026 15:40:18 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 13 Jul 2026 15:40:18 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260713191727.GH674038@nvidia.com>
References: <20250529053513.1592088-1-yilun.xu@linux.intel.com>
 <20250529053513.1592088-11-yilun.xu@linux.intel.com> <20250602133009.GC233377@nvidia.com>
 <CAEvNRgFpJWQ5M5sQhGpQUV3GbBq9N+MQhhaxdxa=D8ky94SCsw@mail.gmail.com>
 <CA+EHjTwd9uku-ZV5y8xcK8VWdOfhcchyW=_fzjpCf5Vk2wQoGQ@mail.gmail.com> <20260713191727.GH674038@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Mon, 13 Jul 2026 15:40:18 -0700
X-Gm-Features: AVVi8CeLrPp9U0h6s0bW1dfkDuvwNQDlx835UcZJGSgXNK2eLWnyQH0juXRBY34
Message-ID: <CAEvNRgEvGmOK3dXD4qdw5uXYD2sXNEVGT9NV2Zz-4H8VPb+KUw@mail.gmail.com>
Subject: Re: [RFC PATCH 10/30] vfio/pci: Export vfio dma-buf specific info for importers
To: Jason Gunthorpe <jgg@nvidia.com>, Fuad Tabba <fuad.tabba@linux.dev>
Cc: Xu Yilun <yilun.xu@linux.intel.com>, kvm@vger.kernel.org, sumit.semwal@linaro.org, 
	christian.koenig@amd.com, pbonzini@redhat.com, seanjc@google.com, 
	alex.williamson@redhat.com, dan.j.williams@intel.com, aik@amd.com, 
	linux-coco@lists.linux.dev, dri-devel@lists.freedesktop.org, 
	linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
	vivek.kasireddy@intel.com, yilun.xu@intel.com, linux-kernel@vger.kernel.org, 
	lukas@wunner.de, yan.y.zhao@intel.com, daniel.vetter@ffwll.ch, 
	leon@kernel.org, baolu.lu@linux.intel.com, zhenzhong.duan@intel.com, 
	tao1.su@intel.com, linux-pci@vger.kernel.org, zhiw@nvidia.com, 
	simona.vetter@ffwll.ch, shameerali.kolothum.thodi@huawei.com, 
	aneesh.kumar@kernel.org, iommu@lists.linux.dev, kevin.tian@intel.com, 
	fvdl@google.com
Content-Type: text/plain; charset="UTF-8"

Jason Gunthorpe <jgg@nvidia.com> writes:

> On Mon, Jul 13, 2026 at 08:08:14PM +0100, Fuad Tabba wrote:
>> On Sun, 12 Jul 2026 at 02:02, Ackerley Tng <ackerleytng@google.com> wrote:
>> >
>> > Jason Gunthorpe <jgg@nvidia.com> writes:
>> >
>> > > On Thu, May 29, 2025 at 01:34:53PM +0800, Xu Yilun wrote:
>> > >> Export vfio dma-buf specific info by attaching vfio_dma_buf_data in
>> > >> struct dma_buf::priv. Provide a helper vfio_dma_buf_get_data() for
>> > >> importers to fetch these data. Exporters identify VFIO dma-buf by
>> > >> successfully getting these data.
>> > >>
>> > >> VFIO dma-buf supports disabling host access to these exported MMIO
>> > >> regions when the device is converted to private. Exporters like KVM
>> > >> need to identify this type of dma-buf to decide if it is good to use.
>> > >> KVM only allows host unaccessible MMIO regions been mapped in private
>> > >> roots.
>> > >>
>> > >> Export struct kvm * handler attached to the vfio device. This
>> > >> allows KVM to do another sanity check. MMIO should only be assigned to
>> > >> a CoCo VM if its owner device is already assigned to the same VM.
>> > >
>> > > This doesn't seem right, it should be encapsulated into the standard
>> > > DMABUF API in some way.
>> > >
>> >
>> > I'd like to propose an alternative. I've been working on guest_memfd and
>> > new to the world of IO, please help me along! :)
>> >
>> > It seems like using dmabufs are used a little awkwardly here. IIUC
>> > dmabufs were originally meant to expose memory of one device to another
>> > device, mostly meant to share memory. Dmabufs do expose MMIO too, for
>> > device to device communications. Without virtualization, userspace MMIO
>> > would be done by mmap()-ing a VFIO fd and having the userspace program
>> > write to the userspace addresses.
>> >
>> > Before CoCo, device passthrough (MMIO) is mostly handled by mmap()-ing a
>> > VFIO fd and setting up the userspace address in a KVM memslot for the
>> > guest.
>> >
>> > With CoCo, is the problem we're solving that we want KVM to know what
>> > pfns to set up in stage 2 page tables, but not via userspace addresses?
>> >
>> > guest_memfd already does that for regular host memory, tracks the
>> > private/shared-ness of the memory, tracks which struct kvm the memory
>> > belongs to.
>> >
>> > guest_memfd functions as KVM's bridge to host memory. KVM already can
>> > ask guest_memfd for the pfn to map into stage 2 page tables, and already
>> > asks guest_memfd for the shared/private state of the memory. guest_memfd
>> > already also blocks the host from faulting guest private memory
>> > (mmap()-ing is always allowed).
>> >
>> >
>> > Instead of using dmabuf as the intermediary between the MMIO PFNs and
>> > KVM, why not use guest_memfd?
>> >
>> > What if we make guest_memfd accept a VFIO fd, or a dmabuf fd?
>>
>> This is interesting for pKVM too, provided it covers more than MMIO.
>>
>> We need guest_memfd to be backable by a dmabuf for ordinary guest memory, not
>> only for device MMIO. There is mobile hardware that doesn't tolerate scattered
>> private memory (DMA engines that can't gather, IOMMU page-table size
>> constraints), and a CMA-backed dmabuf heap is the practical way to get
>> contiguous memory at runtime.
>
> Why can't guestmemfd allocate directly from CMA? Allocating struct
> page memory through dmabuf just to put it back in a guestmemfd sounds
> very ugly to me.
>

I'd like to understand this use case better too, is using CMA through
dmabuf basically because CMA doesn't really have a direct userspace
interface? As in, for HugeTLB there's fd = memfd_create(HUGETLB) and
HugeTLBfs fds, but not CMA?

I did hope for this API shape to extend beyong VFIO and HugeTLB to
anything that has an fd today, but Frank did bring up the counter point
that not all memory has an fd.

>> HugeTLB doesn't help, it wants boot-time
>> reservation. Those pages are struct-page backed, so it's a different problem
>> from the non-struct-page MMIO case, and the shared parts still need to be
>> GUP-able.
>
> Isn't dmabuf pretty allergic to mmaping refcounted struct page backed
> memory since that wrecks its lifetime model?
>
>> More important for the API shape: conversions have to work on subsets of such a
>> region, at page granularity. A pKVM guest doesn't know what backs its memory, so
>> it will issue share/unshare hypercalls over arbitrary ranges of whatever it was
>> given.

For my future reference, does this mean for the CMA case, some page
splitting on conversion to shared (so each page can have its own
refcount to track users) will be necessary? (and merging)

>> If a dmabuf-backed guest_memfd can only be converted as a whole, we can't
>> use it for memory, and the guest can't be taught to care.
>
> More reasons not to involve DMABUF since guestmemfd already does all
> of this...
>
> Jason
