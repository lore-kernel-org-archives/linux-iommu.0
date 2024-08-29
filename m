Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004774084E
	for <iommu@lists.linux.dev>; Thu, 29 Aug 2024 15:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724945118; cv=none; b=kMfT49C6KyP2nvOUdwBX8q0mj5cNfVBPukMyjZ1K510y1D/N6qlF9WDHmdFe3j5mZdubuEgFLrF2LOSS3EGTb92L3o6C3jAXab5getKN8MBLbUCIH/FTh/Xp3yEIynwjPC6QCUd+gK9K+homkaacsRqNaF9ABBNrzieRUuIDg44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724945118; c=relaxed/simple;
	bh=W5GQhkVjz2wwdC5lXitoDCDre3m21qvN2+9J1ktg/iQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CCeBhvOO4/roSTwe6K6usqLu+IsRn5Rz1nqdMswJ0fy8DX6juH3/VkTk1m3LRMcyRenHds0C9SpqeEM7ER37HrwHrtenFwOIGq+ZNaX7MmWFNtdMgnAUXp5TjOgpQt0vNzSirAsQ28coWfCEUgwiBMdI0urME5LW2EXTe3nvXPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DR/6iKaN; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DR/6iKaN"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42bb72a5e0bso6487775e9.1
        for <iommu@lists.linux.dev>; Thu, 29 Aug 2024 08:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724945115; x=1725549915; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3CePclmUlJ9R5wUKygyM22ovfabY44x27bhlzsShvYo=;
        b=DR/6iKaNPCwYTRIb6C4ZhfZySlAimjkx8fMNmFBI/atiQgf8dDwn7n582xuiV1pfSz
         FhR3g2Q1Qy2uokq6EEuwzgacGOgsmiwG8HGeig3E+iwqygQmHiSCZrP2BMK1zqP6Z6Kn
         ZZaXpsUPFXjsDTSj5hfN98slQljouSIafqG/ELlbRth1MYBrX9g+nRwKRK2owabks/VM
         /LrL3S9eYDRSVPlc0kFXMZwVWtgqzlkB6WQN8cRrIyMsr8Dps1P+QXQ2KLdzocgTWo3X
         YrnH+jDZcC2vO5SIGN98xvaI8AYNq/S+gAyjg/S+qkOjQ/6VKpuuuGNmueRFZjdKXLm9
         O7Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724945115; x=1725549915;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3CePclmUlJ9R5wUKygyM22ovfabY44x27bhlzsShvYo=;
        b=ok40UtX8UaLW1jwXhTe3MKrLdmLGx8XSk6fOBOp6YudXfqDqYTCBEp6JX86AsBYHYQ
         Lk786ktvvyES2p6zJsb0IpxZQGewV58E7NZUiAk9aZluLvDsq2WUGJLHMP9VvASQTMIP
         0H/9MR/A1hl0652Y7u2tjdENt4Q/aRRMg6MceMlAE//ky+mD5UF4dy0aueHshIH5qNL4
         CDhsEv0Nftj0dYIv5nEOgCTGg9IrcGutSDD9lzLzxmYATvJG5XtYICrryH10fAzEMEPN
         bBnkK4xOVGbKoTvbyxp6myFv2vKLANOYe935rD443t5rhdyZ4nIpDSV1BTs/5KsqaWfo
         IjWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTHdPl3DHFUlkzog/YNYnJS1/qGTZLqHmpf2eUYLACLAS712tcSFgVOb2hAlLB66HwqGT2FA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxsXQwlDOzThz4V/zJEUTlAwjQC7YEFQfE9zD4qk3LFP90//3jg
	28uIMtLFaCVAh2P1U7eLguU2tDNeZhIftvqJf7OeZacoF8NCA2vV
X-Google-Smtp-Source: AGHT+IHB9DwVQH+LaPCki7l5s2XbNvXlqbr5f4VqUYxz7BdDtbuqto3Zl5PtmeS+7pmQVpMQVL7Cmg==
X-Received: by 2002:a05:600c:474c:b0:426:6e95:78d6 with SMTP id 5b1f17b1804b1-42bb01aa1fdmr26574845e9.4.1724945114644;
        Thu, 29 Aug 2024 08:25:14 -0700 (PDT)
Received: from orome (p200300e41f29d300f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f29:d300:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb37f7849sm25800085e9.7.2024.08.29.08.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 08:25:13 -0700 (PDT)
Date: Thu, 29 Aug 2024 17:25:12 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Dmitry Osipenko <digetx@gmail.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, Vikash Garodia <quic_vgarodia@quicinc.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Kevin Tian <kevin.tian@intel.com>, linux-media@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH 1/2] media: nvidia: tegra: Use iommu_paging_domain_alloc()
Message-ID: <2o6gpxknio4kvf5fmqgai5jaov65semmw3wvtmt4gdauwzhbti@ii3ydtlmp2sb>
References: <20240812072105.9578-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cowfqq5j65e3ovof"
Content-Disposition: inline
In-Reply-To: <20240812072105.9578-1-baolu.lu@linux.intel.com>


--cowfqq5j65e3ovof
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 03:21:04PM GMT, Lu Baolu wrote:
> An iommu domain is allocated in tegra_vde_iommu_init() and is attached to
> vde->dev. Use iommu_paging_domain_alloc() to make it explicit.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Link: https://lore.kernel.org/r/20240610085555.88197-9-baolu.lu@linux.int=
el.com
> ---
>  drivers/media/platform/nvidia/tegra-vde/iommu.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--cowfqq5j65e3ovof
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmbQktQACgkQ3SOs138+
s6EUfRAAme7fMme4dA56e6MubG7cFGGWr8iHzpMLzb7Gxi4bRxcYB/Gtn/cepURr
Ybbn9lG86we9+zbd+FNlPWTKXxFFZG3kDfKnU4eILM2y56SQApilQzwwicdOgN5a
7aqDJu0/eEIwagudME6HYDlALal0MCib/UblMbReIP7XnAcrR+HhO1aRMy95l6P+
xYD6VzW7evnIR1BRkz5CHS9Dgo7o3ykNsGr0wDkYjK6oFjF5g9Y6LZCZIRO3sZxe
jqijysA0g9cAk+NsDNmWKbd0UEMM3DX1ROebrEzbBkXC9+PWe56LmP77zigyPHVr
aVXBy9edGGmkJfKvwvkJJLAs3wpjN2cHVO8zPjg2bntFR5VhAPgMo7RJKt4Tj/A9
rEcmcaPggDUVVgJEbogj1zZtpeTp89+56tGcFjJvMi1sVbudisnejl4aSfx/Hnzc
4QKrj/ajGfmJkPJbjjUEIzTSV+Z7L3M06jC9eLrgKzURdymvDUAPuVaZWkPcT/DK
hqiTAVU43r+yr40ZwRoxyuHIQLxGIxmUtnjk96uQhKa7bs3loD4KR00EIX590fGL
cRL3yZFx2G7ILQ1Cnru0vXA3iF9RxG1eikHZHtqTPsInPseAMx6QpE0Vn0I/gT0G
S/cBJhFE3NxmP45u2DKKrhq7+pRf6AEpKh1tnwZoB6NIx5cwGG0=
=3ZMs
-----END PGP SIGNATURE-----

--cowfqq5j65e3ovof--
