Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B444B1859
	for <iommu@lists.linux.dev>; Fri,  4 Nov 2022 13:47:18 +0000 (UTC)
Received: by mail-qt1-f175.google.com with SMTP id cg5so2998827qtb.12
        for <iommu@lists.linux.dev>; Fri, 04 Nov 2022 06:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L7WseZRfMElBir/cLk2JQliiFaWR+DdJpgj5HlfNINc=;
        b=aInlDUycJ9stGOQ6sNTM+uIgV0KRZL7s6M68oHhc/YoM9U5BqzyAomesP/Sj+Wr/22
         WollcOSLAbZi9hbxHsy/rqLH5BoWyJAaQS+mOTHxTT+H0FdBPjME44F8W+xGcIk4dDfk
         8rpm2zHbs//JwMzcDr2FPThODj+A9Fu1o1SGwenIoq4rjZRsee6JzUbjX3mXjkDiZdIW
         vILgo8knX1lCe15B2REdpPTOtMDOghaPl81hC+v4xj6t3mK/DAVrnUsiI7sUdr77NiIs
         GLmPW1pYtKJ8zpb5d2dHVpzELbhKLgLGPB/9bGHF2fEc6kw4PTKUr1J40pjPgugMjXol
         Zf+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L7WseZRfMElBir/cLk2JQliiFaWR+DdJpgj5HlfNINc=;
        b=6GuuSk8ljhuSI2dbsft2zIgXagu5OHWCKVf58HsFNx5Y1VFXZJXJrfePLSK3EK4wQR
         Hn2UZjBHWHfftCttXOd6OmtE/m9h7H5Pt9xTURW8UnV31yCYGoonE7Gq7BYX+D9GFteq
         2P/cfcdam2SDi3WvA0D/rILkj6C8rSjOPOzWbZP1q55FArBPUfm6NE7V9H46nq/Xkbju
         wgYyl22v+AV/TATxlTx/9vaMa3Dxih2Q8q8TlXdUIbMwHq48uvautQYxMxamsnWf542c
         sebJgn6FoSXtdNkuttrag4VwsJ7fW/pUfOX76j5EjCfP8K0t6qoHr63Ug2j0ZUPpp0Hr
         +K1g==
X-Gm-Message-State: ACrzQf1nLeEDwfkyoiCuRZl/3q4qH9S2CKCkv7gVsWEFNf11kw0H1UBL
	UtQoFnRNzhWXqU4GF2tUwasPuA==
X-Google-Smtp-Source: AMsMyM5D2EICh2JE91+aDvxWc6mBwjjHQuWq2+0QafbSqJU3b4BRMSKagNhRlqnN+mXAfVcHcXLJaA==
X-Received: by 2002:ac8:7457:0:b0:3a5:4193:e722 with SMTP id h23-20020ac87457000000b003a54193e722mr13997029qtr.415.1667569637708;
        Fri, 04 Nov 2022 06:47:17 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:aad6:acd8:4ed9:299b? ([2601:586:5000:570:aad6:acd8:4ed9:299b])
        by smtp.gmail.com with ESMTPSA id bp9-20020a05620a458900b006f7ee901674sm2986683qkb.2.2022.11.04.06.47.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 06:47:17 -0700 (PDT)
Message-ID: <39aac9a0-a2cb-af98-8274-93ff0a7da095@linaro.org>
Date: Fri, 4 Nov 2022 09:47:15 -0400
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 4/6] iommu/exynos: Implement shutdown driver method
Content-Language: en-US
To: Sam Protsenko <semen.protsenko@linaro.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>,
 Janghyuck Kim <janghyuck.kim@samsung.com>,
 Cho KyongHo <pullip.cho@samsung.com>, Daniel Mentz <danielmentz@google.com>,
 David Virag <virag.david003@gmail.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org
References: <20221103195154.21495-1-semen.protsenko@linaro.org>
 <20221103195154.21495-5-semen.protsenko@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221103195154.21495-5-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/11/2022 15:51, Sam Protsenko wrote:
> While remove method shouldn't be implemented, as it can't be done
> reliably, the shutdown method can be useful for performing a kexec.
> That was inspired by other IOMMU drivers, see commit 1a4e90f25b2c
> ("iommu/rockchip: Perform a reset on shutdown") for example.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

