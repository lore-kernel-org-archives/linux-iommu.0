Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4694A1F
	for <iommu@lists.linux.dev>; Mon, 19 Sep 2022 11:05:19 +0000 (UTC)
Received: by mail-lf1-f49.google.com with SMTP id f9so45603782lfr.3
        for <iommu@lists.linux.dev>; Mon, 19 Sep 2022 04:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=A1FM6FAoiEC7PRrQXFWOsfGGjoGMqEaUpaQkuBnp1+0=;
        b=E+e2zAkBBAYbfP4FR7CDEDZL6ZBO3HanynU8QYzX2dHuxE/7jtOkzzGnboB92pZKlz
         CfolEkfmNq200LVMY9y1ZqenAfdaLjzzhMUb5izdzqtRETRUDlYv0kAqWmNvj/j7juma
         kRUBzqcdD2LODp1Gjs0eDSFfkB2H8Qxa3IAglVyEdxWB9p+3CXVprVCEVJtcGNhRnTJ3
         QLPUphIs8bDk4Ky+7g1R/98hE2H5KAh2uTVlhK6lzbHNmpjG+hMCtGYAquKu3GPrWq4J
         lbgQ0OeAEqYYxWAJ/RX7KQdfyGCEjvnE4DmlvxMY17PGaONt+jgncae3EoEDHB1KarrC
         CneQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=A1FM6FAoiEC7PRrQXFWOsfGGjoGMqEaUpaQkuBnp1+0=;
        b=lUgHttSNbaoipycuCHzeM9WqXWqT/+CKnnSiBzL3hZX0dpLGpF8nguuZkuMxVTzBNz
         4dyzp60yTHiQYAsECJU1E93UyD+yXgFoneSqJofo8tAaAQAcrVtoqM7BvhHbsjOcq+bU
         8ezaLY+9FuXKVVpO7dd0xIGBlv3rpGUgRH1VsxlTrUrwgWa51fThkzKp+msRw5F1wcN/
         jwi1wygrdYCvT8Z5iue1lZxOzg1pn7AV2TAgaFCFY00lu0EPjd1qN/ZTyFbks8sm0WTn
         w+gQjj8IZNx3C8SiM/dN6wmfO4bV0dTlxX9S6Q6fPGWMjBb4X+gZaI/iAkm3W2cNaTu0
         lhgA==
X-Gm-Message-State: ACrzQf3pI/+CaGytWH1gZKZDDOZuXqIqT7grGSRqHHTRpZzKe1Dy5wdI
	N8ciVHPQfKS7TT0nkxuzUJ5uFA==
X-Google-Smtp-Source: AMsMyM6YrKPdqb1UqOzTNjT+xjVxRozWKcwrIhZa5ApEvR1bc0UP6/cShGl5qisCorV5ckrazWZ4Bg==
X-Received: by 2002:ac2:4c35:0:b0:497:ae09:11b with SMTP id u21-20020ac24c35000000b00497ae09011bmr5900342lfq.507.1663585517490;
        Mon, 19 Sep 2022 04:05:17 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id w9-20020a05651234c900b00499bf7605afsm5010369lfr.143.2022.09.19.04.05.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 04:05:17 -0700 (PDT)
Message-ID: <2e2a7dbb-ba8a-3406-b54d-0ca135193c3c@linaro.org>
Date: Mon, 19 Sep 2022 13:05:16 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3 1/3] dt-bindings: mediatek: mt8188: Add binding for MM
 & INFRA IOMMU
Content-Language: en-US
To: "Chengci.Xu" <chengci.xu@mediatek.com>, Yong Wu <yong.wu@mediatek.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: iommu@lists.linux.dev, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220919082611.19824-1-chengci.xu@mediatek.com>
 <20220919082611.19824-2-chengci.xu@mediatek.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220919082611.19824-2-chengci.xu@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/09/2022 10:26, Chengci.Xu wrote:
> Adds descriptions for mt8188 IOMMU which also use ARM Short-Descriptor
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
> ---------------     ----------------
>   |     |    ...      |     |    ...
> larb0 larb2  ...    larb1 larb3  ...
> 
> We also have an IOMMU that is for infra master like PCIe.
> And infra master don't have the larb and ports.
> 
> Signed-off-by: Chengci.Xu <chengci.xu@mediatek.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
