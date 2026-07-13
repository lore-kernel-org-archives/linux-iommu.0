Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7CB368D4B;
	Mon, 13 Jul 2026 09:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783934171; cv=none; b=hfe7jewNPVCr5tOLoRfBRrKYzERzj98qu09RmFpH3W2bF4fIdCew5K4/2MesL22XGrpyh6f4N2ZQmBiDdRODVVVCUviYbSdgv9t15j4IhWydKVRxV2Pl91Hbuy+Xsq24zSbsoQ0YwCdQ8YGA+K1KMIke9NNeT8HGUEprWJqUVgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783934171; c=relaxed/simple;
	bh=qy4epiyYjdSjOA+l6Z5k+6LYOxC7LsuckhtI65J+MXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Onmuc7eqF7mtzf4m7aYH1WuSu/35P4F5GZ5CgpTbRJ4b2GZ196KXeP9UfaDuiGTWecb9E5uKbzqkLsc8ZfgrFB1brV32THMqPEHRnOZIDTMGypaaGuZog/q0R2Gar7LfznrTVmnETqwPfcECubGklGNC5Sx8VR3hReyCyXKkXp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E7FwN/Jv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E7FwN/Jv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A02E1F000E9;
	Mon, 13 Jul 2026 09:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783934169;
	bh=N30vr1xrRftm2nMobVAtxbwff06D+Jf4XX9jZoAnGTU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=E7FwN/Jv6m1e69kx632GqJLog3RwP12tN0ucav26FktzwqnDd4kBGbNenuLYwevaG
	 1BGaAYWSOPpXQRSOjYHhBVIcbF6c6745HuTPWIJSEk8DBaXcYiJiRhiQHM0PuxFF6P
	 BwYbJSu9iMhhF+DNNLmVWpQSpv2YXboLZUCWFoTXiDPKBMPB5Kbs7XTiLQtafM8HCh
	 PNnPj9dcL0ZH08/cBg+D0N2/m6AGaFNxwZfAKu9PvpgM4thZA2L6/kvTerKA11bcS4
	 O4pi77LeTOqxqk29h93wNbDV6E+GB/6u5CSeTYHY3YOHUOPR191DfJ6oc4ZrkSO5RK
	 M/S7j7bXcZacQ==
Date: Mon, 13 Jul 2026 11:16:05 +0200
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
Subject: Re: [PATCH 3/6] dt-bindings: iommu: Add Broadcom BCM2712 IOMMU
Message-ID: <20260713-corgi-of-striking-science-4afbdc@quoll>
References: <20260712-bcm2712-iommu-submit-v1-0-80e10cdde2ea@reactivated.net>
 <20260712-bcm2712-iommu-submit-v1-3-80e10cdde2ea@reactivated.net>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260712-bcm2712-iommu-submit-v1-3-80e10cdde2ea@reactivated.net>

On Sun, Jul 12, 2026 at 10:18:53PM +0100, Daniel Drake wrote:
> Add bindings for the Broadcom BCM2712 IOMMU and its shared TLB cache.
> 
> Include compatibility with the cache phandle used in existing firmware
> shipped on Raspberry Pi 5, and also allow the iova-window to be omitted,
> which similarly will maintain compatibility with existing RPi5 firmware.
> 
> Signed-off-by: Daniel Drake <dan@reactivated.net>
> ---
>  .../bindings/iommu/brcm,bcm2712-iommu.yaml         | 65 ++++++++++++++++++++++
>  .../bindings/iommu/brcm,bcm2712-iommuc.yaml        | 35 ++++++++++++
>  2 files changed, 100 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/brcm,bcm2712-iommu.yaml b/Documentation/devicetree/bindings/iommu/brcm,bcm2712-iommu.yaml
> new file mode 100644
> index 000000000000..0d91c513afc4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iommu/brcm,bcm2712-iommu.yaml
> @@ -0,0 +1,65 @@
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
> +description: |

Do not need '|' unless you need to preserve formatting.

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
> +    description: Phandle to the shared IOMMU cache (IOMMUC).

You need to explain what for, the purpose in hardware.

> +
> +  cache:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: Deprecated. Use brcm,iommu-cache instead.
> +    deprecated: true

Drop property, we do not take new bindings with deprecated properties.
Existing FW is not an excuse, Raspberry 5 developers could reach out and
ask if this is okay. They did not.

> +
> +  brcm,iova-window:
> +    $ref: /schemas/types.yaml#/definitions/uint64-array
> +    description: |
> +      An array of two 64-bit integers specifying the IOVA aperture start
> +      address and the aperture size. IOMMU mappings will be created inside
> +      this aperture. All preceding address space is in identity/bypass mode.
> +      The aperture start address must be 4GB-aligned.
> +      Should be considered a required property, but it is technically optional
> +      in order to maintain compatibility with historical firmware versions.
> +      If absent, defaults to a 4GB window at 40GiB (0xa00000000).
> +    items:
> +      - description: IOVA window start address
> +      - description: IOVA window size

This looks a lot like reserved region, so why do you need a new
property? If this is not a reserved memory, then why compatible does not
imply the value?


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
> +        brcm,iova-window = /bits/ 64 <0xa00000000 0x100000000>;

Best regards,
Krzysztof

