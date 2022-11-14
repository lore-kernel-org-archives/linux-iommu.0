Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50B64C78
	for <iommu@lists.linux.dev>; Mon, 14 Nov 2022 14:19:56 +0000 (UTC)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-13c2cfd1126so12579618fac.10
        for <iommu@lists.linux.dev>; Mon, 14 Nov 2022 06:19:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=T363VWdQ5ocnDSQ5x4Cz3XrYjoogVZHJUwppT1WNaYs=;
        b=kbIO6QUBvUthIqERCSK6rhqMn+HhKDFI9DXo4JIPXumMT69DJkViTzp2SSR6baMbBq
         n7sOH7CdYSzWZFcRNIhyvwG4VEJZy56+G2Bj3j6w0hNqzSF7yFTteZFDq+2SuzUA4CGG
         Umn5phEBsDAAtAVa9DaEb070NOITxfXnvUxSMWUOHwam2MiiRVmuOMkK5Nb9QG0y5KSM
         8ji4bBoXz1Tj0ZJUrtQe7kKFTlgCSxdh1QDDdb9fjhngu7HBIiOEteqAMgIVVtkFuKuX
         WxfoLI8PVmF6n1L19yCrzg7QgkEnLdHHJLXhAfwO0+dnRkt+6xRFSMW/pa9CdHzzmw3A
         Reqw==
X-Gm-Message-State: ANoB5pluhYEdRvdLGNjJWKee7i7V7GjYwez8fgJDtx/zU0rIA3+QVfLp
	9lIz4hdimN6Amv0Ucg3dbw==
X-Google-Smtp-Source: AA0mqf5YD2ya3ZXS0A73Y8ieA+ETvdMBfmcetHL50rNO1AXEo7hvIHk3FznZiOxaGoOQxPiD6GLxBg==
X-Received: by 2002:a05:6870:8dc3:b0:13b:b3b7:1082 with SMTP id lq3-20020a0568708dc300b0013bb3b71082mr7186742oab.71.1668435595440;
        Mon, 14 Nov 2022 06:19:55 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id h3-20020a9d7983000000b0063b24357269sm4138272otm.13.2022.11.14.06.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 06:19:54 -0800 (PST)
Received: (nullmailer pid 2686451 invoked by uid 1000);
	Mon, 14 Nov 2022 14:19:56 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, patches@linaro.org, Rob Herring <robh+dt@kernel.org>, krzysztof.kozlowski@linaro.org, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, agross@kernel.org, andersson@kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
In-Reply-To: <20221114104222.36329-2-konrad.dybcio@linaro.org>
References: <20221114104222.36329-1-konrad.dybcio@linaro.org>
 <20221114104222.36329-2-konrad.dybcio@linaro.org>
Message-Id: <166843545485.2679805.16057396300948126713.robh@kernel.org>
Subject: Re: [PATCH v2 1/9] dt-bindings: arm-smmu: Allow up to 3 power-domains
Date: Mon, 14 Nov 2022 08:19:56 -0600


On Mon, 14 Nov 2022 11:42:14 +0100, Konrad Dybcio wrote:
> Some SMMUs require that a vote is held on as much as 3 separate PDs
> (hello Qualcomm). Allow it in bindings.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
> Changes since v1:
> - Add minItems
> 
>  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iommu/arm,smmu.yaml: properties:power-domains:minItems: 0 is less than the minimum of 1
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iommu/arm,smmu.yaml: properties:power-domains: 'anyOf' conditional failed, one must be fixed:
	'minItems' is not one of ['maxItems', 'description', 'deprecated']
		hint: Only "maxItems" is required for a single entry if there are no constraints defined for the values.
	'minItems' is not one of ['description', 'deprecated', 'const', 'enum', 'minimum', 'maximum', 'multipleOf', 'default', '$ref', 'oneOf']
	'maxItems' is not one of ['description', 'deprecated', 'const', 'enum', 'minimum', 'maximum', 'multipleOf', 'default', '$ref', 'oneOf']
	1 was expected
		hint: Only "maxItems" is required for a single entry if there are no constraints defined for the values.
	0 is less than the minimum of 1
		hint: Arrays must be described with a combination of minItems/maxItems/items
	hint: cell array properties must define how many entries and what the entries are when there is more than one entry.
	from schema $id: http://devicetree.org/meta-schemas/power-domain.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

