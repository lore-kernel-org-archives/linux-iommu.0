Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD2310FF
	for <iommu@lists.linux.dev>; Fri,  5 May 2023 22:34:51 +0000 (UTC)
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6a5febde157so911415a34.3
        for <iommu@lists.linux.dev>; Fri, 05 May 2023 15:34:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683326091; x=1685918091;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=x2bjE4y2k/ZRonBr5I4qWlh5CoiWSN7zhAV2pZnn6Zo=;
        b=OQqP6FgDXO05CYkLhyKyLlSULpOYbIjvrU/a+q7cm9nXcpB/TriWdHKcTHVDtDLnBx
         VLo1lw2vwWuCeNvH1WuXslhRiKBo9VET3aVaqSiab3o98jH2NoAgSgtdqykZq/k+PlwB
         tY/1117dTFOnPSu7pJx4obnJDkYnSHRQT1DzyofAiRUcTmMtB1hTbCDDUx/rCOOGY6FA
         GqtYK+suyvndHmHcArufqkmJ7zyPwsTpeIcisc0iMqXhPZyFZ+unni0B2MY3fnvT3kS+
         Jnu/LMKMk4Te60Pxlw/Fr6u+s6fEr7qaQkgOuw8BJb3Ba5kzuqWJodiqFP1eiVNJB+py
         UElw==
X-Gm-Message-State: AC+VfDyLwvzMA7+VEjJKtch0yrQf7DYzuyb8J2+2vJxa7/YhqhBA25t/
	yM/UAB5YJXHhtAWzFhnvsQ==
X-Google-Smtp-Source: ACHHUZ53cI1CM7mECZnA6cYHzHY3nz4n6zr1YDhdJXJbCXDc1XMGMyxqi2QWT5S0Nvb2PxvZUxA5IA==
X-Received: by 2002:a05:6808:1c4:b0:387:2e2e:7b2 with SMTP id x4-20020a05680801c400b003872e2e07b2mr1330779oic.26.1683326090853;
        Fri, 05 May 2023 15:34:50 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j16-20020a9d7690000000b006a6558ef17fsm1404537otl.30.2023.05.05.15.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 15:34:50 -0700 (PDT)
Received: (nullmailer pid 3806405 invoked by uid 1000);
	Fri, 05 May 2023 22:34:48 -0000
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
Cc: Robin Murphy <robin.murphy@arm.com>, David Airlie <airlied@gmail.com>, Rob Herring <robh+dt@kernel.org>, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, dri-devel@lists.freedesktop.org, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Krishna Manikandan <quic_mkrishn@quicinc.com>, Marijn Suijten <marijn.suijten@somainline.org>, Rob Clark <robdclark@gmail.com>, Joerg Roedel <joro@8bytes.org>
In-Reply-To: <20230411-topic-straitlagoon_mdss-v3-4-9837d6b3516d@linaro.org>
References: <20230411-topic-straitlagoon_mdss-v3-0-9837d6b3516d@linaro.org>
 <20230411-topic-straitlagoon_mdss-v3-4-9837d6b3516d@linaro.org>
Message-Id: <168332608833.3806341.1631479517447632665.robh@kernel.org>
Subject: Re: [PATCH v3 04/12] dt-bindings: display/msm: Add SM6350 MDSS
Date: Fri, 05 May 2023 17:34:48 -0500


On Fri, 05 May 2023 23:40:30 +0200, Konrad Dybcio wrote:
> Document the SM6350 MDSS.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  .../bindings/display/msm/qcom,sm6350-mdss.yaml     | 214 +++++++++++++++++++++
>  1 file changed, 214 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm6350-mdss.example.dtb: dsi@ae94000: compatible: 'oneOf' conditional failed, one must be fixed:
	'qcom,sm6350-dsi-ctrl' is not one of ['qcom,apq8064-dsi-ctrl', 'qcom,msm8916-dsi-ctrl', 'qcom,msm8953-dsi-ctrl', 'qcom,msm8974-dsi-ctrl', 'qcom,msm8996-dsi-ctrl', 'qcom,msm8998-dsi-ctrl', 'qcom,qcm2290-dsi-ctrl', 'qcom,sc7180-dsi-ctrl', 'qcom,sc7280-dsi-ctrl', 'qcom,sdm660-dsi-ctrl', 'qcom,sdm845-dsi-ctrl', 'qcom,sm8150-dsi-ctrl', 'qcom,sm8250-dsi-ctrl', 'qcom,sm8350-dsi-ctrl', 'qcom,sm8450-dsi-ctrl', 'qcom,sm8550-dsi-ctrl']
	'qcom,sm6350-dsi-ctrl' is not one of ['dsi-ctrl-6g-qcm2290']
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm6350-mdss.example.dtb: dsi@ae94000: Unevaluated properties are not allowed ('compatible' was unexpected)
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230411-topic-straitlagoon_mdss-v3-4-9837d6b3516d@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

