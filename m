Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9564C8C09
	for <iommu@lists.linux.dev>; Mon,  9 Jan 2023 20:13:08 +0000 (UTC)
Received: by mail-ot1-f46.google.com with SMTP id i26-20020a9d68da000000b00672301a1664so5808575oto.6
        for <iommu@lists.linux.dev>; Mon, 09 Jan 2023 12:13:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/Dd+49/GslLom8JrkYqQTgzORoaBAb8RY4Tf7RLsiJw=;
        b=GF2suFPD2IXjcgQ9A6nYC0BTIuWJWLQ8GawjxlCNS6V9t9X6gUsVL2dfIF0B52zprb
         wPA4lXyFXwW0XDc3WV4oRKaoUa34xv/ekeXuOv30Mn3mazWcdpWr0M9Dfgfj0/iOMNjp
         xw13KSaJzp229GdDWTH+8PLyQZuZQxPTl6pxjH0HldqjpclcOAt+ktPWASqYD7iL9Qm3
         h8o5tVPxGzsG8CkmnYGg4/YqQYO72Zs/dtgp8X9MIWhfuG3UXNhc/BSBtgWwk+WkOie3
         isLsjN5a3D0r9SiVUjzyVPl/vwspw5GkUMwZWb229XIVXNRVmIjV5TIkzuF2o5yN0nMs
         9peQ==
X-Gm-Message-State: AFqh2kqrUMlZ4xa9zNFYZHX1xjquJwrnC7+M9odwyvlozx7gZR7DbrzA
	W0b8uOJVB11FNuoLTtsOkg==
X-Google-Smtp-Source: AMrXdXsqGGm5UfV6qInsHPAPYf+IKd1w7nmRejg4gEoDHU+6l769MnAo6YkgkE/qpAwc4M3S4Blu1w==
X-Received: by 2002:a05:6830:cb:b0:66c:dd2b:e1ad with SMTP id x11-20020a05683000cb00b0066cdd2be1admr44971742oto.23.1673295187503;
        Mon, 09 Jan 2023 12:13:07 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r7-20020a056830418700b006706e4f6863sm4965699otu.75.2023.01.09.12.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 12:13:07 -0800 (PST)
Received: (nullmailer pid 11353 invoked by uid 1000);
	Mon, 09 Jan 2023 20:13:05 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, linux-gpio@vger.kernel.org, 
	Andy Gross <agross@kernel.org>, Richard Cochran <richardcochran@gmail.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Alex Elder <elder@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Will Deacon <will@kernel.org>, netdev@vger.kernel.org, 
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Vinod Koul <vkoul@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, Georgi Djakov <djakov@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, linux-arm-kernel@lists.infradead.org, 
	Rob Herring <robh+dt@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Jassi Brar <jassisinghbrar@gmail.com>, iommu@lists.linux.dev, 
	Joerg Roedel <joro@8bytes.org>, Manivannan Sadhasivam <mani@kernel.org>
In-Reply-To: <20230109174511.1740856-2-brgl@bgdev.pl>
References: <20230109174511.1740856-1-brgl@bgdev.pl>
 <20230109174511.1740856-2-brgl@bgdev.pl>
Message-Id: <167329506223.7347.1097731761808411140.robh@kernel.org>
Subject: Re: [PATCH 01/18] dt-bindings: clock: sa8775p: add bindings for
 Qualcomm gcc-sa8775p
Date: Mon, 09 Jan 2023 14:13:05 -0600


On Mon, 09 Jan 2023 18:44:54 +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Add DT bindings for the GCC clock on SA8775P platforms. Add relevant
> DT include definitions as well.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  .../bindings/clock/qcom,gcc-sa8775p.yaml      |  77 +++++
>  include/dt-bindings/clock/qcom,gcc-sa8775p.h  | 320 ++++++++++++++++++
>  2 files changed, 397 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-sa8775p.yaml
>  create mode 100644 include/dt-bindings/clock/qcom,gcc-sa8775p.h
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/qcom,gcc-sa8775p.example.dtb: clock-controller@100000: clocks: [[4294967295, 0], [4294967295, 0, 0, 0, 0, 0, 0, 0, 0], [4294967295, 0, 0, 0, 0]] is too short
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/qcom,gcc-sa8775p.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/qcom,gcc-sa8775p.example.dtb: clock-controller@100000: Unevaluated properties are not allowed ('clocks' was unexpected)
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/qcom,gcc-sa8775p.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230109174511.1740856-2-brgl@bgdev.pl

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

