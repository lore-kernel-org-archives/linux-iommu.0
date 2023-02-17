Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893582560
	for <iommu@lists.linux.dev>; Fri, 17 Feb 2023 09:23:39 +0000 (UTC)
Received: by mail-ed1-f43.google.com with SMTP id l11so2386643edb.11
        for <iommu@lists.linux.dev>; Fri, 17 Feb 2023 01:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1uhXWC5aUog2B3MifbzjgvTuIZZSneoOYENLVLF/lKo=;
        b=chKsPtB2hT8iQd0O3UAtAE7NwizW0neSxB7B7EZwVa3mYLn0K1FcBNjdDKkUNi/rY7
         6Ib1WaGIu+wGXltyhaFqmjH0cXGQsq0ZzT2buGbSUgs2IG0Dd8sUWjQT1uIIT3V2CXf4
         Pz+eYhFnz/IU927IhztkWlsp0ucMgWhusahIc5sEyW6IbDd5i8RjUxHXElXJgdeMS5xv
         kl6xIMSb4dILHSFFuLnMcehWArNGYohQoc6UsdNKUF03qFZaDfwpMfJXjv5A0SuVIhVu
         ecNo5OI2lELoSVgwN870+3hoDnbZpDvLC0fBYFqGlQJ2le7qPg0lqwK83mpPu1SRCUvR
         aZfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1uhXWC5aUog2B3MifbzjgvTuIZZSneoOYENLVLF/lKo=;
        b=rVwE4601PiOcDRgSZMpXp5kqb98+igyyP/C5xWwROfsjZw2/MXTaSAGwUOzDwYysGa
         aG9BrcJY8CCVLf/rqaF1dRwuJ8xYbGOO1G4lDTTaQ11JgPDwfJL5YsN8VNAfaAtlXvZw
         D/ZZ1Yr0CD/jE0dkZ0r4+9ur7gV6dUCf7Di+h5OjNZM/Y22OyAZAMLh66Jk9fgrHt0U6
         jzAa3fuhXJuFTmk8hiMaacFdYu4nHEuqD/VmAlSuSxgdVOlMiZ337tRYk3sl8sbqTuRG
         mrPsSgMbukd7jmWbT9QUqVsCJZgEz7Q+J9lrx0asWj1Yd7YcuSyB1NU5rhBzzDYz/rNl
         hNKA==
X-Gm-Message-State: AO0yUKV/5zyWuJKUq9PkzwwZF91d692HR4f/Gj0lG0eUsSaZwY8XGs9u
	dXuLQ5TAIvRFaoMzCqtvM5txWQ==
X-Google-Smtp-Source: AK7set917pjRrPajgtaJkUtWkGOkMBJyKzJs5QyJgmH71D2U+yOlZOHZsD2RSv78b/Ft7In+yuB16w==
X-Received: by 2002:aa7:cd51:0:b0:4ac:b32e:b6f with SMTP id v17-20020aa7cd51000000b004acb32e0b6fmr104366edw.23.1676625817729;
        Fri, 17 Feb 2023 01:23:37 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id x29-20020a50d61d000000b0049e1f167956sm2000726edi.9.2023.02.17.01.23.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Feb 2023 01:23:37 -0800 (PST)
Message-ID: <08b993f9-f998-14c8-221a-a0b80ac5d342@linaro.org>
Date: Fri, 17 Feb 2023 10:23:34 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v7 1/6] dt-bindings: mediatek: mt8188: Add binding for MM
 & INFRA IOMMU
Content-Language: en-US
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: Robin Murphy <robin.murphy@arm.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 iommu@lists.linux.dev, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, mingyuan.ma@mediatek.com,
 yf.wang@mediatek.com, jianjiao.zeng@mediatek.com, chengci.xu@mediatek.com,
 youlin.pei@mediatek.com
References: <20230216053322.11596-1-yong.wu@mediatek.com>
 <20230216053322.11596-2-yong.wu@mediatek.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230216053322.11596-2-yong.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/02/2023 06:33, Yong Wu wrote:
> From: "Chengci.Xu" <chengci.xu@mediatek.com>
> 
> Add descriptions for mt8188 IOMMU which also use ARM Short-Descriptor
> translation table format.
> 
> In mt8188, there are two smi-common HW and IOMMU, one is for vdo(video
> output), the other is for vpp(video processing pipe). They connects
> with different smi-larbs, then some setting(larbid_remap) is different.
> Differentiate them with the compatible string.
> 
> Something like this:
> 
>   IOMMU(VDO)          IOMMU(VPP)
>       |                   |
> SMI_COMMON_VDO      SMI_COMMON_VPP
> 
> ---------------     ----------------
>   |     |    ...      |     |    ...
> larb0 larb2  ...    larb1 larb3  ...
> 
> We also have an IOMMU that is for infra master like PCIe.
> And infra master don't have the larb and ports.
> 
> Signed-off-by: Chengci.Xu <chengci.xu@mediatek.com>
> Reviewed-by: Yong Wu <yong.wu@mediatek.com>
> ---
> Hi Krzysztof,
> I added some comment about larbid index, this is for readable when
> adding iova_region_larb_msk in the code.
> I'm not sure if it is ok for you, thus don't keep your A-b currently.
> Thanks.
> ---
>  .../bindings/iommu/mediatek,iommu.yaml        |  12 +-
>  .../memory/mediatek,mt8188-memory-port.h      | 489 ++++++++++++++++++
>  2 files changed, 500 insertions(+), 1 deletion(-)


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

