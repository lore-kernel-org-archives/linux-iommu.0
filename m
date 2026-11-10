Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.11.138.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794300576;
	b=AjoAqKtWc1+/UnTzAliUpyM+X8M1T9XFesSbOfa68VUwR2tsw2ER/et6Qe5oQUMFUjfR
	 spOlyZx+4SRhVCU3HvUMbgjDiAV+mKSMHKqgth0AHfX7nlOf7dtrg/ulsSQE8jIBqL/in
	 Paazy5RjfTadcRxxaMM8OpdIoVVZwcAbwLFj+Rt8iaPCq7VBOrfj2oWhe2KBeOR2BeyR9
	 r/u20Unx6AFRXWJccTJ8WgCKcfbMrYeQnMIoZRalJpw1nR+pNd74q4YAeR/de9DUMTNVJ
	 mFamdYtpoNWtxSh4/E0qgUI4Peh5e2JF8WymVh1my4Wz9wcmGn3i1TXbBY8rdpGhMSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794300576;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type;
	bh=aHn8KcgHhLcXL95P9INTAmVAeZpvAJPCq7Suu5pEHwk=;
	b=cDFwRT3MIDxvq0mrBB3Kq/6VfFnFDDXiB1/UqEgkB/q2pcYm2RHYyzZ+nM3KYmby8vF6
	 GmwYjnNUPyhZP1UvtZKvBnc/camkOzHqKvYTRT1tgROUWSTrgosuodjYM0yD75NrdcNYs
	 o3OMDdsRD5TkbwdYmWoWki+C3Bt6Friz8HiwA/djvAlcI7CfGag+rTGDlKcuTgTeG28W9
	 idpkGZsKnQ89QNI4EBnU6fXezVzH1pP0e0WTqqRvsbiZNOEWFE8JXKKelofU4VKfyjG1A
	 uk4ztcDBmDg2UzlaGqdeunmmB1ErRtRoUdCxQhxqzDzAtBYoKdjxAOo0DpqSIO6Shfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sntech.de;
	spf=pass smtp.mailfrom=sntech.de;
	dkim=pass header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=KZ7GbPpj;
	arc=none smtp.remote-ip=185.11.138.130
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC80606A31C;
	Tue, 10 Nov 2026 08:49:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BBC80606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=KZ7GbPpj
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=aHn8KcgHhLcXL95P9INTAmVAeZpvAJPCq7Suu5pEHwk=; b=KZ7GbPpjr8rhjj9TeCSN3isJMo
	4d122GgaAflfPr6ZO4ozp74l8SzqGjVsu5H6TFM2vMhzmL0KHht4wMTwld3FIKNZ8RCqHqHs4jcgV
	v83dvQpMXC0J35H4CocMuWLe3GQWQip4RgxB9bd28fy1oU+bREnQbTP6s89Rxpecyd3teH+M5USVw
	ZhnyQ/EhBeB8TNton7OX7iwnUvu+OQeTaHKe12xysLOnzjUoTwOovZI5eCPjfEW3Tjn10GDXQjiUk
	sMmsr7Jx78SnG58k0FIX2G0gYSMFPfijeXJxkR4cFyERpEqF35KcnYXRp1JFGQaq61Ii8HYqvm/vU
	7OtWoU3A==;
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: aiyengar1990@gmail.com, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 Shawn Lin <shawn.lin@rock-chips.com>
Cc: shawn.lin@rock-chips.com, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 Simon Xue <xxm@rock-chips.com>, "finley.xiao" <finley.xiao@rock-chips.com>
Subject:
 Re: [PATCH 0/5] iommu/arm-smmu-v3: power domain and clock of the RK3588 PCIe
 SMMU
Date: Tue, 10 Nov 2026 09:49:29 +0100
Message-ID: <10924894.NyiUUSuA9g@diego>
In-Reply-To: <7e053777-31ee-4127-af53-0820e852d375@rock-chips.com>
References:
 <20261110-smmu-v3-pcie-pd-v1-0-628819ca44b9@gmail.com>
 <7e053777-31ee-4127-af53-0820e852d375@rock-chips.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Dienstag, 10. November 2026, 09:40:44 Mitteleurop=C3=A4ische Normalzeit =
schrieb Shawn Lin:
> Cc: Simon and Finley
>=20
> =E5=9C=A8 2026/11/10 =E6=98=9F=E6=9C=9F=E4=BA=8C 15:11, Arun Iyengar via =
B4 Relay =E5=86=99=E9=81=93:
> > The MMU-600 in front of the PCIe controllers of the Rockchip RK3588
> > (mmu600_pcie) is enabled for every RK3588 board, but its node describes
> > neither the power domain it lives in (RK3588_PD_PCIE) nor its clock
> > (ACLK_MMU_PCIE). Both are held by any enabled PCIe controller, which is
> > why nobody noticed: on a board that enables no PCIe controller in that
> > domain (an Orange Pi 5 with its M.2 slot in SATA mode, or any RK3588
> > board without PCIe), genpd powers the domain off and the clock framework
> > gates the clock as unused after boot, while arm-smmu-v3 stays bound.
> > At reboot, arm_smmu_device_shutdown() then writes CR0 and polls CR0ACK =
on
> > the dead block, the interconnect stalls, "reboot: Restarting system" is
> > never reached and the board only comes back ~90 s later when the
> > watchdog fires.

We have a work-around for that in some boards, manually disabling the
smmu until now. As the SMMU is part of the SoC and always present
the general DT practice is to have it always enabled, as it does not
depend on the actual board design.

Hence we end up in the situation described above.

So this series fixes the actual underlying problem, making these
workarounds unnecessary in the future :-)


So definitly thanks a lot
Heiko


