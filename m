Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793958640;
	b=zaU27+1GDpdm7xkdzrjYmS54ye5ZRy7jW1e7CQZSTgClF/M3Gh13WAGNmir+/X4tLHHP
	 dm0HahcicQ1NjRpMY6tVQrhxgyMEQqfaA2Wmup3TCocWzy1VI3DFgvsQr0nmeAXZzGVm7
	 NZaa3xcRYKf1ZSt0rq/D2mTthYiJRvj85i6dPJERMPq1UhKwm5hOlCKbMrHMRnnvdcq9s
	 C61vlJ4qdMqSroBsUnf+Eu/DDUEpb3cP9wMQ9EzuQOWUAifBwmwm0esuMQ9zR8kNPjuXI
	 8Tc05HHvUXe/o7og268SekER7sZRpQhf8qfaITNGPfvSL2aBo2q4rhc3QmrO7WLwYiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793958640;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=RupwrtSRCRknDTCP4U8+mHVorluG3D1aDqrqCuXGL/o=;
	b=G6WPzeNaADji6XMna0O6T7rTDQIeA06e39YUy9L5fBZ/2KScuMIzN2lfSqqxISTFNMm3
	 J1pYZ0pWtNeiZFEIFa6i4JN2Gz7/Fm+RTM/WMNC7eloH7euXJQTlFFc0u1pSIkemxaFVw
	 w39UgT+mr8FR9RtQvDP4iKwiBiAn9IQN8sdiACf/Ad3ZUBVAvZO6Vkfs/TbfIDb95J4Y/
	 ZUKkXqdjHkP3FTuo3IhP56ykDvRmRkEtX2jOMAq2vA+jgjr9tigHRz8rDgw7UQ4T2KSw1
	 P68AxLuaMZ53uluB2v+UzjjR/Hzl7e/STIlelhZoeCXdMGQnnH1WE8tBdWk+RHi67iA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UUKyuuQv;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA46606EEBA
	for <iommu@lists.linux.dev>; Fri,  6 Nov 2026 09:50:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EAA46606EEBA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UUKyuuQv
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-490585eddfcso290442f8f.0
        for <iommu@lists.linux.dev>; Fri, 06 Nov 2026 01:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793958638; x=1794563438; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RupwrtSRCRknDTCP4U8+mHVorluG3D1aDqrqCuXGL/o=;
        b=UUKyuuQvG/ORTmnYmorHohpcYhdE05C8Nl2V6I5KNltk3IT9pvOs4FyndLQMaocIfU
         v8xdfqkjnvOMIF+Rdjy610ob8q5rpePjbUMxnxnbR7hdTqXple+lIzOpba78qJTDvdBE
         Xbxdr7CqCYa+YzxZ5XSSrN+HtapnYmO0kA3yO6ljEIe/erfDr2/y1LoVJFObPjkj5dL8
         J2YWTvzQXLmEez5dgcYTkKYLp+eysLNdMcO2cFAEYlqvsaNmi87p8wrIpBwOHBG9XvnY
         UdDrg6nKfS9Pw5lxzJRcVvtWWhaF8O9MwxyjrtUdv+ItsIu/2iNT6IUG1dzl9Mao3Nul
         j5jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793958638; x=1794563438;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RupwrtSRCRknDTCP4U8+mHVorluG3D1aDqrqCuXGL/o=;
        b=w+O+thBCzhXdAxpYQz9yr9m2Klx9YRIClZdRsksAployDe/8d6+LyW3z2n0AEvxqm9
         sNWhDtaHMiFhVhqCq3e2lal6mHytErR389CGu6JComb8LOQHI99udVF10CWRQ3BRsgsd
         rouDjf83xuxwkJfhhsYxWPJqhzZrxwmqN2dDnUY7DVCqPtPtKf5+YyP5EvP/jRsX43bg
         tTPJHMFUqWlma6eyi2bbmkAgY8D1uUSOht7N0KJ3BVL/nccCKfIDIoLYyTCzJ9QpINvc
         6+Bn/et1H6IPneVEqKJeQc34loW2jKL2vC6GlfuSV+b7JqgWPXk8PsfcJHfLEjGZtO5x
         Mktg==
