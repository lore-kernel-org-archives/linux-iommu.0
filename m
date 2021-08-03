Return-Path: <SRS0=qwh6=M2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F83C432BE
	for <iommu@archiver.kernel.org>; Tue,  3 Aug 2021 10:36:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 895A7610CC
	for <iommu@archiver.kernel.org>; Tue,  3 Aug 2021 10:36:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 895A7610CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5063740390;
	Tue,  3 Aug 2021 10:36:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cjJCVEXeiPWf; Tue,  3 Aug 2021 10:36:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 244E24038A;
	Tue,  3 Aug 2021 10:36:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E5C57C0010;
	Tue,  3 Aug 2021 10:36:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 36A87C000E
 for <iommu@lists.linux-foundation.org>; Tue,  3 Aug 2021 10:36:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 18B9A4038A
 for <iommu@lists.linux-foundation.org>; Tue,  3 Aug 2021 10:36:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TnkKo1EbScZs for <iommu@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 10:36:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DD8FA40389
 for <iommu@lists.linux-foundation.org>; Tue,  3 Aug 2021 10:36:05 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id D137160F58;
 Tue,  3 Aug 2021 10:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1627986965;
 bh=OKjeuOM6V0zI7ozBJZBwK2+rpt/Y8fFWQlLVfX7CcCc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=TzormALcrksfXm3/ozDNOrUjiK9T4bOuW7LOMOpv+HBrpO2IHzm1VLBOFb1krOuMU
 Lvxew2ej+IRxCVIe1c4fc9U2Hw+rVwqABkfiU7Azk2PYH3PP4gv9Ap32vkTKQPH9/Q
 agWi4w3XGZeHm+uQbqMYUWKc5X5ZIWZoAP4maZJbeBAYoquaz2KWncAkgaLFxXmCXX
 9gjAH/b/A54MXuDRlXCiro1uFDr69tNmA3ybxzObRCnECbEPNbif5qE7fljuDi5qbJ
 LtQt+4dcn1+QUHWxtAvDiFpbZUDF2J7Rh2C6u0NIbuAQitBoqBrqZ08V4HfB+QdpmI
 FDPspXLllLHkQ==
Date: Tue, 3 Aug 2021 11:36:00 +0100
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 23/24] iommu/arm-smmu: Allow non-strict in
 pgtable_quirks interface
Message-ID: <20210803103559.GA30690@willie-the-truck>
References: <cover.1627468308.git.robin.murphy@arm.com>
 <0fcd1f5225a6b435cbc697551a6247cd435c04db.1627468310.git.robin.murphy@arm.com>
 <20210802130438.GA28547@willie-the-truck>
 <3dd7cdae-7111-6ff2-6350-a0e19fe4ab66@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3dd7cdae-7111-6ff2-6350-a0e19fe4ab66@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: linux-kernel@vger.kernel.org, dianders@chromium.org,
 iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
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

On Mon, Aug 02, 2021 at 03:15:50PM +0100, Robin Murphy wrote:
> On 2021-08-02 14:04, Will Deacon wrote:
> > On Wed, Jul 28, 2021 at 04:58:44PM +0100, Robin Murphy wrote:
> > > To make io-pgtable aware of a flush queue being dynamically enabled,
> > > allow IO_PGTABLE_QUIRK_NON_STRICT to be set even after a domain has been
> > > attached to, and hook up the final piece of the puzzle in iommu-dma.
> > > 
> > > Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> > > ---
> > >   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 15 +++++++++++++++
> > >   drivers/iommu/arm/arm-smmu/arm-smmu.c       | 11 +++++++++++
> > >   drivers/iommu/dma-iommu.c                   |  3 +++
> > >   3 files changed, 29 insertions(+)
> > > 
> > > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > index 19400826eba7..40fa9cb382c3 100644
> > > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > @@ -2711,6 +2711,20 @@ static int arm_smmu_enable_nesting(struct iommu_domain *domain)
> > >   	return ret;
> > >   }
> > > +static int arm_smmu_set_pgtable_quirks(struct iommu_domain *domain,
> > > +		unsigned long quirks)
> > > +{
> > > +	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
> > > +
> > > +	if (quirks == IO_PGTABLE_QUIRK_NON_STRICT && smmu_domain->pgtbl_ops) {
> > > +		struct io_pgtable *iop = io_pgtable_ops_to_pgtable(smmu_domain->pgtbl_ops);
> > > +
> > > +		iop->cfg.quirks |= IO_PGTABLE_QUIRK_NON_STRICT;
> > > +		return 0;
> > > +	}
> > > +	return -EINVAL;
> > > +}
> > 
> > I don't see anything serialising this against a concurrent iommu_unmap(), so
> > the ordering and atomicity looks quite suspicious to me here. I don't think
> > it's just the page-table quirks either, but also setting cookie->fq_domain.
> 
> Heh, I confess to very much taking the cheeky "let's say nothing and see
> what Will thinks about concurrency" approach here :)

Damnit, I fell for that didn't I?

Overall, I'm really nervous about the concurrency here and think we'd be
better off requiring the unbind as we have for the other domain changes.

> The beauty of only allowing relaxation in the strict->non-strict direction
> is that it shouldn't need serialising as such - it doesn't matter if the
> update to cookie->fq_domain is observed between iommu_unmap() and
> iommu_dma_free_iova(), since there's no correctness impact to queueing IOVAs
> which may already have been invalidated and may or may not have been synced.
> AFAICS the only condition which matters is that the setting of the
> io-pgtable quirk must observe fq_domain being set. It feels like there must
> be enough dependencies on the read side, but we might need an smp_wmb()
> between the two in iommu_dma_init_fq()?
> 
> I've also flip-flopped a bit on whether fq_domain needs to be accessed with
> READ_ONCE/WRITE_ONCE - by the time of posting I'd convinced myself that it
> was probably OK, but looking again now I suppose this wacky reordering is
> theoretically possible:
> 
> 
> 	iommu_dma_unmap() {
> 		bool free_fq = cookie->fq_domain; // == false
> 
> 		iommu_unmap();
> 
> 		if (!cookie->fq_domain) // observes new non-NULL value
> 			iommu_tlb_sync(); // skipped
> 
> 		iommu_dma_free_iova { // inlined
> 			if (free_fq) // false
> 				queue_iova();
> 			else
> 				free_iova_fast(); // Uh-oh!
> 		}
> 	}
> 
> so although I still can't see atomicity being a problem I guess we do need
> it for the sake of reordering at least.

With your changes, I think quite a few things can go wrong.

  * cookie->fq_domain may be observed but iovad->fq could be NULL
  * We can miss the smp_wmb() in the pgtable code but end up deferring the
    IOVA reclaim
  * iommu_change_dev_def_domain() only holds the group mutex afaict, so can
    possibly run concurrently with itself on the same domain?
  * iommu_dma_init_fq() can flip the domain type back from
    IOMMU_DOMAIN_DMA_FQ to IOMMU_DOMAIN_DMA on the error path
  * set_pgtable_quirks() isn't atomic, which probably is ok for now, but the
    moment we use it anywhere else it's dangerous

and I suspect there are more :/

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
