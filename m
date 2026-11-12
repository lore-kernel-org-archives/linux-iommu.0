Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794492369;
	b=rT9oqFo9745IrowXgbY4f7NqPFDUlsosXxlq0EpiIPlNqTFjBwQQxqfHA1veKF+M9g/o
	 xivNQyp+S4PTR54Fw/ARBVlKk9tKq5UxmBFA/BMYj5fNV4WC5GIR9PcsZK66gDHbgtiHM
	 fO52p+FKiLl2VATz/IAILg/Ok26wWGSuOZD+d2XQKE1VrQ/ZIShKLlVwGkKEbWBeA5sKx
	 Ro0iIc4fy1LP+fV5JaULPsKa5HPN4dGu0EGa3RevdGvVfvtJytinh4YGhCJrXmiiTVtWn
	 2gSCxe9Y7oKYbXPAj3NWUAwNHN193d5v9VjwHdRgaxHR+oepao8PG9FZbZ834Tv7POQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794492369;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Spam-Flag:X-Spam-Level:X-Spamd-Result:X-Spam-Score;
	bh=d26nC76YLz1Hx0CSfgosaWHEU4xoea2lRNFaxDZwsTA=;
	b=q9uJDqe8ZkysfhA92PCBvXvo5F4hdL0V2KgPYib36TBgZfL4sjku0VHmBExHSp3KMsiL
	 Q1Dqk5r5E/T8Bwg54qDDScJouT78GwXwOwkHpJALmJgrNcdXQozP4XYw/2Yptx/57Jh8Y
	 vp2d7EkuT8sCl46m//G/dtee90wczEEfgW++0cU6gGUUqtYdzJdcrRNzJZ14j4SXVMaGA
	 LDUSVgmiE+pGXGKjcXP7hDzZdSPOJ1M2CXB7vWM6nCiqgsWndEYhwCAt6JYj9VTt6NJkn
	 NzfATAOiUKIKDnSXBd3ibfq2LQUYGPvJkmR8ilFBs3d4WLk1td/cVAi4GHrxs58srcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=MePUV0PJ;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=tYPab8lG;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=MePUV0PJ;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=tYPab8lG;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DDD606C4BF;
	Thu, 12 Nov 2026 14:06:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70DDD606C4BF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=MePUV0PJ;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=tYPab8lG;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=MePUV0PJ;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=tYPab8lG
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4F54321E32;
	Thu, 12 Nov 2026 14:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794492366; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d26nC76YLz1Hx0CSfgosaWHEU4xoea2lRNFaxDZwsTA=;
	b=MePUV0PJPVg6e87V3rI/oBHU/WVNpeN9fAmgxCGLxENx35oKrb0iEmR3T18rtLtVz1Vf+O
	1G6UmmBLJXvaA1WYhfqBFsQOBOJ7IA2iBvpEpvVmXn/Cmsa4Thr80o0Lq+TtDYhKs5Kyab
	qpmF+O8fmKXKFCYmnkRlnrBsSmTsSBg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794492366;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d26nC76YLz1Hx0CSfgosaWHEU4xoea2lRNFaxDZwsTA=;
	b=tYPab8lGc7bR6d9kEE9FN38yDhbA+TLnfbS8qBFT3Rs/vxGIU/l099dpGQkmH3U6mcvPbG
	SX8CzvRsGMGv8qBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794492366; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d26nC76YLz1Hx0CSfgosaWHEU4xoea2lRNFaxDZwsTA=;
	b=MePUV0PJPVg6e87V3rI/oBHU/WVNpeN9fAmgxCGLxENx35oKrb0iEmR3T18rtLtVz1Vf+O
	1G6UmmBLJXvaA1WYhfqBFsQOBOJ7IA2iBvpEpvVmXn/Cmsa4Thr80o0Lq+TtDYhKs5Kyab
	qpmF+O8fmKXKFCYmnkRlnrBsSmTsSBg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794492366;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d26nC76YLz1Hx0CSfgosaWHEU4xoea2lRNFaxDZwsTA=;
	b=tYPab8lGc7bR6d9kEE9FN38yDhbA+TLnfbS8qBFT3Rs/vxGIU/l099dpGQkmH3U6mcvPbG
	SX8CzvRsGMGv8qBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8DBA813432;
	Thu, 12 Nov 2026 14:06:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RScNEcrH9WqvKgAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Thu, 12 Nov 2026 14:06:02 +0000
