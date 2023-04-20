Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1385A946F
	for <iommu@lists.linux.dev>; Thu, 20 Apr 2023 22:50:23 +0000 (UTC)
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-4ec81245ae1so988326e87.0
        for <iommu@lists.linux.dev>; Thu, 20 Apr 2023 15:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682031021; x=1684623021;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=68FCGKUyFaiFbG/iXo9yWgITnRfiZGq9Rg8NWDS09CU=;
        b=Hm9MQY+d3zWJ8HGp6gmLD/00DgcjBJwatAr7+3XYRS59EtbFDERsBX8/Ks3EPh6BG3
         fQgoE2PFsLatuu5MA9UVvUlYPHKCcdjQ8E6SrVHzXj4Qs1mMw1EkHdacE/NdiUh8tfL5
         LAKAHQABx64AXh8gWtXf1KIQFq1tsUa9uQY9PFxebAD67U7c5bHoSUbUc/Bn1jQDbS9n
         Qf/iewahUJEDdjqzt+IFOixdGJwc2vN7gAfzL1LA7fLqCYA95/RQaLb5JvrgzBC1AH9K
         OO0+VY1ADaQmiqr7YH+tv2T84hDNPMSaCgIKwTazyvmrQlot1YlBbzgv+pnfUckh3UJS
         h3Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682031021; x=1684623021;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=68FCGKUyFaiFbG/iXo9yWgITnRfiZGq9Rg8NWDS09CU=;
        b=BLVGTopVe6lQWNvSmN3WrHeilo0cBzGEc9T9aMD7HieRRMy5FV3ENIL2vXwEVEtdJV
         gzt1+Sy0/oOufHxhbt2/4VAU+z5l33GqOAeLExC1c0senxwZEaCP0vkqprQS6cODD7SM
         DieABjJ6rFUdXU148ZrVSBtL1r14lwRHNIJr1WzFJOqCQU3TAsEMZhMMjJw6ea0U0pMu
         a1mDp7iT/7fN+Diduy5P4ayq4sU7ZNg2qAgrus19l2sdkrZxGRGgl6RKCbPtI0e01OfU
         ZmLkruLBkdfLrcN9Hwh+56I1m3BT2iZb5+W/vbcsM8TLp2A7YDBQrNTZAjpDZxkJJdvQ
         SGgg==
X-Gm-Message-State: AAQBX9dEe4zEbcgf56MOF+TVzT/lDLNcYqhjAd++bCuefsHW7aL/v2Iw
	J93/yQbmgk6lESk6hYnMkCgQyw==
X-Google-Smtp-Source: AKy350a7P9jnq3r/leHVLSe7itJb11Vk9eHPCVoGdSGTSX6RhfhyYLjGpLCW3dojQzCUqmMeF0OUDQ==
X-Received: by 2002:ac2:5a4a:0:b0:4d7:ccef:6b52 with SMTP id r10-20020ac25a4a000000b004d7ccef6b52mr817486lfn.39.1682031021097;
        Thu, 20 Apr 2023 15:50:21 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id o14-20020a2e730e000000b002a8d41c8ebdsm404990ljc.122.2023.04.20.15.50.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 15:50:20 -0700 (PDT)
Message-ID: <26832d5c-f55c-1dd0-947a-0278bcbf08de@linaro.org>
Date: Fri, 21 Apr 2023 01:50:20 +0300
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 10/13] drm/msm: mdss: Add SM6375 support
Content-Language: en-GB
To: Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Clark
 <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>, Will Deacon
 <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev
References: <20230411-topic-straitlagoon_mdss-v2-0-5def73f50980@linaro.org>
 <20230411-topic-straitlagoon_mdss-v2-10-5def73f50980@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230411-topic-straitlagoon_mdss-v2-10-5def73f50980@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/04/2023 01:31, Konrad Dybcio wrote:
> Add support for MDSS on SM6375.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/gpu/drm/msm/msm_mdss.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
> index 4e3a5f0c303c..f2470ce699f7 100644
> --- a/drivers/gpu/drm/msm/msm_mdss.c
> +++ b/drivers/gpu/drm/msm/msm_mdss.c
> @@ -546,6 +546,15 @@ static const struct msm_mdss_data sm6350_data = {
>   	.highest_bank_bit = 1,
>   };
>   
> +static const struct msm_mdss_data sm6375_data = {
> +	.ubwc_version = UBWC_2_0,
> +	.ubwc_dec_version = UBWC_2_0,
> +	.ubwc_swizzle = 6,
> +	.ubwc_static = 0x1e,
> +	/* Possibly 0 for LPDDR3 */
> +	.highest_bank_bit = 1,
> +};

Nit: we can use sm6350 data here, can't we?

> +
>   static const struct msm_mdss_data sm8150_data = {
>   	.ubwc_version = UBWC_3_0,
>   	.ubwc_dec_version = UBWC_3_0,
> @@ -580,6 +589,7 @@ static const struct of_device_id mdss_dt_match[] = {
>   	{ .compatible = "qcom,sc8280xp-mdss", .data = &sc8280xp_data },
>   	{ .compatible = "qcom,sm6115-mdss", .data = &sm6115_data },
>   	{ .compatible = "qcom,sm6350-mdss", .data = &sm6350_data },
> +	{ .compatible = "qcom,sm6375-mdss", .data = &sm6375_data },
>   	{ .compatible = "qcom,sm8150-mdss", .data = &sm8150_data },
>   	{ .compatible = "qcom,sm8250-mdss", .data = &sm8250_data },
>   	{ .compatible = "qcom,sm8350-mdss", .data = &sm8250_data },
> 

-- 
With best wishes
Dmitry

