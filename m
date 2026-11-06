Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793956312;
	b=kXyCml0khbR1hFdT1PzO9b+Fpm/p2LNZGAyrCBM/C9JRnkJaaZYkBD0rbu7cKV2tH+QT
	 LcWIvcf4BU/Nuhd4c0KExp8Z6uIU1nycTLkrlRPJnfSYrEEOuxmkyuo4U+fKcc7PXVlWf
	 ZJ33RL6HIb9A3QQcoPjWkNQal+JNKMWdnDOPeyNnr1d5IWtfqffLWZBWx4bjhPONATe7r
	 Bd49IMZpOkr4TnzRcwP1spLv0XUEB5S/GBxCH5n/nEzz1g+DPqz955QK2M1xrfcVrr+51
	 BQ7VRuGRtGvpms/p/bTrUfkHHO+Odl1KPzyr2anAQGk4NTv6DUMXVa/qS0Hm3vXQ2Ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793956312;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=AKi4F1XkSqKNw3b7+Ng4uXx+ZMXFkYDoN/Pwc1tdXyw=;
	b=3tHcK/pqrxtRZ/747kqP0LWz2LEOj5Cdr1jGzIeY9j1AKuqHqgjgaZaldIsrp+wHUAwQ
	 79kWWo6awZhMU8tEeHdzCEOpDM2xynd64SyIt+F0dh8ElAI7GQifXrBfmSm7Ilpa3a0Ra
	 qz8ZuEjT/yGwVPRR1vnvXZ+zZQNCXVvL89zzGo1J2hyKDyLqlU/Ctlv3X89gFkwWN9/gy
	 uYmZbUgW6sQdRFvbJ+GYjX+PzbG/cUhEb/gsrK5wp/qfytNKuWkUgfIvKt66EHYpvEeQM
	 yz7kLEyItnf5QROs0stl3vBcXpXyelh/Skzscrfa2m0u2uxKggKzG7nrwBP8XAQ3ohQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=SP14kqgH;
	arc=none smtp.remote-ip=95.215.58.17
Received: from mta1.migadu.com (out-17.mta1.migadu.com [95.215.58.17])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AC2606A331
	for <iommu@lists.linux.dev>; Fri,  6 Nov 2026 09:11:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0AC2606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=SP14kqgH
X-Envelope-To: iommu@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=RB9jCfeGXFtAeNZRCJe7qF1HA2DzPZCiRtQ6f8rlwO8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793956308; v=1; x=1794561108;
 b=SP14kqgHZegobLguKceMWVRaaEf3xj0wYia2VHIJv7nrvC8v/x1oCpRu272qEx3kMDDC6SEE
 DlL0PmcvKPbKwAj+xL2YncyuVQl1aPxY6vKPhNcd0sk3NnzrIjyjhtFA8ayH6u8Qep1tmr357io
 IqEHRdCNdAzL3+8AVKpJKnLM=
X-Envelope-To: iommu@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id a5d8b693a372ae24;
	Fri, 06 Nov 2026 09:11:48 +0000
X-Mizu-Trace-ID: a5d8b693a372ae24
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: david@kernel.org
Cc: akpm@linux-foundation.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	willy@infradead.org,
	jack@suse.cz,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	nico.pache@linux.dev,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev,
	usama.arif@linux.dev,
	kas@kernel.org,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	peterx@redhat.com,
	hannes@cmpxchg.org,
	songliubraving@fb.com,
	riel@surriel.com,
	hughd@google.com,
	will@kernel.org,
	aneesh.kumar@kernel.org,
	npiggin@gmail.com,
	peterz@infradead.org,
	jgg@ziepe.ca,
	kevin.tian@intel.com,
	joro@8bytes.org,
	robin.murphy@arm.com,
	steven.sistare@oracle.com,
	jhubbard@nvidia.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	iommu@lists.linux.dev,
	mason@kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/5] mm: limit pagecache folio refcount when mapping pages
Date: Fri,  6 Nov 2026 17:11:39 +0800
Message-ID: <20261106091139.67845-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261105-refcount_overflow_stable-v1-1-70b9c655da3e@kernel.org>
References: <20261105-refcount_overflow_stable-v1-1-70b9c655da3e@kernel.org>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On Thu, Nov 05, 2026 at 02:10:10PM +0100, David Hildenbrand (Arm) wrote:
>With large file folios, overflowing the folio mapcount and refcount
>became possible. For anon folios it is currently not really an issue:
>each large anon folio can only be mapped once into a process.
>
>That's not really big news, but it's about time that we do something
>about it because some modern technology might find ways to abuse it :)
>
>One of the enablers for that was commit ddc58f27f9ee ("mm: drop tail page
>refcounting"), however, file thp support was added later.
>
>File folios can be mapped multiple times into the same process, allowing
>for processes to hold many references to the same folio.
>
>As a short-term solution, let's introduce two folio refcount limits:
>one for ordinary consumers and one for admins. Leave some headroom
>before the refcount goes negative, which we really don't want (having
>the mapcount go negative is also not expected).
>
>Start reporting SIGBUS if we run into limits. When restoring mappings
>from migration entries, instead zap the pte/pmd entry. We allow for
>slightly exceeding the limit to keep things simpler.
>
>This is far from ideal, but better than all easy alternatives we can
>backport comfortably. For now it fixes the big problem: letting
>the refcount (+mapcount) go negative and cause trouble.
>
>This is only a temporary fix, we'll follow up with something better.
>
>While the refcount checks are not required for order 0 folios, let's
>just add them for consistency: each folio_add_file_rmap*() and
>folio_dup_file_rmap*() needs a prior check.
>
>Also, just document -EHWPOISON for copy_present_ptes() while at it.
>
>Reported-by: Chris Mason <mason@kernel.org>
>Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
>Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
>Fixes: 793917d997df ("mm/readahead: Add large folio readahead")
>Cc: stable@vger.kernel.org
>Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>---
> include/linux/mm.h | 33 +++++++++++++++++++++++++++++++++
> mm/filemap.c       |  6 ++++++
> mm/huge_memory.c   | 24 ++++++++++++++++++++++--
> mm/memory.c        | 23 ++++++++++++++++++++---
> mm/migrate.c       | 11 +++++++++++
> mm/userfaultfd.c   |  4 ++++
> 6 files changed, 96 insertions(+), 5 deletions(-)

Nice work! I just went through all folio_add_file_rmap*() and
folio_dup_file_rmap*() callers, including callers of set_pte_range().

All covered, looks good to me1

Reviewed-by: Lance Yang <lance.yang@linux.dev>
