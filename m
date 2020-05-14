Return-Path: <SRS0=Hf/t=64=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16224C433E0
	for <iommu@archiver.kernel.org>; Thu, 14 May 2020 15:17:19 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD00B206A5
	for <iommu@archiver.kernel.org>; Thu, 14 May 2020 15:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FAV0FiFG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD00B206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id A1715884C9;
	Thu, 14 May 2020 15:17:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V88rBVV8xSmz; Thu, 14 May 2020 15:17:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id EFDEC88376;
	Thu, 14 May 2020 15:17:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C4A02C0178;
	Thu, 14 May 2020 15:17:13 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DAC57C016F
 for <iommu@lists.linux-foundation.org>; Thu, 14 May 2020 15:17:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id D68D88729F
 for <iommu@lists.linux-foundation.org>; Thu, 14 May 2020 15:17:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DoyegXm3DKN4 for <iommu@lists.linux-foundation.org>;
 Thu, 14 May 2020 15:17:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com
 [209.85.214.195])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id F097B87A51
 for <iommu@lists.linux-foundation.org>; Thu, 14 May 2020 15:17:05 +0000 (UTC)
Received: by mail-pl1-f195.google.com with SMTP id u10so1274101pls.8
 for <iommu@lists.linux-foundation.org>; Thu, 14 May 2020 08:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=UOTOikrlMIdFP4aQmvMqbEPCvRUzwtRIl17AlTTVkFQ=;
 b=FAV0FiFG8pM97LoBhxQbtROvqf5AWxbcndRpllxsWkcIaHB91vOCGimVplMMreOEkU
 qmULzk7Z8/9dMEQh2GpPtXAgAVgIOrVijnr4Pnx8/0XJGCojoYh41JhId1eODIo/qiep
 xvk5ETm2APEaZqfxNLnXRh317kjcD6LCKsIRIi04YPhTYU4Gwy0Ow34pSlur7iyAjK5z
 MOf0RYaNnjUSa57Lmh+exTlxatlDaNGjkRGK+//LW74ckUsxdoEPLIK1K2KPWX1YDiP2
 iH6uIOx00Z31Nqm3522GqrSiroWfCfOR1cuzfqq4k8cuko9iWbJZyev7hiNAM69rGiYs
 705Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=UOTOikrlMIdFP4aQmvMqbEPCvRUzwtRIl17AlTTVkFQ=;
 b=mLjPpxh1vdY4tqb3QIcjxV+ikIOPhaEjd+oE0XimbDdGGqFQ4vTC0x4lsZ0OIeUU92
 kPbP5X3PNuWQK+azdjIV9oSeWOFxdbEkvvykHFWwFONs5H2FQ4SDxvPRABVboYVpbC5T
 k1/ozHxp9+aq3ySUBGxH4FK5fNfSBV2D27RH6gJUpjEO7r7BC11H1vQI4jUb0KGvm0Yy
 F8VJS8Nm0+bvVwcq9i/hz2NdUaolRN7xEhH0pAa6sq5CaEkTKx7RoQom1+xtunCM1wIo
 LQT7ZUjYpCe0I6RfBkyiXgCyCLANQw//67eQPKaem401Js3PR3nObJidtvKAxWxrnc2W
 2MQQ==
X-Gm-Message-State: AGi0Pub2OOEJJj4AbGj5n+nWy3sjNYJISFvH0duP5MI0xnVI77z8EFqU
 0q9TM6jj2ogIhwtpqEfkHxiJ7A==
X-Google-Smtp-Source: APiQypIqLPWyOC5M9ILxiC3BfqbMDARmmWsJ8Dm25QhFLozp8vgxg4irNno8ImmwBQmFa6uK/83m+w==
X-Received: by 2002:a17:90a:de8d:: with SMTP id
 n13mr42417575pjv.173.1589469425327; 
 Thu, 14 May 2020 08:17:05 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net.
 [104.188.17.28])
 by smtp.gmail.com with ESMTPSA id k7sm2346357pga.87.2020.05.14.08.17.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2020 08:17:04 -0700 (PDT)
