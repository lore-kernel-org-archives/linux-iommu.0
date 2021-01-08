Return-Path: <SRS0=te8u=GL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB092C433E0
	for <iommu@archiver.kernel.org>; Fri,  8 Jan 2021 18:18:40 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69EC923A7C
	for <iommu@archiver.kernel.org>; Fri,  8 Jan 2021 18:18:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69EC923A7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1838087409;
	Fri,  8 Jan 2021 18:18:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K2XQQgLZ0O9N; Fri,  8 Jan 2021 18:18:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 800AD87406;
	Fri,  8 Jan 2021 18:18:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5BA21C0891;
	Fri,  8 Jan 2021 18:18:39 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A1E11C013A
 for <iommu@lists.linux-foundation.org>; Fri,  8 Jan 2021 18:18:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 88FA487409
 for <iommu@lists.linux-foundation.org>; Fri,  8 Jan 2021 18:18:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xAnwWaniKq+d for <iommu@lists.linux-foundation.org>;
 Fri,  8 Jan 2021 18:18:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id B7B0787406
 for <iommu@lists.linux-foundation.org>; Fri,  8 Jan 2021 18:18:36 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1BB9723A7A;
 Fri,  8 Jan 2021 18:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1610129916;
 bh=1EJDjUMPNL/dY0XEEkmAoh+OfzkB5yqH0QpcKX27KdQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gOAaZKMBGevPezWNeCeeRPpwnW3ki8JMZ3ojjuJnY5SMO0nydVHO/xXY0yA6k6eMc
 ruSWe9plVJ0Zo3oSx5nQvnje1e0kI3FdZX3Q/dEf1lExhqP7XIq74eEnikkOOKavco
 duc/mpql1uOwc/kZucSz5iG+biQbSXdzPhSuI/k5ZNagSsk8YmI7PObnEnJpakgRje
 Aw/uLHiRUU0A3VHsVUPnqKqPOC0plw2zNgYfVDEr1sriYbuyMku128jorI5DcaHf7j
 /9Cnj8jfwv+6xqPDZBioVAfeT4kfCrcS66RFA22SqEGYaJSdqC+E0nWaV8k3bnE6Hx
 4LHFeRNRBeeFQ==
Date: Fri, 8 Jan 2021 18:18:30 +0000
From: Will Deacon <will@kernel.org>
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: Re: [PATCH] iommu/io-pgtable-arm: Allow non-coherent masters to use
 system cache
Message-ID: <20210108181830.GA5457@willie-the-truck>
References: <20201224064007.2339-1-saiprakash.ranjan@codeaurora.org>
 <20210106115615.GA1763@willie-the-truck>
 <cfced52002337025088a64aa159760b2@codeaurora.org>
 <8cfefbff135a5287d177b6ab2ccc3304@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8cfefbff135a5287d177b6ab2ccc3304@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: isaacm@codeaurora.org, linux-arm-msm@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Akhil P Oommen <akhilpo@codeaurora.org>, Robin Murphy <robin.murphy@arm.com>,
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

On Fri, Jan 08, 2021 at 11:17:25AM +0530, Sai Prakash Ranjan wrote:
> On 2021-01-07 22:27, isaacm@codeaurora.org wrote:
> > On 2021-01-06 03:56, Will Deacon wrote:
> > > On Thu, Dec 24, 2020 at 12:10:07PM +0530, Sai Prakash Ranjan wrote:
> > > > commit ecd7274fb4cd ("iommu: Remove unused IOMMU_SYS_CACHE_ONLY
> > > > flag")
> > > > removed unused IOMMU_SYS_CACHE_ONLY prot flag and along with it went
> > > > the memory type setting required for the non-coherent masters to use
> > > > system cache. Now that system cache support for GPU is added, we will
> > > > need to mark the memory as normal sys-cached for GPU to use
> > > > system cache.
> > > > Without this, the system cache lines are not allocated for GPU.
> > > > We use
> > > > the IO_PGTABLE_QUIRK_ARM_OUTER_WBWA quirk instead of a page
> > > > protection
> > > > flag as the flag cannot be exposed via DMA api because of no in-tree
> > > > users.
> > > > 
> > > > Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> > > > ---
> > > >  drivers/iommu/io-pgtable-arm.c | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > > 
> > > > diff --git a/drivers/iommu/io-pgtable-arm.c
> > > > b/drivers/iommu/io-pgtable-arm.c
> > > > index 7c9ea9d7874a..3fb7de8304a2 100644
> > > > --- a/drivers/iommu/io-pgtable-arm.c
> > > > +++ b/drivers/iommu/io-pgtable-arm.c
> > > > @@ -415,6 +415,9 @@ static arm_lpae_iopte
> > > > arm_lpae_prot_to_pte(struct arm_lpae_io_pgtable *data,
> > > >  		else if (prot & IOMMU_CACHE)
> > > >  			pte |= (ARM_LPAE_MAIR_ATTR_IDX_CACHE
> > > >  				<< ARM_LPAE_PTE_ATTRINDX_SHIFT);
> > > > +		else if (data->iop.cfg.quirks & IO_PGTABLE_QUIRK_ARM_OUTER_WBWA)
> > > > +			pte |= (ARM_LPAE_MAIR_ATTR_IDX_INC_OCACHE
> > > > +				<< ARM_LPAE_PTE_ATTRINDX_SHIFT);
> > > >  	}
> > > 
> > While this approach of enabling system cache globally for both page
> > tables and other buffers
> > works for the GPU usecase, this isn't ideal for other clients that use
> > system cache. For example,
> > video clients only want to cache a subset of their buffers in the
> > system cache, due to the sizing constraint
> > imposed by how much of the system cache they can use. So, it would be
> > ideal to have
> > a way of expressing the desire to use the system cache on a per-buffer
> > basis. Additionally,
> > our video clients use the DMA layer, and since the requirement is for
> > caching in the system cache
> > to be a per buffer attribute, it seems like we would have to have a
> > DMA attribute to express
> > this on a per-buffer basis.
> > 
> 
> I did bring this up initially [1], also where is this video client
> in upstream? AFAIK, only system cache user in upstream is GPU.
> We cannot add any DMA attribute unless there is any user upstream
> as per [2], so when the support for such a client is added, wouldn't
> ((data->iop.cfg.quirks & IO_PGTABLE_QUIRK_ARM_OUTER_WBWA) || PROT_FLAG)
> work?

Hmm, I think this is another case where we need to separate out the
page-table walker attributes from the access attributes. Currently,
IO_PGTABLE_QUIRK_ARM_OUTER_WBWA applies _only_ to the page-table walker
and I don't think it makes any sense for that to be per-buffer (how would
you even manage that?). However, if we want to extend this to data accesses
and we know that there are valid use-cases where this should be per-buffer,
then shoe-horning it in with the walker quirk does not feel like the best
thing to do.

As a starting point, we could:

  1. Rename IO_PGTABLE_QUIRK_ARM_OUTER_WBWA to IO_PGTABLE_QUIRK_PTW_LLC
  2. Add a new prot flag IOMMU_LLC
  3. Have the GPU pass the new prot for its buffer mappings

Does that work? One thing I'm not sure about is whether IOMMU_CACHE should
imply IOMMU_LLC, or whether there is a use-case for inner-cacheable, outer
non-cacheable mappings for a coherent device. Have you ever seen that sort
of thing before?

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
