Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795035659;
	b=H/LOzQI+G4TyLSNvHkJjblrS4DRLuGQQjyoBTSLOPtnF/aofuxy9nPwPgjP3D2yhTLxJ
	 aXno1aN2we6t3yowSThWcJ9IAa7DZEfAmJFl1bde5t5oQ217K5hNwAL37TJpeW90I/mLS
	 J99GlZq+3g3JD0esPcqjuX+xxsD1UXLwz3zJLWrUy9ffGqTplnv/dpK6VHvAZhovpDcL2
	 IsSESDGEewpydza2+QT1Ef1XVfaTDRdRNVsZB3ZUPepub/p8JilSOGIOQlFDIcnkEJ4Qi
	 MSt6oI3rS3rEWz2gKlHCdWvX92z+DgVL50yLipNxC4R5deF/aKyDpOh6wZAWU+ppinw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795035659;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Zoho-Virus-Status:X-Zoho-AV-Stamp:
	 X-ZohoMailClient;
	bh=1Q0LYYslC9SLGX+vLFPasi395lu1/6g9K3WwZGH1f8g=;
	b=d4ogVLxeO+w//mCb+G9KZOkxI5JlfL1FIFuH8DJOfGYEm+PrHnMTkxhrWNa7mDPKJME7
	 t3/4inbwgdKG8m9EPwPEgpMIMsNYwaL7Xdn5qKZYK8pxgw6I1ltsv0acB1zMMYC4kQHKD
	 XaKjKSjRgJdq0mrsodANaoN9lWruHGKUOKw4Xi+gyHdaUFEyRKfEAIc8rczhg3QZtqY7n
	 s6aW0MELDnTV8SNi/uda/Bwd0aLkQj6zfdB2XjlOSALZmSBUEJJHQftOkteh1zKUMVHdB
	 q22Ow4JlD0VS9LSnTeIWfhNRYhFG1YLdUzFIC66+dVvbszcajw1gbGujsHh6BKSJDDA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=FHmnU7By;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.11
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com [165.173.180.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BDC606A320
	for <iommu@lists.linux.dev>; Wed, 18 Nov 2026 21:00:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35BDC606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=FHmnU7By
ARC-Seal: i=1; a=rsa-sha256; t=1795035652; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Httsw4pR7dDdbppwdsQxr3rUc79b3jduysU0djA8OLqDzBWGbDyy69ShVu2KbwElSZW0NXMa6K4FRkc5FY4CMR9f/ym/9v38QOuxCa7t4nAtRI/fjfNThYG1drNt0QaP4UCulr8YJ/ARkhI3LBAQgw1QVORX06AEm9/HE0n1/LI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1795035652; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=1Q0LYYslC9SLGX+vLFPasi395lu1/6g9K3WwZGH1f8g=; 
	b=crAMmfhFvuID4uKP6zbCqY4rXZvYx4s2j8UScMlCeX5WwsgRonq0wv2el7qjYb8dUxlPKU0wZspPTcoAtFNSS0rpVCO/cJgIaAYJH7LJsvcbtI92gaDzt1K/Kry2LYxLDyYcMAQkvqJ9pyTeffDmMoTigKlSnugATVaiuvezeHs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: a=rsa-sha256; b=FHmnU7ByIKPhVZaba8+HYqebSTQp/Kb0y9IpIo30em87v4uTuPrIQ+Y7XUbvhkEMBKkLf+E3Y2CrtLUoecslLfe3s36nvpJtnPr85aF3mNGTE8X6oaOm7w88tyQs2szzS0wfDq6BzL4947m90+6LU7k/r4ERY5Gtm0yWvVcoeJs=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=1Q0LYYslC9SLGX+vLFPasi395lu1/6g9K3WwZGH1f8g=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795035649369461.9687927612447;
	Wed, 18 Nov 2026 13:00:49 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id 1937618044A; Wed, 18 Nov 2026 22:00:44 +0100 (CET)
Date: Wed, 18 Nov 2026 22:00:44 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Rob Herring <robh@kernel.org>
Cc: Arun Iyengar <aiyengar1990@gmail.com>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Niklas Cassel <cassel@kernel.org>, 
	Pranjal Shrivastava <praan@google.com>, linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	Shawn Lin <shawn.lin@rock-chips.com>, Simon Xue <xxm@rock-chips.com>, 
	Finley Xiao <finley.xiao@rock-chips.com>
Subject: Re: [PATCH v3 2/3] iommu/arm-smmu-v3: Enable an optional clock
Message-ID: <av4PT0Xu8yd6ygN9@venus>
References: <20261113-smmu-v3-pcie-pd-v3-0-39eb4f919529@gmail.com>
 <20261113-smmu-v3-pcie-pd-v3-2-39eb4f919529@gmail.com>
 <20261118203236.GA823624-robh@kernel.org>
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
	protocol="application/pgp-signature"; boundary="n5rhigbbwwyg4zlt"
Content-Disposition: inline
In-Reply-To: <20261118203236.GA823624-robh@kernel.org>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/295.17.74
X-ZohoMailClient: External


--n5rhigbbwwyg4zlt
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 2/3] iommu/arm-smmu-v3: Enable an optional clock
MIME-Version: 1.0

