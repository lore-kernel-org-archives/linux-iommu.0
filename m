Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793958143;
	b=qnhK7OU64HPp5DEB+XmeoNNP41TOvrVFPn1QwXUiLkhPNCCxCZLxa3+L0JdqGn5dYwwx
	 4Ry8GlpiNKYKsTldE5qMXnwFEaXcx44r8iVlBf5Ens+FfYtKPZ1n9N1uND1We9xiWEZy7
	 PZSylNleneec+BaxPI3so1fTOxy49jgAiJ81Ix1BQzcd6GtmMf4A4TCd3IPd0UJzFq408
	 QAxAP+HUJwYf0lU5IfupII4O1NBuhpfoAyDvzE4qe1Pm1fng3IZQbg1D5tRNmDvZmwmn3
	 E2ZIhleGpkkbjMIHNQ1T41mm9e/OHTMQz0JdGnsRlQ9zV07zVxmFu2bifCPs3M/1WWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793958143;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=wxjoU6eh1AnEB74q9TNTzzgoHGIbkez0gtAfCeShC9g=;
	b=eHWRLargQ8kOhzfwdBWLEz48/F2fkICBxGxfmlppCkLN3Pj8d1GWUqjlhHBwq7JW94qH
	 D8PP1/Kp1ixmMeFaCxRxKg/Xhb39MvOJnUhhs6WRfEN4phrO9UvmAoqWWzIItzUKvGcab
	 iCuCjRwTyufoXrjAJ4ogvQIcNWe+3NBIjhNeaBXY3pV4/zYe38KWT1mAEIU6cEI8nrZdQ
	 Dm61eJwi+QMv4e8YIh2yL8aqqQ4RFEqSk6hJjD4smE85hqmViQqQh5w1/4myl/Zfs6vEt
	 3QFVpRj/JzOxv9D18wrD996QOsC6zYO9hQL7ZAt6ETPzx29Wvp5KmiwHGa7mw+/9fQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="YLPs/XiL";
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8C6606A90C
	for <iommu@lists.linux.dev>; Fri,  6 Nov 2026 09:42:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA8C6606A90C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YLPs/XiL
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4b467581b98so3093185e9.0
        for <iommu@lists.linux.dev>; Fri, 06 Nov 2026 01:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793958141; x=1794562941; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wxjoU6eh1AnEB74q9TNTzzgoHGIbkez0gtAfCeShC9g=;
        b=YLPs/XiL1yrfJSKvgjFLqFpYVf+5gAOArCdmDxZArUbHzbBnM+IOxoX27NWOpFgUSc
         uJB6Isa+mNvkOdvybXZoiZMFSJnG2IKitBp1pUlJSFSTnY06Nzs7QFn6/Au/hSYvBYjq
         /Te6OaWDfi70zBPqcamiDGXwZp51hiXo4KSR1gByB+ezd1rnmfBdr4xuEV+q6BiG66I/
         hZiHv/7a3TXSNU3wjUm1LtcYYEtgjEFblO297XYEWSy2xgXHZppO2fOLKXA3EHDa/dFT
         Qj5EpV9z68taA/KSTT76Xn4fszchN5r2ZVzm1lTTiBWjtyYaj0dkpJndGlOstYiOlDhw
         q3sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793958141; x=1794562941;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wxjoU6eh1AnEB74q9TNTzzgoHGIbkez0gtAfCeShC9g=;
        b=qO3CJH6U2f7zrQ7cPcCF0wgIKCtsAz10yYmVwoF7sEhfPxUTjswciKbH72wTGvtqNq
         fJRWoQZmlGcqk5lwQLDz8n/sZjphSmGse0m39DUtpvhq4kpQc+J4Xi2dq9q4RLJkclqQ
         QQPuCYKZdarSssBfcM7Q6QVtW5LXSoLnGbWFegTBF1BFdsGtXydZGJcB+jPzMbXu7rVs
         b6tcbfNtOKbRs4de6DHkFIFecnvRtVAHqOZX+wtkOXbL0RaVdwrDXN25nHiizQERqCmN
         PyzaFL0+hZOapNQ5BOgcmGwpprFaUtnvx+9fKHh979H9IzOyFCAfqH+ZPAJKZk2ZoPOB
         ik9g==
X-Forwarded-Encrypted: i=1; AKwUvBy2VhA78AwrCiJ8nQT3BaL5fDDO3Csjzxc53AdJ9iJnddRKA6dufD2sT4OGM7qLMXYObfl0pw==@lists.linux.dev
X-Gm-Message-State: APuU4Z8QmZ+14vX0U9zOibJYZVTySXFIsZVLbqFDF7Ylx5jPqKInUPgr
	YycrBl7Hel6Ga7uqrpGItynXZIHqZ2ig4SXBS9uT4EtW8qUv6V6TNEey
