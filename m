Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FE03C13F1
	for <iommu@lists.linux.dev>; Mon, 27 Jul 2026 18:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785178439; cv=pass; b=hCcaNqM7rkCuDsh2wwwJMUGx/53RxrLpE/7rZUhJEfeBiHSUVftPLjQ3qB8cseYj8W4Rrwj8fGHomknH6TT4EdZmmTDdnwDP7A/MlccItjuahzFBF74fqn+/+2oXhxw7Dzz5+IqYD34szrlYs4OYiUoVcrR56Vzm1dCFNbv8CRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785178439; c=relaxed/simple;
	bh=jBGj3vq73TpQNUHtZ8hP8T9s3Rn/i9PzV5LYqBYc5Jk=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N/OmDLyreEyUpjvxQ883sqoZbQl3mHm4kxZa6dbLG3tLOT7Lppuc7eHyJ5f1t2CuYf7g7adnwiBmlgH+kof2nSd9JdkXKLn7a19qXGmkrkJxEfdj3yDk/hW3v4piMxqRmnmygTVTwIg/PD3Tt6+C3kQZXvmMrxU4/EbAWx+I8wA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t5X4yEWp; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t5X4yEWp"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2caea3f742bso37415865ad.0
        for <iommu@lists.linux.dev>; Mon, 27 Jul 2026 11:53:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785178437; cv=none;
        d=google.com; s=arc-20260327;
        b=RodbdaCh4uOPj+uTCXIIvkPlvC6bkHoJY8VGhQw5gcTN5/0IVSULL4/pL3cO9ZA+aO
         o7rox9Qk/mjRIUBh9gDaWfnZwNoZDWpwagEffsxEidlFPYE1q+EUReVxeB/VtBSfRZRU
         6TsDuxEa54cqvNaPvedExMtHa/uX+6HwhHxnziDixrY/djv8nCikgTETyFKAimxF1HBy
         5s9D5nDvJEBrHLIUTMkRX6Wc7sIsEHLQrwsCPntkoDXpHAIX6OqC+v5KHdx2MFy+JX6E
         T26MIFaD0Z2KIl1Vf6tG05UOCDBcEeWnTvvnNqtNIlGR4s58Fs6ujQt5CcjaBO1RewBT
         EiwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=Ezc2drTNkvx/EGjvXJcxB1ItRYJScaQpIm5JRHoUsx4=;
        fh=ZYFSKfWqEx3xdC08v8xl7ZnXacvlCZFiNWfenbMjC9Q=;
        b=emB5QVXycIm6EAXwoQFfP2Ugaahg5Gqw3GmsX8PkDNo8/n09bXSQerWcxbErkYQt7r
         1SQXGoZhBxwOF42ZEvcbOtmU09yhpdKmLuy6ev8PLnctQsEwqD56U1wQEKsIK29/xlD5
         y3X/Bo7vCFzNmG+mccfD/oYR+JwPXwPALxiyuaYlDpo7Miaec5K7sI0AtQC2Dwx/fY5m
         Imm4xtCKkjwO2oV0scA6arscz4foFy4pBqmKdlS5R8dAfl00WpwQqdRVN7fLAf8RSOZG
         h/HOC4nUCJiCLkw+sz3zG7OL7pSFyW2INORNSk7rdjG4ZO2VBX69f2P/19a7GAEo8SV/
         PIUA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785178437; x=1785783237; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ezc2drTNkvx/EGjvXJcxB1ItRYJScaQpIm5JRHoUsx4=;
        b=t5X4yEWp7mr+pHxTincS18rD6fCwNmEtaXdrtF+l34vqPJlu7AYiYg3+DjAgx8FJcP
         BcJHehIrNaQq8XahL3MVesOJS3kJ2feiEHPZ1I8GSSaMBqouNUa0z8La1hvVG+u22KxE
         XxmILmTEV28Pd6wDNA2jzsMd/7ND7gjPd6MmFB8cn3+QC9qZS3Vg4aYZGIDhi7DzumS6
         SGqd6QvaYyYfkhtsOAx+AH9FEFR6K4nLX5V+/m0LOQ5gm/6GqiRKoi2pkwPXVv6heqJ1
         sSr4J+xxQAUTK621j78vZK+bMHvgMWDPijA+derSvfbK8HZsHnDivNW902jzzlRBmvAq
         WkpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785178437; x=1785783237;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ezc2drTNkvx/EGjvXJcxB1ItRYJScaQpIm5JRHoUsx4=;
        b=QaVLqrSqsBjpTjKspiYEAdgiyqDdL1+3S/XQoL7SlTxJXr1F0gAG+kWxEq4agJqp34
         pUgrcq0LlNJ6DPOfxj5C4Y9DV0P/w9fFeiIiy71wOarLevW8DRkzeU7p2AoKt6wmqJvs
         vaEWW4LDpS3azzMuF3GlPItS9GkuXPGBbRsKqckMdyyi60cmUNjLYP6fz6slCgSrWOnC
         GoBaFhBfe+0FQe221WY7ldz0TWSCynwQAlLncjkv+Gf2l3X8oeJoHnhNgZKEkmuZk1Ig
         jM84tfXAL8MdC1Hh1eFpwN1vYXesTmOPamYnTSGgjTxwUFvdr6o1/M9YELDakho5M1z1
         KWKw==
