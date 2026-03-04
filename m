Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB878382F29
	for <iommu@lists.linux.dev>; Wed,  4 Mar 2026 07:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772611140; cv=none; b=jQPxlT8jYOWOsissnOVppic1HhkZxL1xaSui6BQi5qQfutcifrxl1HezeD2OoihrbW5pJAmZFwnuRM5F2+0hidLxb8jpf1dhlRyQQrUcHGUHI+369pZ0dKXyzMUvBkYIdlxw5SAEThT01H6U27KfFET089U4T9RHcBQa3LXFwtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772611140; c=relaxed/simple;
	bh=7DX6Xti3V185YiZv0qsnJejX66rVhLRc4dUIutVTUlA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G9zXZ5btMCpmCmD0JYSH/4Z84NFD1tMPV3Sq9XTQiHjnW893KY0GbBOleViSjKP+iqqm/gvTPsKVOsUSzvoXzy5M1GzswodLcOfynOKsM/s3CaqhSS1C3XfkKcFPpsxAWOtipsFbgs5cggiVu4dm6SkzIprSsVxBVJ2i0PRocic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VW0X/hp4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VW0X/hp4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772611135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wcqpRt8jvMP8XWtSPkO4bteIZfJG5tmplM3Y6kGZdoo=;
	b=VW0X/hp4O1IQo+Lv3+QFu2uH75QK0Ag2xrWlbtJRpOEknfg2vibGbb3Lb+qcEbPOBbtPXI
	MS6bgpIqBeai4zzshIsP5diS0Hhe/bPbrBr5bykJpj6zP5UZoQMuXGdHPKk5hAlqXEOaJW
	IK2yfCXgJ4JY+eYSGSoDRsRTZ8XCboU=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-TwNEySkaMh6DwW9fOGQA7Q-1; Wed, 04 Mar 2026 02:58:54 -0500
X-MC-Unique: TwNEySkaMh6DwW9fOGQA7Q-1
X-Mimecast-MFC-AGG-ID: TwNEySkaMh6DwW9fOGQA7Q_1772611134
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-64ca5bae25aso10353670d50.3
        for <iommu@lists.linux.dev>; Tue, 03 Mar 2026 23:58:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772611134; x=1773215934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wcqpRt8jvMP8XWtSPkO4bteIZfJG5tmplM3Y6kGZdoo=;
        b=w1vfsB/uXa6ex2S1Qop/Ke1U3yv0XHsPZXqQrxgWOy8v6mUiyabc9rHVFcq7tbAqnr
         V9o0pAGb5BFNeOIKnoNXzEEZrHguE/5cF5b+R0y/8t4lLi44lOUL0B0K09iDjp5caA50
         hmgyxiMoVtAOiIWuYSRJTa/5UPIoQZn8LumxS1HagMGnTqGogEb4cPDw06Al8woNF6Aj
         Zk+UATJI3BRLNLi37qmlsM+AJFrWG/ljPB31DDNUBXl5pjAxStUDNzjJRszbmE3oR5X/
         gS40sbu21wpRxJoKP6XwdXhC0Mw+OUQ8HimxxJS1EQdl5R9snB27ojvNW1LbkwyHoOlK
         xUtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPuiFt0by1FRAXOcnJwMiGxadbfz7K2rtgJBaeOr99v2ee3dAxPFQNOagLKTTZzTfD44gNmg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyp6JvRZVDZ3AE4lofIFtf5Ml3VrT9ZPgj6CEeJX22uz/oPAWZf
	XIa88GpiPdCSMaq9Bk2enGULDNoYHiKPDgLjLSXvFTXL8V7BRooccqhJD0br1RWJmv4MlnSicQj
	o5tZSGMPG7ENfkpyeO7/OadjWOGrqsJpUBs72BSEoWFImh20IJfDHqAvfC7BY1wPqlkiXnYWWwk
	gQfbwBSSytP88HAloWRds0eEAhkaysRTI=
X-Gm-Gg: ATEYQzx9EfAddohcENO1MkktkOxUXQGKztxyNvAv8YXYas8wMDdgxQGWna1azMC2Ia1
	x/jFD9l8U9p0iEo7pxys+xUKsHTnUJ/wLVwmSlhlbXdTtGFt0qGkREXfSLwEbvYl10v6lf1O55o
	LNlH+tmNcGIXWNfM8zrieGs7cmn2AyhCWZfv2r1s7bsl/tYeAAgRV2HOcHnwOBsuCE/laKxyw9U
	Q==
X-Received: by 2002:a53:ee53:0:b0:649:b04c:25c3 with SMTP id 956f58d0204a3-64cf9c1872amr761655d50.62.1772611134101;
        Tue, 03 Mar 2026 23:58:54 -0800 (PST)
