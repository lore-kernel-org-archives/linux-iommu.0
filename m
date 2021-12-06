Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A16BFC433F5
	for <iommu@archiver.kernel.org>; Mon,  6 Dec 2021 13:28:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 23C3284B3C;
	Mon,  6 Dec 2021 13:28:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9tB9u3cEW-oD; Mon,  6 Dec 2021 13:28:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id DE19484B37;
	Mon,  6 Dec 2021 13:28:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 940A8C002F;
	Mon,  6 Dec 2021 13:28:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E1A1BC0012
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 13:28:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BD78F60B29
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 13:28:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5LiVmMe4Ybej for <iommu@lists.linux-foundation.org>;
 Mon,  6 Dec 2021 13:28:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id E8CE96061D
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 13:28:17 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 106DB6D;
 Mon,  6 Dec 2021 05:28:17 -0800 (PST)
Received: from [10.57.34.58] (unknown [10.57.34.58])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C84B03F73D;
 Mon,  6 Dec 2021 05:28:15 -0800 (PST)
Message-ID: <0c55d229-67a4-c5fa-4d0d-9f1497330e45@arm.com>
Date: Mon, 6 Dec 2021 13:28:11 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 4/9] iommu/amd: Simplify pagetable freeing
Content-Language: en-GB
To: Joerg Roedel <joro@8bytes.org>
References: <cover.1637671820.git.robin.murphy@arm.com>
 <0a98d76325d6899808afb1118629c22427629c7c.1637671820.git.robin.murphy@arm.com>
 <Ya4EwWkvDpuvoEjF@8bytes.org>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <Ya4EwWkvDpuvoEjF@8bytes.org>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2021-12-06 12:40, Joerg Roedel wrote:
> On Tue, Nov 23, 2021 at 02:10:39PM +0000, Robin Murphy wrote:
>> For reasons unclear, pagetable freeing is an effectively recursive
>> method implemented via an elaborate system of templated functions that
>> turns out to account for 25% of the object file size. Implementing it
>> using regular straightforward recursion makes the code simpler, and
>> seems like a good thing to do before we work on it further. As part of
>> that, also fix the types to avoid all the needless casting back and
>> forth which just gets in the way.
> 
> Nice cleanup! The stack of functions came from the fact that recursion
> was pretty much discouraged in the kernel. But in this case it looks
> well bounded and should be fine.

I did wonder about explicitly clamping lvl to ensure that it couldn't 
possibly recurse any further than the multi-function version, but given 
that you'd need to craft a suitable bogus pagetable in addition to 
corrupting the arguments to be able to exploit it at all, that seemed 
perhaps a little too paranoid. Happy to add something like:

	if (WARN_ON(lvl > PAGE_MODE_7_LEVEL))
		return NULL;

if you like, though.

>> +static struct page *free_pt_lvl(u64 *pt, struct page *freelist, int lvl)
>> +{
>> +	u64 *p;
>> +	int i;
>> +
>> +	for (i = 0; i < 512; ++i) {
>> +		/* PTE present? */
>> +		if (!IOMMU_PTE_PRESENT(pt[i]))
>> +			continue;
>> +
>> +		/* Large PTE? */
>> +		if (PM_PTE_LEVEL(pt[i]) == 0 ||
>> +		    PM_PTE_LEVEL(pt[i]) == 7)
>> +			continue;
>> +
>> +		p = IOMMU_PTE_PAGE(pt[i]);
>> +		if (lvl > 2)
> 
> I thinkt this function deserves a couple of comments. It took me a while
> to make sense of the 'lvl > 2' comparision. I think it is right, but if
> I have think again I'd appreciate a comment :)

Heh, it's merely a direct transformation of the logic encoded in the 
existing "DEFINE_FREE_PT_FN(...)" cases - I assume that's just an 
optimisation, so I'll add a comment to that effect.

Thanks,
Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
