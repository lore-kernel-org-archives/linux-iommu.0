Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573947EF
	for <iommu@lists.linux.dev>; Fri, 13 Jan 2023 08:26:03 +0000 (UTC)
Received: by mail-ej1-f47.google.com with SMTP id az20so31493357ejc.1
        for <iommu@lists.linux.dev>; Fri, 13 Jan 2023 00:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ow5pZFQZCEYCIqWOTwm6DkLVewzWxSQ2hqbyfaIYUMw=;
        b=AC8rsonIaKcS2a/AKPnyvkOrD5LKOz/E/kypsJqKNj44ntLKk+BZQq0pJYwlExETvH
         MqJQIHgjIl49HUPLbLmq7kDUTnHbIYva0FXIOZYmPbaGDh1Y3/SLNQhcvvcQV33S6Oqw
         LWzMeZPhLmbEJ+aXOMPimAuZu0ot1TeNjbfPtLhZcajjKLL2xYNnr7xK62Hq/ECXivB9
         KR9q2u4MqGg6UDBTgMDMZg2zfotH7Eda07Tz57yWnykG44VGzeLan0+FW6jaHQbJKUpW
         MQYKFwWhW943wKe9d3rdjA0Vn9dJG//JCfFDTLFLqNrNa34NXsm30uhRzZqVFR3dtRYL
         oPGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ow5pZFQZCEYCIqWOTwm6DkLVewzWxSQ2hqbyfaIYUMw=;
        b=EtyHb5Q0uA6ZETjzJDRCTIfunARqFjgLj0XmfA3mZRfkdJwa1uQ5Yb1KTSCIRF4MJC
         tIdaj2agxgMc9qSM4W0pljwrLNERajZcjUIu4rjbu7zEGI4tgg69NLD/J11j8qYzB+E+
         CUwGPsBYGRVAIyav9Il3bF1gUowQPqJMeWRW3s9CxvKZezpTQ/vfbJeC6T1haaBAAQIi
         1LjgzAwc4cA8umIF3diI8UlK6AS6Bu/qWVRBgiIN7v9GVJQMXK+VFMi4IvA1jQvwtNyF
         9PjPkTy9NcX3daj4hF7gkAg6H5r9CcgIZThuVnMgeNUqhVJnDeKSYmjjZ1RAi05Mt6E/
         Btkw==
X-Gm-Message-State: AFqh2kr/aJi8rH+9i0uNsLzfrjVmI3HErJsM9Xrg0TtISgi59VLK4M6o
	tfns8dZlESb5VfYzVUEQxMtI5A==
X-Google-Smtp-Source: AMrXdXvtfAJKfd+dEPUQgGjDwVPJIsdk/au7/BL5yCsi6a/MUx3IfCt5RfR2t5rlFGwdCkF3RMDP/g==
X-Received: by 2002:a17:907:2587:b0:7c0:ac4b:8b9 with SMTP id ad7-20020a170907258700b007c0ac4b08b9mr56938493ejc.14.1673598361438;
        Fri, 13 Jan 2023 00:26:01 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id hq15-20020a1709073f0f00b0084c4b87a69csm8258399ejc.153.2023.01.13.00.25.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jan 2023 00:26:00 -0800 (PST)
Message-ID: <07ecf7cf-4a68-0f80-0452-3737b7d7922d@linaro.org>
Date: Fri, 13 Jan 2023 09:25:58 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 01/10] dt-bindings: media: mediatek,vcodec: Remove
 dma-ranges property
Content-Language: en-US
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Hans Verkuil <hverkuil@xs4all.nl>, nfraprado@collabora.com,
 linux-media@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 mingyuan.ma@mediatek.com, yf.wang@mediatek.com, libo.kang@mediatek.com,
 Yunfei Dong <yunfei.dong@mediatek.com>,
 kyrie wu <kyrie.wu@mediatek.corp-partner.google.com>,
 chengci.xu@mediatek.com, youlin.pei@mediatek.com, anan.sun@mediatek.com,
 Tiffany Lin <tiffany.lin@mediatek.com>,
 Andrew-CT Chen <andrew-ct.chen@mediatek.com>
