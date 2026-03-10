Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A9639937E
	for <iommu@lists.linux.dev>; Tue, 10 Mar 2026 15:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773157602; cv=none; b=TFe+lC4Q91yZfxt+SwhgZftGkPw3o6vfp9++IVzeh0h9TfchaWnxB2VrM8nfvOnDDLArQ4HUhd7eyAfxo/FzOV9GYZ0Fxi0YedyHfqeQpmWmO38VILHEKj+pyx6n+zUz0opA6ChNJi8hlRvuDrLyk3xAs/fxYK6xYaAVtsxZ1pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773157602; c=relaxed/simple;
	bh=F08TgPh030yz8+md6SB+C8RT0YDoIoklYB+Pplsjyik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vfr75VxwltahjbN37j3W0M4UkhTYbOD8ZBH08ClEYVvbgh07BbMVBJbaT5tVIEg/0pzyfl6sM1rwHmV5fP71qVadI9wQZOPrU5GBw9EsjHf6DocFQpc2yrxz5qNTWKRkNUOzh8uG9IKj98pUjxPY3i2Bv9VBHBQvweY0Ckpj4nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G3bIIElj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G3bIIElj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773157599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jm9RLDPaaT3j+gPSqhDteLms1KMvfMsdB8K+UVkI8jo=;
	b=G3bIIEljxCaSiYbn/3w3XfxwOwJw/c0wcXgPcyHpPVYpWFkSngTlRbY2zWsPSVR5vF2Gvx
	Zfm43FsdFxbdNA1BMIaFtalQweGP6N3qcJ4w8Od7z0pyRLVEbNks0LcR0vOPihEqBwz1UC
	arjAlrV7spfDNe3+qGMG5FxOeBumOjE=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-Fn3T6kfWMKuEW-EiPiAy5g-1; Tue, 10 Mar 2026 11:46:38 -0400
X-MC-Unique: Fn3T6kfWMKuEW-EiPiAy5g-1
X-Mimecast-MFC-AGG-ID: Fn3T6kfWMKuEW-EiPiAy5g_1773157598
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-794b74a8b2bso30689997b3.3
        for <iommu@lists.linux.dev>; Tue, 10 Mar 2026 08:46:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773157598; x=1773762398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jm9RLDPaaT3j+gPSqhDteLms1KMvfMsdB8K+UVkI8jo=;
        b=iYlcCwnTL7Rfa/ivtC3ILjTIBuiYC0dkLnLB5VGk7m0kJMj5uCDsatSQ6iCzAfhRg1
         C4mG6JZ3znpdMU95Zd1VBngsQzMLn+BzOwlU4yZFIK90OlxJ/X6Ep6EPiaRDuLbRTe7+
         Ic84WFE65tE9sBipM19GBj4Z3HkXYahnTlvDgjBOL/VZUU0eATiAPPYdHGC23j/h5jEC
         k5EbBiLBiUMHWvube1ueivF7ST85J0Xr8Fd7qG+aJ3A+Maj0KDrcL5g6+3+z89EfG04W
         Wr7gCOV5V0IkpXphDGarjL9FGP/bs76uAkLA4ASZpRS+mgMeipUrSdUZIVk3QR49MTdg
         rjOg==
X-Forwarded-Encrypted: i=1; AJvYcCWqieys4o2xV38IQA4p16+CX62kP1iXTPGxHy3dKJUf3khsAGYFbsfSiNm+rHB9nqu8+r/Q1Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw25G49gB7iD6VB4geytwoV1L6MBxHPmoXilJUopvsy61T2kkAq
	yYIWqyL5At2/DxTsbUAxQ45NF+7SwnWB3E+hf1BTg/3z7mBrDu0VxwAA7lybe7JR68m5P4Vpi1L
	WCwugC4sNK9K4/Mk6FK0B/j96zE3CTcUvlHMdJ6eToef+gMzNA3pwm2T0xh88JLT9jaZ/WGCTBO
	azXaEfjAArhbC0y84t0ti4t78l8y7WmyQ=
