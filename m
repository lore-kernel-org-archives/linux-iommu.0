Return-Path: <SRS0=B4OP=WL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2077C3A589
	for <iommu@archiver.kernel.org>; Thu, 15 Aug 2019 13:55:36 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 853A6208C2
	for <iommu@archiver.kernel.org>; Thu, 15 Aug 2019 13:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZSXhKCXn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 853A6208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 5A9D3EEB;
	Thu, 15 Aug 2019 13:55:36 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 3950FEE4
	for <iommu@lists.linux-foundation.org>;
	Thu, 15 Aug 2019 13:55:35 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id E062787B
	for <iommu@lists.linux-foundation.org>;
	Thu, 15 Aug 2019 13:55:34 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
	bits)) (No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 5A0942086C;
	Thu, 15 Aug 2019 13:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565877334;
	bh=5wfdAeZ3utUPYQaQDWs/sPCscNo9VPDGdHObDpJgZkA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZSXhKCXnjT2MHojqRaEFTPxafHmaj9lMMhHJUpp43bu0tOq3kPe9BYmQjtTmS1cxI
	yPAmnhyd3tcv2gKM9FioP06CRf/UfBdxlgJ1p2oVvCNaXLzfQ2B80Dzj9FVNxlt5E9
	WDQZVtHduPewVZJ9mtJQZLV08NiopSr1aD8Z7/fs=
Date: Thu, 15 Aug 2019 14:55:29 +0100
From: Will Deacon <will@kernel.org>
To: John Garry <john.garry@huawei.com>
Subject: Re: [PATCH 00/13] Rework IOMMU API to allow for batching of
	invalidation
Message-ID: <20190815135528.d7ip6dkqdwwvjy64@willie-the-truck>
References: <20190814175634.21081-1-will@kernel.org>
	<78d366b7-590f-b114-1a9a-91dea01cde4d@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <78d366b7-590f-b114-1a9a-91dea01cde4d@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Vijay Kilary <vkilari@codeaurora.org>,
	Jon Masters <jcm@redhat.com>, Jan Glauber <jglauber@marvell.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	iommu@lists.linux-foundation.org,
	Jayachandran Chandrasekharan Nair <jnair@marvell.com>,
	David Woodhouse <dwmw2@infradead.org>, Robin Murphy <robin.murphy@arm.com>
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

On Thu, Aug 15, 2019 at 12:19:58PM +0100, John Garry wrote:
> On 14/08/2019 18:56, Will Deacon wrote:
> > If you'd like to play with the patches, then I've also pushed them here:
> > 
> >   https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/log/?h=iommu/unmap
> > 
> > but they should behave as a no-op on their own.
> 
> As anticipated, my storage testing scenarios roughly give parity throughput
> and CPU loading before and after this series.
> 
> Patches to convert the
> > Arm SMMUv3 driver to the new API are here:
> > 
> >   https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/log/?h=iommu/cmdq
> 
> I quickly tested this again and now I see a performance lift:
> 
> 			before (5.3-rc1)		after
> D05 8x SAS disks	907K IOPS			970K IOPS
> D05 1x NVMe		450K IOPS			466K IOPS
> D06 1x NVMe		467K IOPS			466K IOPS
> 
> The CPU loading seems to track throughput, so nothing much to say there.
> 
> Note: From 5.2 testing, I was seeing >900K IOPS from that NVMe disk for
> !IOMMU.

Cheers, John. For interest, how do things look if you pass iommu.strict=0?
That might give some indication about how much the invalidation is still
hurting us.

> BTW, what were your thoughts on changing
> arm_smmu_atc_inv_domain()->arm_smmu_atc_inv_master() to batching? It seems
> suitable, but looks untouched. Were you waiting for a resolution to the
> performance issue which Leizhen reported?

In principle, I'm supportive of such a change, but I'm not currently able
to test any ATS stuff so somebody else would need to write the patch.
Jean-Philippe is on holiday at the moment, but I'd be happy to review
something from you if you send it out.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
