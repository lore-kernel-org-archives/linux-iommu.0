Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC2330F95C
	for <iommu@lists.linux.dev>; Mon,  1 Dec 2025 14:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764598268; cv=none; b=NOR8f8gAvkhcParJ/ydCzhdM+9B8V4N+RTPer1J4o4UdpYHn1GkNf14coTlgT/fUfErG3Kx5e6RMxboqzOfPwGtb1qJuC6uDZNurMX2K1VMOyJ5IkDaqYQ+IVqn24kf/3wzv6z6gVoyFSRvDmZGVFKXvt7CpoLT8uXVGr3xDl2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764598268; c=relaxed/simple;
	bh=0Mrs2ijgX21f6ksv66mCAQsr3PSgk54buiEGY7STqEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eqPksFi7DwKK17WRnSj1WvOcdhgtyWhcEEAiUx43dCV3qFBLGVbf5Q+LnFR1wOUncekAWs3ygNz+hkg3T7ICXxfYkoC6rg7oQiddmgwFo5ppJ3ruUPd9Co73SdsJIUJgWIFN930ETFdBBeJQwlPIgItYvqhq677Q/b6/nFqAjSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SFGqHpmc; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SFGqHpmc"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4779a637712so25327975e9.1
        for <iommu@lists.linux.dev>; Mon, 01 Dec 2025 06:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764598265; x=1765203065; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0Mrs2ijgX21f6ksv66mCAQsr3PSgk54buiEGY7STqEI=;
        b=SFGqHpmcoY0FrV48Fz39NTt5iezEy8nxtUyQKcbigTR7KlxSYIl3FTqKioNqyr0zR/
         bIjjiSgmSo1d3uyBi7PQlpBRMmgl9we+FkqZ+370LwqxjKcgUwDCd3VApjFiY7NX6u0W
         U0rph2UWn+4Gh6tEMi3fh32QBDhVZYMycej7RvlviJMExM4Xbpl+C3nHiHk10f03w/pC
         OpbNETqqvqmAHqx0XiGHuAx7SqqCD7MLfAjS+bnhMfmLlm8bIF4YvOMWUxF0KllI0qkJ
         /sGqeRdYMlQt9MppMDXU+Gbj1utQa1l/D54BB8gSvFgHKMH5fJ15666qcOp1oFFVR8YN
         x1+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764598265; x=1765203065;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Mrs2ijgX21f6ksv66mCAQsr3PSgk54buiEGY7STqEI=;
        b=rC58oCaEnP7Jn58Klrswj6k34edAunnlvsPdDzD+xtDRmXc5yYQ8KLv876N//E3R1j
         9I160kwfQB5Zgk76u/eCisujWpsQEIc6TE9rMGTE8OY2U6ah5ItIDMDdfDQYp9uMl0b9
         55QXtILyIAmSUkhi/0K/s7oIX/2M8BRfj8K/zAY9EMTWGLKPO7oAjvIhqq1Cbd78TZVD
         MeYyEZ3YsASG/uWXQFTYjkayV59Rywkim+ypVdgpOBvBMNAbGcyogJMfUwNtAguEdZC/
         ZYov3CPESRebHz/pUw3gib0Lq/f36eUhNPjGuGWL+sjzFx+FUezMbZkFBbxoTR4bGfOm
         qByA==
X-Forwarded-Encrypted: i=1; AJvYcCU0SGIwZ3NK0+HypIh1oXAx6KNdTCiQO5bXPcZVmTf8NYijzdQHffY4Q2BTNwjEQKdQ6T8WqA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwA42zetpc7of6fXjwTAcE+dyWfdKh9LvG3BA2fDGYsmMbXppZu
	xUg1SUfvoOFKx9IRoAJz4NqCdvTgXovG5b/IDuvhfCu9t/osFPVYyK6a
X-Gm-Gg: ASbGncuDLL0OefYhADCzB+I2X3sX9LoI0PsFFC90Q8R8RO7H4SAdcNu2LTqA8Mu58H4
	tM/xRUpa18pWDdmxCZmaiuaiD0SNg2dK6nRvq6WSpQ0nVqX3l99p40Cs5N+UCqbM9PPPhZmSJ4Q
	9SCHXY4RgM/WoduDM8ioYA4xizCQvTuQL7mAfZkaZ37zjMqPSjLZTJ+OqXSw1q3BTFZ+H7nHdKz
	V/47utSRrBRf3bVL1fKipRp10RFyrl+ScaTGxHQIAi0fy6R1AGFSfLCjlKjw3M1w/r/+t0+eRm+
	j6rK+/kC4L/LC0OHcJYnDdFOfOBs59EuTD6Y3Hn8q5SMc+zD6Dqlp4YVyBwScVSd9POM+7JFNpy
	fvE9ychf5Nh7zEZLqaCjWX3UOixIUOOTkVupbht8UU/nutmHt0z0kkO5xEWFJYzt0P8yKrdkFhh
	ZoBvCUX+EBU0X9ZUr5hIge9ZsOwEogzMVaPnPt0NcrEiIxDLepi6EF5ChuoRyo2u7V/WdG3hOEj
	Q==
X-Google-Smtp-Source: AGHT+IEE6nJwSv7GJv5Tpq+9BS1wDZGt0pOH46cSqLXpdpti1ytJV7Lap5tpsWVi/xKgs1f9pxSxvw==
X-Received: by 2002:a05:600c:3553:b0:477:7a78:3016 with SMTP id 5b1f17b1804b1-477c0170782mr399239025e9.8.1764598264581;
        Mon, 01 Dec 2025 06:11:04 -0800 (PST)
