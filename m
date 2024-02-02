Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E89F4F0
	for <iommu@lists.linux.dev>; Fri,  2 Feb 2024 04:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706848874; cv=none; b=QyKcukuJVyoJq8LsXuVxmx0Yl9LbCZQ6ZN5KaLkVMdUKB8X4kcG50YHXbM2HG+ysi+hhE+JWzjvpTIxt6guBtwFKiS3JsS6Y/nJGBROjPAqEeQ1au1XzHAW3RePU6D7mOUQuOoy+aUE//z0V33U/vLDV6Ue09PT5EvkUqBlCDMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706848874; c=relaxed/simple;
	bh=tcEH8y9ILQRfJEiztnFPBtbL/SdrVqxuQ6BXuMiY/J8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d4+B0klEUa9Q4YCa4nwYJB5w3y0O+zajAxsZkNMkCIVwHdqePpxe9XURGVzk7+GBjaQF9BUx44cyy0qAZy2Y2D5b8JP6vdM6szQ0HyVzzU9RlVcJn6cfCR8/mW6xUrqNC8AicUEvz3Tw6OJtnG+J0dvN94CAlG3BqlJngoTm29g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4LIz2VSK; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4LIz2VSK"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dc6c3902a98so1297151276.1
        for <iommu@lists.linux.dev>; Thu, 01 Feb 2024 20:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706848871; x=1707453671; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MR2/y2vEPhv8eBcksIZP96OOa1fhQ1JeijHES+W35BI=;
        b=4LIz2VSKNPXbyMWuJ2V8YlWFeigb8WvMNo7+hc6P4jYUOAnhEsPw3rpIAUMetvkQvp
         a3MmXaOG1qnFxZPV7zoQfAWYIcpvTVOrx0hdDPPQ4CmVIsLpQYGXkszwoJQMEQQEQtRZ
         oDfkUm1XwhqEz67VZuQOwfu6zTvnfQ/+0TJ1CHSJSyeKG0mjT+LzcttKAAVTlqDRL5ru
         lawaxll3zn/gPVsfS0dlN2HjoWVAVvL9s3czrO60a5JnIIfb1BD3oLiVo1vr/n9yLnvo
         LJkiTea0MGldFI+FuyxAkss2on3hppvK1bBBKNKNuuHiaNnBNfN1zayFHs8X3Y52vqQP
         1rRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706848871; x=1707453671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MR2/y2vEPhv8eBcksIZP96OOa1fhQ1JeijHES+W35BI=;
        b=wlSEuJI5wj9exmo4Ttay0YI/EqMD59E5ReTFAVkEmlJEiJ/4BNsvU5md7Sc8Cmedqv
         5nSeAICT78w50Tisma+wxqBDb+Zertyxv84YgS0Tcq0s7A6Ma6v+JCRPS52SfbAAjcEB
         DDyR2VIwV0uUciip8CI6BmWYhPsf27qkan2mgke3acMS2MT2pUt0mq5U5CmfT+CXOuMr
         xb8/GNDgJ1Xl+pV7nglMMY8xlRUpOrq5xq6NwwHx3NhSpIWMSkDYE1KIzLJvfrxsPfiM
         o/UySux1ZrrNktZA0BolPgHt7iBTTYlDntSybASsLQAvW7lfDMDwBAtJzvGQ9tE8B93+
         3R+g==
X-Gm-Message-State: AOJu0YzXotEZQe7sfOmi7pW7BzSDIWK7OMTUNqpDHiB79zDbJMD5BuIw
	/0PXtfZ0mRfboQPBC0q/evUsFXdTUdPLBWcV3uBhE+FagwaRluOwbx7Y0q8xX6tluoO1mTmNkWD
	VL4B2INcBgIWC1wc9ZGCfO9Kb5TTCNNzsws+G
