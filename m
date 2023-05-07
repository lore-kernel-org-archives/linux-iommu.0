Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662AF1C04
	for <iommu@lists.linux.dev>; Sun,  7 May 2023 08:19:19 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-956ff2399c9so632148166b.3
        for <iommu@lists.linux.dev>; Sun, 07 May 2023 01:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683447557; x=1686039557;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AmspFl/qcrUH5DUFKPFejz2sbTyU5nmTsYvZW5M2EaQ=;
        b=IIB3tnM8iSk7+xLeoUFp6dbaAhKrnsZxTyDQTCE+XEzeYtpSAVNL36PF4++K0wmSzJ
         GnIqJJzw0bnxIsDHk6hT+NlyQGf+sapJGylBIUXJUdJO0DZeH1s2iEDBKBHQTsUyCokg
         N+sc6dFjeilgxW3KC/FAVa58V4ILCKQC8AFKshQ6h5whWceVlAc7iEVS+Mq7Fo00hlU5
         qtu9n7bmmKhfln8OB5myFlbUcUdLLyLt2HMJzIpMWegQfLBN+A70yeqwTAZGcKknoFvO
         TnUZdEUkELul9W/Pl8KtMmsFBMfV7KPK4Nka+HFDtJH4Y3aH+23vASb/huPAJKEqgeOD
         UpOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683447557; x=1686039557;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AmspFl/qcrUH5DUFKPFejz2sbTyU5nmTsYvZW5M2EaQ=;
        b=D0hiI3d84FLWm9I5tKRrFXmEaAAnjE23KWQF3QOrOtKHHT8+p0uvW9DIvHBjOx9SFA
         HFn0cU6MKjh2VcaoDOQ83dxmJVvGWvwpg5nVz4N4NM+cCaVCoWl68AU3Wr+e1N9ov8nq
         FdJ5HOa/yPMA/XrOd30To4tcpklZDdXgk7qb+1zKokdi/ZVzLrjpoO5P9UQr3uCUmF4c
         N4U4GfJcOk3tYTVu6BAfQrRUVcTLgMVbf9KHMR5bbg49QfMgn/Qxc5Y3ODoCwy2XBsuj
         8FNvuzFG4oqbAX6Uz3M8ypIaMIo51UANJW5Nh1HCTGYnxZzXu/IBffeLWkaloQ8Dsamh
         dUkg==
X-Gm-Message-State: AC+VfDy5AYTKsccSR9YavDNFFvJ/uJMpjkWszkp1ZO5oKqF5I+3dDKb6
	y2xNCcg7shN11DhcUF1eGwhUUQ==
X-Google-Smtp-Source: ACHHUZ7VKQzOW+S0ssTzMGK+ru9aMnpaJYX1bc4BHHGSsy+EFj9PX/kcenbTWjQXmlp0f8u2kphtKw==
X-Received: by 2002:a17:907:c1e:b0:94a:4107:3975 with SMTP id ga30-20020a1709070c1e00b0094a41073975mr5824210ejc.76.1683447557500;
        Sun, 07 May 2023 01:19:17 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:183b:950f:b4d5:135a? ([2a02:810d:15c0:828:183b:950f:b4d5:135a])
        by smtp.gmail.com with ESMTPSA id oy10-20020a170907104a00b00965f76318b1sm2590673ejb.201.2023.05.07.01.19.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 May 2023 01:19:16 -0700 (PDT)
Message-ID: <80b46fcb-d6d0-1998-c273-5401fa924c7d@linaro.org>
Date: Sun, 7 May 2023 10:19:15 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v3 04/12] dt-bindings: display/msm: Add SM6350 MDSS
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Clark
 <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>, Will Deacon
 <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev
References: <20230411-topic-straitlagoon_mdss-v3-0-9837d6b3516d@linaro.org>
 <20230411-topic-straitlagoon_mdss-v3-4-9837d6b3516d@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230411-topic-straitlagoon_mdss-v3-4-9837d6b3516d@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/05/2023 23:40, Konrad Dybcio wrote:
> Document the SM6350 MDSS.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  .../bindings/display/msm/qcom,sm6350-mdss.yaml     | 214 +++++++++++++++++++++
>  1 file changed, 214 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm6350-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm6350-mdss.yaml
> new file mode 100644
> index 000000000000..6674040d2172
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/msm/qcom,sm6350-mdss.yaml
> @@ -0,0 +1,214 @@
> +# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/msm/qcom,sm6350-mdss.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm SM6350 Display MDSS
> +
> +maintainers:
> +  - Krishna Manikandan <quic_mkrishn@quicinc.com>
> +
> +description:
> +  SM6350 MSM Mobile Display Subsystem (MDSS), which encapsulates sub-blocks
> +  like DPU display controller, DSI and DP interfaces etc.
> +
> +$ref: /schemas/display/msm/mdss-common.yaml#
> +
> +properties:
> +  compatible:
> +    items:

Drop items

> +      - const: qcom,sm6350-mdss
> +

The Rob's bot warning can be ignored - it seems patch #1 was not applied.


Best regards,
Krzysztof

