Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794493591;
	b=Wxh+ynd/7LNmnyTXBc4JbAahKMI1FXUxVwi/fExG1oLlnqTg9/49DZb2RHZCL6iUIStE
	 ABLymmPaqc+P6Qyi6ORLxnevmUQtjkCPeHo1YAmgg3JEPN6GGjmuDwjSdROec9j7+DzxJ
	 8dm6F64jDevjsTfy232lDW4siKVfkRJ/YrZX5eMi6Zs11VoKjH2ISADg3hl3qMIjoKRl6
	 6or7UJeMDFqihy+ZhFRpCW29RWw9dYiTWOWU2ZFNBe2kT2PdIMBRWGwD4/C+YsqXXKfY0
	 q/gEIPem6FQSTaoB0X8W2RUhtbD3ul9W8NJizqdzB/1xOL8w9XX7Oey9zFFOpLK14zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493591;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Rspamd-Queue-Id:X-Spam-Level:X-Rspamd-Server:X-Rspamd-Action:
	 X-Spam-Flag:X-Spamd-Result:X-Spam-Score;
	bh=jHr4RUKl7RY4PSbdL2GT5NxxihQwmpjqwvgP01/M+Ac=;
	b=PraiLGsJLvOP6VCcKYgI603wqzqNXeOHMocT5BqUX5ih/HypJtthwUchnf08m/Ei8I+X
	 fxZ6pO4w+I41QZUflVkl3wjVkQN2abw5VdaFVtN1QRELYvsqQUQnbATGlVANQvloYaTE5
	 g34jxo2TlkdauZePJ6ljqbLgB3JOSVRY5+jWFtf9Z2tCXKAPkeTZWAglZ7Fs9ZY8mldXc
	 /0oEzOMOW3CQwz3D/csXKVM/9qWHJSbb2pbIOvyr+JtrSRhk1DjlkJJSoXmiBhXMRc29B
	 JASsLAioztjXUh9fcY7n2IyAZV3glx+Tg+K/Ntxz42ukP9jJCp7rTJsu1D3CzNDQmYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=kYW8zoDp;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=tjn0V528;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=kYW8zoDp;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=tjn0V528;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046E6606B2CA;
	Thu, 12 Nov 2026 14:26:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 046E6606B2CA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=kYW8zoDp;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=tjn0V528;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=kYW8zoDp;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=tjn0V528
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2DCCE21C53;
	Thu, 12 Nov 2026 14:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794493589; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jHr4RUKl7RY4PSbdL2GT5NxxihQwmpjqwvgP01/M+Ac=;
	b=kYW8zoDpxMShaXbNnc9eapJegGiIybzvqwjxCqnm+R2TdEAh36ASZwVv4xO/eJIdXj+9cM
	9D4IrfT0kvDW90Cves9fCI1ZQjOgverbkC1h8JjL9l8PFxNUq73b7D91YAkzOkysn1ZGw2
	CWXeWI690YBd0qRlSnh9jtU+06mmwdI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794493589;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jHr4RUKl7RY4PSbdL2GT5NxxihQwmpjqwvgP01/M+Ac=;
	b=tjn0V528px+d3pLuk5LH3w+4rInyUgou34GTzbKL3K6IA6KH4ammsRhKZEOQcJQ/txfapm
	aavvgsfYqamIknCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=kYW8zoDp;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=tjn0V528
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794493589; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jHr4RUKl7RY4PSbdL2GT5NxxihQwmpjqwvgP01/M+Ac=;
	b=kYW8zoDpxMShaXbNnc9eapJegGiIybzvqwjxCqnm+R2TdEAh36ASZwVv4xO/eJIdXj+9cM
	9D4IrfT0kvDW90Cves9fCI1ZQjOgverbkC1h8JjL9l8PFxNUq73b7D91YAkzOkysn1ZGw2
	CWXeWI690YBd0qRlSnh9jtU+06mmwdI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794493589;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jHr4RUKl7RY4PSbdL2GT5NxxihQwmpjqwvgP01/M+Ac=;
	b=tjn0V528px+d3pLuk5LH3w+4rInyUgou34GTzbKL3K6IA6KH4ammsRhKZEOQcJQ/txfapm
	aavvgsfYqamIknCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6A81013432;
	Thu, 12 Nov 2026 14:26:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OIFuDpHM9WrmPwAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Thu, 12 Nov 2026 14:26:25 +0000
