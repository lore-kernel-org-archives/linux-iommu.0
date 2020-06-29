Return-Path: <SRS0=qe9F=AK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D870C433E0
	for <iommu@archiver.kernel.org>; Mon, 29 Jun 2020 13:15:25 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A29523D56
	for <iommu@archiver.kernel.org>; Mon, 29 Jun 2020 13:15:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A29523D56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 2CA5C2042C;
	Mon, 29 Jun 2020 13:15:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WKQ+2K+Gyyyo; Mon, 29 Jun 2020 13:15:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 9A9BE204FB;
	Mon, 29 Jun 2020 13:15:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7F80DC07FF;
	Mon, 29 Jun 2020 13:15:23 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5BF75C016E
 for <iommu@lists.linux-foundation.org>; Mon, 29 Jun 2020 13:15:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 33E90204FB
 for <iommu@lists.linux-foundation.org>; Mon, 29 Jun 2020 13:15:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BgaRx3-tq5b6 for <iommu@lists.linux-foundation.org>;
 Mon, 29 Jun 2020 13:15:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by silver.osuosl.org (Postfix) with ESMTP id 895E92042C
 for <iommu@lists.linux-foundation.org>; Mon, 29 Jun 2020 13:15:20 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DE9CA14F6;
 Mon, 29 Jun 2020 06:15:19 -0700 (PDT)
Received: from [10.57.21.32] (unknown [10.57.21.32])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1043F3F73C;
 Mon, 29 Jun 2020 06:15:18 -0700 (PDT)
Subject: Re: the XSK buffer pool needs be to reverted
To: Christoph Hellwig <hch@lst.de>, Jonathan Lemon <jonathan.lemon@gmail.com>
References: <20200626074725.GA21790@lst.de>
 <20200626205412.xfe4lywdbmh3kmri@bsd-mbp> <20200627070236.GA11854@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <e43ab7b9-22f5-75c3-c9e6-f1eb18d57148@arm.com>
Date: Mon, 29 Jun 2020 14:15:16 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200627070236.GA11854@lst.de>
Content-Language: en-GB
Cc: netdev@vger.kernel.org, iommu@lists.linux-foundation.org,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>
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

On 2020-06-27 08:02, Christoph Hellwig wrote:
> On Fri, Jun 26, 2020 at 01:54:12PM -0700, Jonathan Lemon wrote:
>> On Fri, Jun 26, 2020 at 09:47:25AM +0200, Christoph Hellwig wrote:
>>>
>>> Note that this is somewhat urgent, as various of the APIs that the code
>>> is abusing are slated to go away for Linux 5.9, so this addition comes
>>> at a really bad time.
>>
>> Could you elaborate on what is upcoming here?
> 
> Moving all these calls out of line, and adding a bypass flag to avoid
> the indirect function call for IOMMUs in direct mapped mode.
> 
>> Also, on a semi-related note, are there limitations on how many pages
>> can be left mapped by the iommu?  Some of the page pool work involves
>> leaving the pages mapped instead of constantly mapping/unmapping them.
> 
> There are, but I think for all modern IOMMUs they are so big that they
> don't matter.  Maintaines of the individual IOMMU drivers might know
> more.

Right - I don't know too much about older and more esoteric stuff like 
POWER TCE, but for modern pagetable-based stuff like Intel VT-d, AMD-Vi, 
and Arm SMMU, the only "limits" are such that legitimate DMA API use 
should never get anywhere near them (you'd run out of RAM for actual 
buffers long beforehand). The most vaguely-realistic concern might be a 
pathological system topology where some old 32-bit PCI device doesn't 
have ACS isolation from your high-performance NIC such that they have to 
share an address space, where the NIC might happen to steal all the low 
addresses and prevent the soundcard or whatever from being able to map a 
usable buffer.

With an IOMMU, you typically really *want* to keep a full working set's 
worth of pages mapped, since dma_map/unmap are expensive while dma_sync 
is somewhere between relatively cheap and free. With no IOMMU it makes 
no real difference from the DMA API perspective since map/unmap are 
effectively no more than the equivalent sync operations anyway (I'm 
assuming we're not talking about the kind of constrained hardware that 
might need SWIOTLB).

>> On a heavily loaded box with iommu enabled, it seems that quite often
>> there is contention on the iova_lock.  Are there known issues in this
>> area?
> 
> I'll have to defer to the IOMMU maintainers, and for that you'll need
> to say what code you are using.  Current mainlaine doesn't even have
> an iova_lock anywhere.

Again I can't speak for non-mainstream stuff outside drivers/iommu, but 
it's been over 4 years now since merging the initial scalability work 
for the generic IOVA allocator there that focused on minimising lock 
contention, and it's had considerable evaluation and tweaking since. But 
if we can achieve the goal of efficiently recycling mapped buffers then 
we shouldn't need to go anywhere near IOVA allocation either way except 
when expanding the pool.

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
