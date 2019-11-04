Return-Path: <SRS0=uwQI=Y4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC921CA9ECF
	for <iommu@archiver.kernel.org>; Mon,  4 Nov 2019 15:15:14 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A64A520663
	for <iommu@archiver.kernel.org>; Mon,  4 Nov 2019 15:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SDuuFx6m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A64A520663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 793F9DD9;
	Mon,  4 Nov 2019 15:15:14 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 2F372DCE
	for <iommu@lists.linux-foundation.org>;
	Mon,  4 Nov 2019 15:15:13 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id DAE2C8A7
	for <iommu@lists.linux-foundation.org>;
	Mon,  4 Nov 2019 15:15:12 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
	bits)) (No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id C8326204FD;
	Mon,  4 Nov 2019 15:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572880512;
	bh=ZQlZhQmX7lrYzQG5MYT2kNnnAWDZXCmqTEyk5dpG6Z8=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=SDuuFx6ma6buOc+UZ2Fh9kNciDW/4g2aAwViZ/tAscQkpDDk2X/khHATq0qDYJ90k
	NulUdDwv/cXglMaXefarN2Soxxqf1LYzANjZX1PHaMWRxnKCdHNNH6xOJG2CohcZ5d
	cPoyCT5mnasLG2pBFi6C9AM3BQbIzgJHQH1RFw2k=
Date: Mon, 4 Nov 2019 15:15:07 +0000
From: Will Deacon <will@kernel.org>
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
	bjorn.andersson@linaro.org, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
	Stephen Boyd <swboyd@chromium.org>,
	Vivek Gautam <vivek.gautam@codeaurora.org>,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Rajendra Nayak <rnayak@codeaurora.org>, linux-arm-msm-owner@vger.kernel.org
Subject: Re: [PATCHv7 0/3] QCOM smmu-500 wait-for-safe handling for sdm845
Message-ID: <20191104151506.GB24909@willie-the-truck>
References: <cover.1568966170.git.saiprakash.ranjan@codeaurora.org>
	<20191101163136.GC3603@willie-the-truck>
	<af7e9a14ae7512665f0cae32e08c8b06@codeaurora.org>
	<20191101172508.GB3983@willie-the-truck>
	<119d4bcf5989d1aa0686fd674c6a3370@codeaurora.org>
	<20191104051925.GC5299@hector.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191104051925.GC5299@hector.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Sun, Nov 03, 2019 at 11:19:25PM -0600, Andy Gross wrote:
> On Fri, Nov 01, 2019 at 11:01:59PM +0530, Sai Prakash Ranjan wrote:
> > >>> What's the plan for getting this merged? I'm not happy taking the
> > >>> firmware
> > >>> bits without Andy's ack, but I also think the SMMU changes should go via
> > >>> the IOMMU tree to avoid conflicts.
> > >>>
> > >>> Andy?
> > >>>
> > >>
> > >>Bjorn maintains QCOM stuff now if I am not wrong and he has already
> > >>reviewed
> > >>the firmware bits. So I'm hoping you could take all these through IOMMU
> > >>tree.
> > >
> > >Oh, I didn't realise that. Is there a MAINTAINERS update someplace? If I
> > >run:
> > >
> > >$ ./scripts/get_maintainer.pl -f drivers/firmware/qcom_scm-64.c
> > >
> > >in linux-next, I get:
> > >
> > >Andy Gross <agross@kernel.org> (maintainer:ARM/QUALCOMM SUPPORT)
> > >linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT)
> > >linux-kernel@vger.kernel.org (open list)
> > >
> > 
> > It hasn't been updated yet then. I will leave it to Bjorn or Andy to comment
> > on this.
> 
> The rumors of my demise have been greatly exaggerated.  All kidding aside, I
> ack'ed both.  Bjorn will indeed be coming on as a co-maintener at some point.
> He has already done a lot of yeomans work in helping me out the past 3 months.

Cheers Andy, and I'm pleased to hear that you're still with us! I've queued
this lot for 5.5 and I'll send to Joerg this week.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