X-Forwarded-Encrypted: i=1; AL+hErE4cRa8PdbSMImloi8gcGleh03jnYcJWfKSAwghFTGHVplYLFO9bRhGncKzqmYs7qh/bUgIEw==@lists.linux.dev
X-Gm-Message-State: APuU4Z8pgSIQSBZi9/lHxyTpZ2WoJ9pXigazStufJXp/nCMSCkCrmewM
	2MsPvyIqPPL5XzilgJjattUeCGa6h7f2FEGf0hijaWxLlq2DQHUdnn56
X-Gm-Gg: AYBFou3EJNGH/oHIZr8XyGQ97orc90uF1k02f0U92+piGqz6sAkSCjac56iWiqZLh83
	us9+SOJXQeh0CLz8kfi3KJZ1oDoqk5jaiCUJ0FB7VypoGfaSycgJFKAOtrSirhnTb/xWB1L10Ut
	HUuNc9HbMMGShQNyz59L5KhN/whFS07qp2EawDTIVrJTLtxp6Oy05ZoOnkmjxlJNuP37/dneZi2
	AoU2ofaw2us99H9HVO854JDSFo9XC8+2d6UAiD5oUeeugeP48nXwjsunpg15tlHTkmvzlDPz3ok
	5hn2hX+DkCbUaP3fmkbhSQLGjAx5dX2mpGUDs5viG1YCLNr0KPjDqzwrszmrjNBCLmUuy6eZAUs
	V7Snit16fAcgbARrsehm4/RCg9ZGsYS9bBvlE2trBoxj9Lk5DjT6jAacv3t2L+ySzqMaSd4YgMw
	B+kdz+xXb1jqDx/i6UEQtmWE4roNhFi/BCv9eNVNedJNGX05bbL2SPsGXkzhU4JQU/XfWe0sIJT
	THOGvnim7EEFjgs+Cs94KyPYq5VUV8eQbezrJmLN7tgoTXNlZs5tFHAG0lR5f6SclrIjRIGHNOz
	dzKi5ne+bm0wagLNxkbemEI=
X-Received: by 2002:a5d:5d82:0:b0:491:83e7:32bd with SMTP id ffacd0b85a97d-49277f88313mr3982559f8f.50.1793958637679;
        Fri, 06 Nov 2026 01:50:37 -0800 (PST)
Received: from [192.168.1.22] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d3d60e78sm2755152f8f.1.2026.11.06.01.50.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2026 01:50:37 -0800 (PST)
Message-ID: <6662ae76-c8dc-4bc5-9730-bf9f537ca9cb@gmail.com>
Date: Fri, 6 Nov 2026 10:50:34 +0100
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
Subject: Re: [PATCH 2/5] mm: limit pagecache folio refcount when splicing into
 pipes
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
 iommu@lists.linux.dev, stable@vger.kernel.org
References: <20261105-refcount_overflow_stable-v1-0-70b9c655da3e@kernel.org>
 <20261105-refcount_overflow_stable-v1-2-70b9c655da3e@kernel.org>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <20261105-refcount_overflow_stable-v1-2-70b9c655da3e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/5/26 2:10 PM, David Hildenbrand (Arm) wrote:
> Similar to mapping pagecache folios into page tables, let's reject splicing
> folios into a pipe if the refcount is at it's limit, similar to how we
> handle it during GUP.
> 
> This will prevent more cases of possible folio refcount overflows with
> large pagecache folios.
> 
> Let's keep it simple and check in the two callers of
> splice_folio_into_pipe().
> 
> Also check in try_get_page() to cover pipe-buffer duplication by tee()
> and partial pipe-to-pipe splicing.
> 
> Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
> Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
> Fixes: 793917d997df ("mm/readahead: Add large folio readahead")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

LGTM:

Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>

-- 
cheers,
jose a. p-a
