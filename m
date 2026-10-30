Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793400299;
	b=nfx+Pf/8uV4M1Fh85IxJ3A5jJ2COuw/Yo7mOHxQiDp7d5nHLJjvgEOydZkCrvwzEkxk5
	 P4QoBltw655gGI6PPRDFIZ1/qrFrT9fLw+FOt0XzAEpZTWWMMTm2RgBCoW6wruN27axOX
	 dL4+CUqqUJpJP4GWQs005aWQMqpON4j4sraNxH6a6CLn2YNCNkOMBKWiV22UeirNABdiO
	 opXPNR2WJCFBGVVEhIh79R1wktW1mO2vJ/I/RDbF0onrFYhq6m33W3oDvkMBG+30FqP+V
	 Af/Xt8DX0m/C4awgNOTpmh3KZkJlSVcYYx/w/iAt/ZoNxcWEPMFeijkYQGHcIWgkgOA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793400299;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=NYbItPhQApEJbZKga/APWqgHEBqrEwP9FLrG/rlKxD8=;
	b=iMnoV1qwl2vFe8InL+py3s1GzUDUoTQE775sySzjr3+/WfQFC6PuW6WP4oTRYQpDce6d
	 gxoxYYaTzHqAEXjE4aigjT7UsxdrvJGox3Jt1h5AlnZJMoJZNbys+JI3hCTEmZUvroNlf
	 juCCV1XitouWqHCZOL/AWydGtf8u9WQ+yw4ffqyeBs4ro6Qd/YFVZUQGFsBWayMCYIGtf
	 myrtWOvO96vpGQdk1h0WDdl25RHTX88n4VofPdG3q0qoAaKhO0c8L78AMEqC1hCmNlSA7
	 jf5ggkT50Xyb0asz5hn0lfaydVmhA772VIG4nSdBi1nnvm6Ra8Gvii47Gfsff1b+hAg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AQlexJGn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.176
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE4A606A31C
	for <iommu@lists.linux.dev>; Fri, 30 Oct 2026 22:44:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CEE4A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AQlexJGn
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-93f1e5d7450so108972385a.2
        for <iommu@lists.linux.dev>; Fri, 30 Oct 2026 15:44:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793400298; cv=none;
        d=google.com; s=arc-20260327;
        b=rrdMqMvaahqz6rEVD13MHFpfsrTNMeVaXlXoXdoG5xfS+FzARhTSLn6H9blmQe8K3C
         ZCA0VpTV9ByT4V5/K7cXhQxlN/de4UOLa6H0752hABmbiLamTrzRZkXKkDzqszbzW5P1
         dEoHd84Rhu3iE38bzrSXaQP7RJFUAPaeLyE55ss4UFueStdxIf/NwYM/TM+olGUAeM6k
         z/o8zT/771UN+r2k7EWwy3nIX3DTUhvZHHY1ahqxRnQ2BrqwgR4gEj/hYyiz01iRId2I
         Rpmt4zYE8MbNA4z9DVVKUQsDej3XniWCllycmhlqPaAK8v+ql4os7k070Lk5rBkYcR2R
         ePtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=NYbItPhQApEJbZKga/APWqgHEBqrEwP9FLrG/rlKxD8=;
        fh=iVIWqr/K4aaBH1I78ZU0pLEbZHdrKIJsPfH3TZKn5JA=;
        b=Yi/+Dpt8I1so+3Bxxrw0HnpCHQRxi3jLZVztG2GvsLMkNXgr5Ju6/ehtUdwaf2de4Z
         UXLXZgUDX+qj2T3NRv7Ip1UAgBagdknNjc+DLteF0RHqbvgjxix/xk5d5XZ1/vA4wE+f
         tkNZfdY75uNs4DREb2EcU+0H7qVQMcjNdqyuZEYZMNNDzgcRD7eJkI373+3S6L1ikcuv
         E66gc3ypNePG+UDU5PFI6aC4NVtjt7gIMSBUIpPrSxxZO8RhbXTxRqKBGcv0x/pa4ECv
         BZMWp5a+AcAhfUVLaaLzuxAs3LKBu/IHsQi61Hau20AWO4d3RQJ6zB1UfAm+kT+SVCbl
         e6iw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793400298; x=1794005098; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NYbItPhQApEJbZKga/APWqgHEBqrEwP9FLrG/rlKxD8=;
        b=AQlexJGnqwgyK/J4WlzIYgsBi6ad2vrDlfymYN+RjMFh+nTd+esYMCCyX2jg16e0sD
         JDRfhf3391NK7UA/tTzJeBNOOz4QzeH9eYj5jK4ZVEWqooiZUUm3vdGYfT4KX+sR5cV2
         CUseiC5PmwDrKnURHzkqVaUxgQNIj+eMY6lWV5kEcgeGM4eFU2v68RiodxidZxf4u1m0
         rywaBQdgrwOfeL1IMjiIEWdkgteyAFFToGwcqz+ZXydYkEkPyMtWMU3LZeSDwJMYvQBw
         ytoBWbVlMN/hWeyMeK6kqGVSipM0Ar+c5MsFst5GuQINqeCh02iVqUcj2YlKs9LP+9oQ
         Tqtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793400298; x=1794005098;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NYbItPhQApEJbZKga/APWqgHEBqrEwP9FLrG/rlKxD8=;
        b=nA29O5zV7EWWnYr0dyuRUVMfHZ/IFCOtThk9cDYbLYj7rGXbV/k0TehPJgRpHV9izL
         MGhZa/flNqqyk4c5UptHOZ0ZCbu+yAQZLIAP3dGUjSfdaUXYJvuldj6hq/dwkQXHX/Fq
         YpgPADVC07Z8Mic/Y/LgFfLdVmYgM6/hQSgwjGHbH0H8l3Fy/gIsTKcMtarONh4k+c0U
         4RMef/rO4f1v2c8zcaoMWOeh6xYGQNt4wdk0X5JisVOYF/8U0F3vJUv4fntNNNjFfOwu
         Ry9odRl+hJdlQGgHMEZC/EMnYwdTaxYuLU5qNUE2TfTgWQ1hUpWMx5WUNFPUoCZVZ0S2
         lfhA==
