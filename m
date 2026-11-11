Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=47.88.81.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794380048;
	b=W7ZjaBV/+90xHolWp7bXBQOZdsorlmjJxEmZaAmdoJ9ytAezNNab8HQJsXoifYE3kgcZ
	 ucXI0LcjM0vZLSmIKDyHGMYF9GvZzbmOsEKRoyDAERy+T4DUqHzEs6knT9MGQWerRxm3z
	 sRj9j6+DQ20M+uQCIbW1QDZO4BRJHc5twbd0mb0iwKpVfMfTVG78VZ9TdrcOAfp5sx0bT
	 9hz8vEvgNEE6U2piBT0xZfXo1oU+PqCbfUZXcaeNVIDXlDiBGFTmdKn2IgJaUtGqY2aqf
	 LZUHsw6IdZvQScVNwAJdgXSHDy2KxBfPNwA0Omf0PZ3ZTzU5oaiB22VnKYNwR6h4U1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794380048;
	h=DMARC-Filter:Received:Message-ID:Date:MIME-Version:User-Agent:Cc:
	 Subject:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:X-HM-Spam-Status:
	 DKIM-Signature;
	bh=GkcCvQ0Cm1Qyej4YW35+cOV6C99poT4s5onAksaynHE=;
	b=OkvbCdLMIV/xdwgYZLIHM0VB6nQSYL+5QirDNk/b3MujsGOV6WiyduAcLXFQm0L6haoN
	 OwxJpoebCIP2c6sya2LrnGbSejblyubXGZqtQgwOABDn7JwKeVghfbDLNjzs+l7IWTaM3
	 PGGZ9zLVqZ+IvM5+RiaJSAgHntmKe16kuaVcGuYBjxRUh2ljpzg5bML2V4WKPj8JKRDzR
	 0i9EgqkGv0FXJL5H3ZHblTPdob1h2zwXAOwjE+HuY9RGJpblUhPQ/bd1Aa6PmOuizzqPn
	 9conn1be9X+Z64zShsImyO1NtSdc08rnsfmJ3f3975hNY82oKO3KRNrgpk1wGLo7TqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rock-chips.com;
	spf=pass smtp.mailfrom=rock-chips.com;
	dkim=pass header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=ZXmX7RJK;
	arc=none smtp.remote-ip=47.88.81.182
Received: from mail-m81182.netease.com (mail-m81182.netease.com [47.88.81.182])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2C5606A31C
	for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 06:54:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E2C5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=ZXmX7RJK
Received: from [172.16.12.48] (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 544548e9e;
	Wed, 11 Nov 2026 14:53:54 +0800 (GMT+08:00)
Message-ID: <21a44f7b-e33c-4feb-a6ba-6d08bc796606@rock-chips.com>
Date: Wed, 11 Nov 2026 14:53:52 +0800
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
 "finley.xiao" <finley.xiao@rock-chips.com>
Subject: Re: [PATCH 4/5] arm64: dts: rockchip: add the PCIe power domain to
 the RK3588 PCIe SMMU
To: aiyengar1990@gmail.com, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Niklas Cassel <cassel@kernel.org>
References: <20261110-smmu-v3-pcie-pd-v1-0-628819ca44b9@gmail.com>
 <20261110-smmu-v3-pcie-pd-v1-4-628819ca44b9@gmail.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20261110-smmu-v3-pcie-pd-v1-4-628819ca44b9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa1c962725603a4kunmb3379dd7965f5
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCT0pJVh0aGUJMSE5CQk5OHlYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
	9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=ZXmX7RJKYwKpIGWxpcLGSdUNUfljyXvYiUtUbnsd6Phb8U97ZPSlESLvBbJzV8hWLtqOLLINOhn9P6waG42+wYWblD1kQZXqhbC50WlpggnfPocO8Xuj/NTbo3b2d0qqYsy7f9rFLq9MUTPEl7lBAdF+V7UrJIHQskw2aZytPko=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=GkcCvQ0Cm1Qyej4YW35+cOV6C99poT4s5onAksaynHE=;
	h=date:mime-version:subject:message-id:from;

Hi Arun

在 2026/11/10 星期二 15:11, Arun Iyengar via B4 Relay 写道:
> From: Arun Iyengar <aiyengar1990@gmail.com>
> 
> The MMU-600 for the PCIe controllers (mmu600_pcie) is enabled for every
> RK3588 board, but its node does not describe that it lives in
> RK3588_PD_PCIE. It only works today because TF-A leaves the domain on at
> boot and, on most boards, an enabled PCIe controller holds it on later.
> 
> On a board that disables all PCIe controllers using that domain (the
> Orange Pi 5 with its M.2 slot in SATA mode is one), genpd powers
> PD_PCIE off as unused after boot while arm-smmu-v3 is still bound. Then
> at reboot arm_smmu_device_shutdown() writes CR0 and polls CR0ACK on the
> unpowered block, which stalls the bus: the kernel never reaches
> "reboot: Restarting system" and the board only comes back once the
> watchdog fires.
> 
> Describe the power domain, so genpd keeps it on for as long as the SMMU
> is bound.
> 
> Fixes: da92d3dfc871 ("arm64: dts: rockchip: enable the mmu600_pcie IOMMU on the rk3588 SoC")
> Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
> ---
>   arch/arm64/boot/dts/rockchip/rk3588-base.dtsi | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
> index aa69fd3793fd..bcd342c025c9 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
> @@ -560,6 +560,7 @@ mmu600_pcie: iommu@fc900000 {
>   			     <GIC_SPI 367 IRQ_TYPE_EDGE_RISING 0>;
>   		interrupt-names = "eventq", "gerror", "priq", "cmdq-sync";
>   		#iommu-cells = <1>;
> +		power-domains = <&power RK3588_PD_PCIE>;

As RK3588 TRM Table 7.1 desribes, both of mmu600_pcie and
mmu600_php live under PD_PHP.

>   	};
>   
>   	mmu600_php: iommu@fcb00000 {
> 

