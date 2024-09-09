Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFE91BA26A
	for <iommu@lists.linux.dev>; Mon,  9 Sep 2024 13:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725889858; cv=none; b=eaKLeqT/ZOR1smlnvtuV5luGlduZZrYmFdvIcSE0IoPb14DqlH3Q0U7Stsreho/CwaYxcVR3cJGLbezfJ7IhjBUF2djSMBK+q+h97JkemnwaY1FQPqjfEuAn09ZhQjbYxtY0zAlX4PiSMkYHFwrPTpuS/buSi2VAN7UL1i3WBd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725889858; c=relaxed/simple;
	bh=5QUD7zyAM2DO5ygjJ1ToYT6vN4jD55DHZMUlXm30lVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=amqDBJRrEYNWGmPdCvkQZqOEcPpQluo/Lcl63mrKNJDhuHif9kGZH7V6FqdUxGl97GvHciwjSdBKfUvQop18S+ag7kx89Y8SnXegShzrKO42WUABNLYuBgHC322hmHMVS6FI03yfaS2gRkoGzfGxpyFRI2/ev0i0NHdiw6PyJq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dx7eMcK0; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dx7eMcK0"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42bbe908380so39092375e9.2
        for <iommu@lists.linux.dev>; Mon, 09 Sep 2024 06:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725889855; x=1726494655; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lMG5CBAWeO4ejfahNXtDesCRER8MZqFkLGpgD/QrZx0=;
        b=Dx7eMcK0SarsYEFtkrR1aGvUjdum7ZfRnwReIGXuAj9ra8n3mZ8mm2LRNJLJGk6v/J
         R4adHwez35Fzd1ojP1ExVHZ1tVSzI4E0MLjNTnqSXuQHC42aBqIa/mqDckf+VXqBiLnO
         2IOlVeV+Ndr8fOuP5p/QdWPLUvclT3mQe8HvwYHMdUmvIWyjuVAoT7/RCOpuj06hIhLn
         Wr6mmDk9jFR/su94ZIpeC97K3SbicGOg4Dlu4D48SDGwQglbrL7wEZ+KlEEEdjDY7ZPI
         ipk5srCyX/98nTANcDY2zIqRtP89XKmbF8D1qqUN/B/WbP5gq4Q0prFk9WOlUOyhHXfJ
         iBIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725889855; x=1726494655;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lMG5CBAWeO4ejfahNXtDesCRER8MZqFkLGpgD/QrZx0=;
        b=rZm8UTdY265xE9j9vUzf53jlXYH4jBajZ+X3mm7eHRCotsAtIrzC6sMTd0XoQNbQpK
         K8ZMizLcM2mLNRPVdXN2YNNFcxVdpD/WZIMjCv9uI6uqAED3pVHyepke1Vct/kOdcC10
         czHyVbEUrwwPV+ZteC+dLO9F/2Ph0j5QGbK1h3/T7rFW0DalomzWoY+U3tldfczvlN7G
         Jzg61CeyvzkAaug2YEi/19wxM+8LSmMGtZvoMzz7du01z4bozTWMk7Rm7rPWsSvepzMi
         F2Q672GjGggf4ebGftnXkhfTSG/z4aLXZ/mlf50k05Qdo8p7Cfi6R5s19sJS5wpera9p
         WHqw==
X-Forwarded-Encrypted: i=1; AJvYcCW67N6vNOlxfrhWRFR9Ds6/8dVvWt+I19a6zP2KsbUpaU8awoUYIUelGmd5Z3PLwn5TwTx3ZQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzAVPdCKsEXbVXxXzg/vcRWmG/vNYDpMkEekv6x57d6V+ngM1Sx
	BByHDhk33mGE7k+XYTOHrA0pL9NXrAQR+cnWkEawZiuMc4SzeuMe
X-Google-Smtp-Source: AGHT+IH7gctIpKVybmTJbCiBDVWk+ue5UJ4VaJ0e/g/b1ur+KjZ/0Qi53vCEo48IGD4SKCIPKcrAhw==
X-Received: by 2002:a05:600c:4692:b0:428:10d7:a4b1 with SMTP id 5b1f17b1804b1-42c9f9d6f06mr85546235e9.25.1725889854108;
        Mon, 09 Sep 2024 06:50:54 -0700 (PDT)
Received: from orome (p200300e41f29d300f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f29:d300:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cabd05496sm89431845e9.27.2024.09.09.06.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 06:50:53 -0700 (PDT)
Date: Mon, 9 Sep 2024 15:50:51 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>, 
	Danilo Krummrich <dakr@redhat.com>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Sandy Huang <hjc@rock-chips.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Mikko Perttunen <mperttunen@nvidia.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Kevin Tian <kevin.tian@intel.com>, dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
	linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-media@vger.kernel.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] drm/nouveau/tegra: Use iommu_paging_domain_alloc()
Message-ID: <zpk3oj47djrrrkxpe6airhiaoe7xr3pvxyqotac2jqmhoerg6h@lp5d5ziiq453>
References: <20240902014700.66095-1-baolu.lu@linux.intel.com>
 <20240902014700.66095-2-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cbx2ef5ohko5pqdz"
Content-Disposition: inline
In-Reply-To: <20240902014700.66095-2-baolu.lu@linux.intel.com>


--cbx2ef5ohko5pqdz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 02, 2024 at 09:46:58AM GMT, Lu Baolu wrote:
> In nvkm_device_tegra_probe_iommu(), a paging domain is allocated for @dev
> and attached to it on success. Use iommu_paging_domain_alloc() to make it
> explicit.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--cbx2ef5ohko5pqdz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmbe/TsACgkQ3SOs138+
s6HxRhAAo/V2yRjVbLpppk3RuhOIcoErbyCc0GlXoAWEjqyBXH3YkzOVeaKlu8iR
cexHENRfvc2/AnQ4DZd43yo3DXB4RL06245qE5NmyTSs1/uzrcwHGrIxYLS2M5NV
GNRWjLVkVVMzZL8+WAVpZlu5Z4EjJiLYWi9ZAeOrK6Pf3KhAKfzNjVALOoLD6V3A
qMfXYpQc9yx8QnBJ/sVC6Jz11kUgDGMjz68rr3vyFftxvownjajcwpa6NvkEBaUW
a1vLHY9T4W4qt0df3VhQM2wmidkF5AFhSNRZvELogwVmVOh06W9sXIe1O79CzJ9d
vnjemWkF3w/d2qqjzSqdktYKDEwECa+f0LiCs0eYgx8btQkevTLqNoZP7f6vKG+5
ELXTVH2DHYbzMQXMnrN73uyd2WUtAP9JeoE+rcTQXv4jpkLx8JnV7cenBYTgl3Tv
xibyj23MiXDiPSX+ZQAs0fMJK9L/MSukej9WyuD95WvqadTCO7qG2DmMcklcoAe9
ZGIXvgwG429t1ttFF6Gd5FfrizP8cQPZAOQ9YgydfSgUrJRIkJJeIO9G3wcJBy4G
2kElKIFxevKxizhPmyAFJMoJCl4I2Ma/OnfVNFvuaJPhYqqfU38RxF6sV+JuwdWM
bg9Bp+0RuHrepTbQn4sGrGK3BLWeeiCoEyECMGc3V5BURxImEfo=
=IgSG
-----END PGP SIGNATURE-----

--cbx2ef5ohko5pqdz--
