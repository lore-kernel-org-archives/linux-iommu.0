Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11403D1AA0
	for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 23:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783984568; cv=pass; b=HtOFjScKNXwtjciw2aePH9GiVpK1NN3u23YxLVpKOIDFCv+PyZUC54lMCjZFMsaQahvMuNjaXVGufB/BdUfWStlpQS2jx6u0zsxQFeX8FlcAaAQa5dNWQdpPT7kR4RXUuXvUndb/2tWOGmXXY08geAp/lBwYSL5Pu+0sm7NrpKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783984568; c=relaxed/simple;
	bh=jNitDBOyiAnqLYAVTV2WWuN1NaJEYQUlElQBlTgvBIA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sK/b44Ej5PeVXmacDe//9EltNmlo1KfgX1KWvDI+mhtFWvSn7MD0FJlfQowKKhvUH1L9r7J/Jtir2oPNnT59w3Hq7whPGTvG5LwtsMdBFICXBxEnF91W8Boyu7715EmhelUNG7Yd98EeBenq/HZUDD4m1Hmbc5VLv6KVNUK3TFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YgT+XIbj; arc=pass smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YgT+XIbj"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c9cf07d2df6so2384267a12.2
        for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 16:16:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783984564; cv=none;
        d=google.com; s=arc-20260327;
        b=Eaq20Rby6gvtyLY6GSPjM7jtTZOkoH+lMRgBh/4EOdsk4RxaZIKUk+j1shuj5AZTVY
         KSznyFwQsLebh+GQ4W1Qyx16dMpb26di52DW72QFo411Vaaz8jKtuphqTtSiBbpzkkg8
         llbDU55eI5mimuPBBOUuvuELAOq1KwPxtbIwBP92yPFXiSjujuCZvNSixX7laFDoQwYC
         XSTEeZrsZujKfzVrC4X+KR6epBTN5PtNYC16TwiPUuIOyUSyHN53YvVuFo0b/DtTio3S
         dvIs/7pg3GJE8EKXpOZgl3lq7+JRn8a4cL+L2kQo9fe0jCyeLvbUyke/+lCBZRyMElFy
         Zzqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=mNe9rM8ZI02kYm64C7ciEQBT8YD2/cothZS9irUHQA8=;
        fh=x5quZiLsZVzeTosX3bpR9qFzgJxaZYvl4RYi4sKgqKs=;
        b=Ky76d9d7IBOrJPaFv4InoRsHW2tzMrEknJ/soZWmcPIdGj52KD+Ue5QFkyfWSdi0OM
         5OtAPJ6vgbhVdxRxR5fF3kwgDnp5CoUlCjXxLRZ47MhTB4lxxVuBAIptgCyavZ0hiawF
         jT10c+IDC6mKhJeO+mHt8ZHLhs1mVfRVxt7kb4jruthlHCT6OUgGzeJV5FStHEAZi3ew
         SUgabksRugWdgoOeul65sXIo+APQ2lQEnK68mGFRKd4AgVWmw3fN9h9+PvD5TttBu2Gp
         eeXcCSA+WM569pwmnBId1JHIW/lgePCcIHPwdLkdfkR3a1tMQI364+WeAnXARII+DG/W
         J0NQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783984564; x=1784589364; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mNe9rM8ZI02kYm64C7ciEQBT8YD2/cothZS9irUHQA8=;
        b=YgT+XIbjH2EXETizkeuTekRsLhIFqUsCrdtKrdWmrfnFDfUrtrzWcecZEM4ifPl7qt
         32WYauaeXouEftRpD4wraIdNKFSDr8F8eMLGzlF/w4TXPEK6qwebjHlJqWzzj0i7LyL4
         e5C6TtEbrU+vIoQlobXZClZ+/7xRE9kpcD22K0oz5k7AUv0Cs6ZO4CL6dSUG0Odq64Ey
         r/CATd0YedBcfxwKq2gcGCEmnLUxVWfFzyFkTSttvmZ3c9rlxFJs9Cr9DrlCPVfdEQae
         QaJ52lQfoKurMiZXBl9VC0qZcZnLNqxVXIMlmTHSH2nZbj8kYtOXIMN7ej9IvtyDJMQP
         eh/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783984564; x=1784589364;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mNe9rM8ZI02kYm64C7ciEQBT8YD2/cothZS9irUHQA8=;
        b=kpl0g+A95pr3OLLAXDh3Qp6ubOw5L/DsyGMreFZp5LctsPK/DQtZSzzsC+WIKACv9K
         NiScYRYUZ2w+Zo9D5ZwMStOnk5+hUtG23k2RdrAsB4F7EJlM3R8q8UkrFh+S8i6TexoZ
         2YhdQeOlbDsrLuY+5UlWes9Hi/U9ffYNG14E1tjX1bur7S8TMLd100Zod/gf/IW4OB4k
         6bru3XgivFMMfy79G9v/Jq8nZEk+/19H/bPd2z3vHfTZzWiMdCA9lkOXLNxOn+WV+hfb
         qaIv5wkZEwjDe3IjXQLFnFCfOZfCxnXhbODx8GzuOtGmVJespsz5pQ8HF1eh72C2EB/0
         RFTQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr6qKZ5kKJSVDfUSf1uNmoJTBsxYMpoiWkjBmple84r69k58Uroaw3fhhi1nyb51V6untwO/w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy3gYYQk5G4JF3ju7AVIkptfO0RGjJMG3Lkm+2JlEgz50McHiBC
	9qTxzFP4RiX8tUJ/skQ1pzu021PPHuDL4YEDyhtf+Yhp31LiZzQyR+QZJoKZAGAFBSKnaP1Ka3d
	+VSX/8dtU0C6EYqeR3c7KBxjJ0QfsSrTNXqDtYaLL
