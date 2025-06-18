Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571992FEE17
	for <iommu@lists.linux.dev>; Wed, 18 Jun 2025 16:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750265650; cv=none; b=EQFQj/m4yYg89S2QL/E2aFS+Q20LiRwxRaqw4QN5wie3nmK8iXP85doUN2QZks3cUPUQNg2bo+cAJq6JvBjsVBw4yD466wXb9E5bUMpT9YnXnnfVEv+KSc5VPB/8g8Eql1ZogbBzZ2wknLPNsodT+tKQJciDQDAaOYad6/+bny4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750265650; c=relaxed/simple;
	bh=kBiRr8MyVCDx2IHSe1QbON+d3OAAkqPRo1XDBFOzGA4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r4M1sXhAZ3JfskhPF9yNtIzPBWyu1GnfgEfd8kS3/qBhZhG5EIqVI0IMIooAVk8IKyev+DfHkgvVEuc9qT4MlgwS4A2+8a7K3NOxAv4SfYhscpDanZhWleeouVp6HrjzU2+4IfSuzMjT5zETu+EnxQajunCBXbPk3lknhOwFtGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=AJfsT/wk; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="AJfsT/wk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1750265645;
	bh=kBiRr8MyVCDx2IHSe1QbON+d3OAAkqPRo1XDBFOzGA4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=AJfsT/wk398JAIgFfr5V6YyaDGkK8LzNxoxZts9xXcxdB8Gy2wod6/9/NvZ/LzwH+
	 YhYF1FGUI6l/uuoiYVfR5uVLkigBmJFAnD7z1MVG0Ke0St9/ZOyxwe2TDZ0CR3cQXb
	 2c7H1Z5zmy5LfpuVQ6sSqSRGgoJyyzcTGCwUr5axQ66KkvD7xm/88GhocP8cKQNM5b
	 Huly3QLWcM5hsJ9Bp/6aknCsKYhf41oEn2SoSXXOkT3UnUERs+C2DdYBQ17ajjU+Se
	 tHABZWkj+HeMuMa20MkSqiC10pNLswp5hXlA6/Q8l2EAfnGCCYWtCu+iJB+z2wcgLw
	 FMxIs4rbA+w8Q==
Received: from [IPv6:2606:6d00:17:b699::5ac] (unknown [IPv6:2606:6d00:17:b699::5ac])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nicolas)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9C48D17E06BF;
	Wed, 18 Jun 2025 18:54:03 +0200 (CEST)
Message-ID: <2f63c39a3b9f16c47dfe7f62338ef17839d1b286.camel@collabora.com>
Subject: Re: [PATCH v2 2/5] dt-bindings: iommu: verisilicon: Add binding for
 VSI IOMMU
From: Nicolas Dufresne <nicolas.dufresne@collabora.com>
To: Conor Dooley <conor@kernel.org>, Benjamin Gaignard
	 <benjamin.gaignard@collabora.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, robh@kernel.org,
 	krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de, jgg@ziepe.ca, 
	iommu@lists.linux.dev, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, 	kernel@collabora.com
Date: Wed, 18 Jun 2025 12:54:01 -0400
In-Reply-To: <20250618-tighten-morphing-47953075b131@spud>
References: <20250618140923.97693-1-benjamin.gaignard@collabora.com>
	 <20250618140923.97693-3-benjamin.gaignard@collabora.com>
	 <20250618-tighten-morphing-47953075b131@spud>
Organization: Collabora Canada
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-H4420/eJuZI3vRrv3ALH"
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0


--=-H4420/eJuZI3vRrv3ALH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mercredi 18 juin 2025 =C3=A0 16:55 +0100, Conor Dooley a =C3=A9crit=C2=
=A0:
> On Wed, Jun 18, 2025 at 04:09:11PM +0200, Benjamin Gaignard wrote:
> > Add a device tree binding for the Verisilicon (VSI) IOMMU.
> > This IOMMU sits in front of hardware encoder and decoder
> > blocks on SoCs using Verisilicon IP, such as the Rockchip RK3588.
> >=20
> > Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> > ---
> > changes in version 2:
> > - Add a compatible "rockchip,rk3588-av1-iommu"
> > - Fix clock-names in binding=20
> > - Remove "vsi_mmu" label in binding example.
> >=20
> > =C2=A0.../bindings/iommu/verisilicon,iommu.yaml=C2=A0=C2=A0=C2=A0=C2=A0=
 | 72 +++++++++++++++++++
> > =C2=A01 file changed, 72 insertions(+)
> > =C2=A0create mode 100644 Documentation/devicetree/bindings/iommu/verisi=
licon,iommu.yaml
> >=20
> > diff --git a/Documentation/devicetree/bindings/iommu/verisilicon,iommu.=
yaml
> > b/Documentation/devicetree/bindings/iommu/verisilicon,iommu.yaml
> > new file mode 100644
> > index 000000000000..9ae4a45d76f4
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iommu/verisilicon,iommu.yaml
> > @@ -0,0 +1,72 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iommu/verisilicon,iommu.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Verisilicon IOMMU
> > +
> > +maintainers:
> > +=C2=A0 - Benjamin Gaignard <benjamin.gaignard@collabora.com>
> > +
> > +description: |+
> > +=C2=A0 A Versilicon iommu translates io virtual addresses to physical =
addresses for
> > +=C2=A0 its associated video decoder.
> > +
> > +properties:
> > +=C2=A0 compatible:
> > +=C2=A0=C2=A0=C2=A0 oneOf:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - enum:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - verisilicon,i=
ommu
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - rockchip,rk35=
88-av1-iommu
>=20
> This isn't right. Firstly, the "oneOf: - enum" construct doesn't do
> anything. oneOf one item is just the item. Secondly this still allows
> verisilicon,iommu in isolation which is not okay. What you actually want
> here is
> items:
> =C2=A0 - const: a
> =C2=A0 - const: b
>=20
> Thirdly, Nicolas mentioned that the version of this iommu is 1.2.0,
> which I would like to see reflected in the compatible.

I believe just 1.2 will be sufficient, the last number is the build number,
the IP is interface is unchanged.

Nicolas


--=-H4420/eJuZI3vRrv3ALH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSScpfJiL+hb5vvd45xUwItrAaoHAUCaFLvKQAKCRBxUwItrAao
HEIBAJ4+fNWvctsbsGY2hG9WzLfQYcW51QCg2j4bOqlf9fdEsgEh4zPtrR8oLqc=
=SlrU
-----END PGP SIGNATURE-----

--=-H4420/eJuZI3vRrv3ALH--
