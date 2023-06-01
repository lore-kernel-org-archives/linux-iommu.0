Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CC880F
	for <iommu@lists.linux.dev>; Thu,  1 Jun 2023 00:16:55 +0000 (UTC)
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-4f122ff663eso128349e87.2
        for <iommu@lists.linux.dev>; Wed, 31 May 2023 17:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685578613; x=1688170613;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sxTX4X4YKUtqwPm+hbV1ZZouN5cpgVgg+LAtjb8cK/I=;
        b=i9rKVnU4m6dI91mhR4zJ7ZW0TQwWjSH3HQMaugd8Y1bpUQYDRiw8b1AKA1sRS0A2FR
         6ZlvU5hW6bsSlbITaHTAI4Ekc9LVT3bVmo6OG4/+itIrrEmHfi9hDdtcfJ6z5aza7qqo
         y42Dn/E/BTVRqI35zv1N2oRcF/9JKrRh+TzhMp79w/spWSvGmmGQw8QuqikBPv8ZWAa+
         iaByBCuzR95pTcAmIWvopqsuDc9/GyQg82VQQeOlm1ciEFrimZht9pExjh9PccrerdFr
         VkpsNgXLe8doQ1rNuozfbkhclKq/tTkgrJA+mq5pjmMGQ/hA2cz/b1dEBGMcqRt4htI6
         eFtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685578613; x=1688170613;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sxTX4X4YKUtqwPm+hbV1ZZouN5cpgVgg+LAtjb8cK/I=;
        b=HPvWdIOf+5m5zZcK+aKPAYk0akuW8bckdsnbF6lE/HsH4GMsr1+6ZSclYsruYKYvWe
         1pN/XmO5VgekzJLcYfKgGOAUqlDmvi8d1N6X4Cz7y4Q2/RaTM/eKCCDUCQtNBU406N19
         P1YpSLXKx9tTc1nC6T13lbpgKZMKXLvuD+XyIaOL1EN/93B/TVNEaeveUcYt8gsBPZ6r
         6FCv9wCX8BkLJ5jDehFn99SIQduljlu9Kpc/kwGk1p+V6WFHYciaSTK5bpbG1cDmRCC9
         M2EDl8jRa5it+omSwwrKJ6tz394eXhBtHA7XvlFaEFpG+63jdje4+7cK/x2Ofy4Jmdzb
         JpJQ==
X-Gm-Message-State: AC+VfDx19P60680LViFJ3+hpoxTVzMvpsFxwt4vLmka8TV/xvfYQrqa/
	X9HVfEdCA8XulahH+w0pS/F6iQ==
X-Google-Smtp-Source: ACHHUZ5Q3u+SzRMFGtrtDBvEpZJ6S83Uw7/xbtquC1ZjKTF0POh8B99t3GmLNjPbhZJsD3vRnrpdEw==
X-Received: by 2002:ac2:4466:0:b0:4f1:43de:7c3 with SMTP id y6-20020ac24466000000b004f143de07c3mr267149lfl.51.1685578613308;
        Wed, 31 May 2023 17:16:53 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id c10-20020ac2530a000000b004f139712835sm889366lfh.293.2023.05.31.17.16.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 17:16:52 -0700 (PDT)
Message-ID: <0fbe5ddb-c3de-0724-fb69-a99e4980b26c@linaro.org>
Date: Thu, 1 Jun 2023 03:16:52 +0300
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 00/12] SM63(50|75) DPU support
Content-Language: en-GB
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, Rob Herring <robh@kernel.org>,
 Konrad Dybcio <konrad.dybcio@somainline.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Clark <robdclark@gmail.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>
References: <20230411-topic-straitlagoon_mdss-v5-0-998b4d2f7dd1@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230411-topic-straitlagoon_mdss-v5-0-998b4d2f7dd1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/05/2023 10:46, Konrad Dybcio wrote:

[skipped the changelog]

> ---
> Konrad Dybcio (12):
>        dt-bindings: display/msm: dsi-controller-main: Add SM6350
>        dt-bindings: display/msm: dsi-controller-main: Add SM6375
>        dt-bindings: display/msm: sc7180-dpu: Describe SM6350 and SM6375
>        dt-bindings: display/msm: Add SM6350 MDSS
>        dt-bindings: display/msm: Add SM6375 MDSS
>        drm/msm/dpu: Add SM6350 support
>        drm/msm: mdss: Add SM6350 support
>        drm/msm/dpu: Add SM6375 support
>        drm/msm: mdss: Add SM6375 support
>        iommu/arm-smmu-qcom: Sort the compatible list alphabetically
>        iommu/arm-smmu-qcom: Add SM6375 DPU compatible
>        iommu/arm-smmu-qcom: Add SM6350 DPU compatible

As we are now nearly ready to merge this series, Will, Robin, what 
should be the merge strategy for these three patches? Would you take 
them through the arm-smmu/iommu tree?

> 
>   .../bindings/display/msm/dsi-controller-main.yaml  |   4 +
>   .../bindings/display/msm/qcom,sc7180-dpu.yaml      |  23 ++-
>   .../bindings/display/msm/qcom,sm6350-mdss.yaml     | 214 ++++++++++++++++++++
>   .../bindings/display/msm/qcom,sm6375-mdss.yaml     | 216 +++++++++++++++++++++
>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_6_4_sm6350.h | 173 +++++++++++++++++
>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_6_9_sm6375.h | 139 +++++++++++++
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c     |   6 +
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h     |   2 +
>   drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            |   2 +
>   drivers/gpu/drm/msm/msm_mdss.c                     |  10 +
>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c         |   6 +-
>   11 files changed, 792 insertions(+), 3 deletions(-)
> ---
> base-commit: 9f925874281f7e8855855d6210d6e29d844e4307
> change-id: 20230411-topic-straitlagoon_mdss-8f34cacd5e26
> 
> Best regards,

-- 
With best wishes
Dmitry

