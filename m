Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794323661;
	b=zRM+C0VH+3iUFmuk694VlrjiV7zJe74OiVZLG0ng8B2Cc0vzOoOjBE4nuOOWP+2Pbp5c
	 93OnjyAAb7zyFwKSX7YKZ5IZ1XUtqO5PxOVF5zTysqjTj5ko1ryyBedPfXmT5PyLxOidQ
	 xSyLw3XV5PApcxkZ87RdcwFFz4lqSfyTWPxxEpnysRN+TdZz53YoDmm5eac9ZvkL2xTsx
	 vU6JkSVl3hKTij2n4MtUBSi8z/sY1rWqLqeD5PKdV5/c8EtRksvdGP4OTH7AVLfWcp6iT
	 kMuCLfXkQyas+wX3ws/FwhBZhEPgqQnc6LopA/DKPQJAsgCZGNugxzld0uxwz+sfziQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794323661;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Zoho-Virus-Status:X-Zoho-AV-Stamp:
	 X-ZohoMailClient;
	bh=Ca7+Dqd4E/749T+VRqLM/gfMqPGBPdrU7OyQ5kokKWw=;
	b=mSP3QQrwwANAJyDKMeumnovhuX+dqwYB5WkSz/myuYzzf9htb5d0lNlWikyo+x0TMyWx
	 Sct3G/Pc2Vm0H9juqVH8oDY1BifV4qDy8ttelXG1xRXHQL1+3Q0cK1WzBLCXOif0iqzYX
	 O6i9uNslcGzv7L3eKs7x386BmH7Ielx1CVQ1zEjdr+sZ83MXsX3U0wpur7usgdda8Hlcn
	 sRoBtzQMFQlbCQssxs7rK+5jkM65AFYIDKijV7iHlp6gFuTq6Q31kjzEmXCtjC5ymTTQp
	 3P7n8lvzA6u2M2A1f6aqxYV7/lU7Qa9usGe/3BzmOcGKAraYMaSI+/wJKAhL+6snmhg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=TIHnyEb2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.11
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com [165.173.182.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4431C60A260C
	for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 15:14:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4431C60A260C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=TIHnyEb2
ARC-Seal: i=1; a=rsa-sha256; t=1794323645; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=lJe5WwfPQsboU9jabFq1Vhi5ZfpWQL282ERr2ptHz//+dM4i6Bc2YFDCXyugFvqgHH3nFHnCmDWnITQ/qh+WtyNmQmuilitgdMuQDOM4CzV++xQuYXlY29dqnp0s9ltOt68wysZMvrO9B8zQuWFalhOg6OoBwyJMo5oc2qYXm+M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794323645; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Ca7+Dqd4E/749T+VRqLM/gfMqPGBPdrU7OyQ5kokKWw=; 
	b=iCeL2J52dTRD0dWv0gR8dcKEIusicoe+++W979gN3D6e0FZCXbfpwNQVDMjprd/vyEUR72npI3rZ532I/kpwbW5uM8XmIuvk9D2pblS6pVoHS4nUD3Lm8lN1hYqZMcsZImciiJ5vveDIqsgeDAu7ZQr43ITNoBWlkkRN/Ncsi1s=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: a=rsa-sha256; b=TIHnyEb23ivDdlDaTZ23hgRBxU6pCSlmo4+pnq+FIf3oLa5YXU+wP+8Ie7Zo+WbWMwIW7RKOejdeUD8YdqSOTFhxEgzsP7NCKIEotA3WzUUkaNdPKf6Qcu/qwaX4cnnnKvKe9+JoxoQpuy+tEDxNibVJi3lPSv60bTpZca+Mftw=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=Ca7+Dqd4E/749T+VRqLM/gfMqPGBPdrU7OyQ5kokKWw=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794323644960444.4158919867489;
	Tue, 10 Nov 2026 07:14:04 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id 3EDC5180354; Tue, 10 Nov 2026 16:13:49 +0100 (CET)
Date: Tue, 10 Nov 2026 16:13:48 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: aiyengar1990@gmail.com
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	"Joerg Roedel (AMD)" <joro@8bytes.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Niklas Cassel <cassel@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 0/5] iommu/arm-smmu-v3: power domain and clock of the
 RK3588 PCIe SMMU
Message-ID: <avMzjsG_Zl8Gh0wJ@venus>
References: <20261110-smmu-v3-pcie-pd-v1-0-628819ca44b9@gmail.com>
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
	protocol="application/pgp-signature"; boundary="24vzfqtpamx44f6c"
Content-Disposition: inline
In-Reply-To: <20261110-smmu-v3-pcie-pd-v1-0-628819ca44b9@gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.7.7.1.5.4/291.452.71
X-ZohoMailClient: External


--24vzfqtpamx44f6c
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/5] iommu/arm-smmu-v3: power domain and clock of the
 RK3588 PCIe SMMU
MIME-Version: 1.0

Hi,

