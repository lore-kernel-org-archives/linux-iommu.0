Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D7423C5
	for <iommu@lists.linux.dev>; Mon, 13 Mar 2023 11:51:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B67AC433D2;
	Mon, 13 Mar 2023 11:51:42 +0000 (UTC)
Message-ID: <75900e56-b430-8d7d-3a97-336bd3d84a68@xs4all.nl>
Date: Mon, 13 Mar 2023 12:51:41 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v5 02/11] dt-bindings: media: mediatek,jpeg: Remove
 dma-ranges property
Content-Language: en-US
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 nfraprado@collabora.com, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 mingyuan.ma@mediatek.com, yf.wang@mediatek.com, jianjiao.zeng@mediatek.com,
 Yunfei Dong <yunfei.dong@mediatek.com>,
 kyrie wu <kyrie.wu@mediatek.corp-partner.google.com>,
 chengci.xu@mediatek.com, youlin.pei@mediatek.com, anan.sun@mediatek.com,
 Bin Liu <bin.liu@mediatek.com>, Xia Jiang <xia.jiang@mediatek.com>,
 Rob Herring <robh@kernel.org>
References: <20230307023507.13306-1-yong.wu@mediatek.com>
 <20230307023507.13306-3-yong.wu@mediatek.com>
From: Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20230307023507.13306-3-yong.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/03/2023 03:34, Yong Wu wrote:
> After commit f1ad5338a4d5 ("of: Fix "dma-ranges" handling for bus
> controllers"), the dma-ranges of the leaf node doesn't work. Remove
> it for jpeg here.
> 
> Currently there is only mt8195 jpeg node has this property in upstream,
> and it already uses parent-child node, this property did work. But instead,
> MediaTek iommu will control the masters' iova ranges by the master's
> larb/port id internally, then this property is unnecessary.
> 
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Bin Liu <bin.liu@mediatek.com>
> Cc: kyrie wu <kyrie.wu@mediatek.corp-partner.google.com>
> Cc: Xia Jiang <xia.jiang@mediatek.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Acked-by: Rob Herring <robh@kernel.org>

Reviewed-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

Thanks!

	Hans

> ---
>  .../devicetree/bindings/media/mediatek,mt8195-jpegdec.yaml | 7 -------
>  .../devicetree/bindings/media/mediatek,mt8195-jpegenc.yaml | 7 -------
>  .../devicetree/bindings/media/mediatek-jpeg-encoder.yaml   | 5 -----
>  3 files changed, 19 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/media/mediatek,mt8195-jpegdec.yaml b/Documentation/devicetree/bindings/media/mediatek,mt8195-jpegdec.yaml
> index 71595c013dbb..e5448c60e3eb 100644
> --- a/Documentation/devicetree/bindings/media/mediatek,mt8195-jpegdec.yaml
> +++ b/Documentation/devicetree/bindings/media/mediatek,mt8195-jpegdec.yaml
> @@ -26,11 +26,6 @@ properties:
>        Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml for details.
>        Ports are according to the HW.
>  
> -  dma-ranges:
> -    maxItems: 1
> -    description: |
> -      Describes the physical address space of IOMMU maps to memory.
> -
>    "#address-cells":
>      const: 2
>  
> @@ -89,7 +84,6 @@ required:
>    - compatible
>    - power-domains
>    - iommus
> -  - dma-ranges
>    - ranges
>  
>  additionalProperties: false
> @@ -115,7 +109,6 @@ examples:
>                       <&iommu_vpp M4U_PORT_L19_JPGDEC_BSDMA1>,
>                       <&iommu_vpp M4U_PORT_L19_JPGDEC_BUFF_OFFSET1>,
>                       <&iommu_vpp M4U_PORT_L19_JPGDEC_BUFF_OFFSET0>;
> -            dma-ranges = <0x1 0x0 0x0 0x40000000 0x0 0xfff00000>;
>              #address-cells = <2>;
>              #size-cells = <2>;
>              ranges;
> diff --git a/Documentation/devicetree/bindings/media/mediatek,mt8195-jpegenc.yaml b/Documentation/devicetree/bindings/media/mediatek,mt8195-jpegenc.yaml
> index 95990539f7c0..596186497b68 100644
> --- a/Documentation/devicetree/bindings/media/mediatek,mt8195-jpegenc.yaml
> +++ b/Documentation/devicetree/bindings/media/mediatek,mt8195-jpegenc.yaml
> @@ -26,11 +26,6 @@ properties:
>        Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml for details.
>        Ports are according to the HW.
>  
> -  dma-ranges:
> -    maxItems: 1
> -    description: |
> -      Describes the physical address space of IOMMU maps to memory.
> -
>    "#address-cells":
>      const: 2
>  
> @@ -89,7 +84,6 @@ required:
>    - compatible
>    - power-domains
>    - iommus
> -  - dma-ranges
>    - ranges
>  
>  additionalProperties: false
> @@ -113,7 +107,6 @@ examples:
>                       <&iommu_vpp M4U_PORT_L20_JPGENC_C_RDMA>,
>                       <&iommu_vpp M4U_PORT_L20_JPGENC_Q_TABLE>,
>                       <&iommu_vpp M4U_PORT_L20_JPGENC_BSDMA>;
> -            dma-ranges = <0x1 0x0 0x0 0x40000000 0x0 0xfff00000>;
>              #address-cells = <2>;
>              #size-cells = <2>;
>              ranges;
> diff --git a/Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.yaml b/Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.yaml
> index c8412e8ab353..37800e1908cc 100644
> --- a/Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.yaml
> +++ b/Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.yaml
> @@ -44,11 +44,6 @@ properties:
>        Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml for details.
>        Ports are according to the HW.
>  
> -  dma-ranges:
> -    maxItems: 1
> -    description: |
> -      Describes the physical address space of IOMMU maps to memory.
> -
>  required:
>    - compatible
>    - reg

