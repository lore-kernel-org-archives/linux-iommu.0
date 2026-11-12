Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794455473;
	b=mdgcDIHFf7mG5doIIvSP9XJmHBMn33+xea3kOJ6iriHhqV2M6tZFXt26gZVwtXHVTIuH
	 8I0U7gtPl91ZWBr6BSEXmfYGD1ky+VZuDuzifDKFm9SvLwUpyBtomjVqExsfpYJLJiGoK
	 l4fj0giznatYH8iDfgQbN0y0ACGALMMbnhXCsrBhIFYJ7lJs+X7nMMGXMKecl8wR8/GSt
	 p9yw5hhhL4/rKHmfDbkxtmw430IvJEF0FZR6E14j/tIlXDQC4J0yC72zLlaoljlO61kzw
	 vysLS7BSy15PD4HqY91fNlzw5dktmSpemCHiX3a7FDCpaicac2s5BoNrMPZm4jvLd/g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794455473;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Zoho-Virus-Status:X-Zoho-AV-Stamp:
	 X-ZohoMailClient;
	bh=od2MTFJr2n07GulawypdnHc+XDeU/CQF54c7+qeGSkg=;
	b=3/GVjMJ6HD76xv6cKqtsS/M7mKVYEuhKM0C7WEzlrUcAWoLnVTj43ID+dB3Po4OCD6tW
	 9AhE4MulSl1nNTIioZXJTKUvajIw03WVYPWA4zHu/ufVrmLzyVYqRwHpuGJxddc8gfWWu
	 PXj27gBGupvW0jdZqWjWXLjpdJ9+dq3YigLABOlfXfiu5j2AIMlocAOfhNmFulHXW5Gc1
	 KoUJk8MojMjersjIqsj8g2AVjfcEPYtp9FUGohwiVZT2dQo7lddo6+9h3BGtuF9Q9Uok4
	 pR2mJ1bSKcjWQG4DSsseDh4B7pfMxA4ahbLSQkOtiV0K8KQoDjknll0Ef+5FylJjJjA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=Pyois4i7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.11
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com [165.173.180.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21C6606A31C
	for <iommu@lists.linux.dev>; Thu, 12 Nov 2026 03:51:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B21C6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=Pyois4i7
ARC-Seal: i=1; a=rsa-sha256; t=1794455460; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=miLEUgmPqEBpcIUKRBbHJcTMV73hdJYQRlNyUHE0BMSpiI6fmHAvyb8adXuq5UAVbQ5AowDfkohUjSyVu+k9TIoCaCCOZe1uLoN5joY5e+7CbIxAzfia9iiro8XAF6cqusXOVcSrvTqq1m2g8N17KFFLZT5Wz6HoyGFUnqhIrU0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794455460; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=od2MTFJr2n07GulawypdnHc+XDeU/CQF54c7+qeGSkg=; 
	b=YcBfySgNNac/Gr2W4Mj6FBzx3G6IXTcAbeQ0ey3pTxW0C+MjtgJlD504YjKtwwJ3WnKu8aUXWIvxgqSth5Ey4Ez9fr1BITAPSqG2aPvNL3PdwrvsBBZKQxsbnSFNLzSlNjXpBZWHm7torfuRhaGA7MuoDfFKTbqkGblF/uGopVo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: a=rsa-sha256; b=Pyois4i7O2HfzlPfTxnQqjrvraZ4PYa2L7WfF+E+HQyBKTQl1iq2FfSYXWJNNSv/XN0XEVfp0220gEvkOq8QdQrVA+7X7K6mJMUNvwZCRfqOCFy0/RRFwnoEXHvyO080ZDeXpVD175i3pUubojIrbLnxpghFq8X4nPmn7OFsZDE=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=od2MTFJr2n07GulawypdnHc+XDeU/CQF54c7+qeGSkg=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794455458780967.2624418168582;
	Wed, 11 Nov 2026 19:50:58 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id 9CDA2180BC0; Thu, 12 Nov 2026 04:50:53 +0100 (CET)
Date: Thu, 12 Nov 2026 04:50:53 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>
Cc: aiyengar1990@gmail.com, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
	Shawn Lin <shawn.lin@rock-chips.com>, linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	Simon Xue <xxm@rock-chips.com>, "finley.xiao" <finley.xiao@rock-chips.com>
Subject: Re: [PATCH 0/5] iommu/arm-smmu-v3: power domain and clock of the
 RK3588 PCIe SMMU
Message-ID: <avU2I_QzCiBPVTDC@venus>
References: <20261110-smmu-v3-pcie-pd-v1-0-628819ca44b9@gmail.com>
 <10924894.NyiUUSuA9g@diego>
 <ea8fa04c-4a8c-4c55-b4fa-f37d74267e93@rock-chips.com>
 <9_7qTfdNSViwtNUGq9D13w@sntech.de>
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
	protocol="application/pgp-signature"; boundary="x7tmavbsaviu3rdb"
Content-Disposition: inline
In-Reply-To: <9_7qTfdNSViwtNUGq9D13w@sntech.de>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/294.450.56
X-ZohoMailClient: External


--x7tmavbsaviu3rdb
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/5] iommu/arm-smmu-v3: power domain and clock of the
 RK3588 PCIe SMMU
MIME-Version: 1.0

Hi,

