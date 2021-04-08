Return-Path: <SRS0=d8dU=JF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D8DC43460
	for <iommu@archiver.kernel.org>; Thu,  8 Apr 2021 14:20:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A989E6113D
	for <iommu@archiver.kernel.org>; Thu,  8 Apr 2021 14:20:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A989E6113D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7E35C84C4E;
	Thu,  8 Apr 2021 14:20:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id j0hDiRr9biGh; Thu,  8 Apr 2021 14:20:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 818D984833;
	Thu,  8 Apr 2021 14:20:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 60BFDC000C;
	Thu,  8 Apr 2021 14:20:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 51AB0C000A
 for <iommu@lists.linux-foundation.org>; Thu,  8 Apr 2021 14:20:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4E58384C42
 for <iommu@lists.linux-foundation.org>; Thu,  8 Apr 2021 14:20:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DaUF1PtoQ7Kp for <iommu@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 14:20:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CD8F584833
 for <iommu@lists.linux-foundation.org>; Thu,  8 Apr 2021 14:20:18 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 658EB610A3;
 Thu,  8 Apr 2021 14:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617891618;
 bh=uLoXvvSUzFFbjBNWJhGTe7w4vOJZpuFCXoBODBm9LbQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=oW6lF5DbIp/mElokhuciKRVNfWMadHR0Nrb8uFMBPaDP5Iitxbx3Axn0PxNxYU0EA
 lA7aKb5Zc/NcVY0D7VzKnk+d+PxcYvrIS1dApUnYuW2ljuT2thD8TZBZzoQk+VrkQO
 4lecKizF2238BTEVd6h8e/IPLDTnCvRGhkI/M+zCYu7wGdWzmPYFPgrkYgJADqRm5i
 5H2giEGDu5LA9SBsHyF+0U5BRy8JYlfWEEN5cbi2SFBswTvdErrOo8F8fUR1j6oRHo
 mGKYxRtejMOCG4lnOR3b00RnAlOnjsqiNiJzgO4P9zHJUzBXaY9Qw8xfPyK3zGN7VZ
 Y04eBfCAs/sMw==
Date: Thu, 8 Apr 2021 15:20:14 +0100
From: Will Deacon <will@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC PATCH v4 09/15] iommu/io-pgtable-arm: Prepare PTE methods
 for handling multiple entries
Message-ID: <20210408142014.GD17998@willie-the-truck>
References: <20210408045241.27316-1-isaacm@codeaurora.org>
 <20210408045241.27316-10-isaacm@codeaurora.org>
 <20210408135925.GC17998@willie-the-truck>
 <20210408140230.GA3884124@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210408140230.GA3884124@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: "Isaac J. Manjarres" <isaacm@codeaurora.org>, robin.murphy@arm.com,
 iommu@lists.linux-foundation.org, pratikp@codeaurora.org,
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

On Thu, Apr 08, 2021 at 03:02:30PM +0100, Christoph Hellwig wrote:
> On Thu, Apr 08, 2021 at 02:59:26PM +0100, Will Deacon wrote:
> > > -static void __arm_lpae_sync_pte(arm_lpae_iopte *ptep,
> > > +static void __arm_lpae_sync_pte(arm_lpae_iopte *ptep, int num_entries,
> > >  				struct io_pgtable_cfg *cfg)
> > >  {
> > >  	dma_sync_single_for_device(cfg->iommu_dev, __arm_lpae_dma_addr(ptep),
> > > -				   sizeof(*ptep), DMA_TO_DEVICE);
> > > +				   sizeof(*ptep) * num_entries, DMA_TO_DEVICE);
> > >  }
> > 
> > Have you tested this with CONFIG_DMA_API_DEBUG=y? I _think_ it should be
> > ok as long as we don't attempt to sync across a page boundary, but it would
> > be good to give it a spin just to check.
> 
> syncing over a page boundary is perfectly fine.  It just needs to say in
> the bounds of the original mapping.

Yes, you're right. I got the CPU page size mixed up with the IOMMU page
size, so I think we're good as the allocations here are made at IOMMU
page size granularity.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
