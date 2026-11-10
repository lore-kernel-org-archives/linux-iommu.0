Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794322330;
	b=i73TCncIf3xHMJnKU5A9UtENOmRAhoLzCL7PyVYyM0GJfICsPGTVGfdaN2xE+2/FY7q6
	 CH/4K5oqTdggivXKNvA0vxXKuGxqah3LJi+E+oLIe04ecSKRHrMyoybrRM7/eyzb4ZLVk
	 87VSjPCaXP4Byzrjfty2zCvjIU2sa24eou9QPCeRXx/nMRY7PV55Hu8i+C5dID0Ar8bog
	 K7LcjwAGJrVmbYQD2CP/Vx+Rvk2e4EUQivrfVI/yvRYJLbj4VktXYyUNwlbcgY/TSIBAR
	 cAfFQkvFkhQ8oY1fN0224Q1gMB0h1/X9QZAbFH4Puuq+rm7DpmWH/+YmTryhYV/zX+A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794322330;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Zoho-Virus-Status:X-Zoho-AV-Stamp:
	 X-ZohoMailClient;
	bh=nIm3ALQw2CLFEdC+FIJT+UWO+XWiCkX3Jl5z6pz25Lw=;
	b=2iHheBQwKZJ859oPmi5oNVO7fxMTWaWbb0jfUIOzoaWy29XVaWgM1TMu6EWjFAq7BDRE
	 ka64pN5fOuq49jLmUXU2qumUxNmPrYSFCYwWhD3FTkXZbVT4pV8/dhsiMchUYIO2RNyyT
	 vTQTnJNrefRCQwgwy1U+y/KDvUNLFaA9+W3cb/61CN7fuh5i0Pw3PvuaCZWPMGzfkj5++
	 U7DT1jjuKWap8cS4dyHEW+JGJin5yrS0hoyt782vBk6CsnzfSt+0pmo8GNEEhGFbXwYGy
	 apE8EBeR3wg7qJ7BP+bo/GAmniZViAti8I8atxbLo4B3XPTV5FjwK6HyMTAAVAjk99w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=aMZJcmnV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.11
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com [165.173.182.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F76606A31C
	for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 14:52:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52F76606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=aMZJcmnV
ARC-Seal: i=1; a=rsa-sha256; t=1794322317; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=IES5w9/rUmQUIOSvczKB958G9ik3/KHQOdqZIpBImeiL6/DiyiXey9VoKv7eSSR//k6c8Fw0ubhAX3eutKWdaQm+KuBtR00hvQuaDMCFAvgg+s4IAxKfAFIX20MW+yKqOBKVdgvqkTmOVaw2rB8WPPnH01qLjyN/0xQuh4lonLA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794322317; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=nIm3ALQw2CLFEdC+FIJT+UWO+XWiCkX3Jl5z6pz25Lw=; 
	b=G9yyZtFQYlZJTLFV0v3bg3BtMw3vkmi3+Poehl2oVa7CSuYF8dGEw/a8aUIy0/4IKr1R0wdNDNCGA2GijuVP/LJrrBnmfKrXPim37YeqeG7MDroFOJ4CvPGazX4JZmOhi+8JsK59WZKRhcQVkDWdzuUedf6LuuFtz/a2OEFdBU8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: a=rsa-sha256; b=aMZJcmnVNEHIWb8uXyKM728ieo5RiRGM1+v6GUx2I12YzHcAOTMRGrUmWeIx092Qx2aaQKx4J0j3zaJJSCDbDa6Jm8SynPbnlTZonYnMYZL0QwpSQIbBqCbpHcIsUMGRAhvQdoQ8pNLIlLckmZBw1gyZRVnn/HDBlOkYnVM97Gs=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=nIm3ALQw2CLFEdC+FIJT+UWO+XWiCkX3Jl5z6pz25Lw=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794322316098419.50846392536164;
	Tue, 10 Nov 2026 06:51:56 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id F1A01180354; Tue, 10 Nov 2026 15:51:46 +0100 (CET)
Date: Tue, 10 Nov 2026 15:51:46 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: aiyengar1990@gmail.com
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	"Joerg Roedel (AMD)" <joro@8bytes.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Niklas Cassel <cassel@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 1/5] dt-bindings: iommu: arm,smmu-v3: allow a power domain
Message-ID: <avMvRiHSp_7d8oD3@venus>
References: <20261110-smmu-v3-pcie-pd-v1-0-628819ca44b9@gmail.com>
 <20261110-smmu-v3-pcie-pd-v1-1-628819ca44b9@gmail.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tfqghsv2wlsgx7bh"
