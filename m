Return-Path: <SRS0=GIAn=JY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B6AC433ED
	for <iommu@archiver.kernel.org>; Tue, 27 Apr 2021 12:33:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8152B60E09
	for <iommu@archiver.kernel.org>; Tue, 27 Apr 2021 12:33:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8152B60E09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2411A40122;
	Tue, 27 Apr 2021 12:33:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GvYl_RO4tqVp; Tue, 27 Apr 2021 12:33:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1496F40148;
	Tue, 27 Apr 2021 12:33:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E48BEC000E;
	Tue, 27 Apr 2021 12:33:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0B234C000B
 for <iommu@lists.linux-foundation.org>; Tue, 27 Apr 2021 12:32:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DD403405DA
 for <iommu@lists.linux-foundation.org>; Tue, 27 Apr 2021 12:32:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8doc9lo0slbX for <iommu@lists.linux-foundation.org>;
 Tue, 27 Apr 2021 12:32:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9782A405E0
 for <iommu@lists.linux-foundation.org>; Tue, 27 Apr 2021 12:32:57 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A544331B;
 Tue, 27 Apr 2021 05:32:56 -0700 (PDT)
Received: from [10.57.61.101] (unknown [10.57.61.101])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 809803F70D;
 Tue, 27 Apr 2021 05:32:55 -0700 (PDT)
Subject: Re: dma-api debugfs directory is not created since debugfs is not
 initialized
To: Greg KH <gregkh@linuxfoundation.org>,
 Corentin Labbe <clabbe.montjoie@gmail.com>
References: <YIf2w1navFNeYjMS@Red> <YIf35EzfSY7qavWw@kroah.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <22f268bb-9b96-1208-0292-68c9b50422a1@arm.com>
Date: Tue, 27 Apr 2021 13:32:50 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YIf35EzfSY7qavWw@kroah.com>
Content-Language: en-GB
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, hch@lst.de,
 rafael@kernel.org
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

On 2021-04-27 12:39, Greg KH wrote:
> On Tue, Apr 27, 2021 at 01:34:27PM +0200, Corentin Labbe wrote:
>> Hello
>>
>> I try to debug some DMA problem on next-20210427, and so I have enabled CONFIG_DMA_API_DEBUG=y.
>> But the dma-api directory does show up in debugfs, but lot of other directory exists in it.
> 
> Does it show up properly in 5.12?
> 
>> After debugging it seems due to commit 56348560d495 ("debugfs: do not attempt to create a new file before the filesystem is initalized")
>> Reverting the commit permit to "dma-api" debugfs to be found. (but seems not the right way to fix it).
> 
> We have had some odd start-up ordering issues that the above commit has
> caused to show.  Given that this commit is now in stable kernels, with
> no report of this issue so far, I'm worried that maybe this is a dma
> subsystem ordering issue?

Both debugfs_init() and dma_debug_init() do run at core_initcall level, 
and disassembling the vmlinux from my current working tree does indeed 
suggest that they somehow end up in the wrong relative order:

[...]
ffff80001160d0c8 <__initcall__kmod_debug__325_918_dma_debug_init1>:
ffff80001160d0c8:       feb0d528        .word   0xfeb0d528

[...]

ffff80001160d108 <__initcall__kmod_debugfs__357_848_debugfs_init1>:
ffff80001160d108:       fff4326c        .word   0xfff4326c
[...]


I always had the impression that initcall ordering tended to work out 
roughly alphabetical, such that entries from fs/* might come before 
kernel/*, but I guess it's at the whims of the linker in the end :/

Perhaps the easiest thing to do is split out dma_debug_fs_init() and run 
that at a later level? We do want the dma-debug infrastructure itself to 
be up as early as possible, but I think the debugfs view of its 
internals can happily wait until closer to the time that there's 
actually a userspace to be able to look at it.

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
