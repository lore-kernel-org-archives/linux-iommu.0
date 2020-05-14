Return-Path: <SRS0=Hf/t=64=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB594C433E0
	for <iommu@archiver.kernel.org>; Thu, 14 May 2020 14:39:27 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DFD7205CB
	for <iommu@archiver.kernel.org>; Thu, 14 May 2020 14:39:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WWrEtcLT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DFD7205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3BB6487ABE;
	Thu, 14 May 2020 14:39:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xYIdQPy-0uK5; Thu, 14 May 2020 14:39:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9655087A49;
	Thu, 14 May 2020 14:39:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7B810C0863;
	Thu, 14 May 2020 14:39:22 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E782FC016F
 for <iommu@lists.linux-foundation.org>; Thu, 14 May 2020 14:39:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id CFC9788613
 for <iommu@lists.linux-foundation.org>; Thu, 14 May 2020 14:39:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id S-7Hrttq666y for <iommu@lists.linux-foundation.org>;
 Thu, 14 May 2020 14:39:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com
 [209.85.210.196])
 by hemlock.osuosl.org (Postfix) with ESMTPS id AD3BF889D5
 for <iommu@lists.linux-foundation.org>; Thu, 14 May 2020 14:39:16 +0000 (UTC)
Received: by mail-pf1-f196.google.com with SMTP id x15so1405874pfa.1
 for <iommu@lists.linux-foundation.org>; Thu, 14 May 2020 07:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=p8VAiP+wdh9S4iV1FPgA8cT+xg80zpJkzOLZcJit37g=;
 b=WWrEtcLTe/AtT4EbCTYzam79Ra7lhJKHBrZL/Tnu4TCAtBVxGBCahYXo5PmodAwuHh
 8k5LBghwsSy0kYyntrskTV8bDhmljrbaE6//K4X2W9Ot/g0R5TTgBIg56t8itWZj89hr
 nPaDDCjBdxDd6mx+299GW+PRdF14eFvxTpSJxuYU/JmR4UbDo0HVrLx7QyBxJ8YTnO4G
 rIqP7oByZMLPnJX1t4ZR/qEZKMRC8L0ueJO1VIRbDk2MDbOeBMa8QUWWfNAuB4/bFH9M
 EE6DDOJDgsV3sBGvA0Q8upX3C4Rw0k5RbHomhw98bQc2fwhLd79Crd2THuaQRgP3sABC
 Kyvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=p8VAiP+wdh9S4iV1FPgA8cT+xg80zpJkzOLZcJit37g=;
 b=YQv3ZyeYD3h56Mx6sZun0dVNJxSoO3kPuLeD5+bvViQmCFZfvmJaJoP+OynGXTnQ7y
 ZKwzcGMJUm96OsG+7QUTQktX6zx7zma4JCQHsb9a/EAoQJ4PfanDQJj2/wa/IZy+M1XE
 VD+jfPYHdxaXs67npiQy6hqbp7iDCvDf1xMcAVeXsE1CP7hE6+VREkk3ayIZ6S2w2jCc
 PsYTHq52xcfeLBG/uIxus0N6APmQyh8K9LoCUsrY0glnwW+i7VSkbfFH3pSuPS4Ezbum
 S1Fw1g1LkMQ1OhCPrpMWwBMZcLTEtye0E6e3sLj2q7rADXER7ZTAXGruCcZp/LzL1BkS
 gAYg==
X-Gm-Message-State: AOAM530IXHEmrDaUL4ebKEj4Hv828nYeqzAh1Li7CoVlGmFDJKgk3fGR
 YG71/lxViFJnrUaSTya3PkmweQ==
X-Google-Smtp-Source: ABdhPJwJa3DynaOxyMoDTqqBxRvRIuQK5Syy/Akad8KVEGe6nuQZzUaCDK13UTkPlphhIeVlYqQ46w==
X-Received: by 2002:aa7:8658:: with SMTP id a24mr4867093pfo.135.1589467156158; 
 Thu, 14 May 2020 07:39:16 -0700 (PDT)
