Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81319125A0
	for <iommu@lists.linux.dev>; Fri, 27 Mar 2026 09:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774603941; cv=pass; b=MPEYXx1LI6Tv4b2J++lbuZyQARdOByUDM7wQK84UmKSIw40n/WBdEfh0+b1VXADxYjJK+OMrOxoAAYxYE2yFuThQxkDMki+A0K0/ZKEJLkIGt3Ax7kbTkPzSSAScbXKOT/NBs6nMAtw8mmlUR4FcosKmnt0BSPw1sdl8qVtTSMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774603941; c=relaxed/simple;
	bh=06LMva7nNAzRB3uoqIeOQbagXCiMFxIYnmMe8xGCgvg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y1Y+wrhpfP/+3EmwbJGG1eBRvO0fGDE5yPyvHp3duButgsSD2L9FRUPj8/np9swOoyr/1QqjDczIqyCP1ei35pFCxt3yCaF+OVzhqEHt517UET33y3xzPtWKKKGUH4GZQismk+S1MAiCni1Fgfgw2Rr60KsabwCgNB62OLrAwzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a0lAe6DR; arc=pass smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a0lAe6DR"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-126ea4b77adso2636499c88.1
        for <iommu@lists.linux.dev>; Fri, 27 Mar 2026 02:32:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774603939; cv=none;
        d=google.com; s=arc-20240605;
        b=GXtVgZO1/eBjI4RTNjV78L2odWpUKx34hlQo5sNRSrusOI3HeqoVt9YUYMNxWKwk/s
         XhjqFRXQGu2t3lEmWL5ruXdiC/Eh6TgyKyPJ4j5oFrJ042vNzaBsbsCQbPL1Ob1nmZlj
         3eiCf2BpVdZmM+ktmD6+oxQuQe+RAeaezAzpkU1jdAHvjGy2xfJYEo0vqTnzYEsZKoga
         2vi8akhVm0+XAky+0erMiwqbQxiF1g7VWC6a/niFN2GVUEGq/TGyS9+45JU54VSY+4Nh
         RNAPkzyvniv0VzCrpHKt3dOVrN9dtlntGz+sLcZT51EJe0ibL078B52TY7Xa7ER0vnsp
         jjzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yTj0lmErHFiNvY1kZ2HPnPSiJy+pFJAQ9CrdVdJE+0w=;
        fh=1TSrcUgsvn9IeLzUWngBThVC+Xd2Zzw6kc9gR3Xxc9s=;
        b=lpsdqjM4edML1rb7yJncGGyv5MYEy4zGMYz+/ioLoUSKvrbxGEC6ptz1sgvn9o6YNj
         1VcNcqNYHEWtBAbkuzbpqz2r5dslHc+ZQ2ECFNB9bXzLZaloirVSbao6D2gefRuXIyWg
         PJcT0bh3sQLd99QhAj9ISD+ndlXjMBFpl5RCTR0G5va7Mb5zmOzw/RDRuuoYudzhdj81
         5xkHPujWnKHQhJKlf58FmEkXogl2BzZylH4B1BBp8S0veVS3BvU6pQcE0w3Ysb3EkUlh
         PACUCBeW2Fgq4a/jZ5hWm5r85e7BVq0wJaZ8L/qMH4Te5rjPQPOtuM13TOUcH7RBnVkr
         AaOA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774603939; x=1775208739; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yTj0lmErHFiNvY1kZ2HPnPSiJy+pFJAQ9CrdVdJE+0w=;
        b=a0lAe6DRkvfIs6yxtXpfnDIHXkYYqQD2PeVBWrtx1tZp/11xN7xt34RNpRftUkiUI4
         nBHlPZ/IHJlXVQsJUyAAn+wjuk5K3kEkBv+5D46M9UuhhlBSUkFDI4K9TwlMQa5cRH7r
         i8g2ukY26wCqxBdjoVAQIl2HJtq/tXcW8l8cdw810+1eSKfXeheax+TxNozLOrctTnsk
         8tb52OFnhF7h9Sz/Fal5JQ/hnG3qalLEeMlvjDP10LZCoQQZbErAM2SoHOfnbk5GoRxu
         YI1P/wBYZ694yLhebtglSv8rdFsHfa7oLNU1XnKfn7+u1R6Th/qrIr1iBov5GuIswsBb
         lzsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774603939; x=1775208739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yTj0lmErHFiNvY1kZ2HPnPSiJy+pFJAQ9CrdVdJE+0w=;
        b=D7oyEDUgYfBIxUDDEm7HpJVbfXMzx84S8tRqlXeWz7P4+zSXnZOsQrRi2bj5Y/2N+3
         radVcmd83pfM6ecG8xSV9HLuWTvMPB8NqvhEr+dsFejRw7Xpw214kryXnTWoXxohy1Ek
         /HTQ+ioGpX5TCx0erbcntn9n7LLju2y8lNx5wBgQPDki6d6a5cMHvGqCWMLe+VXdn1Qy
         5gDQSrUArw+fA3gPEeL0/b20xwI8DaNBsKrhU3HQ/XZdQf5L5MTlyLcPH4CntwoFfAaC
         eIbGLVDfPSCd/F/Wslc2uYDqOHgvOVC3y6EZIIs+CV/RK4enCHTVn0ZcY7nomiTXkch7
         /EYw==
