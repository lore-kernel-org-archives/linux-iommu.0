Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9338B425CC9
	for <iommu@lists.linux.dev>; Tue,  3 Mar 2026 13:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772543591; cv=none; b=Sct0tVm/Q6HIuAWhKS3buhuFat7+F58oWioUfvQjsBWzsD3nTicauRGLLQJxA3okbKm3ITxGHLzJ6ULsWXFzB/L5G/DlXItdzUTU9J2vuwY5Lwhlhw3sMDnXVFIg+l0qFW78Xfn5khCr7rFriM/np+9gA3Fh5GwXyRHHsspZF5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772543591; c=relaxed/simple;
	bh=L11CgpOsvWjy//OKwmDKit419j3ro/+KfnYSmwS3d4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RSuy6Vi+dW6VrFZyinHzvT1JHX/XxVT+dJWJ4dhLzLfGbBtY4ilp4BmtDr2yiEAP7f5I5wFZn1doXnzr1glPNyFD/CvtVCtVSjMKKTwgTKpUqXHWo58J3ALxqYwTqEfbSVSw0opTUg/d/skNlp/fNxDbh+7NeApv3M1gbyImI9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P6dTb0/v; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=K98YcS0O; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P6dTb0/v";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="K98YcS0O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772543589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5qYfoI6IhVhwhSZGcHAz8lUbAzhXZJ/rjYc5L9rs8fk=;
	b=P6dTb0/vXUUxJjsbKr5sc2VR9ZDTQJ7eNA5gopg8QGaU0I1HZcVAw6U109iIh441phrIjw
	BAIM7UqxC7OKXEFbM56NCPY88NMesamde8/vjWMH2f9CCOQHgfAO89NSMqBVtUHimrx0bJ
	wGkyHoY+3SFLmSA7JPO84HgGTy5z694=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-zFunBSTWPqmjeeQyLHFFvw-1; Tue, 03 Mar 2026 08:13:06 -0500
X-MC-Unique: zFunBSTWPqmjeeQyLHFFvw-1
X-Mimecast-MFC-AGG-ID: zFunBSTWPqmjeeQyLHFFvw_1772543585
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4837246211bso67853545e9.0
        for <iommu@lists.linux.dev>; Tue, 03 Mar 2026 05:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772543585; x=1773148385; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5qYfoI6IhVhwhSZGcHAz8lUbAzhXZJ/rjYc5L9rs8fk=;
        b=K98YcS0OYbaAhquOo+EbFapLE8xdjmQxoQ/XWcN+ZhvE7oBD+TLW8q+tTkcThFmcOk
         QxepQCKwJl6BPnrQOv4d3s4BuGjkPK15fREfBWc2R8HxP5GVO/EJszVzXajEyZOmyTLz
         kWsWtGDnXuEe/9H3oryRDcRIeIVkB82bi2g9aSARy14Z+C+fGzMNRZaiVHXdfmy5VIUZ
         81P8YGAvNUk/FtcWEvJ66NzdLKZgRMKf1EOUlOZjWVtaIB2o4yqbAGw0sDJuwa9vgZHn
         Qj1BQtmmPAAB8eGpf9cckrQpXobFLhyjCe8fOWg6stecr5HpFjVEkxs3fWSsvkkwdjrx
         L+jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772543585; x=1773148385;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5qYfoI6IhVhwhSZGcHAz8lUbAzhXZJ/rjYc5L9rs8fk=;
        b=um/QmeD7U+dnD+x8z9Qh0nGfjpGDCAzOxOmsPBIPUNFWVIKP3Sg5XttNcNOl9ey2zT
         mAMq9sM0jBspdXO9srST4bWcLjYO4UbuHvAoLJBep0ANxiyZGo5Pai1ryf+T5HXbdzMY
         hMzApmyt2BDrKv0OgryxUqa0wHRgrLws8CODt5O3zOkHop4busBPrhjY3PwD9OodyEts
         vUapENrmjPSjmp5qMvlLsA03Zk8PbfRX61eGdZen9EI1b9X8ExCcx0wAAAEz8IhhDaBn
         7p4GG2bLXk/blZmiTthaTDEUhoOfX+ELKxzNlfubCTBGDGYEdq8eKMMzYfOVDMxBE7lK
         VfiA==
X-Forwarded-Encrypted: i=1; AJvYcCV6zTsRnkZYqLb/2pQt+VWwhAUbXSY2SFSRF5I0/fhN9KZ8CA3q1CGIarPUF+wXAFPyp8APaA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxX9yZfg3muOPk5daXSRhQp5nkiP9r2TPaPSbU5FOa7ERNWjoYl
	aZ5NuVGwHtZMS3NpwX8AKQzaJ6xpipb8TUMHRPCqkplAdyahC0WRAp6ZvU6AYcQsVOSdB+qmSlg
	Y2j8nVGikskJfob3ioRibHRQfRrZUbtZ2VYzvhSx7ML7Ogyg0Y/1t5x+Q
X-Gm-Gg: ATEYQzzzFWagpxtVp6WFK/1mISs1wMj3cSpKwngEHV5mfB4xYSHxHnHhV+CoBEZBsag
	926aKANUQgkVPLvEGv8feS5kDr6kGSJ0dff9EzlLnB7Dl+VTHQoavtvTkB5Tg+LUXRKAGoKmWSD
	DzpXcCco7LooxlFDJSKAgcuSbYQr1VUzNz7BB94oOGELGHeCg9s2SZGV7FprZRgs5tijld0oAe3
	M+GDRX4B8q3NwjwQcux7M3a2SWLQT0N5jExBwfloBLBWeVn6/pIfyo1rGenBo+18ikKEs35+2II
	xo6/JE/9Sa+kZ/p4iYWfcKA/l2TJIeKMqwLREQLaJL8QvYi6YodbFAkZ9wL+VLKT0ze4oe7FXA=
	=
