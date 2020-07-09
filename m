Return-Path: <SRS0=szPT=AU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDEA1C433DF
	for <iommu@archiver.kernel.org>; Thu,  9 Jul 2020 04:42:59 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B115220674
	for <iommu@archiver.kernel.org>; Thu,  9 Jul 2020 04:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n+SHRE9U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B115220674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 827FF89537;
	Thu,  9 Jul 2020 04:42:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id etIZWl8Y7f-Z; Thu,  9 Jul 2020 04:42:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id D14E089511;
	Thu,  9 Jul 2020 04:42:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C064FC0865;
	Thu,  9 Jul 2020 04:42:58 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 25633C016F
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jul 2020 04:42:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 390842154A
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jul 2020 04:42:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ONxpPp-NgOyC for <iommu@lists.linux-foundation.org>;
 Thu,  9 Jul 2020 04:42:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com
 [209.85.214.193])
 by silver.osuosl.org (Postfix) with ESMTPS id 86A5E204CE
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jul 2020 04:42:53 +0000 (UTC)
Received: by mail-pl1-f193.google.com with SMTP id d10so326542pll.3
 for <iommu@lists.linux-foundation.org>; Wed, 08 Jul 2020 21:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=pTAzdoR1iN01t/o6IGGOMW4lUNtEdPviP+EREnFTumw=;
 b=n+SHRE9Ua8fMAWjFYOgNrl8i+y+/wi7luuOf8JRUES039HMvzP3fg+t5pG3pdY/VKY
 Ux0xL3tiwAb90UAPQhMPQIBkcK8fblXPeWI8QGk2nw+3c43jvcdIcEpUsx5xxQ3eRqAl
 /T45fd2rtkgzrRGg/yVeaPi7/HKJ+P0ttw/ROclQZBUuCsXwaDvNVZ2hkwLt2aSaFht8
 LvZOVViLVpMJ7DRHjz3XvTSXtt19VeOSTrTmCQaLEd61i4rlDJEtpKdcds32Hj+rKO/O
 vySVkJCCTEL0DQPYcWIjsakGOh0BAmR6bhUQq6XmfGhBK7ZvH2eInjnZun+7BQSDOLoJ
 sElA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=pTAzdoR1iN01t/o6IGGOMW4lUNtEdPviP+EREnFTumw=;
 b=pX07M6lEOdFfUWORT+xhska+m+1zKg/ozdXHv2nS3v4LvwisAW1qSTo/JzW8PxEIrU
 8Ycw3CGXzpJz3yCFn0KCtquTUVLXjvszDiopEBVBr75f4P592exjcpkUMSjoX1OzZ04t
 Q60DgmhbP09Hr+IqfticAcB8wI5hjT9Y8sS0Ay+zjvx4wvG6qfKmlYbhPg04EjsqLg2V
 a+JTS+cD/+TBr0369K6Dcy9skQw7/o1ev5DlD8UnnbuyEh9is3yVFSPo/5+nFuJoMQ1S
 syKIek3PXsJDdZERR6Xr4pyClBlwiDnibCe/HwYsJPcd82FkHfJ3cRzk2W1Zqb8iTbnQ
 oNXw==
X-Gm-Message-State: AOAM530WBTBkpqz3PH3WN5/1CyLiFrqwGQe/SedVz7D5viBq7iqMwmXE
 odbWksXd0YWfHNcraPM5YZzrug==
X-Google-Smtp-Source: ABdhPJyrm5vz51JSJy0lUCVNkroG/XfjsDb45YFwdd0ZYnD6cYxRHPchu5dD4ScTiTIEeUIiSD1ocQ==
X-Received: by 2002:a17:90a:ff03:: with SMTP id
 ce3mr13844333pjb.174.1594269772843; 
 Wed, 08 Jul 2020 21:42:52 -0700 (PDT)
Received: from ripper (104-188-17-28.lightspeed.sndgca.sbcglobal.net.
 [104.188.17.28])
 by smtp.gmail.com with ESMTPSA id z11sm1228667pfk.46.2020.07.08.21.42.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2020 21:42:51 -0700 (PDT)
Date: Wed, 8 Jul 2020 21:43:18 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Jonathan Marek <jonathan@marek.ca>
Subject: Re: [PATCH v2 2/8] iommu: arm-smmu-impl: Use qcom impl for sm8150
 and sm8250 compatibles
Message-ID: <20200709044318.GA3453565@ripper>
References: <20200609194030.17756-1-jonathan@marek.ca>
 <20200609194030.17756-3-jonathan@marek.ca>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200609194030.17756-3-jonathan@marek.ca>
Cc: linux-arm-msm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Will Deacon <will@kernel.org>,
 "moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>,
 Robin Murphy <robin.murphy@arm.com>
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

On Tue 09 Jun 12:40 PDT 2020, Jonathan Marek wrote:

> Use the qcom implementation for IOMMU hardware on sm8150 and sm8250 SoCs.
> 
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/iommu/arm-smmu-impl.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm-smmu-impl.c b/drivers/iommu/arm-smmu-impl.c
> index c75b9d957b70..f5f6cab626be 100644
> --- a/drivers/iommu/arm-smmu-impl.c
> +++ b/drivers/iommu/arm-smmu-impl.c
> @@ -172,7 +172,9 @@ struct arm_smmu_device *arm_smmu_impl_init(struct arm_smmu_device *smmu)
>  		smmu->impl = &calxeda_impl;
>  
>  	if (of_device_is_compatible(np, "qcom,sdm845-smmu-500") ||
> -	    of_device_is_compatible(np, "qcom,sc7180-smmu-500"))
> +	    of_device_is_compatible(np, "qcom,sc7180-smmu-500") ||
> +	    of_device_is_compatible(np, "qcom,sm8150-smmu-500") ||
> +	    of_device_is_compatible(np, "qcom,sm8250-smmu-500"))
>  		return qcom_smmu_impl_init(smmu);
>  
>  	return smmu;
> -- 
> 2.26.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