X-Received: by 2002:a53:ee53:0:b0:649:b04c:25c3 with SMTP id
 956f58d0204a3-64cf9c1872amr761636d50.62.1772611133749; Tue, 03 Mar 2026
 23:58:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260303-b4-dmabuf-heap-coherent-rmem-v2-0-65a4653b3378@redhat.com>
 <20260303-b4-dmabuf-heap-coherent-rmem-v2-3-65a4653b3378@redhat.com> <20260303-weightless-crafty-hyrax-bdf1ca@houat>
In-Reply-To: <20260303-weightless-crafty-hyrax-bdf1ca@houat>
From: Albert Esteve <aesteve@redhat.com>
Date: Wed, 4 Mar 2026 08:58:42 +0100
X-Gm-Features: AaiRm50vjbd8iZF9aZq1Cno_RqIuyn0PYTIuzz9Iq5d5rpEaa4iOCaZKKjWryT4
Message-ID: <CADSE00LodeTg8Xfvo4VOZDvHh25=8+Jsqq+V8iynmpYx2bBRjA@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] of_reserved_mem: add a helper for rmem device_init op
To: Maxime Ripard <mripard@redhat.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	John Stultz <jstultz@google.com>, "T.J. Mercier" <tjmercier@google.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, 
	Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev, 
	devicetree@vger.kernel.org, echanude@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AKQJwxETKe7_-MTTd_sGJOQbO9Ihe0jMsbOJ2fwXdlU_1772611134
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 3, 2026 at 2:13=E2=80=AFPM Maxime Ripard <mripard@redhat.com> w=
rote:
>
> On Tue, Mar 03, 2026 at 01:33:46PM +0100, Albert Esteve wrote:
> > Add a helper function wrapping internal reserved memory
> > device_init call and expose it externally.
> >
> > Use the new helper function within of_reserved_mem_device_init_by_idx()=
.
> >
> > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > ---
> >  drivers/of/of_reserved_mem.c    | 27 +++++++++++++++++++++++----
> >  include/linux/of_reserved_mem.h |  8 ++++++++
> >  2 files changed, 31 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.=
c
> > index 1fd28f8056108..3a350bef8f11e 100644
> > --- a/drivers/of/of_reserved_mem.c
> > +++ b/drivers/of/of_reserved_mem.c
> > @@ -605,6 +605,28 @@ struct rmem_assigned_device {
> >  static LIST_HEAD(of_rmem_assigned_device_list);
> >  static DEFINE_MUTEX(of_rmem_assigned_device_mutex);
> >
> > +/**
> > + * of_reserved_mem_device_init_with_mem() - assign reserved memory reg=
ion to
> > + *                                       given device
> > + * @dev:     Pointer to the device to configure
> > + * @rmem:    Reserved memory region to assign
> > + *
> > + * This function assigns respective DMA-mapping operations based on th=
e
> > + * reserved memory region already provided in @rmem to the @dev device=
,
> > + * without walking DT nodes.
> > + *
> > + * Returns error code or zero on success.
> > + */
> > +int of_reserved_mem_device_init_with_mem(struct device *dev,
> > +                                      struct reserved_mem *rmem)
> > +{
> > +     if (!dev || !rmem || !rmem->ops || !rmem->ops->device_init)
> > +             return -EINVAL;
> > +
> > +     return rmem->ops->device_init(rmem, dev);
> > +}
> > +EXPORT_SYMBOL_GPL(of_reserved_mem_device_init_with_mem);
> > +
> >  /**
> >   * of_reserved_mem_device_init_by_idx() - assign reserved memory regio=
n to
> >   *                                     given device
> > @@ -643,14 +665,11 @@ int of_reserved_mem_device_init_by_idx(struct dev=
ice *dev,
> >       rmem =3D of_reserved_mem_lookup(target);
> >       of_node_put(target);
> >
> > -     if (!rmem || !rmem->ops || !rmem->ops->device_init)
> > -             return -EINVAL;
> > -
> >       rd =3D kmalloc_obj(struct rmem_assigned_device);
> >       if (!rd)
> >               return -ENOMEM;
> >
> > -     ret =3D rmem->ops->device_init(rmem, dev);
> > +     ret =3D of_reserved_mem_device_init_with_mem(dev, rmem);
> >       if (ret =3D=3D 0) {
> >               rd->dev =3D dev;
> >               rd->rmem =3D rmem;
>
> I think you need to take the allocation of rd, and everything below.
> Otherwise, your device, despite being attechd, wouldn't be listed
> anywhere.

True, I did not pay enough attention to that part. I will fix it in
the next version.

>
> Maxime