Date: Thu, 12 Nov 2026 14:06:00 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, 
	Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
	Matthew Brost <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Peter Xu <peterx@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Song Liu <songliubraving@fb.com>, Rik van Riel <riel@surriel.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Hugh Dickins <hughd@google.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Kevin Tian <kevin.tian@intel.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Steve Sistare <steven.sistare@oracle.com>, 
	John Hubbard <jhubbard@nvidia.com>, "Jose A. Perez de Azpillaga" <azpijr@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev, linux-arch@vger.kernel.org, 
	iommu@lists.linux.dev, netdev@vger.kernel.org, Chris Mason <mason@kernel.org>, 
	stable@vger.kernel.org
Subject: Re: [PATCH v3 1/9] mm: limit pagecache folio refcount when mapping
 pages
Message-ID: <avXGtysfRk3uQpNu@pedro-suse.tail5790ac.ts.net>
References: <20261110-refcount_overflow_stable-v3-0-318625d63a98@kernel.org>
 <20261110-refcount_overflow_stable-v3-1-318625d63a98@kernel.org>
 <avW0HGjF6wuqn12T@pedro-suse.tail5790ac.ts.net>
 <86206f64-fefa-4a13-95bc-eddf756eecc8@kernel.org>
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
In-Reply-To: <86206f64-fefa-4a13-95bc-eddf756eecc8@kernel.org>
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-11.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,infradead.org,google.com,suse.com,suse.cz,linux-foundation.org,nvidia.com,linux.alibaba.com,linux.dev,arm.com,intel.com,gmail.com,sk.com,gourry.net,redhat.com,cmpxchg.org,fb.com,surriel.com,szeredi.hu,zeniv.linux.org.uk,arndb.de,ziepe.ca,8bytes.org,oracle.com,toxicpanda.com,davemloft.net,kvack.org,vger.kernel.org,lists.linux.dev];
	R_RATELIMIT(0.00)[to_ip_from(RLru1qh6mb4sjaccpm4fphkxao)];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_GT_50(0.00)[63];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Score: -11.80

