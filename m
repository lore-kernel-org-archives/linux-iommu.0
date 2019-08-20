Return-Path: <SRS0=xQF/=WQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39866C3A589
	for <iommu@archiver.kernel.org>; Tue, 20 Aug 2019 17:07:46 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC3A4214DA
	for <iommu@archiver.kernel.org>; Tue, 20 Aug 2019 17:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dRvrXrV8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC3A4214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 9CA48AB9;
	Tue, 20 Aug 2019 17:07:45 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 8766F941
	for <iommu@lists.linux-foundation.org>;
	Tue, 20 Aug 2019 17:07:44 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id BB2C88A0
	for <iommu@lists.linux-foundation.org>;
	Tue, 20 Aug 2019 17:07:42 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
	bits)) (No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 8FD3E20856;
	Tue, 20 Aug 2019 17:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566320862;
	bh=9SDmMNWp7CHtjv9I2iSd0uIujbS1EWSd5cv/nWxgdWI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dRvrXrV8z214/nOQYP598qfU2Ydcy5vAnKi+c55DFGnOlYNt6J20+mw38RkrvmuTF
	QzUrq1nnLM2O4UqCDuH92sbHXqLtk9FY/D/mgiBYJu2g4TVEfZxiz+QUnrKcERJ/OI
	RwMRLn2zMtnnnRKlLz6QOhK54X5Qgj/Hv5Gfogrs=
Date: Tue, 20 Aug 2019 18:07:38 +0100
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 3/4] iommu/arm-smmu-v3: Fix ATC invalidation ordering wrt
	main TLBs
Message-ID: <20190820170737.xdfbg4p4bneau4uv@willie-the-truck>
References: <20190820154549.17018-1-will@kernel.org>
	<20190820154549.17018-4-will@kernel.org>
	<983be1bc-1b51-77e7-5aee-8395a4f3724e@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <983be1bc-1b51-77e7-5aee-8395a4f3724e@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	iommu@lists.linux-foundation.org
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

On Tue, Aug 20, 2019 at 05:50:06PM +0100, Robin Murphy wrote:
> On 20/08/2019 16:45, Will Deacon wrote:
> > When invalidating the ATC for an PCIe endpoint using ATS, we must take
> > care to complete invalidation of the main SMMU TLBs beforehand, otherwise
> > the device could immediately repopulate its ATC with stale translations.
> > 
> > Hooking the ATC invalidation into ->unmap() as we currently do does the
> > exact opposite: it ensures that the ATC is invalidated *before*  the
> > main TLBs, which is bogus.
> > 
> > Move ATC invalidation into the actual (leaf) invalidation routines so
> > that it is always called after completing main TLB invalidation.
> > 
> > Signed-off-by: Will Deacon <will@kernel.org>
> > ---
> >   drivers/iommu/arm-smmu-v3.c | 12 +++++-------
> >   1 file changed, 5 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> > index 9096eca0c480..183a1c121179 100644
> > --- a/drivers/iommu/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm-smmu-v3.c
> > @@ -1961,6 +1961,7 @@ static void arm_smmu_tlb_inv_context(void *cookie)
> >   	 */
> >   	arm_smmu_cmdq_issue_cmd(smmu, &cmd);
> >   	arm_smmu_cmdq_issue_sync(smmu);
> > +	arm_smmu_atc_inv_domain(smmu_domain, 0, 0, 0);
> >   }
> >   static void arm_smmu_tlb_inv_range(unsigned long iova, size_t size,
> > @@ -1969,7 +1970,7 @@ static void arm_smmu_tlb_inv_range(unsigned long iova, size_t size,
> >   {
> >   	u64 cmds[CMDQ_BATCH_ENTRIES * CMDQ_ENT_DWORDS];
> >   	struct arm_smmu_device *smmu = smmu_domain->smmu;
> > -	unsigned long end = iova + size;
> > +	unsigned long start = iova, end = iova + size;
> >   	int i = 0;
> >   	struct arm_smmu_cmdq_ent cmd = {
> >   		.tlbi = {
> > @@ -1998,6 +1999,8 @@ static void arm_smmu_tlb_inv_range(unsigned long iova, size_t size,
> >   	}
> >   	arm_smmu_cmdq_issue_cmdlist(smmu, cmds, i, true);
> > +	if (leaf)
> > +		arm_smmu_atc_inv_domain(smmu_domain, 0, start, size);
> 
> I still need to get up to speed on your cmdlist and unmap changes, but in
> isolation this "if (leaf)" guard looks a bit dodgy - in the case where
> io-pgtable goes to unmap a 2MB block, finds it's mapped as a table, and
> blows it away in one go, we'll only see a non-leaf TLBI call for that range,
> no?

Yuck, this is quite horrible. I don't think the ATC is permitted to cache
intermediate walks, so we actually don't need the thing to be synchronous
here. But if we update the gather structure as well, then we risk
over-invalidating for the non-ATS case when we get to the sync.

I'll have a think.

> Tangentially, does arm_smmu_atc_inv_domain() really need to sync once for
> each individual master, or could that do better as well? Not something we
> should worry about right now, but now that I'm looking I may as well note it
> for the record.

Indeed -- that function should be rewritten using the cmdlist() stuff I've
done. I'm just reluctant to start optimising for the ATS case when I'm not
able to test it.

Thanks,

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
