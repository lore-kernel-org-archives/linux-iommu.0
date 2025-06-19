Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3121D6187
	for <iommu@lists.linux.dev>; Thu, 19 Jun 2025 14:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750342804; cv=pass; b=i3obUBr9gogisJaDDK88jVIMeMvg6/HgvRtK+nV+F5HZcgqFp6YInNRN/Tt1mjCAfM5wfzvl4QV++GnCZd9OYp1Fr4+6cSDrZ5EI97CFEm7VEcNTGGSQ7gj/8zGyazZZQXAUPkZDwyLBMw53BIM3z0nCJ1hWFwgyDIMtZY+hPUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750342804; c=relaxed/simple;
	bh=0Cym437Fzw1lGFc5sfa9fLx57YRauPELSn/2mY5STGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D+B7i4YdUT7hi6hD/Q9z8fyMKRiCkYKpMJ5/2M4kB3fXbxITN+54PUgPmfgm00TIabxlqqQzVdKyg0BEpyi4cSDPnZ/Jgf05bbNc++9WbhMzfTEhlGllLQANE/vFyIs+JRX595A/TAoOBSJntngbtU1ytqamTAbpoQcB2KGxJbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=IVbmkkhm; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="IVbmkkhm"
ARC-Seal: i=1; a=rsa-sha256; t=1750342780; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Sr5BuXOgL2KVTzPmp8+v1j9JhBQTMY363XCLrtS9H9Z9IZteGXR1fez9QbHoCQsH+3EZN1CWFqXzcb2IV8DAKGFVsdr1zPITYSNLVKlTLm+Drr0vmI2Po5BkEJt3e5ijl1o5ipkDy0R5W2Jxf+J4TuVY2Q/P8f833i+2hBMagEk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1750342780; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=CEQBftYU5GEsq+N2TpwS8b8J87N/ZfaxNbCv461Psqg=; 
	b=PUu6EExDbfETJz0GDpKE5VnemHaQxMu9+yF+YQ3zEgT6BPfEtuyA2kBNILwR4wJEH9LPS93Pu/xyqvYwEZVpi8Kjjo7mhZtxAdr+fDcwaa4N5W4l19AxjvoVB1BDHGANOXzIWzS94khBqTMpZ1eBdP969/rychvWGOJOuIOpeNA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1750342780;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=CEQBftYU5GEsq+N2TpwS8b8J87N/ZfaxNbCv461Psqg=;
	b=IVbmkkhmZn3/slqjttwKvzYB3/PzTbZ+Q9nrn4mD1bqlo/qqdLY1Eecb57hS5DTQ
	5zbAuHsb7ODTYngCTv4umq5/Vcgp29Ig9IdOMI8K9Qm89m+AKYtUB15IC2Cam4FaZLA
	iEMEvCYN2kweNdcr70RfhOGxNLUZjYdEzNC6o+AY=
Received: by mx.zohomail.com with SMTPS id 17503427768471007.5123585560125;
	Thu, 19 Jun 2025 07:19:36 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 3965E1805A8; Thu, 19 Jun 2025 16:19:32 +0200 (CEST)
Date: Thu, 19 Jun 2025 16:19:32 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de, 
	nicolas.dufresne@collabora.com, jgg@ziepe.ca, iommu@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v3 2/5] dt-bindings: iommu: verisilicon: Add binding for
 VSI IOMMU
Message-ID: <n5ddeogrpgctrljnxjfxqaz22qfnxsgm6ro7qihbjeyhd5br44@ojlzlz7gsuzb>
References: <20250619131232.69208-1-benjamin.gaignard@collabora.com>
 <20250619131232.69208-3-benjamin.gaignard@collabora.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hnoyd7gcbfhdjsab"
Content-Disposition: inline
In-Reply-To: <20250619131232.69208-3-benjamin.gaignard@collabora.com>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.2/250.326.2
X-ZohoMailClient: External


--hnoyd7gcbfhdjsab
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 2/5] dt-bindings: iommu: verisilicon: Add binding for
 VSI IOMMU
MIME-Version: 1.0

Hi,

On Thu, Jun 19, 2025 at 03:12:23PM +0200, Benjamin Gaignard wrote:
> +properties:
> +  compatible:
> +    items:
> +      - const: verisilicon,iommu
> +      - const: rockchip,rk3588-iommu-1.2

The entries should be ordered the other way around, so that the
"generic" compatible is the fallback. Also the 1.2 version is from
Verisilicon. It does not really make sense for Rockchip. So I
think it should look like this:

properties:
  compatible:
    items:
      - const: rockchip,rk3588-av1-iommu
      - const: verisilicon,iommu-1.2

Otherwise LGTM.

-- Sebastian

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: Core clock
> +      - description: Interface clock
> +
> +  clock-names:
> +    items:
> +      - const: core
> +      - const: iface
> +
> +  "#iommu-cells":
> +    const: 0
> +
> +  power-domains:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - "#iommu-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/rockchip,rk3588-cru.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    bus {
> +      #address-cells =3D <2>;
> +      #size-cells =3D <2>;
> +
> +      iommu@fdca0000 {
> +        compatible =3D "verisilicon,iommu","rockchip,rk3588-iommu-1.2";
> +        reg =3D <0x0 0xfdca0000 0x0 0x600>;
> +        interrupts =3D <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH 0>;
> +        clocks =3D <&cru ACLK_AV1>, <&cru PCLK_AV1>;
> +        clock-names =3D "core", "iface";
> +        #iommu-cells =3D <0>;
> +      };
> +    };
> --=20
> 2.43.0
>=20

--hnoyd7gcbfhdjsab
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmhUHGUACgkQ2O7X88g7
+prRww//e+aSThtmJ810xji+RnvlWS2wXqSSig1uhBCoEFpCcWL8o04mLBsHlg+t
QEXbDsWRcs2dstJ8R/0zTskv4dXptRsA99DDBw0oqFXDVT7DA5brVDSL36BMDKW9
KI8KYrP1V2RpeV86Ry3q1ETRVGmiBUfN33KWDRuUDMMIW0/VIynan07sZap/0Cz4
vxTOJ0KiLchDa92nzX2bqn0UldSlFJct4G8sVfDJui9zTpw4RmMA+5IL6c+qC/jq
yIbHUniQVieY8q1vwAYkbw2VigzMeU/+rv/4EIuHB8lyhoMQwtGb/Zo6Dt2NgwmX
Vad1qXEzE5HIc/4V9PjXAU+mCOcnmEhSGFRGCkbZFmirMRbpErNd/yxVvgcxP3Fy
3IFoIkzZN9wc0aGOdWOH1Y/y5SwQHP31RRNwAlc2rQCdUQNkKUjXls7Im8Om40cD
pJpTDGTUX0PJUg6Cq+0CmVPsIa+KMN6l2QzThllthrJICmoDvBsTROg7eQJ5sfYF
fUTDG6G1I+MwrxgWyVtP+6C46xrXaKW+ny9XB5Cw3lITNPXTsIGugzwCZzMN85Cr
d/KwLnOdfVykNTLDbWtkmViXDy3G7vT1lBymWPaiIxSygNjUPvcH6lELbi5hQkSS
ys0Hb/aioLfK3y/Oz1mqsqRAcTtA96j2UxwUchBfUyRk0e9Do/A=
=wgbS
-----END PGP SIGNATURE-----

--hnoyd7gcbfhdjsab--
