Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC8A53D9DD
	for <iommu@lists.linux.dev>; Tue, 22 Sep 2026 11:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790077508; cv=none; b=fF/Rp9VEl0IR/Phw/EJdvPqMeLQh43tF/rVYbQXpow2NTG27jfU2yEvFqRRln5xIs2TRfilm1wpLmaODnTxVRv5pf5UJxslSaS/gWVrlZad93XamfugI+YO/OEyJe27+M2Rfr7GUmyjLtdLVPC75Vov3CrGTMrK46Z8/56hxQFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790077508; c=relaxed/simple;
	bh=nVhD/4MjWM8j1FzDpqCVCao9PsGmI7N0h8F75GJSEFc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kawPJgE9ve1MeWcL9G/fgvzFjMp5i0mRa7GXeVmSLyKZpXaG4zB2Z5K/xmprlfjGLoSnQ/4ICXRCwNmKH5Y8xb317Iww9kvOQuaAGzbZTAE2o0ztSBmbj+68S6EiBefXZ4Pp81W1O7hcusrFr9Ym+DiZOUoTfTvQaIgoJBZNmwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Dprtpitr; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Dprtpitr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1790077505;
	bh=nVhD/4MjWM8j1FzDpqCVCao9PsGmI7N0h8F75GJSEFc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Dprtpitr3AspMjmZsaSSq3vHtti7lA6slpnG0Pc2C8+HOHgqCUWk0skdav6PhFB3c
	 08PoBlmiat1O2ZJ2YfvYw4XQ19XeI41WwppXg74bNUjP5mfxsW+RoqG9GdFyWyf8MW
	 S6FyR86vOSDVdmYGrvgQcDvfFXGP5nIpH37szugpoBBYsbjiDt3wFaDfLFaywNxFN3
	 Rrcf+TaCJzEk6YPK4txB8oO7n2Eq61nbFQpWG+fOmVHfkDFmeciSxYuIDnbD4XziY6
	 +W1DUF6AouXIBaxjHtTyZo2vfRtlAhp3s/vTpdd/PPstwz1+9kJwKAgf4ju8hdWMWg
	 WyPApt70ss/ow==
Received: from [100.64.1.21] (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2985C17E03B6;
	Tue, 22 Sep 2026 13:45:05 +0200 (CEST)
Message-ID: <bef176a0-7b13-4753-9d9c-494a0bf04cea@collabora.com>
Date: Tue, 22 Sep 2026 13:45:05 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: iommu: Describe MT8195 infra IRQs
To: "Rob Herring (Arm)" <robh@kernel.org>, Yong Wu <yong.wu@mediatek.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: iommu@lists.linux.dev, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20260921232716.3134140-1-robh@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20260921232716.3134140-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/22/26 01:27, Rob Herring (Arm) wrote:
> The MT8195 infra IOMMU has one fault interrupt per IOMMU bank. Require
> the five bank interrupts, named bank0 through bank4, for this
> compatible. Keep other MediaTek IOMMUs limited to one unnamed interrupt.
> 

Why are you introducing interrupt-names, and why would that be a required property?

I disagree - interrupt names are not necessary here.

Cheers,
Angelo

> Assisted-by: LLM
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>   .../bindings/iommu/mediatek,iommu.yaml        | 30 ++++++++++++++++++-
>   arch/arm64/boot/dts/mediatek/mt8195.dtsi      |  2 ++
>   2 files changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> index 79c573c47b08..4dc5621c17e1 100644
> --- a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> @@ -100,7 +100,11 @@ properties:
>       maxItems: 1
>   
>     interrupts:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 5
> +
> +  interrupt-names:
> +    description: Names of IOMMU banks providing fault interrupts.
>   
>     clocks:
>       items:
> @@ -155,6 +159,30 @@ required:
>     - '#iommu-cells'
>   
>   allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: mediatek,mt8195-iommu-infra
> +    then:
> +      properties:
> +        interrupts:
> +          minItems: 5
> +        interrupt-names:
> +          items:
> +            - const: bank0
> +            - const: bank1
> +            - const: bank2
> +            - const: bank3
> +            - const: bank4
> +      required:
> +        - interrupt-names
> +    else:
> +      properties:
> +        interrupts:
> +          maxItems: 1
> +        interrupt-names: false
> +
>     - if:
>         properties:
>           compatible:
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> index 9aaf8b6edcb5..3e46ffaa44c6 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> @@ -937,6 +937,8 @@ iommu_infra: infra-iommu@10315000 {
>   				     <GIC_SPI 797 IRQ_TYPE_LEVEL_HIGH 0>,
>   				     <GIC_SPI 798 IRQ_TYPE_LEVEL_HIGH 0>,
>   				     <GIC_SPI 799 IRQ_TYPE_LEVEL_HIGH 0>;
> +			interrupt-names = "bank0", "bank1", "bank2", "bank3",
> +					  "bank4";
>   			#iommu-cells = <1>;
>   		};
>   

