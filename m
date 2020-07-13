Return-Path: <SRS0=SFHS=AY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03EA1C433E1
	for <iommu@archiver.kernel.org>; Mon, 13 Jul 2020 19:13:22 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C216220758
	for <iommu@archiver.kernel.org>; Mon, 13 Jul 2020 19:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="ZVwFIJQo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C216220758
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9754387DEA;
	Mon, 13 Jul 2020 19:13:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id floveq7gfa4V; Mon, 13 Jul 2020 19:13:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D925F87BB0;
	Mon, 13 Jul 2020 19:13:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ADD0EC0888;
	Mon, 13 Jul 2020 19:13:20 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3A04BC0733
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jul 2020 19:13:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 2C59B89DE9
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jul 2020 19:13:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UXKYuy3tf+O0 for <iommu@lists.linux-foundation.org>;
 Mon, 13 Jul 2020 19:13:18 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from m43-7.mailgun.net (m43-7.mailgun.net [69.72.43.7])
 by whitealder.osuosl.org (Postfix) with ESMTPS id BD26487F44
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jul 2020 19:13:17 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1594667598; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=8fx4I85o6Wf3cmctscltFFb3YOaN1s6FZjMVuu5Dadc=;
 b=ZVwFIJQoATQzVrirMzr8ZzwU+uAmoRSAQmYepmH7yjsIU/R/eQ66oNVlXTGjLQmRZwbz+b7C
 25Ie5detrGZfBjTe+0h4joyulyiB0qcVXT7AjoOjopw+N81mNZpCi2hYNCW2otQqhi5NVMhZ
 6NCNUBRPGHm5WUHcxKv4m798eO4=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 5f0cb24b10127684903d18f6 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 13 Jul 2020 19:13:15
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 3FCD0C43395; Mon, 13 Jul 2020 19:13:15 +0000 (UTC)
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: jcrouse)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id C4B6FC433C8;
 Mon, 13 Jul 2020 19:13:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C4B6FC433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date: Mon, 13 Jul 2020 13:13:10 -0600
From: Jordan Crouse <jcrouse@codeaurora.org>
To: Will Deacon <will@kernel.org>
Subject: Re: [Freedreno] [PATCH] iommu/arm-smmu: Add a init_context_bank
 implementation hook
Message-ID: <20200713191310.GD3815@jcrouse1-lnx.qualcomm.com>
Mail-Followup-To: Will Deacon <will@kernel.org>,
 linux-arm-msm@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
 Robin Murphy <robin.murphy@arm.com>,
 freedreno@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200611223656.4724-1-jcrouse@codeaurora.org>
 <20200713151123.GB3072@willie-the-truck>
 <20200713170032.GH21059@jcrouse1-lnx.qualcomm.com>
 <20200713190331.GA3444@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200713190331.GA3444@willie-the-truck>
User-Agent: Mutt/1.5.24 (2015-08-30)
Cc: linux-arm-msm@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org
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

On Mon, Jul 13, 2020 at 08:03:32PM +0100, Will Deacon wrote:
> On Mon, Jul 13, 2020 at 11:00:32AM -0600, Jordan Crouse wrote:
> > On Mon, Jul 13, 2020 at 04:11:23PM +0100, Will Deacon wrote:
> > > On Thu, Jun 11, 2020 at 04:36:56PM -0600, Jordan Crouse wrote:
> > > > Add a new implementation hook to allow the implementation specific code
> > > > to tweek the context bank configuration just before it gets written.
> > > > The first user will be the Adreno GPU implementation to turn on
> > > > SCTLR.HUPCF to ensure that a page fault doesn't terminating pending
> > > > transactions. Doing so could hang the GPU if one of the terminated
> > > > transactions is a CP read.
> > > > 
> > > > This depends on the arm-smmu adreno SMMU implementation [1].
> > > > 
> > > > [1] https://patchwork.kernel.org/patch/11600943/
> > > > 
> > > > Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> > > > ---
> > > > 
> > > >  drivers/iommu/arm-smmu-qcom.c | 13 +++++++++++++
> > > >  drivers/iommu/arm-smmu.c      | 28 +++++++++++++---------------
> > > >  drivers/iommu/arm-smmu.h      | 11 +++++++++++
> > > >  3 files changed, 37 insertions(+), 15 deletions(-)
> > > 
> > > This looks straightforward enough, but I don't want to merge this without
> > > a user and Sai's series has open questions afaict.
> > 
> > Not sure what you mean by a user in this context?
> > Are you referring to https://patchwork.kernel.org/patch/11628541/?
> 
> Right, this post was just a single patch in isolation, whereas it was
> reposted over at:
> 
> https://lore.kernel.org/r/cdcc6a1c95a84e774790389dc8b3b7feeee490dc.1593344119.git.saiprakash.ranjan@codeaurora.org
> 
> so I'll ignore this one. Sorry, I'm just really struggling to keep track
> of what is targetting 5.9, and I don't have tonnes of time to sift through
> the backlog of duplicate postings :(

Yeah, that is our fault. There are too many cooks in the kitchen.

We need to pick either system cache or split pagetable and serialize
the other on top of it to get the impl code going and then build from there. 
This particular patch can happily hang out in the background until the rest is
resolved.

Jordan

> Will
> _______________________________________________
> Freedreno mailing list
> Freedreno@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/freedreno

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