Received: from orome (p200300e41f07e000f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f07:e000:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4790b0e21e8sm323578165e9.15.2025.12.01.06.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 06:11:02 -0800 (PST)
Date: Mon, 1 Dec 2025 15:11:00 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Ashish Mhetre <amhetre@nvidia.com>
Cc: Jon Hunter <jonathanh@nvidia.com>, will@kernel.org, 
	robin.murphy@arm.com, joro@8bytes.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, nicolinc@nvidia.com, vdumpa@nvidia.com, jgg@ziepe.ca, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH V2 3/3] arm64: dts: nvidia: Add nodes for CMDQV
Message-ID: <r2mkiktazyn3nvhirbs2ac7n5ymdw62ueutpxt55cnivdi7pdn@6i4hjtvxp2ph>
References: <20251125071659.3048659-1-amhetre@nvidia.com>
 <20251125071659.3048659-4-amhetre@nvidia.com>
 <dff3a962-82dd-4aac-ae11-69f0e95ba04d@nvidia.com>
 <acae92d8-3394-436c-be8e-8bed7a923e85@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hmgu7kapjngbyggz"
Content-Disposition: inline
In-Reply-To: <acae92d8-3394-436c-be8e-8bed7a923e85@nvidia.com>


--hmgu7kapjngbyggz
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH V2 3/3] arm64: dts: nvidia: Add nodes for CMDQV
MIME-Version: 1.0

On Mon, Dec 01, 2025 at 03:06:55PM +0530, Ashish Mhetre wrote:
>=20
> On 11/25/2025 3:52 PM, Jon Hunter wrote:
> >=20
> >=20
> > On 25/11/2025 07:16, Ashish Mhetre wrote:
> > > The Command Queue Virtualization (CMDQV) hardware is part of the
> > > SMMUv3 implementation on NVIDIA Tegra SoCs. It assists in
> > > virtualizing the command queue for the SMMU.
> > >=20
> > > Update SMMU compatible strings to use nvidia,tegra264-smmu to enable
> > > CMDQV support. Add device tree nodes for the CMDQV hardware and enable
> > > them on the tegra264-p3834 platform where SMMUs are enabled. Each SMMU
> > > instance is paired with its corresponding CMDQV instance via the
> > > nvidia,cmdqv property.
> > >=20
> > > Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
> > > ---
> > > =C2=A0 .../arm64/boot/dts/nvidia/tegra264-p3834.dtsi |=C2=A0 8 +++
> > > =C2=A0 arch/arm64/boot/dts/nvidia/tegra264.dtsi=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 55 +++++++++++++++++--
> > > =C2=A0 2 files changed, 58 insertions(+), 5 deletions(-)
> > >=20
> > > diff --git a/arch/arm64/boot/dts/nvidia/tegra264-p3834.dtsi
> > > b/arch/arm64/boot/dts/nvidia/tegra264-p3834.dtsi
> > > index 06795c82427a..375d122b92fa 100644
> > > --- a/arch/arm64/boot/dts/nvidia/tegra264-p3834.dtsi
> > > +++ b/arch/arm64/boot/dts/nvidia/tegra264-p3834.dtsi
> > > @@ -26,5 +26,13 @@ iommu@5000000 {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iommu@6000000 {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 status =3D "okay";
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cmdqv@5200000 {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s=
tatus =3D "okay";
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> >=20
> > This needs to be ordered in the file according to its address.
>=20
> Hi Jon, Thanks for the review.
> cmdqv nodes follow same ordering as its corresponding iommu nodes.
> I have added them immediately after corresponding iommu nodes.

No, you didn't. It seems like you sorted by type and then address. But
we always sort by address first. Type doesn't matter.

This node belongs above the iommu@6000000 node and after iommu@5000000.
The same ordering should be respected in the DTS include.

Thierry

--hmgu7kapjngbyggz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmktofQACgkQ3SOs138+
s6EyLhAAsTEU10nghdoSpblIcVzJ/qhmjr7WspdOv/UxyNC6yGc32tbPTSMeeGKB
ojvenyoNPugSaOyLZXSFTl/kpTKdGcoCkegC04uNDzwhNYdBeqEmWQBcWAA726Br
KavTOQhDpPmV0XdPm1lDVjo9xbNSDasetodfY48k8vfJCf4BEdBCAY3LDzvzdAQ5
m77dDHC0z38Ytkjl5kbQsuZywmE67pYDtsOV4kQ0dZiZXBKWzJVEME92ADY5t2Y1
MuLoASC1ETuEPnpjMJ1lU+1QTUiDN7LlgDiQzRkR/MkBrw+GbaUrwhzh0pNB8xHR
BS9h/RUC8wpaiDulhMEq8ZDPFsjHkH3WlGNv7vC4HspcUhzkzaT8PFSfuzcHYSNr
gddqDlRd9cpPkoqPVT9BLfX8VPeIOSz4vQp8fr5OlM0gNVS71Dlr7qr8DNQo9JbU
hZ0P1D7clUrw5gCGXcEDHLtpesD+jOswALr64iahD1xGKEDcUsZIM+DLgmFjuuU7
sRcKhRF6Y0eroL1Skol2tvZ6iLrTRXToACMtXiR3HGPAtiU4nm04EC8nr1WVbNYL
qjfxz0QXACVToYJPxQVVcjZ+uLMBtBR7rVsd7Q+A/NeBPwctkw3/+foLMmRsP6jw
AuvrP0nzagjXuL/UJEOYw9YYgbg5e58q8OG1mWmjeqKRcU7JmN4=
=78kF
-----END PGP SIGNATURE-----

--hmgu7kapjngbyggz--
