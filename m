Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850153205
	for <iommu@lists.linux.dev>; Mon,  3 Apr 2023 20:41:29 +0000 (UTC)
Received: by mail-ot1-f53.google.com with SMTP id x8-20020a9d3788000000b0069f922cd5ceso16330391otb.12
        for <iommu@lists.linux.dev>; Mon, 03 Apr 2023 13:41:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680554488;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z9C/3hBrTR7K2nHN4gC1rv1X/TFSh2EbFRlM3X5whh8=;
        b=HpiavjE7301uoZjtKHmfZXdD/pxRutwC4Hu519054idDtyzM0BIvcq3FHCOjmwv5VQ
         FcO/aDYqkTJe3TMxv+oe96TvKyWo/knM8YR1vrVVdPBBzUr0jgmp7S0sMRYbbbObr3h/
         V0/jws+hyrf/0UPjHT1isRLJ3Gwv31pe4/L/BsQ3vKOFDw4FPgWvNLk75iSawLCqvlDf
         My9bKj4IhMl/g99EKC8rpOzHx/zXbaUNt3Hyc0a1S+E2KbMDj56OV+RErGA1AeyzwadT
         He2Dsl7LrPJA+MwRVPduvAw27KfkG6QJsfOUufJuUvZCY14iMfYaWbwlYe2wHRW9Exzb
         apYw==
X-Gm-Message-State: AAQBX9efEiDcLWHlm7jd1+5RFJRMRnzlqgIydmSCmayg00paPYX4EHRe
	ntzQPxyxVwxT6LB2ySnnQ/+p53j1Lg==
X-Google-Smtp-Source: AKy350bLaMZm4zgOYFd0dWu6aGZldut/svNiHGH7Kc2jWFeeDzQmIG9nsGYpwa5jcpaQGkCUr2yC+Q==
X-Received: by 2002:a05:6830:571:b0:6a1:2a17:16f2 with SMTP id f17-20020a056830057100b006a12a1716f2mr8533665otc.1.1680554488633;
        Mon, 03 Apr 2023 13:41:28 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z1-20020a9d7a41000000b006a144b97e73sm4629237otm.74.2023.04.03.13.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 13:41:28 -0700 (PDT)
Received: (nullmailer pid 1710521 invoked by uid 1000);
	Mon, 03 Apr 2023 20:41:27 -0000
Date: Mon, 3 Apr 2023 15:41:27 -0500
From: Rob Herring <robh@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 4/7] dt-bindings: iommu: arm,smmu: enable clocks for
 sa8775p
Message-ID: <20230403204127.GA1708388-robh@kernel.org>
References: <20230328193632.226095-1-brgl@bgdev.pl>
 <20230328193632.226095-5-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328193632.226095-5-brgl@bgdev.pl>

On Tue, Mar 28, 2023 at 09:36:29PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> The KGSL iommu will require the clocks property to be set. Enable it for

Isn't KGSL the name for QCom's adreno vendor driver? What does that have 
to do with bindings?

> sa8775p in the bindings.
> 
> Cc: Will Deacon <will@kernel.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> index 807cb511fe18..74d5164ed1e8 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> @@ -375,7 +375,6 @@ allOf:
>                - nvidia,smmu-500
>                - qcom,qcm2290-smmu-500
>                - qcom,qdu1000-smmu-500
> -              - qcom,sa8775p-smmu-500
>                - qcom,sc7180-smmu-500
>                - qcom,sc8180x-smmu-500
>                - qcom,sc8280xp-smmu-500
> -- 
> 2.37.2
> 
