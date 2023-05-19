Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2974812B9A
	for <iommu@lists.linux.dev>; Fri, 19 May 2023 19:05:33 +0000 (UTC)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-19a1ac5e200so2639282fac.1
        for <iommu@lists.linux.dev>; Fri, 19 May 2023 12:05:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684523132; x=1687115132;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=I40vgsxqxEeuLbFdYwBEPCfpX/jxJIkwaPXV/ediegI=;
        b=dVZLloGwZW61P+X8heq1VuOh+CfPLU5RmbbYKc8dabDtwfjighvy8TSlZplIKVQs42
         uPcTwTML0E+oRryNBiiu11n2zmKDpTO4Dy2EflPs0dm9RAFeDJdMT8DNlFi7sx1EI4B9
         PzqqOW2PVtB8wDQIambhSREcZActYstkAHSAeKxFRT4o8B6qqMIEmjn6aZoy2KjH1uVj
         Ubd7Y0/a9oJzO/wjFZG9rUEpBhob9ONUDdJKgkcVtKgh8Nq87+NZAyFauQw5YQbVG0Bc
         2KgjfZApSFKmAQQhcFHmYLW9zMc+NJu8Nfq6O7vHQlzbbTEWBJbAkXf3efJfOi4SSMIV
         r5Qw==
X-Gm-Message-State: AC+VfDzzwGpIGErmHhrq2g7Rp6arUvEnUq3nbQ1zLlmvE/h10aOUATkl
	9RRvxzeW8yZBTpTkz0O7qw==
X-Google-Smtp-Source: ACHHUZ6Z7ctoE0Xg6rjUWDn3rqomNMMmXJEoVf2UiTHn5Uezqyl7vhRSGEzk/DBjyr6PSMIrc1TYBg==
X-Received: by 2002:a05:6870:36c1:b0:187:85c1:8075 with SMTP id u1-20020a05687036c100b0018785c18075mr1541235oak.15.1684523132174;
        Fri, 19 May 2023 12:05:32 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v1-20020a056870e28100b0018456166c7asm2259270oad.39.2023.05.19.12.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 12:05:31 -0700 (PDT)
Received: (nullmailer pid 3852246 invoked by uid 1000);
	Fri, 19 May 2023 19:05:30 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, freedreno@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, Sean Paul <sean@poorly.run>, Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Rob Clark <robdclark@gmail.com>, iommu@lists.linux.dev, Abhinav Kumar <quic_abhinavk@quicinc.com>, Marijn Suijten <marijn.suijten@somainline.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, David Airlie <airlied@gmail.com>, Robin Murphy <robin.murphy@arm.com>, Krishna Manikandan <quic_mkrishn@quicinc.com>
In-Reply-To: <20230411-topic-straitlagoon_mdss-v4-5-68e7e25d70e1@linaro.org>
References: <20230411-topic-straitlagoon_mdss-v4-0-68e7e25d70e1@linaro.org>
 <20230411-topic-straitlagoon_mdss-v4-5-68e7e25d70e1@linaro.org>
Message-Id: <168452313011.3852116.2187810600963716663.robh@kernel.org>
Subject: Re: [PATCH v4 05/12] dt-bindings: display/msm: Add SM6375 MDSS
Date: Fri, 19 May 2023 14:05:30 -0500


On Fri, 19 May 2023 19:04:26 +0200, Konrad Dybcio wrote:
> Document the SM6375 MDSS.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  .../bindings/display/msm/qcom,sm6375-mdss.yaml     | 216 +++++++++++++++++++++
>  1 file changed, 216 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm6375-mdss.example.dtb: display-controller@5e01000: clock-names:0: 'bus' was expected
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sc7180-dpu.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm6375-mdss.example.dtb: display-controller@5e01000: clock-names:1: 'iface' was expected
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sc7180-dpu.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm6375-mdss.example.dtb: display-controller@5e01000: clock-names:2: 'rot' was expected
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sc7180-dpu.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm6375-mdss.example.dtb: display-controller@5e01000: clock-names:4: 'core' was expected
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sc7180-dpu.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230411-topic-straitlagoon_mdss-v4-5-68e7e25d70e1@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

