Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E732321B9DA;
	Fri, 28 Nov 2025 08:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764317890; cv=none; b=urGXAFtvJuIu/ejND03aX6xU7t4e7hjGu1LJEBxWb0z08adx0gDtyj+1UF5iDQSe7CvBudOwQ4zjykB0MxfoN8mxVN+4EouKG9cKPUHmYCPWjv37uRStnhZZi/QQ+u47C7cIDeKpfbfRwESN+boo3fS50yQ7nSFm+cYSOJBsb0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764317890; c=relaxed/simple;
	bh=Oycb6ot6Iyhsttxtig2/z+FAxLCxcG3XAiysNbp4Vdw=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=jN8mT55CqhZq2hDUxxJb7RYtL8LzPHSIoPF6liKXQSf/eIdULD+yXpE0XeJunEnzf4lTG0q9mgVAhRg9YECnzTmKVHFkLaoXjmms3xI9relaUMxEtUSgWKde6Gxi6Gvt1rE/3rQ770QRfzn7PbJ7jBxqDSQHMFMJ/9aVwDKlG3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D2UPU2kI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D2UPU2kI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42062C4CEF1;
	Fri, 28 Nov 2025 08:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764317889;
	bh=Oycb6ot6Iyhsttxtig2/z+FAxLCxcG3XAiysNbp4Vdw=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=D2UPU2kIouxukoByIRpHeE7yB9hi0j1p5g3O4zP4ENqRSX/Z8+pl1Mm3LrvHm5thq
	 tB+erSWVHiFBi468A5rhzTTijwcJRvjThyH25MuhVCTYf/clYHKWKVm3lh1V72qlXG
	 2vZtDiEQt0ztKR4wv1qVGsVxzE9eapDp4spc713WubXGWJ/X8zAV59AXLP7MS3xhmJ
	 CyXloozgNe7Z+dQyhjfh5tnCWIjJFFm61r3UAhsZ5pw4XAkGBrFB3EYSXIE88gH2zA
	 QLMsACSuWwqig8N/ShJdPcSX+Zl9vqxavU1nWZLOSOObZYkUbgnqtI0JBsTvrKVHuR
	 7UgUFLawaXy+w==
Date: Fri, 28 Nov 2025 02:18:07 -0600
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
 Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org, 
 Will Deacon <will@kernel.org>, linux-rockchip@lists.infradead.org, 
 iommu@lists.linux.dev, Chaoyi Chen <chaoyi.chen@rock-chips.com>, 
 Joerg Roedel <joro@8bytes.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>
To: Chaoyi Chen <kernel@airkyi.com>
In-Reply-To: <20251128071322.92-2-kernel@airkyi.com>
References: <20251128071322.92-1-kernel@airkyi.com>
 <20251128071322.92-2-kernel@airkyi.com>
Message-Id: <176431788757.1500601.18210148365739838676.robh@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: iommu: rockchip: Add support for
 multiple interface clocks


On Fri, 28 Nov 2025 15:13:21 +0800, Chaoyi Chen wrote:
> From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> 
> The iommu found on RK3576 NPU and RK3576 RKVDEC have 4 clock instead of
> 2 clock. Their clock names might differ, but I don't think that matters
> much.
> 
> Add support for them.
> 
> Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> ---
> 
> Changes in v2:
> - Rewrite dt binding.
> 
>  .../bindings/iommu/rockchip,iommu.yaml        | 52 ++++++++++++++++---
>  1 file changed, 46 insertions(+), 6 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/thermal/thermal-sensor.example.dtb: /example-0/soc/thermal-sensor@c263000: failed to match any schema with compatible: ['qcom,sdm845-tsens', 'qcom,tsens-v2']
Documentation/devicetree/bindings/thermal/thermal-sensor.example.dtb: /example-0/soc/thermal-sensor@c263000: failed to match any schema with compatible: ['qcom,sdm845-tsens', 'qcom,tsens-v2']
Documentation/devicetree/bindings/thermal/thermal-sensor.example.dtb: /example-0/soc/thermal-sensor@c265000: failed to match any schema with compatible: ['qcom,sdm845-tsens', 'qcom,tsens-v2']
Documentation/devicetree/bindings/thermal/thermal-sensor.example.dtb: /example-0/soc/thermal-sensor@c265000: failed to match any schema with compatible: ['qcom,sdm845-tsens', 'qcom,tsens-v2']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20251128071322.92-2-kernel@airkyi.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