Hi,

On Wed, Nov 18, 2026 at 02:32:36PM -0600, Rob Herring wrote:
> On Fri, Nov 13, 2026 at 08:45:06AM +0000, Arun Iyengar wrote:
> > On the RK3588 the PCIe SMMU's clock is gated as unused when no PCIe
> > controller holds it, and the next register access (the CR0 write at
> > shutdown) hangs. Enable the clock from the firmware node, if there is
> > one, while the driver is bound.
> >=20
> > Do it first in probe, as the firmware probe may take a Tegra CMDQV
> > reference that only arm_smmu_impl_probe() releases.
> >=20
> > Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
> > ---
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >=20
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iomm=
u/arm/arm-smmu-v3/arm-smmu-v3.c
> > index 6d4520c47308..d3f42316b0d6 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > @@ -12,6 +12,7 @@
> >  #include <linux/acpi.h>
> >  #include <linux/acpi_iort.h>
> >  #include <linux/bitops.h>
> > +#include <linux/clk.h>
> >  #include <linux/crash_dump.h>
> >  #include <linux/delay.h>
> >  #include <linux/err.h>
> > @@ -5786,12 +5787,22 @@ static int arm_smmu_device_probe(struct platfor=
m_device *pdev)
> >  	resource_size_t ioaddr;
> >  	struct arm_smmu_device *smmu;
> >  	struct device *dev =3D &pdev->dev;
> > +	struct clk *clk;
> > =20
> >  	smmu =3D devm_kzalloc(dev, sizeof(*smmu), GFP_KERNEL);
> >  	if (!smmu)
> >  		return -ENOMEM;
> >  	smmu->dev =3D dev;
> > =20
> > +	/*
> > +	 * Before the firmware probe: it may take a reference on the Tegra
> > +	 * CMDQV device that only arm_smmu_impl_probe() releases.
> > +	 */
> > +	clk =3D devm_clk_get_optional_enabled(dev, NULL);
> > +	if (IS_ERR(clk))
> > +		return dev_err_probe(dev, PTR_ERR(clk),
> > +				     "failed to enable clock\n");
>=20
> The primary point of the "optional" flavor of get functions is so the=20
> get function itself can print an error rather than every driver doing=20
> it. So drop the error print here.

For clocks no errors are printed for any flavor so far. The primary
point is simplifying the case of a clock not being described in the
firmware:

clk_get -> -ENOENT

clk_get_optional -> NULL (valid dummy clk handle, which may be used
in clk_prepare/clk_enable/clk_set_rate/...; also not covered by
IS_ERR() and thus not considered an error)

I think it is sensible to have a proper error in
/sys/kernel/debug/devices_deferred when getting the clock return
-EPROBE_DEFER, so I consider the error message sensible.

Greetings,

-- Sebastian

--n5rhigbbwwyg4zlt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmr+EfgACgkQ2O7X88g7
+pqAZw//TekznrpEVhxaX/atWMdDNYcX48509vLVMXmPg0jrqdTaBHoIkmXN7Rfj
VPJVEjCzuwW/Cdpzt1bEaHgtySqvErR05QdAK4heSrScM8eSpyyczs7/ONQTkOUb
ewAisBTV8Fp4Hnt+DzuXR1Z43JEaH433Z8eoHMp7wUksKPUpE6AXsJwQ8C1GrXCG
1ce+UIsrMBwe/aFmlIgbx8G05FvXQ+JifcLIqM7uWqfgHpmB3XJ86jkXvLe5YPYg
3A5qAvV05ilAxRQKer3xnTu8v+l6bMgYIZSGj6TnUQNCfQRz2yNgvMShD+baqsLj
kLAcPd9ytULKlD0XH4A/vpYFcZvjSPskKRnCMRNNqOOAXl6nWmZYW/cktqT/M22y
InVtBhprpj/+4NUlQC0Ji0nvQsa+YuGYOc3LMCIJDNtEM1DmqcxCvwnEH7zF9/7S
Zmwa+pCm8XIO0g3yyKtEVVoWRzQWf9IDMVJuvsqKl/nPH6IANCJ2SEt5ZnsYye2a
21mPuP40QeCBMc+F8inZUmiahnURrIcYFuDPFc3ufsFIQXDyZUImpL5Ei3ydzGzc
bNhy79nUI79XQ2+En2HVWbakyoz42Mu1eoOGCsm061fn0GamtKuiZWErxcq8C/f3
0qQeAd40nrhMIqZN1oGUSRkLDIfapqN8jUQ2qJGOVavEzbYaWyM=
=FSvF
-----END PGP SIGNATURE-----

--n5rhigbbwwyg4zlt--
