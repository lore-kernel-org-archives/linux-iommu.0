Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794501212;
	b=omRDD9awWhLkcj0FoJgXh+H2akhBVpFCtUYzs5PW/wNnFDPdP9mJRZcQQ5drYBnG3OTL
	 gjiRBOGNG4RZrrvHrrGASnP5qcfKra0/lTHoKIvp50TbBie4CnPrc/FYWwOmFWog/eUAF
	 MlBPjAhLcnS8NDyDYyq+HhKJRSqGEJOL8rzQuRhRfy3GgsmQfcMWR4oaHVo0h8aKD71PR
	 QxY7o2E8HB3blX8xtjqDQdGbJLNUORMuWPbI7jzp3tkzvfyXUJTyyhJ9Ql+EbG6Ux5HQd
	 rcv6DTfJd9wBv/H7vHdrKlnsB1cjZHgdgYV22u8O+woDpLVRYh/2diRqKgZK7FwGGLg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794501212;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Zoho-Virus-Status:X-Zoho-AV-Stamp:
	 X-ZohoMailClient;
	bh=Q/dnwQIhA8Sqe3WS4uwxB+IGEIoincQaBjNIe4lg0SQ=;
	b=J9DhSWwc6gTk5l2bAKFQZuMdkXQ9I5ePB9u8ZR8VjAwb9xOtTgSJnHOPQs+0jU/MScug
	 rY/wN1ck9djXrwpE6KXdrb+cDKrmIvaEzJwkvTxk5kQlF6DkihjMc5eCLgIdxb+C4aFXy
	 l8JcD1PnHWpgDUW+cxhObUpcB6j0n7dDCqBWPNK1XKILjVUGjGBFwaf5HoPzXc7NdrmX5
	 nV4SJYwk69T02I1A+sEyoxvM5NhTAiHg3zfFvH01B+ba8RJm5kOwPr1UUIOgQr474P1cP
	 9LU0wyWlqIL2mOmJ8i2plDzwNyuWK78QMgaJiKtULKeY6v/Vkqb8zV7CkZ8hlnnZK7w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=ip9ePaPo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.11
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com [165.173.182.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53F9606A893
	for <iommu@lists.linux.dev>; Thu, 12 Nov 2026 16:33:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E53F9606A893
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=ip9ePaPo
ARC-Seal: i=1; a=rsa-sha256; t=1794501203; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=TyXFnpzt6dEn7SYZRYX9LBDwUMJG88UPvXAhu+jvP4b5K+gCdAr/syvn4RXC3C4jlxNzgPt48zf10avCykyl61Pxfg9VxRNQ9qW0Bhp8PlX7zaa3tPAEHg45ps2HKNFcHyqN8NcXOyuK76PvUxqT5CQ2QLRKVmxGIixgGRD3ALI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794501203; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Q/dnwQIhA8Sqe3WS4uwxB+IGEIoincQaBjNIe4lg0SQ=; 
	b=FYeV0xsv23iGhQRJsEl6egozOrqON5Hs+1DEvzxrPFhE0giGXnyydeA+H4uvU0eP27XOGT9QjhmbodMjSZaGgahitwsGi/J7iN3CF6PvfQdf//EqijbNMCElZGOCzIe59VipzJNXeQfzDEdreDvSs/qwDNH7dmIkDvOX4k0qH0Q=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: a=rsa-sha256; b=ip9ePaPoVY3ZGfrjNpmVgomklprEC4o4roC1mcA+NBvqB1udzuz/z6o0nXkhFtHplLQBHB033UxNnzoW5Log1fF8+y8V/j1wVXq+/AIVeAFvYdFLTXmmmob7d6MYWDTgPMujwzN+ur/vT6ibOLa11Ofo9jehlWe9PDTFjwdTyxQ=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=Q/dnwQIhA8Sqe3WS4uwxB+IGEIoincQaBjNIe4lg0SQ=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794501201770774.608247615585;
	Thu, 12 Nov 2026 08:33:21 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id EA777180570; Thu, 12 Nov 2026 17:33:16 +0100 (CET)
Date: Thu, 12 Nov 2026 17:33:16 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: aiyengar1990@gmail.com
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	"Joerg Roedel (AMD)" <joro@8bytes.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Niklas Cassel <cassel@kernel.org>, 
	Pranjal Shrivastava <praan@google.com>, linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	Shawn Lin <shawn.lin@rock-chips.com>, Simon Xue <xxm@rock-chips.com>, 
	Finley Xiao <finley.xiao@rock-chips.com>
Subject: Re: [PATCH v2 4/4] arm64: dts: rockchip: Add the reset of the RK3588
 PCIe SMMU
Message-ID: <avXqMZkpY7d0sbfR@venus>
References: <20261112-smmu-v3-pcie-pd-v2-0-3a77bbb6b2c4@gmail.com>
 <20261112-smmu-v3-pcie-pd-v2-4-3a77bbb6b2c4@gmail.com>
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
	protocol="application/pgp-signature"; boundary="plo7cdziw5qygczc"
Content-Disposition: inline
In-Reply-To: <20261112-smmu-v3-pcie-pd-v2-4-3a77bbb6b2c4@gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/294.497.36
X-ZohoMailClient: External


--plo7cdziw5qygczc
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 4/4] arm64: dts: rockchip: Add the reset of the RK3588
 PCIe SMMU
