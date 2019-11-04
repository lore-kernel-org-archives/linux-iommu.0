Return-Path: <SRS0=uwQI=Y4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80751CA9EB5
	for <iommu@archiver.kernel.org>; Mon,  4 Nov 2019 19:57:33 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 465E620848
	for <iommu@archiver.kernel.org>; Mon,  4 Nov 2019 19:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kmi34sQq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 465E620848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 1FAC8E22;
	Mon,  4 Nov 2019 19:57:33 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id D228EBBC
	for <iommu@lists.linux-foundation.org>;
	Mon,  4 Nov 2019 19:57:31 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 535B2A9
	for <iommu@lists.linux-foundation.org>;
	Mon,  4 Nov 2019 19:57:31 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
	bits)) (No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 4E3E4206BA;
	Mon,  4 Nov 2019 19:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572897451;
	bh=97Dtze6o2XzFNmhhMSxNCYQqcshoW4t7kxQPlXUyMP4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kmi34sQqlqdSIPSpW/SBgmg47vBTlexNqCNFFo1L46i8bHH0o1dJA4UpIe/LwbIR8
	IN1iqLMm61Y3kXipU2gnxMKvDmpjnY+szPDGNU0g5K5DG2IoYag1mz02dwaSsh+uAo
	5klgz+xltkzs9ju8nLsBr+DWRNwTUJInN9B+7hL0=
Date: Mon, 4 Nov 2019 19:57:27 +0000
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 07/10] iommu/io-pgtable-arm: Rationalise MAIR handling
Message-ID: <20191104195726.GM24909@willie-the-truck>
References: <cover.1572024119.git.robin.murphy@arm.com>
	<c6bee9e6de5e7f4aa2293ee5385ffa2dd95600d3.1572024120.git.robin.murphy@arm.com>
	<20191104182029.GG24909@willie-the-truck>
	<d7d7513d-9e54-6ae8-168a-2460a306a027@arm.com>
	<20191104192058.GK24909@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191104192058.GK24909@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
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

On Mon, Nov 04, 2019 at 07:20:58PM +0000, Will Deacon wrote:
> On Mon, Nov 04, 2019 at 06:43:06PM +0000, Robin Murphy wrote:
> > On 04/11/2019 18:20, Will Deacon wrote:
> > > On Fri, Oct 25, 2019 at 07:08:36PM +0100, Robin Murphy wrote:
> > > > Between VMSAv8-64 and the various 32-bit formats, there is either one
> > > > 64-bit MAIR or a pair of 32-bit MAIR0/MAIR1 or NMRR/PMRR registers.
> > > > As such, keeping two 64-bit values in io_pgtable_cfg has always been
> > > > overkill.
> > > > 
> > > > Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> > > > ---
> > > >   drivers/iommu/arm-smmu-v3.c    | 2 +-
> > > >   drivers/iommu/arm-smmu.c       | 4 ++--
> > > >   drivers/iommu/io-pgtable-arm.c | 3 +--
> > > >   drivers/iommu/ipmmu-vmsa.c     | 2 +-
> > > >   drivers/iommu/qcom_iommu.c     | 4 ++--
> > > >   include/linux/io-pgtable.h     | 2 +-
> > > >   6 files changed, 8 insertions(+), 9 deletions(-)
> > > > 
> > > > diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> > > > index 8da93e730d6f..3f20e548f1ec 100644
> > > > --- a/drivers/iommu/arm-smmu-v3.c
> > > > +++ b/drivers/iommu/arm-smmu-v3.c
> > > > @@ -2172,7 +2172,7 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
> > > >   	cfg->cd.asid	= (u16)asid;
> > > >   	cfg->cd.ttbr	= pgtbl_cfg->arm_lpae_s1_cfg.ttbr[0];
> > > >   	cfg->cd.tcr	= pgtbl_cfg->arm_lpae_s1_cfg.tcr;
> > > > -	cfg->cd.mair	= pgtbl_cfg->arm_lpae_s1_cfg.mair[0];
> > > > +	cfg->cd.mair	= pgtbl_cfg->arm_lpae_s1_cfg.mair;
> > > >   	return 0;
> > > >   out_free_asid:
> > > > diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> > > > index 080af0326816..2bc3e93b11e6 100644
> > > > --- a/drivers/iommu/arm-smmu.c
> > > > +++ b/drivers/iommu/arm-smmu.c
> > > > @@ -552,8 +552,8 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain,
> > > >   			cb->mair[0] = pgtbl_cfg->arm_v7s_cfg.prrr;
> > > >   			cb->mair[1] = pgtbl_cfg->arm_v7s_cfg.nmrr;
> > > >   		} else {
> > > > -			cb->mair[0] = pgtbl_cfg->arm_lpae_s1_cfg.mair[0];
> > > > -			cb->mair[1] = pgtbl_cfg->arm_lpae_s1_cfg.mair[1];
> > > > +			cb->mair[0] = pgtbl_cfg->arm_lpae_s1_cfg.mair;
> > > > +			cb->mair[1] = pgtbl_cfg->arm_lpae_s1_cfg.mair >> 32;
> > > 
> > > Does this work correctly for big-endian?
> > 
> > I don't see why it wouldn't - cfg.mair is read and written as a u64, so this
> > should always return its most significant word regardless of the storage
> > format. We're not doing anything dodgy like trying to type-pun the u64
> > directly into the u32[2].
> 
> Urgh, I need to convince myself about this then. Off to draw those silly
> ABCD DCBA diagrams on some paper.

Yes, you're right, it's fine. I was worried about explicitly writing
2x32-bit MAIRs and then loading them as one, but that's not what is going on
here.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
