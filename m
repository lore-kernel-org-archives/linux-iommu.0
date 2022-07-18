Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818673C37
	for <iommu@lists.linux.dev>; Mon, 18 Jul 2022 21:15:03 +0000 (UTC)
Received: by mail-io1-f44.google.com with SMTP id z132so10391146iof.0
        for <iommu@lists.linux.dev>; Mon, 18 Jul 2022 14:15:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=waGojzQJKestAFlcfSdCqvEWi/o6eYFkAoN0J4xqLlM=;
        b=ucVWU7BmlRZ84UBICWt5MVfKcv6hofZbs4mssfJCr8uVXnPcQf0d3e191MtA+FWDy2
         9cJN8hExqm/lWe9W3qa5RnO9nnjoP0LjR1Bx54Ti8rxTFgnd1R5ddabxUqF0WcGLPM/h
         7jw/d5R6itSVdCuTFYvxur0cWaz5RTsV+ZOVxJm6BdDkd+N9FYu7jXcOQu9xCkLtacBc
         HXH2NsYSaAnJPEQ32U7pJMZr7GbfM/eS6X3NgAXMUZwIgBX+xHoRqpRMl3nOV7iteymt
         VHdnnVKFe8+liIGgv1pwrmye9nJAGm5Xs0C2U+26aZluPEVEi42vJfFdC7MzIzn/RJbh
         S9Aw==
X-Gm-Message-State: AJIora+pV/q4b3TxcIusqqcvFgU+/2RN53KfbaLj1f07si+yACYQGVHX
	iaulJhXC/rwP49aWbeiklg==
X-Google-Smtp-Source: AGRyM1vzkO++HsbSir7ZbCZNk8RsHLKO5mm6TyRRsK3Bu8hhHALzdY+MkTYM98ZV7iYjLMb5ueJJrQ==
X-Received: by 2002:a05:6602:131a:b0:67b:dbd5:49dd with SMTP id h26-20020a056602131a00b0067bdbd549ddmr8950312iov.1.1658178902508;
        Mon, 18 Jul 2022 14:15:02 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id x13-20020a92de0d000000b002dc06989d86sm5196511ilm.52.2022.07.18.14.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 14:15:02 -0700 (PDT)
Received: (nullmailer pid 3569024 invoked by uid 1000);
	Mon, 18 Jul 2022 21:15:00 -0000
Date: Mon, 18 Jul 2022 15:15:00 -0600
From: Rob Herring <robh@kernel.org>
To: Tinghan Shen <tinghan.shen@mediatek.com>
Cc: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Lee Jones <lee.jones@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, Chun-Jie Chen <chun-jie.chen@mediatek.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, MandyJH Liu <mandyjh.liu@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>, iommu@lists.linux.dev, linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v2 03/19] dt-bindings: power: mediatek: Add bindings for
 MediaTek SCPSYS
Message-ID: <20220718211500.GA3562861-robh@kernel.org>
References: <20220714122837.20094-1-tinghan.shen@mediatek.com>
 <20220714122837.20094-4-tinghan.shen@mediatek.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220714122837.20094-4-tinghan.shen@mediatek.com>

On Thu, Jul 14, 2022 at 08:28:21PM +0800, Tinghan Shen wrote:
> The System Control Processor System (SCPSYS) has several power
> management related tasks in the system. Add the bindings for it.

Please coordinate your work:

https://lore.kernel.org/linux-arm-kernel/20220718180654.GA3260460-robh@kernel.org/

> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> ---
>  .../bindings/mfd/mediatek,scpsys.yaml         | 62 +++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/mediatek,scpsys.yaml
