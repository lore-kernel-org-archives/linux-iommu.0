Return-Path: <SRS0=ygJE=DB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5447C4346E
	for <iommu@archiver.kernel.org>; Thu, 24 Sep 2020 15:55:17 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06D58238A1
	for <iommu@archiver.kernel.org>; Thu, 24 Sep 2020 15:55:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VuYM/Sxt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06D58238A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 950992E11D;
	Thu, 24 Sep 2020 15:55:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BgFEUIavB5Es; Thu, 24 Sep 2020 15:55:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 693DC2E10B;
	Thu, 24 Sep 2020 15:55:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5D8A8C0890;
	Thu, 24 Sep 2020 15:55:14 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4242EC0859
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 15:55:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 19A232E112
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 15:55:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cdOv04jKlxjc for <iommu@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 15:55:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com
 [209.85.210.65])
 by silver.osuosl.org (Postfix) with ESMTPS id B507F2E0FE
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 15:55:11 +0000 (UTC)
Received: by mail-ot1-f65.google.com with SMTP id q21so3607220ota.8
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 08:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=BFQYGakvszSZQYEiK77qmVljG0V+wrRK/T3GO3bZxA4=;
 b=VuYM/Sxtj92l9I7qft+wT7jbFfT5vZNLK8wgvLXr8W0wjputBXVcePPAvaI+sKwdv2
 bH4N0JJWo33SnqLzRC1fZbF0hRkFxmfqgEc4IHi1hVHB3Fy5EsfE6p2K8PvvMTwvUO6b
 9dUZIZYKqOWqyX/6f49oJ2/bXQPDOhNowqmZNQr3+sWHQqVSXVZnFVVpP3cc4ixi06m+
 TyS7AJO+fPZVMp/o356dNl29HmfqXU3xV/wr1dPTCU9YV33lDqN3S/FcY7VoNLuqRiDr
 T76jWbUSgh9HkVtgoxw65kl9/4u2P6dZIejODFmlWo6SkLGdgLmwrtvRTusn5irWQFTB
 Tc/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=BFQYGakvszSZQYEiK77qmVljG0V+wrRK/T3GO3bZxA4=;
 b=roX2aQLYr/LShgBfS2hVyipdYSimG/zuAQUczIJfYYAdsHhJgQlMNKHazIFV271CUO
 gkaqDH/m+PP1agbTOyrHhF2L//eW4UfMez2ZI3OFcsF27GGX3Ezydph14cSMUuYNDflO
 nywpFBDwDBK3110Q/ZJPTE3SMBkgGPHwY5xUWSrUcSZxGawzl7rNwkYs0JS1j3rjHVw/
 4mGI/28GL2nDf+Dah9XsOC+hF+q7PM/Gf4tuP6ddS+bsS15lypZuSbbtBIC+eBHz1b1H
 grXegZVvmWLc6d/mW8wP2n4Ldat/bUgL0F/DbY1KuF3JbPMb5x1TvGQAkIu4qRNJ/5K6
 lmzQ==
X-Gm-Message-State: AOAM532s91N0mJTGxEkgBQOz0lK28PwnOphFtXSI9m3zgBZj2WKfe0RX
 Y/rSE523aXhG9TvQjVjqaDzcOw==
X-Google-Smtp-Source: ABdhPJwFHBL2FKeccMlXLdOu/LTSXUl23rU0UsGy8dJd/nIuZMvT3wS2wgBvDcqgNEUZ6Q8WAUKisQ==
X-Received: by 2002:a05:6830:610:: with SMTP id
 w16mr178455oti.353.1600962910817; 
 Thu, 24 Sep 2020 08:55:10 -0700 (PDT)
Received: from yoga (99-135-181-32.lightspeed.austtx.sbcglobal.net.
 [99.135.181.32])
 by smtp.gmail.com with ESMTPSA id p8sm907633oot.29.2020.09.24.08.55.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2020 08:55:10 -0700 (PDT)
Date: Thu, 24 Sep 2020 10:55:07 -0500
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCH v3 6/8] iommu/arm-smmu: Add impl hook for inherit boot
 mappings
Message-ID: <20200924155507.GE40811@yoga>
References: <20200904155513.282067-1-bjorn.andersson@linaro.org>
 <20200904155513.282067-7-bjorn.andersson@linaro.org>
 <0bfcc8f7-d054-616b-834b-319461b1ecb9@arm.com>
 <20200913032559.GT3715@yoga>
 <20200921210814.GE3811@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200921210814.GE3811@willie-the-truck>
Cc: Rob Clark <robdclark@chromium.org>, linux-arm-msm@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Sibi Sankar <sibis@codeaurora.org>, Robin Murphy <robin.murphy@arm.com>,
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

On Mon 21 Sep 16:08 CDT 2020, Will Deacon wrote:

> On Sat, Sep 12, 2020 at 10:25:59PM -0500, Bjorn Andersson wrote:
> > On Fri 11 Sep 12:13 CDT 2020, Robin Murphy wrote:
> > > On 2020-09-04 16:55, Bjorn Andersson wrote:
> > > > Add a new operation to allow platform implementations to inherit any
> > > > stream mappings from the boot loader.
> > > 
> > > Is there a reason we need an explicit step for this? The aim of the
> > > cfg_probe hook is that the SMMU software state should all be set up by then,
> > > and you can mess about with it however you like before arm_smmu_reset()
> > > actually commits anything to hardware. I would have thought you could
> > > permanently steal a context bank, configure it as your bypass hole, read out
> > > the previous SME configuration and tweak smmu->smrs and smmu->s2crs
> > > appropriately all together "invisibly" at that point.
> > 
> > I did this because as of 6a79a5a3842b ("iommu/arm-smmu: Call
> > configuration impl hook before consuming features") we no longer have
> > setup pgsize_bitmap as we hit cfg_probe, which means that I need to
> > replicate this logic to set up the iommu_domain.
> > 
> > If I avoid setting up an iommu_domain for the identity context, as you
> > request in patch 8, this shouldn't be needed anymore.
> > 
> > > If that can't work, I'm very curious as to what I've overlooked.
> > > 
> > 
> > I believe that will work, I will rework the patches and try it out.
> 
> Did you get a chance to rework this?
> 

Unfortunately not, I hope to get to this shortly.

Thanks,
Bjorn
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
