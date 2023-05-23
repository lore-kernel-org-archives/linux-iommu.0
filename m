Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F6629A9
	for <iommu@lists.linux.dev>; Tue, 23 May 2023 08:34:55 +0000 (UTC)
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6af6f83fc49so2153279a34.3
        for <iommu@lists.linux.dev>; Tue, 23 May 2023 01:34:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684830895; x=1687422895;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Fbuuelze6oX5JYOQ10a+DjnQCHnZU9fuAvZCu9bIt5c=;
        b=UJLzedOtEwriT79crldc4oh3okHcbZndiyzwjaanGOpvP4RJdYCFBtTZXE3h9i6IW+
         O7yy+EpNdb+nXQHDGRAR0kmsipjkoKkHfjCQ2TStkEUfIDrcG66vYcPmeJTJOuivBswB
         y06VEi7e3jrCV0FfASRsHAMAFB2qHLnGswAQSffXyv+1AWC1t2WaxsgR1i33pQFpD8IK
         MvqXpy++B2yyhK7ILT7ZnKib2pU6A2Kr1teGe/9BkU92zHIS8fEuS5iwu0zC2Rs0lZey
         +nBvsjDOPH9ZGivOEEM15mzH/Yp3kneAKhmI0Z3tt364d2s5Y0W6ov17IOyF4hb3J1sw
         ltVg==
X-Gm-Message-State: AC+VfDxS7KPfiEawfpMBqfbD9gZ+K17HLqruPkLNsScp1Pk9s9ibTVyU
	hUUM61mPGy9WJM7aOZ5ibQ==
X-Google-Smtp-Source: ACHHUZ7/tT2ff11MVD89mp0Uq6HgcF9rMmy1Is5kbzuJKiVecR9PIqUjz5MCk5++W0yN001aVxjPUQ==
X-Received: by 2002:a9d:6b11:0:b0:6af:85fd:ffff with SMTP id g17-20020a9d6b11000000b006af85fdffffmr2136294otp.25.1684830894792;
        Tue, 23 May 2023 01:34:54 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q25-20020a9d7c99000000b006aaf82bd5a2sm3258395otn.43.2023.05.23.01.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 01:34:54 -0700 (PDT)
Received: (nullmailer pid 140433 invoked by uid 1000);
	Tue, 23 May 2023 08:34:52 -0000
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
Cc: linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev, David Airlie <airlied@gmail.com>, Conor Dooley <conor+dt@kernel.org>, Joerg Roedel <joro@8bytes.org>, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>, freedreno@lists.freedesktop.org, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Rob Herring <robh+dt@kernel.org>, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, Sean Paul <sean@poorly.run>, Robin Murphy <robin.murphy@arm.com>, Daniel Vetter <daniel@ffwll.ch>, Abhinav Kumar <quic_abhinavk@quicinc.com>, Krishna Manikandan <quic_mkrishn@quicinc.com>, linux-arm-kernel@lists.infradead.org, Marijn Suijten <marijn.suijten@somainline.org>
In-Reply-To: <20230411-topic-straitlagoon_mdss-v5-4-998b4d2f7dd1@linaro.org>
References: <20230411-topic-straitlagoon_mdss-v5-0-998b4d2f7dd1@linaro.org>
 <20230411-topic-straitlagoon_mdss-v5-4-998b4d2f7dd1@linaro.org>
Message-Id: <168483089214.140382.17835176497108911988.robh@kernel.org>
Subject: Re: [PATCH v5 04/12] dt-bindings: display/msm: Add SM6350 MDSS
Date: Tue, 23 May 2023 03:34:52 -0500


On Tue, 23 May 2023 09:46:15 +0200, Konrad Dybcio wrote:
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
	['qcom,sm6350-dsi-ctrl', 'qcom,mdss-dsi-ctrl'] is too long
	'qcom,sm6350-dsi-ctrl' is not one of ['qcom,apq8064-dsi-ctrl', 'qcom,msm8916-dsi-ctrl', 'qcom,msm8953-dsi-ctrl', 'qcom,msm8974-dsi-ctrl', 'qcom,msm8996-dsi-ctrl', 'qcom,msm8998-dsi-ctrl', 'qcom,qcm2290-dsi-ctrl', 'qcom,sc7180-dsi-ctrl', 'qcom,sc7280-dsi-ctrl', 'qcom,sdm660-dsi-ctrl', 'qcom,sdm845-dsi-ctrl', 'qcom,sm6115-dsi-ctrl', 'qcom,sm8150-dsi-ctrl', 'qcom,sm8250-dsi-ctrl', 'qcom,sm8350-dsi-ctrl', 'qcom,sm8450-dsi-ctrl', 'qcom,sm8550-dsi-ctrl']
	'qcom,sm6350-dsi-ctrl' is not one of ['qcom,dsi-ctrl-6g-qcm2290', 'qcom,mdss-dsi-ctrl']
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm6350-mdss.example.dtb: dsi@ae94000: Unevaluated properties are not allowed ('compatible' was unexpected)
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230411-topic-straitlagoon_mdss-v5-4-998b4d2f7dd1@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

