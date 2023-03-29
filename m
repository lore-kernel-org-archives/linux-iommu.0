Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D911865
	for <iommu@lists.linux.dev>; Wed, 29 Mar 2023 08:31:22 +0000 (UTC)
Received: by mail-lf1-f52.google.com with SMTP id c9so8702753lfb.1
        for <iommu@lists.linux.dev>; Wed, 29 Mar 2023 01:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680078680;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1rkqB/pSe/Uf7R42daYkgCUwin72MjNO+JZK0n3K2tQ=;
        b=mK8OljvcAlXLRlURsbzrz8VLrh3qBax49hDLf23vpE/ew2aRk8mDd5l61Y+0vdZzC7
         a3Tvq3BTHwdduf7flFbMdePnsOzr6iACGE6x6vZi72ZeaOygZ58nDSYsNbIgsif6vsBA
         EgNtUmaJWp5zgQaoifJadboHZB0cTxPMnlSR6ugO7N7ICPPn5ZJqFx+ec2ml9dLRaM44
         FYUg5e7ZjdgYbviArSUQbM8dT4KjAHOhbmaMZibdXcer7ok6zvn1vWD7eSeObPlCGrYl
         LtI0pFu8cgB87X2DRgFh7c+pldh0D0uY5nZfWD3ySf54kt/2EY0Xxg1pdSTyNbtMzbPn
         b1ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680078680;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1rkqB/pSe/Uf7R42daYkgCUwin72MjNO+JZK0n3K2tQ=;
        b=zq74EY41crGYaA0V6pwW9V3+BVAK6pJ8d89WwWgmPL5L/ez66yUsFM2ODGf3jar+ai
         GWllYg4/Mm3j/adJXPUnbSvCgTX7zBqkha6CdQdYvmq+sUlPidJ77wFiSPQ+KNKePnEP
         aYxOqforWMMNwyVgDFdLOSidJhanWRJkmgyhyyc9pDQtWIikfhcaRf5saV/1sxATc/Du
         yWGegp54vLwfY6VzeZJ1eHQ1liBuK70jMDZuE+MFKKDk5MxWB67FUoTiccGTRF0zLBUT
         l+v3haBiHtYZn1lV6qUBrXv2G34NdL5F49Op0ajh12QOhN9gyeysepZDAhHK0xlEbty+
         Musw==
X-Gm-Message-State: AAQBX9ddGpSCkVX7LKvEMoiZQwfxjixCGANFPONfzXwbkjLb97wa9434
	50JLL4g6bXL0LFdnz9IHQijovA==
X-Google-Smtp-Source: AKy350aLnZoE3VH5F+C9qZoroickOae9EztGyVhx2T4moZpvdDOO2NmhS3zjPSDiQb1l+vkSWljpNA==
X-Received: by 2002:ac2:5966:0:b0:4e9:d85d:9032 with SMTP id h6-20020ac25966000000b004e9d85d9032mr5581749lfp.54.1680078679782;
        Wed, 29 Mar 2023 01:31:19 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id x6-20020a2e7c06000000b002a5f91380e2sm1030479ljc.84.2023.03.29.01.31.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 01:31:19 -0700 (PDT)
Message-ID: <14688a5c-c50a-4876-e7b7-565b106b431a@linaro.org>
Date: Wed, 29 Mar 2023 10:31:18 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 4/7] dt-bindings: iommu: arm,smmu: enable clocks for
 sa8775p
Content-Language: en-US
To: Bartosz Golaszewski <brgl@bgdev.pl>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>
References: <20230328193632.226095-1-brgl@bgdev.pl>
 <20230328193632.226095-5-brgl@bgdev.pl>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230328193632.226095-5-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/03/2023 21:36, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> The KGSL iommu will require the clocks property to be set. Enable it for
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

Then you need to describe them, like other variants are doing.

Best regards,
Krzysztof

