Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793997794;
	b=TsBc2/l8NG/UWr2HslD5IEX/94EVkFDIoyJ4XAy12a/KJr3tDNVCDuV3cnjgAJjsuIEg
	 x3rSAGuWyK0NCGIA1SzGnw42zYey6y5xlkdlIrKMQX4B5hHOhBqpZ/a1zu8CrqzdZWrc0
	 vaRXfkqzGxR/4kpF2Q0nXbxYcrCPzzSH0aUm3WqXWyMiycOcgtjTYPzCZTJulKNNCAeZ+
	 EvJJZIjiFBm+cHe1S3TC2uDmuW8WPrk3wLrEZpMzuW2iCHVMWxZ7IeIaU7z2ds2UDhfp8
	 /jhtkVQbh320YV43Ub2Uabl1kGiH1jY5ymg+S+SxzqkS8c43Fo0LoX+0DBx4PFLXnQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793997794;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=ws2V6VbViJ6cnrlfEDvDEs6KCs0YOuB35XjyLfjvYOA=;
	b=2QpvixK4fnIxQFmAT5ZAWXHrm+h6+yMU+kazBVsepuH9EhRkvhfdsGqdrsG6GifNl0pS
	 WeqwZlQiH4zmYGGecJvE1Ss3QeOUiAlnkGOntaYyHCLxXjByBAdkJaQlWtqulUv7EDzEw
	 uZaxhvKY3EsiAfZJFJBUNnaNk4RZ1JTc8wBloV4wZ1dY3go/p+OWwQ2t7ouWePE6fWwYh
	 Xvs5siTeQPhMDpykBHrsDt5CSicU0r+CdZJRqg7DGsJVc7W0ztBG6TFS4ENqYRbJYWX7J
	 adCK3LkLejQYdeLKli3TQ+r2HIBj6E2VVW+xp1z4s+02HVTNsoZPvHXORLl4XbmAfZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=DhEyOYAU;
	arc=none smtp.remote-ip=209.85.219.51
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CF1606A32D
	for <iommu@lists.linux.dev>; Fri,  6 Nov 2026 20:43:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93CF1606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=DhEyOYAU
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-91e98301805so11386626d6.1
        for <iommu@lists.linux.dev>; Fri, 06 Nov 2026 12:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793997792; x=1794602592; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ws2V6VbViJ6cnrlfEDvDEs6KCs0YOuB35XjyLfjvYOA=;
        b=DhEyOYAU1kJJ13dcrQJHTzNmsvcdjMIu+X36CiJSNwC+0Km3powtdqto3rbwhsZfNp
         hhsq+UF/pUuf5vt/176hrn9b69Gp7247sA8J/Bc7AWLHk+PUqcY81krRJxK38k7KKpnD
         gX9IIP0nbaI/fsBuTvDUotdlnmBbPpFk6dpydDtOPtReSGU3cICsBfI4zq3oIMLPcNQ5
         aM6oHh65IwXqPlTjPQoRxJpSsPKcwxE7PC1kOVf+47n/T6ZxNwLP4i96z+97Ih9Sj3kC
         n66/PR3Fy52w2ln2l0gLTJ+I4MbZaV3aJ8fK3uBIQ3izLMwjyLEg0eb5nxyfF21px5eQ
         fk1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793997792; x=1794602592;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ws2V6VbViJ6cnrlfEDvDEs6KCs0YOuB35XjyLfjvYOA=;
        b=I8Rvy5/ES/a0juUcLmE5lcdq+3RNWS45tpoSgOIr+axwAZMyISBQ7IhQc72Prmx1P1
         WUaEvgwlpGJk2wopPX9bydrHkUPo/1PnwRlgiPsBRt+qro351rF8aHQLP/mv/q7f+cVt
         6ZXzOy2oRwhl1w23enG6zOc3ew4igTMgnmUzBsqve1TT3uCRjWkca8BifMDzw8R+qp2N
         8ySj/7I+STKKsKi/a4U8x74DCNEUGvHfxw+D7ijAWxOGnZwNovzjTxfCz2rqHtNl+vXQ
         V8WOVnYyIYr+G8SNrIvnYUPIgWQ1jt7D3/cu0aaDBlb6duu+lZNkWFNS5b6LmCmWzisC
         7Zsg==
X-Forwarded-Encrypted: i=1; AL+hErF5dqMPWRg7vCgoNZdvtAWjnGrWq1szUre7b9p8TtuN5qzTgitknun/hbLImBu9aYBExuuxuA==@lists.linux.dev
X-Gm-Message-State: APuU4Z9JvJchFulQRyb+OiYP/ErjmCeWm81MBjAOW8+DkgRPHpCpcknE
	wO0MJS4TrcPI3d7RWKC58aJZbSYZ2wq3tefPf8xxDTU4XVYMSFb2FZnLVgMQ9X0Uswk=
