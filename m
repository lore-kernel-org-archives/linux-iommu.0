Return-Path: <SRS0=CWSE=5Y=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF445C2BA1B
	for <iommu@archiver.kernel.org>; Wed,  8 Apr 2020 15:38:13 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79DAB206F7
	for <iommu@archiver.kernel.org>; Wed,  8 Apr 2020 15:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gBMMD0VV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79DAB206F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 31CA6881A4;
	Wed,  8 Apr 2020 15:38:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S0ZzmWaU5Gwg; Wed,  8 Apr 2020 15:38:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id A61A987368;
	Wed,  8 Apr 2020 15:38:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9AD47C1AE8;
	Wed,  8 Apr 2020 15:38:12 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2378AC0177
 for <iommu@lists.linux-foundation.org>; Wed,  8 Apr 2020 15:38:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 1263787368
 for <iommu@lists.linux-foundation.org>; Wed,  8 Apr 2020 15:38:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hcSnqGIiUQNn for <iommu@lists.linux-foundation.org>;
 Wed,  8 Apr 2020 15:38:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 661178744A
 for <iommu@lists.linux-foundation.org>; Wed,  8 Apr 2020 15:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=zXlIsbDM28OKmK+7j6iTmvR4wjllvC+TzshTZOZR7TU=; b=gBMMD0VVRRKgOhHzpjDt/lZU1Y
 u9BILt8VLhw0sO34uaQF8z0/PQuXdH0k8rq6aufu410mYc/h3uYsHE3q9jGtAR4M+g6usA+9c6hXK
 qRLaLBonqPUOIZaYwx8mMo+2EsEG9nTiAccNRbs6mfHNotxOLNwE+DlKy1V2XzHirfFfsMPOVzUym
 kj+8W0aL1LC5SGUCy/9LavI/NBI3tZTJ8tgBbvnAEsg8PZoPaY6ZqgBKJJoDlEFMhPCgeRUq/t2tJ
 UNV8tw5S5/pX84WeHyxnsmLcEBTrdKEA6VvzmozcQ0Sa3ZoJrnu5VhBf+PUP8I8OdfHleFuFcY7pQ
 OYfbsiKQ==;
Received: from [2601:1c0:6280:3f0::19c2]
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jMCm9-0006Y5-CG; Wed, 08 Apr 2020 15:38:07 +0000
Subject: Re: [PATCH 10/28] mm: only allow page table mappings for built-in
 zsmalloc
To: Christoph Hellwig <hch@lst.de>, Matthew Wilcox <willy@infradead.org>
References: <20200408115926.1467567-1-hch@lst.de>
 <20200408115926.1467567-11-hch@lst.de>
 <c0c86feb-b3d8-78f2-127f-71d682ffc51f@infradead.org>
 <20200408151203.GN20730@hirez.programming.kicks-ass.net>
 <20200408151519.GQ21484@bombadil.infradead.org>
 <20200408153602.GA28081@lst.de>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ce1cb560-2670-c79d-48eb-e4dd423aecb0@infradead.org>
Date: Wed, 8 Apr 2020 08:37:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200408153602.GA28081@lst.de>
Content-Language: en-US
Cc: linux-hyperv@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
 "K. Y. Srinivasan" <kys@microsoft.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
 Wei Liu <wei.liu@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>,
 x86@kernel.org, David Airlie <airlied@linux.ie>,
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

On 4/8/20 8:36 AM, Christoph Hellwig wrote:
> On Wed, Apr 08, 2020 at 08:15:19AM -0700, Matthew Wilcox wrote:
>>>>>  config ZSMALLOC_PGTABLE_MAPPING
>>>>>  	bool "Use page table mapping to access object in zsmalloc"
>>>>> -	depends on ZSMALLOC
>>>>> +	depends on ZSMALLOC=y
>>>>
>>>> It's a bool so this shouldn't matter... not needed.
>>>
>>> My mm/Kconfig has:
>>>
>>> config ZSMALLOC
>>> 	tristate "Memory allocator for compressed pages"
>>> 	depends on MMU
>>>
>>> which I think means it can be modular, no?
>>
>> Randy means that ZSMALLOC_PGTABLE_MAPPING is a bool, so I think hch's patch
>> is wrong ... if ZSMALLOC is 'm' then ZSMALLOC_PGTABLE_MAPPING would become
>> 'n' instead of 'y'.
> 
> In Linus' tree you can select PGTABLE_MAPPING=y with ZSMALLOC=m,
> and that fits my understanding of the kbuild language.  With this
> patch I can't anymore.
> 

Makes sense. thanks.

-- 
~Randy

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
