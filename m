Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.11.138.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794390821;
	b=Gv/kBhunH2s0eqdR5qEcrSOA9xxyGxsGHy8ZNjAmHDOxQiOXOkacEcz0gTOKWOuASLjz
	 osbYXHoeG8oZc+inq2W6wu5mYjRjT3y6wxhv51CTavYMFJgHfrP+YowWluXIDV4fUoOqV
	 mz4VtrTylhcgVQpT5lLqQjXS/xB2JSwqlfyOFqtAPlDKPmAqcaGTiuTfJshOX4KAZHU8T
	 JTrt9hYQd76uidx9LSYZDlARbIunjIwv2cneL5kDuaki0PpNBBpSzPdSL+iJ/265Y+wCi
	 Xqil6mYE8gtcz756tkVl/uIU9GFAm5Z9aNXESgWC4ke1a/S40d5AKuiRkoZo2VqZCMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794390821;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type;
	bh=rOYijy98RgI2qIIiyL+QLiDNYX9ODiA3qXMCnsWdXVU=;
	b=lpVan8fj6OaYhRbZWuPcunHI0BSP9CyCM1ey5Nx9g2Wfz8RzqvPr/7IJyusOf4YYjYO3
	 AM87iTYix/8REfeXCbR1TYwEv+gmO6PKLELHGgx7mHVezBpGFDHotOd6lN9Q13wCLpo26
	 81oxQwOTOB/FsSJHYbQoL3btxhi/OdSE268czgZQhvNdX8SrrfoVnzamwBtvGbl1Qfoyc
	 SY3MnurSVXizICXfJ3+j5+B3Mn9BgOVBZA12/T2O0sfjWgrTsoXWYllqbQHEVYH4wiZMT
	 Fj/ODmcPvq22+BVNZ4zYsO0zgK32uOOJK47TZcseF/mDInhX6Wyme7uMyZR7WvXl/MQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sntech.de;
	spf=pass smtp.mailfrom=sntech.de;
	dkim=pass header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=28SzyvUr;
	arc=none smtp.remote-ip=185.11.138.130
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB78F606A324;
	Wed, 11 Nov 2026 09:53:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB78F606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=28SzyvUr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=rOYijy98RgI2qIIiyL+QLiDNYX9ODiA3qXMCnsWdXVU=; b=28SzyvUrJWEKkHHZXCa1oDz4JF
	PlSX5euAAMQyENwudCVR6cTty+VH1jG/mgo73RBjbiZivnZXrK+AHWj4VHdAF7otI7kK0Ynp2wXix
	WRr27PFPkEjrC5iXrkptO3jjbv/C5C4O6OsdamoQ/Zew2t5ZPng/9RL6GZtaX0pN5yybStTSI/Wni
	VkuKQaOUKYWbYnyU/Mdd2eaVbg0rSr+BKaCuckVeOyYGhiGO/sF2AJtcyfDT4SKsWXQf44zSah16c
	onKYsT1a7e5TG2rx/E6cxZ/NNmWFX9JRutQCBH8O6CmfwPXX/5a1UWBneR8+DnlP7+TH4FMCM/KdP
	3HqbLhtg==;
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
Date: Wed, 11 Nov 2026 10:53:28 +0100
Message-ID: <9_7qTfdNSViwtNUGq9D13w@sntech.de>
In-Reply-To: <ea8fa04c-4a8c-4c55-b4fa-f37d74267e93@rock-chips.com>
References:
 <20261110-smmu-v3-pcie-pd-v1-0-628819ca44b9@gmail.com>
 <10924894.NyiUUSuA9g@diego>
 <ea8fa04c-4a8c-4c55-b4fa-f37d74267e93@rock-chips.com>
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

Am Mittwoch, 11. November 2026, 09:02:30 Mitteleurop=C3=A4ische Normalzeit =
schrieb Shawn Lin:
> Hi Heiko
>=20
> =E5=9C=A8 2026/11/10 =E6=98=9F=E6=9C=9F=E4=BA=8C 16:49, Heiko St=C3=BCbne=
r =E5=86=99=E9=81=93:
> > Am Dienstag, 10. November 2026, 09:40:44 Mitteleurop=C3=A4ische Normalz=
eit schrieb Shawn Lin:
> >> Cc: Simon and Finley
> >>
> >> =E5=9C=A8 2026/11/10 =E6=98=9F=E6=9C=9F=E4=BA=8C 15:11, Arun Iyengar v=
ia B4 Relay =E5=86=99=E9=81=93:
> >>> The MMU-600 in front of the PCIe controllers of the Rockchip RK3588
> >>> (mmu600_pcie) is enabled for every RK3588 board, but its node describ=
es
> >>> neither the power domain it lives in (RK3588_PD_PCIE) nor its clock
> >>> (ACLK_MMU_PCIE). Both are held by any enabled PCIe controller, which =
is
> >>> why nobody noticed: on a board that enables no PCIe controller in that
> >>> domain (an Orange Pi 5 with its M.2 slot in SATA mode, or any RK3588
> >>> board without PCIe), genpd powers the domain off and the clock framew=
ork
> >>> gates the clock as unused after boot, while arm-smmu-v3 stays bound.
> >>> At reboot, arm_smmu_device_shutdown() then writes CR0 and polls CR0AC=
K on
> >>> the dead block, the interconnect stalls, "reboot: Restarting system" =
is
> >>> never reached and the board only comes back ~90 s later when the
> >>> watchdog fires.
> >=20
> > We have a work-around for that in some boards, manually disabling the
> > smmu until now. As the SMMU is part of the SoC and always present
> > the general DT practice is to have it always enabled, as it does not
> > depend on the actual board design.
> >=20
> > Hence we end up in the situation described above.
> >=20
>=20
> I notice that mmu600_php is disabled in rk3588-base.dtsi. If describing
> the SMMU that way is incorrect, should we enable mmu600_php as well? I'm
> asking because I see a different picture in the RK3588 TRM: both
> mmu600_php and mmu600_pcie reside under PD_PHP, not PD_PCIE. Therefore,
> even without any PCIe controller enabled, PD_PHP should remain powered
> on (it is never added in rk3588-base.dtsi, so it should be outside the
> kernel=E2=80=99s scope). How does the original problem occur in that case?

The original problem is the smmu probing (probably during boot when
everything is still powered), not doing anything with it and on shutdown
the smmu driver wanting to access the smmu registers and thus ending
in a hang.

So the problem is not necessarily the power-domain, but can also be
the clocks getting turned off during clk_disable_unused.


As for not disabling it, the case is also the some for things like the
video-encoders - they are also present all the time, so we don't have
devicetree wiggling for them.

The fully correct thing would be, power-domain + clock handling
and adding runtime-pm to the smmu for when it is not in use.
So this would then not require any special thinking

And yes, I think the other smmu should also use the same handling.

@Arun care to also add a runtime-pm patch? :-)


Heiko


