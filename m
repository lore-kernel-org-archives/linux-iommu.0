Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7367AC433FE
	for <iommu@archiver.kernel.org>; Wed, 12 Jan 2022 11:01:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 29791409D2;
	Wed, 12 Jan 2022 11:01:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bA17X-vQ50xl; Wed, 12 Jan 2022 11:01:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B7C9B4019B;
	Wed, 12 Jan 2022 11:01:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 89A17C0030;
	Wed, 12 Jan 2022 11:01:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 53D2AC0030
 for <iommu@lists.linux-foundation.org>; Wed, 12 Jan 2022 11:01:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 30FE06FB8B
 for <iommu@lists.linux-foundation.org>; Wed, 12 Jan 2022 11:01:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qfRegDm7BS60 for <iommu@lists.linux-foundation.org>;
 Wed, 12 Jan 2022 11:01:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7F8486FB8F
 for <iommu@lists.linux-foundation.org>; Wed, 12 Jan 2022 11:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641985303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8/XZEAdk6QhvWrbmCBXkp2EEmuq+KMqsHqxGoGIR2UA=;
 b=DK1+lKg2UaD3bNk8Dy8HUxN36HXmHiZQ2CxVywgzFn+l4sE5C0QlCEH0blT7WCCngTkOv0
 LJS9JjB7pRa+Mt8sb4VgSpnsNnAC4I+OqB/K0oEPHQKAY7Vfosm9cSJQwnrGjdo1YBNZzL
 RE9MYJPUnAp2JiZeYIJ66hN/ajZm3m0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-583-_XrIcovKOJygLCaQTo0D9w-1; Wed, 12 Jan 2022 06:01:40 -0500
X-MC-Unique: _XrIcovKOJygLCaQTo0D9w-1
Received: by mail-ed1-f72.google.com with SMTP id
 ec25-20020a0564020d5900b003fc074c5d21so1895862edb.19
 for <iommu@lists.linux-foundation.org>; Wed, 12 Jan 2022 03:01:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:organization:in-reply-to
 :content-transfer-encoding;
 bh=8/XZEAdk6QhvWrbmCBXkp2EEmuq+KMqsHqxGoGIR2UA=;
 b=MN7HifqYN3Ckc5X9iVm3HceLGwfJ9Y97MmhS01nCm3Ra+/bQ6pZWNNm7TZQPVkDQiU
 Ee3ItSHM2txhktk2d0cyALZbelB/Hlhdu4JcaEX24ZhUclOMZ0gCiNHC08yw0iNszIPG
 02D7CbEkVrL5orxZQ0kMFkEh1aDQ+LvE/1zDns8x9Xg9wnefsQ1clZL9O3Zl7PNNX/uj
 lUlZlbPMsUc8FhfT8vIiYsZz14RsyNDUNQef9oN9/7Wjap+XWfH0HU0ZSYVAvCyNADYz
 XtEAhROeShKznNsdlRnq1REee173lB7UuJoaU3dsa9gSf0+Ld8jSglXGTeWMhKKPBW7a
 HrUQ==
X-Gm-Message-State: AOAM53001iLmPoGI4z51L9mY8xJ7KGiPQD0I1meE5pYOtUzwwVT8hHZ+
 +WKQVZW1wkLsNQSXY+lbnSSleQEW17J1TCJaQEYpZyV5Xi4m/0CCglskJE5tn37QcT1ST4esNaO
 fZCTdDv4clExckVEJHU2GIuC/nQKz9g==
X-Received: by 2002:a05:6402:4405:: with SMTP id
 y5mr8374681eda.179.1641985298979; 
 Wed, 12 Jan 2022 03:01:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxWWf+6A4h9fD+VcApry/1ctZSaWE5x9A2DNgQ1rynCwOFlVNP1wLYNq0HbTcp/3NUGR7KzoA==
X-Received: by 2002:a05:6402:4405:: with SMTP id
 y5mr8374660eda.179.1641985298747; 
 Wed, 12 Jan 2022 03:01:38 -0800 (PST)
Received: from ?IPV6:2003:cb:c702:4700:e25f:39eb:3cb8:1dec?
 (p200300cbc7024700e25f39eb3cb81dec.dip0.t-ipconnect.de.
 [2003:cb:c702:4700:e25f:39eb:3cb8:1dec])
 by smtp.gmail.com with ESMTPSA id 13sm4394200ejh.225.2022.01.12.03.01.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Jan 2022 03:01:38 -0800 (PST)
Message-ID: <a5e029e8-f646-a414-f4f4-ba573171642f@redhat.com>
Date: Wed, 12 Jan 2022 12:01:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [RFC PATCH v3 2/8] mm: compaction: handle non-lru compound pages
 properly in isolate_migratepages_block().
To: Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org
References: <20220105214756.91065-1-zi.yan@sent.com>
 <20220105214756.91065-3-zi.yan@sent.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220105214756.91065-3-zi.yan@sent.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Mel Gorman <mgorman@techsingularity.net>,
 Michael Ellerman <mpe@ellerman.id.au>, Robin Murphy <robin.murphy@arm.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Eric Ren <renzhengeek@gmail.com>, virtualization@lists.linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>,
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

On 05.01.22 22:47, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> In isolate_migratepages_block(), a !PageLRU tail page can be encountered
> when the page is larger than a pageblock. Use compound head page for the
> checks inside and skip the entire compound page when isolation succeeds.
> 

This will currently never happen, due to the way we always isolate
MAX_ORDER -1 ranges, correct?

Better note that in the patch description, because currently it reads
like it's an actual fix "can be encountered".

> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>  mm/compaction.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index b4e94cda3019..ad9053fbbe06 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -979,19 +979,23 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>  		 * Skip any other type of page
>  		 */
>  		if (!PageLRU(page)) {
> +			struct page *head = compound_head(page);
>  			/*
>  			 * __PageMovable can return false positive so we need
>  			 * to verify it under page_lock.
>  			 */
> -			if (unlikely(__PageMovable(page)) &&
> -					!PageIsolated(page)) {
> +			if (unlikely(__PageMovable(head)) &&
> +					!PageIsolated(head)) {
>  				if (locked) {
>  					unlock_page_lruvec_irqrestore(locked, flags);
>  					locked = NULL;
>  				}
>  
> -				if (!isolate_movable_page(page, isolate_mode))
> +				if (!isolate_movable_page(head, isolate_mode)) {
> +					low_pfn += (1 << compound_order(head)) - 1 - (page - head);
> +					page = head;
>  					goto isolate_success;
> +				}
>  			}
>  
>  			goto isolate_fail;


-- 
Thanks,

David / dhildenb

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
