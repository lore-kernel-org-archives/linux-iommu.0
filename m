Return-Path: <SRS0=JfOd=4H=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF782C34050
	for <iommu@archiver.kernel.org>; Wed, 19 Feb 2020 12:37:17 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A55F24670
	for <iommu@archiver.kernel.org>; Wed, 19 Feb 2020 12:37:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QxlTibBt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A55F24670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 7D3D3204F1;
	Wed, 19 Feb 2020 12:37:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e16AdPsss0Vp; Wed, 19 Feb 2020 12:37:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 92EB82039D;
	Wed, 19 Feb 2020 12:37:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 86EBCC1D80;
	Wed, 19 Feb 2020 12:37:16 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7399BC013E
 for <iommu@lists.linux-foundation.org>; Wed, 19 Feb 2020 12:37:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 6A57284B6A
 for <iommu@lists.linux-foundation.org>; Wed, 19 Feb 2020 12:37:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JzSWaBY2kWEq for <iommu@lists.linux-foundation.org>;
 Wed, 19 Feb 2020 12:37:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id DECC0847CC
 for <iommu@lists.linux-foundation.org>; Wed, 19 Feb 2020 12:37:14 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5505924654;
 Wed, 19 Feb 2020 12:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1582115834;
 bh=U+Ccu+qodZQF5R9TKwMdKiDlgQqekTrccjPfmt2hzAM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=QxlTibBtDT5kOVybylM1mh7E9F5Fv+2NSpCsPVedk5Ge0FEuD5LqnEyP0P2bnhqKu
 KbgFaoznIVmXCPCezJXTpqcM+GuFHNPCcybbbWauQ0OoiBSmCa3I/axm41iVdGKkrt
 8mUYeKW/8PeQBEfLtNTIBAdRpLcYWAhgvm9t+/e8=
Date: Wed, 19 Feb 2020 12:37:04 +0000
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [RFC PATCH] iommu/iova: Support limiting IOVA alignment
Message-ID: <20200219123704.GC19400@willie-the-truck>
References: <alpine.DEB.2.10.2002141223510.27047@lmark-linux.qualcomm.com>
 <e9ae618c-58d4-d245-be80-e62fbde4f907@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e9ae618c-58d4-d245-be80-e62fbde4f907@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: "Isaac J. Manjarres" <isaacm@codeaurora.org>,
 Pratik Patel <pratikp@codeaurora.org>, linux-kernel@vger.kernel.org,
 Liam Mark <lmark@codeaurora.org>, iommu@lists.linux-foundation.org,
 kernel-team@android.com
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

On Mon, Feb 17, 2020 at 04:46:14PM +0000, Robin Murphy wrote:
> On 14/02/2020 8:30 pm, Liam Mark wrote:
> > 
> > When the IOVA framework applies IOVA alignment it aligns all
> > IOVAs to the smallest PAGE_SIZE order which is greater than or
> > equal to the requested IOVA size.
> > 
> > We support use cases that requires large buffers (> 64 MB in
> > size) to be allocated and mapped in their stage 1 page tables.
> > However, with this alignment scheme we find ourselves running
> > out of IOVA space for 32 bit devices, so we are proposing this
> > config, along the similar vein as CONFIG_CMA_ALIGNMENT for CMA
> > allocations.
> 
> As per [1], I'd really like to better understand the allocation patterns
> that lead to such a sparsely-occupied address space to begin with, given
> that the rbtree allocator is supposed to try to maintain locality as far as
> possible, and the rcaches should further improve on that. Are you also
> frequently cycling intermediate-sized buffers which are smaller than 64MB
> but still too big to be cached?  Are there a lot of non-power-of-two
> allocations?

Right, information on the allocation pattern would help with this change
and also the choice of IOVA allocation algorithm. Without it, we're just
shooting in the dark.

> > Add CONFIG_IOMMU_LIMIT_IOVA_ALIGNMENT to limit the alignment of
> > IOVAs to some desired PAGE_SIZE order, specified by
> > CONFIG_IOMMU_IOVA_ALIGNMENT. This helps reduce the impact of
> > fragmentation caused by the current IOVA alignment scheme, and
> > gives better IOVA space utilization.
> 
> Even if the general change did prove reasonable, this IOVA allocator is not
> owned by the DMA API, so entirely removing the option of strict
> size-alignment feels a bit uncomfortable. Personally I'd replace the bool
> argument with an actual alignment value to at least hand the authority out
> to individual callers.
> 
> Furthermore, even in DMA API terms, is anyone really ever going to bother
> tuning that config? Since iommu-dma is supposed to be a transparent layer,
> arguably it shouldn't behave unnecessarily differently from CMA, so simply
> piggy-backing off CONFIG_CMA_ALIGNMENT would seem logical.

Agreed, reusing CONFIG_CMA_ALIGNMENT makes a lot of sense here as callers
relying on natural alignment of DMA buffer allocations already have to
deal with that limitation. We could fix it as an optional parameter at
init time (init_iova_domain()), and have the DMA IOMMU implementation
pass it in there.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
