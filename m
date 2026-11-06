Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793958978;
	b=34+bKU5LLF27JF1uoc8QMvoQH1SI2RxiDrr8j1G9N8BstHTN4AdGHRRQvOfu4VbSBfmI
	 YMZnssjDQPNIqn6Q2nqGo7TO+Lla/n/Ml1sUHDl+10drIxjWgL6sHftG/5ZF5gRKzNIJ8
	 JBo5URmdtPcnS8IUH0JMmdrRwhpKLQJsEB3DMUZkKupGldYcBrla3sK7KYQEOGumJQiCL
	 +l6VkYxTqSrATgVW0wpDDvkI7SHfrnUmR6FfH8ySfEk3Bj6u/uMg8SA745WMxeyofafdt
	 3jdTIQGGThlXJKuOLZ2dDMIaYyHXKda6B6Rfy1dxMqAJMNM+pymghAA2/GzqJEI7lbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793958978;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=PVNqNcKixHGsvQRk+aF9Z3pXurarEsFSJxJzB1XGyf0=;
	b=YSE4MY6WxiuhDLoJvORiSeNRSql8ZpFw9NvAt0gPv/DKuruvraE1+p5ij2hWzBqrrB8J
	 HDUhUSKpD0EqBygPNm6TQCb8hzSZLtGcSY/UTrJ4Ud/uzvkVQ8jd1CWXv8hyz/u9BEzF5
	 WAzLYsqLADh3HO77jbLTqjdnImYERFQ6nN7v16fpER5t7Ncva8Pv9uXr1CBcHrMvxF1DA
	 xlKKJz6n/bPyN5uzHPw9fVW9xezuIlG8HsyUjoyiLH7VnUp8+R0nq21WscUw9VoaESwy9
	 gT//aQa1MR9wNwa816ORwfyZZGvp9UB3MRb3DB1+T8nhPTZ7ZYLa3NPkbzluamXAEBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LRVELVcM;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A14E606A328
	for <iommu@lists.linux.dev>; Fri,  6 Nov 2026 09:56:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A14E606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LRVELVcM
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-492f0a1b685so218858f8f.0
        for <iommu@lists.linux.dev>; Fri, 06 Nov 2026 01:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793958976; x=1794563776; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PVNqNcKixHGsvQRk+aF9Z3pXurarEsFSJxJzB1XGyf0=;
        b=LRVELVcMEuZrpSLas8QsS1v02kla16urJHco97PN94lrmuYCws3WyBJuNhzi36gpFm
         Mr2HdtOS5b8qj8Vf2v5sTTly/RNh9LQrDkIaBERDDJqpGVih9pm7fAsV+QA+FDc0d43N
         jmnw/S9IAepaRkyKhBzdAOuGH7wxPmFnci9gimv7VBoYLfPPWc/GHBUjhxo6mnvXmBFw
         Ww0ezXw3269tXOAq/F/khDmptkTVWskIjRI37RhkOKovSMdrrobQwi8EC5pq1c+M5iCW
         JtJHjQIULEJhrmx35ZF9S2pynJgn7C4tQNSxEYX2WuFmL62iDQm1BhRxBoOEsLes7IEx
         rECQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793958976; x=1794563776;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PVNqNcKixHGsvQRk+aF9Z3pXurarEsFSJxJzB1XGyf0=;
        b=l04j4DEDcmn1RJ200grrZgnXn7/w6YNwdYu7dFqs6GfHPVwJvuCQjyhi8dOwW5xaff
         pJPeTDWzBvUUPTL+YUTqhRlhEZPb4M21ZMlWJujR6jt+d3nSx5jYu0E7vCQ8CLtUdG5G
         0QOxL3x3jgJ6Ck8CBGXguYu02XGF4TAbtD32mer6ZYrKGKa6y55YnkXTtil4kV1lh0Vd
         xpF9js5E6jJBd8iNVYPFrSupjtWdJ4O9THjBTd28GJPvjziwbNz71b6L846BRtKHejv5
         oL5lIX6XDzI7yO3X5/XbGOs1heOfqZNatpVxwdZBiTXR0fwAvjgTFb1pv5CMz53+ay6H
         y2ig==
