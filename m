Return-Path: <SRS0=CWSE=5Y=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D240BC2BA1B
	for <iommu@archiver.kernel.org>; Wed,  8 Apr 2020 15:37:05 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8A84206F7
	for <iommu@archiver.kernel.org>; Wed,  8 Apr 2020 15:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VNbrIglN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8A84206F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9668287FA1;
	Wed,  8 Apr 2020 15:37:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TqCjLcwHKeiT; Wed,  8 Apr 2020 15:37:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4CDD087FB9;
	Wed,  8 Apr 2020 15:37:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3B08CC1AE8;
	Wed,  8 Apr 2020 15:37:03 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9A8EEC0177
 for <iommu@lists.linux-foundation.org>; Wed,  8 Apr 2020 15:37:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 88C4285BFB
 for <iommu@lists.linux-foundation.org>; Wed,  8 Apr 2020 15:37:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id spCau_-o69oy for <iommu@lists.linux-foundation.org>;
 Wed,  8 Apr 2020 15:37:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 16A3385BE4
 for <iommu@lists.linux-foundation.org>; Wed,  8 Apr 2020 15:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=NjrfXWzBHp9dUGtZC6AXf3gVdy3neXUwD6Zi4ikgFI4=; b=VNbrIglNX5XGXIm/NNZLA+p/Kj
 5sP44g8Gpu4dV5GQq48I/VAqImWTTO7UOVLC/I93y9bsLUoXRrAZrGsO8pqaFrLK3hNNWcPpO7LH9
 sBbHuvgX3ssA94QgJvW5ecpOgR54ODRZMbvySxIZlw5wFH3PzF9jebAP4ULouyfQQPH9WOOPKUjGE
 SFEXAfLSq8aoH4PyEC3XZbMmEfljyKBbGbCbm+zAYF4emVk1HnLFKAZfR9+5/zqUGpO6yxi7UX57i
 QnssTPKyGTMpoTQgpDVnM9fMHQMfG8vEvg/t7TUqcXxvUGoeqIlv7lInyBmt6r7bZNjJr105FtD51
 eSrtUb/w==;
Received: from [2601:1c0:6280:3f0::19c2]
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jMCl9-00069a-K4; Wed, 08 Apr 2020 15:36:59 +0000
Subject: Re: [PATCH 10/28] mm: only allow page table mappings for built-in
 zsmalloc
To: Matthew Wilcox <willy@infradead.org>, Peter Zijlstra <peterz@infradead.org>
References: <20200408115926.1467567-1-hch@lst.de>
 <20200408115926.1467567-11-hch@lst.de>
 <c0c86feb-b3d8-78f2-127f-71d682ffc51f@infradead.org>
 <20200408151203.GN20730@hirez.programming.kicks-ass.net>
 <20200408151519.GQ21484@bombadil.infradead.org>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <139a494a-f946-fd4b-4854-6ff625e4c24f@infradead.org>
Date: Wed, 8 Apr 2020 08:36:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200408151519.GQ21484@bombadil.infradead.org>
Content-Language: en-US
Cc: linux-hyperv@vger.kernel.org, David Airlie <airlied@linux.ie>,
 dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
 "K. Y. Srinivasan" <kys@microsoft.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
 Wei Liu <wei.liu@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>,
 x86@kernel.org, Christoph Hellwig <hch@lst.de>,
 Laura Abbott <labbott@redhat.com>, Nitin Gupta <ngupta@vflare.org>,
 Daniel Vetter <daniel@ffwll.ch>, Haiyang Zhang <haiyangz@microsoft.com>,
 linaro-mm-sig@lists.linaro.org, bpf@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Christophe Leroy <christophe.leroy@c-s.fr>,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 Minchan Kim <minchan@kernel.org>, iommu@lists.linux-foundation.org,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
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

On 4/8/20 8:15 AM, Matthew Wilcox wrote:
> On Wed, Apr 08, 2020 at 05:12:03PM +0200, Peter Zijlstra wrote:
>> On Wed, Apr 08, 2020 at 08:01:00AM -0700, Randy Dunlap wrote:
>>> Hi,
>>>
>>> On 4/8/20 4:59 AM, Christoph Hellwig wrote:
>>>> diff --git a/mm/Kconfig b/mm/Kconfig
>>>> index 36949a9425b8..614cc786b519 100644
>>>> --- a/mm/Kconfig
>>>> +++ b/mm/Kconfig
>>>> @@ -702,7 +702,7 @@ config ZSMALLOC
>>>>  
>>>>  config ZSMALLOC_PGTABLE_MAPPING
>>>>  	bool "Use page table mapping to access object in zsmalloc"
>>>> -	depends on ZSMALLOC
>>>> +	depends on ZSMALLOC=y
>>>
>>> It's a bool so this shouldn't matter... not needed.
>>
>> My mm/Kconfig has:
>>
>> config ZSMALLOC
>> 	tristate "Memory allocator for compressed pages"
>> 	depends on MMU
>>
>> which I think means it can be modular, no?

ack. I misread it.

> Randy means that ZSMALLOC_PGTABLE_MAPPING is a bool, so I think hch's patch
> is wrong ... if ZSMALLOC is 'm' then ZSMALLOC_PGTABLE_MAPPING would become
> 'n' instead of 'y'.

sigh, I wish that I had meant that. :)

thanks.

-- 
~Randy

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