Date: Thu, 14 May 2020 08:15:34 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH] iommu/qcom: add optional clock for TLB invalidate
Message-ID: <20200514151534.GV2165@builder.lan>
References: <20200509130825.28248-1-shawn.guo@linaro.org>
 <20200512055242.GJ1302550@yoga> <20200514143905.GA10507@dragon>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200514143905.GA10507@dragon>
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

On Thu 14 May 07:39 PDT 2020, Shawn Guo wrote:

> Hi Bjorn,
> 
> On Mon, May 11, 2020 at 10:52:42PM -0700, Bjorn Andersson wrote:
> > On Sat 09 May 06:08 PDT 2020, Shawn Guo wrote:
> > 
> > > On some SoCs like MSM8939 with A405 adreno, there is a gfx_tbu clock
> > > needs to be on while doing TLB invalidate. Otherwise, TLBSYNC status
> > > will not be correctly reflected, causing the system to go into a bad
> > > state.  Add it as an optional clock, so that platforms that have this
> > > clock can pass it over DT.
> > > 
> > > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > > ---
> > >  drivers/iommu/qcom_iommu.c | 16 ++++++++++++++++
> > >  1 file changed, 16 insertions(+)
> > > 
> > > diff --git a/drivers/iommu/qcom_iommu.c b/drivers/iommu/qcom_iommu.c
> > > index 0e2a96467767..2f6c6da7d540 100644
> > > --- a/drivers/iommu/qcom_iommu.c
> > > +++ b/drivers/iommu/qcom_iommu.c
> > > @@ -45,6 +45,7 @@ struct qcom_iommu_dev {
> > >  	struct device		*dev;
> > >  	struct clk		*iface_clk;
> > >  	struct clk		*bus_clk;
> > > +	struct clk		*tlb_clk;
> > >  	void __iomem		*local_base;
> > >  	u32			 sec_id;
> > >  	u8			 num_ctxs;
> > > @@ -643,11 +644,20 @@ static int qcom_iommu_enable_clocks(struct qcom_iommu_dev *qcom_iommu)
> > >  		return ret;
> > >  	}
> > >  
> > > +	ret = clk_prepare_enable(qcom_iommu->tlb_clk);
> > > +	if (ret) {
> > > +		dev_err(qcom_iommu->dev, "Couldn't enable tlb_clk\n");
> > > +		clk_disable_unprepare(qcom_iommu->bus_clk);
> > > +		clk_disable_unprepare(qcom_iommu->iface_clk);
> > > +		return ret;
> > > +	}
> > 
> > Seems this is an excellent opportunity to replace
> > qcom_iommu_enable_clocks() to clk_bulk_prepare_enable() and disable,
> > respectively.
> 
> So we have two required and one optional clocks.  I guess we don't want
> to use clk_bulk_get_optional() to get all of them as optional.  So we
> will end up with getting clock with individual call and enabling/disabling
> with bulk version.  I'm personally not fond of this mixed style.  But if
> you really like this, I can change.
> 

I share your dislike for mixing them, but I do prefer it over the nasty
error handling we end up with in qcom_iommu_enable_clocks().

Regards,
Bjorn

> > 
> > > +
> > >  	return 0;
> > >  }
> > >  
> > >  static void qcom_iommu_disable_clocks(struct qcom_iommu_dev *qcom_iommu)
> > >  {
> > > +	clk_disable_unprepare(qcom_iommu->tlb_clk);
> > >  	clk_disable_unprepare(qcom_iommu->bus_clk);
> > >  	clk_disable_unprepare(qcom_iommu->iface_clk);
> > >  }
> > > @@ -839,6 +849,12 @@ static int qcom_iommu_device_probe(struct platform_device *pdev)
> > >  		return PTR_ERR(qcom_iommu->bus_clk);
> > >  	}
> > >  
> > > +	qcom_iommu->tlb_clk = devm_clk_get(dev, "tlb");
> > 
> > Wouldn't "tbu" be a better name for this clock? Given that seems the
> > actually be the hardware block you're clocking.
> 
> I was trying to emphasize the function of this clock.  But I agree that
> 'tbu' is a better name now.  I will change it in v2.
> 
> Thanks for the comments.
> 
> Shawn
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
