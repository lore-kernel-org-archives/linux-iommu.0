Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81AE1C433F5
	for <iommu@archiver.kernel.org>; Thu, 13 Jan 2022 12:28:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9B71340142;
	Thu, 13 Jan 2022 12:28:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4M6CAvgYkWn8; Thu, 13 Jan 2022 12:28:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 33C5440158;
	Thu, 13 Jan 2022 12:28:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0A91EC002F;
	Thu, 13 Jan 2022 12:28:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 91AC8C001E
 for <iommu@lists.linux-foundation.org>; Thu, 13 Jan 2022 12:28:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7FE0784B5B
 for <iommu@lists.linux-foundation.org>; Thu, 13 Jan 2022 12:28:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xi-0VfmzfSxE for <iommu@lists.linux-foundation.org>;
 Thu, 13 Jan 2022 12:28:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B026F84B2F
 for <iommu@lists.linux-foundation.org>; Thu, 13 Jan 2022 12:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642076897;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hnfVK2fyY9BtL+cahlLSPFYi/lDkJGG3ZpACsVHPbRc=;
 b=CQcovqztFtuAzWuGOrKpnHCpi2la10zPK6GRSKZzK5nknKgLBzNmaTJ2SBAgUa55PwsGvu
 GHuZDi1EWxWzQNIKCX+eXfTc9tnbXsTfOPWooGVB4XbzBAZ6M7F2NgAKy5BjwoPTgoipUM
 Ijk5ZaOLdoCMy/DHPjhrCbrOusofcIc=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-439-GRfevJTbPFqqQNZIFgRZ5g-1; Thu, 13 Jan 2022 07:28:14 -0500
X-MC-Unique: GRfevJTbPFqqQNZIFgRZ5g-1
Received: by mail-ed1-f69.google.com with SMTP id
 z9-20020a05640240c900b003fea688a17eso5211610edb.10
 for <iommu@lists.linux-foundation.org>; Thu, 13 Jan 2022 04:28:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:organization:in-reply-to
 :content-transfer-encoding;
 bh=hnfVK2fyY9BtL+cahlLSPFYi/lDkJGG3ZpACsVHPbRc=;
 b=jTnJ6qjZsqcbsjBbONKEY5/pNMbqldVonTahxS1z0gj3R2j0tdGXwdayS6jeUnw4Wq
 3TEJsuwTqCJt9bFHuXpWSFHaGKoqnW/oP7mqg7I8QvSV3HKaRJ6fdFgzIyk3kdF5so5M
 hFvYjdLv6lhYIyxBc+E2vSzWogYDG+g3KTvEJPA6PcZqnShFgyLleO1qDqhlTeeFeXyZ
 mUWewx/mde/rxcyvjrNpx7MTKpI7vVSl6KmLnOdXBMsHIh9SQbakRqHa8GiqKwHsMxR1
 0+BUK8tptzh6JwqNzKfrHxItHURrSwPufTSneCNEXwQvO85yI4knz/Lim7MUaTpp37WT
 JYpg==
X-Gm-Message-State: AOAM531oODQefA9xRs6OOTqn7yMJmX05uI9SnHsl87rovwslUSYCoG9x
 FCY8IPe2TvVVawISiE4W668FgHeOaCE83MF5NhRZgWz9wadAPLYMVse4ua8feJTmotHzHN2lSB0
 Yr/LX1TOE9dFNMKZ4EeuGhzHGT6W2TQ==
X-Received: by 2002:a50:8d16:: with SMTP id s22mr3857822eds.141.1642076893362; 
 Thu, 13 Jan 2022 04:28:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyzDUme++gR+E7EfrqgLj1iyeR0r4RpB81KvaPod0mEHW3Q7ncqa9lY+1sUM8bAVvrgQ/bdNg==
X-Received: by 2002:a50:8d16:: with SMTP id s22mr3857806eds.141.1642076893116; 
 Thu, 13 Jan 2022 04:28:13 -0800 (PST)
