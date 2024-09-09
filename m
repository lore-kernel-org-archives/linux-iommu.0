Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323711EEFC
	for <iommu@lists.linux.dev>; Mon,  9 Sep 2024 13:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725889833; cv=none; b=ImI9NCDIV28OT5wqmBi9LCCHc9f5X+k+UdnvrhD977VyuL71rop0DFfmgrMB/FRZhxbQfBkFSZhqAnbeOW1OdNBAmSWVmyLnH6RoEXMydJxs8w0yxW3q96+I8ydh0UxDqBJVqcPVS6P89lHX4miCAW+Bu2kxIO+vuvHk038Bh8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725889833; c=relaxed/simple;
	bh=itxo6/62dv5QH54RJ3ls+SJy/YuQMZMxrdupV5XIk/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AGyeQN6Ufk9+72IeryCbaOCQtHlyw3MNnX8U02sbrcyh5D3DWeZ49/itlcBN62ZPkVsaM3/F5Rj6WjTTOEIcE54tl56hes37KmkTmhsjsjK5Ei/QtRuPW2vnrNSA/x4qxTtppN/bzctXUn0TgRNWYLlSAKmDXOCbROTVNNi1aDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J/LKRDrP; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/LKRDrP"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42cb60aff1eso11215925e9.0
        for <iommu@lists.linux.dev>; Mon, 09 Sep 2024 06:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725889830; x=1726494630; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uTmI7FKnXchw996SUeECY59GrYXxeJtGeoLPHxq544M=;
        b=J/LKRDrPS3MEY17xwNIReXKMpkeiYTxHj3ZeIxuqmYFkGxrLH2dE6rfIBFhTRqa8eZ
         7bz+l0fDia+goOTyN+J8xU/t+t2JkMNtRpf5OuspiWkNibZsrZ6Qv2s6+QElEeNtvrwa
         v5+fgRjfa5jZguWwliLxOXnVOaOy01jljS9wh7s6lOT9zzAmpgos//My2CrzB0MI+OF8
         Zw1xIUq1fjn+gEGI2qcYPFCi7ueEe+d7+cV8wccu2lWs1fIbh79+1U49XkM2mMV9fDZl
         UOTjDwHt6QJGxMHU2RlVfpknYuy0bsmz67/LdnOcMIVTKJqpkEJBpiJciNSkjOhXXD+O
         33VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725889830; x=1726494630;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uTmI7FKnXchw996SUeECY59GrYXxeJtGeoLPHxq544M=;
        b=E/uzthrmm9fcr7vqJauP+po8NiXlkliCCluUVoPLOxwxFw3ftWvy2+1Y34jUCe3u4c
         Rh7iaTKb9j+dsbjMaqTmWoX32Atk1mhW4mAK4qvdAXNhNsO88NtGidYQX/+n7fhjQ89R
         RjIThwelezS5cXUxWSHQHk/RoYvN6pSXvj/xZOhQDCy1XcdYe2KNfZ6N0m8VLe3ElKtw
         ckNW+07tPp+X7pbyBbHAGUTDJRSbxvDW6DWbl6ahsgaoFsxki4akLdUCp1lkPu4SKpcM
         Ao4hClOE4/Kmqkn7a5W2VjCGzYuWDrnL5tEIppPKniHNCIE4zNUVR9fxf7usKQ0ig5QT
         pXjg==
X-Forwarded-Encrypted: i=1; AJvYcCXChcZvuqd8I+ykYTQXTaOfNw6gS5/iqCR2omf2YZHXyk5S1zxKPrfHdNXY0oMT8AHTztHcLg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxzOTygo8yPjiZoccZkvspDZne4QJfya+++pNJ4yPobXOyZG5N3
	NQ1DZKn/7pPkh3nobMJ27zOtekHagpvC8T2+9JXyAXDRNkn4VPnt
X-Google-Smtp-Source: AGHT+IFWznISjjxuV7eQKDlaN9b6a4OoZXrdhN32jKOPKPIhtjTxNr0Q41kQYaOLItLh2+izQfDzHw==
X-Received: by 2002:a05:600c:19ce:b0:42c:aeff:9766 with SMTP id 5b1f17b1804b1-42caeff99aamr49332695e9.20.1725889829441;
        Mon, 09 Sep 2024 06:50:29 -0700 (PDT)
Received: from orome (p200300e41f29d300f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f29:d300:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42caeb81ac0sm78365275e9.34.2024.09.09.06.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 06:50:28 -0700 (PDT)
Date: Mon, 9 Sep 2024 15:50:26 +0200
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
Subject: Re: [PATCH v2 3/3] drm/tegra: Use iommu_paging_domain_alloc()
Message-ID: <7unmvrhiydje2fqcrmj6flbvdbpexujibatpgoqcqevmuhkcgs@pa62yzobzajj>
References: <20240902014700.66095-1-baolu.lu@linux.intel.com>
 <20240902014700.66095-4-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sekau6utgzc3r2ki"
Content-Disposition: inline
In-Reply-To: <20240902014700.66095-4-baolu.lu@linux.intel.com>


--sekau6utgzc3r2ki
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 02, 2024 at 09:47:00AM GMT, Lu Baolu wrote:
> Commit <17de3f5fdd35> ("iommu: Retire bus ops") removes iommu ops from
> the bus structure. The iommu subsystem no longer relies on bus for
> operations. So iommu_domain_alloc() interface is no longer relevant.
>=20
> Replace iommu_domain_alloc() with iommu_paging_domain_alloc() which takes
> the physical device from which the host1x_device virtual device was
> instantiated. This physical device is a common parent to all physical
> devices that are part of the virtual device.
>=20
> Suggested-by: Thierry Reding <thierry.reding@gmail.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/gpu/drm/tegra/drm.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--sekau6utgzc3r2ki
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmbe/SIACgkQ3SOs138+
s6GivQ/+JSKDqhg5e7WkMv/tttd5OTC46SSL0+cobiyQfyKnv+49GXf27ORgQw1S
aVk1ecp/nPSd0KksxiAd/ZDwulfWcOZSEVKSNhhm8Ju3WrCAZcDoI7wjiOjhNK4U
o1kbLg2ly3JhXkEhPuyvfW+1pk6rNt/xcqY5NrpW8Fh6/G1K5AJiC6oCEAsS65Ak
QejXU8T/A6s4jfBOd3O23td1serVya4AAc+wJzKgGcmVsG6ELwWbJSD0rGX+Ai5a
vO2IGIt5qzeibQIP/ZSOLX0lacV028ZEc0zCK/0tgoLkk/TiMfraIO6Ay3Ok5wdo
WiLZ/VYBfsxlQO/IqlgI/WbmhwcTReCK+T46GoyFAW6fvS2TP4YQ0JGJsubrxUby
zk8Bt9oUwJcAq9LotbPSaXgHgrkbUq1Zg4AX53UoZi6n2ClKsMusqx60Z7kbKBTU
MefEmbsZaQCoY6PdDZPYHehE08YC3d0RlojHdxwrzJM2UHfn9fCtdD5HQJGnpGxi
tgNrxCPCUNa7EzE0lqRIkDM3QoBaoxAQVf6Q2uI3BG3HPBowuwXXcTayfrKPJEoP
IVZHM9lH1aEo6B2iT1zE4oXbNS8PFeJPLkzS4XEZk+Ct0ytaBLLoGykSvvk8xE5h
oSnbslewV6UY1RVPQyOSGA/kxxwOhbB9hd65dQ87qSyKaXwc1u4=
=K/dz
-----END PGP SIGNATURE-----

--sekau6utgzc3r2ki--
