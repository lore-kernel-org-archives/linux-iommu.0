Return-Path: <SRS0=mVMG=CN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0861C433E2
	for <iommu@archiver.kernel.org>; Fri,  4 Sep 2020 16:07:11 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A63CC2074D
	for <iommu@archiver.kernel.org>; Fri,  4 Sep 2020 16:07:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bls3T86m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A63CC2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 8335D20107;
	Fri,  4 Sep 2020 16:07:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rdQXt2cJyyZ3; Fri,  4 Sep 2020 16:07:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 9F6DD1FFC1;
	Fri,  4 Sep 2020 16:07:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 95D01C07FF;
	Fri,  4 Sep 2020 16:07:10 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2B71BC0051
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 16:07:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 26F9E86B88
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 16:07:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ncpuF3b40Cy2 for <iommu@lists.linux-foundation.org>;
 Fri,  4 Sep 2020 16:07:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-oi1-f195.google.com (mail-oi1-f195.google.com
 [209.85.167.195])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 6B6AD866E2
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 16:07:09 +0000 (UTC)
Received: by mail-oi1-f195.google.com with SMTP id x69so4013109oia.8
 for <iommu@lists.linux-foundation.org>; Fri, 04 Sep 2020 09:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=doLJDgNe0qt085BNPu/3Io3kfNCUU7JOawvznIdKbdg=;
 b=Bls3T86mzryTn+qU1zsr/9PYb0zkdzQQ2ypAxX9SKP9tu98U+eVySYDoXF3jIyFa8G
 XH3HYfOWR693y7ALBNUYECipnhoSVq9uQtmNNn8ZNJMY3gWyc7pbJWqOcy39gmSAsouj
 U8vUn6yRiuL/09+Q3ZPurtyUqlRFuuSAdVbkVyt9CLW/Hw0QFIVg8PBZUUjOuAjxdnu1
 Eak3IlxA4JLKEFyjL/fgoyooxv3/37UcREE9CZ1SSFV7DDDliFlyEcDpvFWUzCLDScXZ
 bwWi0RyelmbdQqrcGz83/qEBJCTQpYYw3g4kHp1J/RwwCAauH4+RwTUXB4UB+CfxXbSP
 lZ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=doLJDgNe0qt085BNPu/3Io3kfNCUU7JOawvznIdKbdg=;
 b=rTsJJLbxvXhJfkN3lmfOOTV3tj3PsCxFACS9aseCXfeKQz9c8VxCmr85+RT4Ruhuoe
 hytPDqGhX8HFbRlxplP2gDhxROdKhlHMl9mBs706wxtFJ162RtVgEIwrBDpi66ZAiggn
 TdKCtmFB/HGyqqc89ussG4hXfufZMTI8dNhO9lOGoPkxB036+eXQD/XpiHvfEbzF5+BJ
 Ekb9tSalCo5kQsId51igfhaBxQzLV7xxgAvB/izzNc2M0mdeYzCly6vCmN9GTZvYWl/B
 rOk9DmBpeJxcHHeJ0SgLouTp1XdRRdaUkyKfTuwHZN1nOe+twS5MfQBAK+hGPhja1sJz
 9gwA==
X-Gm-Message-State: AOAM533VnLyJa0Ga8NZiEuklcjBa9lopoOJU/Hp4cXFwpN4WCxD1Njt3
 V4YsoFQ00hAxcqO1Xd25lZLh6A==
X-Google-Smtp-Source: ABdhPJyW9FGADBJOCZRrQYFZdHWHjGtQOzqZty0xfmulX35Zut5RGG3F7ZSeSB47qhRZIBUayNPRPA==
X-Received: by 2002:a54:4f85:: with SMTP id g5mr5738063oiy.27.1599235628680;
 Fri, 04 Sep 2020 09:07:08 -0700 (PDT)
Received: from yoga ([2605:6000:e5cb:c100:8898:14ff:fe6d:34e])
 by smtp.gmail.com with ESMTPSA id w1sm1370649oop.16.2020.09.04.09.07.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2020 09:07:07 -0700 (PDT)
Date: Fri, 4 Sep 2020 11:06:58 -0500
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH v16 20/20] arm: dts: qcom: sc7180: Set the compatible
 string for the GPU SMMU
Message-ID: <20200904160658.GJ3715@yoga>
References: <20200901164707.2645413-1-robdclark@gmail.com>
 <20200901164707.2645413-21-robdclark@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200901164707.2645413-21-robdclark@gmail.com>
Cc: Rob Clark <robdclark@chromium.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, linux-arm-msm@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>, dri-devel@lists.freedesktop.org,
 Stephen Boyd <swboyd@chromium.org>, Rob Herring <robh+dt@kernel.org>,
 iommu@lists.linux-foundation.org, Andy Gross <agross@kernel.org>,
 Akhil P Oommen <akhilpo@codeaurora.org>, Sibi Sankar <sibis@codeaurora.org>,
 Vivek Gautam <vivek.gautam@codeaurora.org>, Will Deacon <will@kernel.org>,
 open list <linux-kernel@vger.kernel.org>
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

On Tue 01 Sep 11:46 CDT 2020, Rob Clark wrote:

> From: Rob Clark <robdclark@chromium.org>
> 
> Set the qcom,adreno-smmu compatible string for the GPU SMMU to enable
> split pagetables and per-instance pagetables for drm/msm.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> index d46b3833e52f..f3bef1cad889 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -1937,7 +1937,7 @@ opp-180000000 {
>  		};
>  
>  		adreno_smmu: iommu@5040000 {
> -			compatible = "qcom,sc7180-smmu-v2", "qcom,smmu-v2";
> +			compatible = "qcom,sc7180-smmu-v2", "qcom,adreno-smmu", "qcom,smmu-v2";
>  			reg = <0 0x05040000 0 0x10000>;
>  			#iommu-cells = <1>;
>  			#global-interrupts = <2>;
> -- 
> 2.26.2
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
