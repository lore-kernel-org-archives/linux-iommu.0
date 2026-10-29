Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793282931;
	b=a907zHyE8cGWbrPEHXFPWkD229/bAT8vmbwpIxXPBsHHGOpAp/dUDIewEz5wMKuBWwJ5
	 xy6uARcyStkBd0EAyY56HsfqC3SWKU1dpnn9GPOZ6IeD+8lVDDgdW54ZxHWzuw+0AxJeD
	 j5/lD8AUT6AH1hcuyQFBYL6ADsvyLO9Ky8gzomPdyBjwq7AFzjLj2pkyqCzC6QPiPimV9
	 GTkaqfh2MDGOBTvpuIjo6Uu9yEuWhPAE1Ok5fL8pHX6bazJTMhnsXK75CRxEc2p/vnEV6
	 I/P8hB7pIMx2OLNk97/TMJ+w2eyghUooEVGsHMYhKy9rqR2U3u5NMFR1FNJigvdP6kg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793282931;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=H7Sot6fFV/mqoa6U1RpNz1ThNjxhsXi7WSqRiEBh7pk=;
	b=qEPEk0LkcUV05qGi8q3c6UVjl/uK+YOvwznYkHcU+VxIGtEL1U+3QxnuuwMgY8m1slca
	 1TZ9QJlT8wYHW6l7zTYWOvUmOkz8LjyRIi/vpb7zNFiTTjU00RaIA7udFSF5oHDUwj/jF
	 FcB8AmlZwuQUh07TaDQHkR+CC/G6rjy3AUK6KKcmlQG4ar2SJgD6BtpUjGcG6uBunU+29
	 k/D8uw0kc0zb1LNJk9kqW80qnvTuyvXqO4HruTHXFb9DFvwcsOERlkoFND9T7AaQZuLNA
	 l0wW7wRBaKYK68JjGp28fS7PqarkgkfkE4bSAN+0RQ7l5xZxIX3B6h7+vwiR//DJ9/A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UKPeO9+2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.47
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02A5606A31A
	for <iommu@lists.linux.dev>; Thu, 29 Oct 2026 14:08:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B02A5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UKPeO9+2
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-917a64f28d0so10038276d6.0
        for <iommu@lists.linux.dev>; Thu, 29 Oct 2026 07:08:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793282930; cv=none;
        d=google.com; s=arc-20260327;
        b=N+pBBN20MEgHd/C/togCWwGZ0nDAx6WUWbU6DZaiAXm9Lb2RiBXzdm3Syoh0To1PAt
         yiBxv/Pra1JTC71Jiq/45RxdxNqnlR6gPxpuyJxIjF6RaJz6wcawAmSSaXl3/bWpgiVN
         XidEfi7/1wRM59cM8Td8gjJu5FUO9ILLGEQsHxE44wKOFhRM9kTKoHZHK2ucjNc42Pku
         u6avXtf9/9db1Tzof5ufWHpwSRmdzMRHgll1BSuaWAPaF1iZUF1MXba+ky9ryMHJJmXC
         qXgT6d90IBqPPCdP1r1fu2gcUtcCSrtWKfL6BPS65gdzQoYqkGdQ5bZRi0xx2bei2gfk
         GMmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=H7Sot6fFV/mqoa6U1RpNz1ThNjxhsXi7WSqRiEBh7pk=;
        fh=1cnkGhznSFejRuymSEEq7uyzzz+Miw+h732QXpdUXCg=;
        b=srZjJ50TkQLb4nya1RVMJ9tqFniE0w+IBb++jG8qBIYwenzNyc38li5H/nlrSYJ2Yn
         Gf8rJ1xIvnac4CS7sI/aA15uRebKDCO20akWKhE9uJEjSELbP27CN0bmHxMM7LCzd0t9
         xlO3PELQrysVqe059Y99oXSWCkgVIsSfEO/wo5ZhGDBKPBYRfacXPnbDixdkpjxwnmKo
         QoT/prL/o1oR2q+9MJRZWxWJEEBpfV/Hnfbm2jYXn7z0mD9F1d51Q7KcqzFJFAvVxMds
         AtmIhKAD/qStfCgaNgN4A2rAS3ANGKTSW/v8pZaxZ/yOeoeDgkdWe1xud85XQIGWe2kv
         M7sw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793282930; x=1793887730; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H7Sot6fFV/mqoa6U1RpNz1ThNjxhsXi7WSqRiEBh7pk=;
        b=UKPeO9+2qc7xiP4MPR/7cBIz6CgSwDcTHk45ktToipsszvxPHPiYYVGrSoRIEsYOKU
         yYIUyssYdajaP0O1EwL1yGuyxeVszaFRgMqvjX8eBPT2JHtAkbYe1rFqa9KXjCcpw2x8
         R9BCKatTJWQ12u7STYp8MgIywDsCnxTKlDdYyy1ssXR5RPPDLFnmI0vS/ZFO5xwr+Tke
         9YedEadMsVQhl6mRgcIi7Al38f4wOuA/sJooJuiTpoZzzXvlHcdvIuCrjORUBK/zV5He
         KHxVsz8eHJZenkpFoIjQesAuAmJvnc3UG00g2gASZwaQIgUE/h+ufl5rsYsl+gy7OEbW
         IoTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793282930; x=1793887730;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H7Sot6fFV/mqoa6U1RpNz1ThNjxhsXi7WSqRiEBh7pk=;
        b=XZlJyc13hp2jZ9KXIHhlzTKCFP8YgsG3jm5SQ/AogzHlNoXlu/Ja2amg7LsyKgR02S
         SyHQKecQoG3ee97yUQKoFsLEZPIWZRr+V3v2a5YiPlAFBwyr0/DyqSkCUA2YwvNgADyR
         bWG7lf+CtWbp0+DyMzjokYXMHtQRpefvh+WZ4NMZzbE4sFInbsQJXS62uK9suCFfwvBg
         n4fBLQRdVOcAkMryXAUeqdl0ojxnrffRV86JVp2/EepWaSvPjtoLjQrNuUYHiQ6cBxi1
         C3q6Bt3b0W9dquYUNbffbXjWTDa2YSt3NTWOLvKnZ/Yy+V5Yfh3/9A1ajb+sKV3HgEbl
         iw2w==
