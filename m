Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD09718A6D4
	for <iommu@lists.linux.dev>; Sun, 12 Jul 2026 01:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783818096; cv=pass; b=qOt8omcCCrJfxVOAjtW/MDlmQGuGAvTVW8SBv3L9Kx1oR9UCDKk0kXdoqmYFMXyhex2k0R4lfMwHcdjclL+6dvCGMPVo5um2YL/Hged1rjP+mEHyxsZH96NnX6/UHBeSI83W3405uvizr4yqCdD/OZBQsLwEC3B55fXcxFsbv60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783818096; c=relaxed/simple;
	bh=R8xlg3RI6zLmG7lgrIZL1li1QImUsqosewBmuLTRodU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TwR6Qd7yki1NqF+JmPbP/upL78QJ+76Zhi1WxC3qpErA61Nol9+cZj0nHxZ3JLweWgq6hGNgaw77MSLn2MLuNAJ8RvYK/4dLPV12F6wPQ8TWY+73R+h7XSOOrkXd06u78gE0OITLcNgnbE7TZWy5fzonkpYhbJBROglynu05hs0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WZK2t0ve; arc=pass smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WZK2t0ve"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8485b358552so2228894b3a.2
        for <iommu@lists.linux.dev>; Sat, 11 Jul 2026 18:01:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783818094; cv=none;
        d=google.com; s=arc-20260327;
        b=sFg/bxZuuTG/kwnn+FeCi4oKfP4Qu4ycIw+0kW0DvMr5ZFzxDCtWyyQxd1Ej/uL8eC
         Djnr75gQaMT553Spcdg2zStaK3wzjRNHpAMy0rPxUoXA7+WvEORLSm9GfyrZlb1Pyc2C
         Qchc++yfrbMF2PEVViMSnCfkbWjdQrVg3diX6qrAc91C73nYNTH7tSYq3ABThMTQ1OFT
         Q+ATaBTDmBiOplm56pTGktv1ONWmopuvawgUoEk0OnscHMVGjYc39Jj/sokNi2MmaEgi
         YOX5rhwWZ0E4CGbOE4BYOI7qufHPOern6vDeV6l9jtaLD2SZC3JTYOqn9icqGDt1t7ZV
         8BVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=gGEYW3UAXERRsGZl8/IlnSaBkO9PGZLTdY+qnlryyhU=;
        fh=JwXAjRnj+GM2t3X1mV+DDUC766rgdo4bAhUDDMWuQek=;
        b=San4ZhtTWAWnWdivE2Im8kaQH78O8qR7TZQkqv1xtrirCIRXyTg/6rz88ctH3/hXLa
         NNLcvIwWkBZSZIHnftxzkKmdXlh252H1Wfcvehd5RWvXmYwbYgL+8ASFz5OKQc0yusEB
         k4O2d78hE5Bs++NC9phD47JNCBS/Dbt9nnfwwutuxaA/xs+PB45f4HIa4O02+f/EQqo8
         NqyuuPz5UPzT42eccMslrpvHbaIXUaMJUNNomzzar/w6RHJXArMsTWpnSrJci/aVjKZ3
         +y0GhEs86ngOUa43onLnUe3Yc4aLs4B+cGCqiV8exoVn4muEvUH1yeqXC/VKmLowEhY/
         orQQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783818094; x=1784422894; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gGEYW3UAXERRsGZl8/IlnSaBkO9PGZLTdY+qnlryyhU=;
        b=WZK2t0veCziy0DtBKdF0topIqRD4IB173sps+8EmQtPWwMmiENvDSBY5iWn1G4P/9M
         ihLS68gWx0+qgtee8my2k17x08CqcQ2mBpWcqpUDy9giP4MHAVmD3r/WSoIKLCCY7H2M
         5cUkDbaX9zDWgECVBi10FHxeKW/V1ic2rejC5TAe0ApJ7JPUHwJfxRUTTGqHXRZyI7sK
         X4lUKbi2RRnqlMtzwbbbDixztYwfzlcKYZe3Ck8O2s84Bu5VXjMWeojLcfNuAk04DYw3
         +x8QvgOVKx9QcHiHkHUqnVwNCdeEl+kOiqhavrOqgpHsYOUXGKe9DNeZlN3W6dIt1GL1
         zyWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783818094; x=1784422894;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gGEYW3UAXERRsGZl8/IlnSaBkO9PGZLTdY+qnlryyhU=;
        b=WQJ5VCf+1K1YoUrfXuH0/8PYwJblx9h2etQKc1KEgsT7DA5t+vZanZT5eYghuVyM/v
         uqIxtg1eUMkfirLQJxMEbwyBUAQuX9A/Jx/pCMd2h9dBaaw3zcfjn0ptNiJv8SOro3UM
         h/fMIXlKBVvyk4bDifV9UajaZm2q2vWPyCaoSsSn7yG/TJclKIcGvm10ywMbo4ko2fcv
         zAxvd6+4TwU81aqFkwrDSR9OW5lY/8rq5WaRkSEcw0klBjmnB0sXuEdP/tjjj0Y9WX9r
         15GeuaSjlLukD3dydwDrJd/QpX1zmkGSeHwtjs10OutiqQy4J3rzclVif/ljlTAEMJhd
         H+EQ==