X-Gm-Gg: ATEYQzxcDgVeHPk1IvVgHXCru78oVm8nvW5dcRN8BlzK3iTpOBtXgO3k5bSw6HMAVGR
	vKgcmQ9XdBKeStz1TT/6aAr/CRc4sZvNmeTjsktaaMdPrJB8AhO4UVqe5qDHLFW/nGMYU/2WZ8u
	b1io76VWWHCWS8/ZbsMP6N3/SsBdTelk03HVF4av008YrbmzlNp6KX2pK/0cqCDNqv+5VhTyDx3
	A==
X-Received: by 2002:a05:690c:c52e:b0:794:cf56:5bc4 with SMTP id 00721157ae682-798dd7967acmr135920017b3.43.1773157597667;
        Tue, 10 Mar 2026 08:46:37 -0700 (PDT)
X-Received: by 2002:a05:690c:c52e:b0:794:cf56:5bc4 with SMTP id
 00721157ae682-798dd7967acmr135919707b3.43.1773157597202; Tue, 10 Mar 2026
 08:46:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260306-b4-dmabuf-heap-coherent-rmem-v3-0-3d00d36c9bc4@redhat.com>
 <20260306-b4-dmabuf-heap-coherent-rmem-v3-1-3d00d36c9bc4@redhat.com> <c7c1a4dd-dd10-4490-998b-55f9ec5989a7@ti.com>
In-Reply-To: <c7c1a4dd-dd10-4490-998b-55f9ec5989a7@ti.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Tue, 10 Mar 2026 16:46:26 +0100
X-Gm-Features: AaiRm52UQkdg-mPAmXvgjVPkoZxrbr_lB6LVxp0pI4Zhk--PPRrGDed_i5m98TE
Message-ID: <CADSE00KgYP0RsSN7wpSrPHDJUfVye40R=KW6XznLxzW16=QmAA@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] dma-buf: dma-heap: Keep track of the heap device struct
To: Andrew Davis <afd@ti.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	John Stultz <jstultz@google.com>, "T.J. Mercier" <tjmercier@google.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, 
	Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev, 
	devicetree@vger.kernel.org, mripard@redhat.com, echanude@redhat.com, 
	John Stultz <john.stultz@linaro.org>, Maxime Ripard <mripard@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XKf2XHce_ecjb5Z_2UECIR2DRSEc6CLWNlQIl5yepew_1773157598
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 3:38=E2=80=AFPM Andrew Davis <afd@ti.com> wrote:
>
> On 3/6/26 4:36 AM, Albert Esteve wrote:
> > From: John Stultz <john.stultz@linaro.org>
> >
> > Keep track of the heap device struct.
> >
> > This will be useful for special DMA allocations
> > and actions.
> >
> > Signed-off-by: John Stultz <john.stultz@linaro.org>
> > Reviewed-by: Maxime Ripard <mripard@kernel.org>
> > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > ---
> >   drivers/dma-buf/dma-heap.c | 34 ++++++++++++++++++++++++++--------
> >   include/linux/dma-heap.h   |  2 ++
> >   2 files changed, 28 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
> > index ac5f8685a6494..1124d63eb1398 100644
> > --- a/drivers/dma-buf/dma-heap.c
> > +++ b/drivers/dma-buf/dma-heap.c
> > @@ -31,6 +31,7 @@
> >    * @heap_devt:              heap device node
> >    * @list:           list head connecting to list of heaps
> >    * @heap_cdev:              heap char device
> > + * @heap_dev:                heap device
> >    *
> >    * Represents a heap of memory from which buffers can be made.
> >    */
> > @@ -41,6 +42,7 @@ struct dma_heap {
> >       dev_t heap_devt;
> >       struct list_head list;
> >       struct cdev heap_cdev;
> > +     struct device *heap_dev;
> >   };
> >
> >   static LIST_HEAD(heap_list);
> > @@ -223,6 +225,19 @@ const char *dma_heap_get_name(struct dma_heap *hea=
p)
> >   }
> >   EXPORT_SYMBOL_NS_GPL(dma_heap_get_name, "DMA_BUF_HEAP");
> >
> > +/**
> > + * dma_heap_get_dev() - get device struct for the heap
> > + * @heap: DMA-Heap to retrieve device struct from
> > + *
> > + * Returns:
> > + * The device struct for the heap.
> > + */
> > +struct device *dma_heap_get_dev(struct dma_heap *heap)
> > +{
> > +     return heap->heap_dev;
> > +}
> > +EXPORT_SYMBOL_NS_GPL(dma_heap_get_dev, "DMA_BUF_HEAP");
> > +
> >   /**
> >    * dma_heap_add - adds a heap to dmabuf heaps
> >    * @exp_info: information needed to register this heap
> > @@ -230,7 +245,6 @@ EXPORT_SYMBOL_NS_GPL(dma_heap_get_name, "DMA_BUF_HE=
AP");
> >   struct dma_heap *dma_heap_add(const struct dma_heap_export_info *exp_=
info)
> >   {
> >       struct dma_heap *heap, *h, *err_ret;
> > -     struct device *dev_ret;
> >       unsigned int minor;
> >       int ret;
> >
> > @@ -272,14 +286,14 @@ struct dma_heap *dma_heap_add(const struct dma_he=
ap_export_info *exp_info)
> >               goto err1;
> >       }
> >
> > -     dev_ret =3D device_create(dma_heap_class,
> > -                             NULL,
> > -                             heap->heap_devt,
> > -                             NULL,
> > -                             heap->name);
> > -     if (IS_ERR(dev_ret)) {
> > +     heap->heap_dev =3D device_create(dma_heap_class,
> > +                                    NULL,
> > +                                    heap->heap_devt,
> > +                                    NULL,
> > +                                    heap->name);
> > +     if (IS_ERR(heap->heap_dev)) {
> >               pr_err("dma_heap: Unable to create device\n");
> > -             err_ret =3D ERR_CAST(dev_ret);
> > +             err_ret =3D ERR_CAST(heap->heap_dev);
> >               goto err2;
> >       }
> >
> > @@ -295,6 +309,10 @@ struct dma_heap *dma_heap_add(const struct dma_hea=
p_export_info *exp_info)
> >               }
> >       }
> >
> > +     /* Make sure it doesn't disappear on us */
> > +     heap->heap_dev =3D get_device(heap->heap_dev);
> > +
> > +
>
> Is this actually something that matters or could happen? Seems you
> just remove it in the next patch anyway.

