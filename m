Return-Path: <SRS0=CZco=62=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 640E3C54E90
	for <iommu@archiver.kernel.org>; Tue, 12 May 2020 05:59:49 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CBEE2072B
	for <iommu@archiver.kernel.org>; Tue, 12 May 2020 05:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tKsnlfhU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CBEE2072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id E1A71207A8;
	Tue, 12 May 2020 05:59:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8Cl2nGZpVkZR; Tue, 12 May 2020 05:59:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 40B1F207A2;
	Tue, 12 May 2020 05:59:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1D4E3C088A;
	Tue, 12 May 2020 05:59:48 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 792B7C016F
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 05:59:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 6665C88A10
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 05:59:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ccGAow1UOV7h for <iommu@lists.linux-foundation.org>;
 Tue, 12 May 2020 05:59:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com
 [209.85.210.195])
 by hemlock.osuosl.org (Postfix) with ESMTPS id ADFE788573
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 05:59:46 +0000 (UTC)
Received: by mail-pf1-f195.google.com with SMTP id 18so5855230pfv.8
 for <iommu@lists.linux-foundation.org>; Mon, 11 May 2020 22:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=CfP4USWuf4jsr8CxicWGhxjxXRopIo0RKfZ+1QBlcmA=;
 b=tKsnlfhUMIet6mwNuBSJVB/HOvSFdB1or5wKLaQq1TqOaLuQIfz6J40GgOHgJYvstQ
 9bZwNbUfiLMUuAPK7keXo0oTrslKfZhuRUScTHyo8PGrC0g9oszz2b0HZPVIBl0Wf1kZ
 ThI6Pfvky1G8iy1fmIxO8HUo5Urt01uf+SCWIgpTTRxlu3zXOHVog55oV/qJSSXImz/0
 hcZ6uwXEvvZ9grqy5whyYu8TqNLwcL75oBYY8OQF7BoOGciQ3Er6BGcoOBPViij7bwJE
 tIoK17AnSaPBZzw9UKrPBfIuxpZrVtfjiPYOWjXGEXWtghhGSDoTRMUAFNOgV0YBS8L1
 EWVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=CfP4USWuf4jsr8CxicWGhxjxXRopIo0RKfZ+1QBlcmA=;
 b=hkBkRLJukzF4xiwdSM5JW2EEc555NJBg/BZXfTvSxAemJnqTorXjWYbRpk8vK0H6lG
 Xh3vWQ7BDcb3/584k2Y1UhYOn4fFBSGHvzsLZLFeSgITPO6t18gx6uWTIZ30+5KcM3ph
 ylmy4Y36V7XFqA+EC9xxo5HWfOtfBy5vgzj+a17m5f6UTtyT2GU0XH4Un+ecA3A/dqJU
 a/+X7BPwHCDJE6JP/onD6HvV7FdZjrHMpIR6oE0nvcR+b+Bqcgsd2aTHjRqIbmSVb0c8
 HR73nYlZoAotW0lXfohbwy2B7zF3ahaAbLaPu6f/kwdx4rjdVj06BWpsqIuKmbYxqaNL
 6A6Q==
X-Gm-Message-State: AOAM531mcvHjRr2uIb9EYkB9c5OD3/h6m0Ze9+jByVGjKfS7wP7IjDi9
 mBlmNAH6dISwdkuE7uCVRIo7ETxnGWk=
X-Google-Smtp-Source: APiQypJJ96PeWAU9UnS8z/TMfYOhK8mhlaPNvQrINPQBZdi2Yjt4mmGXCCToUaVU4ys48UnSf1li/w==
X-Received: by 2002:a17:902:a5c2:: with SMTP id
 t2mr18385800plq.151.1589262765889; 
 Mon, 11 May 2020 22:52:45 -0700 (PDT)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net.
 [104.188.17.28])
 by smtp.gmail.com with ESMTPSA id q21sm9268767pgl.7.2020.05.11.22.52.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 22:52:45 -0700 (PDT)
Date: Mon, 11 May 2020 22:52:42 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH] iommu/qcom: add optional clock for TLB invalidate
Message-ID: <20200512055242.GJ1302550@yoga>
References: <20200509130825.28248-1-shawn.guo@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200509130825.28248-1-shawn.guo@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
 Konrad Dybcio <konradybcio@gmail.com>, Andy Gross <agross@kernel.org>
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

On Sat 09 May 06:08 PDT 2020, Shawn Guo wrote:

> On some SoCs like MSM8939 with A405 adreno, there is a gfx_tbu clock
> needs to be on while doing TLB invalidate. Otherwise, TLBSYNC status
> will not be correctly reflected, causing the system to go into a bad
> state.  Add it as an optional clock, so that platforms that have this
> clock can pass it over DT.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  drivers/iommu/qcom_iommu.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/iommu/qcom_iommu.c b/drivers/iommu/qcom_iommu.c
> index 0e2a96467767..2f6c6da7d540 100644
> --- a/drivers/iommu/qcom_iommu.c
> +++ b/drivers/iommu/qcom_iommu.c
> @@ -45,6 +45,7 @@ struct qcom_iommu_dev {
>  	struct device		*dev;
>  	struct clk		*iface_clk;
>  	struct clk		*bus_clk;
> +	struct clk		*tlb_clk;
>  	void __iomem		*local_base;
>  	u32			 sec_id;
>  	u8			 num_ctxs;
> @@ -643,11 +644,20 @@ static int qcom_iommu_enable_clocks(struct qcom_iommu_dev *qcom_iommu)
>  		return ret;
>  	}
>  
> +	ret = clk_prepare_enable(qcom_iommu->tlb_clk);
> +	if (ret) {
> +		dev_err(qcom_iommu->dev, "Couldn't enable tlb_clk\n");
> +		clk_disable_unprepare(qcom_iommu->bus_clk);
> +		clk_disable_unprepare(qcom_iommu->iface_clk);
> +		return ret;
> +	}

Seems this is an excellent opportunity to replace
qcom_iommu_enable_clocks() to clk_bulk_prepare_enable() and disable,
respectively.

> +
>  	return 0;
>  }
>  
>  static void qcom_iommu_disable_clocks(struct qcom_iommu_dev *qcom_iommu)
>  {
> +	clk_disable_unprepare(qcom_iommu->tlb_clk);
>  	clk_disable_unprepare(qcom_iommu->bus_clk);
>  	clk_disable_unprepare(qcom_iommu->iface_clk);
>  }
> @@ -839,6 +849,12 @@ static int qcom_iommu_device_probe(struct platform_device *pdev)
>  		return PTR_ERR(qcom_iommu->bus_clk);
>  	}
>  
> +	qcom_iommu->tlb_clk = devm_clk_get(dev, "tlb");

Wouldn't "tbu" be a better name for this clock? Given that seems the
actually be the hardware block you're clocking.


That said, I thought we used device links and pm_runtime to ensure that
the TBUs are powered and clocked...

Regards,
Bjorn

> +	if (IS_ERR(qcom_iommu->tlb_clk)) {
> +		dev_dbg(dev, "failed to get tlb clock\n");
> +		qcom_iommu->tlb_clk = NULL;
> +	}
> +
>  	if (of_property_read_u32(dev->of_node, "qcom,iommu-secure-id",
>  				 &qcom_iommu->sec_id)) {
>  		dev_err(dev, "missing qcom,iommu-secure-id property\n");
> -- 
> 2.17.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
