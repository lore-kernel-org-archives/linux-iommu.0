Return-Path: <SRS0=UphA=BH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A21DFC433DF
	for <iommu@archiver.kernel.org>; Tue, 28 Jul 2020 12:49:23 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73486206D7
	for <iommu@archiver.kernel.org>; Tue, 28 Jul 2020 12:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qSq1O3vr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73486206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3FB0787A0D;
	Tue, 28 Jul 2020 12:49:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5KML2ay1K7FS; Tue, 28 Jul 2020 12:49:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id B0BCA876CF;
	Tue, 28 Jul 2020 12:49:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A84E6C0050;
	Tue, 28 Jul 2020 12:49:22 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BBCF4C004D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jul 2020 12:49:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id A96A3233ED
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jul 2020 12:49:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nl5vsXAwXLJd for <iommu@lists.linux-foundation.org>;
 Tue, 28 Jul 2020 12:49:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
 [209.85.128.68])
 by silver.osuosl.org (Postfix) with ESMTPS id 639E42013C
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jul 2020 12:49:19 +0000 (UTC)
Received: by mail-wm1-f68.google.com with SMTP id d190so564540wmd.4
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jul 2020 05:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=563GAo9gKuT0AKRtxTEqoPLHerqlMxrPbkrlrOCDFYw=;
 b=qSq1O3vrQ/Y2T6GQNexhBU764AjJjOQtxxtONMkq2zj5yUyiYw60j08pG6BSeDas5Q
 fJoytaDNwDJjXVCrfoFUEzgqDbMsDZSsrDyJA/v57qeyqWmu7RVv4+KcKBRCCgPPxXKs
 IMx1Gw5CMjzyovzCtDkoxc6hyT3BlUSarfjTAczejW8+SR7CbFKni1xNeIlTmLLWyH6g
 pFXrbIBSNXxjia75qDr+enP+jNFyL1lCZzdY75s/84ULrMo0unXM0WQwppisybRgbfng
 iuwwRRTlgXkSbAyIPf3eerRdKG3oBLTTKfLszfeXfgNyVJ1ng9+kzxIIPn7lCRB6szeF
 DM8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=563GAo9gKuT0AKRtxTEqoPLHerqlMxrPbkrlrOCDFYw=;
 b=LeCmk4lUKkU56b620L7BLgfCLW38N1QuyJTGjOgD4A63qVLYRRhR72+QXeHmtkcG2D
 igDQftL0dlTnb/uMG6ueAIptEfDtFr9uQwHO+RWlD5E3y6gWCq1ceFNQVKFM3DoX4kfr
 bIUbcKnLBbbxAcxqPeO5KazLcwMU1ulbbfRMwSNYiumIW+gJ310L/2X5wiHSYO20tk04
 WTDTnIP0aOWGJTU9xVf7DidEZLjhXYlrCivPMWOPSrSFV75zIXyOjcVgCvRhy/+2o2fC
 tvdqd3E2eqXBHN8oz87pJwjGdXjvDdYJ55uBGRZGSoTgUdqF4SP5/CwVsWmGd3cLUcYS
 zxsA==
X-Gm-Message-State: AOAM530XyYLPuHszCfrdPl7YtbGAvBSAajX83Cgd1pGZahfyz+kiBXWI
 oRc+Bsz3nadVcvRpMqayIH5WBejLxKZs5YCmHA2UqA==
X-Google-Smtp-Source: ABdhPJyadO5w+1PGVxJYg7a6olB2hSpL99Mg/7IFEhs5VIWgnkGsm2XwbpBJXtFwoCFzMep87tfTqvbL1OTJ1KULbuo=
X-Received: by 2002:a1c:5a41:: with SMTP id o62mr3966629wmb.16.1595940557819; 
 Tue, 28 Jul 2020 05:49:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200728104742.422960-1-hch@lst.de>
 <CAMi1Hd3=6ZZykF1yx_CChqx71k6T-wj12TzJiz_uJZbwrEtTXw@mail.gmail.com>
 <20200728120716.GA2507@lst.de>
 <CAMi1Hd1c3cNMYg+S5Pwuv30QCdcWJw+QxkWmNP34s3nb+_yUuA@mail.gmail.com>
 <20200728124114.GA4865@lst.de>
In-Reply-To: <20200728124114.GA4865@lst.de>
From: Amit Pundir <amit.pundir@linaro.org>
Date: Tue, 28 Jul 2020 18:18:41 +0530
Message-ID: <CAMi1Hd0wpcLVJ41h6gs4H0WEDVpNEs7N=wx+KQ_yRKeSv0kQ9g@mail.gmail.com>
Subject: Re: dma-pool fixes
To: Christoph Hellwig <hch@lst.de>
Cc: jeremy.linton@arm.com, iommu@lists.linux-foundation.org,
 linux-rpi-kernel@lists.infradead.org, David Rientjes <rientjes@google.com>,
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

On Tue, 28 Jul 2020 at 18:11, Christoph Hellwig <hch@lst.de> wrote:
>
> On Tue, Jul 28, 2020 at 05:55:30PM +0530, Amit Pundir wrote:
> > On Tue, 28 Jul 2020 at 17:37, Christoph Hellwig <hch@lst.de> wrote:
> > >
> > > On Tue, Jul 28, 2020 at 05:32:56PM +0530, Amit Pundir wrote:
> > > > > can you try these two patches?  The first one makes sure we don't apply
> > > > > physical address based checks for IOMMU allocations, and the second one
> > > > > is a slightly tweaked version of the patch from Nicolas to allow dipping
> > > > > into the CMA areas for allocations to expand the atomic pools.
> > > >
> > > > Sorry, verified a couple of times but these two patches are not working
> > > > for me. I'm stuck at the bootloader splash screen on my phone.
> > >
> > > Thanks for testing.  The only intended functional change compared to
> > > Fridays patch was the issue Nicolas pointed out.  Can you try this hack
> > > on top?
> >
> > Yes, that worked.
>
> Oh well, this leaves me confused again.  It looks like your setup
> really needs a CMA in zone normal for the dma or dma32 pool.

Anything I should look up in the downstream kernel/dts?

Regards,
Amit Pundir
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
