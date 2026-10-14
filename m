Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419772DC32E
	for <iommu@lists.linux.dev>; Wed, 14 Oct 2026 00:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791939456; cv=pass; b=faGqZLOkb3+qnmhD0tKhZPLiuqFXNjWIUF7uf1KHr+6tvH0ffdTwcRV8t04GBY0sVHj9KueBPu51J+9717F0emnDdPX0NY4dPX7cuU1gdYi7puOqPVL2RIqiwvEuVd+IQrpyb+6URF+mclULvoX0WKl+QXYnE6K33MEEufLspw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791939456; c=relaxed/simple;
	bh=7AJW+pkKJiIaZiVjk3cd+e7+JDtIZRXHEpkbTXm/BVg=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AZ+55IgCj2LRXimVKLz9/qTnYt+/JFAXt3cXLPS4mIaRPOjHN/4aFfyAEN180APOrhqKsJrqY51g49N8oNAQLgbNO79IafDLJxlzjn1hK/oiWsJKdaxUTA8wcc1BpqsbLU5nhWw+6b+veiU/Oyp7Jv3X2BRnUlaQMKxlRZf/ynI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GOEAbkFO; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GOEAbkFO"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-5352a876d5aso47054801cf.1
        for <iommu@lists.linux.dev>; Tue, 13 Oct 2026 17:57:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791939454; cv=none;
        d=google.com; s=arc-20260327;
        b=UgMKV/BMJRXYIvkLz5UslOw6fTuqkg6eKqfKB3az6GKbkHozWNKAWUHGbBEyaEx3GH
         eqT5wuFAmK6EqJSc4HkN9OvumhYf0zZJbYSg/R1tmpJzsIvkwF3lDSC3Sz9m+jaI6PBU
         d8Y6pJT4kSN39HCHpAJp0pOqh4Im7q/kelXv/In0+So1Od4a628pPcnKd0OKsmIF/kRi
         5cB/f3BqjgR9a5DK6oLMd/sCLHzvP9h6hltKg4RDBSxOhNs7HDCGp4Y5hQmGDmn3zaWF
         +33mzci7nLD0lVWBPwnCZVTJitNSf/SXazhev4Fb4z3rc1iDtCXaNN5UrPOTr2fxKAPs
         pH/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=7AJW+pkKJiIaZiVjk3cd+e7+JDtIZRXHEpkbTXm/BVg=;
        fh=ujO9gzSTq26+FAsylEIuS5jmTKVApdiexoC9wqA9uFo=;
        b=HN16W4LHTdNAQ369xlsGaYP0lnSviHU6TxIZkNuv4+34XZWS85kosO6sVN43YggCRL
         GV/kgCFWFoEVMSvA3d4Iavwn73rPyjnto2lcRw6/0KWjmHQKtDkiah2zbGLSMTiqA1aI
         8MzyyvXVAlFKwoD7HBtnGC6kkNKqCF1yIzHnQ16p5zZ4J1aU2YEw2h2JPq+M+Th05kEZ
         hzH2Vg/BvTZD2b8OPIHeOeqn2+cQGHOxx/oVp7pw38tXk8i6sqHaGAv5SeHM6v2XBMV9
         RmWd/5RTO8XkfAwzAQXG6C9pYstOuev2SrRjbzhKBiAxwEat2pGl1mK6ewbqdF4v32jt
         JlgQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791939454; x=1792544254; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7AJW+pkKJiIaZiVjk3cd+e7+JDtIZRXHEpkbTXm/BVg=;
        b=GOEAbkFORybpcEF/O4MYvqJlFxu/vXFQqs4E3JiNQ+3437SNn6RgrZ0iu4poLag2YG
         Aq7x+LlT5ebv7avm+xUTzFcg0ZyBOeZ2yQ7ttX0Ntqyn96qry6dHAvVGSxYKGC7Fvlbu
         piOMkb4zKpqvs3hb6+rZVHbxUOE0oIsLUO2SsTBnX25zcGUf4xyJXQZWNSv1nu6RopEi
         ZM9cOq58reUKi+lN+ZZYfP5Pd+cxJFGXIq5HOqhJitXc0E+xWilLBtMx4eA7kwPKjx+a
         0mwla+iWrTbZB0lwTNWbB6fQk4qxL6aOfEr/e/oGK3KeneSIc8xOdoRovXliAxOHkCjs
         Hz2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791939454; x=1792544254;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7AJW+pkKJiIaZiVjk3cd+e7+JDtIZRXHEpkbTXm/BVg=;
        b=IwNQyy/Ytg8F82kEtF23R1ZtUgy7WL5d5qu/A1bXGEFJQIp9amZtTcVr6qlEkysthO
         FfcbwB/S0iuxvOpeeZl9t+2Y2Ap7/fpI6yCkV9iuuHUwMtlneQShLlDW/vi8X3CKNAtl
         F6p73ZOM0CGBQ1D3BSjC6oHhbt1HosrgzqmLv6hUorTft9mBU7SdHwrwsELz2n3DKbgi
         n0N+ntzcFLkBL0e6EBlpgYxR9ftq2NPr4zQzN2TrViivbCI95nPoW9TYprvNNtjYTB0j
         H1QawXrfU6i3hMBjDOgOTO9f357EVDnNZNqj6eivYZPsSepCO1A+2A38yQ6tdzEcKcjX
         rD9w==
