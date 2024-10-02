Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6BD1946B9;
	Wed,  2 Oct 2024 21:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727904045; cv=none; b=NOKZO3VfDAiVAj4bVl+T+fY+0q0QwG6uguCvY8mKa3N2JSBaqQ9xcj71klWPpYR91KLs38d4cZ6q/1LOIlVO8C14atVL4ga4HfwgG178UnpFsTJqMGlPaiR3I0BQ4O103Peia9UmFhTaFfXkLA1dkTsjiwpk0p/bXf6H0jReLw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727904045; c=relaxed/simple;
	bh=WOZJowlZmyTzhhIM25DP7gggpGjOS9oOh8m5/SnwFNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p6TkOrdphIVt1Or9iw0gjv/tT9G4UETARij3TBwcyedT1y9U3VwkqnY6IxpPUhwop6kczhzZ1dutMBxVuV4VV1xFNI2Hhr/LUOVmq/8HtwKbFXKEv0SfCnFvJ3Pog38gIz+kbWLeJ+a82H8Na3GAG1sUdwAxv6WaR7xYw6yUW/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YS54HsHu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YS54HsHu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 284D5C4CEC5;
	Wed,  2 Oct 2024 21:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727904044;
	bh=WOZJowlZmyTzhhIM25DP7gggpGjOS9oOh8m5/SnwFNE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YS54HsHu/vZmCX4jzHcFaDeHgnuyeyib5kgeYowtuRymutC0iSzKFgmD3OCoYBdmd
	 rZBsnLiRQ/mhL12oz7o9yjOVfPVKwK+0Wy87wgEZgX42v6XsxqjMhQmYlK2+L5og4x
	 p8d1bBD36aAyi7uIFCbGHwnQdpYjIhR7ow68aWRWFFls067L13E300hckDQaG3748U
	 HPkBL6PbpSClM0IHP6KBtk1sNcpIRNTVOpPK8Zsy4+lArw6IrwO+K44ekBlbOQnDqV
	 WP+f4UlD0Ap6XHO+atUxDmblvYZ5xOKbq8sHLolHX/bx5Fc8hGf1bnc7LL3UtYxpkF
	 kPBA9VGjVZ1SQ==
Date: Wed, 2 Oct 2024 16:20:29 -0500
From: Rob Herring <robh@kernel.org>
To: Macpaul Lin <macpaul.lin@mediatek.com>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yong Wu <yong.wu@mediatek.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rohit Agarwal <rohiagar@chromium.org>,
	dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Alexandre Mergnat <amergnat@baylibre.com>,
	Bear Wang <bear.wang@mediatek.com>,
	Pablo Sun <pablo.sun@mediatek.com>, Macpaul Lin <macpaul@gmail.com>,
	Sen Chu <sen.chu@mediatek.com>,
	Chris-qj chen <chris-qj.chen@mediatek.com>,
	MediaTek Chromebook Upstream <Project_Global_Chrome_Upstream_Group@mediatek.com>,
	Chen-Yu Tsai <wenst@chromium.org>
Subject: Re: [PATCH v5 2/5] dt-bindings: iommu: mediatek: Fix interrupt count
 constraint for new SoCs
Message-ID: <20241002212029.GA1320580-robh@kernel.org>
References: <20241002051620.2050-1-macpaul.lin@mediatek.com>
 <20241002051620.2050-2-macpaul.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002051620.2050-2-macpaul.lin@mediatek.com>

On Wed, Oct 02, 2024 at 01:16:17PM +0800, Macpaul Lin wrote:
> The infra-iommu node in mt8195.dtsi was triggering a CHECK_DTBS error due
> to an excessively long 'interrupts' property. The error message was:
> 
>   infra-iommu@10315000: interrupts: [[0, 795, 4, 0], [0, 796, 4, 0],
>                      [0, 797, 4, 0], [0, 798, 4, 0], [0, 799, 4, 0]]
>                      is too long
> 
> To address this issue, update the compatbile matching rule for
> 'interrupts' property. This change allows flexibility in the number
> of interrupts for new SoCs like MT8195.
> The purpose of these 5 interrupts is also added into description.
> 
> Fixes: bca28426805d ("dt-bindings: iommu: mediatek: Convert IOMMU to DT schema")
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> ---
>  .../bindings/iommu/mediatek,iommu.yaml        | 29 ++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)
> 
> Changes for v2:
>  - commit message: re-formatting and add a description of adding 5 interrupts.
>  - add 'description' and 'maxItems: 5' for 'interrupt' property of
>    'mt8195-iommu-infra'
>  - others keeps 'maxItems: 1'
> 
> Changes for v3:
>  - Refine the description for 'interrupts' property and fixes the compatible
>    matching rules.
>  - Refine commit message.
> 
> Changes for v4:
>   - add missing 'minItems: 5' to 'mediatek,mt8195-iommu-infra'.
>     Thanks the explanation from Conor and Krzysztof. 
> 
> Changes for v5:
>   - Repharse the description for interrupts property of MT8195.
> 
> diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> index ea6b0f5f24de..df8b2429008e 100644
> --- a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> @@ -96,7 +96,16 @@ properties:
>      maxItems: 1
>  
>    interrupts:
> -    maxItems: 1
> +    description: |
> +      Usually, the IOMMU requires only one interrupt.
> +
> +      The infra IOMMU in MT8195 has five banks: each features one set
> +      of APB registers. One for the normal world (set 0), three for the
> +      protected world (sets 1-3), and one for the secure world (set 4).
> +      and each set has its own interrupt. Therefore, five interrupts
> +      are needed.
> +    minItems: 1
> +    maxItems: 5
>  
>    clocks:
>      items:
> @@ -210,6 +219,24 @@ allOf:
>        required:
>          - mediatek,larbs
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - mediatek,mt8195-iommu-infra
> +
> +    then:
> +      properties:
> +        interrupts:
> +          minItems: 5
> +          maxItems: 5

You only need minItems. The max is already 5.

With that,

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

> +
> +    else:
> +      properties:
> +        interrupts:
> +          maxItems: 1
> +
>  additionalProperties: false
>  
>  examples:
> -- 
> 2.45.2
> 
