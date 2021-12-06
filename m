Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F298FC433FE
	for <iommu@archiver.kernel.org>; Mon,  6 Dec 2021 12:40:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6A52281CDC;
	Mon,  6 Dec 2021 12:40:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5axLjxFYpxOY; Mon,  6 Dec 2021 12:40:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6608E81CD0;
	Mon,  6 Dec 2021 12:40:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 42A3AC001E;
	Mon,  6 Dec 2021 12:40:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D873DC0012
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 12:40:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B71904019F
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 12:40:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L8rw8qGRtQW0 for <iommu@lists.linux-foundation.org>;
 Mon,  6 Dec 2021 12:40:41 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org
 [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E61AE40017
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 12:40:40 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 23482396; Mon,  6 Dec 2021 13:40:38 +0100 (CET)
Date: Mon, 6 Dec 2021 13:40:33 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 4/9] iommu/amd: Simplify pagetable freeing
Message-ID: <Ya4EwWkvDpuvoEjF@8bytes.org>
References: <cover.1637671820.git.robin.murphy@arm.com>
 <0a98d76325d6899808afb1118629c22427629c7c.1637671820.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0a98d76325d6899808afb1118629c22427629c7c.1637671820.git.robin.murphy@arm.com>
Cc: linux-kernel@vger.kernel.org, willy@infradead.org,
 iommu@lists.linux-foundation.org, will@kernel.org
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

On Tue, Nov 23, 2021 at 02:10:39PM +0000, Robin Murphy wrote:
> For reasons unclear, pagetable freeing is an effectively recursive
> method implemented via an elaborate system of templated functions that
> turns out to account for 25% of the object file size. Implementing it
> using regular straightforward recursion makes the code simpler, and
> seems like a good thing to do before we work on it further. As part of
> that, also fix the types to avoid all the needless casting back and
> forth which just gets in the way.

Nice cleanup! The stack of functions came from the fact that recursion
was pretty much discouraged in the kernel. But in this case it looks
well bounded and should be fine.

> +static struct page *free_pt_lvl(u64 *pt, struct page *freelist, int lvl)
> +{
> +	u64 *p;
> +	int i;
> +
> +	for (i = 0; i < 512; ++i) {
> +		/* PTE present? */
> +		if (!IOMMU_PTE_PRESENT(pt[i]))
> +			continue;
> +
> +		/* Large PTE? */
> +		if (PM_PTE_LEVEL(pt[i]) == 0 ||
> +		    PM_PTE_LEVEL(pt[i]) == 7)
> +			continue;
> +
> +		p = IOMMU_PTE_PAGE(pt[i]);
> +		if (lvl > 2)

I thinkt this function deserves a couple of comments. It took me a while
to make sense of the 'lvl > 2' comparision. I think it is right, but if
I have think again I'd appreciate a comment :)

Regards,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
