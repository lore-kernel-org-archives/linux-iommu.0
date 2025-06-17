Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FB4C2D1;
	Tue, 17 Jun 2025 06:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750141702; cv=none; b=lDwcudUd9euXmblN4sR9Lzkqm4CnSZ4Hmn/QteNJfB6oJR/tzI08LjJOX7bT2K49Z/RQh7XBw0FEWif0iXxbsggUOqvS6HlqdEnf/HtWxHjDCx34K2qeN42Nh0aiIfYYIgkq5i9W8XJYxhqIxN0nhwpDMUB1pKWrvTm6O10edx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750141702; c=relaxed/simple;
	bh=LF9auu4JR+Lf7VFoXANiRubeszBNmKcaT9+J6iYCMqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xzv9SfPAs9s+VVZuigNQYhs2joW+EJzL9vfOc8Xs8Av+tLkuU9Dl391vSRcdHvL5khfSt8xGn/an6dr4qtcsZ2I3MyisF9WAx0QeZo8X7J8fn53WS0mnktvFwzyott1On+LYpANGsO26eVqZ7mMiD12rJb1JGQQ1A4pBkDPTYmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=si0ySmFf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="si0ySmFf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DB45C4CEE7;
	Tue, 17 Jun 2025 06:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750141701;
	bh=LF9auu4JR+Lf7VFoXANiRubeszBNmKcaT9+J6iYCMqQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=si0ySmFf06Kx/pNC4mfe6nBcvFNV89lyyiFLJWdWrDmhso9gixojQO98veDgzlFS2
	 bS4eVP0/5UE4jURK+g1fRox6cuIv53sWw8Du+l6BfR1pPc0WQR4nceAvkuxGbqQw9q
	 HfsqK6V1xxQJPg7WDS0pb1SyDq2oY+HTxzLt4PdtAfaEnySYIVD2h9q+wO2LNP5LYB
	 SHFzQ99MFGGSFuxx9uYyrD9ZT5pD96cdUNXz/RlL96Y9hQbrjGZN3HL3XSror6hl1l
	 gCpKHF9/DfjEtIPPPvZWYUlLuCeyvNBZrGZFyXg9voZF6JW2FP/NWHR6QBwPzE7YJu
	 snYheb0NY7lNQ==
Date: Tue, 17 Jun 2025 08:28:19 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Xueqi Zhang <xueqi.zhang@mediatek.com>
Cc: Yong Wu <yong.wu@mediatek.com>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Project_Global_Chrome_Upstream_Group@mediatek.com, 
	Ning li <ning.li@mediatek.com>, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [RFC PATCH 1/8] dt-bindings: iommu: mediatek: Add mt8196 support
Message-ID: <20250617-woodoo-uakari-of-cubism-c2bedf@kuoka>
References: <20250616025628.25454-1-xueqi.zhang@mediatek.com>
 <20250616025628.25454-2-xueqi.zhang@mediatek.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250616025628.25454-2-xueqi.zhang@mediatek.com>

On Mon, Jun 16, 2025 at 10:56:07AM GMT, Xueqi Zhang wrote:
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

You just broke every existing user, so this was not tested.

Limited review follows - test your patches first.

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

No, power domains express power relationship. Or some other existing
properties or simply parent-child relationships.

Best regards,
Krzysztof

