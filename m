Return-Path: <SRS0=o4oj=NB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10393C4338F
	for <iommu@archiver.kernel.org>; Tue, 10 Aug 2021 18:08:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B08D260462
	for <iommu@archiver.kernel.org>; Tue, 10 Aug 2021 18:08:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B08D260462
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 729BC4010E;
	Tue, 10 Aug 2021 18:08:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hmQjxcwtN3Ea; Tue, 10 Aug 2021 18:08:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 20446402C3;
	Tue, 10 Aug 2021 18:08:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DD9FBC001A;
	Tue, 10 Aug 2021 18:08:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 11E7EC000E
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 18:08:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id ED9948350D
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 18:08:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 85BeZlrO6YWI for <iommu@lists.linux-foundation.org>;
 Tue, 10 Aug 2021 18:08:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 402CC833A8
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 18:08:34 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id CBEB660527;
 Tue, 10 Aug 2021 18:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1628618913;
 bh=ZLjQ+E7kEbaxwXSfj/EjKh4hS0Qf8184pyly8Dfhtm4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=oHScJLoUWHHobKc83Z0tPXc2r9y0CA/eD2Uok4ZlwwgIe4/UN910YCRxqB6nB0jm9
 URDOjjPcubG2CCDl7foJTCOW1DTzpI1JVLpBiJ62tnRez4aNcMtQovsfsLdlhnSv++
 rv3rqtoByIcxveM+llHj4M5U/Am5K4WjICeUGecvRJjpgoQH6zn/X92o2lfnM67dvc
 MA1oHcn4IUgwXs23F+cF1PlSNWsZYWXgQZuoYSx8GhscV70l+ngNABd44RskpFnKYX
 8Ock0OweYWvcDISqZzYBz9m2ZcCCBTXerF4YzRzGaMk8u2HXkhoCz4VlTwWHY2smk4
 n/ZBHX9SV9UWA==
Date: Tue, 10 Aug 2021 19:08:28 +0100
From: Will Deacon <will@kernel.org>
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: Re: [PATCHv3] iommu/arm-smmu: Optimize ->tlb_flush_walk() for qcom
 implementation
Message-ID: <20210810180827.GA3296@willie-the-truck>
References: <20210623134201.16140-1-saiprakash.ranjan@codeaurora.org>
 <20210802154308.GG28735@willie-the-truck>
 <584e31653ee0e01d249e414dbbc816ea@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <584e31653ee0e01d249e414dbbc816ea@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Doug Anderson <dianders@chromium.org>, iommu@lists.linux-foundation.org,
 Thierry Reding <treding@nvidia.com>, Robin Murphy <robin.murphy@arm.com>,
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

On Tue, Aug 03, 2021 at 11:09:17AM +0530, Sai Prakash Ranjan wrote:
> On 2021-08-02 21:13, Will Deacon wrote:
> > On Wed, Jun 23, 2021 at 07:12:01PM +0530, Sai Prakash Ranjan wrote:
> > > diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > > b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > > index d3c6f54110a5..f3845e822565 100644
> > > --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > > +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > > @@ -341,6 +341,12 @@ static void arm_smmu_tlb_add_page_s1(struct
> > > iommu_iotlb_gather *gather,
> > >  				  ARM_SMMU_CB_S1_TLBIVAL);
> > >  }
> > > 
> > > +static void arm_smmu_tlb_inv_walk_impl_s1(unsigned long iova,
> > > size_t size,
> > > +				     size_t granule, void *cookie)
> > > +{
> > > +	arm_smmu_tlb_inv_context_s1(cookie);
> > > +}
> > > +
> > >  static void arm_smmu_tlb_inv_walk_s2(unsigned long iova, size_t size,
> > >  				     size_t granule, void *cookie)
> > >  {
> > > @@ -388,6 +394,12 @@ static const struct iommu_flush_ops
> > > arm_smmu_s1_tlb_ops = {
> > >  	.tlb_add_page	= arm_smmu_tlb_add_page_s1,
> > >  };
> > > 
> > > +const struct iommu_flush_ops arm_smmu_s1_tlb_impl_ops = {
> > > +	.tlb_flush_all	= arm_smmu_tlb_inv_context_s1,
> > > +	.tlb_flush_walk	= arm_smmu_tlb_inv_walk_impl_s1,
> > > +	.tlb_add_page	= arm_smmu_tlb_add_page_s1,
> > > +};
> > 
> > Hmm, dunno about this. Wouldn't it be a lot cleaner if the
> > tlb_flush_walk
> > callbacks just did the right thing based on the smmu_domain (maybe in
> > the
> > arm_smmu_cfg?) rather than having an entirely new set of ops just
> > because
> > they're const and you can't overide the bit you want?
> > 
> > I don't think there's really an awful lot qcom-specific about the
> > principle
> > here -- there's a trade-off between over-invalidation and invalidation
> > latency. That happens on the CPU as well.
> > 
> 
> Sorry didn't understand, based on smmu_domain what? How do we make
> this implementation specific? Do you mean something like a quirk?
> The reason we didn't make this common was because nvidia folks weren't
> so happy with that, you can find the discussion in this thread [1].
> 
> [1] https://lore.kernel.org/lkml/20210609145315.25750-1-saiprakash.ranjan@codeaurora.org/

The ->tlb_flush_walk() callbacks take a 'void *cookie' which, for this
driver, is a 'struct arm_smmu_domain *'. From that, you can get to the
'struct arm_smmu_cfg' which could have something as coarse as:

	bool	flush_walk_prefer_tlbiasid;

which you can set when you initialise the domain (maybe in the
->init_context callback?). It shouldn't affect anybody else.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
