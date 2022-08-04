Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AD12585
	for <iommu@lists.linux.dev>; Thu,  4 Aug 2022 15:12:35 +0000 (UTC)
Received: by mail-lf1-f51.google.com with SMTP id e15so21220680lfs.0
        for <iommu@lists.linux.dev>; Thu, 04 Aug 2022 08:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=flkVgJSkLgJ6BOpNMmZn044hSm3xppsdwA5+7hs10Sw=;
        b=VoNdeeXAdgGXCwnYXIP0vshrJlTj60Rj0SlnPnxPXaKKWiUFheu9gCKm8hfkKqss4q
         uYQzS3hcLbXxbCwFsFCrf6KwE5Yi2bWFe7YoI0UIhgzlrMqmbNYlgjbPE+tHi/0JDK8p
         Jx2NKK6q8R9eW80z/ftc4GQg5ypo3E0oKACcSRzK1M/qfq4McC0vPWDXWfaldPwFvaGP
         R7o4j4FZvOjyxtuiNODfEQ3DyTbxyLjW921OdjA2jHLFmdZL3bpldBpuQQYSIwifglt+
         ByaQjKOzWHbsGOd6yPtP/Byff7IzkdG3a1TVnSONhRzjxJTK66sDwmzeIBw1LJrSNzGw
         Sp5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=flkVgJSkLgJ6BOpNMmZn044hSm3xppsdwA5+7hs10Sw=;
        b=uW3VnfxIJYmoR+faVUCW1EkAEAIvkq1tnrztxv1ptkxPL+CHvce1v380w5UY3mhpH1
         HqNKmyvAPmu/Rsl3bKVSFcd+S3pr+BEcUkPTXM+X1FCNIgn6h44Kt+YO7C4czOI+o76B
         31TWPg2Y5iOb6YwXGog9/I8U5S+DKkSX2un63mi5WzwAZLqGpjCUlz8v9ngPplHiZJPL
         AQtcgBiavhW3Ta83F4PBUvMMfM2NzqjJ47GNAw37a8i3WUsA8Mm180gKkNEwKWAK0vgl
         /vT8tR09a443lWlrJ3OIYhaVNnuDqIokK31QDyaRia8FftEmBAlNuXaXZSn4xWfi3W0u
         UoPw==
X-Gm-Message-State: ACgBeo1wMC2Jedg67BKfGMmfX4anVGizMbnRlcrve9pa3p5H7U9TSnDv
	KhtpcrnY8krKCFxaYdFnsOs4ZQ==
X-Google-Smtp-Source: AA6agR4xRfdJNey5VDI+Z+Ke7JJhcpNk9MMKaJuqCPEr/8M6Ybdcf7CJcsxxJBA11P5XBB6r/pHgyA==
X-Received: by 2002:a05:6512:2202:b0:48a:1153:d3a0 with SMTP id h2-20020a056512220200b0048a1153d3a0mr798559lfu.423.1659625953271;
        Thu, 04 Aug 2022 08:12:33 -0700 (PDT)
Received: from [192.168.1.6] ([77.222.167.48])
        by smtp.gmail.com with ESMTPSA id 11-20020a05651c128b00b0025e51a00a5asm156500ljc.41.2022.08.04.08.12.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Aug 2022 08:12:31 -0700 (PDT)
Message-ID: <96e66425-ff2a-4640-8b96-48fa39943bf9@linaro.org>
Date: Thu, 4 Aug 2022 17:12:29 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v5 02/20] dt-bindings: memory: mediatek: Update condition
 for mt8195 smi node
Content-Language: en-US
To: Tinghan Shen <tinghan.shen@mediatek.com>, Yong Wu <yong.wu@mediatek.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Lee Jones <lee@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 MandyJH Liu <mandyjh.liu@mediatek.com>
Cc: iommu@lists.linux.dev, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220804021553.14867-1-tinghan.shen@mediatek.com>
 <20220804021553.14867-3-tinghan.shen@mediatek.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220804021553.14867-3-tinghan.shen@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/08/2022 04:15, Tinghan Shen wrote:
> 
> It's because the 'mediatek,mt8195-smi-sub-common' compatible incorrectly
> matches the 'else' conditions for gen2 HW without gals.
> 
> Rewrite the 'else' condition to specifically identify the compatibles
> that utilizing gen2 HW without gals.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno
>  <angelogioacchino.delregno@collabora.com>

Unfortunately, your patches got corrupted.


Best regards,
Krzysztof
