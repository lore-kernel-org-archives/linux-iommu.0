Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794322842;
	b=UZbqe+9pmtRcxiS6Uk5gJWU+Iu2Smvk7/AnQwfcKI0vmtTCl/yEkEN5Q757qfugI7TPw
	 eMd4T8O42Q+QoD3Y6KzTTrCBUvTrsrRSLQFdKyxiXuZQZDSedKbLofygbvcaFFhAk9nA5
	 C5OXSs0sbtvmBzsuMjbg4gegL+nnViLhzM2y5RTQB39Fw0Zk5mL97fh5dP01shv9fl0fW
	 t6Qrw1l0gB6sNv4zBlgKiuyLWbUGXGxZdfT3BTB2e3yXIwd+0xsAEfm+YkMH34ZFpj9Ko
	 aY8TxE4wQFSlDrOEhJ96axs+qTeOdOOPEwVIKAdDColb8QPre2ymTi6+1g0UDFPZbIg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794322842;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Zoho-Virus-Status:X-Zoho-AV-Stamp:
	 X-ZohoMailClient;
	bh=Xb1y+ovOhvBI3PPY14V/QFdhBDvdbmq7VXJJdsVP7cU=;
	b=ZuuArVxFbnNLDKbYisaLHccUbRpnsx9l1HfUEmcF3mqhJtrQpf/af6skwnYbufnVkfb1
	 Aaxuq8Li3RsrRDlkog1yfnDVEAqPybqJZqtjo4aoHi1U4OGQnAt44no8FXXNnWPdN7H9F
	 cDUWR+LIfolY7Tyt2W6U3iUxwaFFkiXyMvy+SaUsc60p9rErbyYeXkuF4DOklpgHNQ+1U
	 8tRWEBVuB6W+9G62OR4ONixdnPzvIZ3FondUrN3YO22a8Egj7ozPOTvq47Jy3WHcCUxgc
	 qRUH9ZTq/kYIdloT6NYwBqYT/yWSS5mTPOdq5v1twtKitZe018T+hqGQWVRpR6yeNnA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=gDpkEvFJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.11
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com [165.173.182.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F14A60A5BCC
	for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 15:00:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F14A60A5BCC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=gDpkEvFJ
ARC-Seal: i=1; a=rsa-sha256; t=1794322829; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Eb0p/omXtaq1k5nxNfO+ujP/HRbgPhXxnjYl+jPdYc33Yc4CrkysC7ePkukgW8NK5IKc5RY+vhGMiAznLn97L7pksj0kVP0VZ1zSIMSmmfMe1WNC4FF183uIUlrKrPSETt5Z75rc6eSv7KOMulct6Wto+FSqVTG4EzDTjhT+YMM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794322829; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Xb1y+ovOhvBI3PPY14V/QFdhBDvdbmq7VXJJdsVP7cU=; 
	b=G9ld2mFn+L16/WrbrJefoNJzbBywfBEPAo+iqStgHa6C6TF5jHufoDYvw2tnQhDwUgHu4Zl7LC2qACeUO5z0i0bWjSMDNeEZG7n6jsKYHlAgvNB7ThslS4sN+7ErElweraMVKzr0KRYQGd5GilNe5cFtg3BEkanr62mXWRAWPpM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: a=rsa-sha256; b=gDpkEvFJvIQrrlLE8Kbk9F2ORW97VzC+pAoFvwtWAdavuP8rXp7dDxdBG0pvOYEzPRLWJag0ME6Wb/fcmYkLCkagSxHhVF32qTeT1los1whzDp4eLXfbMyslEUXbKBlIA+InyXnlx12Js13nHIYPDnzuc94GNosGA4yZb2G+fVc=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=Xb1y+ovOhvBI3PPY14V/QFdhBDvdbmq7VXJJdsVP7cU=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794322827521487.8316939248318;
	Tue, 10 Nov 2026 07:00:27 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id D82A2180354; Tue, 10 Nov 2026 16:00:17 +0100 (CET)
Date: Tue, 10 Nov 2026 16:00:17 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: aiyengar1990@gmail.com
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	"Joerg Roedel (AMD)" <joro@8bytes.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Niklas Cassel <cassel@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 4/5] arm64: dts: rockchip: add the PCIe power domain to
 the RK3588 PCIe SMMU
Message-ID: <avMwk16cTHMQIwmC@venus>
References: <20261110-smmu-v3-pcie-pd-v1-0-628819ca44b9@gmail.com>
 <20261110-smmu-v3-pcie-pd-v1-4-628819ca44b9@gmail.com>
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
	protocol="application/pgp-signature"; boundary="yvnwakyswhfsguxx"
