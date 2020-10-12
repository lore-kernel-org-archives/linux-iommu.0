Return-Path: <SRS0=a71q=DT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F248C433E7
	for <iommu@archiver.kernel.org>; Mon, 12 Oct 2020 07:32:01 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19406207FF
	for <iommu@archiver.kernel.org>; Mon, 12 Oct 2020 07:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b0UFofGe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19406207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id B768D86995;
	Mon, 12 Oct 2020 07:32:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kkgwINVptEp7; Mon, 12 Oct 2020 07:31:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8D73386992;
	Mon, 12 Oct 2020 07:31:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7F434C07FF;
	Mon, 12 Oct 2020 07:31:59 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 201E8C0051
 for <iommu@lists.linux-foundation.org>; Mon, 12 Oct 2020 07:31:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id F217A2076E
 for <iommu@lists.linux-foundation.org>; Mon, 12 Oct 2020 07:31:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jk8nsV5RNmAz for <iommu@lists.linux-foundation.org>;
 Mon, 12 Oct 2020 07:31:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com
 [209.85.208.66])
 by silver.osuosl.org (Postfix) with ESMTPS id 6E44520555
 for <iommu@lists.linux-foundation.org>; Mon, 12 Oct 2020 07:31:56 +0000 (UTC)
Received: by mail-ed1-f66.google.com with SMTP id o18so15858809edq.4
 for <iommu@lists.linux-foundation.org>; Mon, 12 Oct 2020 00:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=CzDxLaDLFJzWcap/ARMkfpBesRsQ6cFDLsAfzEHhwNg=;
 b=b0UFofGey9MHN4SSKeWJne/jISh0kZ4rKs08Umat1GtUhptcnknv3VsZFMe74YDxK8
 +JFbEMLjSb3QLuIDhnLOtzA8nFoFEAtB07cpzErKshtf7030J2/yyB2L8QDfIJM6IFMG
 wOgjFRhEoC0PoIJ1v5e52Av5WQBBAKNAChPIDSvM3CHvCIEEA1uWvjmJ9cXZJvrc70R2
 DbQR1JXv2jr8nGlgyMO1cZ1JtR6tayglpD8EwubGrKVXQgUgRCvptXMtyhJBm+3VbHFc
 qPo/L0Y73MO+zXoSQ+VKiA4TKFVoReqFKJE9CBqM6095iH22+gT3A2xMNboe/ZQxGfxl
 uF3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=CzDxLaDLFJzWcap/ARMkfpBesRsQ6cFDLsAfzEHhwNg=;
 b=c229uEjeYOhS08Y1UyCsgXjVEOWFGKCS3fgdzmz4YpjgbBd8zN3IZw7rHQ8dJrw7bF
 11c4OQjeLCiRe9BfrJbXFECZl1ZnDG5iFW1GNR/ggwZddmh9MtrglcAXVrx/CF45YQ1C
 C24gcdBGDIFUJ0wAFr9+35RJTlc4sxvYweUsQePjXRix8Z73zKk1UC6eb198z+d3bdTS
 pr3ufXu4aodePKsm/Ru+rTBYs5wev95tPezcEE+zrXchykviIq14SoT30ZRgndYWSSJJ
 H5joZPCgdLBDxklJaNLBJaYGeSvSHT63bP8DIhKduo4pDWttjGpf8LafuwQnKciElGbz
 Z6sQ==
X-Gm-Message-State: AOAM531aNP3O4WPDwxCsuoKbtjIMlrO5az+0LiqM72SNC5FhxmxZP938
 lFXEIJzP1ohE+WeqHP+rD4Ep7A==
X-Google-Smtp-Source: ABdhPJxaZ45/LGCB6zLJp30ygGXXJGsXRsI9tcD8xqo9itEMOS9n1yfi201ECa1UI9OmrMS8rBHpBg==
X-Received: by 2002:aa7:dcc7:: with SMTP id w7mr12914876edu.80.1602487914471; 
 Mon, 12 Oct 2020 00:31:54 -0700 (PDT)
Received: from yoga ([194.182.8.81])
 by smtp.gmail.com with ESMTPSA id n22sm10021525eji.106.2020.10.12.00.31.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 00:31:53 -0700 (PDT)
Date: Mon, 12 Oct 2020 09:31:52 +0200
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCH v3 6/8] iommu/arm-smmu: Add impl hook for inherit boot
 mappings
Message-ID: <20201012073152.GA2998@yoga>
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

On Mon 21 Sep 23:08 CEST 2020, Will Deacon wrote:

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

Finally got a chance to dig through this properly.

Initial results where positive and with an implementation of cfg_probe
in qcom_smmu_impl I'm able to probe the arm-smmu driver just fine - and
display (e.g. efifb) stays alive.

Unfortunately as the display driver (drivers/gpu/drm/msm) is about to
probe a new iommu domain is created, which due to its match against
qcom_smmu_client_of_match[] becomes of type IOMMU_DOMAIN_IDENTITY.
This results in a S2CR of BYPASS type, which the firmware intercepts and
turns the stream into a type FAULT.

So while the cfg_probe looks very reasonable we're still in need of a
mechanism to use the fake identity context for the iommu domain
associated with the display controller.


The workings of the display driver is that it gets the iommu domain
setup for byass and then after that creates a translation context for
this same stream where it maps the framebuffer.

For testing purposes I made def_domain_type always return 0 in the qcom
impl and the result is that we get a few page faults while probing the
display driver, but these are handled somewhat gracefully and the
initialization did proceed and the system comes up nicely (but in the
case that the display driver would probe defer this leads to an storm of
faults as the screen continues to be refreshed).

TL;DR I think we still need to have a way to get the arm-smmu driver to
allow the qcom implementation to configure identity domains to use
translation - but we can make the setup of the identity context a detail
of the qcom driver.

Regards,
Bjorn
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
