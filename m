Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED3A1C2D
	for <iommu@lists.linux.dev>; Mon, 23 Jan 2023 13:21:28 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id tz11so30497378ejc.0
        for <iommu@lists.linux.dev>; Mon, 23 Jan 2023 05:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YsXGq+84b3tFva8sx/OXAy3zCE5skYa0ofpr2MBER4c=;
        b=eRDEYhOIGJ103mS6oZnJoO+6Moo0rdjkBf0TOJ5mG0TBUOIxJc/CtJMsqHf7Tn6UuH
         sULITttpVPB4z/TZl9rXOV5TH2C9xOTHn1+1l7IajvYiAjGBhQeFPicvAMZsDe+v2ZXy
         ze6kRY+UwbVsCacMyfFQoCs85JCLULvRBsssHbCUgu8nvfAGuHN9ADc+nAGR6+7b351U
         lVusB2tp+v8OXfrGP2lIQY1AAFlwYo6vmzoVGHg/xOX3cuuZh1rmgGhSYe/yOAXJhqes
         jLuwg5Gqcwr/EmudOw+AaKZtN/saCTd/WXyVp5aVGTbflmbm2O9J+vZQomtTg4YRRlCk
         ObVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YsXGq+84b3tFva8sx/OXAy3zCE5skYa0ofpr2MBER4c=;
        b=PDSe97JSMWB/+68l5VeBjnfBYwL7fClq2G6AOEmmP0axAM/aSKxHYBpjAllavt/W7+
         bCatWjMeKE5KLqrBVGGEJ2H3UuuvcJHdm+RlTuo010jtQ57y5A/1WN7j/B6+IceyoFLQ
         2Z0HOQC+Kb6gsUSYRy6bMTf+nXy6Q8lzlDnHfi5LpCrmXIjPkhoXsvbvU4iuRpYm0WWS
         rCereoo26YTHLVmNwl1LOw4YLHlKQ943YlMry05VF14pqKzht6neiNRKrv3+7c/5LIJW
         VwurCPSd4ecLgirwVa+9AQmmW3xnhE3mdt30+RBghTOhayh6y0AcXZIyD76lEsMqdLTm
         OGOw==
X-Gm-Message-State: AFqh2koF9XQBP4I1ZX94t0zIOyHE5L1Y/eVVSEHVm2rXWJS3USOMSWHC
	vx1N9ijzjVg5mghl5qpKqdCKFQ==
X-Google-Smtp-Source: AMrXdXvoSP7NORFjK/VvrRxhcuHbYeJ42QdKshHQmbhms89pHQrdDseSM67icmPAtdDWwLKfJneaAw==
X-Received: by 2002:a17:907:cc03:b0:7c4:f8fb:6a27 with SMTP id uo3-20020a170907cc0300b007c4f8fb6a27mr34065026ejc.0.1674480086417;
        Mon, 23 Jan 2023 05:21:26 -0800 (PST)
Received: from [192.168.1.101] (abxi24.neoplus.adsl.tpnet.pl. [83.9.2.24])
        by smtp.gmail.com with ESMTPSA id p8-20020a17090653c800b00872c0bccab2sm9742043ejo.35.2023.01.23.05.21.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 05:21:26 -0800 (PST)
Message-ID: <8d07ba5e-6354-c2ba-bd09-5f8169732b55@linaro.org>
Date: Mon, 23 Jan 2023 14:21:24 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 3/3] ARM: dts: qcom: sdx65: Add Qcom SMMU-500 as the
 fallback for IOMMU node
Content-Language: en-US
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 andersson@kernel.org, will@kernel.org, joro@8bytes.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 dmitry.baryshkov@linaro.org, stable@vger.kernel.org
References: <20230123131931.263024-1-manivannan.sadhasivam@linaro.org>
 <20230123131931.263024-4-manivannan.sadhasivam@linaro.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230123131931.263024-4-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 23.01.2023 14:19, Manivannan Sadhasivam wrote:
> SDX65 uses the Qcom version of the SMMU-500 IP. So use "qcom,smmu-500"
> compatible as the fallback to the SoC specific compatible.
> 
> Cc: <stable@vger.kernel.org> # 5.19
> Fixes: 98187f7b74bf ("ARM: dts: qcom: sdx65: Enable ARM SMMU")
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm/boot/dts/qcom-sdx65.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom-sdx65.dtsi
> index b073e0c63df4..408c4b87d44b 100644
> --- a/arch/arm/boot/dts/qcom-sdx65.dtsi
> +++ b/arch/arm/boot/dts/qcom-sdx65.dtsi
> @@ -455,7 +455,7 @@ pil-reloc@94c {
>  		};
>  
>  		apps_smmu: iommu@15000000 {
> -			compatible = "qcom,sdx65-smmu-500", "arm,mmu-500";
> +			compatible = "qcom,sdx65-smmu-500", "qcom,smmu-500", "arm,mmu-500";
>  			reg = <0x15000000 0x40000>;
>  			#iommu-cells = <2>;
>  			#global-interrupts = <1>;
