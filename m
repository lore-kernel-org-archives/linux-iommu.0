Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF586624
	for <iommu@lists.linux.dev>; Sat, 20 May 2023 01:33:09 +0000 (UTC)
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2af2c35fb85so3525401fa.3
        for <iommu@lists.linux.dev>; Fri, 19 May 2023 18:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684546388; x=1687138388;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9m6FYEdyuS34WJpEKNGhiGJw26BbhauPjEFJhVqIy84=;
        b=J2WAtndni5pg8zI01jaEewzpdR8rCPsAoHbZekp+7M7wC2x3R9lV418//z863DW65n
         2lUc3KDyHqYLd/BYBzCb+uiqjLN/9CLt1T1xBY4W326Xz1VlLg27DhrsdUr4KSEGc4e7
         rwLGneMzBtX9uDKXQ2tiw+kMkyTrE3mKeqUvyAOECJqTiUVwCraa9sePU3K9gItlfFUz
         1fccnmpHkpoYH6BPpwxCn/QluiL5NGN+jeyHtyD9ahQjzJaKQvimoTnyv59pD0rWMtt5
         FbuBOuOjbn7d8xA3FKXll6cU3ijggLoMHkMRp8NIQ9Qd7KxbWm3ySAdYBfXjJ8Duwq71
         h4Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684546388; x=1687138388;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9m6FYEdyuS34WJpEKNGhiGJw26BbhauPjEFJhVqIy84=;
        b=S3R6/UmYc9WW3OIidK8zANdzdKptdSL67I6RM03hMcy3M8VChfMI/tGiLXXTPPHKYM
         7ApvfVTEsG/4D7IEc784XO2kY2XyoZCBL0UE27AMUioevLfjqk+9n6FeMOrFHhlZHc2q
         8a1hQTyctzKsAjVm06rrEZaMWt/EcwHItbkoh2iuQMB8pKhh6ReJ1vNGt5aW2t7QY+yC
         AWG/dI2I+SEzs04XuDO+C+xU0ye/YX7UbdAqwUmZYfCq75CV/E5KpvCmSvlyspKf3v8t
         rpgeMzGYN+LYWkc5bB1Lt+GiLZQEI+c/WOuhl2+Dj7wy1B+5PEi1Z00bX2wP2zCrGfa3
         vE3Q==
X-Gm-Message-State: AC+VfDyoNs/uRBoYyXmrJqEKuqPYY3wwKCvCx5C59tyQDQt6PZT5sWuv
	+EWfQX+awBuDMprrv8e8Za3g4Q==
X-Google-Smtp-Source: ACHHUZ7hSJky8D3B+kEQc4AR9VaHMZsAgYX95I/Fi+l7dRlfuSrwNICffM982tuTFljAsF+j/ezRAA==
X-Received: by 2002:a2e:880a:0:b0:2af:20c9:3f8a with SMTP id x10-20020a2e880a000000b002af20c93f8amr1515995ljh.7.1684546387794;
        Fri, 19 May 2023 18:33:07 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id k7-20020ac24567000000b004efe9a169d2sm92819lfm.64.2023.05.19.18.33.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 18:33:07 -0700 (PDT)
Message-ID: <02e1886f-801e-6100-f977-be407697df29@linaro.org>
Date: Sat, 20 May 2023 04:33:06 +0300
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 08/12] drm/msm/dpu: Add SM6375 support
Content-Language: en-GB
To: Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Clark
 <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>, Will Deacon
 <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev
References: <20230411-topic-straitlagoon_mdss-v4-0-68e7e25d70e1@linaro.org>
 <20230411-topic-straitlagoon_mdss-v4-8-68e7e25d70e1@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230411-topic-straitlagoon_mdss-v4-8-68e7e25d70e1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/05/2023 20:04, Konrad Dybcio wrote:
> Add basic SM6375 support to the DPU1 driver to enable display output.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_6_9_sm6375.h | 153 +++++++++++++++++++++
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c     |   1 +
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h     |   1 +
>   drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            |   1 +
>   4 files changed, 156 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

