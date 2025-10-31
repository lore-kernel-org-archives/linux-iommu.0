Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369EA3009DE;
	Fri, 31 Oct 2025 08:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761898468; cv=none; b=EkP7TlwtxRCP+xJND5+9QAl2VmwcpvbLr1tPSr6jze42w4xgL08PRW3sXzh9VmFuSjEtX7fWD0lNizZ7FkLTcb0CTN6lrUrvsTMBNNYf+IarGPIKsDHf+/7quq2NZ3ML+VEQ+a7B7wsNymhDbKiz3jbSvJrijb09pQw4PeuOu/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761898468; c=relaxed/simple;
	bh=T7nI7xvtFl7krfWTdP/qjx1BlQ3XmAzSZCU1Kz/Md9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P4O8g6Q0JOWN2XufPa6QGFk2cNx3MYQuUndsqCWvsVKV3mQcO/P6GoKcFP4Y1eey+orRMxjRSBPwV3EgUznQxd6EXVD8FqB2+rJPJajdEjbyx63AO4VvCtI+EbtgD2ftQGPho4DDcrKhQMBtMt7LC7hhBajaIQUw4ClBj0t9czk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LJbKnESF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LJbKnESF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 754F3C4CEFB;
	Fri, 31 Oct 2025 08:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761898468;
	bh=T7nI7xvtFl7krfWTdP/qjx1BlQ3XmAzSZCU1Kz/Md9c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LJbKnESFg6XyUjYSq7gFteRw1AzLeEOwhq/R1FQ9acELAGb+1lo+BK3K6HG4G/O9k
	 xCbFSxVcLC6lxIA0RrBry1xU4Ny6c2H9iQpJGAXLuYmETlnLIP8hBxSbvlZPayn7P3
	 pcdWLf2PtvqhAnCGPD2p3hRJ9Lk1gYYEF4knXXJYhNNNRjes5DC7lcoG0kLdNdtV/1
	 nCEB4VgBWNM6NXS1awmf6VveSzpRC4x8tIriIrbbOk8w5xV8RlXWbSdrKrJV1DsLdn
	 UnSBH3oBfQXE59g/0J4wbD5O4tEdAtNlrTE0qdoi8niaUfHbef0uVckyS7o8sjZq5k
	 qYs5Od5VGpOrQ==
Date: Fri, 31 Oct 2025 09:14:25 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ashish Mhetre <amhetre@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	thierry.reding@gmail.com, jonathanh@nvidia.com, jgg@ziepe.ca, nicolinc@nvidia.com, 
	linux-tegra@nvidia.com, linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: iommu: Add NVIDIA Tegra CMDQV support
Message-ID: <20251031-witty-sociable-chachalaca-b73dbc@kuoka>
References: <20251031062959.1521704-1-amhetre@nvidia.com>
 <20251031062959.1521704-3-amhetre@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251031062959.1521704-3-amhetre@nvidia.com>

On Fri, Oct 31, 2025 at 06:29:58AM +0000, Ashish Mhetre wrote:
> The Command Queue Virtualization (CMDQV) hardware is part of the
> SMMUv3 implementation on NVIDIA Tegra SoCs. It assists in
> virtualizing the command queue for the SMMU.

If this is specific to Nvidia, then I think you need specific front
compatible and disallow it for other vendors.

> 
> Add a new device tree binding document for nvidia,tegra264-cmdqv.
> 
> Also update the arm,smmu-v3 binding to include an optional nvidia,cmdqv
> property. This property is a phandle to the CMDQV device node, allowing
> the SMMU driver to associate with its corresponding CMDQV instance.
> 
> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
> ---
>  .../bindings/iommu/arm,smmu-v3.yaml           | 10 ++++
>  .../bindings/iommu/nvidia,tegra264-cmdqv.yaml | 46 +++++++++++++++++++
>  2 files changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iommu/nvidia,tegra264-cmdqv.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
> index 75fcf4cb52d9..edc0c20a0c80 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
> @@ -58,6 +58,15 @@ properties:
>  
>    msi-parent: true
>  
> +  nvidia,cmdqv:
> +    description: |
> +      A phandle to its pairing CMDQV extension for an implementation on NVIDIA
> +      Tegra SoC.
> +
> +      If this property is absent, CMDQ-Virtualization won't be used and SMMU
> +      will only use its own CMDQ.
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +
>    hisilicon,broken-prefetch-cmd:
>      type: boolean
>      description: Avoid sending CMD_PREFETCH_* commands to the SMMU.
> @@ -92,4 +101,5 @@ examples:
>              dma-coherent;
>              #iommu-cells = <1>;
>              msi-parent = <&its 0xff0000>;
> +            nvidia,cmdqv = <&cmdqv>;
>      };
> diff --git a/Documentation/devicetree/bindings/iommu/nvidia,tegra264-cmdqv.yaml b/Documentation/devicetree/bindings/iommu/nvidia,tegra264-cmdqv.yaml
> new file mode 100644
> index 000000000000..f22c370278a3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iommu/nvidia,tegra264-cmdqv.yaml
> @@ -0,0 +1,46 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NVIDIA Tegra264 CMDQV

Missing blank line

> +description: |

Do not need '|' unless you need to preserve formatting.

> +  The CMDQ-Virtualization hardware block is part of the SMMUv3 implementation
> +  on Tegra264 SoCs. It assists in virtualizing the command queue for the SMMU.
> +
> +maintainers:
> +  - NVIDIA Corporation <linux-tegra@nvidia.com>

No. It should be a person. If entire Nvidia cannot find a person, I
don't think we are interested in having this in the kernel.

> +
> +properties:
> +  compatible:
> +    const: nvidia,tegra264-cmdqv
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  interrupt-names:
> +    items:
> +      - const: cmdqv

Drop interript names, obvious.

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - interrupt-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    cmdqv: cmdqv@8105200000 {

Drop unused label

Best regards,
Krzysztof

