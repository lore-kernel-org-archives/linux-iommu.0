Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794262813;
	b=Fk8h0zc40cPk7Le/iBvkXxpHArSABhgOt4PGpHZ1d0sH8l0G/5j52cEIQyo8ZTLCyXwq
	 frx11fNKVKrWsM5cJ7RGprPgK4dDp9aaaaEbUppxm1v2XxNEzAnIAEAoE7rCLFsQ7OZDS
	 7Wx7jahbdZdlrVjXXilz8J5cyrgREUB92sykWVEZXXO+6/oDAhECLLzkF+cxhQctSMjFr
	 OONZs6JGiWg8X86jJQDDZ9bW0zO5lOi4Tl01cCbVJb8rCXKvinFKx/Qh2rBAGmRUAd48I
	 EVgusrL7HRzlfuHhMVvAE34j+yqgem5Buo/gTNLxpz+ZGp663Ga2/BPVrVIxxEJExMQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794262813;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=KfoXHxmDBEItkaa6hcxF0A8t0fZTG3DLVeoM83AlVUQ=;
	b=JX35CEcimwXazQe+7ZsrechcgcdM1ZHIGEI1Ir3n8Kj8JZiGyBDvB5bsUEgTpWDxjMIQ
	 IMzPw6s8oyZqpfZ09UVmGjKy+adKBwCjmnff3YmSzkhOqWM+dR8FaqoaZk7mhv/5SKudp
	 pP3FNi/EsV0JjSl+JAx6VwIWjkBDHLlEBZ7bsNvOtUaIghOdyjVNsbYdgBrxGseToTkNA
	 R+v8V+woNKgE4ZlyJwj/6ImdlUqee0DHLmQzff/wxxZ/t39uz/ZphyQcs+u0bLD31jCx/
	 ZsnpNPm2o5Gqq8Y4tw5bVLfPtMeR80/p2KXSn1uMMmXgrKK8bpHgE0qQ4ivrOPaqOIw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WKNV4H1x;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.52
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACE2606A330
	for <iommu@lists.linux.dev>; Mon,  9 Nov 2026 22:20:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2ACE2606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WKNV4H1x
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-91befbcad6dso15215026d6.3
        for <iommu@lists.linux.dev>; Mon, 09 Nov 2026 14:20:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794262812; cv=none;
        d=google.com; s=arc-20260327;
        b=njtNqB1tKBtsb+yz1sMI4RxZCU14WcQbmZBqEJTZAlNC+lVYitJwokqA+a2DrhaXLv
         PjWcRL5iHpiEcX2HmnIV6jt9hFpzfsMJ9t6cYh3ry8Ek0VqJvy2mh18Y9tRESaTWd4PB
         cwyJN/GlqWf/JoTSGAPYYQ9i9SWOajXsEHcPUuSsEVseV38dSiqqXkPWDVk7WUPEy1A7
         /fqIyJR9tSWBwPKWyKtsjg1BxA+k3LPDmsPSKvAyt3d8YWClXXkKYSe1QvYppMckM+IM
         DQN6/cZzp3Vt26lC/h3UDKC02bRIYjVq9/fYwrGxfjb0+2q1S9JAlyU0OSECD2EetCb4
         fYoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=KfoXHxmDBEItkaa6hcxF0A8t0fZTG3DLVeoM83AlVUQ=;
        fh=oxWn0Hcc0ZTW/h6U+cP07aB/9/rXYZ2B8a8y8bHOLqc=;
        b=TQKzOXGqPAChoCUaZ893xDGeP9LKh151pg2WUO0TXps+Qux3mUgL4EOQQ9g0HBPba8
         RUQCZ/BU4tL9Qm3pOpdB6oy9jmyGf+FLQAZDADv7HiV3/sTwVrbd5gEgSxMOK30Q2MCb
         ypcdAeUGxr3ny7CdqEQ3paYKn+o0tIdLVAaWIcb1EwPr6xE4GvRidokLCoJxQsTxCtCn
         T1B9Uuu9dAvUFHPNLhbRh/jUqLydUmIZ+03vj7dDd7i4syy4PbPj+oX69bFJRq02myP+
         p02XuFEj8CNxcX6BqP63qFtsjYO/U6yulzYC/IlbARXCn32helIZ4n9EYf1w1hmhqgAW
         XKZQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794262812; x=1794867612; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KfoXHxmDBEItkaa6hcxF0A8t0fZTG3DLVeoM83AlVUQ=;
        b=WKNV4H1x/tAD+zTkrybKKlp64hrXZod/25kQICYaVl6bVkQDQr8Tm6IE+YKcQIbiST
         KOJoixTwN9ykt+RCk3Md5tHCgTdIC568HgkfHpDB4Xn8HwUxcd2hoVJgbGHyWXUlxdkD
         59j6bRVN5HHHYA94CigNvelAoUUw1IkM0AGOIejgqbeauduJuOdZ5BOyc44AyL9OQvDT
         JStZOE83iIXm3H+QkV4q128JP1AJjPbeCDndRuu12wRBATzH6z4Z7wSFVhi3iySU5l7m
         PecoKqN3zKPQkwGVFvRnuy2JnnmHrDOFgYInLfWmKvpF0QcABSC9YiURY8T7ljEvYT1H
         Wi6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794262812; x=1794867612;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KfoXHxmDBEItkaa6hcxF0A8t0fZTG3DLVeoM83AlVUQ=;
        b=KO6+IbQdBwHXiBnEueRK3UynoY7HKlDdxUl+cMr7XQQVR+GYMbrHZH7SzM00ANqCfs
         dsb/MsuoPbQJzMDlhzR0mnoF1hQqeJZ9lBGmDXmN34Z+0c1rYI/GXvymHyNIrLC3QrUh
         0m8fgtanH89BeOiUoVD1+IrxZzfk61OtEhwxymlW5U63KNnVwmjifI+SEvtT9Jnh6/Y8
         vGWMpjQMe02fZxz1uCvmGgzNtZwuUAW5ICcXYraIm8OgytoYBSQgOUOz7MFdbbegU5Go
         pT7B/0bA/FmMOV2JAxZD3RgrcFKRgzWma9DjPdL4JXQ6Em9bFjBk/8FXzFeJSfBoVNuI
         c+CQ==