X-Gm-Gg: AYBFou1mhv/mfRb6/dn8eAVIoRP0XqWvL3rLwEQnwYWwwe0Q9US00qyKQpGPOCdSXYH
	mxS5QtL8LzRm9p/S4dme4KGgDFpF7mm7SovHsEwDOWxxe/44yF/mtc29iC5S4z11/TFrRvtmTAP
	xvwYu3Nes0fxUPqcaIbHXQPFLzseQ0ydNWYgxsMpBOFXFgQpE/XilOC5lRIiOFbtkksqsMzeNdA
	YP8pLEY/bZaCIGkwyuCYg/9BErtVnCvXojMH6F7Zwj5riTlpCTrbVVOnvpnv7snnIWRQVZ2h2/z
	TVp2+qWQDfQtW775qHW38F8jIrmtk6RO458UeRD7PuWrCvvb1huUmuzgPae2VHw0fOkj09lIaAx
	HbtGbdB/DYjYFu11nTEuzUG/9q3+jMl09oVo3RTtaw7Dm2uLVDtuIboMnKWs8anelBOSD32Vg1R
	X7zqyPtzTebUqIGuUqahNxgpMG1njbxh4lCMCLsrO56bIsGtSuLaottbxvWAEM4KJMmSsXg7Ufw
	cwakB7KVDmUice5svaQv0FF0RK0T0PLhVoh4o1lE78m94w8kswoM6SLmgzl/pITeWeJkEUBX1Zp
	jQw7mO3GKCOzpej617Ny2IXMmOs2H9WN6SihmvMa7LNiUZy0nchbwdO/G5DhvOMLhZaA0P4N4FW
	qU6q3dzVDDQ==
X-Received: by 2002:ad4:4ee5:0:b0:91e:a5c2:37f7 with SMTP id 6a1803df08f44-91ea97a22b7mr53003846d6.42.1793997792129;
        Fri, 06 Nov 2026 12:43:12 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ea6a2c742sm29232026d6.11.2026.11.06.12.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 12:43:11 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xPQmE-00000007ent-3ktJ;
	Fri, 06 Nov 2026 16:43:10 -0400
Date: Fri, 6 Nov 2026 16:43:10 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <nico.pache@linux.dev>,
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>, Peter Xu <peterx@redhat.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Song Liu <songliubraving@fb.com>, Rik van Riel <riel@surriel.com>,
	Hugh Dickins <hughd@google.com>, Will Deacon <will@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Nick Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Kevin Tian <kevin.tian@intel.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Steve Sistare <steven.sistare@oracle.com>,
	John Hubbard <jhubbard@nvidia.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org, iommu@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/5] mm: limit pagecache folio refcount when splicing
 into pipes
Message-ID: <20261106204310.GK663069@ziepe.ca>
References: <20261105-refcount_overflow_stable-v1-0-70b9c655da3e@kernel.org>
 <20261105-refcount_overflow_stable-v1-2-70b9c655da3e@kernel.org>
 <n3l2cnx6d25jovloqyoxiz566mh62janclmiewjvumtmqfezo7@zmsmco5vvssn>
 <23f947e2-ff06-426d-adb7-396871304736@kernel.org>
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
In-Reply-To: <23f947e2-ff06-426d-adb7-396871304736@kernel.org>

On Fri, Nov 06, 2026 at 09:09:10PM +0100, David Hildenbrand (Arm) wrote:
> On 11/6/26 18:58, Josef Bacik wrote:
> > On Thu, Nov 05, 2026 at 02:10:11PM +0100, David Hildenbrand (Arm) wrote:
> >> Similar to mapping pagecache folios into page tables, let's reject splicing
> >> folios into a pipe if the refcount is at it's limit, similar to how we
> >> handle it during GUP.
> >>
> >> This will prevent more cases of possible folio refcount overflows with
> >> large pagecache folios.
> >>
> >> Let's keep it simple and check in the two callers of
> >> splice_folio_into_pipe().
> >>
> >> Also check in try_get_page() to cover pipe-buffer duplication by tee()
> >> and partial pipe-to-pipe splicing.
> >>
> >> Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
> >> Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
> >> Fixes: 793917d997df ("mm/readahead: Add large folio readahead")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> >> ---
> >>  include/linux/mm.h | 9 ++++++---
> >>  mm/filemap.c       | 4 ++++
> >>  mm/shmem.c         | 4 ++++
> >>  3 files changed, 14 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/include/linux/mm.h b/include/linux/mm.h
> >> index 79ae8fc0d6bb4..a82cfbce18215 100644
> >> --- a/include/linux/mm.h
> >> +++ b/include/linux/mm.h
> >> @@ -2287,10 +2287,13 @@ static inline void get_page(struct page *page)
> >>  
> >>  static inline __must_check bool try_get_page(struct page *page)
> >>  {
> >> -	page = compound_head(page);
> >> -	if (WARN_ON_ONCE(page_ref_count(page) <= 0))
> >> +	struct folio *folio = page_folio(page);
> >> +
> >> +	if (WARN_ON_ONCE(folio_ref_count(folio) <= 0))
> > 
> > Since you're here anyway can you change this to something other than
> > WARN_ON_ONCE, since that results in an OOPS with panic_on_warn set?
> > Thanks,
> 
> If it actually turns negative (or 0) with out changes, we had an overflow and
> for sure want to know about it :)

Yeah, didn't you get Docs merged to clarify WARN_ON is fine if
userspace can't trigger it?

If you use panic_on_warn you *WANT* your system to stop if it detects
corruption, that's the whole point. Removing corruption detection so
panic doesn't trigger is pure 100% nonsense.

This keeps coming up and it's frustrating to go over again and again.

Jason