Received: from dragon ([80.251.214.228])
 by smtp.gmail.com with ESMTPSA id w2sm18702332pja.53.2020.05.14.07.39.12
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 14 May 2020 07:39:15 -0700 (PDT)
Date: Thu, 14 May 2020 22:39:06 +0800
From: Shawn Guo <shawn.guo@linaro.org>
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH] iommu/qcom: add optional clock for TLB invalidate
Message-ID: <20200514143905.GA10507@dragon>
References: <20200509130825.28248-1-shawn.guo@linaro.org>
 <20200512055242.GJ1302550@yoga>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200512055242.GJ1302550@yoga>
User-Agent: Mutt/1.9.4 (2018-02-28)
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

Hi Bjorn,

On Mon, May 11, 2020 at 10:52:42PM -0700, Bjorn Andersson wrote:
> On Sat 09 May 06:08 PDT 2020, Shawn Guo wrote:
> 
> > On some SoCs like MSM8939 with A405 adreno, there is a gfx_tbu clock
> > needs to be on while doing TLB invalidate. Otherwise, TLBSYNC status
> > will not be correctly reflected, causing the system to go into a bad
> > state.  Add it as an optional clock, so that platforms that have this
> > clock can pass it over DT.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > ---
> >  drivers/iommu/qcom_iommu.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> > 
> > diff --git a/drivers/iommu/qcom_iommu.c b/drivers/iommu/qcom_iommu.c
> > index 0e2a96467767..2f6c6da7d540 100644
> > --- a/drivers/iommu/qcom_iommu.c
> > +++ b/drivers/iommu/qcom_iommu.c
> > @@ -45,6 +45,7 @@ struct qcom_iommu_dev {
> >  	struct device		*dev;
> >  	struct clk		*iface_clk;
> >  	struct clk		*bus_clk;
> > +	struct clk		*tlb_clk;
> >  	void __iomem		*local_base;
> >  	u32			 sec_id;
> >  	u8			 num_ctxs;
> > @@ -643,11 +644,20 @@ static int qcom_iommu_enable_clocks(struct qcom_iommu_dev *qcom_iommu)
> >  		return ret;
> >  	}
> >  
> > +	ret = clk_prepare_enable(qcom_iommu->tlb_clk);
> > +	if (ret) {
> > +		dev_err(qcom_iommu->dev, "Couldn't enable tlb_clk\n");
> > +		clk_disable_unprepare(qcom_iommu->bus_clk);
> > +		clk_disable_unprepare(qcom_iommu->iface_clk);
> > +		return ret;
> > +	}
> 
> Seems this is an excellent opportunity to replace
> qcom_iommu_enable_clocks() to clk_bulk_prepare_enable() and disable,
> respectively.

So we have two required and one optional clocks.  I guess we don't want
to use clk_bulk_get_optional() to get all of them as optional.  So we
will end up with getting clock with individual call and enabling/disabling
with bulk version.  I'm personally not fond of this mixed style.  But if
you really like this, I can change.

> 
> > +
> >  	return 0;
> >  }
> >  
> >  static void qcom_iommu_disable_clocks(struct qcom_iommu_dev *qcom_iommu)
> >  {
> > +	clk_disable_unprepare(qcom_iommu->tlb_clk);
> >  	clk_disable_unprepare(qcom_iommu->bus_clk);
> >  	clk_disable_unprepare(qcom_iommu->iface_clk);
> >  }
> > @@ -839,6 +849,12 @@ static int qcom_iommu_device_probe(struct platform_device *pdev)
> >  		return PTR_ERR(qcom_iommu->bus_clk);
> >  	}
> >  
> > +	qcom_iommu->tlb_clk = devm_clk_get(dev, "tlb");
> 
> Wouldn't "tbu" be a better name for this clock? Given that seems the
> actually be the hardware block you're clocking.

I was trying to emphasize the function of this clock.  But I agree that
'tbu' is a better name now.  I will change it in v2.

Thanks for the comments.

Shawn
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