Content-Disposition: inline
In-Reply-To: <20261110-smmu-v3-pcie-pd-v1-1-628819ca44b9@gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/294.310.16
X-ZohoMailClient: External


--tfqghsv2wlsgx7bh
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/5] dt-bindings: iommu: arm,smmu-v3: allow a power domain
MIME-Version: 1.0

Hi,

On Tue, Nov 10, 2026 at 07:11:48AM +0000, Arun Iyengar via B4 Relay wrote:
> From: Arun Iyengar <aiyengar1990@gmail.com>
>=20
> An SMMUv3 instance can sit in a switchable power domain of the SoC, for
> example the MMU-600 in front of the PCIe controllers on the Rockchip
> RK3588, which is part of the PCIe power domain. If the domain is not
> described, nothing keeps it powered while the SMMU is bound, and any
> register access after it has been turned off as unused stalls the
> interconnect.
>=20
> Allow a single power-domains entry, as arm,smmu.yaml already does for
> the earlier SMMU architectures.
>=20
> Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Greetings,

-- Sebastian

>  Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml b/D=
ocumentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
> index 3c044e4f03d4..c8f22dfdb1db 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
> @@ -63,6 +63,9 @@ properties:
> =20
>    msi-parent: true
> =20
> +  power-domains:
> +    maxItems: 1
> +
>    nvidia,cmdqv:
>      description: |
>        A phandle to its pairing CMDQV extension for an implementation on =
NVIDIA
>=20
> --=20
> 2.55.0
>=20
>=20
>=20

--tfqghsv2wlsgx7bh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmrzL34ACgkQ2O7X88g7
+pqJrw/+Ltixuq2mwS/7jblulvQQALfQna4bWRC1zreexGhF+leoXqP9JEMhCnkp
Vr3wOBovLKA//DQokcLKXgDGqVS21CBMdTAEp2Gc+G0N0VHZzdSP7i3QCkr9qNZI
vPm9hifWU277QF5SgT/YCR94Jt8m46KSkFNiaeq2dTUBi+/TpYO1y1UxvNnlBm8H
ySl3PLGGBj909ezmEy12KLVHxYAPM3SKAbE6dr7Uyo3B2yuMp5uY1TPdYbJpNi4+
s/qBdbgxBqPVWVhRspqwjcJKpc2jnv1aLQjZsHCulAxY6iOnGscDwHgCnerj7xw2
XJOJ+cmGi2CvqRYloutaEx3DFDW0ANLaOvxLBe43c8jwuDP72eeM+Bl4JnNxQOZX
uVu6498a/JQxBCXyo0IW/vEUQ/VhCo6bG7CaLHIWmuX/gVH0DNCuz43JFInaZaCz
lHffjGUeQNGigfx+zlTTu1Ng0rqBA6qKnva8gOUE2AvFkWD3lYh7MWuZWy4Foz6i
g2FEtxt2CfNYpzm6/XE5Sp5ayNqO0l3N2Y+m2W413Ae8Pe5dmtZmNekDmJOLKzYq
PWNKmQ16cANFsiA0Zq8fL7p4EArT1cC7o37lWeKdJJdodL+edfTFWmee0YmmrTOA
lsBVO1mkefW/Kf+L2CL8+DoN0EUu7+qa7rVBLxOlkPB+b3A8UsU=
=xEf6
-----END PGP SIGNATURE-----

--tfqghsv2wlsgx7bh--
