Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A296108
	for <iommu@lists.linux.dev>; Mon,  9 Jan 2023 18:10:30 +0000 (UTC)
Received: by mail-lf1-f50.google.com with SMTP id f34so14236998lfv.10
        for <iommu@lists.linux.dev>; Mon, 09 Jan 2023 10:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z3JsIjoi2dFk770K4E7Cc6+bvqTHzQJvboduENfqJDY=;
        b=po91acebuAvy/xot5kHoF4OPolKB3textI1oiX6y8CDEHm3m7spk2rSBHSHP/wOzzx
         SaJ0a69VpJ+awHAM/0EyVUqdNhHg8DFCrfHoMoglseOH6lJxgJ2iOH8Ejm/TaJNlnUfh
         nV7aCd4vhT/R9xqno+syxGWrwXUlVfjxJGPmp7I5/hMsR8JV3X9xja4nqeMpSCrYXG7o
         4T7fExOMO3by+aAZ7jJc38p7Bz5EPtwIakfjYtOHl74nwzYhz+JiZirkqtKKLe46GRcf
         Z5Re4jSmxx+3nbNc8gXDgZmeDhyEzvjnGtbB1Q74pKZWBPPUAZMiXZIZRpIcQcXZo3P8
         pavQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z3JsIjoi2dFk770K4E7Cc6+bvqTHzQJvboduENfqJDY=;
        b=j2qo3IrFuWjGe84BCx1S2pBwC2SN9ZkYb4MbTirh19tW3Ne6bO+IANEDETFkB0qfQg
         3BgHkiKa3WyELBDUih0d2eShxiL5n3GAa4H74FiOh7pR+3crFWRBvPIVAOFkV7QNu51K
         gbNtsHiP5FPtLcYXch1JG1noY1mrtetcjBm3mnLdDd58sga48etYDojBALP71BQaK8gY
         qOnYiRvxXiY6AgD74H6CHPDltly9lSALH1PaFazG/vBwQEBbgDj/L4Dmh4ZPSp2YrXOE
         BHZIyiQrnLDJAgvGsYYBVBVeQ2GC5UiYCP6FjX7w6UOV0oCPrN1lMewvpPxa+FZI7u1S
         KJCg==
X-Gm-Message-State: AFqh2kqtv3EV2AjRHtUcfo8jllhfsQC5gkVLGL/MHV4AfI3pgfqs1RYZ
	wyk3rnRBxt048LXTocplDUTAQw==
X-Google-Smtp-Source: AMrXdXva6mNB/kyj8xZBHoSj3xleh1LF7x+HCVy6uO5GijSB7MF6YlZ626gg7/Cu2pQeZV5Ni5We3A==
X-Received: by 2002:ac2:46d1:0:b0:4cb:1fa4:f68d with SMTP id p17-20020ac246d1000000b004cb1fa4f68dmr9302557lfo.18.1673287826433;
        Mon, 09 Jan 2023 10:10:26 -0800 (PST)
Received: from [192.168.1.101] (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id n11-20020a05651203eb00b004b58d457f2dsm1731581lfq.61.2023.01.09.10.10.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 10:10:24 -0800 (PST)
Message-ID: <863ca113-cf78-1844-d0be-e21915ef662f@linaro.org>
Date: Mon, 9 Jan 2023 19:10:21 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 16/18] iommu: arm-smmu: qcom: add support for sa8775p
Content-Language: en-US
To: Bartosz Golaszewski <brgl@bgdev.pl>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Georgi Djakov <djakov@kernel.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Manivannan Sadhasivam <mani@kernel.org>,
 Jassi Brar <jassisinghbrar@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Vinod Koul <vkoul@kernel.org>, Alex Elder <elder@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, linux-gpio@vger.kernel.org, netdev@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230109174511.1740856-1-brgl@bgdev.pl>
 <20230109174511.1740856-17-brgl@bgdev.pl>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230109174511.1740856-17-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9.01.2023 18:45, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Extend the driver to support the sa8775p platform.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index 91d404deb115..5e12742fcfd9 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
/*
 * Do not add any more qcom,SOC-smmu-500 entries to this list, unless they need
 * special handling and can not be covered by the qcom,smmu-500 entry.
 */
> @@ -500,6 +500,7 @@ static const struct of_device_id __maybe_unused qcom_smmu_impl_of_match[] = {
>  	{ .compatible = "qcom,msm8998-smmu-v2", .data = &qcom_smmu_v2_data },
>  	{ .compatible = "qcom,qcm2290-smmu-500", .data = &qcom_smmu_500_impl0_data },
>  	{ .compatible = "qcom,qdu1000-smmu-500", .data = &qcom_smmu_500_impl0_data  },
> +	{ .compatible = "qcom,sa8775p-smmu-500", .data = &qcom_smmu_500_impl0_data },
>  	{ .compatible = "qcom,sc7180-smmu-500", .data = &qcom_smmu_500_impl0_data },
>  	{ .compatible = "qcom,sc7280-smmu-500", .data = &qcom_smmu_500_impl0_data },
>  	{ .compatible = "qcom,sc8180x-smmu-500", .data = &qcom_smmu_500_impl0_data },

Document the property in bindings and follow it by "qcom,smmu-500", "arm,mmu-500"
instead.

Konrad