X-Forwarded-Encrypted: i=1; AHgh+RpVHr71YIH7MMrtrJrIjE3SEmlM5+XkhGtQdyvbw1Natw8c32qbs6L2nt33+6Veo7CqZ3agpw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwXW6EyogeA0LVoBNQhJsXZ7wS9neE1c73SYclo5SKcePZGY7S0
	0cbe7BOKBKhb3FZ8UtAoJCjHKPkZneuXdQ+iUQj6kcmOv8KkCVlx5bSO9SBaqGSGBeR77hG55C9
	46iWVAleyDk4MthAPgtgUItL1+J3CxNMpONDInQLo
X-Gm-Gg: AfdE7cncjOWs+IK576wehRvE8+ZZxTWMTz6y6b1oFU9fa1qFF/ZQDVrcfMiLGcreeST
	rZInDr1Y20HIMgB4cqnefmPDUncukaQ8bCphOTPw7kofIci9afURPFYMzVu8aYACPoPcA8VLF6T
	m/917EyF1Fcuf9VCemyHsOJ0f7ARrcnPBMzqYtjCh6xzkvSfakO6hiiwne78VCypQZkkdlhIkzS
	/6FzQkBZqRojrVj+I1PlsjUK6PEM4sZeqZdLLkIxgJJFDkFfvQ5SZM08Xq0a/+kiE2pGE6eTDku
	G60psOAIPryMqYBWaJ9y8kuFxETF
X-Received: by 2002:a05:6a21:3990:b0:3bf:a7d5:df38 with SMTP id
 adf61e73a8af0-3c11075f8f6mr4812182637.9.1783818093599; Sat, 11 Jul 2026
 18:01:33 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 11 Jul 2026 18:01:31 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 11 Jul 2026 18:01:31 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20250602133009.GC233377@nvidia.com>
References: <20250529053513.1592088-1-yilun.xu@linux.intel.com>
 <20250529053513.1592088-11-yilun.xu@linux.intel.com> <20250602133009.GC233377@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Sat, 11 Jul 2026 18:01:31 -0700
X-Gm-Features: AVVi8Cd0bGOMjMsYrL4vU20fXx-xb2mKPsbs-m9K5p8jfizmd9no0laxFphKWjw
Message-ID: <CAEvNRgFpJWQ5M5sQhGpQUV3GbBq9N+MQhhaxdxa=D8ky94SCsw@mail.gmail.com>
Subject: Re: [RFC PATCH 10/30] vfio/pci: Export vfio dma-buf specific info for importers
To: Jason Gunthorpe <jgg@nvidia.com>, Xu Yilun <yilun.xu@linux.intel.com>
Cc: kvm@vger.kernel.org, sumit.semwal@linaro.org, christian.koenig@amd.com, 
	pbonzini@redhat.com, seanjc@google.com, alex.williamson@redhat.com, 
	dan.j.williams@intel.com, aik@amd.com, linux-coco@lists.linux.dev, 
	dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, 
	linaro-mm-sig@lists.linaro.org, vivek.kasireddy@intel.com, yilun.xu@intel.com, 
	linux-kernel@vger.kernel.org, lukas@wunner.de, yan.y.zhao@intel.com, 
	daniel.vetter@ffwll.ch, leon@kernel.org, baolu.lu@linux.intel.com, 
	zhenzhong.duan@intel.com, tao1.su@intel.com, linux-pci@vger.kernel.org, 
	zhiw@nvidia.com, simona.vetter@ffwll.ch, shameerali.kolothum.thodi@huawei.com, 
	aneesh.kumar@kernel.org, iommu@lists.linux.dev, kevin.tian@intel.com
