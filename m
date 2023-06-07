Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D0C3B3E0
	for <iommu@lists.linux.dev>; Wed,  7 Jun 2023 23:39:09 +0000 (UTC)
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2b1b92845e1so59430311fa.0
        for <iommu@lists.linux.dev>; Wed, 07 Jun 2023 16:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686181148; x=1688773148;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XONB9T8Mj7o/MLrEwoJSSBYj969JG7tPSlspH2W5BIw=;
        b=GTSY7qEdobWh7LkTRnOAImvPKZUJQfgOgETcJ+tk6DI5sF/chuwr6uFDqqlVN23O2W
         //yo7tNg480hQs0zkZINMpSZx3sk/T3RykwcV+TsgCqjcm6lxUr7OIiZgxIFpwSR5GDM
         4G0wg5Ie0zBjwOhgMcBHNt5pPR8zWZkXbyFtqUc4AfJayZmsCu3RwDeCa8spwMuwj3kd
         l7IFXSZtuqtnQi6PcQ7vFnWwXhpYhZaVzrLSjtc6apATcNyaMuyKL3dvg8eSImkt7HNR
         s3HuH1jxWmY/bYrPhnN5PoHhxg9HXsMayW/9mjwSHTu08V8Fjpsb3fvDLgVQ95kyqjtA
         HJ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686181148; x=1688773148;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XONB9T8Mj7o/MLrEwoJSSBYj969JG7tPSlspH2W5BIw=;
        b=BGH8nY2xElpWaqAAnALVwBXKTewHdruc8kd1hpT6i58MTK65sQAk4xg7jmUc4un3v4
         NKTLv7dUHmmh3xH3FiERpxKYZD4IqboDnEF3zR4ueBbOKe5v8HmLJlxTju6PSj5xhLCB
         UPQaR0ShpTJDy7d/1cq9cJmjve6DcZBFlNZD2QSl19Wvx1ZWqTgKoO3Ai7zGeQHBo9m7
         IYwSMd1vIRloxEHRnBeTMwWDlbHcH8Smht+eATJH+diZUI1Xn/E4HMtGKJslresoa8ll
         Oo6a0JN7WPrAm/CwcSTGotv/v+em9I4M9pgGxauNdnT28i5QMOvHk22ISU69th7qBpz9
         fiSw==
X-Gm-Message-State: AC+VfDy/RAM7qomWPGLy/HXt6Vy0/3wuP4nEKZ6u6UnYC7KUOL0n3l9D
	Ux+QgkcLaAA/ADbj1bA71YDh/w==
X-Google-Smtp-Source: ACHHUZ5Ti07xNp1+TYebI62vHoSL/r5taUDlEmn3ZQRy27Ik7N84bpsPjsq4VfKfSjqdaopI0zXg+A==
X-Received: by 2002:a2e:730c:0:b0:2a7:7100:ff5a with SMTP id o12-20020a2e730c000000b002a77100ff5amr2976356ljc.6.1686181147775;
        Wed, 07 Jun 2023 16:39:07 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id o15-20020a2e90cf000000b002b1b92910c8sm346ljg.86.2023.06.07.16.39.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 16:39:07 -0700 (PDT)
Message-ID: <e70b266b-85bb-f23f-dac8-47702a2aaf37@linaro.org>
Date: Thu, 8 Jun 2023 02:39:06 +0300
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v6 00/12] SM63(50|75) DPU support
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
 iommu@lists.linux.dev, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Konrad Dybcio <konrad.dybcio@somainline.org>
References: <20230411-topic-straitlagoon_mdss-v6-0-dee6a882571b@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230411-topic-straitlagoon_mdss-v6-0-dee6a882571b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/06/2023 15:43, Konrad Dybcio wrote:

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

Will, we have finally picked up the display related patches. Could you 
please pick up the IOMMU patches if they look fine to you.

>        iommu/arm-smmu-qcom: Sort the compatible list alphabetically
>        iommu/arm-smmu-qcom: Add SM6375 DPU compatible
>        iommu/arm-smmu-qcom: Add SM6350 DPU compatible
> 
>   .../bindings/display/msm/dsi-controller-main.yaml  |   4 +
>   .../bindings/display/msm/qcom,sc7180-dpu.yaml      |  23 ++-
>   .../bindings/display/msm/qcom,sm6350-mdss.yaml     | 213 ++++++++++++++++++++
>   .../bindings/display/msm/qcom,sm6375-mdss.yaml     | 215 +++++++++++++++++++++
>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_6_4_sm6350.h | 173 +++++++++++++++++
>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_6_9_sm6375.h | 139 +++++++++++++
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c     |   6 +
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h     |   2 +
>   drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            |   2 +
>   drivers/gpu/drm/msm/msm_mdss.c                     |  10 +
>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c         |   6 +-
>   11 files changed, 790 insertions(+), 3 deletions(-)
> ---
> base-commit: 6db29e14f4fb7bce9eb5290288e71b05c2b0d118
> change-id: 20230411-topic-straitlagoon_mdss-8f34cacd5e26
> 
> Best regards,

-- 
With best wishes
Dmitry

