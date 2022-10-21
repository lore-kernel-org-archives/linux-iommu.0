Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF1F7B
	for <iommu@lists.linux.dev>; Fri, 21 Oct 2022 21:00:29 +0000 (UTC)
Received: by mail-ot1-f41.google.com with SMTP id r8-20020a056830120800b00661a0a236efso2551198otp.4
        for <iommu@lists.linux.dev>; Fri, 21 Oct 2022 14:00:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jp5O+v/VR9Uxc6a9bxAqi2fjatkKvL4KNFA/YE6ATM4=;
        b=3P4s/Mg7qedgs4Z2eojXUvNpkbeanrBfPYSlGQC2hg1t/qUxMVDqfkqm7+HDn1ADgv
         LrUCVuk8TEVj3Eb4ZdDLKhf8sV10dEmLQJXvrWkyYYohrr3VXXOtMoU4H4t0OHynTr4O
         yr/a+z5Pkr9C0yMA333opQUefS/YfvYn303dBHqNSJ4p/QS3fDl0wnnFro+dd43G5buk
         IpfcWYkfOY+t+3PF3XCFOnZHSoJF97mfX3o5tlWRvuO+XxJXnUM4KNtm8ZihXUhG+K/D
         I8vxU1XlxuufGVeE3edP4LqueLtpU1Vpy3yZpQjIB5w4DV0ib6fPBoIic5jX65DCIcZi
         /D7g==
X-Gm-Message-State: ACrzQf1rS+fjkBlU8X18WF4OhEYU2iM5mmEFazUuszwt9Aw4uMTUXQc+
	N8L/LPQIp2PJny/p6mcDhw==
X-Google-Smtp-Source: AMsMyM7d4LB4l4q8le8x1CWXfY+uasId0M+kGCbSwVnvSjOkI5HsMNG3Eu8V1sORN0mJObk7QNOP2g==
X-Received: by 2002:a05:6830:440c:b0:661:e2ad:c599 with SMTP id q12-20020a056830440c00b00661e2adc599mr10066800otv.103.1666386028428;
        Fri, 21 Oct 2022 14:00:28 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e18-20020a056830201200b00661ad8741b4sm1579722otp.24.2022.10.21.14.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 14:00:27 -0700 (PDT)
Received: (nullmailer pid 314789 invoked by uid 1000);
	Fri, 21 Oct 2022 21:00:25 -0000
From: Rob Herring <robh@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org, Joerg Roedel <joro@8bytes.org>, Rob Clark <robdclark@gmail.com>, Rob Herring <robh+dt@kernel.org>, Sai Prakash Ranjan <quic_saipraka@quicinc.com>, freedreno@lists.freedesktop.org, Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>, linux-arm-kernel@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, iommu@lists.linux.dev, Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20221021165534.2334329-3-dmitry.baryshkov@linaro.org>
References: <20221021165534.2334329-1-dmitry.baryshkov@linaro.org> <20221021165534.2334329-3-dmitry.baryshkov@linaro.org>
Message-Id: <166638584258.307638.14223403470296832950.robh@kernel.org>
Subject: Re: [RFC PATCH 2/9] dt-bindings: arm-smmu: fix clocks/clock-names schema
Date: Fri, 21 Oct 2022 16:00:25 -0500
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

On Fri, 21 Oct 2022 19:55:27 +0300, Dmitry Baryshkov wrote:
> Rework clocks/clock-names properties schema to property describe
> possible usage cases.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  .../devicetree/bindings/iommu/arm,smmu.yaml   | 129 ++++++++++++++++--
>  1 file changed, 121 insertions(+), 8 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iommu/arm,smmu.example.dtb: iommu@d00000: 'anyOf' conditional failed, one must be fixed:
	['bus', 'iface'] is too long
	['bus', 'iface'] is too short
	'iface' was expected
	'iface-mm' was expected
	'mem' was expected
	'iface-smmu' was expected
	[[4294967295, 123], [4294967295, 124]] is too long
	[[4294967295, 123], [4294967295, 124]] is too short
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iommu/arm,smmu.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