Content-Type: text/plain; charset="UTF-8"

Jason Gunthorpe <jgg@nvidia.com> writes:

> On Thu, May 29, 2025 at 01:34:53PM +0800, Xu Yilun wrote:
>> Export vfio dma-buf specific info by attaching vfio_dma_buf_data in
>> struct dma_buf::priv. Provide a helper vfio_dma_buf_get_data() for
>> importers to fetch these data. Exporters identify VFIO dma-buf by
>> successfully getting these data.
>>
>> VFIO dma-buf supports disabling host access to these exported MMIO
>> regions when the device is converted to private. Exporters like KVM
>> need to identify this type of dma-buf to decide if it is good to use.
>> KVM only allows host unaccessible MMIO regions been mapped in private
>> roots.
>>
>> Export struct kvm * handler attached to the vfio device. This
>> allows KVM to do another sanity check. MMIO should only be assigned to
>> a CoCo VM if its owner device is already assigned to the same VM.
>
> This doesn't seem right, it should be encapsulated into the standard
> DMABUF API in some way.
>

I'd like to propose an alternative. I've been working on guest_memfd and
new to the world of IO, please help me along! :)

It seems like using dmabufs are used a little awkwardly here. IIUC
dmabufs were originally meant to expose memory of one device to another
device, mostly meant to share memory. Dmabufs do expose MMIO too, for
device to device communications. Without virtualization, userspace MMIO
would be done by mmap()-ing a VFIO fd and having the userspace program
write to the userspace addresses.

Before CoCo, device passthrough (MMIO) is mostly handled by mmap()-ing a
VFIO fd and setting up the userspace address in a KVM memslot for the
guest.

With CoCo, is the problem we're solving that we want KVM to know what
pfns to set up in stage 2 page tables, but not via userspace addresses?

guest_memfd already does that for regular host memory, tracks the
private/shared-ness of the memory, tracks which struct kvm the memory
belongs to.

guest_memfd functions as KVM's bridge to host memory. KVM already can
ask guest_memfd for the pfn to map into stage 2 page tables, and already
asks guest_memfd for the shared/private state of the memory. guest_memfd
already also blocks the host from faulting guest private memory
(mmap()-ing is always allowed).


Instead of using dmabuf as the intermediary between the MMIO PFNs and
KVM, why not use guest_memfd?

What if we make guest_memfd accept a VFIO fd, or a dmabuf fd?

guest_memfd can then take the mmap() calls from userspace and .fault()
from mm, and then forward them to VFIO or dmabuf. This way, VFIO/dmabuf
can stick to their original functions, and the changes to VFIO/dmabuf
would probably revolve around disabling access.

Disabling access would probably involve some of these:

+ When guest_memfd receives the fd, it could return error for existing
  mappings, or perhaps it could just force-unmap.
+ 1 extra flag or field to indicate that guest_memfd is controlling this
  file, so that if userspace tries to take some actions with the
  original VFIO or dmabuf fd, the request should be blocked.
+ Perhaps just close the original fd, like dup2(oldfd, newfd) closes
  newfd?


I'm about to restart work on guest_memfd HugeTLB and I'm thinking about
a similar approach for guest_memfd HugeTLB, where perhaps the interface
could be that userspace will give guest_memfd a HugeTLB fd at creation
time, and then the original HugeTLB fd would be rendered unusable in the
same way as above, perhaps like with the S_IMMUTABLE inode flag, but
also blocking reads, and not userspace-modifiable.


In the course of a CoCo guest's operation, will the guest need to
convert between private/shared MMIO? Will the guest need some pages
shared and others private? If these are required operations, guest_memfd
already provides the tracking and is going to have a conversion ioctl
very soon. Instead of further extending dmabuf to track more things, how
about letting guest_memfd track it?
