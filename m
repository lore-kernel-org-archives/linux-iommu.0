Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C836CBE7D
	for <iommu@lists.linux.dev>; Tue, 23 May 2023 08:34:57 +0000 (UTC)
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6af812703b6so719812a34.1
        for <iommu@lists.linux.dev>; Tue, 23 May 2023 01:34:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684830897; x=1687422897;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8Rk/6TkhHiy7aOgeY8F1RdAT5pIvD1dRXseK75IVn/U=;
        b=Oi87TdI9+Cr38I+T/wzi1bY66E7RFsFNdd06aQrkHN8vJIKN6X4R7kTPY9BGY+RotM
         0vi6Od+fBYc8L4tPSLkHNmHPAlh3M5OdVoEJsAN2DPu3kw1YQAHdO32djsuJ641UGBhy
         EiwIFUao1KWCuhIc8KLRuTV7RXu335PCfZXXMJWlQOU/gSMe7J/rKggkE8U+8zlsPqg8
         q+AOP5fZCiuHHSBxHccazi0fgz5xumG0kAjo01ICDMH04dz2KLOrh2cKjGiEqw0swcLu
         a8fKIZHL/iZEu4HtYofAcOCfrUArjIOMp0BTkmW+mbT7ECgMbEZanOe/KUTBwliUvnxZ
         C0Jw==
X-Gm-Message-State: AC+VfDxqZ1CCE7qcDnI4j+bb6K2Er2E/ECoecIa+uUSOjaqoFIL+x8wC
	ASZz2Ygn287Eepih94nK6cNd/xE/1w==
X-Google-Smtp-Source: ACHHUZ5s/vzpTb+9BMMWcelUyV4uhEXM/zWmwl11RKvNss9ted8Bfh3Z6TbSKaa7B4n4vss2ArZacw==
X-Received: by 2002:a9d:7e9a:0:b0:6af:8743:d5ac with SMTP id m26-20020a9d7e9a000000b006af8743d5acmr1845750otp.29.1684830896813;
        Tue, 23 May 2023 01:34:56 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g7-20020a9d6c47000000b006ae7c3eaf4esm1353685otq.26.2023.05.23.01.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 01:34:56 -0700 (PDT)
Received: (nullmailer pid 140436 invoked by uid 1000);
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
Cc: Daniel Vetter <daniel@ffwll.ch>, Robin Murphy <robin.murphy@arm.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, Krishna Manikandan <quic_mkrishn@quicinc.com>, linux-arm-kernel@lists.infradead.org, Rob Clark <robdclark@gmail.com>, devicetree@vger.kernel.org, Abhinav Kumar <quic_abhinavk@quicinc.com>, dri-devel@lists.freedesktop.org, Conor Dooley <conor+dt@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Joerg Roedel <joro@8bytes.org>, David Airlie <airlied@gmail.com>, Rob Herring <robh+dt@kernel.org>, iommu@lists.linux.dev
In-Reply-To: <20230411-topic-straitlagoon_mdss-v5-5-998b4d2f7dd1@linaro.org>
References: <20230411-topic-straitlagoon_mdss-v5-0-998b4d2f7dd1@linaro.org>
 <20230411-topic-straitlagoon_mdss-v5-5-998b4d2f7dd1@linaro.org>
Message-Id: <168483089291.140404.16963046121189730936.robh@kernel.org>
Subject: Re: [PATCH v5 05/12] dt-bindings: display/msm: Add SM6375 MDSS
Date: Tue, 23 May 2023 03:34:52 -0500


On Tue, 23 May 2023 09:46:16 +0200, Konrad Dybcio wrote:
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
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm6375-mdss.example.dtb: dsi@5e94000: compatible: 'oneOf' conditional failed, one must be fixed:
	['qcom,sm6375-dsi-ctrl', 'qcom,mdss-dsi-ctrl'] is too long
	'qcom,sm6375-dsi-ctrl' is not one of ['qcom,apq8064-dsi-ctrl', 'qcom,msm8916-dsi-ctrl', 'qcom,msm8953-dsi-ctrl', 'qcom,msm8974-dsi-ctrl', 'qcom,msm8996-dsi-ctrl', 'qcom,msm8998-dsi-ctrl', 'qcom,qcm2290-dsi-ctrl', 'qcom,sc7180-dsi-ctrl', 'qcom,sc7280-dsi-ctrl', 'qcom,sdm660-dsi-ctrl', 'qcom,sdm845-dsi-ctrl', 'qcom,sm6115-dsi-ctrl', 'qcom,sm8150-dsi-ctrl', 'qcom,sm8250-dsi-ctrl', 'qcom,sm8350-dsi-ctrl', 'qcom,sm8450-dsi-ctrl', 'qcom,sm8550-dsi-ctrl']
	'qcom,sm6375-dsi-ctrl' is not one of ['qcom,dsi-ctrl-6g-qcm2290', 'qcom,mdss-dsi-ctrl']
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm6375-mdss.example.dtb: dsi@5e94000: Unevaluated properties are not allowed ('compatible' was unexpected)
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230411-topic-straitlagoon_mdss-v5-5-998b4d2f7dd1@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

