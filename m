Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 210E6C433F5
	for <iommu@archiver.kernel.org>; Wed,  1 Dec 2021 19:46:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BAFAD607B3;
	Wed,  1 Dec 2021 19:46:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ei0vdnL1XzjR; Wed,  1 Dec 2021 19:46:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9783F60724;
	Wed,  1 Dec 2021 19:46:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 74192C0012;
	Wed,  1 Dec 2021 19:46:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 51605C000A
 for <iommu@lists.linux-foundation.org>; Wed,  1 Dec 2021 19:46:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2C8D241CAD
 for <iommu@lists.linux-foundation.org>; Wed,  1 Dec 2021 19:46:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PQZCVOeImClC for <iommu@lists.linux-foundation.org>;
 Wed,  1 Dec 2021 19:46:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id E49F141CAC
 for <iommu@lists.linux-foundation.org>; Wed,  1 Dec 2021 19:45:59 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D03413D5;
 Wed,  1 Dec 2021 11:45:59 -0800 (PST)
Received: from [10.57.34.58] (unknown [10.57.34.58])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CFB1E3F766;
 Wed,  1 Dec 2021 11:45:56 -0800 (PST)
Message-ID: <70fbdc70-6838-0740-43e3-ed20caff47bf@arm.com>
Date: Wed, 1 Dec 2021 19:45:52 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2 29/33] iommu: Use put_pages_list
Content-Language: en-GB
To: Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>
References: <20211201181510.18784-1-vbabka@suse.cz>
 <20211201181510.18784-30-vbabka@suse.cz>
 <YafH2YT+uxn/y4sV@casper.infradead.org>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <YafH2YT+uxn/y4sV@casper.infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Woodhouse <dwmw2@infradead.org>, patches@lists.linux.dev,
 Pekka Enberg <penberg@kernel.org>, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, David Rientjes <rientjes@google.com>,
 Christoph Lameter <cl@linux.com>, Will Deacon <will@kernel.org>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>
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

On 2021-12-01 19:07, Matthew Wilcox wrote:
> On Wed, Dec 01, 2021 at 07:15:06PM +0100, Vlastimil Babka wrote:
>> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
>>
>> page->freelist is for the use of slab.  We already have the ability
>> to free a list of pages in the core mm, but it requires the use of a
>> list_head and for the pages to be chained together through page->lru.
>> Switch the iommu code over to using put_pages_list().
> 
> FYI, this is going to have conflicts with
> https://lore.kernel.org/lkml/cover.1637671820.git.robin.murphy@arm.com/
> 
> I'm not sure what the appropriate resolution is going to be here;
> maybe hold back part of this patch series to the following merge
> window to give the iommu people time to merge their own patches?

More than that, this version is subtly but catastrophically broken - we 
can't simply pass &gather->freelist through the current IOVA entry_dtor 
machinery, since gather is a stack variable from a few call frames up so 
the actual list head will be long gone by the time 
iommu_dma_entry_dtor() tries to dereference it. It took until I was 
elbow-deep in refactoring the RFC to notice that one :)

Thanks,
Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
