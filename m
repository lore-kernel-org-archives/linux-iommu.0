Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A1D3C0A
	for <iommu@lists.linux.dev>; Tue, 25 Apr 2023 17:03:22 +0000 (UTC)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-18665c1776dso4474251fac.2
        for <iommu@lists.linux.dev>; Tue, 25 Apr 2023 10:03:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682442202; x=1685034202;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ZDfXI7hMbqGi7E82l8vWt9jneZ/T4Uui2TLcBQz+KM=;
        b=L5O5oJwt+SpxJ404w0ra1JOPuWLFAOeGYyW1rgLwgA4olPwG636jBqCfptiW+i4KI+
         xro5WTk6tBUoH25MVq9kp1VwNaQ8PAKwr4xT+ZKa4p1a5VDiyzNk6VnHY3557oeGxTqb
         1CAZbRgTc2SOaTR2FrshanGRZLSVqII7WTEhQXVCCu/Qa5HmNUAiyrKOZ2gB1BKBGmi8
         J58nvVjt6jXHPkHxAZO5YkbEvLxhhtJHx0rqfVe5gIPa/PVzgOS7jRy3QMnzJuoCl0CE
         GT9J/OXuHSfExBzqeREJz54pJeeqFDmeGjXo+Ebv2D4fB3B4t1jJmYAcPtfS8mwacvHQ
         dMOg==
X-Gm-Message-State: AAQBX9falDxCwE8AO0Jkk/mbfboF4Zj8ruXen6y339+X+Ng8lqW6vJ2C
	NMvLhL6KZhzGPHYC22uWfw==
X-Google-Smtp-Source: AKy350Yul7/EEVvrMD/ABdCsLr9ode6pBn2tmtKnE0Rjjz8gJcwSoneSAZlS17HOt1THyFiTOOIaeQ==
X-Received: by 2002:a05:6870:63a4:b0:17e:6eaa:945f with SMTP id t36-20020a05687063a400b0017e6eaa945fmr12199364oap.8.1682442201994;
        Tue, 25 Apr 2023 10:03:21 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id b1-20020a056870b24100b0018045663fc5sm5678632oam.48.2023.04.25.10.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 10:03:21 -0700 (PDT)
Received: (nullmailer pid 1948453 invoked by uid 1000);
	Tue, 25 Apr 2023 17:03:20 -0000
Date: Tue, 25 Apr 2023 12:03:20 -0500
From: Rob Herring <robh@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Krishna Manikandan <quic_mkrishn@quicinc.com>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Marijn Suijten <marijn.suijten@somainline.org>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
Subject: Re: [PATCH v2 03/13] dt-bindings: display/msm: Add SM6350 DPU
Message-ID: <20230425170320.GA1931576-robh@kernel.org>
References: <20230411-topic-straitlagoon_mdss-v2-0-5def73f50980@linaro.org>
 <20230411-topic-straitlagoon_mdss-v2-3-5def73f50980@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411-topic-straitlagoon_mdss-v2-3-5def73f50980@linaro.org>

On Fri, Apr 21, 2023 at 12:31:12AM +0200, Konrad Dybcio wrote:
> Document the SM6350 DPU.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  .../bindings/display/msm/qcom,sm6350-dpu.yaml      | 94 ++++++++++++++++++++++
>  1 file changed, 94 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm6350-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm6350-dpu.yaml
> new file mode 100644
> index 000000000000..979fcf81afc9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/msm/qcom,sm6350-dpu.yaml
> @@ -0,0 +1,94 @@
> +# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/msm/qcom,sm6350-dpu.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Display DPU dt properties for SM6350 target
> +
> +maintainers:
> +  - Konrad Dybcio <konrad.dybcio@linaro.org>
> +
> +$ref: /schemas/display/msm/dpu-common.yaml#
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: qcom,sm6350-dpu
> +
> +  reg:
> +    items:
> +      - description: Address offset and size for mdp register set
> +      - description: Address offset and size for vbif register set
> +
> +  reg-names:
> +    items:
> +      - const: mdp
> +      - const: vbif
> +
> +  clocks:
> +    items:
> +      - description: Display axi clock
> +      - description: Display ahb clock
> +      - description: Display rot clock
> +      - description: Display lut clock
> +      - description: Display core clock
> +      - description: Display vsync clock
> +
> +  clock-names:
> +    items:
> +      - const: bus
> +      - const: iface
> +      - const: rot
> +      - const: lut
> +      - const: core
> +      - const: vsync

Is there some reason the clocks are in different order? They appear to 
be the same minus the 'throttle' clock. Is there really no 'throttle' 
clock? Maybe this platform just tied it to one of the same clocks in the 
above?

I really hate the mess that is clocks. We have the same or related 
blocks with just totally different names and order. The result is 
if/then schemas or separate schemas like this. Neither option is great, 
but at least the if/then schemas provides some motivation to not have 
pointless variations like this. </rant>

As it seems the only difference between these 2 bindings is 1 extra 
clock, can't they be shared?

Rob