On Thu, Nov 12, 2026 at 02:16:33PM +0100, David Hildenbrand (Arm) wrote:
> > Mostly LGTM, with some comments:
> > 
> > Reviewed-by: Pedro Falcato <pfalcato@suse.de>
> 
> Thanks for the review, Pedro!
> 
> > 
> >> ---
> >>  include/linux/mm.h | 35 +++++++++++++++++++++++++++++++----
> >>  mm/filemap.c       |  6 ++++++
> >>  mm/huge_memory.c   | 29 +++++++++++++++++++++++++++--
> >>  mm/memory.c        | 33 +++++++++++++++++++++++++++++----
> >>  mm/migrate.c       | 11 +++++++++++
> >>  mm/userfaultfd.c   |  4 ++++
> >>  mm/util.c          | 18 ++++++++++++++++++
> >>  7 files changed, 126 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> >> index 4608540e40d46..439cfe446cea4 100644
> >> --- a/mm/huge_memory.c
> >> +++ b/mm/huge_memory.c
> >> @@ -1626,6 +1626,7 @@ static vm_fault_t insert_pmd(struct vm_area_struct *vma, unsigned long addr,
> >>  {
> >>  	struct mm_struct *mm = vma->vm_mm;
> >>  	pgtable_t pgtable = NULL;
> >> +	vm_fault_t ret = VM_FAULT_NOPAGE;
> >>  	spinlock_t *ptl;
> >>  	pmd_t entry;
> >>  
> >> @@ -1662,6 +1663,10 @@ static vm_fault_t insert_pmd(struct vm_area_struct *vma, unsigned long addr,
> >>  		if (is_huge_zero_folio(fop.folio)) {
> >>  			entry = pmd_mkspecial(entry);
> >>  		} else {
> >> +			if (unlikely(folio_ref_count_over_limit(fop.folio))) {
> >> +				ret = VM_FAULT_SIGBUS;
> >> +				goto out_unlock;
> >> +			}
> >>  			folio_get(fop.folio);
> > 
> > I see you use this pattern often. Would it make sense to have a
> > bool folio_get_unless_overflow()?
> 
> I commented somewhere (in v2 I think) that I played with using
> folio_get_checked() from #2, but didn't quite like it so I discarded it as
> 
> (a) it cannot be used everywhere here, as I'd need more functions to add
> multiple references. next_uptodate_folio() also could use it as I would need yet
> another temporary helper for a try_get().
> 
> (b) these changes here are going to get reverted fairly soon once I change the
> way how mappings are refcounted (which is, unfortunately, not suitable for
> stable, otherwise I wouldn't be throwing in this temporary change in the first
> place)
> 
> So everything that is expected to stay in later patches uses the proper helper.

Alright.

> 
> [...]
> 
> >>  
> >> +		if (unlikely(folio_ref_count_over_limit(folio))) {
> >> +			/* Skip this PUD; it can be faulted in later. */
> >> +			ret = (dst_vma->vm_flags & VM_MIXEDMAP) ? -ENOMEM : 0;
> > 
> > A comment as to what's going on here with VM_MIXEDMAP would be useful. I guess
> > the idea is that faulting on a mixedmap later will not necessarily hand you the
> > exact same page fault result?
> 
> I can throw in a comment, yes.
> 
> [...]
> 
> >> +bool __folio_ref_count_over_limit(unsigned int ref_count)
> >> +{
> >> +	if (ref_count >= FOLIO_REF_COUNT_ADMIN_LIMIT)
> >> +		return true;
> >> +	/* Background threads must not consume admin reserves. */
> >> +	if (current->flags & PF_KTHREAD)
> >> +		return true;
> >> +	/* Neither must interrupt contexts on behalf of the interrupted task. */
> >> +	if (!in_task())
> >> +		return true;
> >> +	/* Capability checks are not safe with IRQs disabled. */
> >> +	if (irqs_disabled())
> >> +		return true;
> >> +	/* Use the task's credentials, which filesystem overrides cannot change. */
> >> +	return !has_capability_noaudit(current, CAP_SYS_RESOURCE);
> >> +}
> > 
> > In case this function ever returns over limit, we probably want to log this
> > in the kernel log. If this function gets the folio you could even print
> > the problematic file offset/inode/filesystem/etc. Ratelimited of course.
> 
> You mean, if this function returns "true", right? Is printing always fine?
> (e.g., irqs disabled?)

Yes. As far as I know, it's always fine, even under NMI. But definitely fine
with IRQs disabled.

> 
> > 
> >> +EXPORT_SYMBOL_GPL(__folio_ref_count_over_limit);
> > 
> > I'm fairly sure this will break the build for a number of non-GPL drivers
> > when calling folio_get() with CONFIG_DEBUG_VM=y.
> 
> You mean, breaking OOT drivers, right? I can switch to EXPORT_SYMBOL if that's a
> concern.

I had the impression we had some stuff in-tree that isn't marked as GPL. But a quick
grep shows that everything is either GPL or dual-licensed.

In any case, yes, this will quite possibly break debug builds for people OOT.
I think folio_get() might be a bit too ubiquitous to do this to.

-- 
Pedro
