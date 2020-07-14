Return-Path: <SRS0=v902=AZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F2A9C433E6
	for <iommu@archiver.kernel.org>; Tue, 14 Jul 2020 04:38:23 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A64F621D90
	for <iommu@archiver.kernel.org>; Tue, 14 Jul 2020 04:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="OKdw876N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A64F621D90
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 71AC289214;
	Tue, 14 Jul 2020 04:38:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9ux4PJYT33ZW; Tue, 14 Jul 2020 04:38:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id CB8108919E;
	Tue, 14 Jul 2020 04:38:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A0B90C088E;
	Tue, 14 Jul 2020 04:38:21 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8BF70C0733
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jul 2020 04:38:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 682DB8A78D
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jul 2020 04:38:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KTAO6O1PZ8vx for <iommu@lists.linux-foundation.org>;
 Tue, 14 Jul 2020 04:38:19 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail29.static.mailgun.info (mail29.static.mailgun.info
 [104.130.122.29])
 by hemlock.osuosl.org (Postfix) with ESMTPS id D7BBA8A19E
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jul 2020 04:38:14 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1594701499; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=l+SKEtwEvXbX8Q/Z4ekeTlZzRX1TnFGS7mEIQl2l3LY=;
 b=OKdw876NL3ee/n3yOxFYW0TgTlxLRS7gNlFukJItLcSTa699S1zPW6PsyA7t0OZ5cukzCuPt
 zZ7gvnP0DE068Y+YngqHwaKrVACaG/dXd6h6W6jV6SXNvM1ByUTTU/s6NMLcfjt8CjQcj0sR
 A1OAixPt8WpyoKfWBGZA7tl3d1A=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n15.prod.us-west-2.postgun.com with SMTP id
 5f0d36a58e36ecda309917a3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 14 Jul 2020 04:37:57
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 8832EC433A0; Tue, 14 Jul 2020 04:37:57 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id B5890C433C8;
 Tue, 14 Jul 2020 04:37:56 +0000 (UTC)
MIME-Version: 1.0
Date: Tue, 14 Jul 2020 10:07:56 +0530
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: Will Deacon <will@kernel.org>, Jordan Crouse <jcrouse@codeaurora.org>
Subject: Re: [Freedreno] [PATCH] iommu/arm-smmu: Add a init_context_bank
 implementation hook
In-Reply-To: <20200713191310.GD3815@jcrouse1-lnx.qualcomm.com>
References: <20200611223656.4724-1-jcrouse@codeaurora.org>
 <20200713151123.GB3072@willie-the-truck>
 <20200713170032.GH21059@jcrouse1-lnx.qualcomm.com>
 <20200713190331.GA3444@willie-the-truck>
 <20200713191310.GD3815@jcrouse1-lnx.qualcomm.com>
Message-ID: <928c0e7a22e9b193774b1e35fbe98762@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2020-07-14 00:43, Jordan Crouse wrote:
> On Mon, Jul 13, 2020 at 08:03:32PM +0100, Will Deacon wrote:
>> On Mon, Jul 13, 2020 at 11:00:32AM -0600, Jordan Crouse wrote:
>> > On Mon, Jul 13, 2020 at 04:11:23PM +0100, Will Deacon wrote:
>> > > On Thu, Jun 11, 2020 at 04:36:56PM -0600, Jordan Crouse wrote:
>> > > > Add a new implementation hook to allow the implementation specific code
>> > > > to tweek the context bank configuration just before it gets written.
>> > > > The first user will be the Adreno GPU implementation to turn on
>> > > > SCTLR.HUPCF to ensure that a page fault doesn't terminating pending
>> > > > transactions. Doing so could hang the GPU if one of the terminated
>> > > > transactions is a CP read.
>> > > >
>> > > > This depends on the arm-smmu adreno SMMU implementation [1].
>> > > >
>> > > > [1] https://patchwork.kernel.org/patch/11600943/
>> > > >
>> > > > Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
>> > > > ---
>> > > >
>> > > >  drivers/iommu/arm-smmu-qcom.c | 13 +++++++++++++
>> > > >  drivers/iommu/arm-smmu.c      | 28 +++++++++++++---------------
>> > > >  drivers/iommu/arm-smmu.h      | 11 +++++++++++
>> > > >  3 files changed, 37 insertions(+), 15 deletions(-)
>> > >
>> > > This looks straightforward enough, but I don't want to merge this without
>> > > a user and Sai's series has open questions afaict.
>> >
>> > Not sure what you mean by a user in this context?
>> > Are you referring to https://patchwork.kernel.org/patch/11628541/?
>> 
>> Right, this post was just a single patch in isolation, whereas it was
>> reposted over at:
>> 
>> https://lore.kernel.org/r/cdcc6a1c95a84e774790389dc8b3b7feeee490dc.1593344119.git.saiprakash.ranjan@codeaurora.org
>> 
>> so I'll ignore this one. Sorry, I'm just really struggling to keep 
>> track
>> of what is targetting 5.9, and I don't have tonnes of time to sift 
>> through
>> the backlog of duplicate postings :(
> 
> Yeah, that is our fault. There are too many cooks in the kitchen.
> 
> We need to pick either system cache or split pagetable and serialize
> the other on top of it to get the impl code going and then build from 
> there.
> This particular patch can happily hang out in the background until the 
> rest is
> resolved.
> 

My bad, sorry. Let us get split pagetable support reviewed first, then I 
can post
system cache support on top of it. As jordan said, this patch can 
hibernate until
those get resolved.

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member
of Code Aurora Forum, hosted by The Linux Foundation
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
