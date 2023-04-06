Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820EAAD29
	for <iommu@lists.linux.dev>; Thu,  6 Apr 2023 18:07:47 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id l17so3436118ejp.8
        for <iommu@lists.linux.dev>; Thu, 06 Apr 2023 11:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680804465;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1weO9qyyCQy8+b4IcRBkB70UCGhmywO6NJQrtwS0SGI=;
        b=Q39KSHVK0vW4i5Ni8OS1x1qezXczm35jO/kx/LP48M/yhIJzxCsjlEkGkpPsBZrkdu
         6KzuKgQrC6cGI46YZBIvBAz05m7Byijj31TWFGRrOGmJZg6AS/nfYc8j5wRnkZB+ixHT
         lFFMw0oOfjoYDKfQEkE3xHvbtU5dqfFqKLULKu4HhJ4Y1SJJBemueE8xAzsPtrAliZuW
         jkl0cYlfZSsnFzcXtZlOKWEkGOFlToS+hK+aVsnF/4Xv9xceCGGPgIPHlvMy0gTdqZih
         VZqacRRlgRvOeOeMTeCDyD/H4o9AHH2XYkdqqmn72aS0I5JxZWlPt/G67JdARodtQVq6
         uVIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680804465;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1weO9qyyCQy8+b4IcRBkB70UCGhmywO6NJQrtwS0SGI=;
        b=ZV14qeKxwPHRS9+izx1V86f6sfKvMVJJkGUSl/+zOGBIyedwc9nvUfHd0mGTNKWaV1
         7iZ69EDRGxFP/KrQyCsIKTjNAUsB3PBDFgi4nK/bu6T8oljNutMUt5fvc3XO2PdTiSmC
         BEVxASvLMdvVm0V5r8iBRnzQ+ToPvEd3YN4MwVFF8ttw1fmUrIjIiRCwP9u6dFBjsnJL
         CrpZ33awOnPwZx95SjSicwQcLe7qZvuEipevmsueQxKehRtR7O5R+uoqNtEDKtmua5yz
         TKbqe6wHCms0XoIXQkH1MfgsmRXX3QE0dWBGG0vFPmFIwNP9RmWF/fD/KW3f71FOA7og
         T/vA==
X-Gm-Message-State: AAQBX9et8rtHIs/z9OuyVtxlTyySqd5Wnve/0RkU1MTK5aw0NGKVBp6R
	5r1Xl4yQKwg0Wf/G4k/jm+IWyA==
X-Google-Smtp-Source: AKy350aHt9yU8Ez/wQQLBkXXBqBOR8IO147QPcgI9LDFf7/LZvdMbuHrlfbxBzBf2DPp21fb0ciawA==
X-Received: by 2002:a17:906:f897:b0:8b1:7eba:de5 with SMTP id lg23-20020a170906f89700b008b17eba0de5mr6211680ejb.10.1680804465711;
        Thu, 06 Apr 2023 11:07:45 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed? ([2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed])
        by smtp.gmail.com with ESMTPSA id r7-20020a50c007000000b005021d210899sm1022641edb.23.2023.04.06.11.07.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 11:07:45 -0700 (PDT)
Message-ID: <cc5ee0e5-5cc7-bf80-68cc-2d38b1118c6d@linaro.org>
Date: Thu, 6 Apr 2023 20:07:44 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2] dt-bindings: iommu: Convert QCOM IOMMU to YAML
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230406-topic-qciommu-v2-1-b8547622b2a4@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230406-topic-qciommu-v2-1-b8547622b2a4@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/04/2023 13:58, Konrad Dybcio wrote:
> Convert the Qualcomm IOMMU bindings to YAML.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
> v1 -> v2:

Thank you for your patch. There is something to discuss/improve.

> +
> +patternProperties:
> +  "^iommu-ctx@[0-9a-f]+$":
> +    type: object

On this level:
additionalProperties: false

> +    properties:
> +      compatible:
> +        enum:
> +          - qcom,msm-iommu-v1-ns
> +          - qcom,msm-iommu-v1-sec
> +
> +      interrupts:
> +        maxItems: 1
> +
> +      reg:
> +        maxItems: 1

On this level:
    required:
      - compatible
      - interrupts
      - reg

> +
> +required:
> +  - compatible
> +  - clocks
> +  - clock-names
> +  - ranges
> +  - '#address-cells'
> +  - '#size-cells'
> +  - '#iommu-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,gcc-msm8916.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    apps_iommu: iommu@1e20000 {
> +      compatible = "qcom,msm8916-iommu", "qcom,msm-iommu-v1";
> +      reg = <0x01ef0000 0x3000>;
> +      clocks = <&gcc GCC_SMMU_CFG_CLK>,
> +               <&gcc GCC_APSS_TCU_CLK>;
> +      clock-names = "iface", "bus";
> +      qcom,iommu-secure-id = <17>;
> +      #address-cells = <1>;
> +      #size-cells = <1>;
> +      #iommu-cells = <1>;
> +      ranges = <0 0x01e20000 0x40000>;
> +
> +      /* mdp_0: */
> +      iommu-ctx@4000 {
> +        compatible = "qcom,msm-iommu-v1-ns";
> +        reg = <0x4000 0x1000>;
> +        interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
> +      };
> +    };
> +
> +    mdp: mdp@1a01000 {
> +      reg = <0x01a01000 0x1000>;
> +      iommus = <&apps_iommu 4>;

Drop mdp node. Consumers should not be in provider bindings.



Best regards,
Krzysztof

