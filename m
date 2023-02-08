Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3089D2105
	for <iommu@lists.linux.dev>; Wed,  8 Feb 2023 09:14:28 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id h3so8192425wrp.10
        for <iommu@lists.linux.dev>; Wed, 08 Feb 2023 01:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LyYzirLtdl5bQvkAtHWV4AUpLzLISEB7q8alQocWH0M=;
        b=Age1qi/MrnoOSTVBuTseOWxpqJ4SJ1AEIXVNba85paHhHXxng8wBAS+9c9Do9HIail
         JfZ3vBZxSt2Ta2by6pbHVJM1TcclWhvjVPRK2MmSn9OPc44PLExVTKEtZ/n05D2Ro5oA
         mGczTfMN06lyP2Xc8/h/Dh/Ktl9KXjuivUSKwZNnQq2FEpuihvKw2dFpLsJlslpyYf7j
         Ca6HmNu3oyMHKH+MLEhMWa2bZayMdDrJY0KfIVyTTAU3hAQHuH8yBoMk/j0uhXgH8vX6
         VEwVe6lf7OB9i8EX7UuVUIJNAzwkrKdLgwv+0IdsSb2FqbuSkbFW9pkqepwXKsjnrVBc
         bqcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LyYzirLtdl5bQvkAtHWV4AUpLzLISEB7q8alQocWH0M=;
        b=XK5aznkgs95pGBAKlmRg2mAgDcb1nLZyXHuB0KQuJ3eBuVcadaSiD5sLOpemO34HMA
         /cJJgqOBzsDiWkdK3LSraVCiXssqNskWUlW7qkooObNc3xH6eFU6E+RPUt1wDqbQIWEi
         aVymvakzhVFpZ7eHuCUC8VMjSXGmi9O7rEx4FWkEvT46NWRC/KX7qKbSCeTykZXE3WDI
         FKMs/NEDA/cEYHSbw+gBVlvyClaFQeh4nz3PZZRlJjKxq8gBaYlckoqyJSxn4INJTjoL
         v5/DwOlKrOsRewpiYojeIxlxtmOp/ihlR3Sgl/KUS6tCV33TbmcFx5hMxzrfJQ34Auyo
         rBSQ==
X-Gm-Message-State: AO0yUKWqr1oR9APQ4nRtnrovtoqHEceFUtn6ZE8K67xzMU1JowaYNKg8
	VP2RkoUGrAxy+7ejh5pu1/4vLTLw7fpY3Ild
X-Google-Smtp-Source: AK7set9X1dUmFONyLvjJaMqkHhahmv6ypd+loT6WfcjkNNvaYBE9AxbkLLkTHvrJifRelZnxVSnQvQ==
X-Received: by 2002:adf:fa10:0:b0:2bf:ad43:8f08 with SMTP id m16-20020adffa10000000b002bfad438f08mr6151651wrr.14.1675847666563;
        Wed, 08 Feb 2023 01:14:26 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id p4-20020a5d68c4000000b002c3e4f2ffdbsm8219442wrw.58.2023.02.08.01.14.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Feb 2023 01:14:26 -0800 (PST)
Message-ID: <70311755-d599-39aa-192e-5957e736eadd@linaro.org>
Date: Wed, 8 Feb 2023 10:14:24 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3] dt-bindings: arm-smmu: Add compatible for SM8550 SoC
Content-Language: en-US
To: neil.armstrong@linaro.org, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 iommu@lists.linux.dev, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
References: <20230207-topic-sm8550-upstream-smmu-bindings-v3-1-cb15a7123cfe@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230207-topic-sm8550-upstream-smmu-bindings-v3-1-cb15a7123cfe@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/02/2023 10:13, neil.armstrong@linaro.org wrote:
> From: Abel Vesa <abel.vesa@linaro.org>
> 
> Add the SoC specific compatible for SM8550 implementing
> arm,mmu-500.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

