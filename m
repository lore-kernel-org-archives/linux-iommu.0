Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AF75C433F5
	for <iommu@archiver.kernel.org>; Mon, 24 Jan 2022 14:18:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CF5E541606;
	Mon, 24 Jan 2022 14:18:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NgGammn9KEvP; Mon, 24 Jan 2022 14:18:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 89C1440295;
	Mon, 24 Jan 2022 14:18:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 521C4C007A;
	Mon, 24 Jan 2022 14:18:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 11FEBC002F;
 Mon, 24 Jan 2022 09:55:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EE556817E4;
 Mon, 24 Jan 2022 09:55:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=suse.de header.b="KGtiw7Mb";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=suse.de header.b="pccFyVCh"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jlOlAUi8jihQ; Mon, 24 Jan 2022 09:55:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1F2FF817C3;
 Mon, 24 Jan 2022 09:55:46 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1C8DE1F88E;
 Mon, 24 Jan 2022 09:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1643018144; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UY9IYgd8hkKnbM1EBvRlpgL7L8s4nRO/7Rp2w0hALcQ=;
 b=KGtiw7MbrqbtdwmTIN21tihOEMjPY1IV7E0JkU89QUCci4JpOtfDiI1XTrJgmG4yZjZ9h7
 s1QgPOwhButRlG3q7JdTF3j9Cqv/X0oB27ZmmEEx3x//gMB3DOms+1sYO1DHzzism3ATYl
 636sePlLdPVWWR3UHlLv7khhAx6FVgk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1643018144;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UY9IYgd8hkKnbM1EBvRlpgL7L8s4nRO/7Rp2w0hALcQ=;
 b=pccFyVChZpI+deG/lwWKxfYZX5Ho6yT54MMe43//zUOjCgx34C1UbYttn5zp4g777PCZbJ
 q1YdEzxEBH/2CrCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 062BA13AB8;
 Mon, 24 Jan 2022 09:55:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id etlEAaB37mEqVwAAMHmgww
 (envelope-from <osalvador@suse.de>); Mon, 24 Jan 2022 09:55:44 +0000
MIME-Version: 1.0
Date: Mon, 24 Jan 2022 10:55:43 +0100
From: Oscar Salvador <osalvador@suse.de>
To: Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH v4 3/7] mm: page_isolation: check specified range for
 unmovable pages
In-Reply-To: <20220119190623.1029355-4-zi.yan@sent.com>
References: <20220119190623.1029355-1-zi.yan@sent.com>
 <20220119190623.1029355-4-zi.yan@sent.com>
User-Agent: Roundcube Webmail
Message-ID: <b7c311d4b2cd377cdc4f92bc9ccf6af1@suse.de>
X-Sender: osalvador@suse.de
X-Mailman-Approved-At: Mon, 24 Jan 2022 14:18:07 +0000
Cc: Mel Gorman <mgorman@techsingularity.net>,
 David Hildenbrand <david@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, Eric Ren <renzhengeek@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 Vlastimil Babka <vbabka@suse.cz>
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

On 2022-01-19 20:06, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> Enable set_migratetype_isolate() to check specified sub-range for
> unmovable pages during isolation. Page isolation is done
> at max(MAX_ORDER_NR_PAEGS, pageblock_nr_pages) granularity, but not all
> pages within that granularity are intended to be isolated. For example,
> alloc_contig_range(), which uses page isolation, allows ranges without
> alignment. This commit makes unmovable page check only look for
> interesting pages, so that page isolation can succeed for any
> non-overlapping ranges.

Hi Zi Yan,

I had to re-read this several times as I found this a bit misleading.
I was mainly confused by the fact that memory_hotplug does isolation on 
PAGES_PER_SECTION granularity, and reading the above seems to indicate 
that either do it at MAX_ORDER_NR_PAGES or at pageblock_nr_pages 
granularity.

True is that start_isolate_page_range() expects the range to be 
pageblock aligned and works in pageblock_nr_pages chunks, but I do not 
think that is what you meant to say here.

Now, to the change itself, below:


> @@ -47,8 +51,8 @@ static struct page *has_unmovable_pages(struct zone
> *zone, struct page *page,
>  		return page;
>  	}
> 
> -	for (; iter < pageblock_nr_pages - offset; iter++) {
> -		page = pfn_to_page(pfn + iter);
> +	for (pfn = first_pfn; pfn < last_pfn; pfn++) {

You already did pfn = first_pfn before.

>  /**
>   * start_isolate_page_range() - make page-allocation-type of range of 
> pages to
>   * be MIGRATE_ISOLATE.
> - * @start_pfn:		The lower PFN of the range to be isolated.
> - * @end_pfn:		The upper PFN of the range to be isolated.
> + * @start_pfn:		The lower PFN of the range to be checked for
> + *			possibility of isolation.
> + * @end_pfn:		The upper PFN of the range to be checked for
> + *			possibility of isolation.
> + * @isolate_start:		The lower PFN of the range to be isolated.
> + * @isolate_end:		The upper PFN of the range to be isolated.

So, what does "possibility" means here. I think this need to be 
clarified a bit better.

 From what you pointed out in the commit message I think what you are 
doing is:

- alloc_contig_range() gets a range to be isolated.
- then you pass two ranges to start_isolate_page_range()
   (start_pfn, end_pfn]: which is the unaligned range you got in 
alloc_contig_range()
   (isolate_start, isolate_end]: which got aligned to, let's say, to 
MAX_ORDER_NR_PAGES

Now, most likely, (start_pfn, end_pfn] only covers a sub-range of 
(isolate_start, isolate_end], and that
sub-range is what you really want to isolate (so (start_pfn, end_pfn])?

If so, should not the names be reversed?


-- 
Oscar Salvador
SUSE Labs
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
