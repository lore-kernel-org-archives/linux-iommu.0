Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8B8153BE8;
	Fri, 31 May 2024 08:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717144963; cv=none; b=PVv1n1JfzE93RN2/Lg2OFOIHul6JOMz6doFuGWgvgbl9DvV26etGsmlDRwrge4dJTv7OhGK9EhM6aPhWkav5Vrky1U43k+PFN1bIa8VTqa5SYKswUyfu54u9eDPXX2YTTVKd1Nq/RicVMDR8LLPxABQeFMX5EALj8WiVHAFSPH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717144963; c=relaxed/simple;
	bh=CF7FQcgTD5C4gVve+D4MF3p3RzrOMqyJxBAKLPvDFmY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ND72T1V2JiU6pMEKEWRb+dTig/oPUl6CdjtX138de+mvbMkJEw3OOR4MfkIJrUsVU6vhMlUa1S+AtTUh2caf0cQ5hEK/EeIJM1Gr6W99Qml/2fWe6qD1T9eaTAhbYWXLkwFabSv6eQOWaP0BVCqdRjBUAvvfQnYG51NJw+YJPtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 315ED113E;
	Fri, 31 May 2024 01:43:05 -0700 (PDT)
Received: from [10.57.67.251] (unknown [10.57.67.251])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5CAAF3F792;
	Fri, 31 May 2024 01:42:38 -0700 (PDT)
Message-ID: <bc550e12-7ad6-4592-994d-dca5a95e88ca@arm.com>
Date: Fri, 31 May 2024 09:42:36 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] arm64: dts: allwinner: h616: add IOMMU node
To: Andre Przywara <andre.przywara@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>
Cc: Chris Morgan <macromorgan@hotmail.com>, Ryan Walklin
 <ryan@testtoast.com>, iommu@lists.linux.dev, devicetree@vger.kernel.org,
 linux-sunxi@lists.linux.dev, linux-arm-kernel@lists.infradead.org
References: <20240530233800.27705-1-andre.przywara@arm.com>
 <20240530233800.27705-6-andre.przywara@arm.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20240530233800.27705-6-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-05-31 12:38 am, Andre Przywara wrote:
> The Allwinner H616 contains a scatter-gather IOMMU connected to some
> video related devices. It's almost compatible to the one used in the H6,
> though with minor incompatibilities.
> 
> Add the DT node describing its resources, so that devices like the video
> or display engine can connect to it.

Without also describing those connections, though, having this node 
enabled in the DT means the driver will just bind, block DMA, and 
prevent those devices from working. That's probably not what you want.

Thanks,
Robin.

> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>   arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
> index 9c1980e24cb21..44f04619a43ac 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
> @@ -320,6 +320,15 @@ x32clk_fanout_pin: x32clk-fanout-pin {
>   			};
>   		};
>   
> +		iommu: iommu@30f0000 {
> +			compatible = "allwinner,sun50i-h616-iommu";
> +			reg = <0x030f0000 0x10000>;
> +			interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&ccu CLK_BUS_IOMMU>;
> +			resets = <&ccu RST_BUS_IOMMU>;
> +			#iommu-cells = <1>;
> +		};
> +
>   		gic: interrupt-controller@3021000 {
>   			compatible = "arm,gic-400";
>   			reg = <0x03021000 0x1000>,
