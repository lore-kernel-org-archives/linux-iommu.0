Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A0214F98;
	Mon, 16 Jun 2025 14:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750084044; cv=none; b=CESF8mw/j3f0psaYNvgR2GLWyzX/qxCflOsyht0Aak2uKpOERUjW7GT5zuGhmWoyz89Ac69wiyJhtAwUU92TPwabffOBozBUXmDRVWnuoIff1zxsZtVhO3TOxSDsiEN0xG/xiUP9PlL+aw+2xAh9Q016ZZNDDoiUReWHRGTGJ8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750084044; c=relaxed/simple;
	bh=uVv7MVHl65v5TQ5atsNpH/OqOcoy86TyB38oIyuB9Gs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s0YFZDm17srCUptvQOJuPFde77adp9nqG2JgJsVUszy7sLtTd7um3LFLDG8wlwTo2R3GFm3kLuFH9xhXARzI82t5m3IDTyA5piLwBfJuijTRTQ83k4n9WBiZJ8tx7MDXw6yxMHzoj6bOWCExzcgjDxvmGdNqCmeZgqvdPBMJPkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m3rR1IJ5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3rR1IJ5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A18EC4CEEA;
	Mon, 16 Jun 2025 14:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750084044;
	bh=uVv7MVHl65v5TQ5atsNpH/OqOcoy86TyB38oIyuB9Gs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m3rR1IJ5Z5MLV/cpapI9lGaiRVfRkzWtMkjIeTAvF839NaO/kONUVEoSEargbvt0g
	 ijZRzVoyBwgcbpuJEgSdEcDfdBX5IQl73mEoVRlKeablQoA5rxJhmZM689Zb5T8ToB
	 fdCwx3t8geYkoZrjO9ZGRZuG0cLuHVjdJuB9QRkFvypSEOY+zubQ6nX4XYLYsTpeC6
	 Xr+75TddJ5YYQv+Ql9NHQi03Snbt6rUPNCXf3p60MBOMoY7rB/kZOPb5VPUG+imr/r
	 GOHB1ZdDvzKneYlYz/jRpDmTL/0w0uwl8FwTKCST4fbcLlz1vwVz4OFsjw8VznQl2C
	 c5IFXgTwtfqZw==
Date: Mon, 16 Jun 2025 09:27:23 -0500
From: Rob Herring <robh@kernel.org>
To: Xueqi Zhang <xueqi.zhang@mediatek.com>
Cc: Yong Wu <yong.wu@mediatek.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Project_Global_Chrome_Upstream_Group@mediatek.com,
	Ning li <ning.li@mediatek.com>, linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [RFC PATCH 1/8] dt-bindings: iommu: mediatek: Add mt8196 support
Message-ID: <20250616142723.GA515421-robh@kernel.org>
References: <20250616025628.25454-1-xueqi.zhang@mediatek.com>
 <20250616025628.25454-2-xueqi.zhang@mediatek.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250616025628.25454-2-xueqi.zhang@mediatek.com>

On Mon, Jun 16, 2025 at 10:56:07AM +0800, Xueqi Zhang wrote:
> 1. Mediatek has its own implementation for wrapper interrupts and
> power management. Add the SoC specific compatible for MT8196
> implementing arm,smmu-v3.
> 2. APU SMMU need wait until its power is ready, thus add a phandle
> smmu-mediatek-parents to its power node.
> 
> Signed-off-by: Xueqi Zhang <xueqi.zhang@mediatek.com>
> ---
>  .../bindings/iommu/arm,smmu-v3.yaml           | 24 ++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
> index 75fcf4cb52d9..c9a99e54de69 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
> @@ -20,7 +20,12 @@ properties:
>    $nodename:
>      pattern: "^iommu@[0-9a-f]*"
>    compatible:
> -    const: arm,smmu-v3
> +    - description: MediaTek SoCs implementing "arm,smmu-v3"
> +      items:
> +        - enum:
> +            - mediatek,mt8196-apu-smmu
> +            - mediatek,mt8196-mm-smmu
> +        - const: arm,smmu-v3
>  
>    reg:
>      maxItems: 1
> @@ -69,11 +74,28 @@ properties:
>        register access with page 0 offsets. Set for Cavium ThunderX2 silicon that
>        doesn't support SMMU page1 register space.
>  
> +  mediatek,smmu-parents:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      A phandle to the SMMU's power node. The SMMU should wait until its power
> +      is ready

What's wrong with the power-domains binding? Don't add vendor specific 
properties to a common IP block.

Rob
