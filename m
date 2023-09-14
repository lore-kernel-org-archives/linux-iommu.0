Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6D92511F
	for <iommu@lists.linux.dev>; Thu, 14 Sep 2023 06:12:00 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40037db2fe7so5843795e9.0
        for <iommu@lists.linux.dev>; Wed, 13 Sep 2023 23:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694671919; x=1695276719; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2a/PHWqxsvCjYvw/PrGstkPwApGUDTH1LI40pfCDPVU=;
        b=rokP6pzL7iZEab7NN9eGZJQY0PGUxX2YeGjf53vCM/gvK/mW8BAYKaoqQ10WDopDrw
         TAmwjlVGgytoVPXJBLQ9MvM2lPuOvBCXz47XnBl/KtIzwIyvAyPBjqT4bcsUxCReFApY
         wA8CspJH16yvkrBiVm6k42dXuB1axq0QEPxaiwC2ygwyva4oAeTSrG+yCskN+Xur+94w
         vDJhFRY9ehYpNHa310LHgD+z5lj12Pcgrf1UP4FmmsEbp22pbFGQ2rfR8fVyKfTGFnXy
         aVnSA4VnV3ZVFxMuK3oW3L71P6bUVcAKPkpsyYZgw1w7Y7gBKKTo4P61svmLJfUHd4ob
         jsJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694671919; x=1695276719;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2a/PHWqxsvCjYvw/PrGstkPwApGUDTH1LI40pfCDPVU=;
        b=d6wG96/H2ZWHgtMbPindXxEilpYLT2yfPKaTQ8kI/Vki1RmGXP5LqsQWN7iVQjnisF
         7633ZXarEM+tGJtCnnZnWpk39L7MHHXCRWRMbAF9tNnTs0fqAlNMIX5JcDw1YBwJlYVv
         CdY2vKZaWuvEyceTWnBXq+1MHRWDDNFDyGw0Nm28Mc9bi6K23hG2ts/pbMZA/24DaybD
         RxiEHoRJvzeEvW1CwuMy6BnmzU7CGil+CJVMZzeYHyxDHySUNXe6oxfWxThBWk1HSPDj
         fl/YEzE2/ZXKTdcBUL4pd+YOoRNGC0VatvCAByiq2wf/fO4FUVlY9BUymM7ukIGuO1Tm
         0OtA==
X-Gm-Message-State: AOJu0Yym1LmuD43QtiW5hnmPmU/1fIjAfUFEYqZPzYf9HKVZO+llFQPW
	qmoeHq7tNuz3ldLdjmnSx8aV2Q==
X-Google-Smtp-Source: AGHT+IGw6rLBiZ/VZp782H6iiBB72aJIj5bR1ullvx8HbEIzsNDjz5tNRHSmEU1mgTSDc50+cIZokQ==
X-Received: by 2002:a05:600c:204c:b0:401:db82:3edf with SMTP id p12-20020a05600c204c00b00401db823edfmr3487074wmg.39.1694671918950;
        Wed, 13 Sep 2023 23:11:58 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id c20-20020a7bc854000000b003fee6f027c7sm3840112wml.19.2023.09.13.23.11.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 23:11:58 -0700 (PDT)
Message-ID: <f4dc58b3-b721-3081-6fed-66976b694217@linaro.org>
Date: Thu, 14 Sep 2023 08:11:56 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 1/2] dt-bindings: arm-smmu: Add SM7150 GPU SMMUv2
Content-Language: en-US
To: Danila Tikhonov <danila@jiaxyga.com>, will@kernel.org,
 robin.murphy@arm.com, joro@8bytes.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 dmitry.baryshkov@linaro.org, konrad.dybcio@linaro.org,
 quic_saipraka@quicinc.com, quic_bjorande@quicinc.com, a39.skl@gmail.com,
 robdclark@chromium.org, mani@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230913184526.20016-1-danila@jiaxyga.com>
 <20230913184526.20016-2-danila@jiaxyga.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230913184526.20016-2-danila@jiaxyga.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/09/2023 20:45, Danila Tikhonov wrote:
> SM7150 has a qcom,smmu-v2-style SMMU just for Adreno and friends.
> Document it.
> 
> Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

