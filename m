Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003CA883C
	for <iommu@lists.linux.dev>; Sun,  4 Jun 2023 18:04:59 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5151934a4e3so5960350a12.1
        for <iommu@lists.linux.dev>; Sun, 04 Jun 2023 11:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685901898; x=1688493898;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ihBL6TJ8C6mU92dx3ETVIyIXq8wWv0W19OQrtjTVS6E=;
        b=FI30/lnyqGkqjoM7lJFPYMooptVi/7DeeM1KS/E0KPhdJXv8U4Eow239gWj/7KQwc+
         /V02myVs6yai/PTWZ4tQHmE+oXtxhX/cb4AVwYcQC4+6KvkTKclOH4chqPK78JOhhSjk
         O1bW0TsyxsAPdLAaE0FwspvFT84WXU2OEHSZkWrNXa4DolOdbGqinLMfbpGTLuNJgIk4
         8Q+iGmfaMAuoLpO76CTFxPzJGtJ4VTmDGFIw5uVp9e41q0z56jjWnQNBf2Te8K/OKO+n
         hzjArDemAds0fl9w5QcqedUGh6NfUTl90unSsFR4mMr+Axl1lcDhJBrIXd3HWWrI7Vvj
         yqRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685901898; x=1688493898;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ihBL6TJ8C6mU92dx3ETVIyIXq8wWv0W19OQrtjTVS6E=;
        b=GGBhhxhX8JQTmikDbrX3Ni8PpukbTpvoRTYJVJuCKiHwH9+UzMktfzfhYSea8CB9tz
         j2LB3kwD854cbOsRavFXiCm3LMjkbTfyf32S3QNuuu4JCR2KMO3b3anjCz2C8EPR6byI
         4fSq5Odt/gB+82PTaYM4Fw0fWWfb5LfRyQgeWcgcdQdi/UuNVVU/O3LQeS3IXDh6RqtN
         DJH8rkcmdqzXw8jNTMep/lR65P4ifnDFGiWD5/fFTV7aliKccM4F4opNQN/4V/cmne/8
         mJzewk4pj7N9uXrn3CA8tNUsfTyYsOn58jjwntz+M+6YzIzGG33ZG74RDwIUzU6YGLbb
         FjOQ==
X-Gm-Message-State: AC+VfDxey4sKkDWAUtzu54oEKWj5Flr4CFUOQmBxXmXwhas9cLjcMgyA
	YJZSGr9BlJKpk+UFLdp0bZycxg==
X-Google-Smtp-Source: ACHHUZ4+vFM/nr8fGvYX+DNeO5lxMdAF0enwX9IrUSUB6khhTQ6PAinPxZOCuZMqppzelTPW9qs6IQ==
X-Received: by 2002:a17:907:9444:b0:974:391f:ed7d with SMTP id dl4-20020a170907944400b00974391fed7dmr4950469ejc.49.1685901898018;
        Sun, 04 Jun 2023 11:04:58 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id c8-20020a170906924800b00977cc473b41sm1356087ejx.142.2023.06.04.11.04.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jun 2023 11:04:57 -0700 (PDT)
Message-ID: <3fe03b31-0cab-82cf-cbdb-766fdf34c44d@linaro.org>
Date: Sun, 4 Jun 2023 20:04:52 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v5 04/12] dt-bindings: display/msm: Add SM6350 MDSS
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Clark
 <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>, Will Deacon
 <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev
References: <20230411-topic-straitlagoon_mdss-v5-0-998b4d2f7dd1@linaro.org>
 <20230411-topic-straitlagoon_mdss-v5-4-998b4d2f7dd1@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230411-topic-straitlagoon_mdss-v5-4-998b4d2f7dd1@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/05/2023 09:46, Konrad Dybcio wrote:
> Document the SM6350 MDSS.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  .../bindings/display/msm/qcom,sm6350-mdss.yaml     | 214 +++++++++++++++++++++
>  1 file changed, 214 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm6350-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm6350-mdss.yaml
> new file mode 100644
> index 000000000000..6674040d2172
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/msm/qcom,sm6350-mdss.yaml
> @@ -0,0 +1,214 @@
> +# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/msm/qcom,sm6350-mdss.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm SM6350 Display MDSS
> +
> +maintainers:
> +  - Krishna Manikandan <quic_mkrishn@quicinc.com>
> +
> +description:
> +  SM6350 MSM Mobile Display Subsystem (MDSS), which encapsulates sub-blocks
> +  like DPU display controller, DSI and DP interfaces etc.
> +
> +$ref: /schemas/display/msm/mdss-common.yaml#
> +
> +properties:
> +  compatible:
> +    items:

Drop items. It's just const.


> +      - const: qcom,sm6350-mdss
> +
> +  clocks:
> +    items:
> +      - description: Display AHB clock from gcc
> +      - description: Display AXI clock from gcc
> +      - description: Display core clock
> +
> +  clock-names:
> +    items:
> +      - const: iface
> +      - const: bus
> +      - const: core
> +
> +  iommus:
> +    maxItems: 1
> +
> +  interconnects:
> +    maxItems: 2
> +
> +  interconnect-names:
> +    maxItems: 2

Are you sure you have two interconnects? Example is missing them.



Best regards,
Krzysztof

