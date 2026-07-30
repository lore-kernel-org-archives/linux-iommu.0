Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF1B3C061D;
	Thu, 30 Jul 2026 06:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785394799; cv=none; b=Mhh59BZgeUcyrTK8jFh55QiWswQ+sWjk7YFgRHw0esyL2UD/l3VHh++4+pzUG3RcvE94iPScSiBJHZBikmKSdGQbaEf0GMrtRTF/uI/UoggMc3ofvj/13ud05xUfMAIGNBoNPN5mRG5qGqdbIVCUkOT/ObE02aYF6Ldp9X3tK/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785394799; c=relaxed/simple;
	bh=+5yAdlvmrmBOU3kyJ8MAg+K3AoP47FJu7gB9iHwdtPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sqHLzui0fH4a1ce52tbOIZxD/n8l9+EO/PFePS63ceowG6MyKTMRQVnESCgp3L1QUIE1DqlQQQx1r2IKD2V81D8tJg2OjwDUj+7DVJafFeXAO7uy0MK/e0SUsgS2PKW+6ll4PmXOjvscxq+MMOujyZyFpSemkC9BnAt02hDd+8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y281iKTI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y281iKTI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E39C1F000E9;
	Thu, 30 Jul 2026 06:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785394785;
	bh=a6vq+XN5CM9+uuf8vbRHpfXJQHZkjlex7kNCOdzok0M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Y281iKTIXaUEJSTFniYUGiW68Fc0k96KRGQ28IdWDxIIb5EDyHNLzMC/BWzs8md/3
	 MxTHO8tY+CfjWNRuFTIVC5XYHB2AAAG4uZQyoPFdPZAu/nEEQb6lyY5GIV6giqSgqo
	 NenFWLhKdXVekH7CVW1j+7Y3evihd4ExGeWRS6oc1TDwnmd0KcVwvQBrxXLT50z21v
	 mOBHHkGBpuTDKVDnhxe5liw1glOMja/HFRRAP4bhaY0AFBActs+IQ+wKncvMdAOcl2
	 g7obNxTjpXx/VWCE7qyCQHYxI1QlAbVh+MRgyIQTMmqVV9h0RY8locX5t67XdxMQuF
	 cTnrfvUyPJaJQ==
Date: Thu, 30 Jul 2026 08:59:41 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Daniel Drake <dan@reactivated.net>
Cc: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, nick.hollinghurst@raspberrypi.com, 
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v2 2/5] dt-bindings: iommu: Add Broadcom BCM2712 IOMMU
Message-ID: <20260730-free-monkey-of-defiance-38b976@quoll>
References: <20260727-bcm2712-iommu-submit-v2-0-0247b5c03de8@reactivated.net>
 <20260727-bcm2712-iommu-submit-v2-2-0247b5c03de8@reactivated.net>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260727-bcm2712-iommu-submit-v2-2-0247b5c03de8@reactivated.net>

On Mon, Jul 27, 2026 at 09:43:57PM +0100, Daniel Drake wrote:
> Add bindings for the Broadcom BCM2712 IOMMUs and their shared TLB cache.
> 
> Signed-off-by: Daniel Drake <dan@reactivated.net>
> ---
>  .../bindings/iommu/brcm,bcm2712-iommu.yaml         | 48 ++++++++++++++++++++++
>  .../bindings/iommu/brcm,bcm2712-iommuc.yaml        | 35 ++++++++++++++++
>  2 files changed, 83 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/brcm,bcm2712-iommu.yaml b/Documentation/devicetree/bindings/iommu/brcm,bcm2712-iommu.yaml
> new file mode 100644
> index 000000000000..af4d8bac10e5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iommu/brcm,bcm2712-iommu.yaml
> @@ -0,0 +1,48 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iommu/brcm,bcm2712-iommu.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Broadcom BCM2712 IOMMU
> +
> +maintainers:
> +  - Daniel Drake <dan@reactivated.net>
> +
> +description:
> +  The BCM2712 IOMMU provides address translation for various hardware blocks
> +  on the BCM2712 SoC, such as the VC6 display pipeline.
> +
> +properties:
> +  compatible:
> +    const: brcm,bcm2712-iommu
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#iommu-cells':
> +    const: 0
> +
> +  brcm,iommu-cache:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Phandle to the shared IOMMU cache. The IOMMUC is a shared hardware block
> +      that provides centralized Translation Lookaside Buffer (TLB) caching and
> +      invalidation.

Again, same comment: what for? What is the purpose of IOMMUC in IOMMU
(not in the system, you are not describing the system). You just pasted
here description of other binding, but I did not ask for that.

Do you need to manually invalidate cache lines from IOMMU?

Why do you think that both are separate devices in the first place? It
would be like describing in DTS separate MMU and TLB.

> +
> +required:
> +  - compatible
> +  - reg
> +  - '#iommu-cells'
> +  - brcm,iommu-cache
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    iommu@5200 {
> +        compatible = "brcm,bcm2712-iommu";
> +        reg = <0x5200 0x80>;
> +        brcm,iommu-cache = <&iommuc>;
> +        #iommu-cells = <0>;
> +    };
> diff --git a/Documentation/devicetree/bindings/iommu/brcm,bcm2712-iommuc.yaml b/Documentation/devicetree/bindings/iommu/brcm,bcm2712-iommuc.yaml
> new file mode 100644
> index 000000000000..f22e9be2c473
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iommu/brcm,bcm2712-iommuc.yaml
> @@ -0,0 +1,35 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iommu/brcm,bcm2712-iommuc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Broadcom BCM2712 Shared IOMMU Cache (IOMMUC)
> +
> +maintainers:
> +  - Daniel Drake <dan@reactivated.net>
> +
> +description: |

Same comments as before.

> +  The BCM2712 IOMMU Cache (IOMMUC) provides a shared Translation Lookaside
> +  Buffer (TLB) cache used by the primary BCM2712 IOMMUs to speed up address
> +  translations.
> +
> +properties:
> +  compatible:
> +    const: brcm,bcm2712-iommuc
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    iommuc: iommu-cache@1001000 {

Drop unused label.

> +        compatible = "brcm,bcm2712-iommuc";
> +        reg = <0x1001000 0x100>;
> +    };
> 
> -- 
> 2.55.0
> 
