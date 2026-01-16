Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85196225A38
	for <iommu@lists.linux.dev>; Fri, 16 Jan 2026 12:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768567488; cv=none; b=qAS6Eb4b4LwJbXoXm5WU1N+1Yc6Mbr+XCZfqRR27xoztDg3gfIzE7qgxWx5G2SdEja5gR69mj+wLbkC87PlTOICx/5rkgxYlWNb4ihGd9vvnNsps1jh9xupaAFwQsk1YaLVRWW+IP8L7YVY5OoAkwOT9+1Yq4aKxvh/N8v7mZHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768567488; c=relaxed/simple;
	bh=408DwCq9gASo4Vyk9YR3/taKUiVRWEuSFIGtx754BN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pEfvkhgQWRmYBd6NBvQCCHcoAoV2Sc+nL+YIrjw/BwD1PsHbQZSL94BbJtu6+FrMT0v9IQNgktRfA8JFO9Q4kIbzd8TgRXnCMWWifWjR4yFLu8pNgVjoC+iXyfCiod0oIz+JcRa9nGzcSm0Kb0twwBRAEV5OJ4ft6n6luDTsQH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GODTTTE9; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GODTTTE9"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2b4520f6b32so2708805eec.0
        for <iommu@lists.linux.dev>; Fri, 16 Jan 2026 04:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768567483; x=1769172283; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uz8SRiw4IfjOx53ckfZ2h9xJeTMYhUuFqjQyqdesaBE=;
        b=GODTTTE9MO1JOIAyvYUeAFWfi0pxMt/vfpMXN+GyR+VC6BSFTQ4bMAsHkur8KKHQMM
         RPw2pcan2c90C5H9/RnJ3ZW/wgtBMnHD2Ci0kjorhgU4lm2D+tLJtkh8cgapgStV88W6
         NYQ6uxvWYrAIvBoj4K8+v7J6XnXLJhWtDrEtlUjNO4nLr9k+FVtoYLQmOJgdWTHUFCKv
         W318hQHIjsrW1b/EzvCrd/bKBvD/gjlLssMOu8MS/PgnW2rh5rDYJZNhpct/PXdIMFqt
         AnCLU2S80su2aQhqCHPm7auBE/KR3j270kyoHJSohfiQysw0gnffzVhvARGDAMeuI9Tn
         MvLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768567483; x=1769172283;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uz8SRiw4IfjOx53ckfZ2h9xJeTMYhUuFqjQyqdesaBE=;
        b=Gz5Q27X1OS7tcos11pFuS7vS+5wWQa+llGnRyJfpbiDc493r0nHpFXYdbzDvusZWA9
         t8gow3GO1gh2/qfUzIJ4ykcjMy8dIFN+pOgHXomucp81XRRf1xANHYVZ9FffkWxnF39n
         NNv3lwllbi9Jp4BDUOJKwmWoJ9KX+wKPULPl09KfXJLkh7ECNfqOug/9kqTf2K7ujeaQ
         rVNOOeeePQTTNb12vsTelqpRsJ8/35JTUGXIGnmD81IysZa5W0v3SmpskvbpJ+WKFBUV
         ya2KyDlAZnH0Rq9xOlTnDUPZUE0K5C/Mf+QAUlrgvfTA35PyrRByAxWV181wwxNJtCnD
         viTA==
X-Forwarded-Encrypted: i=1; AJvYcCWHVdairoxiATD6lYHnm5yjMQ5jz/Ppr4ApKJecvdflNqriEU2TKwEuh/ZrHDPW6m/t0eEt5Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YztE8PrpcjvZcSjP/EhyDOACtOuqtYhmb/jkZzZYCqPM0LllcDl
	HIJVJMO/+9GDg8qcguW2vB8blg7mSWMpz0tDan3ulxcX6cQAly899mFA
X-Gm-Gg: AY/fxX6L/NN2hpw8veYzzSZEAoBmWfNYGClvAEg1lX7WTjMxDi2n13m09Y3/gATN4VL
	ttRU/cVdREbvLvcKXtgGuGAbyNOyVuu01GUwUmvwmYRIb6RAtG/gEWZ6qcH2JpMUijk2E3XKUnF
	TjM9AUUgP+4el+IzzTApoH/WNV50yLxzRKlYcgSqTS0C4XbKIjX0H5GhAHV8vW5wTZY0rcTOvbp
	6GS5sk1HCc5lEY50PPlnW+FlIXKjwUJ2uJSoXPYP4P/k/Q3FMjooBVnOQ89bkExD/pYY4EUkx03
	TFbm/28j2JitN9P7HidAuuIemZyThlQQBXF5KB7PaVDIf6Nk3+zEVhRHQKnJ9T91SlVRQUME068
	bIYiSvZ7cyLJ/dqNPvVtasmCiPFBZIrYlEewTS1zIX1/ut1SngsL+EFNRboxSdlLkvvCZiAyOL8
	Crzs/C6NlMVH6HJ1YiFcbuM09idFFbaABeABvvGWTDdR378kjFAzOObV1rqMbLxQ+cP9z8p7cXM
	A==
