Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CBF3C0A
	for <iommu@lists.linux.dev>; Tue, 25 Apr 2023 16:53:12 +0000 (UTC)
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-38bed577755so2237925b6e.0
        for <iommu@lists.linux.dev>; Tue, 25 Apr 2023 09:53:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682441592; x=1685033592;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xsSaFPoEnp1cGsorTT7ZaH8aG8h2ymJ3AbL8g9oAX2c=;
        b=YmUJn0TAfNcVgtMGoIMKHabZJDPTH9muu4O4UhcUdNMxomfxUwWEUpubs0BAqB4PLJ
         QZ9blAfYZmgLnMnz8C+FFJ5InSGdguP0I3aB4V+PjtHFvsQgRtvtG7w9EbB7jM39BvY2
         7KpRBpRX6SPH9pVdd7UonBRB+gYW4E7Fd2pxNFPpWS+vXeKfq7HFV7P9SM/OyolJgQHG
         sPdJC6Avn6comKXOl2Jza744GRM4i9F/LLKZCsHTqg+5HwpXyGzfHWK8GWS7Iw1t/JHk
         CtCQ5HE2nBG6ESiafPRxXV1dtCIA8kCnFn+H/Q5/NBC6ADSmAsaS4TbskRuSTEaOiTTL
         5zRw==
X-Gm-Message-State: AAQBX9ez+I1gWh3ml3bZL0dxVZQs7vOqDjNfSvwIzDdahu+AxmnJaOi/
	rOaUcLKTCN4OZ3j4tkgREw==
X-Google-Smtp-Source: AKy350bfrDTwQxvMUyap3y3hJHSKG/gULg481X3pOZQCJmRNZ5VYkfUL4Idx8sx5O25r4MyufQ1RvQ==
X-Received: by 2002:a05:6808:1392:b0:387:14b7:f8e7 with SMTP id c18-20020a056808139200b0038714b7f8e7mr10106662oiw.38.1682441591645;
        Tue, 25 Apr 2023 09:53:11 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z9-20020a056808048900b0038dd5bf922bsm5772958oid.22.2023.04.25.09.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 09:53:11 -0700 (PDT)
Received: (nullmailer pid 1931342 invoked by uid 1000);
	Tue, 25 Apr 2023 16:53:10 -0000
Date: Tue, 25 Apr 2023 11:53:10 -0500
From: Rob Herring <robh@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Krishna Manikandan <quic_mkrishn@quicinc.com>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Marijn Suijten <marijn.suijten@somainline.org>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
Subject: Re: [PATCH v2 03/13] dt-bindings: display/msm: Add SM6350 DPU
Message-ID: <20230425165310.GA1928942-robh@kernel.org>
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

Drop 'Address offset and size for '

With that,

Reviewed-by: Rob Herring <robh@kernel.org>
