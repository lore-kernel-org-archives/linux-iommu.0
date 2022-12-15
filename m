Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE43190
	for <iommu@lists.linux.dev>; Thu, 15 Dec 2022 15:10:51 +0000 (UTC)
Received: by mail-lf1-f48.google.com with SMTP id bp15so16074992lfb.13
        for <iommu@lists.linux.dev>; Thu, 15 Dec 2022 07:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=petCtMT6h9gBTrPqM4wSXPuKYj7TltVBXvRJZq1Vl4A=;
        b=wxAxGHVqRSAWNyWfmK7P70u9SxsXJSH1r5fH7taXrSq+Rfu6lZsny9oPYIOPs8dfUI
         Au5EXXc7iW4c4KkVhWpjHc0/brvLjJ5i2+OG2OBKvIhvzP24oce4CpugSmER6l54FebS
         7W1RwoY/HEFeVHT0lyCyC2RZuR+XSsYgDB+sHt2UWdcBiKMWcT4IA6x6bvN72p29Hdgg
         krpL0Fr8Y+DroU3qi9xpQHisGZfOcIBstLZ2jXAClrCKcOPF+xZ3P9Qdx8c/UN7BJ78P
         VwJ0NyhO1g2gQjnvd6Tuc3hd/sY0p7OhuMy04LH2xjvkjAqomlNP/VnfiEL2sRdNMwMi
         Tbdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=petCtMT6h9gBTrPqM4wSXPuKYj7TltVBXvRJZq1Vl4A=;
        b=y7A/v3xao16Hv7irdMgRqRC/wXTRFwegN6Ji95oBJZ9tRJz4VZ4/SFV0YfFq6zIzS3
         KdUGrpo6ePAOImsy/s+F9qkG1+O+t1Wt6F8XJCYfZTbGUcklHu6W8RU8IR64tMyf91MU
         gz1XIAF/TI6SyxQTVaPT5EnYWqRP9OPP3xsYN9M9MHcA/Rht3qJeKXiC9FVktCzIef19
         8ZV+rohVX+/Nt94NYgiqrQTe+iA9W3hUiei6wuX6lr2/ZGaTKcHzwoNQ1SBx/WM27Q2E
         OJxrrPBp23fAWjv9s1x1U0YBf1Xo8jrn1EtsJKI+EACXEd00OW4znos6bg0zo1A4Dajc
         NJVQ==
X-Gm-Message-State: ANoB5pnJ/rF7w/gkmfDEK0XEK3SRttfhfhx7426LK0WBDQet+u9i3Aea
	oTdtF5BlPvC2IDuSmGT068cAgA==
X-Google-Smtp-Source: AA0mqf4mYmzjbcewsbtx2GMO4Z0urxIS7tt5k3wtucHMuRDUfjlTrJFPUq3Rj8Jakr44QpceqaDxVw==
X-Received: by 2002:ac2:4e4e:0:b0:4a4:68b9:608a with SMTP id f14-20020ac24e4e000000b004a468b9608amr6993443lfr.21.1671117049557;
        Thu, 15 Dec 2022 07:10:49 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id w5-20020a05651234c500b004b0b131453csm1183121lfr.49.2022.12.15.07.10.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Dec 2022 07:10:48 -0800 (PST)
Message-ID: <9e94c0b9-f901-5ac9-2abb-40e958cbe5a2@linaro.org>
Date: Thu, 15 Dec 2022 17:10:48 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v5 5/8] iommu/arm-smmu-qcom: Add SM6115 support
Content-Language: en-GB
To: Iskren Chernev <iskren.chernev@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc: phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 Adam Skladowski <a39.skl@gmail.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Konrad Dybcio <konrad.dybcio@somainline.org>,
 Sai Prakash Ranjan <quic_saipraka@quicinc.com>, Emma Anholt
 <emma@anholt.net>, Rob Clark <robdclark@chromium.org>,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20221030094258.486428-1-iskren.chernev@gmail.com>
 <20221030094258.486428-6-iskren.chernev@gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221030094258.486428-6-iskren.chernev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30/10/2022 11:42, Iskren Chernev wrote:
> From: Adam Skladowski <a39.skl@gmail.com>
> 
> Add the Qualcomm SM6115 platform to the list of compatible,
> this target uses MMU500 for both APSS and GPU.
> 
> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
> Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>

This needs to rebased on linux-next (or 6.2-rc1 once it's out).

> ---
>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index b2708de25ea3..526fec79b4fe 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -432,6 +432,7 @@ static const struct of_device_id __maybe_unused qcom_smmu_impl_of_match[] = {
>   	{ .compatible = "qcom,sc8280xp-smmu-500" },
>   	{ .compatible = "qcom,sdm630-smmu-v2" },
>   	{ .compatible = "qcom,sdm845-smmu-500" },
> +	{ .compatible = "qcom,sm6115-smmu-500" },
>   	{ .compatible = "qcom,sm6125-smmu-500" },
>   	{ .compatible = "qcom,sm6350-smmu-500" },
>   	{ .compatible = "qcom,sm6375-smmu-500" },

-- 
With best wishes
Dmitry