X-Google-Smtp-Source: AGHT+IEeBKezZDIqBQF7eHwuYqAvCJ8nw+dAXcKn3tJnFoqaYeczMg4ET2n7H9b6PoIbYlxV8PzaiVJxGLGJ2vWoXDo=
X-Received: by 2002:a25:9701:0:b0:dc6:bb86:ea11 with SMTP id
 d1-20020a259701000000b00dc6bb86ea11mr4583776ybo.19.1706848871267; Thu, 01 Feb
 2024 20:41:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240201093515.849873-1-howardyen@google.com> <f5b626ae-bda1-479f-bc14-b1fd7ba043cf@arm.com>
 <2024020156-reshuffle-salvaging-8161@gregkh>
In-Reply-To: <2024020156-reshuffle-salvaging-8161@gregkh>
From: Howard Yen <howardyen@google.com>
Date: Fri, 2 Feb 2024 12:40:59 +0800
Message-ID: <CAJDAHvZ=XVZ-Ea1LVqfTnDXJ+J=PLbZNCZkuSpvdOtEsreguWw@mail.gmail.com>
Subject: Re: [PATCH] dma-coherent: add support for multi coherent rmems per dev
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Robin Murphy <robin.murphy@arm.com>, hch@lst.de, m.szyprowski@samsung.com, 
	andriy.shevchenko@linux.intel.com, petr.tesarik.ext@huawei.com, 
	rafael@kernel.org, broonie@kernel.org, james@equiv.tech, james.clark@arm.com, 
	masahiroy@kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 11:41=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Thu, Feb 01, 2024 at 10:45:30AM +0000, Robin Murphy wrote:
> > On 2024-02-01 9:35 am, Howard Yen wrote:
> > > Add support for multiple coherent rmems per device. This patch addes
> > > dma_mem_list to device structure to store multiple rmems.
> > >
> > > These multiple rmems can be assigned to the device one by one by
> > > of_reserved_mem_device_init_by_idx() with the memory-region
> > > declaration in device tree as below and store the rmem to the dma_mem=
_list.
> > >
> > >     device1@0 {
> > >             ...
> > >             memory-region =3D <&reserved_mem0>, <&reserved_mem1>;
> > >             ...
> > >     };
> > >
> > > When driver tries to allocate memory from the rmems, looks for the fi=
rst
> > > available rmem and allocates the memory from this rmem.
> > >
> > > Then if driver removed, of_reserved_mem_device_release() needs to be
> > > invoked to release all the rmems assigned to the device.
> > >
> > > Signed-off-by: Howard Yen <howardyen@google.com>
> > > ---
> > >   include/linux/device.h |  1 +
> > >   kernel/dma/coherent.c  | 66 +++++++++++++++++++++++++++++++++++----=
---
> > >   2 files changed, 56 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/include/linux/device.h b/include/linux/device.h
> > > index 97c4b046c09d..c8682ee507cf 100644
> > > --- a/include/linux/device.h
> > > +++ b/include/linux/device.h
> > > @@ -751,6 +751,7 @@ struct device {
> > >   #ifdef CONFIG_DMA_DECLARE_COHERENT
> > >     struct dma_coherent_mem *dma_mem; /* internal for coherent mem
> > >                                          override */
> > > +   struct list_head        dma_mem_list;
> >
> > I'm not necessarily against the idea, but only if it's implemented sens=
ibly.
> > If we're going to have a list of these it should *replace* the existing
> > pointer, not do this weird thing with both.
>
> Agreed, it should be one pointer max for this structure for this type of
> thing.  Why not move it into the dma_coherent_mem structure?
>
> thanks,
>
> greg k-h

I'm considering to modify the change to

1. Move it into the dma_coherent_mem structure, like

     HEAD
mem0->node

This case, if I check list_empty(mem0->node), it would give me the
list is empty, but actually there is one rmem.

2. Replace the pointer to a list_head.

    HEAD
dma_mems ---> mem0->node

This case, if I check list_empty(dma_mems), it would give me the list
is non-empty, it matches the actual status.

So, the 2nd looks reasonable, I'm going to upload a v2 patch with the
2nd approach, does that make sense?

--=20
Regards,

Howard
