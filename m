Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794322440;
	b=mmMC9z94R1dpededABsIJ0hr+wrI7PW40OfCmStlXUhbcxgHmrC8w58lC2u2CdODT8+s
	 eRC+I0aWdWMQI5u0lgqoA0VQOTeTZq0te+FncqTkDRB97gJ7o+Gc9XiEJYGq2gggDK+gt
	 CztPlPztAPq1RvmVQRUALXAQk48VDz8Y43pU0rxOPUSSy+scoE7pK62mVfVmSgsc81hfk
	 +Re5h91fltrwoJKBt3cZe8H1L7c7M5g35enpqGsLH1nXNSFU7x1ceQvuV0nIelL5eE+5R
	 lxKLiB7brEQRpclDNKh6TjXFGktxOgpZXtY0LhT257MUiQDpRYO6Hp6hqeTnDleeS2g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794322440;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Zoho-Virus-Status:X-Zoho-AV-Stamp:
	 X-ZohoMailClient;
	bh=1nscl7aZNwOtv842vwFmJ0HuXa6txcAWMb0wIM3bg7A=;
	b=f2FeHAQ/m7x8EK+zUFlAUk0J7UugaIXw4pIb64NlmzWHLdsNfG8/++9jHBaNb53aLs6l
	 Hzy6mjo9/2ArsqsorFZI51+1Xna0uFHVEi6cfPiA62HxPQ8t88Jhh+PcZs6NkZwWmjGJB
	 d3DUKV8t2mn5lOO2u/zvWLHaBeLEKtwPREUh8u6mOG4Skjl/rjimCqhdF/ku/9SESsQcH
	 RfAZ6aiKgy9fPDkpJAdgkiK69dpKB22rvyGCoAK0J8vLQNGexmnxyzeQ5xyX6SX44JonI
	 wfncL/HFop/80uNoSa5BrjmHiw9OXEI9F5s06/M2hWyejXL9bSUrJH06wgGrCipHDHQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=LnS20fwW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.11
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com [165.173.180.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C8F606A32D
	for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 14:53:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91C8F606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=LnS20fwW
ARC-Seal: i=1; a=rsa-sha256; t=1794322424; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=UQSDQPeWhfDIklKZ7AQ4NwCZKHSdWUX/rrRc047HEmYw+aETLagSI4a9TAIEG14IcNGL8ymrGQi6OqZrBdm72lGeJXqjG//Te9khom1dWxsIqTwWFBGu6xXvMlkOU8uD/YOJGmOVyQdhle3ryB9qGy76eJ0u9nCR20RbwS9rr+I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794322424; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=1nscl7aZNwOtv842vwFmJ0HuXa6txcAWMb0wIM3bg7A=; 
	b=i6Hdhl3LW9WWmxNJMIJv0NFXuWqWKsV72EAfdGP/d3Dgykm7kjpX7jcmm40kemY6mbp8TilQJVAgo2/OVMweLpMI3yLnddctKZ6sI54PEs8NeuZ35CjNtI+uTmZMUGM27Vn5OPDg6h0SKEuDwYXT4z74OLcaOwsvcS7K0FDkvfg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: a=rsa-sha256; b=LnS20fwWU9doICCJkO1+lTngxmeRJLeTmQxP2EXQ9bP0uSEb9wxc+bD/UKHee2lakzRDGm4FJbQg/0tmwGt7iTYbFr6liiSlrMUKT70SiXzC+mVv2K3pll3en/EjvAwbCZW5g8JKpa44Y9+RTbtRVUZrWO5iCFZTC7JhPpdWEy0=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=1nscl7aZNwOtv842vwFmJ0HuXa6txcAWMb0wIM3bg7A=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794322422153362.1328994697353;
	Tue, 10 Nov 2026 06:53:42 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id A4C1E180354; Tue, 10 Nov 2026 15:53:28 +0100 (CET)
Date: Tue, 10 Nov 2026 15:53:28 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: aiyengar1990@gmail.com
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	"Joerg Roedel (AMD)" <joro@8bytes.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Niklas Cassel <cassel@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 3/5] iommu/arm-smmu-v3: enable optional clocks
Message-ID: <avMvinXkzBpaRh5K@venus>
References: <20261110-smmu-v3-pcie-pd-v1-0-628819ca44b9@gmail.com>
 <20261110-smmu-v3-pcie-pd-v1-3-628819ca44b9@gmail.com>
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
	protocol="application/pgp-signature"; boundary="j6dulos5oufpuo7z"