X-Gm-Gg: AYBFou050PFuRyBjEeOyrKxJgg15KceX/1AH3FCThEGLoS7QRC7pfzXBNX5AI8n4HF3
	kQqi2aeZ6xJbD/CdYs+wQMNnlt5g1bM25JaA9H2EraWfRBltdL8r3SuvJt7rijKOhm63jtOA0OM
	fpMaMlRhyEioLGBM8CHCwMONQrogeeZO/01GM4lJcX8Anmnpv0FskaGoX5HchVzXOXLLRVl5EXj
	l88FHICbqPkEbbMxa//zp7B2Xu2wXReJy2LsPOrnQmjlo6/e8hQXK19tyk6IQPl62AfoHadoIWe
	9gH+QSYS5oHhuR1XCzFRp+5zfHIN6ZkaWdbFWVsMsf/wwj6xgGPYfxbAQGn1d23JMKjHz9p79KT
	UXQepZAf6Vy26Btv9m6YET/aVaoRRYifDCffasIneBJftAOEFfuG1cLXycepWt02G5kKh48kRDE
	7SrebYdj19SNaWtPOQLZosg6jzfrLarYYNlnK0jF0F7lSd6jRddh0qNkjCAmKdnU5sddGDor1mr
	psPZWh8U37mCCEP8k35zfigvz1NEESO2DM8l+WymK1/trMRkJUxCUs1HLWVqs8qK/UC/y3oQgSe
	USY5ubbZzVrd7M2t0+gOJKA=
X-Received: by 2002:a05:600c:c168:b0:4a0:1c0e:b057 with SMTP id 5b1f17b1804b1-4b6db2ba2demr25269125e9.4.1793958140866;
        Fri, 06 Nov 2026 01:42:20 -0800 (PST)
Received: from [192.168.1.22] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b741cdd8d7sm22361285e9.1.2026.11.06.01.42.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2026 01:42:20 -0800 (PST)
Message-ID: <528e3a0e-04fb-427f-88c7-63a7f4bbc505@gmail.com>
Date: Fri, 6 Nov 2026 10:42:17 +0100
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] mm: limit pagecache folio refcount when mapping pages
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>, Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
 Kiryl Shutsemau <kas@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>,
 Gregory Price <gourry@gourry.net>, Ying Huang
 <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>,
 Peter Xu <peterx@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Song Liu <songliubraving@fb.com>, Rik van Riel <riel@surriel.com>,
 Hugh Dickins <hughd@google.com>, Will Deacon <will@kernel.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin
 <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
 Steve Sistare <steven.sistare@oracle.com>, John Hubbard <jhubbard@nvidia.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
 iommu@lists.linux.dev, Chris Mason <mason@kernel.org>, stable@vger.kernel.org
References: <20261105-refcount_overflow_stable-v1-0-70b9c655da3e@kernel.org>
 <20261105-refcount_overflow_stable-v1-1-70b9c655da3e@kernel.org>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <20261105-refcount_overflow_stable-v1-1-70b9c655da3e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/5/26 2:10 PM, David Hildenbrand (Arm) wrote:
> With large file folios, overflowing the folio mapcount and refcount
> became possible. For anon folios it is currently not really an issue:
> each large anon folio can only be mapped once into a process.
> 
> That's not really big news, but it's about time that we do something
> about it because some modern technology might find ways to abuse it :)
> 
> One of the enablers for that was commit ddc58f27f9ee ("mm: drop tail page
> refcounting"), however, file thp support was added later.
> 
> File folios can be mapped multiple times into the same process, allowing
> for processes to hold many references to the same folio.
> 
> As a short-term solution, let's introduce two folio refcount limits:
> one for ordinary consumers and one for admins. Leave some headroom
> before the refcount goes negative, which we really don't want (having
> the mapcount go negative is also not expected).
> 
> Start reporting SIGBUS if we run into limits. When restoring mappings
> from migration entries, instead zap the pte/pmd entry. We allow for
> slightly exceeding the limit to keep things simpler.
> 
> This is far from ideal, but better than all easy alternatives we can
> backport comfortably. For now it fixes the big problem: letting
> the refcount (+mapcount) go negative and cause trouble.
> 
> This is only a temporary fix, we'll follow up with something better.
> 
> While the refcount checks are not required for order 0 folios, let's
> just add them for consistency: each folio_add_file_rmap*() and
> folio_dup_file_rmap*() needs a prior check.
in mm-new copy_huge_pmd() now does a folio_dup_file_rmap_pmd() at fork,
since Konstantin's "mm/huge_memory: copy file THPs at fork like
copy_present_ptes() does". doesn't that one need the check too?

the rest LGTM:

Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>

-- 
cheers,
jose a. p-a