On Wed, Nov 11, 2026 at 10:53:28AM +0100, Heiko St=C3=BCbner wrote:
> Am Mittwoch, 11. November 2026, 09:02:30 Mitteleurop=C3=A4ische Normalzei=
t schrieb Shawn Lin:
> > Hi Heiko
> >=20
> > =E5=9C=A8 2026/11/10 =E6=98=9F=E6=9C=9F=E4=BA=8C 16:49, Heiko St=C3=BCb=
ner =E5=86=99=E9=81=93:
> > > Am Dienstag, 10. November 2026, 09:40:44 Mitteleurop=C3=A4ische Norma=
lzeit schrieb Shawn Lin:
> > >> Cc: Simon and Finley
> > >>
> > >> =E5=9C=A8 2026/11/10 =E6=98=9F=E6=9C=9F=E4=BA=8C 15:11, Arun Iyengar=
 via B4 Relay =E5=86=99=E9=81=93:
> > >>> The MMU-600 in front of the PCIe controllers of the Rockchip RK3588
> > >>> (mmu600_pcie) is enabled for every RK3588 board, but its node descr=
ibes
> > >>> neither the power domain it lives in (RK3588_PD_PCIE) nor its clock
> > >>> (ACLK_MMU_PCIE). Both are held by any enabled PCIe controller, whic=
h is
> > >>> why nobody noticed: on a board that enables no PCIe controller in t=
hat
> > >>> domain (an Orange Pi 5 with its M.2 slot in SATA mode, or any RK3588
> > >>> board without PCIe), genpd powers the domain off and the clock fram=
ework
> > >>> gates the clock as unused after boot, while arm-smmu-v3 stays bound.
> > >>> At reboot, arm_smmu_device_shutdown() then writes CR0 and polls CR0=
ACK on
> > >>> the dead block, the interconnect stalls, "reboot: Restarting system=
" is
> > >>> never reached and the board only comes back ~90 s later when the
> > >>> watchdog fires.
> > >=20
> > > We have a work-around for that in some boards, manually disabling the
> > > smmu until now. As the SMMU is part of the SoC and always present
> > > the general DT practice is to have it always enabled, as it does not
> > > depend on the actual board design.
> > >=20
> > > Hence we end up in the situation described above.
> > >=20
> >=20
> > I notice that mmu600_php is disabled in rk3588-base.dtsi. If describing
> > the SMMU that way is incorrect, should we enable mmu600_php as well? I'm
> > asking because I see a different picture in the RK3588 TRM: both
> > mmu600_php and mmu600_pcie reside under PD_PHP, not PD_PCIE. Therefore,
> > even without any PCIe controller enabled, PD_PHP should remain powered
> > on (it is never added in rk3588-base.dtsi, so it should be outside the
> > kernel=E2=80=99s scope). How does the original problem occur in that ca=
se?
>=20
> The original problem is the smmu probing (probably during boot when
> everything is still powered), not doing anything with it and on shutdown
> the smmu driver wanting to access the smmu registers and thus ending
> in a hang.
>=20
> So the problem is not necessarily the power-domain, but can also be
> the clocks getting turned off during clk_disable_unused.
>=20
>=20
> As for not disabling it, the case is also the some for things like the
> video-encoders - they are also present all the time, so we don't have
> devicetree wiggling for them.
>=20
> The fully correct thing would be, power-domain + clock handling
> and adding runtime-pm to the smmu for when it is not in use.
> So this would then not require any special thinking
>=20
> And yes, I think the other smmu should also use the same handling.
>=20
> @Arun care to also add a runtime-pm patch? :-)

Adding runtime PM support is already WIP:

https://lore.kernel.org/all/20260929034510.2023173-1-praan@google.com/

(this is also needed to avoid potential crashes with system
suspend/resume on RK3588, since we enable PCIe IOMMU by default)

Greetings,

-- Sebastian

--x7tmavbsaviu3rdb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmr1N5oACgkQ2O7X88g7
+poq8Q/+P0pOInRktOpa7ipZqr7ZZw0Ry5Z09iTXZlgJa5ImtfUKuwho88ecAs+Y
AijE7yqpKPfi/a0xBUyWWdrGYWhEBZo97uvlxNlLT1I5TnPXz/8xY6fP8iW09TpN
TssTFHUZH1jwpkMZx56idljsFwIwDkhbxjApqnW0CjQi9He8qx88w6AXzHC603VH
zSxHgSpyTCkNigp7txnzxrt9x1/5PZool+9mt/ougKDtOZHaQP4r8PRqvJPcMBWr
Qmn5WjkMUSaiOGv+E7WKuBO3gz5RoymMqwGdQFG6s+TnyRxvmy7ZiJZBOZcGiR8a
NdN9Ow2Q3Mh+XrSJZj5De+LWjBRbSB5urw149w07xE/1HxOFlbpR/V8nNDlBIgXT
JoUcNTKo/NMlkj8KauGJXcQUNsaNFCIQGSngnn+FyKG5rRyiGXPuaP9cDplZcVv3
WYYMtYOxLnT3ouNJ+wq6kF8N2sVzx+ezZw1ipCXVXVu2Gl49GlAIGknuBwZLVwd7
ZoM+PwQEy/AyNQY8Maefctg5zh49lZhzA7fMV5Lcg1ErLnhuBG6qBsY8N/snDPwi
EFANmXjlRCRQ8Yot+LigovbQuOZBLfUGF5Ql0u+/t8L4eyO1I53JvsRfG0k+NoZ1
aYj+apKKbcr0SFiobCOTeHLNM9DhA132MPfpMR3sVmc7aDqDq/s=
=RkWx
-----END PGP SIGNATURE-----

--x7tmavbsaviu3rdb--