Content-Disposition: inline
In-Reply-To: <20261110-smmu-v3-pcie-pd-v1-3-628819ca44b9@gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/294.310.16
X-ZohoMailClient: External


--j6dulos5oufpuo7z
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 3/5] iommu/arm-smmu-v3: enable optional clocks
MIME-Version: 1.0

Hi,

On Tue, Nov 10, 2026 at 07:11:50AM +0000, Arun Iyengar via B4 Relay wrote:
> From: Arun Iyengar <aiyengar1990@gmail.com>
>=20
> On some platforms the SMMU's clock is controlled by the OS, and without a
> consumer the clock framework gates it as unused late in boot. Any later
> register access, for example the CR0 write in the shutdown path, then
> stalls the interconnect. This happens on the RK3588 when no PCIe
> controller keeps the PCIe MMU-600 clock running.
>=20
> Get and enable all clocks described in the firmware node before the
> registers are first accessed, and keep them enabled while the driver is
> bound. Nodes without clocks are not affected.
>=20
> Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/=
arm/arm-smmu-v3/arm-smmu-v3.c
> index 6d4520c47308..cce66db93219 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -12,6 +12,7 @@
>  #include <linux/acpi.h>
>  #include <linux/acpi_iort.h>
>  #include <linux/bitops.h>
> +#include <linux/clk.h>
>  #include <linux/crash_dump.h>
>  #include <linux/delay.h>
>  #include <linux/err.h>
> @@ -5786,6 +5787,7 @@ static int arm_smmu_device_probe(struct platform_de=
vice *pdev)
>  	resource_size_t ioaddr;
>  	struct arm_smmu_device *smmu;
>  	struct device *dev =3D &pdev->dev;
> +	struct clk_bulk_data *clks;
> =20
>  	smmu =3D devm_kzalloc(dev, sizeof(*smmu), GFP_KERNEL);
>  	if (!smmu)
> @@ -5800,6 +5802,11 @@ static int arm_smmu_device_probe(struct platform_d=
evice *pdev)
>  	if (ret)
>  		return ret;
> =20
> +	/* Optional clocks: keep them running for as long as we are bound */

useless comment, otherwise

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Greetings,

-- Sebastian

> +	ret =3D devm_clk_bulk_get_all_enabled(dev, &clks);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "failed to enable clocks\n");
> +
>  	smmu =3D arm_smmu_impl_probe(smmu);
>  	if (IS_ERR(smmu))
>  		return PTR_ERR(smmu);
>=20
> --=20
> 2.55.0
>=20
>=20
>=20

--j6dulos5oufpuo7z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmrzL+gACgkQ2O7X88g7
+prUgg/+JNEo0SPEnyobWdRYPSOZu/Tn9RCGlBzIehkk0TD0d2SvMuDPacuxM6iy
msiz8nlhpfkagYAKp9ojnjS8MIDJ98u/AihAlgXj6PaLeWVLhUaN62zkKgYEB7pN
eAK6AZNCaLAKTDfQUhnAS5Ts4DFqhfo2kURK/5sLoKgvgCEIVJIBQsISRtOgxnYp
w+rqmAj1so634w7NXLzLt2hCL93EZxSfQWJFjWzAX4pSR0YtRYM+g9NZiO2G/YHj
Aip92FBnkjVXbl0+DAPnQJ3PTjWIWABxwp4DLs/WfkiOHSv59z6rXW7iluR/+5y1
6e2T21bQnoAmbGsTKpZbTT6UUkLCfXDfIc4bIFqWQR604Gb37xENkUsq8elOzIfT
oj4ObXRhUCUlurV2tVjAmYqlbXKrVEEhI+pnTvbg3aNmj/12fT5wtOZsaSGg8FVW
nTjMYzcj+geSNOKvi/asIOFV8jR6fIl7TwOS7u/ojoTlCvAJ2V77g8l5+u/8qnA/
Phw3tKaaoahqi7m84zxDyc1oXAwvUvz0kDZIg8ZEUm6fRr1W53LILDMvMgIrRTcL
qmzlHQJlx+PhspiX+kE7kwCp8dFmhcndqnlZwsTcIdxkGJJQnhM0Anrq0k3x6omB
OI5FfL+iINUvWHew81mwzujVKxBgxcYpbbfxo2ySecCSc5HmH0A=
=10on
-----END PGP SIGNATURE-----

--j6dulos5oufpuo7z--
