Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 267ECC433FE
	for <iommu@archiver.kernel.org>; Wed,  1 Dec 2021 12:10:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A12B9400FB;
	Wed,  1 Dec 2021 12:10:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Z5wOi21Cp0fg; Wed,  1 Dec 2021 12:10:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3C330400D1;
	Wed,  1 Dec 2021 12:10:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1370BC001C;
	Wed,  1 Dec 2021 12:10:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 89BB1C000A
 for <iommu@lists.linux-foundation.org>; Wed,  1 Dec 2021 12:10:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6928840958
 for <iommu@lists.linux-foundation.org>; Wed,  1 Dec 2021 12:10:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qV1KBqNBg1W9 for <iommu@lists.linux-foundation.org>;
 Wed,  1 Dec 2021 12:10:47 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 108BF4090B
 for <iommu@lists.linux-foundation.org>; Wed,  1 Dec 2021 12:10:46 +0000 (UTC)
Received: by mail-lj1-x22e.google.com with SMTP id e11so47607299ljo.13
 for <iommu@lists.linux-foundation.org>; Wed, 01 Dec 2021 04:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=W0kJqyc37bbbHViV4LcHXw2CKa8FmCmhGKxmED2s2So=;
 b=Gz4woK5qr89jZnNUbBzcuc4OBBIlQlajz9n0JOB+7qcmDsbz2IPy77u22ioWewcu66
 jTY1b9ePZcLJUJQaXPChclUHPMcEUze543NNmKGjnZ1n+O93O6UGBJ1l1MtusAt2RAuF
 Ge+x/9WgvRMettMLrV3VyHIr2f6zw/YmAQDJ4spX4RpCv44GHWJC2ems7NnTtJUPVC2J
 d/usnpa1KlTGk4Sf9EOzsv35z1ZFHmwY8d214lFM+LtV7EkwZ1lAI/MAHaWzmeWVfQTL
 8uTRYySxoEqwn2D6rrzHODPcayrhM5P8QFwO94jRxSol5tD2Sh5BjJN93+bLTSxoQdbX
 r0iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=W0kJqyc37bbbHViV4LcHXw2CKa8FmCmhGKxmED2s2So=;
 b=rt5hAdNryxVeXxNlO4BaGgJijUwgHr8RqLxKjZBB8h8aqRFxEXmpiwTO6YN6zvtR9S
 UdtU9iwS5/CjDwVK5DYv4n/iAUpmdrLtWi4zr/1vlwEXJg5o2uiBWFKbfYaKqNEuSkYq
 0d3HCFaTQB0WcApqWB60cyVLxmJEmo9eUbiq+L2xQl+3h6Qc3tkaHuQ9T4tIPk2KQTOu
 6ISt0IqH+gWqm/AkGb/M5vQ+EMe3oK2Xjtgn6L3lKVs9w+GtKh/tazA/XQwVT2uCkKMS
 hQgerjlYTZlww29VUn4NrRIELJxgEja8IkNJEQgs1/tQY2Syy3S5GvZ3Yqn81MGj/MA3
 YXLw==
X-Gm-Message-State: AOAM532Mm6+c7RP22WLnlgg1uJmClZgawnOh+zMqqnHYsF0O/+1k5zdb
 MVqqCwTZNEU8su/FI8g9gSfgzg==
X-Google-Smtp-Source: ABdhPJyEF2qyDbLNDxQhbZ+6mREN6XM1DNbXus3stsaBmnyvAW/BQzFn0OsHD1jEXT6eWF/8qPCQyg==
X-Received: by 2002:a2e:bc24:: with SMTP id b36mr5387099ljf.54.1638360644835; 
 Wed, 01 Dec 2021 04:10:44 -0800 (PST)
Received: from [192.168.1.211] ([37.153.55.125])
 by smtp.gmail.com with ESMTPSA id a7sm2090907lfr.204.2021.12.01.04.10.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Dec 2021 04:10:44 -0800 (PST)
Subject: Re: [PATCH 2/2] iommu: arm-smmu-impl: Add SM8450 qcom iommu
 implementation
To: Vinod Koul <vkoul@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>
References: <20211201073943.3969549-1-vkoul@kernel.org>
 <20211201073943.3969549-3-vkoul@kernel.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Message-ID: <eaf8f0f2-2c12-f01d-36b8-165859a5487a@linaro.org>
Date: Wed, 1 Dec 2021 15:10:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211201073943.3969549-3-vkoul@kernel.org>
Content-Language: en-GB
Cc: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 01/12/2021 10:39, Vinod Koul wrote:
> Add SM8450 qcom iommu implementation to the table of
> qcom_smmu_impl_of_match table which brings in iommu support for
> SM8450 SoC
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>

Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


> ---
>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index ca736b065dd0..4aee83330629 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -415,6 +415,7 @@ static const struct of_device_id __maybe_unused qcom_smmu_impl_of_match[] = {
>   	{ .compatible = "qcom,sm8150-smmu-500" },
>   	{ .compatible = "qcom,sm8250-smmu-500" },
>   	{ .compatible = "qcom,sm8350-smmu-500" },
> +	{ .compatible = "qcom,sm8450-smmu-500" },
>   	{ }
>   };
>   
> 


-- 
With best wishes
Dmitry
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