X-Forwarded-Encrypted: i=1; AKwUvBxUAMEzzRp4swu7aMoy21F/7/So2BbnnWnsowhwaHqRulVt0piu6tq9AKnBbWFGUO8oDFObdQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYLUMD3BF7R9Wpgh32KIXwMtEp8OqpQY6yDM9FlW9Co7E0xYKnxQ
	SP3JMy6PmgQAiPFkGTS4kgyiEVC397w064ELxPRTI1N2WKW2gzo/QEfpwv+aYwhaoPWQnyWxcsV
	wgV26p+eRMnUp7+fBm4sRGZAavuLvQC0xqmLwQ+rK
X-Gm-Gg: AYBFou2oYX+hsKWUN3DsH6BxPMsnALnPWiGijioUg3FfBCsHcK0I+7wA3x8D3taZBzi
	d10GEcnUImM4a6bRV4nEbBbklrZIDWLjqeEJJwSO31tPAe/r69bb9WyN1VJi3+pZ5TQwCF4Z+OR
	lDa4LwDHT5LpndDRBDlCTDCg9qAa7XXAcXey69lDFjo8t6oJy7API4l8UYzNS2hEDW3SyV+ymc9
	g/q5s5SlT6P/5yNS08RBI3K1qCPdlnV85iqP4usJz+ecDYrMtdSyio0Ymvj9SKCd1vDbxw27z9t
	4K/maRfAoHoSEL6kLxN38oWWSSUrdu6Wm75MRzjKIe1iwo68zIMxGoccpIaZr0M/V7tO9hkBsAZ
	x8OB1PFQsww==
X-Received: by 2002:a05:622a:1b89:b0:535:a5fb:644b with SMTP id
 d75a77b69052e-535a5fb697dmr226430261cf.69.1791939451986; Tue, 13 Oct 2026
 17:57:31 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 13 Oct 2026 17:57:30 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 13 Oct 2026 17:57:30 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20261010072504.536230-1-aneesh.kumar@kernel.org>
References: <20261010072504.536230-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Tue, 13 Oct 2026 17:57:30 -0700
X-Gm-Features: AclHuK8IpfUaX1YzXwxxGXLTDx_2ZBXI8B7jbHF2vFIgFQSAyamwlt7EhEC2s9U
Message-ID: <CAEvNRgFC6U4er0QhcwVOqWyz657WWWtidkNu0hKS5go4A3cP4g@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/6] KVM/VFIO: guest_memfd support for device MMIO resources
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Cc: Alex Williamson <alex@shazbot.org>, David Woodhouse <dwmw2@infradead.org>, 
	David Hildenbrand <david@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
	Kevin Tian <kevin.tian@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Robin Murphy <robin.murphy@arm.com>, Sean Christopherson <seanjc@google.com>, Will Deacon <will@kernel.org>, 
	Alexey Kardashevskiy <aik@amd.com>, Xu Yilun <yilun.xu@linux.intel.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Steven Price <steven.price@arm.com>, Fred Griffoul <griffoul@gmail.com>, iommu@lists.linux.dev, 
	kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> writes:

> This series adds a guest_memfd device-resource framework for exposing PCI
> BAR memory to guests. The intended use is confidential device assignment,
> where KVM needs to coordinate private device mappings with shared access
> through VFIO. The Arm CCA backend is provided separately; these patches
> contain the guest_memfd, VFIO and IOMMUFD interfaces it uses.
>

Thank you Aneesh!

I definitely like this since it builds upon [1], the model where
guest_memfd coordinates zapping during conversions for the
provider. Please see comparison with the alternative at [2].

>
> [...snip...]
>

I have questions:

> Userspace creates a device-backed guest_memfd using the ordinary VFIO
> device fd as resource_fd, with GUEST_MEMFD_FLAG_USE_RESOURCE,
> GUEST_MEMFD_FLAG_DEVICE

With the model described at [1][2][3], I was thinking that the VFIO fd
would be the resource fd. I'm hoping that there wouldn't be a need for
GUEST_MEMFD_FLAG_DEVICE.

The plan [3] was for resource fd to represent just the resource but not
provide any way to access the underlying resource, so that after
.attach(), guest_memfd's fd should be the way userspace would access the
underlying resource.

For tmpfs, the example in [1], fsmount() returns an fd that has no
.mmap/.read/.write ops, which fits the plan above perfectly. It tells
guest_memfd about the resource, but does not give userspace access to
the resource.

In VFIO's case, vfio_device_fops does implement .mmap()/.read/.write,
and I don't think there's a better existing fd that represents a single
device.

> and GUEST_MEMFD_FLAG_INIT_SHARED. Eligible BAR
> intervals are registered as guest_memfd memslots. File offsets use the
> existing VFIO region-offset namespace, allowing one guest_memfd to cover
> multiple BAR intervals. Device-backed guest_memfd rejects mmap and
> fallocate; shared guest faults obtain bare BAR PFNs from the provider
> instead of resolving the memslot HVA or allocating folios.
>

The model I have in mind is kind of opposite from above. Instead of the
guest_memfd rejecting mmap(), I'm thinking that the VFIO fd should be
the one that rejects mmap(), read() and write() once guest_memfd
attaches to it.

If userspace needed to mmap() the VFIO fd, it should instead mmap() the
guest_memfd fd. guest_memfd doesn't support read() and write() now, but
support can be added. The read/write for guest_memfd just forwards to
vfio if the offset range is shared and blocks if the range is
private.

For mmap(), for regular memory, mmap() is always allowed, but faulting
dependsd on shared/private status. It would be nice if the same logic
could apply to guest_memfds that wrap VFIO.

I prefer the userspace accesses to go through guest_memfd to VFIO so
that the shared/private-ness can be enforced from guest_memfd.


Is GUEST_MEMFD_FLAG_DEVICE there because GUEST_MEMFD_FLAG_USE_RESOURCE
tells guest_memfd to look up
resource_inode->i_sb->s_op->gmem_provider_ops but for VFIO,
gmem_provider_ops can't be stored in super_operations? If that's the
only reason, that's a very good reason to store gmem_provider_ops in
file_operations for gmem_provider_ops to serve different kinds resources
and include VFIO.

I also noticed the need to guest_memfd_register_device_fops, so that
guest_memfd knows the device supports being attached to?

What do you think of this: we have a common attach function for all VFIO
fds in file_operations that would look up the struct vfio_device to
determine if guest_memfd can attach to the vfio device? Actually, which
devices would not support attaching? Wouldn't all devices support
attaching? I'm thinking that using a device that is all-shared via
guest_memfd should be no different from using the device directly. All
operations should flow through to the device.


Regarding conversions, I would like to check: with Confidential IO, are
conversions at runtime actually necessary?

Is the only "conversion" the one when the guest accepts a device? If so,
maybe that "conversion" can be implemented by replacing memslots.

Pre-accept, mmap() the vfio fd directly, set it up in memslots.

Post-accept, remove the old memslot, wrap the vfio fd with guest_memfd,
set up the guest_memfd statically with shared/private ranges as the TDI
report requested and never allow conversions, replace the pre-accept
memslot.

> IOMMUFD resolves and pins the device's existing vDEVICE for the VM and
> serializes MMIO conversion through its MMIO mutex. VFIO supplies BAR PFNs,
> checks eligible ranges and excludes independent dma-buf exports while a
> guest_memfd provider is attached. VFIO host mmap faults, read/write and
> ioeventfd accesses check the requested range's guest_memfd attributes.
> Conversion revokes cached host mappings and shared guest mappings before
> installing private mappings. Other shared intervals remain accessible.
>
>
> [...snip...]
>

[1] https://lore.kernel.org/all/20260925-gmem-tmpfs-backend-v1-0-d36159822d18@google.com/
[2] https://lore.kernel.org/all/CAEvNRgEseLO+LbkwXrEit0H2LH5Wx-srSvHEMpt0=upPL3tF=g@mail.gmail.com/
[3] https://lpc.events/event/20/contributions/2551/attachments/2047/4693/lpc-2026-gmem-other-backends.pdf