On Tue, Nov 10, 2026 at 07:11:47AM +0000, Arun Iyengar via B4 Relay wrote:
> The MMU-600 in front of the PCIe controllers of the Rockchip RK3588
> (mmu600_pcie) is enabled for every RK3588 board, but its node describes
> neither the power domain it lives in (RK3588_PD_PCIE) nor its clock
> (ACLK_MMU_PCIE). Both are held by any enabled PCIe controller, which is
> why nobody noticed: on a board that enables no PCIe controller in that
> domain (an Orange Pi 5 with its M.2 slot in SATA mode, or any RK3588
> board without PCIe), genpd powers the domain off and the clock framework
> gates the clock as unused after boot, while arm-smmu-v3 stays bound.
> At reboot, arm_smmu_device_shutdown() then writes CR0 and polls CR0ACK on
> the dead block, the interconnect stalls, "reboot: Restarting system" is
> never reached and the board only comes back ~90 s later when the
> watchdog fires.
>=20
> Patches 1 and 2 allow power-domains and clocks in the arm,smmu-v3
> binding (arm,smmu.yaml already allows both for the earlier SMMUs).
> Patch 3 makes the driver get and enable the clocks of its firmware node
> before the first register access, for as long as it is bound; nodes
> without clocks (and ACPI/IORT systems) are unaffected. Patches 4 and 5
> describe the power domain and the clock in rk3588-base.dtsi. Both DT
> patches are needed: with the power domain alone the clock is still
> gated and the shutdown still hangs.
>=20
> Related: Pranjal Shrivastava's "iommu/arm-smmu-v3: Add runtime PM
> support" v11 (2026-09-29, 20260929034510.2023173-1-praan@google.com,
> not merged) adds pm_domain-based runtime PM and resumes the SMMU around
> shutdown, but has no clock handling. This series is compatible with it:
> once it lands, the clocks from patch 3 should move into its runtime
> suspend/resume callbacks.
>=20
> Tested on an Orange Pi 5 (RK3588S) with the M.2 slot in SATA mode and
> the root filesystem on the SATA SSD, where every reboot used to hang:
> three consecutive reboots printed "reboot: Restarting system" and the
> boot loader started 0.6 s later (previously ~89 s, from the watchdog);
> clk_summary shows aclk_mmu_pcie enabled with iommu@fc900000 as consumer
> and pm_genpd_summary shows PD_PCIE on; the SMMU probes as before and
> SATA keeps running at 6.0 Gbps without errors. With patch 4 alone
> (power domain, clock still gated) the reboot still hung at
> "arm-smmu-v3 fc900000.iommu: shutdown" on the serial console. Boards
> with PCIe enabled are already in the state these patches describe.
>=20
> This series was developed with Claude (Anthropic) as a coding assistant:
> it wrote the code and the commit messages, and I reviewed and tested
> every change as described above.
>=20
> Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
> ---

While at it, maybe also add the reset line (SRST_A_MMU_PCIE on
RK3588) to make the hardware description complete? See also the
MMU-600 TRM, that there is one clock and one reset line:

Link: https://support.arm.com/documentation/100310/0202/Signal-descriptions=
/Clock-and-reset-signals?lang=3Den

Greetings,

-- Sebastian

--24vzfqtpamx44f6c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmrzNKwACgkQ2O7X88g7
+prULQ//VEgh6N9Y3WLpzFsig1dhiT2LoeoOtAVe85S1Tbd7/c3fTMzrhVzWhVFq
W3WBHB+HGc66sORyvrmexq2QVFCcwp10rhrgc78z+K2d84NJilMXrnB2YcjCRWtC
8m5sCiP0PA64jV41kv/NQ7++CBG2MVSkXZdqJvua7BCSW6jBtxEx0H6hAYsomNkK
tJb7BKs2XbWg7Evz/zQmSNSAZLCSu938nBIrX+eh1Z3vFrvWx6Z1TK5vn5IDD6LT
p6Oy1i8suyCXOus6c/LLUy/saeg3QoksFYWMV7TcCZk0mplPGDdyzjjH4W/yihqi
CvgBkzOxY6AZfTkzhJZ94LzuuhdbKZQemaHaE9sBZQ6Zs6+RCjlWBLnKsOy7Ut55
ZbncW/uK5OFJTfGgsrG5cNwTN+GJGKXlVdqmgjh6mo7ItQrbK91XoZH3oAC02ZDy
+F75j6CS57Cb/QtObqTakXOiyBlwB393eeVhVmBnHb5xmt7vmmR9h4w4I/sxwokO
5Vbg7RFZuS38HrbtRXOMkCZAOvDvBJ4zQ8dWGI6rMdrfMffpfLGd7sjIho/vZJo7
wta4vE2aYvEguH9aoEGrztvW0UgjqMOGfI+txG3u7Mxv6O8ZujV8tR6QOLx8pCAd
sDav3IQ9EtmrV4NTZnIcVtkZ4Go3kbrhPlVfDSXQtZqBI8rGQAY=
=DQeM
-----END PGP SIGNATURE-----

--24vzfqtpamx44f6c--