X-Forwarded-Encrypted: i=1; AKwUvBw5pL9o1agPZP2RJpPGhxiZ12CAtf2g/zFkjaMGF5oTnmmSVpYKI3pFFt9qnQgY6cg4q/QnkQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYJJTiq3V6OX/Cy161MIu1v3rAfwDB4Ttueap104F8vPTbpb/0tH
	AAI74yPPEtq45ECYGyd3Ybji+qcv96ntYl8nZTWkGplqBiMrYhG3+Ej9KMAFPMa3L6Jl+QcUS/c
	lD2fx7+A1BdcM3lDlPN8vFGbdF0EluxtMNOeblKVf
X-Gm-Gg: AYBFou2NAfK10997ro2u25hSz21fchr4h7DAD2lT7LYRqer7SbXeB9d/tzdgpHf2aNZ
	L9tK4T7aRlgm0Vxo0o5lZDjinydypA7vZfHtdWGiQEDWlpRmFpNDWfybT+YYNV0TbXoX5BbbAl4
	Zmoxk89A2HAPMpElQP7HvkJaCkGfO9Lg4Hw+cXH01HcBmfJxGDiODfLDB5y3TgapPCSzC6KFfZ9
	cidP9IO+1BpgvDfSg2e6WO4IQWql57vmZner+3sYNaqOs+Vjj42/TGT8D+Utnr36HwXWOli+1Ak
	j8gkDQRoUR0Vfo0bPvHnZEh85glRlW9XiTNnQPpR/1GRuCbfBBIEPf+7OzZgKAqHLPj+H8VZF/Q
	5spjKFJo94+9ngcWe8roZi+FMunn083okONGD3bFeZsbkxsrzwcuo7GsrICZ++0EEuNWQQX5kTl
	y4GyegoKmIjFrM1jtrmMA7rvk=