Content-Disposition: inline
In-Reply-To: <20261110-smmu-v3-pcie-pd-v1-4-628819ca44b9@gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/294.310.16
X-ZohoMailClient: External


--yvnwakyswhfsguxx
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 4/5] arm64: dts: rockchip: add the PCIe power domain to
 the RK3588 PCIe SMMU
MIME-Version: 1.0

Hi,

On Tue, Nov 10, 2026 at 07:11:51AM +0000, Arun Iyengar via B4 Relay wrote:
> From: Arun Iyengar <aiyengar1990@gmail.com>
>=20
> The MMU-600 for the PCIe controllers (mmu600_pcie) is enabled for every
> RK3588 board, but its node does not describe that it lives in
> RK3588_PD_PCIE. It only works today because TF-A leaves the domain on at
> boot and, on most boards, an enabled PCIe controller holds it on later.
>=20
> On a board that disables all PCIe controllers using that domain (the
> Orange Pi 5 with its M.2 slot in SATA mode is one), genpd powers
> PD_PCIE off as unused after boot while arm-smmu-v3 is still bound. Then
> at reboot arm_smmu_device_shutdown() writes CR0 and polls CR0ACK on the
> unpowered block, which stalls the bus: the kernel never reaches
> "reboot: Restarting system" and the board only comes back once the
> watchdog fires.
>=20
> Describe the power domain, so genpd keeps it on for as long as the SMMU
> is bound.
>=20
> Fixes: da92d3dfc871 ("arm64: dts: rockchip: enable the mmu600_pcie IOMMU =
on the rk3588 SoC")
> Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3588-base.dtsi | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi b/arch/arm64/b=
oot/dts/rockchip/rk3588-base.dtsi
> index aa69fd3793fd..bcd342c025c9 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
> @@ -560,6 +560,7 @@ mmu600_pcie: iommu@fc900000 {
>  			     <GIC_SPI 367 IRQ_TYPE_EDGE_RISING 0>;
>  		interrupt-names =3D "eventq", "gerror", "priq", "cmdq-sync";
>  		#iommu-cells =3D <1>;
> +		power-domains =3D <&power RK3588_PD_PCIE>;

The TRM says the power domain of MMU600_PCIE is PD_PHP, not PD_PCIE.
See Table 7-1 RK3588 Voltage Domain and Power Domain Summary around
page 1096 (depending on specific TRM version).

Note, that PD_PCIE is a child of PD_PHP, so it makes sense that
PD_PCIE also works.

Greetings,

-- Sebastian

>  	};
> =20
>  	mmu600_php: iommu@fcb00000 {
>=20
> --=20
> 2.55.0
>=20
>=20
>=20

--yvnwakyswhfsguxx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmrzMYEACgkQ2O7X88g7
+prfPw/9H7V6CFJtfI0s9f5zQ1tXpHmng97aGYhRQAxloE/LcvZHpFI8zHFOAL+3
/BQfGKhYVHxw0VEO4VSVrIbaLWag1mtFtYfjINdR5/uT6937ctWfyskTfMuKf/35
O3nOwz8Uihhq3ZbA+AFJ+DLbUiRs7+Ka7rn4IxvDE/YEZrVPFJIRmU/iJ5NZTiDs
u8AVATgGiVEmYXFkrqUr3siaEB5QiITUOkv8F4y5i9xYcrqnRr+9LrwjXVsjVpn+
cySgWnAySJ13eX55L4XktWLXiqd26EaK7dRTcWsNm6mACod8BP1sGtDJkS310fFv
Utzx30B9Qh7ThWXF2HwdmeqSGfzWFc54k8IHtmx7PcpKkxmOFXG5+e7gOw1IMCE0
Ro9SQxIwJ44twPtPyuQyA/nzqvui8ZmzFhZ9TmuKjyuR1tOLmg1546WVLJroN3+B
ceLNYAhT94Xopbf4C1WAA8WWOSEuhU7ILyyDB+LqVQEG8YtaP6d9wFq0vRDxKbXj
WITuytLrKkMWWjwXtq2qWko1HLDCHv1SV/1lmw7Vxye2Gx8mLIjnrRXgRVfhcmZA
TC7g/FJ3/oEvKSbf9OrE5LglaqBWGgwbzN+e/g7UCoQnfHKOwHB9phFeOj7nUTvW
/zzCKbC+DQ+HjRbMKlP9bEw/GgJebMSK+fDAM7d68zim0FCJ5Jo=
=Q6ux
-----END PGP SIGNATURE-----

--yvnwakyswhfsguxx--
