Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A926E20F3
	for <iommu@lists.linux.dev>; Fri,  9 Jun 2023 08:53:49 +0000 (UTC)
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2b1a46ad09fso16332621fa.2
        for <iommu@lists.linux.dev>; Fri, 09 Jun 2023 01:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686300827; x=1688892827;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hqc7b6Q+g/CohWxFaiQNgMOrW73y4+LWnJE4cKqKUVQ=;
        b=FVMYQZZ+1ggHUXFPybxhrwf6kWVwQQmoPV9TIm7dKxDQ1J5bYSGl8mCBYCduQC9tci
         oKQgkveQY6aiRKExaeSONPstmLY0FI/jDVcVovc50HNowcviUKAP6d75AttmGbb+5uRl
         LESds+hDmRKenoErLUuS4lZXDHAx5lB84S3s2w0UlETrpz2ESc79NEXBFxpzjO9k8DTJ
         LMC4ZHF/VwPAQEQ7mDZwYEsziK4x+WGZLUMyILKLGy2TYevjGB4OV7G2Cp6z+ycxhmXr
         +wLUXEd6RZKK1o8g4AtoIIhOwXfmfVls27+0lrISBDQG6WtArCKAMyzcyGgdlpHcZVAX
         buZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686300827; x=1688892827;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hqc7b6Q+g/CohWxFaiQNgMOrW73y4+LWnJE4cKqKUVQ=;
        b=BveQdB96WHiftGR9zbINRxzHsUVocYeKnG6Fk+hRc2KsNUbSDJTipwb9oxl6bdiT4W
         whWe04vlPyhauZuQ6LdBks1dcUchffDSa/w/s+JL7bN3Vmfa2cYfYiM94jAHh45SClLv
         l0VGbmKkwfl71bzhnY1iewkImJHLK3wVD6Y/GRnUJutD2hytbYasjtdNWWjU1QOsffc+
         FwXXkVZ7lLVNRk0lXrWUSskntAapZf8DhVZzhqnJAMSpr1FrU2Ppy5HM29WOeH3S2Pks
         4ueu0NxUp9naxv0pIPWCl421CNH2fcp2o4b7c4Ex78YYAi7j7a3dNONpTh6URhyDziNf
         J+Nw==
X-Gm-Message-State: AC+VfDweLXYauF7zAzzSiz3Z6NYRFstH7bI/08SXGfYj7I+iPD70QHzA
	iOQMdXYRDw9lh+tl2Y0srM508Q==
X-Google-Smtp-Source: ACHHUZ7qZqosiJP9Jkt7v4+WhBbhhZbxgDN9UMFeOJ5MeM8qzrGOivaF1ZgOUnhmsjiTBTGmjg5Hmg==
X-Received: by 2002:a2e:9cc9:0:b0:2b0:2bf6:1448 with SMTP id g9-20020a2e9cc9000000b002b02bf61448mr585354ljj.47.1686300827402;
        Fri, 09 Jun 2023 01:53:47 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id b10-20020a2e988a000000b002ac7a25c001sm306894ljj.24.2023.06.09.01.53.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jun 2023 01:53:47 -0700 (PDT)
Message-ID: <316fd262-eeec-a2a4-cbc1-2c39935be87c@linaro.org>
Date: Fri, 9 Jun 2023 10:53:45 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 1/3] dt-bindings: arm-smmu: Add interconnect for qcom
 SMMUs
Content-Language: en-US
To: Parikshit Pareek <quic_ppareek@quicinc.com>, Will Deacon
 <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Adam Skladowski <a39.skl@gmail.com>, linux-arm-msm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org,
 "linux-kernel @ vger . kernel . org Prasanna Kumar"
 <quic_kprasan@quicinc.com>, Shazad Hussain <quic_shazhuss@quicinc.com>
References: <20230609054141.18938-1-quic_ppareek@quicinc.com>
 <20230609054141.18938-2-quic_ppareek@quicinc.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230609054141.18938-2-quic_ppareek@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9.06.2023 07:41, Parikshit Pareek wrote:
> There are certain SMMUs on qcom SoCs, which need to set interconnect-
> bandwidth, before accessing any MIMO mapped HW registers, and accessing
> RAM during page table walk. Hence introduce the due bindings for
> interconnects.
> 
> Reported-by: Eric Chanudet <echanude@redhat.com>
> Signed-off-by: Parikshit Pareek <quic_ppareek@quicinc.com>
> ---
>  .../devicetree/bindings/iommu/arm,smmu.yaml   | 22 +++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> index ba677d401e24..75e00789d8c2 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> @@ -327,6 +327,28 @@ allOf:
>              - description: interface clock required to access smmu's registers
>                  through the TCU's programming interface.
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              qcom,sa8775p-smmu-500
> +    then:
> +      properties:
> +        interconnects:
This isn't specific to SA8775P.. I believe we could make it SMMU-generic..

> +          minItems: 1
> +          maxItems: 1
> +
> +        interconnect-names:
> +          minItems: 1
> +          items:
> +            - const: tbu_mc
> +
> +        icc_bw:
No underscores in property names.
> +          $ref: /schemas/types.yaml#/definitions/int32
Can't we use OPP tables? They'd also allow for specifying required-opps.

Konrad
> +          description:
> +            An integer expressing the interconnect bandwidth(MBps) to be set.
> +
>    - if:
>        properties:
>          compatible:
