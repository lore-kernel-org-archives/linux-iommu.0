Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B0528FA
	for <iommu@lists.linux.dev>; Tue, 24 Oct 2023 18:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6ce353df504so3234339a34.3
        for <iommu@lists.linux.dev>; Tue, 24 Oct 2023 11:42:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698172971; x=1698777771;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e7tCIB9BylheYtMG7rMe1KZx7kNN6oaCCoyrHFzcP3w=;
        b=GaLsiOhTexEPEcBQo7NfLXXvVK61b81iGvBzJjFpS3UM9f3fz2pnth4KkXgabRF4z4
         3Vot0zFj6ewEL2IoGTeowp5OYCXRBOZsOSbV+ed4YRqSLw7+K6BkpOfWQsFSHvG4icfV
         zi3RvddMUW0W5tz/fHAMjPvBXGF1c/0WhyKhaBG9A8PkQJcSkS4rZcdyqMiUTugOrX1i
         U67EtiyjhL1ejN42xYPc2nYugXO3jNPtJ81Bt6oBgND1QKhwLn9rpD4OGPCsRCEZmVAv
         vPNJMpQ7CU6CvsmswGTmxc0Adyc62e1x48PEz6ObECpn+ztlUjzh0g11O6UiEK7Lwidm
         WgWw==
X-Gm-Message-State: AOJu0YxhysKhW+W2XsXLxp6B4lszzNoT8kadT61c32Wk2ouHxLxDDOYo
	Sp1DC/ijkCQzklh8XMLw+w==
X-Google-Smtp-Source: AGHT+IEwPD0r1BvSI+qia1MrYQNuHfFhmEEtqVIVoIHZoqHIvOzwAF1Y9oJIQUNl++IgJf0l1aNg1g==
X-Received: by 2002:a05:6870:b90a:b0:1ea:4dc8:a17 with SMTP id gx10-20020a056870b90a00b001ea4dc80a17mr13544728oab.28.1698172970721;
        Tue, 24 Oct 2023 11:42:50 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id sc17-20020a056871221100b001e0fd4c9b9asm2303077oab.6.2023.10.24.11.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 11:42:50 -0700 (PDT)
Received: (nullmailer pid 263045 invoked by uid 1000);
	Tue, 24 Oct 2023 18:42:48 -0000
Date: Tue, 24 Oct 2023 13:42:48 -0500
From: Rob Herring <robh@kernel.org>
To: Georgi Djakov <quic_c_gdjako@quicinc.com>
Cc: krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, devicetree@vger.kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, quic_cgoldswo@quicinc.com, quic_sukadev@quicinc.com, quic_pdaly@quicinc.com, quic_sudaraja@quicinc.com, djakov@kernel.org
Subject: Re: [PATCH 1/6] dt-bindings: iommu: Add Translation Buffer Unit
 bindings
Message-ID: <20231024184248.GA252155-robh@kernel.org>
References: <20231019021923.13939-1-quic_c_gdjako@quicinc.com>
 <20231019021923.13939-2-quic_c_gdjako@quicinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019021923.13939-2-quic_c_gdjako@quicinc.com>

On Wed, Oct 18, 2023 at 07:19:18PM -0700, Georgi Djakov wrote:
> The "apps_smmu" on the Qualcomm sdm845 platform is an implementation
> of the ARM SMMU-500, that consists of a single TCU (Translation Control
> Unit) and multiple TBUs (Translation Buffer Units). The TCU is already
> being described in the ARM SMMU DT schema. Add also bindings for the
> TBUs so that we can describe their properties.

Arm SMMU-500 is an implementation, too. Is QCom's a modified 
implementation or you are just the first to want to control TBU 
resources?

You need to split this into what could be any SMMU-500 implementation 
and what is truly QCom specific (i.e. modified). Unlike some licensed IP 
that's a free-for-all on DT resources, Arm IP has public specs so we 
don't have to guess.

> In this DT schema, the TBUs are modelled as a child devices of the TCU
> and each of them is described with it's own resources such as clocks,
> power domains, interconnects etc.
> 
> Signed-off-by: Georgi Djakov <quic_c_gdjako@quicinc.com>
> ---
>  .../devicetree/bindings/iommu/arm,smmu.yaml   | 13 ++++
>  .../bindings/iommu/qcom,qsmmuv500-tbu.yaml    | 67 +++++++++++++++++++
>  2 files changed, 80 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iommu/qcom,qsmmuv500-tbu.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> index cf29ab10501c..afc323b4bbc5 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> @@ -230,6 +230,19 @@ properties:
>        enabled for any given device.
>      $ref: /schemas/types.yaml#/definitions/phandle
>  
> +  '#address-cells':
> +    const: 2
> +
> +  '#size-cells':
> +    const: 2
> +
> +  ranges: true
> +
> +patternProperties:
> +  "^tbu@[0-9a-f]+$":
> +    $ref: qcom,qsmmuv500-tbu.yaml

Generic SMMU binding includes something QCom specific. That's not right.


> +    description: The SMMU may include Translation Buffer Units (TBU) as subnodes
> +
>  required:
>    - compatible
>    - reg
> diff --git a/Documentation/devicetree/bindings/iommu/qcom,qsmmuv500-tbu.yaml b/Documentation/devicetree/bindings/iommu/qcom,qsmmuv500-tbu.yaml
> new file mode 100644
> index 000000000000..4baba7397e90
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iommu/qcom,qsmmuv500-tbu.yaml
> @@ -0,0 +1,67 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iommu/qcom,qsmmuv500-tbu.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm TBU (Translation Buffer Unit)
> +
> +maintainers:
> +  - Georgi Djakov <quic_c_gdjako@quicinc.com>
> +
> +description:
> +  TBU nodes represent Translation Buffer Units in an ARM SMMU. Each TBU node
> +  should be a child node of the SMMU in the device tree.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,qsmmuv500-tbu
> +
> +  reg:
> +    items:
> +      - description: Address and size of the TBU's register space.
> +
> +  reg-names:
> +    items:
> +      - const: base
> +
> +  clocks:
> +    maxItems: 1
> +
> +  interconnects:
> +    maxItems: 1
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  qcom,stream-id-range:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description: Stream ID range (address and size) that is assigned by the TBU
> +
> +required:
> +  - compatible
> +  - reg
> +  - interconnects
> +  - qcom,stream-id-range
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,gcc-sdm845.h>
> +    #include <dt-bindings/interconnect/qcom,sdm845.h>
> +    #include <dt-bindings/power/qcom-rpmpd.h>
> +
> +
> +    tbu@150e1000 {
> +        compatible = "qcom,qsmmuv500-tbu";
> +        reg = <0x150e1000 0x1000>;
> +        reg-names = "base";
> +        clocks = <&gcc GCC_AGGRE_NOC_PCIE_TBU_CLK>;
> +        power-domains = <&gcc HLOS1_VOTE_AGGRE_NOC_MMU_PCIE_TBU_GDSC>;
> +        interconnects = <&system_noc MASTER_GNOC_SNOC 0 &config_noc SLAVE_IMEM_CFG 0>;
> +        qcom,stream-id-range = <0x1c00 0x400>;
> +    };
> +
> +...
