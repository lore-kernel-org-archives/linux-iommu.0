Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793987931;
	b=QhJLQBBt/6YzQ4aIL0PpOuFSEYsyC2VymoL+2Jj9FRO9sZeP4OMW5wyXv7iwf9r8T5/s
	 8O739HI+uP97DCLv6Zzi7OtCSsW2x4TI3xjMV1XhMvLCmzxxoLIWpjSXgOU2DRL2Bimdu
	 Tqj5WuaIWqMS0R10uae8IFb1mMu+z2oKb35sKOvUNxceLe7mKklFve6kMYT887JX4xZcm
	 gVGUic3J8w3hw/SFNKNYGznSdAbUIv9ckke8NIiV3K+WZgD7TKVVf1d6qeG6kL6aOq3gy
	 yvn468MaXJhlo5IqY3QwfiawaXUXngv9W9tHAR0m7wX7L1TGAi5jcIsYoZs/qXF5Abg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793987931;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=KoOh0KgSmAnOjKaKpi/0YYF58G7PTa1KHqz+Z6PRDOg=;
	b=RE3NKKm48gSmMsvPqCECYDfkzFM9pQeBKN9PqBoMT1qGq/T6qn5sSoEDp4viXDuOyK0a
	 sR3QPc3Ilep7KAnJKSpr3DBJ65PCbAJe0zhUIXrNJBf4K3l4tBOVepYGqDQGnduq9f7bq
	 1LcXhEUQSMPTrd4Lw0E7SpjkRtd+y3AwKdiavMRTS1ScxYtoVEv3N9+UxXhXTeapq+0fn
	 UUcqTsyCsvaRxRvybC+e/+G0E9+A7Y7ipi4h0shdLtj+UzR+JGFE+maSqq2VgIUbkjElh
	 mNSQCHFd//FDqVpplZ/aPixg7x6UilnLwRvALlmVPGi6/PDviBxJFpbLCyz8Me9ZEWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=q8l5HWpV;
	arc=none smtp.remote-ip=209.85.160.174
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07E7606A32E
	for <iommu@lists.linux.dev>; Fri,  6 Nov 2026 17:58:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C07E7606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=q8l5HWpV
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-533778ab0bdso10265351cf.3
        for <iommu@lists.linux.dev>; Fri, 06 Nov 2026 09:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793987929; x=1794592729; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KoOh0KgSmAnOjKaKpi/0YYF58G7PTa1KHqz+Z6PRDOg=;
        b=q8l5HWpVR+6WoIzGWW/C1qIXbvkV5clCBWf+vfGcJl26xoV9k/8qdLG+2SnGeOrB49
         GBhfW2SR+axf6btx+rT+FmyAe73em8Z5eHBANL63aJDqwgiLYOPZw3LjYOCBHzQR0DmS
         KyQSXMT9Y9t78SilpvqXNVJ7uP/8VSkjiffo6519HCkkhZ/tVCnqS3A5vQjDkAqT7yC/
         1mpqTlwN1g3wnEWZ2vywu+krBbZmbhbG4DOK8tMFutuP1WNLu7MW7OKhiSnNImbaAGcJ
         Kt2BtbtPBkbCZ6ZA7WV4ayDRdNfGOpF+CziM7k4seRryilgaVMZlaoKOtYkk6Q/IgwR5
         Yo9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793987929; x=1794592729;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KoOh0KgSmAnOjKaKpi/0YYF58G7PTa1KHqz+Z6PRDOg=;
        b=tRBODSzeVONNC26gSrL98if6KfyDLDTrj6rwYs7Vp/IfdjIjIUC9oZPGTC1u046k+w
         KFV9JIRg5sy4+wuwbQNnae/zJkUxj0Fy4WbUMBdEdiQUhj0n02NvBpR2HF0OBuWFfydd
         SOMDE+JOAmoDVNtHOH/yJ6luVlxvo0Tncvo0k1D00LOrnG+Kv/UZHGmM9306tuhKc3oz
         BG2lt5k2ZCgnlI4U9fWhK/MlSynl4U4oRqwANgydFVuNC06E2E4d3L8bda01fUAK7iFn
         MPMyVIYpkdzhyBh+udf9LA1T1sSB8h4mKP5Iy2bb+Lw7IAS6NmJsH09Lu49UT41HCPCT
         x2Kg==