Good question. Technically, device_add() (and therefore, also
device_create()) already increments the refcount by calling
get_device() internally. So I'm not sure if this is necessary, I just
carried it over when I picked the patch. It feels like a safeguard to
have the device owner hold an extra reference so that if other code
decreases the reference count, the heap device won't be destroyed. So,
having the extra reference causes no harm.

I dropped it in the next patch because otherwise, I would have to
account for (and drop) both references when implementing
dma_heap_destroy().

So, I'm not sure what the best pattern is here. But I do agree that I
should either remove it from both patches or keep it for both.

BR,
Albert.


>
> Andrew
>
> >       /* Add heap to the list */
> >       list_add(&heap->list, &heap_list);
> >       mutex_unlock(&heap_list_lock);
> > diff --git a/include/linux/dma-heap.h b/include/linux/dma-heap.h
> > index 648328a64b27e..493085e69b70e 100644
> > --- a/include/linux/dma-heap.h
> > +++ b/include/linux/dma-heap.h
> > @@ -12,6 +12,7 @@
> >   #include <linux/types.h>
> >
> >   struct dma_heap;
> > +struct device;
> >
> >   /**
> >    * struct dma_heap_ops - ops to operate on a given heap
> > @@ -43,6 +44,7 @@ struct dma_heap_export_info {
> >   void *dma_heap_get_drvdata(struct dma_heap *heap);
> >
> >   const char *dma_heap_get_name(struct dma_heap *heap);
> > +struct device *dma_heap_get_dev(struct dma_heap *heap);
> >
> >   struct dma_heap *dma_heap_add(const struct dma_heap_export_info *exp_=
info);
> >
> >
>

