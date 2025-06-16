Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F7B7262B;
	Mon, 16 Jun 2025 04:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750048843; cv=none; b=a/F1bBzzuVRTAjB5LuV/A/CiSqp09RqDbIqVl+3UBkmaiRKvsi41NLkJkvucx6v+w0Nd3a1IjcIcUyIkuXcrX5lp1f6eQG6YVnu3pxGG3/dQtyzAkb3AMeCFP1ShySbme2ExPZt5Wr9BhfRceawi2R6eNUFOvjKf33hjU23pxdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750048843; c=relaxed/simple;
	bh=TGHN5IjJzRSodYVswQbkuM8G3fZj/gxhvozJyWYCAMw=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=CTmTKD9K/SDxbVHqsmnwFVCZykw9dtRMgyZ+wipeCZ9TKYoZAHmg2PPN9oHkwdXYTwX+rm2DnsOVrAfMQT0V/gCQlfxqG4yNq1K7gpcXRHankIUShxE2AU8N2yc1UpAzqjqXfVC2nNx650T2ad1EOKuJF0rSKhUDof/1nk1C9xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KeNuXSA6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KeNuXSA6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C9C1C4CEEA;
	Mon, 16 Jun 2025 04:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750048843;
	bh=TGHN5IjJzRSodYVswQbkuM8G3fZj/gxhvozJyWYCAMw=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=KeNuXSA6uKkfHRPo9/0yzTwWwVbqXmUIEmb+pj3q9uPRXbbw7346x1/GG3vvNKl/l
	 aq8jkTvyH+g7m3oEgl71QVRighbGsfy78v8wJiaFq6HZVC5evfEYXuX0mFWGahOaYU
	 e/mAfnVayKsomZFWjzpTbP9BfTeNzdXBpnynhFTGRl3Iz11mFocQbS4rsJvY48+owE
	 IEg+VI1VKPtDdJovr9XyOihFQI0/ofEoipkgqjiA2N7ZeJReLu8JfvfFLytY8vEEwJ
	 eoRlxtj3uG/Lw6MoTKFojv46sC69BjIhFBsNC85llDRCvb2kJBbI4M+S/xbkc4VaCA
	 GfNJVfqGWtOhg==
Date: Sun, 15 Jun 2025 23:40:42 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Yong Wu <yong.wu@mediatek.com>, linux-mediatek@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Will Deacon <will@kernel.org>, 
 Project_Global_Chrome_Upstream_Group@mediatek.com, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, iommu@lists.linux.dev, 
 devicetree@vger.kernel.org, Ning li <ning.li@mediatek.com>
To: Xueqi Zhang <xueqi.zhang@mediatek.com>
In-Reply-To: <20250616025628.25454-2-xueqi.zhang@mediatek.com>
References: <20250616025628.25454-1-xueqi.zhang@mediatek.com>
 <20250616025628.25454-2-xueqi.zhang@mediatek.com>
Message-Id: <175004884234.2151629.17180852934991161132.robh@kernel.org>
Subject: Re: [RFC PATCH 1/8] dt-bindings: iommu: mediatek: Add mt8196
 support


On Mon, 16 Jun 2025 10:56:07 +0800, Xueqi Zhang wrote:
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

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml: ignoring, error in schema: properties: compatible
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml: properties:compatible: [{'description': 'MediaTek SoCs implementing "arm,smmu-v3"', 'items': [{'enum': ['mediatek,mt8196-apu-smmu', 'mediatek,mt8196-mm-smmu']}, {'const': 'arm,smmu-v3'}]}] is not of type 'object', 'boolean'
	from schema $id: http://json-schema.org/draft-07/schema#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml: properties:compatible: [{'description': 'MediaTek SoCs implementing "arm,smmu-v3"', 'items': [{'enum': ['mediatek,mt8196-apu-smmu', 'mediatek,mt8196-mm-smmu']}, {'const': 'arm,smmu-v3'}]}] is not of type 'object', 'boolean'
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
Documentation/devicetree/bindings/iommu/arm,smmu-v3.example.dtb: /example-0/iommu@2b400000: failed to match any schema with compatible: ['arm,smmu-v3']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250616025628.25454-2-xueqi.zhang@mediatek.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