X-Forwarded-Encrypted: i=1; AHgh+RoEuePiwNa/4WzzsDqfdLlI8MxjtpGd9TImjOjhFsxabiu4BlrNzqxYg06+sKL4C2ORCVhmuQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz1n+GxFQ3fo1ORdeGDquUiML7cikWp1/eVJwp34Gm2jgpForyB
	ugD+i5MpGjRJPB/5ZD7kP29iMgAwCNmqfmZkBim1Y5hSu8ULfjeaYiwLuAY3G1i8AyqYr/LknwY
	cOZcdAsEENfeHescpEAeQgL7agyd17zJQGjnm4JBt
X-Gm-Gg: AR+sD13nKCZSpuZfG6o3wrTC3JyYNBVXtv3/a8+TqHM5ZXOZGpqss8/qYZ3dVbg3b28
	+qwr5A6r9Ra+wQ5rO0BcnBMEchnH0x439hof4t2GQ2B8o4BrzIgm5J8Uz8T2fr2j4VVOt36IG6q
	nIuek5F9tn9qHobdC49dbwJmz/mrdOTDLRJikKfVAMHBWdYzoDTpfk4NCme8sD+0GViSS2tvKSh
	5quyL6awGbLjg9yhgD4AmOY+Y3yHgqzjklCzWlt1BCT33XfkeR4jFBaulLHfIJSag7zMs1Igx7X
	DqX0vedK6oi1CWCFwK1fPfahgkZnOoBZX07G49hSDsPrn3OI
X-Received: by 2002:a05:6a20:6a05:b0:3c3:7a0a:18a7 with SMTP id
 adf61e73a8af0-3c6c7fb20d4mr796670637.55.1785178436210; Mon, 27 Jul 2026
 11:53:56 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 27 Jul 2026 11:53:55 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 27 Jul 2026 11:53:55 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <amcdueQI1voXWPQb@yilunxu-OptiPlex-7050>
References: <20250529053513.1592088-1-yilun.xu@linux.intel.com>
 <20250529053513.1592088-11-yilun.xu@linux.intel.com> <20250602133009.GC233377@nvidia.com>
 <CAEvNRgFpJWQ5M5sQhGpQUV3GbBq9N+MQhhaxdxa=D8ky94SCsw@mail.gmail.com>
 <20260712221934.GF674038@nvidia.com> <CAEvNRgEo2kLUmaGU-Vsgx2sTQvU_NNUJ4bRp5Z4Ygs_xvVLOYA@mail.gmail.com>
 <amcdueQI1voXWPQb@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Mon, 27 Jul 2026 11:53:55 -0700
X-Gm-Features: AUfX_mylYj_x8eQp0BvgfyW8gHfhB_jFskLbUbWzV0Fgf00qZT4Qn9h3hPlqeKo
Message-ID: <CAEvNRgGYc0B1YyhDhS0Khfm3N85hbkYGMTfDLiXYn+WHTLF2EQ@mail.gmail.com>
Subject: Re: [RFC PATCH 10/30] vfio/pci: Export vfio dma-buf specific info for importers
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, kvm@vger.kernel.org, sumit.semwal@linaro.org, 
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

Xu Yilun <yilun.xu@linux.intel.com> writes:

>> > If VFIO can create one
>
> It is an interesting idea to let VFIO create a guest_memfd instance, if
> DMABUF doesn't work. But to achieve this goal, I think we still need to
> refactor guest_memfd to allow for different memory/MMIO resource
> exporters/creators, and different resource importers/users like KVM MMU
> & IOMMUFD.
>

Yup I think both ways we'd need some level of integration from both
sides :)

>>
>> At guest_memfd creation time, guest_memfd is always created for a
>> KVM. This is the first place where it is bound to a kvm instance. This
>> is one place where it helps Yilun with Confidential VMs, so KVM can be
>> sure that the memory was meant for a specific CoCo kvm and not any VM.
>>
>> I think it might be weird to have VFIO take a kvm fd to create a
>> guest_memfd?
>
> I think having VFIO create a guest_memfd is better than having KVM
> create a guest_memfd on behalf of VFIO.
>
> The lifecycle of the MMIO resources should be managed by VFIO, cause
> the availability of these MMIO resouces are impacted by device
> operations, e.g., device reset, PCI Memory Space Enable (MSE) ...
> You can't export MMIO resources to KVM MMU without VFIO's awareness.
>

Thanks for explaining the above!

Do you mean that as long as VFIO knows that some addresses are not
usable, those addressses have to be removed from the stage 2 page tables
that KVM manages?

> And VFIO doesn't have to take a kvm fd paramter to create a guest_memfd,
> VFIO has got the kvm instance via KVM_DEV_VFIO_FILE_ADD.
>

I'm new to this - looks to me KVM_DEV_VFIO_FILE_ADD is for linking VFIO
to KVM but some mmap-ing is also required (pre-CoCo) to set up memslots?

With CoCo, setting up memslots would use some fd (guest_memfd wrapping
VFIO or the VFIO-created guest_memfd like you were suggesting) and I'd
think there will still be some notifiers between KVM and VFIO for the
mapping.

Btw is it right to say that KVM_DEV_VFIO_FILE_ADD is only in the case of
setting up irqchip? Is irqchip a requirement for Confidential IO?


Hope you also had a chance to look at [1] that David Woodhouse is
working on :)

[1] https://lore.kernel.org/all/1dc299af6b795a40c8887b3d84f915024f6446a9.camel@infradead.org/

>>
>> I was thinking that the userspace VMM could do something like:
>>
>>   int vfio_fd = open("/dev/vfio/devices/vfio0");
>>   int gmem_fd = ioctl(KVM_CREATE_GUEST_MEMFD, { .fd = vfio_fd });
