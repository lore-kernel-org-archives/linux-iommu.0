Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8B7DC433F5
	for <iommu@archiver.kernel.org>; Wed, 12 Jan 2022 11:04:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 902F784B31;
	Wed, 12 Jan 2022 11:04:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kM3hlVdtGfya; Wed, 12 Jan 2022 11:04:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 81D4084B2B;
	Wed, 12 Jan 2022 11:04:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5B7EEC0030;
	Wed, 12 Jan 2022 11:04:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E7614C001E
 for <iommu@lists.linux-foundation.org>; Wed, 12 Jan 2022 11:04:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E381B84B2E
 for <iommu@lists.linux-foundation.org>; Wed, 12 Jan 2022 11:04:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mBjArC87fBDD for <iommu@lists.linux-foundation.org>;
 Wed, 12 Jan 2022 11:04:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4539484B28
 for <iommu@lists.linux-foundation.org>; Wed, 12 Jan 2022 11:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641985479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eQRmWQJO7h35wGy22fa7tdbvt7nutmZtPTdgCQaUOQQ=;
 b=F1UzzZt6AZlDzPRfzWeyzFPi1bnyep/nArTgrBD9Sfg0qRx6hiRUfK0B8DNRR+QVAAZ78d
 NwtTuhGKhkWmz7TV5dE1JfxjQn07r9Af9DcK8c70cDBUYgV1HksEcxtPYjNK5BUR2E67Yr
 +t4dtBkYHLHxcj0u0iRm189R9UjWwR4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-385-xhrYWymWM9iEnXqfcBDLuA-1; Wed, 12 Jan 2022 06:04:33 -0500
X-MC-Unique: xhrYWymWM9iEnXqfcBDLuA-1
Received: by mail-ed1-f70.google.com with SMTP id
 i9-20020a05640242c900b003fe97faab62so1934973edc.9
 for <iommu@lists.linux-foundation.org>; Wed, 12 Jan 2022 03:04:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:organization:in-reply-to
 :content-transfer-encoding;
 bh=eQRmWQJO7h35wGy22fa7tdbvt7nutmZtPTdgCQaUOQQ=;
 b=cJWXJfoMQmy9Bw20CCqoFC6Gbv106CR0ZJeoDbAdOnXvq+VT4zjG8C6dm0lkXXLIZc
 WEn4N7102GdJA/Cj/VIAyyVTrHPd5Q1VL6Zk4osYakpypx9HUVFVpvIdJd5tQszo2acJ
 X+Dg60jh4eZd0BpHTzeePjogXi97hCdc72inPSaE1rKvyRzUan3E/Z0H1XYU1J0WaNnO
 1qVp1J7cd8CDeYVt89bPQoI5F+wZfTmY1Ok1WiQXasm0hobKT4UqWCWIgLZOAD1cpXWc
 0KQ80CBAk083njeKwPOdv0cwcnqT9rAN0RC6xu5khwDNuQSB7cRpJzIvorRPJBlP4bOC
 KGmg==
X-Gm-Message-State: AOAM533XC+EAufYAHb2YSttXELgkXxWlIUiYkxqbSQ7WLOFx0T573sv6
 W1DuyCEoBilf3QCkMdiXrtok8kRFVB6YnykQtFVLsoHd7+jpLMoX+ZsmniPb1kdtRhkNotSj7/l
 ud1FWyOhkLqZOUeYf5Eu7Tq6DRmZDgw==
X-Received: by 2002:a05:6402:486:: with SMTP id
 k6mr8580290edv.330.1641985471847; 
 Wed, 12 Jan 2022 03:04:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyLu6iWsDVwPl07dmV9nmwCMbbplxs+ZFDOgPiX/VhbSWFK2LAa03DeMHirncilimRMIa9S6A==
X-Received: by 2002:a05:6402:486:: with SMTP id
 k6mr8580274edv.330.1641985471689; 
 Wed, 12 Jan 2022 03:04:31 -0800 (PST)
Received: from ?IPV6:2003:cb:c702:4700:e25f:39eb:3cb8:1dec?
 (p200300cbc7024700e25f39eb3cb81dec.dip0.t-ipconnect.de.
 [2003:cb:c702:4700:e25f:39eb:3cb8:1dec])
 by smtp.gmail.com with ESMTPSA id qw4sm4413621ejc.55.2022.01.12.03.04.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Jan 2022 03:04:31 -0800 (PST)
Message-ID: <970ca2a4-416d-7e8f-37c7-510c5b050f4b@redhat.com>
Date: Wed, 12 Jan 2022 12:04:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [RFC PATCH v3 3/8] mm: migrate: allocate the right size of non
 hugetlb or THP compound pages.
To: Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org
References: <20220105214756.91065-1-zi.yan@sent.com>
 <20220105214756.91065-4-zi.yan@sent.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220105214756.91065-4-zi.yan@sent.com>
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
> alloc_migration_target() is used by alloc_contig_range() and non-LRU
> movable compound pages can be migrated. Current code does not allocate the
> right page size for such pages. Check THP precisely using
> is_transparent_huge() and add allocation support for non-LRU compound
> pages.

IIRC, we don't have any non-lru migratable pages that are coumpound
pages. Read: not used and not supported :)

Why is this required in the context of this series?


-- 
Thanks,

David / dhildenb

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
