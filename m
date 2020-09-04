Return-Path: <SRS0=mVMG=CN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB101C433E2
	for <iommu@archiver.kernel.org>; Fri,  4 Sep 2020 16:06:44 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95E662074D
	for <iommu@archiver.kernel.org>; Fri,  4 Sep 2020 16:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OZy7+nmo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95E662074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 836BB86B9A;
	Fri,  4 Sep 2020 16:06:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i5O2pdKDMVOW; Fri,  4 Sep 2020 16:06:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7610186DF0;
	Fri,  4 Sep 2020 16:06:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 625B6C07FF;
	Fri,  4 Sep 2020 16:06:43 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7A3F1C0051
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 16:06:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 70C972E1D9
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 16:06:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rJrajyxPshcb for <iommu@lists.linux-foundation.org>;
 Fri,  4 Sep 2020 16:06:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com
 [209.85.210.66])
 by silver.osuosl.org (Postfix) with ESMTPS id 92C7E2012D
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 16:06:34 +0000 (UTC)
Received: by mail-ot1-f66.google.com with SMTP id i4so6350664ota.2
 for <iommu@lists.linux-foundation.org>; Fri, 04 Sep 2020 09:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=yGsA49rxc5hM77zu3hVnv/Snb3l8Beqqgv9O0m89n9M=;
 b=OZy7+nmo3BIaZ9T9nelyVX4l9QpEbcCuo8yllCgiWtT62uoQjY63QalRFu8zFehO6v
 ZnAVU++j55iEY2+/sYTqgpW965CzNYh5FSFLjLpJUbZlROleC0GufMN2cf17HO1cOrdh
 vlLrs+k7gUMBydn50+D7kwpNIeCJfrsHGQ7J6qgvpCSVbA6vxWMTAVSFIfjIhNhxCoo/
 vW27rwvVuBh+ZoTTMRP+K7vfGOFt0KzFaw693zfr5F+d1dEyCfujTjhQj5DYbITrbKFs
 xUlgzZm6UckT40GBkz51u7zO3ZW6Bdm3+d5Xt6kV1xFyTr++s7HS/jYv/RsDEy2rqQiv
 hg8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=yGsA49rxc5hM77zu3hVnv/Snb3l8Beqqgv9O0m89n9M=;
 b=Cu7fRBRB9YTiZ0TDG9nn4xqkSBSzqyI/k6tZXWDRlxgSF16kmnNWunANDQh8I7yah9
 b9VmzlbjhaZWf5KJO8zUWVaqm9VpF/bNwSqP5EmVB6uINeeRl1pLj9khfib6AGlJtaND
 4Cy/uX7GQeADZ3LZXWtm+ZPYTl+/MSjDwP1IYmyG8AG8OoGbp5lPPeRjBBeNDVFzJwHc
 ONj7L/Xg+JKgJr738rGDl43d2R7/bijTpsYYUafhz+HvanNObj20Qzbmcw9Ze/0RFH/b
 OZh6xiKVIcdGYoYhwKrIpsWkqkFZi15sVLoRq31pXeR0xcP4RL4uLOQiLg58H7lzcVZk
 oiaQ==
X-Gm-Message-State: AOAM530MQXDR6s+ixhpNKJLYO8nla6QGruZXjvUn657T9/RNXsB6RZPy
 shCmRfNoxzGRAj8AC0tD7O+23Q==
X-Google-Smtp-Source: ABdhPJzGRciwEc32A7jGVOPFZOIbTFY5t2o9ThvPI+Y2vdsQYpVMGnxVgGSNkXlsXYLGJPIR5XUBxw==
X-Received: by 2002:a9d:2c43:: with SMTP id f61mr6394737otb.154.1599235593662; 
 Fri, 04 Sep 2020 09:06:33 -0700 (PDT)
Received: from yoga ([2605:6000:e5cb:c100:8898:14ff:fe6d:34e])
 by smtp.gmail.com with ESMTPSA id q9sm1264649otk.14.2020.09.04.09.06.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2020 09:06:32 -0700 (PDT)
Date: Fri, 4 Sep 2020 11:06:20 -0500
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH v16 19/20] arm: dts: qcom: sm845: Set the compatible
 string for the GPU SMMU
Message-ID: <20200904160620.GI3715@yoga>
References: <20200901164707.2645413-1-robdclark@gmail.com>
 <20200901164707.2645413-20-robdclark@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200901164707.2645413-20-robdclark@gmail.com>
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

> From: Jordan Crouse <jcrouse@codeaurora.org>
> 
> Set the qcom,adreno-smmu compatible string for the GPU SMMU to enable
> split pagetables and per-instance pagetables for drm/msm.
> 
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> Signed-off-by: Rob Clark <robdclark@chromium.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
>  arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi | 9 +++++++++
>  arch/arm64/boot/dts/qcom/sdm845.dtsi       | 2 +-
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
> index 64fc1bfd66fa..39f23cdcbd02 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
> @@ -633,6 +633,15 @@ &mdss_mdp {
>  	status = "okay";
>  };
>  
> +/*
> + * Cheza fw does not properly program the GPU aperture to allow the
> + * GPU to update the SMMU pagetables for context switches.  Work
> + * around this by dropping the "qcom,adreno-smmu" compat string.
> + */
> +&adreno_smmu {
> +	compatible = "qcom,sdm845-smmu-v2", "qcom,smmu-v2";
> +};
> +
>  &mss_pil {
>  	iommus = <&apps_smmu 0x781 0x0>,
>  		 <&apps_smmu 0x724 0x3>;
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 2884577dcb77..76a8a34640ae 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -4058,7 +4058,7 @@ opp-257000000 {
>  		};
>  
>  		adreno_smmu: iommu@5040000 {
> -			compatible = "qcom,sdm845-smmu-v2", "qcom,smmu-v2";
> +			compatible = "qcom,sdm845-smmu-v2", "qcom,adreno-smmu", "qcom,smmu-v2";
>  			reg = <0 0x5040000 0 0x10000>;
>  			#iommu-cells = <1>;
>  			#global-interrupts = <2>;
> -- 
> 2.26.2
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