Received: from ?IPV6:2003:cb:c703:e200:8511:ed0f:ac2c:42f7?
 (p200300cbc703e2008511ed0fac2c42f7.dip0.t-ipconnect.de.
 [2003:cb:c703:e200:8511:ed0f:ac2c:42f7])
 by smtp.gmail.com with ESMTPSA id la21sm830830ejc.137.2022.01.13.04.28.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Jan 2022 04:28:12 -0800 (PST)
Message-ID: <ae2862a0-c39c-ed2f-23fe-510c6c2fad5c@redhat.com>
Date: Thu, 13 Jan 2022 13:28:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [RFC PATCH v3 1/8] mm: page_alloc: avoid merging non-fallbackable
 pageblocks with others.
To: Mike Rapoport <rppt@kernel.org>
References: <20220105214756.91065-1-zi.yan@sent.com>
 <20220105214756.91065-2-zi.yan@sent.com>
 <7dc078ef-70f4-159e-b928-34f0fb0ffaea@redhat.com>
 <YeAO0vtyjWWMRliF@kernel.org>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <YeAO0vtyjWWMRliF@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Mel Gorman <mgorman@techsingularity.net>, Eric Ren <renzhengeek@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-mm@kvack.org, iommu@lists.linux-foundation.org, Zi Yan <ziy@nvidia.com>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 13.01.22 12:36, Mike Rapoport wrote:
> On Wed, Jan 12, 2022 at 11:54:49AM +0100, David Hildenbrand wrote:
>> On 05.01.22 22:47, Zi Yan wrote:
>>> From: Zi Yan <ziy@nvidia.com>
>>>
>>> This is done in addition to MIGRATE_ISOLATE pageblock merge avoidance.
>>> It prepares for the upcoming removal of the MAX_ORDER-1 alignment
>>> requirement for CMA and alloc_contig_range().
>>>
>>> MIGRARTE_HIGHATOMIC should not merge with other migratetypes like
>>> MIGRATE_ISOLATE and MIGRARTE_CMA[1], so this commit prevents that too.
>>> Also add MIGRARTE_HIGHATOMIC to fallbacks array for completeness.
>>>
>>> [1] https://lore.kernel.org/linux-mm/20211130100853.GP3366@techsingularity.net/
>>>
>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>> ---
>>>  include/linux/mmzone.h |  6 ++++++
>>>  mm/page_alloc.c        | 28 ++++++++++++++++++----------
>>>  2 files changed, 24 insertions(+), 10 deletions(-)
>>>
> 
> ...
> 
>>> @@ -3545,8 +3553,8 @@ int __isolate_free_page(struct page *page, unsigned int order)
>>>  		struct page *endpage = page + (1 << order) - 1;
>>>  		for (; page < endpage; page += pageblock_nr_pages) {
>>>  			int mt = get_pageblock_migratetype(page);
>>> -			if (!is_migrate_isolate(mt) && !is_migrate_cma(mt)
>>> -			    && !is_migrate_highatomic(mt))
>>> +			/* Only change normal pageblock */
>>> +			if (migratetype_has_fallback(mt))
>>>  				set_pageblock_migratetype(page,
>>>  							  MIGRATE_MOVABLE);
>>>  		}
>>
>> That part is a nice cleanup IMHO. Although the "has fallback" part is a
>> bit imprecise. "migratetype_is_mergable()" might be a bit clearer.
>> ideally "migratetype_is_mergable_with_other_types()". Can we come up
>> with a nice name for that?
> 
> migratetype_is_mergable() kinda implies "_with_other_types", no?
> 
> I like migratetype_is_mergable() more than _has_fallback().
> 
> My $0.02 to bikeshedding :)

:)

Yeah, for me migratetype_is_mergable() would also be good enough. I
think I was at first thinking one could mistake it with a dedicated
migratetype. But such functions are historically called

is_migrate_cma/is_migrate_cma/....

-- 
Thanks,

David / dhildenb

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