X-Forwarded-Encrypted: i=1; AL+hErFsAq5Mxoh0OMtjKpsNNA6R3OKjreo1OXZ0QEjoZKHujP7F6OqYEKPh5IsEl+sNLkAIf4wekw==@lists.linux.dev
X-Gm-Message-State: APuU4Z/DMgnd9r8cOkP04zbkpsGKz58k1pXcWCCWIx9FSaagutwXW0se
	5TV1C2tEdnE5rfe4K0R1UMhjPL3V7o88rzedWpC59/SV2gGIsdLpELV2DhAMqyK2p150BflUBVl
	axzCCgto6n8KvS+omlR5Y/8/dWcODC/v9Wg+eM9Wf
X-Gm-Gg: AYBFou0tDcZNweVs0XtmsngcRW8hkToGeHrKnJARt7l7VDjj9RETw+4NMkoCJUquinQ
	vE9CGdGaEPMQj5aYBa717F7aW4XNg0PgMK8RHdESIPXOrlLDGSNEekdOoJNPDdCZ4S8mEHESIiX
	K/0+cl62aYe7viMN9j8ddDHxRcTQ5jzGXgWXAW8huPorYLcNdk7GHIE+16lNgG+R20A7O7gCGBK
	8+l2n2jRhn4rAfZIGYZsXehWKhg7s0C0fYPtP8WMBSU+/vlFaZxy67iLPhaAcZRkZrz/ayCMuA7
	j803ttan6jMqr4Kj4vUNT9vPAm8hPTLFfHtSxeuIQ4vYiE6sVACPbxfwU+xSGtbAH/Sz2c7hDYc
	jyWnLC0RMgerRflc2rxUvQOiIEuu1v9yAEC/g0JBaLC9AS9Fzb2TuiE4vX5zZKlgWPjvSkORRNt
	DKwJN40P1sZyvg8j3q0YPXBoA=
X-Received: by 2002:a05:6214:519a:b0:91e:a3a7:eabe with SMTP id
 6a1803df08f44-91eef7ed59dmr16998506d6.31.1794262811011; Mon, 09 Nov 2026
 14:20:11 -0800 (PST)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 9 Nov 2026 14:20:09 -0800
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <yq5apkwettbg.fsf@kernel.org>
References: <20261104150322.3516320-1-aneesh.kumar@kernel.org>
 <20261104150322.3516320-7-aneesh.kumar@kernel.org> <20261104183754.10457-1-griffoul@gmail.com>
 <yq5apkwettbg.fsf@kernel.org>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Date: Mon, 9 Nov 2026 14:20:09 -0800
X-Gm-Features: AclHuK9yaZZX5RqlQUphUJAHyVgMZuWE0tyCGC8w_purOOnnuK3ITj8aYHc0AWs
Message-ID: <CAEvNRgFE5=u8Q+fCUxLT7M_gAjkgNddSVrM3axuTUxBScffcbQ@mail.gmail.com>
Subject: Re: [RFC PATCH v4 06/25] KVM: guest_memfd: Support device-backed PFN providers
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Fred Griffoul <griffoul@gmail.com>, 
	linux-coco@lists.linux.dev