Date: Thu, 12 Nov 2026 14:26:23 +0000
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
Message-ID: <avXMKH__gwi6BwVy@pedro-suse.tail5790ac.ts.net>
References: <20261110-refcount_overflow_stable-v3-0-318625d63a98@kernel.org>
 <20261110-refcount_overflow_stable-v3-1-318625d63a98@kernel.org>
 <avW0HGjF6wuqn12T@pedro-suse.tail5790ac.ts.net>
 <86206f64-fefa-4a13-95bc-eddf756eecc8@kernel.org>
 <avXGtysfRk3uQpNu@pedro-suse.tail5790ac.ts.net>
 <2f9b90fd-fe50-4afa-ab59-0c4a00e5e276@kernel.org>
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
In-Reply-To: <2f9b90fd-fe50-4afa-ab59-0c4a00e5e276@kernel.org>
X-Rspamd-Queue-Id: 2DCCE21C53
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-12.01 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,infradead.org,google.com,suse.com,suse.cz,linux-foundation.org,nvidia.com,linux.alibaba.com,linux.dev,arm.com,intel.com,gmail.com,sk.com,gourry.net,redhat.com,cmpxchg.org,fb.com,surriel.com,szeredi.hu,zeniv.linux.org.uk,arndb.de,ziepe.ca,8bytes.org,oracle.com,toxicpanda.com,davemloft.net,kvack.org,vger.kernel.org,lists.linux.dev];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RL3qe7do4s7ra64g8gjdgiaorz)];
	RCPT_COUNT_GT_50(0.00)[63];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -12.01

On Thu, Nov 12, 2026 at 03:16:00PM +0100, David Hildenbrand (Arm) wrote:
> On 11/12/26 15:06, Pedro Falcato wrote:
> > On Thu, Nov 12, 2026 at 02:16:33PM +0100, David Hildenbrand (Arm) wrote:
> >>> Mostly LGTM, with some comments:
> >>>
> >>> Reviewed-by: Pedro Falcato <pfalcato@suse.de>
> >>
> >> Thanks for the review, Pedro!
> >>
> >>>
> >>>
> >>> I see you use this pattern often. Would it make sense to have a
> >>> bool folio_get_unless_overflow()?
> >>
> >> I commented somewhere (in v2 I think) that I played with using
> >> folio_get_checked() from #2, but didn't quite like it so I discarded it as
> >>
> >> (a) it cannot be used everywhere here, as I'd need more functions to add
> >> multiple references. next_uptodate_folio() also could use it as I would need yet
> >> another temporary helper for a try_get().
> >>
> >> (b) these changes here are going to get reverted fairly soon once I change the
> >> way how mappings are refcounted (which is, unfortunately, not suitable for
> >> stable, otherwise I wouldn't be throwing in this temporary change in the first
> >> place)
> >>
> >> So everything that is expected to stay in later patches uses the proper helper.
> > 
> > Alright.
> > 
> >>
> >> [...]
> >>
> >>>
> >>> A comment as to what's going on here with VM_MIXEDMAP would be useful. I guess
> >>> the idea is that faulting on a mixedmap later will not necessarily hand you the
> >>> exact same page fault result?
> >>
> >> I can throw in a comment, yes.
> >>
> >> [...]
> >>
> >>>
> >>> In case this function ever returns over limit, we probably want to log this
> >>> in the kernel log. If this function gets the folio you could even print
> >>> the problematic file offset/inode/filesystem/etc. Ratelimited of course.
> >>
> >> You mean, if this function returns "true", right? Is printing always fine?
> >> (e.g., irqs disabled?)
> > 
> > Yes. As far as I know, it's always fine, even under NMI. But definitely fine
> > with IRQs disabled.
> > 
> >>
> >>>
> >>>
> >>> I'm fairly sure this will break the build for a number of non-GPL drivers
> >>> when calling folio_get() with CONFIG_DEBUG_VM=y.
> >>
> >> You mean, breaking OOT drivers, right? I can switch to EXPORT_SYMBOL if that's a
> >> concern.
> > 
> > I had the impression we had some stuff in-tree that isn't marked as GPL. But a quick
> > grep shows that everything is either GPL or dual-licensed.
> > 
> > In any case, yes, this will quite possibly break debug builds for people OOT.
> > I think folio_get() might be a bit too ubiquitous to do this to.
> 
> Thinking again, folio_get() should not be affected, it rightfully only checks
> for a refcount underflow (when we exceed the limit + headroom). So only
> try_get_page() is affected, which OOT very likely doesn't use.

Aha, yes, you're right. I mixed up your folio_get() change. Would it make sense
to VM_WARN_ON() on this as well, or does the <= 0 check cover us already?
> 
> -- 
> Cheers,
> 
> David

-- 
Pedro
