Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15154A35
	for <iommu@lists.linux.dev>; Mon, 25 Jul 2022 22:24:54 +0000 (UTC)
Received: by mail-oi1-f172.google.com with SMTP id w204so15149003oie.7
        for <iommu@lists.linux.dev>; Mon, 25 Jul 2022 15:24:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4lnMpoZb+qHkuYn7ZnPpjURPzGmFuQzUhlPQ6dAnI2E=;
        b=qL/wJz6cmIgwUq+9iLHHYGUAsKYoxv/wmCG95YwZcoOSdMJrFY/1lNVMbhI0nUYz1E
         r/feWmmndk9fEmV8gs37+NggcTBZ3lSYrOaRONWdfs4J8P8BmOAJTjx7p1g1AmCFn0QF
         L8MlFD77Vg7z6tx/yBCEpM/u5sZ8BAiBD+Uv4Gzx0Or9YpJmRTrBpYHEOZBU1EXQMVO2
         /eIBFB9TW0AR39H8xOInIl8Lz7B6rdRXcvp62mHPkyioDw0Y9lm6SjtDAnX2Sh98kO4i
         nHXlzfj2pM2pi/s1QRAjCiujJIz1wUvdzPlAVUt4kXbvYvfhbex5WA/R719ZM77Ivsyf
         SNZg==
X-Gm-Message-State: AJIora8TNpcaoRN8HzwROSpampvRt6WOtPZfkBXhx0MwnbA8DlcGWsho
	BCbLLwN11sDPoPb74T/LNg==
X-Google-Smtp-Source: AGRyM1vAofLtAEFQzPOgCv9X/fCj3FwcSwZCkPVppTY/bmRdoY/U3iOTun0xg2e24/o3pIP7hHNcIg==
X-Received: by 2002:a54:458b:0:b0:33a:74a7:4271 with SMTP id z11-20020a54458b000000b0033a74a74271mr6389250oib.287.1658787893762;
        Mon, 25 Jul 2022 15:24:53 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id l6-20020a05687040c600b0010c5005d427sm6639754oal.33.2022.07.25.15.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 15:24:53 -0700 (PDT)
Received: (nullmailer pid 2853362 invoked by uid 1000);
	Mon, 25 Jul 2022 22:24:51 -0000
Date: Mon, 25 Jul 2022 16:24:51 -0600
From: Rob Herring <robh@kernel.org>
To: Tinghan Shen <tinghan.shen@mediatek.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, devicetree@vger.kernel.org, Yong Wu <yong.wu@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, Joerg Roedel <joro@8bytes.org>, Lee Jones <lee.jones@linaro.org>, MandyJH Liu <mandyjh.liu@mediatek.com>, Rob Herring <robh+dt@kernel.org>, Project_Global_Chrome_Upstream_Group@mediatek.com, linux-mediatek@lists.infradead.org, iommu@lists.linux.dev
Subject: Re: [PATCH v3 05/21] dt-bindings: power: mediatek: Update maintainer
 list
Message-ID: <20220725222451.GA2853305-robh@kernel.org>
References: <20220720123023.13500-1-tinghan.shen@mediatek.com>
 <20220720123023.13500-6-tinghan.shen@mediatek.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220720123023.13500-6-tinghan.shen@mediatek.com>

On Wed, 20 Jul 2022 20:30:07 +0800, Tinghan Shen wrote:
> Update the maintainer list of power controller binding.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> ---
>  .../devicetree/bindings/power/mediatek,power-controller.yaml    | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
