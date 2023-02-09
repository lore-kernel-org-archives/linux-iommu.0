Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFDC64A
	for <iommu@lists.linux.dev>; Thu,  9 Feb 2023 17:45:54 +0000 (UTC)
Received: by mail-oi1-f181.google.com with SMTP id dt8so2341559oib.0
        for <iommu@lists.linux.dev>; Thu, 09 Feb 2023 09:45:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0DrSTVU0MouuPAPgDnH3bvO6W0mBoIKC+iPYe6f7yQ8=;
        b=BPqsOTRbXu/xFIZGxgi4hHqUrdLsREjfL6ukZv3x5vu+o93dgql16u8hAs8TRjiBYw
         4KrFPBxhWNZ+Dq2h1zI/8iwrN8rEUvfuCo53ZhnZMf8QdSzf3mQd76UgJ94ZC94iDgIy
         IekVf22e60bG2gskviyw/2mVE6qaZbWZZx+pd87TZIeiDldWoWpV06FyKycC/OGIZdqx
         Y93/EyyySlQZWMiZ8VyiSLg5Rt6ypsEHpGzyNLfZ3bVH6sDAJN5CIYHh/hX0u+Oe9BF6
         xkWB04kA9/z2AtiE/ipH+qh6QDb+v6PmYkMmI3rfSeS0gZerCLNW/HDXlkH8gh+dwePH
         dvKg==
X-Gm-Message-State: AO0yUKUbw5uCaNNun0qmUMZmvy+Wzbanocf/5y0eNACnmLGklY8CFpsl
	hf+3ngcJYh1oitzRM2ncJg==
X-Google-Smtp-Source: AK7set9jyx6LMJhbcKNlh1fXP27jxIMoQEJ+KUbwmEZRPY53UW1ny3huB384noPvethCecih31RSAw==
X-Received: by 2002:a05:6808:279a:b0:37b:3177:65c with SMTP id es26-20020a056808279a00b0037b3177065cmr5747500oib.28.1675964753686;
        Thu, 09 Feb 2023 09:45:53 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z14-20020a0568301dae00b0068d56f93d73sm973117oti.26.2023.02.09.09.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 09:45:53 -0800 (PST)
Received: (nullmailer pid 556291 invoked by uid 1000);
	Thu, 09 Feb 2023 17:45:52 -0000
Date: Thu, 9 Feb 2023 11:45:52 -0600
From: Rob Herring <robh@kernel.org>
To: Yong Wu <yong.wu@mediatek.com>
Cc: anan.sun@mediatek.com, Xia Jiang <xia.jiang@mediatek.com>, Rob Herring <robh+dt@kernel.org>, yf.wang@mediatek.com, chengci.xu@mediatek.com, iommu@lists.linux.dev, devicetree@vger.kernel.org, Yunfei Dong <yunfei.dong@mediatek.com>, Robin Murphy <robin.murphy@arm.com>, mingyuan.ma@mediatek.com, Joerg Roedel <joro@8bytes.org>, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>, libo.kang@mediatek.com, kyrie wu <kyrie.wu@mediatek.corp-partner.google.com>, youlin.pei@mediatek.com, Matthias Brugger <matthias.bgg@gmail.com>, nfraprado@collabora.com, Will Deacon <will@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Hans Verkuil <hverkuil@xs4all.nl>, Bin Liu <bin.liu@mediatek.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 02/10] dt-bindings: media: mediatek,jpeg: Remove
 dma-ranges property
Message-ID: <167596475165.556224.15663986433586946843.robh@kernel.org>
References: <20230208053643.28249-1-yong.wu@mediatek.com>
 <20230208053643.28249-3-yong.wu@mediatek.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230208053643.28249-3-yong.wu@mediatek.com>


On Wed, 08 Feb 2023 13:36:35 +0800, Yong Wu wrote:
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
> ---
>  .../devicetree/bindings/media/mediatek,mt8195-jpegdec.yaml | 7 -------
>  .../devicetree/bindings/media/mediatek,mt8195-jpegenc.yaml | 7 -------
>  .../devicetree/bindings/media/mediatek-jpeg-encoder.yaml   | 5 -----
>  3 files changed, 19 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