X-Received: by 2002:a05:7301:3f16:b0:2ae:55f2:ad57 with SMTP id 5a478bee46e88-2b6b40f01e5mr2028389eec.29.1768567482726;
        Fri, 16 Jan 2026 04:44:42 -0800 (PST)
Received: from orome (p200300e41f0ffa00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f0f:fa00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b36564ffsm1810021eec.28.2026.01.16.04.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 04:44:41 -0800 (PST)
Date: Fri, 16 Jan 2026 13:44:35 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Ashish Mhetre <amhetre@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, nicolinc@nvidia.com, 
	jonathanh@nvidia.com, vdumpa@nvidia.com, jgg@ziepe.ca, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH V8 4/4] arm64: dts: nvidia: Add nodes for CMDQV
Message-ID: <aWoymh04hKXsADa-@orome>
References: <20260113054935.1945785-1-amhetre@nvidia.com>
 <20260113054935.1945785-5-amhetre@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4oau3igknnhri5c2"
Content-Disposition: inline
In-Reply-To: <20260113054935.1945785-5-amhetre@nvidia.com>


--4oau3igknnhri5c2
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH V8 4/4] arm64: dts: nvidia: Add nodes for CMDQV
MIME-Version: 1.0

On Tue, Jan 13, 2026 at 05:49:35AM +0000, Ashish Mhetre wrote:
> The Command Queue Virtualization (CMDQV) hardware is part of the
> SMMUv3 implementation on NVIDIA Tegra SoCs. It assists in
> virtualizing the command queue for the SMMU.
>=20
> Update SMMU compatible strings to use nvidia,tegra264-smmu to enable
> CMDQV support. Add device tree nodes for the CMDQV hardware and enable
> them on the tegra264-p3834 platform where SMMUs are enabled. Each SMMU
> instance is paired with its corresponding CMDQV instance via the
> nvidia,cmdqv property.
>=20
> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
> Acked-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
> ---
>  .../arm64/boot/dts/nvidia/tegra264-p3834.dtsi |  8 +++
>  arch/arm64/boot/dts/nvidia/tegra264.dtsi      | 50 +++++++++++++++++--
>  2 files changed, 53 insertions(+), 5 deletions(-)

Applied, with the tags rearranged and the subject prefix fixed.

Thanks,
Thierry

--4oau3igknnhri5c2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmlqMrMACgkQ3SOs138+
s6GZWw/+PsfThyygUX03IXSU8Jsrup/oODhWPhvKjNgijz6nnSVFBhA0BA5ikMoH
FCIWEVLZKqW3QA6ftDE8V3MnYh+JPY1qW0g55q5jFthi1qtwtbL+WlMvvGPqulGx
8XYCYkYrtzg/PEx+UJi/0DP0i0BNCCCSSx4fTNDxUqpNdre3oGyD0Ac8eF0xkp90
JLv76ggCT7UX4MNuXEGGs4ndCBYlcOeO1wDkkDd8ZfkdZU8qAaOnvM4TNRocSZIU
imgVHUIRNXnaMOB29ykaxvAjah65rbv//4inrVutVTLepKoH/rT/p2ahSUHG3JIZ
DAssTp4AUCO2Ovc4CGqPBw5ORMs3TdKnKFGqyQN718EnSGmJkzwbWZ0Z1Q+FJrdN
s2RQXxLdL9ZGcu3tBm3/5j5If5VRvNo5aTc2IDhjeKsrVRPttCw6FBZfbxHcHj0M
UZls4LAAes/RnZ3XQDrUdf6mIgoOZnx70Dy5BfulONNoVf7SxE3yZGR0h02q9EVp
kJlCh9VuoS0aza6CpWY8mv6Gam171pC0VJABduWXeCfxKW0uqDIce7EOrppXT1/w
7XMvcfiSfopGB83vO4ulQ3rTPvot2fbJnm9JHrYPdnYwkDPFRs+zDeDSr3Ub/iZ/
U5J/FD1YV4AsdQfuwEDWkE8URTqex7eqUWg3i2yKHe2wZBYHb50=
=R6HJ
-----END PGP SIGNATURE-----

--4oau3igknnhri5c2--