X-Forwarded-Encrypted: i=1; AKwUvBwRi7znRgR+ay05uAqpfwYn0AFxbczUTVuEcX6fn25GD33pPnj+ZFqvo+0nJ1ZaC6rN1Ehhwg==@lists.linux.dev
X-Gm-Message-State: APuU4Z+OEHvnLL6kgw7dXM0aoEe2atqt/ZbuVIE22tjhnBS1ouiZ9nyJ
	F71RBW/hHFg/h151EMkBx2aRnupwJaiUPo6W0o3BAMIuDNI5T66Q3To2fjIKqh9ywZk=
X-Gm-Gg: AYBFou13l9CLHue8JLd1KQbg9RWe5bt4sZjN6ViWkQ3Ls6WkrsQsexYI0eukKynVpnW
	w7gay9v75eJLf5wi7QSVQiEksN7M3JF02Ti8xNuWatZf8saOI9iZkvDdUIdO7XdHNHG7fwu2/jT
	1w4vxU5Rj/ctsWoAkMc1PDahfd+Cby5sgqrN9pFFVnWSVKUQwHH1sndiIZRm/G95Ia9ODv8cdsW
	GJtnD3hYk8C+Rhnw4mi4dTNn28SMi5F3W3nyEpz6I3kOq19l/wibLpX6s6MuIK7stqA0x5moSpa
	ZhnGBOBnlbKY4Nh3Z4QEGKBl1lCjPGD5vjTTka2gfa4nbPEw1Fo7XZ5GInn2Jscx3x3KfrpfvSh
	DFZL7rhVaknrqQCX9BgH1YGGF/P80HcjHPeIXoGJwf8CQQAJMThdhZenVzQJxWd25jg7TzwhX3Q
	jDf4DvWtEOaANOxCFuPBQvq4YfCncv0HMNVkVA5+D1rRRvqTb2tcfeAqenKPxUVHynF2p3DpVE7
	0u/B/CPlIl+0eFzgVYCx6/4QEBDKqbXYCKC9ktOV/1eO3OY8B6PheYptrj4cXO6vaHySASzpLSZ
	iAD4HPzHlM0Jl6eSKjGLqxola5mYe31L0ngJW+r8j6zy
X-Received: by 2002:ac8:5d08:0:b0:536:699d:9a22 with SMTP id d75a77b69052e-54e157646f3mr53331201cf.57.1793987929323;
        Fri, 06 Nov 2026 09:58:49 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.254])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54e27013e83sm25509581cf.24.2026.11.06.09.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 09:58:48 -0800 (PST)
Date: Fri, 6 Nov 2026 17:58:36 +0000
From: Josef Bacik <josef@toxicpanda.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
	Gregory Price <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Alistair Popple <apopple@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Song Liu <songliubraving@fb.com>, 
	Rik van Riel <riel@surriel.com>, Hugh Dickins <hughd@google.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Kevin Tian <kevin.tian@intel.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Steve Sistare <steven.sistare@oracle.com>, 
	John Hubbard <jhubbard@nvidia.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, iommu@lists.linux.dev, 
	stable@vger.kernel.org
Subject: Re: [PATCH 2/5] mm: limit pagecache folio refcount when splicing
 into pipes
Message-ID: <n3l2cnx6d25jovloqyoxiz566mh62janclmiewjvumtmqfezo7@zmsmco5vvssn>
References: <20261105-refcount_overflow_stable-v1-0-70b9c655da3e@kernel.org>
 <20261105-refcount_overflow_stable-v1-2-70b9c655da3e@kernel.org>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105-refcount_overflow_stable-v1-2-70b9c655da3e@kernel.org>

On Thu, Nov 05, 2026 at 02:10:11PM +0100, David Hildenbrand (Arm) wrote:
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
> ---
>  include/linux/mm.h | 9 ++++++---
>  mm/filemap.c       | 4 ++++
>  mm/shmem.c         | 4 ++++
>  3 files changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 79ae8fc0d6bb4..a82cfbce18215 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2287,10 +2287,13 @@ static inline void get_page(struct page *page)
>  
>  static inline __must_check bool try_get_page(struct page *page)
>  {
> -	page = compound_head(page);
> -	if (WARN_ON_ONCE(page_ref_count(page) <= 0))
> +	struct folio *folio = page_folio(page);
> +
> +	if (WARN_ON_ONCE(folio_ref_count(folio) <= 0))

Since you're here anyway can you change this to something other than
WARN_ON_ONCE, since that results in an OOPS with panic_on_warn set?
Thanks,

Josef