X-Gm-Gg: AfdE7cmvAXtslIfJCLcyV+2yrLaWnwev+/pTuodxYJHzkmtF6pE3r9iIaEMxiszHL1d
	JFx2jN5A7Kbk1y0eOcz8/gs0aPAAan+ipvYailkGVc+ZOLdrZLvRxEzXZyZ9dxtVrkcjoA/+Box
	ihzVnsulqUIzyCrv/WWNi2H/3Sp0y7S2gJfMCJWIIwJzotDp+ccTKnac/wXrbP3ViO6vpzwA2QF
	G7wsMmSL6EsFClvfZCe5zFK6YRT9W/VtkOlsRkEHOhm9oBsZ/wh3QVyA7OVDsY0f0wHo6oCO6pM
	OPYduhO7WnwR9saS2pl8ePcPhFFNSmVmz/yRrh9hBMR/KtUrQHTsNfECLeU=
X-Received: by 2002:a05:6a20:cd8f:b0:3bf:83f3:b810 with SMTP id
 adf61e73a8af0-3c110a7b287mr11689858637.29.1783984563364; Mon, 13 Jul 2026
 16:16:03 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 13 Jul 2026 16:16:02 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 13 Jul 2026 16:16:02 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260712221934.GF674038@nvidia.com>
References: <20250529053513.1592088-1-yilun.xu@linux.intel.com>
 <20250529053513.1592088-11-yilun.xu@linux.intel.com> <20250602133009.GC233377@nvidia.com>
 <CAEvNRgFpJWQ5M5sQhGpQUV3GbBq9N+MQhhaxdxa=D8ky94SCsw@mail.gmail.com> <20260712221934.GF674038@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Mon, 13 Jul 2026 16:16:02 -0700
X-Gm-Features: AVVi8CczeGanVcGdhsy5HlDfD2XYPmjZautNceRH5dXiMXcxQCHaSODxjV4xdX8
Message-ID: <CAEvNRgEo2kLUmaGU-Vsgx2sTQvU_NNUJ4bRp5Z4Ygs_xvVLOYA@mail.gmail.com>
Subject: Re: [RFC PATCH 10/30] vfio/pci: Export vfio dma-buf specific info for importers
To: Jason Gunthorpe <jgg@nvidia.com>
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
	aneesh.kumar@kernel.org, iommu@lists.linux.dev, kevin.tian@intel.com
Content-Type: text/plain; charset="UTF-8"

Jason Gunthorpe <jgg@nvidia.com> writes:

> On Sat, Jul 11, 2026 at 06:01:31PM -0700, Ackerley Tng wrote:
>
>> In the course of a CoCo guest's operation, will the guest need to
>> convert between private/shared MMIO? Will the guest need some pages
>> shared and others private? If these are required operations, guest_memfd
>> already provides the tracking and is going to have a conversion ioctl
>> very soon. Instead of further extending dmabuf to track more things, how
>> about letting guest_memfd track it?
>
> Use another FD type was sort of my fallback if we couldn't get DMABUF
> into something workable. I'm kind of surprised to see guestmemfd
> proposed as the other FD, but I don't know much about its insides.
>

For now guest_memfd only supports 4K pages, so the interfaces we're
interested in are:

+ The .fault() handler, which core mm calls to service any page
  faults. For this, guest_memfd first checks if the page is shared, and
  if so, proceeds to return a struct page.
    + For VFIO, guest_memfd could call vfio_pci_mmap_huge_fault() and do
      vmf_insert_pfn().
+ The kvm_gmem_get_pfn() function, which kvm calls to get a pfn and a
  max_order to set up stage 2 page tables. Now guest_memfd returns
  folio_pfn(folio) and max_order = 0 since guest_memfd only supports
  PAGE_SIZE pages now.
    + For VFIO, guest_memfd would need some way to get the PFN, so
      probably something like dma_buf_get_pfn_unlocked() [1], but
      probably from VFIO instead of dmabuf. Perhaps pci_resource_start()
      is good enough to get a pfn.

[1] https://lore.kernel.org/all/20250529053513.1592088-2-yilun.xu@linux.intel.com/

> If VFIO can create one

At guest_memfd creation time, guest_memfd is always created for a
KVM. This is the first place where it is bound to a kvm instance. This
is one place where it helps Yilun with Confidential VMs, so KVM can be
sure that the memory was meant for a specific CoCo kvm and not any VM.

I think it might be weird to have VFIO take a kvm fd to create a
guest_memfd?

I was thinking that the userspace VMM could do something like:

  int vfio_fd = open("/dev/vfio/devices/vfio0");
  int gmem_fd = ioctl(KVM_CREATE_GUEST_MEMFD, { .fd = vfio_fd });

and creating from a template fd would also disable/close the vfio_fd so
that the following will fail:

  addr = mmap(vfio_fd);  // Maybe this should fail too?
  *addr = 1;             // But this should definitely fail so that
                         // guest_memfd gets to block private writes.

> and fill it with MMIO physical addresses then
> maybe it is OK?
>
> Jason

What interface would be used fill a guest_memfd with MMIO physical
addresses?

When a vdev is associated with a vfio file, can some other vfio file be
created that can also do MMIO to the vdev's PFNs? Would I be able to set
something to block any future associations to those PFNs? This will help
guest_memfd to prevent any other writes to private PFNs.
