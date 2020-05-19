Return-Path: <SRS0=kGUL=7B=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F52C433E1
	for <iommu@archiver.kernel.org>; Tue, 19 May 2020 01:43:02 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6072320709
	for <iommu@archiver.kernel.org>; Tue, 19 May 2020 01:43:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d6Vp9MSw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6072320709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2F736885E2;
	Tue, 19 May 2020 01:43:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4NOKb4-CTZ+o; Tue, 19 May 2020 01:43:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1A2DB885C3;
	Tue, 19 May 2020 01:43:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 02BECC0888;
	Tue, 19 May 2020 01:43:01 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 22FB0C07FF
 for <iommu@lists.linux-foundation.org>; Tue, 19 May 2020 01:43:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 0B3F8862C1
 for <iommu@lists.linux-foundation.org>; Tue, 19 May 2020 01:43:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sinZARMxEVdk for <iommu@lists.linux-foundation.org>;
 Tue, 19 May 2020 01:42:58 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com
 [209.85.215.194])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id E115086303
 for <iommu@lists.linux-foundation.org>; Tue, 19 May 2020 01:42:58 +0000 (UTC)
Received: by mail-pg1-f194.google.com with SMTP id j21so5657899pgb.7
 for <iommu@lists.linux-foundation.org>; Mon, 18 May 2020 18:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Slf7JvWKOrM5x0/oFbmF5JJYCBnsK+Ra0wqdUtMN3PI=;
 b=d6Vp9MSwRJLOki7yPmsFP9mtreGeqohuis73sWEhgrcFYq0NCg+DdODWp7JbWlpmsC
 40DHVtyAZTwv9j60eD4l7aNT5Z8A/jr5T7yEVrEiewA0xp4t5oa+kpa++9NnVekVk9kU
 rseFenuXW3aZaXjw2sea/r89ld2mr27Ko0dlaSICFAi2P+H8AKiR5GXQtHVeyGYwFxai
 s3SesYrMYBTcXbHvdSR4dw6B7htGt4cnDcLtY/5RnV2AdXbwSQ6YkLf8qtlda9QkT8oC
 Tu5mQoqTlqjgNa9DbGtrdKjcTDYgMwqsFu5ubJLnATlwTn2DYZaUfE4MgHl35bBUR5y4
 a9dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Slf7JvWKOrM5x0/oFbmF5JJYCBnsK+Ra0wqdUtMN3PI=;
 b=Y3QtEB9RNTNjep+qNBLVG1e/jTFXcIRkdqC9gb2z6k+gFIM28aWh5HsmkFinbPY5cI
 B0SuKj+ivlcFodVMXDRfvoH6a1o/7MCagw66i5UkJpjlTsazd+aZ54gpxyz7nQh4maif
 Zx/Cv96KpnSAofYoDJ48NXqnmwJqBf0dapFwfaa8u9qvxM4sAuVvqainwf5K7GzVeRm7
 7PgkWlgWDc1W/sCLZUW3U6BbO0zAC6Cjo+XAWdjirEoCMJ4LHNbdcrymTynv8rDtJHi4
 SbsIZ+2enNu4jb+103GlEpm6RV4VhheWmbfvMZ6BlzwEYUheZIlC3MvQ/5ktkIcpioIT
 57ug==
X-Gm-Message-State: AOAM533iEJfXe/cr7+bKgfo600OqWyBvSWabHIRBuXXEvUqaYuJBcw/R
 MEDc8H9kDnYaVHW9ZCF038urzA==
X-Google-Smtp-Source: ABdhPJx65eKPngn5OVLo7uoRDLU6Jsu4qJjlV5sooVcPZdPqE8dlBaKsMWwqnQE75tPyXN6IiNKBbw==
X-Received: by 2002:a63:b146:: with SMTP id g6mr17214044pgp.396.1589852578368; 
 Mon, 18 May 2020 18:42:58 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net.
 [104.188.17.28])
 by smtp.gmail.com with ESMTPSA id 14sm605798pjm.49.2020.05.18.18.42.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2020 18:42:57 -0700 (PDT)
Date: Mon, 18 May 2020 18:41:35 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v2] iommu/qcom: add optional 'tbu' clock for TLB invalidate
Message-ID: <20200519014135.GV2165@builder.lan>
References: <20200518141656.26284-1-shawn.guo@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200518141656.26284-1-shawn.guo@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, Konrad Dybcio <konradybcio@gmail.com>,
 iommu@lists.linux-foundation.org,
 Stanimir Varbanov <stanimir.varbanov@linaro.org>,
 Andy Gross <agross@kernel.org>
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

On Mon 18 May 07:16 PDT 2020, Shawn Guo wrote:

