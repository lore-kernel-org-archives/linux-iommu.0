Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890CB20E0
	for <iommu@lists.linux.dev>; Fri, 15 Jul 2022 07:36:00 +0000 (UTC)
Received: by mail-lj1-f170.google.com with SMTP id a10so4813794ljj.5
        for <iommu@lists.linux.dev>; Fri, 15 Jul 2022 00:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=mqhVEUWoJhyGaRXatPdO6jF7+Eft9kIRbLVR6FWlzs8=;
        b=qjvMjtSFhMHa6WnM74siqopulg6O3rjmx3IiBooXy24W/I4PZDNd+xl+uQGyiC1DZb
         lWSfhBY62FfqUJPPAXUjczFT0aIo4m6S8H0G2jRVq8b5ye6HG/pii+GGvDCQtIvh+fnO
         XRT06LG1Jrsu9wN0TpvNrdx+gSWPx6A80gCufY3qCCovtvtHOgGRPlxsaSSmDvfOs+Kx
         8gMkrLffn5LHOlrIxv7+/xe1caZMYMya/z7j91Oec0mGl4cN/XYqMSkWSqkbC9ckT/LP
         CPFq0oj54KUPsoZaR86X2Te9VAE0jtoZgM7Td6AvTmm6RDdgwd5pakE6FUb5ZdfDhFkV
         uNXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mqhVEUWoJhyGaRXatPdO6jF7+Eft9kIRbLVR6FWlzs8=;
        b=ViGHCYUWzROKtGRZBH9ZTc6Q6lKIVmhc1HJ32OJPeL8Scpq2hrom/K3rpjJtizgTiX
         bunXDig6DIqu0BQlc6P0D7ZDp25K24S6Q9RQFyMgDB01Hli8MnSEJia+6rXlF3Pjv9Sx
         TCDtNN4+pJrVMnLnBbIMjFTu7YfeY/q9CyHKeGXwL/WNlBaUvM2DMv1ZoghofEdBy8Ul
         rH3MvA49efi5Nn8PK+VN2mmmPRy0vQE7mxGmxKz5UDU/zt7Xxd8sor+K9Q81jkukZJSZ
         Qss0eNAkmiGEdJmKAwJlaLcWA6HaSoTNfNv2rXzIYojG0BaY7xJn+LY+wo6gwuzfnVM8
         NaRw==
X-Gm-Message-State: AJIora8AgVm5ipjTa1OMcp22Zj9c6JxsQnnsnEZbWOI2SI9ABiz3RQI8
	9Ydqmf9zq55FgCVmJg/ay4mAMw==
X-Google-Smtp-Source: AGRyM1tOzrr9Yq9VEdfdXk1wmZFGhIc3cdIcL/0dwI8mv3a3rDX0Kkzg3QqLlEmjX7QvHubznwMfXQ==
X-Received: by 2002:a05:651c:1a0a:b0:25d:a17d:9c23 with SMTP id by10-20020a05651c1a0a00b0025da17d9c23mr1419736ljb.480.1657870558571;
        Fri, 15 Jul 2022 00:35:58 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id 3-20020ac25f03000000b004790a4ce3e5sm771300lfq.278.2022.07.15.00.35.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jul 2022 00:35:58 -0700 (PDT)
Message-ID: <9f8217f5-7369-0abe-cf8a-d501e163580f@linaro.org>
Date: Fri, 15 Jul 2022 09:35:55 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 02/19] dt-bindings: memory: mediatek: Update condition
 for mt8195 smi node
Content-Language: en-US
To: Tinghan Shen <tinghan.shen@mediatek.com>, Yong Wu <yong.wu@mediatek.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Lee Jones <lee.jones@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Chun-Jie Chen <chun-jie.chen@mediatek.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 MandyJH Liu <mandyjh.liu@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>
Cc: iommu@lists.linux.dev, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220714122837.20094-1-tinghan.shen@mediatek.com>
 <20220714122837.20094-3-tinghan.shen@mediatek.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220714122837.20094-3-tinghan.shen@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/07/2022 14:28, Tinghan Shen wrote:
> The max clock items for the dts node with compatible
> 'mediatek,mt8195-smi-sub-common' should be 3.
> 
> However, the dtbs_check of such node will get following message,
> arch/arm64/boot/dts/mediatek/mt8195-evb.dtb: smi@14010000: clock-names: ['apb', 'smi', 'gals0'] is too long
>          From schema: Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
> 
> It's because the 'mediatek,mt8195-smi-sub-common' compatible incorrectly
> matches the 'else' conditions for gen2 HW without gals.
> 
> Rewrite the 'else' condition to specifically identify the compatibles
> that utilizing gen2 HW without gals.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
