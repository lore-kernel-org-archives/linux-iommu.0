Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6B265A
	for <iommu@lists.linux.dev>; Fri,  9 Sep 2022 07:11:10 +0000 (UTC)
Received: by mail-lj1-f180.google.com with SMTP id by6so741098ljb.11
        for <iommu@lists.linux.dev>; Fri, 09 Sep 2022 00:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=y0DoW8vregXVH+TM9mSXdMASvPMT9wSQ3N08H3J6evs=;
        b=w290wK8hnQpSbBmI3NNQEyLEA0IUA1o7Yh2KDXNLksO9NzSUKeKrwKdCpZcrSqzj+u
         iM0CFYgP/r4t74k4pGZEg05CgZcSA1y5VZWab4+viW0PdL6vzWGGi8raEZun5V4UrjK1
         wYjdB5iYfKMNW/kj/4am9xtzGvglsW57d4gXgUeEleLJgUcY9xGarD/KCq1TEBCNmFQZ
         jj/MRGOPYfZDTND/SumPuDpt/Sv4AJLgpxC9NkbcX+vyjdZaKdzAlnVkPK9ymxWBBhMG
         6C1I2qGyG9dSrMd5y6LSPnz1PpwE4Z+dxZ+0ZAvaGA8aHT/0q/AB5iQ+e1BoLYnC/h5h
         qT7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=y0DoW8vregXVH+TM9mSXdMASvPMT9wSQ3N08H3J6evs=;
        b=LCbjTz5tOxb1vyo9EojBib0xuy6FPmMMnPy8AuaVEafU6wWPGrdoirvpg/64HsvRsb
         OmC5g2SDTJoDx1msYFNUNf/Pl3nbamSjizYOrjMZU47srUsbz3sZhqt/S3MYhyTP3ZQh
         AnErIo7vbF1EZtwJw8roe7MHVRjNSe3K0wfN7kGIgG//hCXvHe8D42ZTS5PjV55q40CK
         W4wl09yLQMLNsC9+cSktX/j6lUbgOfzOdgwDx9OVKQxT0MRt0ks434hPBsz2CJQE4wrM
         0cVbJjhv+sJB7lHCWjLoUUZGasI6oI+8rdJipsceyxOqBPm4digTPKaN/K8K7Hfrzybx
         Ns0A==
X-Gm-Message-State: ACgBeo2dndkxD5IxloNxCSbhunVwYVZ1dlvAvg4dFDSpPfWjo9/xuS3+
	FrbEz/2NZQBWiCDprlwPB94Lwg==
X-Google-Smtp-Source: AA6agR5cskGKF9Nq7MxQL8NV1peMGWdlaRakuhFzDBcuIUAY5U+RObocA3dShuBgZsktmyl+JKAROw==
X-Received: by 2002:a2e:aa13:0:b0:264:eb98:b7fd with SMTP id bf19-20020a2eaa13000000b00264eb98b7fdmr3379497ljb.26.1662707468235;
        Fri, 09 Sep 2022 00:11:08 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id q30-20020ac2511e000000b004979ec19387sm142439lfb.305.2022.09.09.00.11.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 00:11:07 -0700 (PDT)
Message-ID: <87307ae4-a320-5880-1333-6ea700b61ca7@linaro.org>
Date: Fri, 9 Sep 2022 09:11:06 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 1/3] dt-bindings: mediatek: mt8188: Add binding for MM
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
References: <20220831125502.7818-1-chengci.xu@mediatek.com>
 <20220831125502.7818-2-chengci.xu@mediatek.com>
 <2e575ed1-b82c-c7bd-3ddf-ccb6022b2461@linaro.org>
 <c09f262422dd6cd0bf2147870a109bd2ede36d4f.camel@mediatek.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <c09f262422dd6cd0bf2147870a109bd2ede36d4f.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/09/2022 05:20, Chengci.Xu wrote:
>>> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause) */
>>
>> Why do you license it under BSD-3 clause?
>>
> 
> A mediatek internal wiki suggest me use "BSD-3-Clause" without detial
> reason. May be it is not suitable for this file.
> 
> If you don't approve of this, I can change this license to "GPL-2.0-
> only OR BSD-2-Clause", which is perferred by DT bindings file according
> to "submitting-patches.rst". 
> 
> Do you think "BSD-2-Clause" is OK? Or could you kindly share me another
> proper license?

Please switch to "GPL-2.0-only OR BSD-2-Clause", which is preferred for
bindings.


Best regards,
Krzysztof