> On some SoCs like MSM8939 with A405 adreno, there is a gfx_tbu clock
> needs to be on while doing TLB invalidate. Otherwise, TLBSYNC status
> will not be correctly reflected, causing the system to go into a bad
> state.  Add it as an optional clock, so that platforms that have this
> clock can pass it over DT.
> 
> While adding the third clock, let's switch to bulk clk API to simplify
> the enable/disable calls.  clk_bulk_get() cannot used because the
> existing two clocks are required while the new one is optional.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
> Changes for v2:
>  - Use devm_clk_get_optional() to simplify code and improve readability.
>  - Rename the new clock from 'tlb' to 'tbu'.
>  - qcom_iommu: use bulk clk API to simplfy enable/disable.
> 
>  drivers/iommu/qcom_iommu.c | 62 ++++++++++++++++----------------------
>  1 file changed, 26 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/iommu/qcom_iommu.c b/drivers/iommu/qcom_iommu.c
> index 0e2a96467767..116d8188f87f 100644
> --- a/drivers/iommu/qcom_iommu.c
> +++ b/drivers/iommu/qcom_iommu.c
> @@ -37,14 +37,20 @@
>  
>  #define SMMU_INTR_SEL_NS     0x2000
>  
> +enum qcom_iommu_clk {
> +	CLK_IFACE,
> +	CLK_BUS,
> +	CLK_TBU,
> +	CLK_NUM,
> +};
> +
>  struct qcom_iommu_ctx;
>  
>  struct qcom_iommu_dev {
>  	/* IOMMU core code handle */
>  	struct iommu_device	 iommu;
>  	struct device		*dev;
> -	struct clk		*iface_clk;
> -	struct clk		*bus_clk;
> +	struct clk_bulk_data clks[CLK_NUM];
>  	void __iomem		*local_base;
>  	u32			 sec_id;
>  	u8			 num_ctxs;
> @@ -626,32 +632,6 @@ static const struct iommu_ops qcom_iommu_ops = {
>  	.pgsize_bitmap	= SZ_4K | SZ_64K | SZ_1M | SZ_16M,
>  };
>  
> -static int qcom_iommu_enable_clocks(struct qcom_iommu_dev *qcom_iommu)
> -{
> -	int ret;
> -
> -	ret = clk_prepare_enable(qcom_iommu->iface_clk);
> -	if (ret) {
> -		dev_err(qcom_iommu->dev, "Couldn't enable iface_clk\n");
> -		return ret;
> -	}
> -
> -	ret = clk_prepare_enable(qcom_iommu->bus_clk);
> -	if (ret) {
> -		dev_err(qcom_iommu->dev, "Couldn't enable bus_clk\n");
> -		clk_disable_unprepare(qcom_iommu->iface_clk);
> -		return ret;
> -	}
> -
> -	return 0;
> -}
> -
> -static void qcom_iommu_disable_clocks(struct qcom_iommu_dev *qcom_iommu)
> -{
> -	clk_disable_unprepare(qcom_iommu->bus_clk);
> -	clk_disable_unprepare(qcom_iommu->iface_clk);
> -}
> -
>  static int qcom_iommu_sec_ptbl_init(struct device *dev)
>  {
>  	size_t psize = 0;
> @@ -808,6 +788,7 @@ static int qcom_iommu_device_probe(struct platform_device *pdev)
>  	struct qcom_iommu_dev *qcom_iommu;
>  	struct device *dev = &pdev->dev;
>  	struct resource *res;
> +	struct clk *clk;
>  	int ret, max_asid = 0;
>  
>  	/* find the max asid (which is 1:1 to ctx bank idx), so we know how
> @@ -827,17 +808,26 @@ static int qcom_iommu_device_probe(struct platform_device *pdev)
>  	if (res)
>  		qcom_iommu->local_base = devm_ioremap_resource(dev, res);
>  
> -	qcom_iommu->iface_clk = devm_clk_get(dev, "iface");
> -	if (IS_ERR(qcom_iommu->iface_clk)) {
> +	clk = devm_clk_get(dev, "iface");
> +	if (IS_ERR(clk)) {
>  		dev_err(dev, "failed to get iface clock\n");
> -		return PTR_ERR(qcom_iommu->iface_clk);
> +		return PTR_ERR(clk);
>  	}
> +	qcom_iommu->clks[CLK_IFACE].clk = clk;
>  
> -	qcom_iommu->bus_clk = devm_clk_get(dev, "bus");
> -	if (IS_ERR(qcom_iommu->bus_clk)) {
> +	clk = devm_clk_get(dev, "bus");
> +	if (IS_ERR(clk)) {
>  		dev_err(dev, "failed to get bus clock\n");
> -		return PTR_ERR(qcom_iommu->bus_clk);
> +		return PTR_ERR(clk);
> +	}
> +	qcom_iommu->clks[CLK_BUS].clk = clk;
> +
> +	clk = devm_clk_get_optional(dev, "tbu");
> +	if (IS_ERR(clk)) {
> +		dev_err(dev, "failed to get tbu clock\n");
> +		return PTR_ERR(clk);
>  	}
> +	qcom_iommu->clks[CLK_TBU].clk = clk;
>  
>  	if (of_property_read_u32(dev->of_node, "qcom,iommu-secure-id",
>  				 &qcom_iommu->sec_id)) {
> @@ -909,14 +899,14 @@ static int __maybe_unused qcom_iommu_resume(struct device *dev)
>  {
>  	struct qcom_iommu_dev *qcom_iommu = dev_get_drvdata(dev);
>  
> -	return qcom_iommu_enable_clocks(qcom_iommu);
> +	return clk_bulk_prepare_enable(CLK_NUM, qcom_iommu->clks);
>  }
>  
>  static int __maybe_unused qcom_iommu_suspend(struct device *dev)
>  {
>  	struct qcom_iommu_dev *qcom_iommu = dev_get_drvdata(dev);
>  
> -	qcom_iommu_disable_clocks(qcom_iommu);
> +	clk_bulk_disable_unprepare(CLK_NUM, qcom_iommu->clks);
>  
>  	return 0;
>  }
> -- 
> 2.17.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
