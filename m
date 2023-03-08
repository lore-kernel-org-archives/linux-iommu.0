Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4E728F3
	for <iommu@lists.linux.dev>; Wed,  8 Mar 2023 10:35:22 +0000 (UTC)
Received: by mail-ed1-f51.google.com with SMTP id k10so39862787edk.13
        for <iommu@lists.linux.dev>; Wed, 08 Mar 2023 02:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678271720;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1eqhJeejf+RQmERnpGqMGzgAI9CUz2kwB1CbIir0tP8=;
        b=ykMZOphQFA1DVSYvYk/K0/T3ZpYXYSMOYsUgSrev8ZzdS3BDpmr6OP1+nrm/d9U+2D
         I5/FuOppgiSp2DjICE5b3FChw++7ies1Gq/GWCNV51wX+V+S0v6g2BXiARRFYDE+gsP0
         6UgUE+Lip0yiSKrmlbSVXOttgUEZT6sLjjomSOtbLNvG2bNW33V25PcdEAAshy3tifHu
         8TJbyP7cbB44nb7R5r7J+GouRiMHGaTeMR0OnAFaW+uf+gBlx4FN82TKlljm4f8VhB9N
         YJ+7gBv8ezagrTk0R/nVw56gIAjc1k78sWaghur2EITACXeGtXmft1RZpnuufSjaWzgA
         kGpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678271720;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1eqhJeejf+RQmERnpGqMGzgAI9CUz2kwB1CbIir0tP8=;
        b=rPi9uTXUO1QAFsRXp9kb2FnBit67FGKZGx/X4KEzo2hf2ZOIfhZWL3/tEnkheDacmn
         BxWHHn7vodUroTmsQ9uPqUZk8A/RgdXU6XjXwrHFEH0+YsPmNGrJ9gD0ZuN/SPPeu+v9
         ywW6F5ATNK6hNG4AfUCVFbTQi14MAeQqpGRYi0uuWLCF8VGZxQQRmPCGhpBtQaFjN9qh
         8B6JYEkwIMJS9Saij4aDiXnDqB2bfTehgT1iFKn8mY5/Hnc9AAktZDVyueYCsJpBZL1o
         jnTapCppycBrZlLgG666wcxjtFfyIllYIgb3rS7brXip53O6fYqS50zXG/GIH74kqOcy
         oXrg==
X-Gm-Message-State: AO0yUKVsnCOk80gUjkaXQhU+oP8glpwOXVpU+c8+aBFibkTi8mgrKChz
	4r5eXeRiESUlZKQSbcRO7YQyuQ==
X-Google-Smtp-Source: AK7set85h3HEkM1KFOIkaPrFIqwjm1PNUWaPYN8WE8M5LcYma/+vDI3oDsZBOeitBKuc8tC5KN/j0A==
X-Received: by 2002:a05:6402:383:b0:4ad:1e35:771f with SMTP id o3-20020a056402038300b004ad1e35771fmr15484678edv.35.1678271720773;
        Wed, 08 Mar 2023 02:35:20 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:ff33:9b14:bdd2:a3da? ([2a02:810d:15c0:828:ff33:9b14:bdd2:a3da])
        by smtp.gmail.com with ESMTPSA id k17-20020a170906a39100b008b17fe9ac6csm7397482ejz.178.2023.03.08.02.35.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 02:35:20 -0800 (PST)
Message-ID: <388e2274-d46a-68a4-3e85-5bd597085041@linaro.org>
Date: Wed, 8 Mar 2023 11:35:19 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v8 1/7] dt-bindings: mediatek: mt8188: Add binding for MM
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
References: <20230307080555.14399-1-yong.wu@mediatek.com>
 <20230307080555.14399-2-yong.wu@mediatek.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230307080555.14399-2-yong.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/03/2023 09:05, Yong Wu wrote:
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
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Indeed, I missed broken checkpatch/DCO chain.

NAK. Please fix the chain.

Best regards,
Krzysztof

