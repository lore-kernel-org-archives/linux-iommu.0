Return-Path: <SRS0=XGcg=MI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C3FC07E95
	for <iommu@archiver.kernel.org>; Fri, 16 Jul 2021 12:01:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D032D613F7
	for <iommu@archiver.kernel.org>; Fri, 16 Jul 2021 12:01:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D032D613F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8D62F4016F;
	Fri, 16 Jul 2021 12:01:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4E_z6-avfALh; Fri, 16 Jul 2021 12:01:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 50AC8400F7;
	Fri, 16 Jul 2021 12:01:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 341ECC001A;
	Fri, 16 Jul 2021 12:01:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BA49EC000E
 for <iommu@lists.linux-foundation.org>; Fri, 16 Jul 2021 12:01:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9AE3542460
 for <iommu@lists.linux-foundation.org>; Fri, 16 Jul 2021 12:01:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RGh1yyN8RIdA for <iommu@lists.linux-foundation.org>;
 Fri, 16 Jul 2021 12:01:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 74B404245C
 for <iommu@lists.linux-foundation.org>; Fri, 16 Jul 2021 12:01:38 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A177FD6E;
 Fri, 16 Jul 2021 05:01:37 -0700 (PDT)
Received: from [10.57.36.240] (unknown [10.57.36.240])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E94503F774;
 Fri, 16 Jul 2021 05:01:36 -0700 (PDT)
Subject: Re: [PATCH v2] iommu: Streamline iommu_iova_to_phys()
To: Christoph Hellwig <hch@infradead.org>
References: <f564f3f6ff731b898ff7a898919bf871c2c7745a.1626354264.git.robin.murphy@arm.com>
 <YPBBJUWvFixPpFYF@infradead.org>
 <d4eb3346-2152-8a7c-619f-b8d5ee222410@arm.com>
 <YPEk4bZKOZntylOI@infradead.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <97aa74ed-c302-efbd-b15a-64cabe7b249f@arm.com>
Date: Fri, 16 Jul 2021 13:01:23 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YPEk4bZKOZntylOI@infradead.org>
Content-Language: en-GB
Cc: iommu@lists.linux-foundation.org, will@kernel.org,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2021-07-16 07:19, Christoph Hellwig wrote:
> On Thu, Jul 15, 2021 at 03:16:08PM +0100, Robin Murphy wrote:
>> On 2021-07-15 15:07, Christoph Hellwig wrote:
>>> On Thu, Jul 15, 2021 at 02:04:24PM +0100, Robin Murphy wrote:
>>>> If people are going to insist on calling iommu_iova_to_phys()
>>>> pointlessly and expecting it to work,
>>>
>>> Maybe we need to fix that?
>>
>> Feel free to try, but we didn't have much luck pushing back on it
>> previously, so playing whack-a-mole against netdev now is a game I'm
>> personally happy to stay away from ;)
> 
> One thing I've done with symbols I want people to not use it to
> unexport them.  But what about vfio?

Yeah, it's not like they shouldn't be calling it at all - I see it as 
primarily intended for use by drivers managing their own domains, but I 
don't entirely disagree with using it on DMA domains either in niche 
cases - it's that they blindly grab the default domain without even 
checking whether DMA mappings are actually translated or not (and thus 
whether they even need to make that call every time they pull a 
descriptor back out of a ringbuffer). IIRC the argument was essentially 
that checking the domain type was an IOMMU API detail that those driver 
shouldn't have to know about and the abstraction should just take care 
of it, despite the fact that they're punching through 2 layers of 
abstraction to even reach that point. And apparently keeping track of 
their own descriptor addresses would be too much work, but expensive 
indirect calls to either return the address they already have or go off 
and do a software table walk with atomic synchronisation and everything 
are fine :/

> While we're talking about iommu_iova_to_phys: __iommu_dma_unmap_swiotlb
> calls it unconditionally, despite only needed ing the physical address.
> Can we optimize that somehow by splitting out the bounce buffering case
> out?

Indeed, as I think I mentioned recently on another thread, all the 
bounce-buffering stuff is fairly ugly because it's basically the old 
intel-iommu code dropped in with as few changes as possible for ease of 
review, since Tom was no longer able to spend time refining it, and 
nobody else has got round to cleaning it up yet either. In fact the 
whole flow through iommu_dma_unmap_page() flow might be the worst-hit - 
reusing the iommu_dma_sync op made perfect sense when it was just cache 
maintenance, but now means that at worst we do iova_to_phys *twice* plus 
a pointless swiotlb_sync :(

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
