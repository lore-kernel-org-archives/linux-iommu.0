Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794322530;
	b=df/fuMe9QIOUmj8aKW0kKb+Us0E6zDC3I1LA7AZ7tJcjGj/jIXijT80fNppsCtR2iBdL
	 V2O6KW3xb10Z6mRuFcEiFSKVGPqvye+lbKx0Ar8VbTKcLXBfWAfo38iMJ1IkB8TjBIG2H
	 SsNnVAvQQtsj2rrYJSEy3+NfAeIeQEHS6PBKLmUJcXDjP6AlP7WM6AfOUjJ2P4Yfg11Uc
	 pOIv0DY3omZIcn931mDFJ2Uug1f3j3+KoWYc3LtoI9cHViq52g2kFGOiouf3RROAgQyip
	 9BF/NSRlR/26hmCBeUUANOt8Zn3+KdjCrOXy75zxBYgQAZACB2yTfgcDYgplXvrfMsw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794322530;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Zoho-Virus-Status:X-Zoho-AV-Stamp:
	 X-ZohoMailClient;
	bh=9iTzNvY7Uy2wxh4/yC+c64lgqi3vm9WV/SAUoSR7IP4=;
	b=pQ9gjQ6REp/LCIJNFGZGPIlTJCEVHls1fe5MZR2tO8cNv2wXlUwURgAgEt3wAalPl4Uw
	 MA3Q7SVoCziHBRtz/2qe5+1pGJ34qxuTMlqhQLa2BkrBvDctFUNtjrITKt+v6KswzUorc
	 NhWdk5xKkmTRTL7MTMoLrzOFFN2sPVDnH1qnQ1hG7sAfdNpDIg9F9XD+PCYc6Rv3vkowO
	 ibGkymYU3VdTFYgcf8US+O2AS8KOBsKQDsB305efGK4iVjbuSdzL5xv0T8OBG+AmR5HCF
	 X5W+idpWbvVe6kO7RcQjcXMkJMgKNWkOt/kA+SDfUpt0WDOpYfM7mJqWatYjHX88T+g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=AZfAP+WA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.11
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com [165.173.182.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256AA606A31C
	for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 14:55:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 256AA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=AZfAP+WA
ARC-Seal: i=1; a=rsa-sha256; t=1794322518; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=P+nid//XTmhX1bkpQjiWlLCC/jZue1QxH2DjzJoB9BLs/o0whE7Jwrhud1S/B9SJagyjI1S6YMVi2DKk7KZm3oWlf7ye8Try18aW7YwogrMmJdSAVO94TGxariIpjZfyeCxV2QoZJO2RYyY7aDRWwUzy65cVBe1sCmmqgycoGsg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794322518; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=9iTzNvY7Uy2wxh4/yC+c64lgqi3vm9WV/SAUoSR7IP4=; 
	b=E/o2LlsUDPGK18ieTU/Qs4wYz/6yyR9UY+1C01o6W7mXZtF2lyRSKMPDayCFpFfxYZZ3czi3E+TCg1ayGBT+saMjMfX6rn5QMElQzWJeXTCtpzlW9TUEpTaA3dugxgA/Zfm/ByBkv5KqflvHDxY8KRaPn3kcQQoE4xzI9+I2Av4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: a=rsa-sha256; b=AZfAP+WAKnLO/LgAor/UnG4BaxlcChZXI4bVO+Xq7/TrvsfcnB55tJWiQML2aL9/QJzKCkKr9QlEiwK/tHL3bBf+9FfcydxJPIWwSuuEWtxs0w8T+FptYdziyfM6YluZfr0ScPqN5Yy2+nMoRJLTEQVrOoFkoZpPFOAL3aNnZJQ=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=9iTzNvY7Uy2wxh4/yC+c64lgqi3vm9WV/SAUoSR7IP4=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 179432251690026.33458305795125;
	Tue, 10 Nov 2026 06:55:16 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id 7AF03180354; Tue, 10 Nov 2026 15:55:09 +0100 (CET)
Date: Tue, 10 Nov 2026 15:55:09 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: aiyengar1990@gmail.com
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	"Joerg Roedel (AMD)" <joro@8bytes.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Niklas Cassel <cassel@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 2/5] dt-bindings: iommu: arm,smmu-v3: allow clocks
Message-ID: <avMv7fQuNJZpE_zr@venus>
References: <20261110-smmu-v3-pcie-pd-v1-0-628819ca44b9@gmail.com>
 <20261110-smmu-v3-pcie-pd-v1-2-628819ca44b9@gmail.com>
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
	protocol="application/pgp-signature"; boundary="apkvvzaxcdcph66e"