X-Received: by 2002:a05:620a:4594:b0:93e:c12c:4409 with SMTP id
 af79cd13be357-944217cece5mr652996085a.69.1793400297298; Fri, 30 Oct 2026
 15:44:57 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 30 Oct 2026 15:44:56 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <CAEvNRgFEKqVZcNYCL0LpB6BTyBFe+ot1x1nFfEqOrSTsu134PQ@mail.gmail.com>
References: <20261017073149.1303738-1-aneesh.kumar@kernel.org>
 <20261017073149.1303738-3-aneesh.kumar@kernel.org> <CAEvNRgEh3E7NBc5_3Wq66Fss-mAYT6+4FWP5+=Co6+OVfVnQQQ@mail.gmail.com>
 <CAEvNRgFEKqVZcNYCL0LpB6BTyBFe+ot1x1nFfEqOrSTsu134PQ@mail.gmail.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Date: Fri, 30 Oct 2026 15:44:56 -0700
X-Gm-Features: AclHuK9AHtuqcVSSdHgG8WAhHla8voZ5Eh8lYfAwHP3Alygt10O_4piQhjU1tlA
Message-ID: <CAEvNRgH5TH8MDaRQaVczv4m6fJZKVmf=MtKzhmHs_px8+r=8bA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 02/13] KVM: guest_memfd: Support private/shared
 conversion of device memory
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

Ackerley Tng <ackerleytng@google.com> writes:

>
> [...snip...]
>
>>
>> Is there a way to avoid making private from within the conversion flow?
>>
>> kvm_gmem_device_map() below already does it as part of vcpu_run.
>>
>> If we do the above, we'd be aligned with regular conversions, where
>> to-shared conversions eagerly update arch state (make_shared) but
>> to-private notifications to the firmware are done lazily.
>>
>
> I was a bit confused above. IIUC to handle
> RMI_EXIT_VDEV_VALIDATE_MAPPING, the conversion is not done from outside
> the kernel, instead it is done in the vcpu_run completion hook.
>
> Can we make the flow that userspace is required to do the conversion
> request from userspace after an exit due to
> RMI_EXIT_VDEV_VALIDATE_MAPPING, and then just do the delegate + map +
> validate in the vcpu_run completion hook?
>
>
> The rest are a little outside the guest_memfd field, but I'll make the
> suggestion anyway.
>
> It looks like delegate and map don't need the vcpu context, only
> validate does, so validate has to be done in the vcpu_run completion
> hook.
>
> Delegate needs the host physical addresses, so we'd need to translate
> the IPAs to PAs, could that be a VM ioctl? It could look up the memslots
> and translate IPA to PA?
>
> RMI_RTT_DEV_MAP also doesn't need the vcpu context, IIUC it does need
> the VM context so it could be a VM ioctl too? If it looks up the
> memslot, it'll also find the guest_memfd, where it can find the device
> information.
>
> I'm just thinking that the vcpu_run completion context is doing too
> much, and there are so many possible errors that could be better
> communicated to userspace if they're separate ioctls.
>
> Or perhaps at least delegate + map could be one required ioctl call by
> userspace before doing vcpu_run to continue after a
> RMI_EXIT_VDEV_VALIDATE_MAPPING exit.
>

The delegate+map actually seems really similar to the
KVM_ARM_RMI_POPULATE ioctl. KVM_ARM_RMI_POPULATE already calls into gmem
using kvm_gmem_populate(), which can do delegate+map, can that be
reused/extended as part of RMI_EXIT_VDEV_VALIDATE_MAPPING handling?

>>>
>>> [...snip...]
>>>
