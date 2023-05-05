Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302A4C8DF
	for <iommu@lists.linux.dev>; Fri,  5 May 2023 22:34:54 +0000 (UTC)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-1959f1505d8so449356fac.0
        for <iommu@lists.linux.dev>; Fri, 05 May 2023 15:34:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683326093; x=1685918093;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Peh9DjIa9y4hL3QLuFr1+gTNBXk18rdV53wUy732J+E=;
        b=N2meZUynRp4ksOlhs6kKAB1Ad7cPOywx2acHKwfTJUlfHMqof25oW9pNhfxmst7MF3
         3+1fHsUnvDr+5O7NjiBywSQWIjNYD5mywAJ/s09uuFpL22gqtcgkGisHTwHWtww8+28h
         yiZI97VOOrx0y8nj1aNAd3Czgc7oex2lL+aU9cRfEoKU9mGU/oy932RAWV+rj9ivBSVU
         MYH8it2jbKDaKjpJcajJT6eTw33OAbGb1EyaLwL9QnI19ZU7e+S3SEtuWXd6p9ZUkZ7X
         D2PIAioSrbLu5erOcNijV4hS2wCxk6tw/YSawC/qUWHvxqcpQReRtr/vPrLRVPFsipMR
         z9cw==
X-Gm-Message-State: AC+VfDzH/JDqeR47r0bI8gjirsREyKe4dZiiEnP2g7zMP+FYMEKUBsod
	/W/OTqM93rcYi0GVeE7ePA==
X-Google-Smtp-Source: ACHHUZ7tewb7lg4E8SgRxZju/tnXnc8FRm8oHt/9thhyErtyx/VXwjE83tq9zPgO4jO2pZGkfKkOsw==
X-Received: by 2002:a05:6870:d2a9:b0:187:8008:eb09 with SMTP id d41-20020a056870d2a900b001878008eb09mr1660487oae.58.1683326092882;
        Fri, 05 May 2023 15:34:52 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id c18-20020a05687093d200b0016a37572d17sm2375548oal.2.2023.05.05.15.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 15:34:52 -0700 (PDT)
Received: (nullmailer pid 3806408 invoked by uid 1000);
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
Cc: linux-arm-kernel@lists.infradead.org, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh+dt@kernel.org>, Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, Krishna Manikandan <quic_mkrishn@quicinc.com>, dri-devel@lists.freedesktop.org, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, iommu@lists.linux.dev, freedreno@lists.freedesktop.org, Abhinav Kumar <quic_abhinavk@quicinc.com>, David Airlie <airlied@gmail.com>, Rob Clark <robdclark@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
In-Reply-To: <20230411-topic-straitlagoon_mdss-v3-5-9837d6b3516d@linaro.org>
References: <20230411-topic-straitlagoon_mdss-v3-0-9837d6b3516d@linaro.org>
 <20230411-topic-straitlagoon_mdss-v3-5-9837d6b3516d@linaro.org>
Message-Id: <168332608896.3806369.13351102709113802853.robh@kernel.org>
Subject: Re: [PATCH v3 05/12] dt-bindings: display/msm: Add SM6375 MDSS
Date: Fri, 05 May 2023 17:34:48 -0500


On Fri, 05 May 2023 23:40:31 +0200, Konrad Dybcio wrote:
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
	'qcom,sm6375-dsi-ctrl' is not one of ['qcom,apq8064-dsi-ctrl', 'qcom,msm8916-dsi-ctrl', 'qcom,msm8953-dsi-ctrl', 'qcom,msm8974-dsi-ctrl', 'qcom,msm8996-dsi-ctrl', 'qcom,msm8998-dsi-ctrl', 'qcom,qcm2290-dsi-ctrl', 'qcom,sc7180-dsi-ctrl', 'qcom,sc7280-dsi-ctrl', 'qcom,sdm660-dsi-ctrl', 'qcom,sdm845-dsi-ctrl', 'qcom,sm8150-dsi-ctrl', 'qcom,sm8250-dsi-ctrl', 'qcom,sm8350-dsi-ctrl', 'qcom,sm8450-dsi-ctrl', 'qcom,sm8550-dsi-ctrl']
	'qcom,sm6375-dsi-ctrl' is not one of ['dsi-ctrl-6g-qcm2290']
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm6375-mdss.example.dtb: dsi@5e94000: Unevaluated properties are not allowed ('compatible' was unexpected)
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230411-topic-straitlagoon_mdss-v3-5-9837d6b3516d@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