X-Received: by 2002:a05:600c:1393:b0:483:498f:7963 with SMTP id 5b1f17b1804b1-483c9c1f8fcmr272330275e9.26.1772543584831;
        Tue, 03 Mar 2026 05:13:04 -0800 (PST)
X-Received: by 2002:a05:600c:1393:b0:483:498f:7963 with SMTP id 5b1f17b1804b1-483c9c1f8fcmr272329585e9.26.1772543584305;
        Tue, 03 Mar 2026 05:13:04 -0800 (PST)
Received: from localhost ([2a01:e0a:b25:f902::ff])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48512692c14sm17392055e9.7.2026.03.03.05.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 05:13:03 -0800 (PST)
Date: Tue, 3 Mar 2026 14:13:02 +0100
From: Maxime Ripard <mripard@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	John Stultz <jstultz@google.com>, "T.J. Mercier" <tjmercier@google.com>, 
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@kernel.org>, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev, 
	devicetree@vger.kernel.org, echanude@redhat.com
Subject: Re: [PATCH v2 3/6] of_reserved_mem: add a helper for rmem
 device_init op
Message-ID: <20260303-weightless-crafty-hyrax-bdf1ca@houat>
References: <20260303-b4-dmabuf-heap-coherent-rmem-v2-0-65a4653b3378@redhat.com>
 <20260303-b4-dmabuf-heap-coherent-rmem-v2-3-65a4653b3378@redhat.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="6eyb3mm7ilqztbmi"
Content-Disposition: inline
In-Reply-To: <20260303-b4-dmabuf-heap-coherent-rmem-v2-3-65a4653b3378@redhat.com>


--6eyb3mm7ilqztbmi
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 3/6] of_reserved_mem: add a helper for rmem
 device_init op
MIME-Version: 1.0

On Tue, Mar 03, 2026 at 01:33:46PM +0100, Albert Esteve wrote:
> Add a helper function wrapping internal reserved memory
> device_init call and expose it externally.
>=20
> Use the new helper function within of_reserved_mem_device_init_by_idx().
>=20
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---
>  drivers/of/of_reserved_mem.c    | 27 +++++++++++++++++++++++----
>  include/linux/of_reserved_mem.h |  8 ++++++++
>  2 files changed, 31 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
> index 1fd28f8056108..3a350bef8f11e 100644
> --- a/drivers/of/of_reserved_mem.c
> +++ b/drivers/of/of_reserved_mem.c
> @@ -605,6 +605,28 @@ struct rmem_assigned_device {
>  static LIST_HEAD(of_rmem_assigned_device_list);
>  static DEFINE_MUTEX(of_rmem_assigned_device_mutex);
> =20
> +/**
> + * of_reserved_mem_device_init_with_mem() - assign reserved memory regio=
n to
> + *					    given device
> + * @dev:	Pointer to the device to configure
> + * @rmem:	Reserved memory region to assign
> + *
> + * This function assigns respective DMA-mapping operations based on the
> + * reserved memory region already provided in @rmem to the @dev device,
> + * without walking DT nodes.
> + *
> + * Returns error code or zero on success.
> + */
> +int of_reserved_mem_device_init_with_mem(struct device *dev,
> +					 struct reserved_mem *rmem)
> +{
> +	if (!dev || !rmem || !rmem->ops || !rmem->ops->device_init)
> +		return -EINVAL;
> +
> +	return rmem->ops->device_init(rmem, dev);
> +}
> +EXPORT_SYMBOL_GPL(of_reserved_mem_device_init_with_mem);
> +
>  /**
>   * of_reserved_mem_device_init_by_idx() - assign reserved memory region =
to
>   *					  given device
> @@ -643,14 +665,11 @@ int of_reserved_mem_device_init_by_idx(struct devic=
e *dev,
>  	rmem =3D of_reserved_mem_lookup(target);
>  	of_node_put(target);
> =20
> -	if (!rmem || !rmem->ops || !rmem->ops->device_init)
> -		return -EINVAL;
> -
>  	rd =3D kmalloc_obj(struct rmem_assigned_device);
>  	if (!rd)
>  		return -ENOMEM;
> =20
> -	ret =3D rmem->ops->device_init(rmem, dev);
> +	ret =3D of_reserved_mem_device_init_with_mem(dev, rmem);
>  	if (ret =3D=3D 0) {
>  		rd->dev =3D dev;
>  		rd->rmem =3D rmem;

I think you need to take the allocation of rd, and everything below.
Otherwise, your device, despite being attechd, wouldn't be listed
anywhere.

Maxime

--6eyb3mm7ilqztbmi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaabeWQAKCRAnX84Zoj2+
dobdAYD53cfYylVyAMmjYQNu5L2HhH4nvwgXPsXDn+F4I5VP5R8b4pw9vf6buYC3
VoNwMQ4BfRUwUB8fZ2DXMX2IzVK3CXj6DaDP6OvnbvuzEI1Mw7ev9Mpzd14engew
qmADP+lGrA==
=WwGV
-----END PGP SIGNATURE-----

--6eyb3mm7ilqztbmi--