X-Forwarded-Encrypted: i=1; AL+hErHDJijF8jq4+b+DtxS4jBwOqZ1dtq71b9WLPdMq0Wtaj2ZKmR5E4hTuy4kmfin3ScZ0l/5OZQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z9I9WVAfMx2q0NUlXwIp+Yp+WF9MAbuT16UKTbAnfoSDQ6NNGE7
	4E2LZX4fe5OB/0p0zOpFW8rAkwUGJZORRgaEy0rbzMFtWoIJXF5Wj1V/
X-Gm-Gg: AYBFou1oquHtFiX68ctO81LI3O+1PA5pcKBkPxCsYNdtj6dwui8xBiOuVI1Pxk3yAoB
	sTW9IBsTj88z183NAi4dO8DyXauimSpiIZXmmqE+girF8Xcd7mnoG7lJOA8i7gMPf3n905aJ4jW
	klxqbezJwFeGWC5OqbWhrKE7XOk45RIs7tyqukmGUa8RZzsUGIGwtcvdlfzQtf4Q3D3AbwF1y1G
	sOjDqAq6SnLalIG2yr8MS0dzXFDXf69yP9JbKAHC1sYDf8VuB6i5kV4KKcpPSmVH8ba6YdOLaqE
	WljtH8FW3C2gJCR6ptJzYAxQSP0pl9K2fCnQtkLi5E2zd4n3vL5batwNv38jA1FC6OAH7wlcYFc
	zLecEJvxeIpqAUCzneUvH882zl7EeTyQqVil0SL0zpNu+edxA7GeyWIRuVQQ0MEWpgmX9U3a0yq
	ntCptplwos/p+nvtlcY6394+4nsxbnvQ2Bobm1dfbKQvd/vWns5UCTLElyh1dAD3aYog7lzdPJy
	fN/CweWo62oqXfuC/m80K/3sr4iOgktr7aUTy9OaUQSOKIAjKoW4CE9wJW1uJUiZ0WukvJuSjw1
	cV+TAplj5n9NcwrbWndlzFo=
X-Received: by 2002:a05:6000:26d3:b0:48e:6159:8274 with SMTP id ffacd0b85a97d-492765a3e9emr3874962f8f.27.1793958975594;
        Fri, 06 Nov 2026 01:56:15 -0800 (PST)
Received: from [192.168.1.22] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d7dbb0d4sm2752385f8f.50.2026.11.06.01.56.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2026 01:56:15 -0800 (PST)
Message-ID: <e3e15340-d6c0-479b-867f-e5eeac1e0e2c@gmail.com>
Date: Fri, 6 Nov 2026 10:56:11 +0100
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
Subject: Re: [PATCH 3/5] mm/mmu_gather: flush pending references early before
 the folio limit
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
 <20261105-refcount_overflow_stable-v1-3-70b9c655da3e@kernel.org>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <20261105-refcount_overflow_stable-v1-3-70b9c655da3e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/5/26 2:10 PM, David Hildenbrand (Arm) wrote:
> When a task zaps mappings (e.g., MADV_DONTNEED), it can drop the PT lock
> and defer dropping the folio references. In the meantime, page faults
> can refault pagecache folios, creating more references for the same
> folios.
> 
> Let's just request a flush after enqueueing a pagecache folio whose
> refcount reached a certain threshold. Start flushing well before new
> references are refused, regardless of the caller's privileges.
> 
> This is a temporary measure until we have something better.
> 
> Reported-by: Chris Mason <mason@kernel.org>
> Fixes: 10ebac4f95e7 ("mm/memory: optimize unmap/zap with PTE-mapped THP")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

LGTM:

Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>

-- 
cheers,
jose a. p-a
