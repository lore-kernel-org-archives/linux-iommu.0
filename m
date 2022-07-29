Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCCF1104
	for <iommu@lists.linux.dev>; Fri, 29 Jul 2022 22:59:19 +0000 (UTC)
Received: by mail-il1-f178.google.com with SMTP id r4so799679ilm.2
        for <iommu@lists.linux.dev>; Fri, 29 Jul 2022 15:59:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=qtHVxHIf1ranp5UWH3YvWfj77wihU7UmTQjplZtOLAo=;
        b=PmysI2UzShb/t2tUNCaUEZ5Pn+D3Slk1o0SXNetdBDohE8PnaftBmfgwqUGgMsTlNd
         3MT9W2xa7Y+ZEsY7e6sdhAx45OLkBB80Tg4jw1dYaAGk2ipnh6Ukyrzqe4HYEhj6O2mY
         qqkohIAs9/M97dYJ4cJ3VK0oXiFsiqYHWoQJpwDTakTkehr0Lbkw3KW/2q1OPyMo11Zo
         1TR26M6rZgXD74UQ1Ow6rdomt9lkjwICNY7vlqXGQp0rYNgeoHr/PWboD+qkFYX5nLvT
         uLKqdcggvno/GSnWfQii5UjnI4Kv+tfjNYCVBUgWV/S5g7fkuGgwmgp0eMKevO5uRclK
         DvOg==
X-Gm-Message-State: AJIora//+lkUQykWtriQHg2tQRzPvLLKpNFjL1igwAe9pMLRFG2D1Yol
	VUyn8wd7RoY6spoYeXlg+w==
X-Google-Smtp-Source: AGRyM1uImBYJJceitPtvDPkne05B/TOaHpSUK/ydXKTmD9uWheT6PiMogps3kBxE+zuC91ugtcAjAQ==
X-Received: by 2002:a05:6e02:1c23:b0:2dc:e497:8b12 with SMTP id m3-20020a056e021c2300b002dce4978b12mr2184159ilh.151.1659135558409;
        Fri, 29 Jul 2022 15:59:18 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id f5-20020a056638168500b0033f5e8dab90sm2262072jat.143.2022.07.29.15.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 15:59:17 -0700 (PDT)
Received: (nullmailer pid 96409 invoked by uid 1000);
	Fri, 29 Jul 2022 22:59:15 -0000
Date: Fri, 29 Jul 2022 16:59:15 -0600
From: Rob Herring <robh@kernel.org>
To: Tinghan Shen <tinghan.shen@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, iommu@lists.linux.dev, linux-mediatek@lists.infradead.org, MandyJH Liu <mandyjh.liu@mediatek.com>, devicetree@vger.kernel.org, Project_Global_Chrome_Upstream_Group@mediatek.com, Robin Murphy <robin.murphy@arm.com>, Yong Wu <yong.wu@mediatek.com>, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v4 06/20] dt-bindings: power: mediatek: Add bindings for
 MediaTek SCPSYS
Message-ID: <20220729225915.GA96357-robh@kernel.org>
References: <20220729063208.16799-1-tinghan.shen@mediatek.com>
 <20220729063208.16799-7-tinghan.shen@mediatek.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220729063208.16799-7-tinghan.shen@mediatek.com>

On Fri, 29 Jul 2022 14:31:54 +0800, Tinghan Shen wrote:
> The System Control Processor System (SCPSYS) has several power
> management related tasks in the system. Add the bindings for it.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> ---
>  .../bindings/mfd/mediatek,mt8195-scpsys.yaml  | 67 +++++++++++++++++++
>  .../power/mediatek,power-controller.yaml      |  2 +-
>  2 files changed, 68 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/mediatek,mt8195-scpsys.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