Cc: Alex Williamson <alex@shazbot.org>, David Woodhouse <dwmw2@infradead.org>, 
	David Hildenbrand <david@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, 
	"Joerg Roedel (AMD)" <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Robin Murphy <robin.murphy@arm.com>, 
	Sean Christopherson <seanjc@google.com>, Alexey Kardashevskiy <aik@amd.com>, Xu Yilun <yilun.xu@linux.intel.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Steven Price <steven.price@arm.com>, iommu@lists.linux.dev, kvm@vger.kernel.org, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Aneesh Kumar K.V <aneesh.kumar@kernel.org> writes:

> Fred Griffoul <griffoul@gmail.com> writes:
>
>> "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> writes:
>>
>>> Device resources such as PCI BARs supply PFNs directly and cannot use
>>> the folio allocation path. Store the mapping owner and device ID in the
>>> core context during attach(), and use them when preparing device
>>> memslots. Keep device memory separate from ordinary PFN-backed RAM.
>>
>> The device rules you wrote down in api.rst and locking.rst helped a
>> lot. If I read v4 right, the device backing differs from the RAM PFN
>> backing in these places:
>>
>>   1. PFN mode calls RAM arch hooks: kvm_arch_gmem_make_shared() at
>>      conversion, kvm_arch_gmem_make_private() at fault, and
>>      kvm_arch_gmem_reclaim() on revoke and release. The device path
>>      has to skip them.
>>
>
> I would say that the VFIO provider expects the conversion to complete at
> conversion time, rather than being triggered by a fault.

guest_memfd currently does .gmem_make_shared() eagerly and
.gmem_make_private() lazily (at fault time).

Technically conversion time spans everything from guest exit to request
a conversion, including the guest_memfd conversion ioctl, then till the
vCPU run completion hook.

Can we move the mapping out of the conversion ioctl and into some
dedicated CCA-specific mapping ioctl, kind of like KVM_ARM_RMI_POPULATE
but doesn't actually perform writes, just does mapping?

The mapping ioctl should check the necessary prereqs, same for the
vcpu_run completion hook.

Here are some advantages I can think of:

1. Decouples mapping of VFIO addresses from guest_memfd and provide more
   understandable errors for userspace, since the mapping step has a
   clear and separate error (conversion is complicated enough with many
   failure points)

2. Better aligned conversions in general where marking private at the
   platform level is lazily performed. In this case, doing it outside of
   the conversions ioctl is not much lazier, but slightly :)

   Not quite mapping, but Suzuki did bring up that for regular memory
   (not VFIO), ARM CCA requires vCPU context for SMC_RMI_RTT_SET_RIPAS
   in .gmem_make_private(), hence that's done in the vcpu_run completion
   hook, so that's kind of lazier, relative to doing
   SMC_RMI_RTT_SET_RIPAS in the conversion ioctl.


> This is also
> required because, when an MMIO validation request completes, the guest
> expects the range to be mapped. The current flow is that the MMIO
> validation request exits to the VMM, which uses set_memory_attributes()
> to convert the range to private.
>
>>   2. lookup_pfn_range() only feeds those hooks, so the device path
>>      does not need it.
>>   3. The host mmap and stage-2 need a device memory type.
>>
>
>
> Do you mean this code? vm_page_prot is used for the host mapping created
> by mmap() on the guest_memfd, and its setup follows
> vfio_pci_core_mmap(). I think the only device-specific difference here
> should be pgprot_noncached(). Shouldn't the rest of the protection
> remain unchanged even for device PFNs?
>
>
> +	if (gmem_provider_is_device(gi)) {
> +		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> +		vma->vm_page_prot = pgprot_decrypted(vma->vm_page_prot);
> +		vm_flags_set(vma, VM_IO | VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP);
> +		vma->vm_ops = &kvm_gmem_device_vm_ops;
> +		return 0;
> +	}
> +
>

What do you think of just forwarding .mmap to VFIO to figure out? This
makes VFIO less special of a provider, since I imagine different
providers may want to have different page protections or VMA flags.

guest_memfd just enforces VM_PFNMAP for PFN-mode providers.

Here's my forwarding setup: [1]. In my proposed control/data-plane
split, the vfio_fd undergoes VFIO_DEVICE_BIND_IOMMUFD with
VFIO_DEVICE_BIND_FLAG_CTRL_ONLY to become eligible for attaching to
guest_memfd. Data plane for vfio-pci == BAR supports mmap, so in this
setup, the vfio_fd's .mmap() would always fail, and the gmem fd's
.mmap() would just let VFIO set up whatever it needs.

[1] https://lore.kernel.org/all/20261106-gmem-alternative-providers-v3-61-8484dde66a7e@google.com/

Wrt the page protections, in my setup gmem reports the cacheability so
the KVM MMU can use that information to set up the stage 2 mappings.

The provider can now set up different cacheabilities for userspace page
tables vs stage 2 page tables if it wants to.

(At least that's what I intended, given my limited knowledge of ARM)

>
> [...snip...]
>

Let me catch up on the rest later :)