X-Forwarded-Encrypted: i=1; AKwUvBw3m6/dEVdN5ggoWp1QPcyImcuZUPnHpnPvoLeUahN1JVQ3I38hjwVuMcnyWtsVp68+Z4r2tA==@lists.linux.dev
X-Gm-Message-State: AFq9FYJeLm4+mDCqEbhFNHqd4loNoGqu12OjhbSvfmNFvDUcDasAjgFP
	CJ87yEJnx1/Cu61PRJVEUgLOkSllhBNvj8aa/cEbqPS1ocQ/cIREtA46lf1yi2YymAHlrCn3QBG
	KMoQv0WBu7WohCM91cflCKVtuU3LJxS37YBFfWkyn
X-Gm-Gg: AYBFou2y2dQLfv8ydm71smGKXfmJNyXfbqsu6XkBkTV0hEZ2ChkIAt85BfTXEsgUS60
	L4ZDmsZhH+yVh9x41ob7whKL68hEYvpNL/+XOYwn/hOjykfQBUVBsmAuiUCaHYNaGr2GYQ2deVc
	WOQO1BEV9j40tErh+/w3xD6HR/yp+a5H2D0oi/t+B83+vh9lZFPnJfYvh2LZbAs6FtMKy3SpQr9
	K+0++UERJZ8QsJxawt/M3iOC5BW2aRFR70BlxUO5mOPpHP7wAHaKUFXu2nKqmOr8pkVMMvuDqGS
	B0H/b0oBro6mgAdX30mkM/Q6iMMWhn63mX0N2jPvqAU76oJg8IeaIrvm3X2eKJfZqVBDQ1uDr0T
	NGugmkFkdBegovJw7I9dDpMUqsS3I8JbKAgpdqv3H0j5uoalFMY4jeOjK4R6r1fx3CQ==
X-Received: by 2002:ad4:5dc3:0:b0:917:9703:48b5 with SMTP id
 6a1803df08f44-91c90742c32mr40775726d6.26.1793282928607; Thu, 29 Oct 2026
 07:08:48 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 29 Oct 2026 07:08:47 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20261017073149.1303738-1-aneesh.kumar@kernel.org>
References: <20261017073149.1303738-1-aneesh.kumar@kernel.org>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Date: Thu, 29 Oct 2026 07:08:47 -0700
X-Gm-Features: AclHuK_fk7ikZ1Ry_rR0lNw1rkr7m6j782yki2DT2D_WNr6A4h89KzpbSsJWlnU
Message-ID: <CAEvNRgFb5zLkTph_9k3io=7UD6S-j3QPnjE3qVTvzeGZxEJSHg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/13] KVM/VFIO: guest_memfd support for device
 MMIO resources
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>, linux-coco@lists.linux.dev
Cc: Alex Williamson <alex@shazbot.org>, David Woodhouse <dwmw2@infradead.org>, 
	David Hildenbrand <david@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
	Kevin Tian <kevin.tian@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Robin Murphy <robin.murphy@arm.com>, Sean Christopherson <seanjc@google.com>, Will Deacon <will@kernel.org>, 
	Alexey Kardashevskiy <aik@amd.com>, Xu Yilun <yilun.xu@linux.intel.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Steven Price <steven.price@arm.com>, Fred Griffoul <griffoul@gmail.com>, iommu@lists.linux.dev, 
	kvm@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> writes:

> This series adds a guest_memfd device-resource framework for exposing PCI
> BAR memory to guests. The intended use is confidential device assignment,
> where KVM needs to coordinate private device mappings with shared access
> through VFIO. The Arm CCA backend is provided separately; these patches
> contain the guest_memfd, VFIO and IOMMUFD interfaces it uses.

Thank you for this revision to guest_memfd + VFIO support!

>
> The guest_memfd framework and Arm CCA backend are available together at:
>
>   https://git.gitlab.arm.com/linux-arm/linux-cca.git cca/topics/cca-da-gmem-backend
>
> Userspace creates a device-backed guest_memfd using the ordinary VFIO
> device fd as resource_fd, with GUEST_MEMFD_FLAG_USE_RESOURCE and
> GUEST_MEMFD_FLAG_INIT_SHARED.
> The resource mapping superblock selects its
> provider; get_pfn identifies PFN-backed memory. Eligible BAR intervals are
> registered as guest_memfd memslots.

> File offsets use the existing VFIO
> region-offset namespace,

Yes, this is great, thank you. I think we should have guest_memfd and
VFIO share the same offset to PFN mapping.

> allowing one guest_memfd to cover multiple BAR
> intervals.

Yes, this is an advantage I see of using guest_memfd to wrap VFIO too,
instead of requiring separate memslots for each shared/private range.

> The device-backed guest_memfd fd rejects mmap and fallocate;
> shared guest faults obtain bare BAR PFNs from the provider instead of
> resolving the memslot HVA or allocating folios.
>
> IOMMUFD resolves and pins the device's existing vDEVICE after its backend
> validates the VM association. Its MMIO mutex coordinates conversion and
> device state changes. VFIO supplies BAR PFNs, validates eligible ranges
> and excludes dma-buf exports while a guest_memfd provider is attached.
>
> Without GUEST_MEMFD_FLAG_MMAP, attachment rejects existing VFIO BAR VMAs,
> and new VFIO mmap calls. With the flag, existing and new BAR VMAs are
> allowed through the VFIO fd. Attachment invalidates existing BAR mappings,
> including huge mappings. Subsequent faults use base-page mappings so each
> page's shared-range attributes are checked separately. Mapping the
> PFN-backed guest_memfd fd remains disabled (We can decide on this later).
>

I saw your other email regarding how to handle read/write/faulting
(mmap). I still think we should have all these be blocked on the wrapped
VFIO fd and have it handled through guest_memfd.

The gmem_device_host_accessible() function in this series has a comment
that explains this, which is that the shared/private attribute is
guarded by filemap_invalidate_lock() in guest_memfd, and so having
providers call back into guest_memfd is probably going to cause locking
issues. That's also what I figured when I was trying to implement the
integration with the sample memory provider in [1].

[1] https://lore.kernel.org/all/20261022-gmem-alternative-providers-v2-45-5dd1dc6c660a@google.com/

> VFIO BAR read/write, ioeventfd and userspace mapping faults check the
> requested range's guest_memfd attributes.
>

Thanks for calling out ioeventfd, this is one other backdoor to possibly
access guest-private memory. To avoid calling back into guest_memfd to
check shared/private status, I have these suggestions:

1. Treat the ioeventfd setup as yet another "mapping" alongside stage 2,
   host userspace, IOMMU page tables. For IOMMU page tables, guest_memfd
   will have to do mappings eagerly on conversion to shared since the
   IOMMU cannot handle faults. We could also "zap" the eventfd-to-VFIO
   connection on conversion to private and "map" the connection back on
   conversion to shared.
2. Take a shortcut for now and say that if the VFIO is wrapped by
   guest_memfd, always block ioeventfd setup.

> This series depends on:
> * Ackerley Tng's "Allow guest_memfd to be created using a resource (pool)
>   fd" RFC, which provides the tmpfs resource-provider API:
>   https://lore.kernel.org/all/20260925-gmem-tmpfs-backend-v1-0-d36159822d18@google.com/
> * The IOMMUFD/TSM series, which provides the vIOMMU and vDEVICE interfaces:
>   https://lore.kernel.org/all/20261008055955.4014342-1-aneesh.kumar@kernel.org/
>

For easier testing, is there a VFIO sample we could use? How about mdpy?
Is mdpy representative enough for selftests?

>
> [...snip...]
>