X-Forwarded-Encrypted: i=1; AJvYcCUJx4w/5iSTitvtFcRGUFYAUhzsVLheuCcJ5ZMa21TikpHtAyC3BAQ/8KugUS1XLNV20JWckw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz694HpLq/q5MfzrCo9DWXiepoLV7tm+7dez8KryQkG98QnLNBX
	nZqNLdhDO3bvFep7C+BxCGs3HGNx5OIuWdKJJbZ7yAxEhPMQ6aiNqqOiuVXwUQrTM0x3gSehwYB
	23jWci0e31mUWI5VBM8oHhW0iSn6R6dg=
X-Gm-Gg: ATEYQzx4NPCRW33qi+MYxZNHV0GhAQ0lJ5BaSdJ/N2bJbMVMHqfRWmMNzJxmv9Jhhl6
	A6f5cK1DMNsGwBJ6OFelX5LPoNDswLoZ8L8pqF36DgE7w1OAkNiCplIVGulGy+NNyNt4NQMQH8H
	UUMfDPW06+zSWWdHz+5GcdIvK+anJ8k6x8IVxShwpDwVEYMyW/FD0HwdEikW3HbXHkDH3bGGHF+
	H9I75i6+h4pguSKdo2b3ed/eGkohpX18+a7m/WhUb+H9o7rN1VJoBgz2ofedE0p8+gD7dqe4vSe
	nVYGYuc=
X-Received: by 2002:a05:693c:2b13:b0:2c0:ca48:3112 with SMTP id
 5a478bee46e88-2c185d2392dmr925089eec.10.1774603938602; Fri, 27 Mar 2026
 02:32:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260325075649.248241-1-tiala@microsoft.com> <75c6dd78-bbae-4f5a-94ef-9de299720d38@linux.microsoft.com>
In-Reply-To: <75c6dd78-bbae-4f5a-94ef-9de299720d38@linux.microsoft.com>
From: Tianyu Lan <ltykernel@gmail.com>
Date: Fri, 27 Mar 2026 17:32:00 +0800
X-Gm-Features: AQROBzBhr93zaAmvsFTclkLSepBZXUTqoKBV-eRXJ6Wqy7QysN56WXF-MYhEV2Q
Message-ID: <CAMvTesD2ix==vObgAC=LLxM2Jn4MnuvnjfL72Z=zfs--gq4M+Q@mail.gmail.com>
Subject: Re: [RFC PATCH V3] x86/VMBus: Confidential VMBus for dynamic DMA transfers
To: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org, 
	decui@microsoft.com, longli@microsoft.com, m.szyprowski@samsung.com, 
	robin.murphy@arm.com, Tianyu Lan <tiala@microsoft.com>, iommu@lists.linux.dev, 
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, hch@infradead.org, 
	vdso@hexbites.dev, Michael Kelley <mhklinux@outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 27, 2026 at 1:05=E2=80=AFAM Easwar Hariharan
