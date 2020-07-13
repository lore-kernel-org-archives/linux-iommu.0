Return-Path: <SRS0=SFHS=AY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2EC0C433EA
	for <iommu@archiver.kernel.org>; Mon, 13 Jul 2020 19:03:42 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B4692067D
	for <iommu@archiver.kernel.org>; Mon, 13 Jul 2020 19:03:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZRkkfyHl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B4692067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 637FF896CD;
	Mon, 13 Jul 2020 19:03:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 25kMF9f6gSlZ; Mon, 13 Jul 2020 19:03:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id B9DB089563;
	Mon, 13 Jul 2020 19:03:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 90ED2C088E;
	Mon, 13 Jul 2020 19:03:41 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D784AC0733
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jul 2020 19:03:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 92F5627344
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jul 2020 19:03:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vMqpxBHTyW0q for <iommu@lists.linux-foundation.org>;
 Mon, 13 Jul 2020 19:03:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id DDF5E272E1
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jul 2020 19:03:37 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 546AB2076D;
 Mon, 13 Jul 2020 19:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1594667017;
 bh=ERBn/pr30RWxSObAL8l85+l8FNMMvON1Mype8up0/AU=;
 h=Date:From:To:Subject:References:In-Reply-To:From;
 b=ZRkkfyHleaBZp0Vfs5JuTH7gBkWzJb7TMWx0WfrKq+JjCqOf1Cx7Ql0CUe4pWmfLI
 1kkyv0RegppAo0t0BoBRlbfvvgEAp01WhxSclT1eANlzJBCgTY/hSn6fOeJh7PLkN5
 PGkqMoZ8H4S5VF0WBd+pUcrT6irlu//cQU3Ak/MI=
Date: Mon, 13 Jul 2020 20:03:32 +0100
From: Will Deacon <will@kernel.org>
To: linux-arm-msm@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
 Robin Murphy <robin.murphy@arm.com>,
 freedreno@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu: Add a init_context_bank implementation
 hook
Message-ID: <20200713190331.GA3444@willie-the-truck>
References: <20200611223656.4724-1-jcrouse@codeaurora.org>
 <20200713151123.GB3072@willie-the-truck>
 <20200713170032.GH21059@jcrouse1-lnx.qualcomm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200713170032.GH21059@jcrouse1-lnx.qualcomm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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

On Mon, Jul 13, 2020 at 11:00:32AM -0600, Jordan Crouse wrote:
> On Mon, Jul 13, 2020 at 04:11:23PM +0100, Will Deacon wrote:
> > On Thu, Jun 11, 2020 at 04:36:56PM -0600, Jordan Crouse wrote:
> > > Add a new implementation hook to allow the implementation specific code
> > > to tweek the context bank configuration just before it gets written.
> > > The first user will be the Adreno GPU implementation to turn on
> > > SCTLR.HUPCF to ensure that a page fault doesn't terminating pending
> > > transactions. Doing so could hang the GPU if one of the terminated
> > > transactions is a CP read.
> > > 
> > > This depends on the arm-smmu adreno SMMU implementation [1].
> > > 
> > > [1] https://patchwork.kernel.org/patch/11600943/
> > > 
> > > Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> > > ---
> > > 
> > >  drivers/iommu/arm-smmu-qcom.c | 13 +++++++++++++
> > >  drivers/iommu/arm-smmu.c      | 28 +++++++++++++---------------
> > >  drivers/iommu/arm-smmu.h      | 11 +++++++++++
> > >  3 files changed, 37 insertions(+), 15 deletions(-)
> > 
> > This looks straightforward enough, but I don't want to merge this without
> > a user and Sai's series has open questions afaict.
> 
> Not sure what you mean by a user in this context?
> Are you referring to https://patchwork.kernel.org/patch/11628541/?

Right, this post was just a single patch in isolation, whereas it was
reposted over at:

https://lore.kernel.org/r/cdcc6a1c95a84e774790389dc8b3b7feeee490dc.1593344119.git.saiprakash.ranjan@codeaurora.org

so I'll ignore this one. Sorry, I'm just really struggling to keep track
of what is targetting 5.9, and I don't have tonnes of time to sift through
the backlog of duplicate postings :(

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
