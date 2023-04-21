Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E09F2F27
	for <iommu@lists.linux.dev>; Fri, 21 Apr 2023 12:56:21 +0000 (UTC)
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6a5f03551fdso1667201a34.0
        for <iommu@lists.linux.dev>; Fri, 21 Apr 2023 05:56:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682081780; x=1684673780;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8iHqSMwo/rp53MUqa385NdmlLYpp8taR9HcafwH8WBg=;
        b=Vf+hgMceoZub79PiBrSnPg4xBvweBqDfTp8gqt4LRqpGGcU4gxuwUdeNNo7JXqHbkA
         DMoAvGHyXkymTgrmAGCQgvU3Gycu34ro+mwSiA8OMmkxEV7Jv9WTLcVdjkjzj09wbp/c
         38By97nkmUzPNEkU5OMCbFno7Jms/d7nZt9+e9fWOWpFEplPhfJ+83FDkpxPyVoBNe6B
         2wNkh/Om/nA8ozfUOX3g/ixGg1odZ0uYPU9pdIcxHdsjHYCdXTv1knDdFptZOnBCIL+1
         UxBAWZkc8FFFGrDRQMI/VHjjcTrIYk5X+tvBk8G709UreMtuMgdpnhrLJRHPUkWyUQR1
         Ybfw==
X-Gm-Message-State: AAQBX9c3zpeniq5/6GOfiCTxayUUQ83dkPLs75MPpE2NNSwoyqvYY4bG
	12KITREMCseY8NOwo46xFA==
X-Google-Smtp-Source: AKy350aomGuxUTztWOPXI+gVl1MEgcB2Ww3EEurAtTYT7QWYKij3fQcsX+CIjfRPUgtasssGom9CvA==
X-Received: by 2002:a05:6830:1e79:b0:6a5:ff72:4fea with SMTP id m25-20020a0568301e7900b006a5ff724feamr2740190otr.29.1682081780049;
        Fri, 21 Apr 2023 05:56:20 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l4-20020a0568301d6400b0069fa883c738sm1742364oti.35.2023.04.21.05.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 05:56:19 -0700 (PDT)
Received: (nullmailer pid 936702 invoked by uid 1000);
	Fri, 21 Apr 2023 12:56:18 -0000
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
Cc: linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org, Abhinav Kumar <quic_abhinavk@quicinc.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, linux-arm-msm@vger.kernel.org, Will Deacon <will@kernel.org>, Rob Herring <robh+dt@kernel.org>, David Airlie <airlied@gmail.com>, Marijn Suijten <marijn.suijten@somainline.org>, devicetree@vger.kernel.org, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Daniel Vetter <daniel@ffwll.ch>, Joerg Roedel <joro@8bytes.org>, Sean Paul <sean@poorly.run>, Rob Clark <robdclark@gmail.com>, Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev, Krishna Manikandan <quic_mkrishn@quicinc.com>, linux-kernel@vger.kernel.org, freedreno@lists.freedesktop.org
In-Reply-To: <20230411-topic-straitlagoon_mdss-v2-4-5def73f50980@linaro.org>
References: <20230411-topic-straitlagoon_mdss-v2-0-5def73f50980@linaro.org>
 <20230411-topic-straitlagoon_mdss-v2-4-5def73f50980@linaro.org>
Message-Id: <168208107852.922456.2603583984839094907.robh@kernel.org>
Subject: Re: [PATCH v2 04/13] dt-bindings: display/msm: Add SM6350 MDSS
Date: Fri, 21 Apr 2023 07:56:18 -0500


On Fri, 21 Apr 2023 00:31:13 +0200, Konrad Dybcio wrote:
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

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230411-topic-straitlagoon_mdss-v2-4-5def73f50980@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

