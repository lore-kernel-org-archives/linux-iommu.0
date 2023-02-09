Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F47C64A
	for <iommu@lists.linux.dev>; Thu,  9 Feb 2023 17:43:10 +0000 (UTC)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-15fe106c7c7so3494431fac.8
        for <iommu@lists.linux.dev>; Thu, 09 Feb 2023 09:43:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zmWeTxm3eAR69llILe3yLFx61s6S09dltEYFO6LRpqs=;
        b=yx/Y1qpSLwT2Rb9ToZT/skuudb1jpQ6d5tE9v6bIbqtx7pns9frzx3QwESMdph3zh+
         sLBlVieSeRDatIx7WWJk6Rjk3rHJd5ibjMkqsE7h2IXuNxuFafqoeWi/g1HxP+HpCND4
         mCTCkvBqNyReFQW/5tFFDx1VOOP3mYCFG4fqqAYpQxC2bGDc3R/fPncpqoZ6hcSVRWwt
         LKL3AVPUflndXL3as/Et/PxOhkS7EDXYAJfXo7bLOWNzJEBLYFYaAYw452F/hz8LFONF
         WvPmu7VRg/TxaW0jD97kN6OWNl1gYSsVe4eVyXfiM3du3QAOxXhrYONTMahkPcpAv5v2
         NXUw==
X-Gm-Message-State: AO0yUKWK9p2AwR4wEddIiA4EQzh0gOUw9HDJOirlWjJfVOCj8EgaA4oh
	YTWUQdhJgM4qM7EMb+tNrg==
X-Google-Smtp-Source: AK7set9i8Yc0as8tcS+G5ABFmialaz9E/t1quo/d+glus4OAQlGXNCIBfTxURc1sXvd6sOHL45g/YQ==
X-Received: by 2002:a05:6870:a11d:b0:163:d167:80bc with SMTP id m29-20020a056870a11d00b00163d16780bcmr2886406oae.49.1675964590032;
        Thu, 09 Feb 2023 09:43:10 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id ky15-20020a056871404f00b0014fc049fc0asm900969oab.57.2023.02.09.09.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 09:43:09 -0800 (PST)
Received: (nullmailer pid 553172 invoked by uid 1000);
	Thu, 09 Feb 2023 17:43:08 -0000
Date: Thu, 9 Feb 2023 11:43:08 -0600
From: Rob Herring <robh@kernel.org>
To: Yong Wu <yong.wu@mediatek.com>
Cc: Tiffany Lin <tiffany.lin@mediatek.com>, linux-media@vger.kernel.org, kyrie wu <kyrie.wu@mediatek.corp-partner.google.com>, youlin.pei@mediatek.com, Matthias Brugger <matthias.bgg@gmail.com>, Will Deacon <will@kernel.org>, Hans Verkuil <hverkuil@xs4all.nl>, Mauro Carvalho Chehab <mchehab@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Andrew-CT Chen <andrew-ct.chen@mediatek.com>, chengci.xu@mediatek.com, mingyuan.ma@mediatek.com, devicetree@vger.kernel.org, Joerg Roedel <joro@8bytes.org>, linux-arm-kernel@lists.infradead.org, anan.sun@mediatek.com, iommu@lists.linux.dev, libo.kang@mediatek.com, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, yf.wang@mediatek.com, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-mediatek@lists.infradead.org, nfraprado@collabora.com, Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org, Yunfei Dong <yunfei.dong@mediatek.com>
Subject: Re: [PATCH v2 01/10] dt-bindings: media: mediatek,vcodec: Remove
 dma-ranges property
Message-ID: <167596458765.553111.2698863120254622830.robh@kernel.org>
References: <20230208053643.28249-1-yong.wu@mediatek.com>
 <20230208053643.28249-2-yong.wu@mediatek.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230208053643.28249-2-yong.wu@mediatek.com>


On Wed, 08 Feb 2023 13:36:34 +0800, Yong Wu wrote:
> After commit f1ad5338a4d5 ("of: Fix "dma-ranges" handling for bus
> controllers"), the dma-ranges of the leaf node doesn't work. Remove
> it for vcodec here.
> 
> 1) For mediatek,vcodec-decoder.yaml and mediatek,vcodec-encoder.yaml,
> this property is in the leaf node, it is invalid as the above comment.
> 
> Currently there is only mt8195 VENC node has this property in upstream.
> Indeed, VENC is affected, but it is not a fatal issue. Originally it
> expects its iova range locate at 4GB-8GB. However after that commit, its
> expectation doesn't come true, it will fall back to 0-4GB iova and also
> could work well.
> 
> 2) For mediatek,vcodec-subdev-decoder.yaml, It already uses parent-child
> node, this property works. Instead, MediaTek iommu will control the
> masters' iova ranges by the master's larb/port id internally, then the
> dma-ranges property is unnecessary for the master's node.
> 
> Cc: Tiffany Lin <tiffany.lin@mediatek.com>
> Cc: Andrew-CT Chen <andrew-ct.chen@mediatek.com>
> Cc: Yunfei Dong <yunfei.dong@mediatek.com>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../devicetree/bindings/media/mediatek,vcodec-decoder.yaml | 5 -----
>  .../devicetree/bindings/media/mediatek,vcodec-encoder.yaml | 5 -----
>  .../bindings/media/mediatek,vcodec-subdev-decoder.yaml     | 7 -------
>  3 files changed, 17 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