References: <20230113060133.9394-1-yong.wu@mediatek.com>
 <20230113060133.9394-2-yong.wu@mediatek.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230113060133.9394-2-yong.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/01/2023 07:01, Yong Wu wrote:
> MediaTek iommu has already controlled the masters' iova ranges by the
> master's larb/port id. then the dma-ranges property is unnecessary for

Sentences in English always start with a capital letter, however also
they do not start with "Then". Make it a proper a proper sentence.

> the master's node. the master is vcodec here.

Unnecessary or invalid? Don't you depend now on some feature of driver
added for example recently?

> 
> Cc: Tiffany Lin <tiffany.lin@mediatek.com>
> Cc: Andrew-CT Chen <andrew-ct.chen@mediatek.com>
> Cc: Yunfei Dong <yunfei.dong@mediatek.com>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>

There is little point in storing output of get_maintainers.pl forever in
the git log. If you need it for some reason, please keep it after ---.

> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  .../devicetree/bindings/media/mediatek,vcodec-decoder.yaml | 5 -----
>  .../devicetree/bindings/media/mediatek,vcodec-encoder.yaml | 5 -----
>  .../bindings/media/mediatek,vcodec-subdev-decoder.yaml     | 7 -------
>  3 files changed, 17 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/media/mediatek,vcodec-decoder.yaml b/Documentation/devicetree/bindings/media/mediatek,vcodec-decoder.yaml
> index aa55ca65d6ed..fad59b486d5d 100644
> --- a/Documentation/devicetree/bindings/media/mediatek,vcodec-decoder.yaml
> +++ b/Documentation/devicetree/bindings/media/mediatek,vcodec-decoder.yaml
> @@ -56,11 +56,6 @@ properties:
>        List of the hardware port in respective IOMMU block for current Socs.
>        Refer to bindings/iommu/mediatek,iommu.yaml.
>  
> -  dma-ranges:
> -    maxItems: 1
> -    description: |
> -      Describes the physical address space of IOMMU maps to memory.
> -
>    mediatek,vpu:
>      $ref: /schemas/types.yaml#/definitions/phandle
>      description:
> diff --git a/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml b/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml
> index 0f2ea8d9a10c..a2051b31fa29 100644
> --- a/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml
> +++ b/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml
> @@ -49,11 +49,6 @@ properties:
>        List of the hardware port in respective IOMMU block for current Socs.
>        Refer to bindings/iommu/mediatek,iommu.yaml.
>  
> -  dma-ranges:
> -    maxItems: 1
> -    description: |
> -      Describes the physical address space of IOMMU maps to memory.
> -
>    mediatek,vpu:
>      $ref: /schemas/types.yaml#/definitions/phandle
>      description:
> diff --git a/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml b/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml
> index c4f20acdc1f8..290594bc91cc 100644
> --- a/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml
> +++ b/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml
> @@ -76,11 +76,6 @@ properties:
>        The node of system control processor (SCP), using
>        the remoteproc & rpmsg framework.
>  
> -  dma-ranges:
> -    maxItems: 1
> -    description: |
> -      Describes the physical address space of IOMMU maps to memory.
> -
>    "#address-cells":
>      const: 2
>  
> @@ -203,7 +198,6 @@ required:
>    - reg
>    - iommus
>    - mediatek,scp
> -  - dma-ranges
>    - ranges
>  
>  if:
> @@ -236,7 +230,6 @@ examples:
>              compatible = "mediatek,mt8192-vcodec-dec";
>              mediatek,scp = <&scp>;
>              iommus = <&iommu0 M4U_PORT_L4_VDEC_MC_EXT>;
> -            dma-ranges = <0x1 0x0 0x0 0x40000000 0x0 0xfff00000>;
>              #address-cells = <2>;
>              #size-cells = <2>;
>              ranges = <0 0 0 0x16000000 0 0x40000>;

Best regards,
Krzysztof

