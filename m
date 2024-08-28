Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F2D1A3BDA
	for <iommu@lists.linux.dev>; Wed, 28 Aug 2024 15:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724858850; cv=none; b=RBAVFKM5mjbbNbq1z2hmmOSFyvvzz6w/Yn6rIlFKtMPv9q9GlbOJf2JNvOyl2YilqEX6o0+5jny7BCZT5LnyWB5/FQhIfLxiT09vn/pYrXhOl0dAND7A+HPMsuZKEpeMCEWIVveJzDHwZb6OMV2lg9vi7YZ5dHb11OeeZ4BUYhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724858850; c=relaxed/simple;
	bh=BtVyzWMVALC/1EFZ2S7XKeV0QsA+D5/40hYHNVrXqJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=onjQtlCcrqo9FhWI6lrdAwLKLUMi3qBjqFZiUcLzrN3U7Tq6o08hnr1lRjlmYdS4+CI+9d7YTvptuD7NMtrT55qbyKovBs87nKOjUVQIFQ94MXQxEn5ZIfqDyaQ+DV1qjkHOHpdWcDvxi+GxqFkX1IrFFpgN6+Pz0Bzwl0AVOxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PapHwSzS; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PapHwSzS"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42808071810so59335655e9.1
        for <iommu@lists.linux.dev>; Wed, 28 Aug 2024 08:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724858848; x=1725463648; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7d72c/mj/2Z6FiVdpOBNTFT01VdBmf1RNvsZEcgNCnA=;
        b=PapHwSzSvuh7cHuT2sz5doyQmB/FqcVs2biqRyeIiq1mEmkd3997XHCbnBZ+Zgcb7Q
         RnTolplyjUC4rAd1pJ+3eniX1LiuUez74+5eB129bDJOQVWf7bEscQygpfhL8okcTuYZ
         DltOzn9qORLwFQtvcrXn1MQTbm2Ff5UeasuCicZCLN7yNj5JjWeykkmcH4l3H/il7rey
         WGL+1X8wKpff7W2y6Q+eEpQI2Bp0YvEUs1+oCrpX79GQ28G+MQ7znXV08NgQBSc+oglR
         eOwXNAIdpM3znH4C66Y86YNWNgxz+OBqli97Ocg7vmtbhJsCJDv3g+X5huYgnhZOcNh1
         8jCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724858848; x=1725463648;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7d72c/mj/2Z6FiVdpOBNTFT01VdBmf1RNvsZEcgNCnA=;
        b=mNvDKVbz6GM40T9LuYtWHLERZksjARlTXhidEsvX3m2qZAm7KB7erNaaVE+XrbnSKi
         KZ/lh1V+WzWMhlhGgQZwy3XbPlvt4Vnwz/zXndmoQRZg6kvy7jmqJ2yy4b5p/wJVN1/T
         ncEnRA3N08/7jwC4wm8v/KxULjipM9aWGknfgTNbVnSu8FGB7iF8vUb3Tt8+eU5nFa0k
         Oy3w+CPnjTPqPiHLlv6GoyXiZDvlfFoCK3Tg/IbBR6+q2ocLHiYuLJ1aNCFq4UDRJktG
         yMeusvwgLBEdJTs38enZzfykoLaKGamAjdv3MfXL1OVFa7x3HHa39PcNs5NnzlZcdQA9
         HZmw==
X-Forwarded-Encrypted: i=1; AJvYcCUWrz0oJPkfHPk/zM12nZ3n/+HfzeL4gqif1l+lk8uAb5ZanfFVuAHl/YVt68fKkpe0V7EnzQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyIz16UEvl2ZQ2JUzhzEnQezMBqWSmXZVCLHJzQVmqLieib9oJb
	KvAnppL2oOlzxlIZX8xrKoUZN3ncnk2adQW7iuBp8uX0rKUZy6uX
X-Google-Smtp-Source: AGHT+IFy+N6MNpikAMD3IJYGiP5Mfu8DbpT3WuOqB9zdjdgMg/vD1umE1XlYBlEzFehtYhZBgfMtDQ==
X-Received: by 2002:adf:a3dd:0:b0:371:7e73:de6e with SMTP id ffacd0b85a97d-3749685b56fmr1596718f8f.52.1724858847009;
        Wed, 28 Aug 2024 08:27:27 -0700 (PDT)
