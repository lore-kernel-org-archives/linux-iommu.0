Return-Path: <SRS0=ynGH=LB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19969C47082
	for <iommu@archiver.kernel.org>; Mon,  7 Jun 2021 11:23:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B43D861078
	for <iommu@archiver.kernel.org>; Mon,  7 Jun 2021 11:23:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B43D861078
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6D72E40245;
	Mon,  7 Jun 2021 11:23:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bA74ylPt12oU; Mon,  7 Jun 2021 11:23:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id CBDE14020E;
	Mon,  7 Jun 2021 11:23:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A60A8C000E;
	Mon,  7 Jun 2021 11:23:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C66F8C0001
 for <iommu@lists.linux-foundation.org>; Mon,  7 Jun 2021 11:23:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A6E394028B
 for <iommu@lists.linux-foundation.org>; Mon,  7 Jun 2021 11:23:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FWDNS5hUPp2W for <iommu@lists.linux-foundation.org>;
 Mon,  7 Jun 2021 11:23:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9BB41401F7
 for <iommu@lists.linux-foundation.org>; Mon,  7 Jun 2021 11:23:40 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA7751063;
 Mon,  7 Jun 2021 04:23:39 -0700 (PDT)
Received: from [10.57.6.115] (unknown [10.57.6.115])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D25FC3F73D;
 Mon,  7 Jun 2021 04:23:38 -0700 (PDT)
Subject: Re: [PATCH 0/4] Free cached iovas when rmmod the driver of the last
 device in group
To: chenxiang <chenxiang66@hisilicon.com>, will@kernel.org, joro@8bytes.org
References: <1623033782-57907-1-git-send-email-chenxiang66@hisilicon.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <75178f05-7831-f6c1-ad2d-5671a65a69bb@arm.com>
Date: Mon, 7 Jun 2021 12:23:34 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <1623033782-57907-1-git-send-email-chenxiang66@hisilicon.com>
Content-Language: en-GB
Cc: iommu@lists.linux-foundation.org, linuxarm@openeuler.org,
 linuxarm@huawei.com
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

On 2021-06-07 03:42, chenxiang wrote:
> From: Xiang Chen <chenxiang66@hisilicon.com>
> 
> When rmmod the driver of the last device in the group, cached iovas are not
> used, and it is better to free them to save memories. And also export
> function free_rcache_cached_iovas() and iommu_domain_to_iova().

How common is it to use a device a significant amount, then unbind its 
driver and not use it for long enough to care about? Off-hand I can't 
think of a particularly realistic use-case which looks like that - the 
closest I can imagine is unbinding a default kernel driver to replace it 
with VFIO, but I would expect the set of devices intended for assignment 
to be distinct from the set of devices used by the host itself, and thus 
the host driver wouldn't have actually done much to generate a lot of 
DMA mappings in that initial period. Is my expectation there wrong?

If there is such a case, how much memory does this actually save in 
practice? The theoretical worst-case should be roughly 4 * 128 * 6 * 
sizeof(struct iova) bytes per CPU, which is around 192KB assuming 
64-byte kmem cache alignment. However it seems rather unlikely in 
practice to have every possible cache entry of every size used, so if 
saving smaller amounts of memory is a concern wouldn't you also want to 
explicitly drain the flush queues (16KB per CPU) and maybe look at 
trying to reclaim the unused pagetable pages from the domain itself - 
that ~192KB worth of cached IOVAs represents ~32K pages worth of IOVA 
space, which for an implementation like io-pgtable-arm with the 4KB 
granule means ~256KB worth of non-leaf pagetables left behind.

I'm not against the idea of having a mechanism to "compact" an idle DMA 
domain if there are convincing numbers to back it up, but the actual 
implementation would need to be better than this as well - having the 
IOMMU core code poking directly into the internals of the iommu-dma 
abstraction is not the way to go, and exporting anything to modules, 
which the IOMU core is not, smells suspicious.

Robin.

> Xiang Chen (4):
>    iommu/iova: add a function to free all rcached iovas and export it
>    iommu/iova: use function free_rcache_cached_iovas() to free all
>      rcached iovas
>    dma-iommu: add a interface to get iova_domain from iommu domain
>    iommu: free cached iovas when rmmod the driver of the last device in
>      the group
> 
>   drivers/iommu/dma-iommu.c |  7 +++++++
>   drivers/iommu/iommu.c     |  7 +++++++
>   drivers/iommu/iova.c      | 17 ++++++++++++-----
>   include/linux/dma-iommu.h |  6 ++++++
>   include/linux/iova.h      |  5 +++++
>   5 files changed, 37 insertions(+), 5 deletions(-)
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
