Return-Path: <SRS0=tLZ8=KU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5427C47084
	for <iommu@archiver.kernel.org>; Tue, 25 May 2021 04:05:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86046613D2
	for <iommu@archiver.kernel.org>; Tue, 25 May 2021 04:05:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86046613D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4EAB660762;
	Tue, 25 May 2021 04:05:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oALn8ko65RSN; Tue, 25 May 2021 04:05:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 506776066F;
	Tue, 25 May 2021 04:05:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2879CC000E;
	Tue, 25 May 2021 04:05:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 69387C0001
 for <iommu@lists.linux-foundation.org>; Tue, 25 May 2021 04:05:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5751D6066F
 for <iommu@lists.linux-foundation.org>; Tue, 25 May 2021 04:05:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VXJkrCwDCe6A for <iommu@lists.linux-foundation.org>;
 Tue, 25 May 2021 04:05:19 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9B22760636
 for <iommu@lists.linux-foundation.org>; Tue, 25 May 2021 04:05:19 +0000 (UTC)
Received: by mail-oi1-x22f.google.com with SMTP id s19so29067945oic.7
 for <iommu@lists.linux-foundation.org>; Mon, 24 May 2021 21:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=omc7Lbht3vsFqQrJHKPy+phsOveVTMec9psAq7xUFRs=;
 b=lW+ENjoppyZF+M3teNJqDMhEM4jS7ukPBgTud4oBZ9PjDHRDiw/ZalyLv3P7S1t/dW
 GsxOszVqbzg66xOE12z9mRNUAgBKAgXjLlB93kLAxVcw3iU+vyMZZyNlQn8W0DrcgMld
 P0L5+d5+zKJu5uUZzjiB3pxtUXdH016j5DdHQm92AsU9kzotvHyXUZbeOBCUX2JRzeRl
 RWFH/Ae1ePShA4IlZjvuVTRnC7lPGBtWon0Zpm3PCpir6h42m5sMvpe3k20l3p1+jTgU
 dTE2lAD2CKtu9e9aMWj6fhemH8xeo5e+HedHj8KbrSe/3n0Y7XJbWkz+cABGLpdo7G9D
 6vMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=omc7Lbht3vsFqQrJHKPy+phsOveVTMec9psAq7xUFRs=;
 b=g6yhWLfBBxuGvyWiusKSIoFe7fvRum2FIOFt1nezovXqhyWC9vgRLn3CPoknpVs6kl
 0JEugcrgMbRI18IZA0UTMCHp/9ERUsRjHl9fpjjx7YUaXtLDcKD/B3UqpInH/V5KEBf1
 K+wI4aPs5pjcHqLg9MrAfxoex4x5rrKBDAR8ITLY5xZZmjOzwOBqFJ+46Hn1O0DRsXDN
 mrofB7ZYtblFQWFjMkAt4l5Nhm5beb05IRK+AyLD9N//bvyjNeHaNnZV63fAMGh3Yjpb
 73faYiekNFquoZZ2974WfUlfWgp5VLkBzvXMNrWlkA7QNgbaR6oEKm2FZqvVCD5sDT8w
 NKjw==
X-Gm-Message-State: AOAM531nTx223hn4XQnBrdWVuUG7k71LgMb4NUkoZRWv+aF/hu+jOSoW
 /ApFSF/We3dmVtS1LVZKgXSQAQ==
X-Google-Smtp-Source: ABdhPJyof/NZ4txSI58nh7ZFjrxTbmlqvpY83qtBXTXzytVbcaY/hbiBaivTbN/C5bYEqngzrFImeg==
X-Received: by 2002:a05:6808:d47:: with SMTP id
 w7mr12999594oik.104.1621915518726; 
 Mon, 24 May 2021 21:05:18 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net.
 [104.57.184.186])
 by smtp.gmail.com with ESMTPSA id r124sm3038199oig.38.2021.05.24.21.05.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 May 2021 21:05:18 -0700 (PDT)
Date: Mon, 24 May 2021 23:05:16 -0500
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Martin Botka <martin.botka@somainline.org>
Subject: Re: [PATCH V2] iommu: arm-smmu-qcom: Add sm6125 compatible
Message-ID: <YKx3fHytiRkLXUW/@yoga>
References: <20210523212535.740979-1-martin.botka@somainline.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210523212535.740979-1-martin.botka@somainline.org>
Cc: Rob Clark <robdclark@chromium.org>, Will Deacon <will@kernel.org>,
 konrad.dybcio@somainline.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, John Stultz <john.stultz@linaro.org>,
 ~postmarketos/upstreaming@lists.sr.ht,
 angelogioacchino.delregno@somainline.org, marijn.suijten@somainline.org,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Sun 23 May 16:25 CDT 2021, Martin Botka wrote:

> Add compatible for SM6125 SoC
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

But please, don't forget to update the dt-binding.

Regards,
Bjorn

> Signed-off-by: Martin Botka <martin.botka@somainline.org>
> ---
> Changes in V2:
> Add commit description
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index 98b3a1c2a181..7455bcc92f43 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -333,6 +333,7 @@ static const struct of_device_id __maybe_unused qcom_smmu_impl_of_match[] = {
>  	{ .compatible = "qcom,sc8180x-smmu-500" },
>  	{ .compatible = "qcom,sdm630-smmu-v2" },
>  	{ .compatible = "qcom,sdm845-smmu-500" },
> +	{ .compatible = "qcom,sm6125-smmu-500" },
>  	{ .compatible = "qcom,sm8150-smmu-500" },
>  	{ .compatible = "qcom,sm8250-smmu-500" },
>  	{ .compatible = "qcom,sm8350-smmu-500" },
> -- 
> 2.31.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
