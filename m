Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23FF7EF
	for <iommu@lists.linux.dev>; Mon, 27 Feb 2023 08:13:48 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id m14-20020a7bce0e000000b003e00c739ce4so3257446wmc.5
        for <iommu@lists.linux.dev>; Mon, 27 Feb 2023 00:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kkVbUWuqip1JKVeXjBIarnPygYYkbu4JQXFrp3pg4Ck=;
        b=dnUzXxbFZ8n6GJ635hbd32kwPg2fY/rR0vl9WgnJrKg8uMy+x7PTaszAkj9M2moObV
         P0vWpOCzhdjh3Vedh/MXSVWzsZII8MxnIRWNu5GuLpWDAfex5i6ZfBil3QZ8iFQRhd2n
         HEYiuxukTvDiLfeQi/eukJ3rBXLkDJQvY6UArTK/uZFKFkyk7Up3cC7RXQfcLqHGgOrY
         7sCuisjfqj1GnOGuGioOFjyFY9pxqgsxc9z9W95vd0pW+jImuXAw7zWdKzea6gnv6FTD
         rXtqyTfEo4ladzd3bFMhHw2gXTLq/QyJfxrmxuKxtsYc7FkxhHwAbdQubua34JH86D2P
         Ds8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kkVbUWuqip1JKVeXjBIarnPygYYkbu4JQXFrp3pg4Ck=;
        b=AJb8/U88RfxUcbEiJxa0yFt4ERzQlBC1O7LXFNlornrr68A/MTKABhmGTlUz3uha+1
         XIdecaxAbiDaR+kacWts8+PpEMFJg9ir9aTyeWO3veNE/8K2FOO2gOgWnR8DzrMj5y0W
         PxyNm5StrII5cZo/KCG7X+nsuu+VTYAxGIXnLzO0y/ymnsv1lKNAtJshMvQugY75dwsk
         7tXpuGas6eI+4LRBQkj2STK2dU15nM4K5m2xgNHMVcihTxtR2OON0I1IqT7hoiwMYLuw
         4RBqUxkNacZRudrrzwTdif+NYscvuLmkKPokSKn5YMtIBxpWhxnh/Bxo5crCrbW2wZR0
         h/Iw==
X-Gm-Message-State: AO0yUKWidyYty9fTgZ3DCsT65BNlAFmvYPI+1hVI/SVKYD2JF5ybIh5c
	23ChOCtb6LXiI7IVIOI17VhK+g==
X-Google-Smtp-Source: AK7set9GOz42ORl/l51MyaUDHOxw+vpO8tpY7GwqfIjGKaGWmWQoXDU9XzKvRbWYOFG7trq0PocKlw==
X-Received: by 2002:a05:600c:3b8b:b0:3ea:ea6b:f9ad with SMTP id n11-20020a05600c3b8b00b003eaea6bf9admr11191889wms.31.1677485627060;
        Mon, 27 Feb 2023 00:13:47 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id m15-20020a5d6a0f000000b002c707785da4sm6283227wru.107.2023.02.27.00.13.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 00:13:46 -0800 (PST)
Message-ID: <6edcd92c-876d-0610-037d-51a1b5c1f662@linaro.org>
Date: Mon, 27 Feb 2023 09:13:44 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 2/6] dt-bindings: arm-smmu: Add SM8350 Adreno SMMU
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>, linux-arm-msm@vger.kernel.org,
 andersson@kernel.org, agross@kernel.org
Cc: marijn.suijten@somainline.org, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230217111613.306978-1-konrad.dybcio@linaro.org>
 <20230217111613.306978-2-konrad.dybcio@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230217111613.306978-2-konrad.dybcio@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/02/2023 12:16, Konrad Dybcio wrote:
> Document the Adreno SMMU present on SM8350.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
> v1 -> v2:
> - Drop Krzysztof's ack, as the patch was out of context..

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

