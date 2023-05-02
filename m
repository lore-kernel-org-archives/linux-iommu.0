Received: from out-45.mta1.migadu.com (out-45.mta1.migadu.com [95.215.58.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1C68F6E
	for <iommu@lists.linux.dev>; Tue,  2 May 2023 19:58:06 +0000 (UTC)
Date: Tue, 2 May 2023 15:57:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1683057484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bbTqJ6Cy48RWo6Tz/tI7JJZLpQOgd1GnXsK6J+pb2Po=;
	b=TPEXvTAZj7eMMlezn0mxuUI2XEAYSmuur8j15Vhz2aAoEuxaC8gwe/DdLVCUdzI8I+L6aU
	DEG5XTP5rhYFuMy34wKLVWK/nyN2iMJiF2WhtVwQS5E54+cSGLx6PlY24qgxqRCabxvnfl
	6yoheYQVL8RgpgGG5HowroFYWwjIS0M=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
Cc: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
	mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org,
	roman.gushchin@linux.dev, mgorman@suse.de, dave@stgolabs.net,
	willy@infradead.org, liam.howlett@oracle.com, corbet@lwn.net,
	void@manifault.com, peterz@infradead.org, juri.lelli@redhat.com,
	ldufour@linux.ibm.com, catalin.marinas@arm.com, will@kernel.org,
	arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com,
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org,
	masahiroy@kernel.org, nathan@kernel.org, dennis@kernel.org,
	tj@kernel.org, muchun.song@linux.dev, rppt@kernel.org,
	paulmck@kernel.org, pasha.tatashin@soleen.com,
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com,
	hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org,
	ndesaulniers@google.com, gregkh@linuxfoundation.org,
	ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	bristot@redhat.com, vschneid@redhat.com, cl@linux.com,
	penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com,
	glider@google.com, elver@google.com, dvyukov@google.com,
	shakeelb@google.com, songmuchun@bytedance.com, jbaron@akamai.com,
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com,
	kernel-team@android.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-modules@vger.kernel.org,
	kasan-dev@googlegroups.com, cgroups@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 03/40] fs: Convert alloc_inode_sb() to a macro
Message-ID: <ZFFrP8WKRFgZRzoB@moria.home.lan>
References: <20230501165450.15352-1-surenb@google.com>
 <20230501165450.15352-4-surenb@google.com>
 <20230502143530.1586e287@meshulam.tesarici.cz>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230502143530.1586e287@meshulam.tesarici.cz>
X-Migadu-Flow: FLOW_OUT

On Tue, May 02, 2023 at 02:35:30PM +0200, Petr Tesařík wrote:
> On Mon,  1 May 2023 09:54:13 -0700
> Suren Baghdasaryan <surenb@google.com> wrote:
> 
> > From: Kent Overstreet <kent.overstreet@linux.dev>
> > 
> > We're introducing alloc tagging, which tracks memory allocations by
> > callsite. Converting alloc_inode_sb() to a macro means allocations will
> > be tracked by its caller, which is a bit more useful.
> > 
> > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> > ---
> >  include/linux/fs.h | 6 +-----
> >  1 file changed, 1 insertion(+), 5 deletions(-)
> > 
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index 21a981680856..4905ce14db0b 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -2699,11 +2699,7 @@ int setattr_should_drop_sgid(struct mnt_idmap *idmap,
> >   * This must be used for allocating filesystems specific inodes to set
> >   * up the inode reclaim context correctly.
> >   */
> > -static inline void *
> > -alloc_inode_sb(struct super_block *sb, struct kmem_cache *cache, gfp_t gfp)
> > -{
> > -	return kmem_cache_alloc_lru(cache, &sb->s_inode_lru, gfp);
> > -}
> > +#define alloc_inode_sb(_sb, _cache, _gfp) kmem_cache_alloc_lru(_cache, &_sb->s_inode_lru, _gfp)
> 
> Honestly, I don't like this change. In general, pre-processor macros
> are ugly and error-prone.

It's a one line macro, it's fine.

> Besides, it works for you only because __kmem_cache_alloc_lru() is
> declared __always_inline (unless CONFIG_SLUB_TINY is defined, but then
> you probably don't want the tracking either). In any case, it's going
> to be difficult for people to understand why and how this works.

I think you must be confused. kmem_cache_alloc_lru() is a macro, and we
need that macro to be expanded at the alloc_inode_sb() callsite. It's
got nothing to do with whether or not __kmem_cache_alloc_lru() is inline
or not.

> If the actual caller of alloc_inode_sb() is needed, I'd rather add it
> as a parameter and pass down _RET_IP_ explicitly here.

That approach was considered, but adding an ip parameter to every memory
allocation function would've been far more churn.