<easwar.hariharan@linux.microsoft.com> wrote:
>
> On 3/25/2026 12:56 AM, Tianyu Lan wrote:
> > Hyper-V provides Confidential VMBus to communicate between
> > device model and device guest driver via encrypted/private
> > memory in Confidential VM. The device model is in OpenHCL
> > (https://openvmm.dev/guide/user_guide/openhcl.html) that
> > plays the paravisor role.
> >
> > For a VMBus device, there are two communication methods to
> > talk with Host/Hypervisor. 1) VMBUS Ring buffer 2) Dynamic
> > DMA transfer.
> >
> > The Confidential VMBus Ring buffer has been upstreamed by
> > Roman Kisel(commit 6802d8af47d1).
> >
> > The dynamic DMA transition of VMBus device normally goes
> > through DMA core and it uses SWIOTLB as bounce buffer in
> > a CoCo VM.
> >
> > The Confidential VMBus device can do DMA directly to
> > private/encrypted memory. Because the swiotlb is decrypted
> > memory, the DMA transfer must not be bounced through the
> > swiotlb, so as to preserve confidentiality. This is different
> > from the default for Linux CoCo VMs, so disable the VMBus
> > device's use of swiotlb.
> >
> > Expose swiotlb_dev_disable() from DMA Core to disable
> > bounce buffer for device.
> >
> > Suggested-by: Michael Kelley <mhklinux@outlook.com>
> > Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> > ---
> >  drivers/hv/vmbus_drv.c  | 6 +++++-
> >  include/linux/swiotlb.h | 5 +++++
> >  2 files changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> > index 3d1a58b667db..84e6971fc90f 100644
> > --- a/drivers/hv/vmbus_drv.c
> > +++ b/drivers/hv/vmbus_drv.c
> > @@ -2184,11 +2184,15 @@ int vmbus_device_register(struct hv_device *chi=
ld_device_obj)
> >       child_device_obj->device.dma_mask =3D &child_device_obj->dma_mask=
;
> >       dma_set_mask(&child_device_obj->device, DMA_BIT_MASK(64));
> >
> > +     device_initialize(&child_device_obj->device);
> > +     if (child_device_obj->channel->co_external_memory)
> > +             swiotlb_dev_disable(&child_device_obj->device);
> > +
> >       /*
> >        * Register with the LDM. This will kick off the driver/device
> >        * binding...which will eventually call vmbus_match() and vmbus_p=
robe()
> >        */
> > -     ret =3D device_register(&child_device_obj->device);
> > +     ret =3D device_add(&child_device_obj->device);
> >       if (ret) {
> >               pr_err("Unable to register child device\n");
> >               put_device(&child_device_obj->device);
> > diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> > index 3dae0f592063..7c572570d5d9 100644
> > --- a/include/linux/swiotlb.h
> > +++ b/include/linux/swiotlb.h
> > @@ -169,6 +169,11 @@ static inline struct io_tlb_pool *swiotlb_find_poo=
l(struct device *dev,
> >       return NULL;
> >  }
> >
> > +static inline bool swiotlb_dev_disable(struct device *dev)
> > +{
> > +     return dev->dma_io_tlb_mem =3D=3D NULL;
>
> Is there an extra =3D here?
>
> - Easwar (he/him)

Hi Easwar:
     Thanks for your review. Nice catch. Oops. Will try other way to disabl=
e
device bounce buffer in the next version.
--=20
Thanks
Tianyu Lan