Content-Disposition: inline
In-Reply-To: <20261110-smmu-v3-pcie-pd-v1-2-628819ca44b9@gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/294.310.16
X-ZohoMailClient: External


--apkvvzaxcdcph66e
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/5] dt-bindings: iommu: arm,smmu-v3: allow clocks
MIME-Version: 1.0

Hi,

On Tue, Nov 10, 2026 at 07:11:49AM +0000, Arun Iyengar via B4 Relay wrote:
> From: Arun Iyengar <aiyengar1990@gmail.com>
>=20
> Some SoCs feed the SMMUv3 from a clock that the OS controls. On the
> Rockchip RK3588 the MMU-600 for PCIe runs from ACLK_MMU_PCIE, whose only
> other consumers are the PCIe controllers. When no PCIe controller is
> enabled, the clock framework gates it as unused, and the SMMU can no
> longer be accessed.
>=20
> Allow up to four clocks, so that such a clock can be described and held
> by the SMMU driver.
>=20
> Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
> ---

This does not explain why a maximum of four clocks is allowed.

Greetings,

-- Sebastian

>  Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml b/D=
ocumentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
> index c8f22dfdb1db..f8a74730667c 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
> @@ -63,6 +63,13 @@ properties:
> =20
>    msi-parent: true
> =20
> +  clocks:
> +    minItems: 1
> +    maxItems: 4
> +    description:
> +      Clocks needed to access the SMMU registers and to keep its transla=
tion
> +      units running, if they are not managed by firmware.
> +
>    power-domains:
>      maxItems: 1
> =20
>=20
> --=20
> 2.55.0
>=20
>=20
>=20

--apkvvzaxcdcph66e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmrzMEwACgkQ2O7X88g7
+ppLEw/+MNtpw8yw9i0ZkKzRkK8q/EzZMGPQ599QxbdAR88xtnYi6Htl4uE73QyK
WkyMrX/NIplWZu5I44J68aJC+H+jWvOxTEO6apPIQFOuK0dznO/Y6m0GRtFz7p4s
4od00k+xpLP/76wW0Ib4d9sSXxyeMv9lXq+1Auv3YkA5a7p+hcpzRDejRrg0udag
xPUiy4++1yAAkaYlBZyR71EqgXkRRTM9a2sDqwlQfK3nsnrWuoPxl4S6Bk67cfOT
U7JRIGKBiKTmMjOU5D0ESw5czT+O9R/bVHdeUnDtSrLyAMxfvjBQv9YLarCHkYmh
5keolQEbb8OzeyEKaj/gFhi9C6eqh5d5D538Zs1Q6pCrSs5BnzN+3BP3CFrhk39G
xjbb2XCo3L+zz0zaiE43XkqsLIz2XujWpWt3HrKSiAQuga0vDZ701isJ/wwYbFbX
WlG+e7XtUKDgbux0s07qRP0dW+/i5jdIx+qW6o/KtGAx4QRgoogiEhxQC7GE8ut8
DTKO3GyJg3oGVbdR2IsEDnhkWpgIJlSRh/GbK5SmMUtzQS+veirXv5rd7QvmXXle
yi3i50b1eY17V2SDt1GuITSD7bfqfd5oZOYnWazdDEdiX0nTlBfDxFH82eu/TlzG
p08cMLFJp/9F2TjNoK0NyMzF6Wx22nxxoj54u0RLkMgJlXa6j8E=
=kunh
-----END PGP SIGNATURE-----

--apkvvzaxcdcph66e--