Received: from orome (p200300e41f29d300f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f29:d300:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749b238cf7sm81389f8f.33.2024.08.28.08.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 08:27:26 -0700 (PDT)
Date: Wed, 28 Aug 2024 17:27:24 +0200
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
Subject: Re: [PATCH 3/3] drm/tegra: Remove call to iommu_domain_alloc()
Message-ID: <qyvyd2ftebjlgmzyayfvxsqa64c4wgx7keix3a6eexdspbvawy@a5ffnm5h5tgp>
References: <20240812071034.9443-1-baolu.lu@linux.intel.com>
 <20240812071034.9443-3-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fslg44mz7bzr7agv"
Content-Disposition: inline
In-Reply-To: <20240812071034.9443-3-baolu.lu@linux.intel.com>


--fslg44mz7bzr7agv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 03:10:34PM GMT, Lu Baolu wrote:
> Commit <17de3f5fdd35> ("iommu: Retire bus ops") removes iommu ops from
> the bus structure. The iommu subsystem no longer relies on bus for
> operations. So iommu_domain_alloc() interface is no longer relevant.
>=20
> Normally, iommu_paging_domain_alloc() could be a replacement for
> iommu_domain_alloc() if the caller has the right device for IOMMU API
> use. Unfortunately, this is not the case for this driver.
>=20
> Iterate the devices on the platform bus and find a suitable device
> whose device DMA is translated by an IOMMU. Then use this device to
> allocate an iommu domain. The iommu subsystem prevents domains
> allocated by one iommu driver from being attached to devices managed
> by any different iommu driver.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Link: https://lore.kernel.org/r/20240610085555.88197-20-baolu.lu@linux.in=
tel.com
> ---
>  drivers/gpu/drm/tegra/drm.c | 34 +++++++++++++++++++++++++---------
>  1 file changed, 25 insertions(+), 9 deletions(-)

Actually I think we can just do something like this:

--- >8 ---
diff --git a/drivers/gpu/drm/tegra/drm.c b/drivers/gpu/drm/tegra/drm.c
index d9f0728c3afd..d35e411d536b 100644
--- a/drivers/gpu/drm/tegra/drm.c
+++ b/drivers/gpu/drm/tegra/drm.c
@@ -1150,7 +1150,7 @@ static int host1x_drm_probe(struct host1x_device *dev)
 	}
=20
 	if (host1x_drm_wants_iommu(dev) && iommu_present(&platform_bus_type)) {
-		tegra->domain =3D iommu_domain_alloc(&platform_bus_type);
+		tegra->domain =3D iommu_paging_domain_alloc(dev->dev.parent);
 		if (!tegra->domain) {
 			err =3D -ENOMEM;
 			goto free;
--- >8 ---

That refers to the physical device that the host1x_device virtual device
was instantiated from and is a common parent to all physical devices
that are part of the virtual device.

Thierry

--fslg44mz7bzr7agv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmbPQdkACgkQ3SOs138+
s6Faag/+PLNW+D2IJ1ANTAMAHn0fybn2aGa6fRFPkVgUQSXQP4OlfAdV1W2+DKPi
CSLmOHisUapqMwyMZECKEkXHkM7+i7Snhz+D6gHCMx7YWFQiLGi0j9KZfT3kfX5V
tOIVJXrEAcJZN9htxoPZ842Z5QrrzTNgVkvhmC2lhqA6sjy3BbyK8TgncUVpceMC
wPCVwjnNyJZUxK/MZgyj5OywXC9emVXY5Y0WgjJ14D1KNPScAsSCLKbIvAS5Pku8
8K0m4Dzv4+WtNRhr42OVrtji9VJwnrjVgJZXuGgJC7aQVDFbghM9rQ2NnaHAztOK
EL+9DKRDLXo+MwQmvqSWTkY1OEd0Y2cJsagqS9363Q5Xau7Iwrxa2vAXgXUwkWyP
/Z4cZYzatMr+CF+165NbtQYlJlRqBpW8kDslxGR1DT1NhNLbpE6y0FKaBp9YWXhA
U8AkaTSeeuO96M7c9jr2sLyHIxIYzMPvsC5vvw44NQRty78DyLp9wE90r0Z954C+
6DJMnKQIsoa+rCnof94BhK9ThweuwyWWMc/7755EWJoUo2g8VVyDei6m2GBMj5zT
kkkzVeWz8F1cV3zDn8aa0hYje3tzVdvChHSMXHU44wRHSD6xaoI9KgxehV6TYlCI
G3/NyFMo6sIP/I5hnEpQmI3pF5641WaJSYeocgjLIRESADr7+Dk=
=Ka+K
-----END PGP SIGNATURE-----

--fslg44mz7bzr7agv--
