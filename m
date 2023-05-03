Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98667138F
	for <iommu@lists.linux.dev>; Wed,  3 May 2023 07:39:08 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E610820079;
	Wed,  3 May 2023 07:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1683099546; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vE/ZqILzfvZWd4rot3GcUptJ3pMzFJC66caayH1dCe0=;
	b=tncfUpOeuf22PZWsQOZPjfGxENPQ6bWeS5Zzg0KWVa6nByIXgrM/jXad5KRjyoMOq9cTRa
	WpcrDCHFNLiXhmlPc0lNRWDLzFfikMFdjsBDSF6ZkSOyK8WMPI6FOfRJkSLZupbbrFLolo
	+Rlvt8SIDl9dbU55U0aIZiVhpfhfHjs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BB17E1331F;
	Wed,  3 May 2023 07:39:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id v3OjLJoPUmQQVAAAMHmgww
	(envelope-from <mhocko@suse.com>); Wed, 03 May 2023 07:39:06 +0000
Date: Wed, 3 May 2023 09:39:06 +0200
From: Michal Hocko <mhocko@suse.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, vbabka@suse.cz,
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de,
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
	corbet@lwn.net, void@manifault.com, peterz@infradead.org,
	juri.lelli@redhat.com, ldufour@linux.ibm.com,
	catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, peterx@redhat.com, david@redhat.com,
	axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org,
	muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org,
	pasha.tatashin@soleen.com, yosryahmed@google.com, yuzhao@google.com,
	dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com,
	keescook@chromium.org, ndesaulniers@google.com,
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
	vschneid@redhat.com, cl@linux.com, penberg@kernel.org,
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com,
	elver@google.com, dvyukov@google.com, shakeelb@google.com,
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com,
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-arch@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com,
	cgroups@vger.kernel.org
Subject: Re: [PATCH 35/40] lib: implement context capture support for tagged
 allocations
Message-ID: <ZFIPmnrSIdJ5yusM@dhcp22.suse.cz>
References: <20230501165450.15352-1-surenb@google.com>
 <20230501165450.15352-36-surenb@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230501165450.15352-36-surenb@google.com>

On Mon 01-05-23 09:54:45, Suren Baghdasaryan wrote:
[...]
> +struct codetag_ctx *alloc_tag_create_ctx(struct alloc_tag *tag, size_t size)
> +{
> +	struct alloc_call_ctx *ac_ctx;
> +
> +	/* TODO: use a dedicated kmem_cache */
> +	ac_ctx = kmalloc(sizeof(struct alloc_call_ctx), GFP_KERNEL);

You cannot really use GFP_KERNEL here. This is post_alloc_hook path and
that has its own gfp context.
-- 
Michal Hocko
SUSE Labs
