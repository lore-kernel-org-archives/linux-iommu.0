Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.209.128.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794300059;
	b=Yf/JBG13DqgZ5fCUDamHkg74VvP4cgeu3ULdq+WapZsnfUt3cM2ixLwOiX4tSCsr4bVd
	 CeKEFIAd0vmfL5chlc8ZEQbZrun3Q9sbG26/SWkiEewdMyN3+jexvEWERFgT8PKYiHyS1
	 Z7IN4IcUuabiiY8hdQRM+cQZuQ/TtY43C5LKiT9DzWtEYlV2zwrd7uQCY10A8QFudJUxK
	 Sy6k7nQCc9UF1VLFNCRYrn9tGfvc0VVGmvmWF+ID19qA992Dko5jfNe4Jc++lAglPafp1
	 iukbkO8fuIsSlXf9361TzGRgqGodATZISaL0sUzP3nqYmyNreZ6cPx1N68+p15P7cNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794300059;
	h=DMARC-Filter:Received:Message-ID:Date:MIME-Version:User-Agent:Cc:
	 Subject:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:X-HM-Spam-Status:
	 DKIM-Signature;
	bh=2tnTx+Y1fIgKicxn0toiFZfZX4oNt2OFXzdiYm7aVCA=;
	b=Vr/0PBVePyY7oT3M2dlgkObClL06IvkkYHQWXAzFgWnLnaQJ+NPoIlQYFUvsuP+VX6Jw
	 Jxs9CiO+8cqzrtQQOx2s3fkdGJ5DbJoUky672IUhvyy3S+TzMFGtMArVHiDqL4rx9+dk6
	 90bmStJHekWHSdbivFcrlR6xNRGEvvp7VO8+6gmPBNZttRPnsFGAFfkdNn+OJIirN1g8h
	 cJIkyedgz5rCGhzkLBah9AQxwUTjf1iM0ebd5n76p+otVHhr4JUBT6ZW2sNl+A+gfwL+b
	 1GsL4baXW0Ma25daIEpD45pdTcDDF2s/y0Gp7mz46nleR01B9NjU8wvbX2dkJ2ResJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rock-chips.com;
	spf=pass smtp.mailfrom=rock-chips.com;
	dkim=pass header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=Ub1Vz6pg;
	arc=none smtp.remote-ip=103.209.128.9
Received: from mail-m1289.netease.com (mail-m1289.netease.com [103.209.128.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC5A606A321
	for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 08:40:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BAC5A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=Ub1Vz6pg
Received: from [172.16.12.48] (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 5423d7e15;
	Tue, 10 Nov 2026 16:40:46 +0800 (GMT+08:00)
Message-ID: <7e053777-31ee-4127-af53-0820e852d375@rock-chips.com>
Date: Tue, 10 Nov 2026 16:40:44 +0800
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 Simon Xue <xxm@rock-chips.com>, "finley.xiao" <finley.xiao@rock-chips.com>
Subject: Re: [PATCH 0/5] iommu/arm-smmu-v3: power domain and clock of the
 RK3588 PCIe SMMU
To: aiyengar1990@gmail.com, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Niklas Cassel <cassel@kernel.org>
References: <20261110-smmu-v3-pcie-pd-v1-0-628819ca44b9@gmail.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20261110-smmu-v3-pcie-pd-v1-0-628819ca44b9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa1c49deb4a03a4kunme182f695684554
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaTxgYVk8dSRkfTh5OTx9ITFYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pKQk1VSktLVUpCWQY+
DKIM-Signature: a=rsa-sha256;
	b=Ub1Vz6pg4k6UDZWkqzesWeqUcDzAnME4g7qqjqvvetdVS/Ss/SwQXxpNyBNYMdrUu/8p/ufPvd5dmdHK4QSGnWfq3IjAecSeG3pCLk7ElJpWWcjAWfAbiW1rMa5gcgNzalcqvN8CF4cWUxh29xpvhKY4L5PyMUWV01V2VvR56Bg=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=2tnTx+Y1fIgKicxn0toiFZfZX4oNt2OFXzdiYm7aVCA=;
	h=date:mime-version:subject:message-id:from;

Cc: Simon and Finley

在 2026/11/10 星期二 15:11, Arun Iyengar via B4 Relay 写道:
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
> 
> Patches 1 and 2 allow power-domains and clocks in the arm,smmu-v3
> binding (arm,smmu.yaml already allows both for the earlier SMMUs).
> Patch 3 makes the driver get and enable the clocks of its firmware node
> before the first register access, for as long as it is bound; nodes
> without clocks (and ACPI/IORT systems) are unaffected. Patches 4 and 5
> describe the power domain and the clock in rk3588-base.dtsi. Both DT
> patches are needed: with the power domain alone the clock is still
> gated and the shutdown still hangs.
> 
> Related: Pranjal Shrivastava's "iommu/arm-smmu-v3: Add runtime PM
> support" v11 (2026-09-29, 20260929034510.2023173-1-praan@google.com,
> not merged) adds pm_domain-based runtime PM and resumes the SMMU around
> shutdown, but has no clock handling. This series is compatible with it:
> once it lands, the clocks from patch 3 should move into its runtime
> suspend/resume callbacks.
> 
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
> 
> This series was developed with Claude (Anthropic) as a coding assistant:
> it wrote the code and the commit messages, and I reviewed and tested
> every change as described above.
> 
> Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
> ---
> Arun Iyengar (5):
>        dt-bindings: iommu: arm,smmu-v3: allow a power domain
>        dt-bindings: iommu: arm,smmu-v3: allow clocks
>        iommu/arm-smmu-v3: enable optional clocks
>        arm64: dts: rockchip: add the PCIe power domain to the RK3588 PCIe SMMU
>        arm64: dts: rockchip: add the clock of the RK3588 PCIe SMMU
> 
>   Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml | 10 ++++++++++
>   arch/arm64/boot/dts/rockchip/rk3588-base.dtsi            |  2 ++
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c              |  7 +++++++
>   3 files changed, 19 insertions(+)
> ---
> base-commit: 2cf4be57b301ed2d7af82e70cff5dfd96894d8de
> change-id: 20261110-smmu-v3-pcie-pd-a2f127b81d8f
> 
> Best regards,
> --
> Arun Iyengar <aiyengar1990@gmail.com>
> 
> 
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
> 