MIME-Version: 1.0

Hi,

On Thu, Nov 12, 2026 at 08:20:25AM +0000, Arun Iyengar via B4 Relay wrote:
> From: Arun Iyengar <aiyengar1990@gmail.com>
>=20
> The MMU-600 for the PCIe controllers (mmu600_pcie) has a reset line in
> the CRU, SRST_A_MMU_PCIE, which its node does not describe. Add it, so
> that the node describes both the clock and the reset of the MMU-600.
>=20
> Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
> ---

squash this into the previous commit.

-- Sebastian

>  arch/arm64/boot/dts/rockchip/rk3588-base.dtsi | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi b/arch/arm64/b=
oot/dts/rockchip/rk3588-base.dtsi
> index dfed34a8aa57..45c1bb335447 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
> @@ -560,6 +560,7 @@ mmu600_pcie: iommu@fc900000 {
>  			     <GIC_SPI 367 IRQ_TYPE_EDGE_RISING 0>;
>  		interrupt-names =3D "eventq", "gerror", "priq", "cmdq-sync";
>  		clocks =3D <&cru ACLK_MMU_PCIE>;
> +		resets =3D <&cru SRST_A_MMU_PCIE>;
>  		#iommu-cells =3D <1>;
>  	};
> =20
>=20
> --=20
> 2.55.0
>=20
>=20

--plo7cdziw5qygczc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmr16kgACgkQ2O7X88g7
+ppxMRAAj3Ltv4ErhZU0f3wZhYPQJhx+mkY3nlU/L6SyJGdIyiP+f5sNRq1yS3PC
uFjSX4M0IV7s6bymiCkx5mimtXcqWnpJZREgT5rE/pn6qA2oEbSvaV71cPBghWMp
cMCpa6RU7UME/Aj2laC7m+FhA9n6HUGYRchQQbSmd0y+bh6QJq2eGNstI0+1Jl8a
xgKEyVomPUWe6U+/gvO+f5huDrx8A6AXYmvP/u+1W2pIYcl7khGjb3RimLjhN//o
IlsoSB3yFBwQsKDJnQBlaCukfQfCaMRFjH6zvIsFMiic2wdLKWTdnDlsFwXXI3HP
Ckxh7FkdAZmT0FhKm+AkHBschqSqzZTfrHfhy9SrOZgXWOTz1jQE9nIurWtjnyco
0BtZjwgYCXWMIEOfV+YSrga4BvooysTtTm9/5FBy/YxY1LWjVMYf/73np8yJ4LYC
yiaPA2M3PfhrK3Pqwany/VxcqF0mgh9wMynwWMmJQXesRv+ECPHtLz+dZ6Ib2pcs
s+rN0hjEsm8tRsTN38r1n0MTlfMAsSBi2Ms3vTmj2v/jPsAwhb2mpPgJwEP8+k8j
cN3vrq1sFgYJMee561K3JiUcpm0aCN55NAuTaQ9fOpV8ow4xNn4vrgh+EvjU+LTQ
YY8DlesoqyZuG6FPd2GvJ5jpRLK2IJtMp+Ao116jHyFzg/oN3UI=
=VZSZ
-----END PGP SIGNATURE-----

--plo7cdziw5qygczc--
