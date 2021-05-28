Return-Path: <SRS0=hOEw=KX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65AF7C2B9F7
	for <iommu@archiver.kernel.org>; Fri, 28 May 2021 16:26:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05580613E3
	for <iommu@archiver.kernel.org>; Fri, 28 May 2021 16:26:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05580613E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BE0EC40578;
	Fri, 28 May 2021 16:26:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ofBS0XDFOFRH; Fri, 28 May 2021 16:26:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id F24E9400AE;
	Fri, 28 May 2021 16:26:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CAA48C000E;
	Fri, 28 May 2021 16:26:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A7BDBC0001
 for <iommu@lists.linux-foundation.org>; Fri, 28 May 2021 16:26:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 884FE608BB
 for <iommu@lists.linux-foundation.org>; Fri, 28 May 2021 16:26:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UT1KdU9pFfeC for <iommu@lists.linux-foundation.org>;
 Fri, 28 May 2021 16:26:13 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 83B52605C4
 for <iommu@lists.linux-foundation.org>; Fri, 28 May 2021 16:26:13 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id o127so2436722wmo.4
 for <iommu@lists.linux-foundation.org>; Fri, 28 May 2021 09:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=TKWYuy5e1a7MVcCONh10ek8WRVjfZhF24M6h3yAlFXg=;
 b=uAqk1rGnr4Zx8fqad9xCVt+J0mKPcTq7ssobuwqr0/V87yyJQtgkrWC0PF+2ZNSBCb
 XhlqvW8R38UvTKfuOKYM4U8FjttA+LC319F73dSL2q1oaYiHyl7IFHQNfRzJB6DEvkCr
 WBw9ERFllz9dAcVcDTtX6ixI8TGNFWs238R37lTFFMtTOgTsQKuif183pW6vIxDO6VrH
 IRc4pSRlEhHlW2GtyTtJFQZfwKxMIXcFohGmeP3RYGw9cswseI0c/VNWQS84ydjxRq7P
 KYaUwyTPqXmkvbyZ5Yb7FITQtQ1OKuIY1PlKlZY0Rf2OgiVaMGN8ylcKefQSE0fsHzW/
 Dw8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=TKWYuy5e1a7MVcCONh10ek8WRVjfZhF24M6h3yAlFXg=;
 b=av395XBrKZkC9Mec79jKh47FJqW4NhfxgNek0dDVgd+cGfb5BScVN3+UT6nNfirtGm
 PceQ9tIPByHtGw1+uWjaoxCRkYBHtwHtA6j6KSyd3fp3VYDYjEwTQ7q1TifZza0OzxSr
 xVMk2O6Eylg1cgL/Jd3yw+d3HKHJO4bA71DBiWuVjcBM4bkPK/EZ8uTs6pzMp8MP2/sH
 teORBzlIm8nC/D/H3fNBV15mnOPMDkOkX5L14lYdqagEkd/ZIwerdS5gjqA/IpSE1vJL
 6JoOzMWvK/50Y8EgIw9+fjZSXthyyUdRx98g3sLTS6JRInQjwUpxlo6FfepI7TcEIXBA
 qTig==
X-Gm-Message-State: AOAM533xs9Sz2ji+QA83XRL54zVX6Iml4YgZWn1Wyt6v3PQxp++JNwrg
 gQ8CEBipXESda/ytTp9Bb0NgGQ==
X-Google-Smtp-Source: ABdhPJyD6eRonZHgh1jOYg+fLrjyl1AjpTN9fePZXHfySYYUG9aFbvN7EU/RT7evtxyZw9yAjqjYDw==
X-Received: by 2002:a05:600c:1909:: with SMTP id
 j9mr9652038wmq.100.1622219171653; 
 Fri, 28 May 2021 09:26:11 -0700 (PDT)
Received: from myrica (adsl-84-226-106-126.adslplus.ch. [84.226.106.126])
 by smtp.gmail.com with ESMTPSA id b15sm7953338wru.64.2021.05.28.09.26.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 May 2021 09:26:11 -0700 (PDT)
Date: Fri, 28 May 2021 18:25:52 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH v4 21/26] iommu/arm-smmu-v3: Ratelimit event dump
Message-ID: <YLEZkGjtkSQu/NP+@myrica>
References: <20200224182401.353359-1-jean-philippe@linaro.org>
 <20200224182401.353359-22-jean-philippe@linaro.org>
 <20210528080958.GA60351@darkstar.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210528080958.GA60351@darkstar.musicnaut.iki.fi>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, kevin.tian@intel.com,
 will@kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, robh+dt@kernel.org, catalin.marinas@arm.com,
 zhangfei.gao@linaro.org, robin.murphy@arm.com, christian.koenig@amd.com,
 linux-arm-kernel@lists.infradead.org
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

Hi Aaro,

On Fri, May 28, 2021 at 11:09:58AM +0300, Aaro Koskinen wrote:
> Hi,
> 
> On Mon, Feb 24, 2020 at 07:23:56PM +0100, Jean-Philippe Brucker wrote:
> > When a device or driver misbehaves, it is possible to receive events
> > much faster than we can print them out. Ratelimit the printing of
> > events.
> > 
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> 
> Tested-by: Aaro Koskinen <aaro.koskinen@nokia.com>
> 
> > During the SVA tests when the device driver didn't properly stop DMA
> > before unbinding, the event queue thread would almost lock-up the server
> > with a flood of event 0xa. This patch helped recover from the error.
> 
> I was just debugging a similar case, and this patch was required to
> prevent system from locking up.
> 
> Could you please resend this patch independently from the other patches
> in the series, as it seems it's a worthwhile fix and still relevent for
> current kernels. Thanks,

Ok, I'll resend it

Thanks,
Jean

> 
> A.
> 
> > ---
> >  drivers/iommu/arm-smmu-v3.c | 13 ++++++++-----
> >  1 file changed, 8 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> > index 28f8583cd47b..6a5987cce03f 100644
> > --- a/drivers/iommu/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm-smmu-v3.c
> > @@ -2243,17 +2243,20 @@ static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
> >  	struct arm_smmu_device *smmu = dev;
> >  	struct arm_smmu_queue *q = &smmu->evtq.q;
> >  	struct arm_smmu_ll_queue *llq = &q->llq;
> > +	static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL,
> > +				      DEFAULT_RATELIMIT_BURST);
> >  	u64 evt[EVTQ_ENT_DWORDS];
> >  
> >  	do {
> >  		while (!queue_remove_raw(q, evt)) {
> >  			u8 id = FIELD_GET(EVTQ_0_ID, evt[0]);
> >  
> > -			dev_info(smmu->dev, "event 0x%02x received:\n", id);
> > -			for (i = 0; i < ARRAY_SIZE(evt); ++i)
> > -				dev_info(smmu->dev, "\t0x%016llx\n",
> > -					 (unsigned long long)evt[i]);
> > -
> > +			if (__ratelimit(&rs)) {
> > +				dev_info(smmu->dev, "event 0x%02x received:\n", id);
> > +				for (i = 0; i < ARRAY_SIZE(evt); ++i)
> > +					dev_info(smmu->dev, "\t0x%016llx\n",
> > +						 (unsigned long long)evt[i]);
> > +			}
> >  		}
> >  
> >  		/*
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
