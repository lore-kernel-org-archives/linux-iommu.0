Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D567E7
	for <iommu@lists.linux.dev>; Wed, 31 Aug 2022 10:10:38 +0000 (UTC)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id 60E182226F;
	Wed, 31 Aug 2022 10:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1661940178; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UghZOtEbbNtkuyHw6OG+q34Eguh17rpI6TW2xy+k26s=;
	b=PRBKEeRroKw9uKicRWHW+510+yPrLqUkpbnRk+7WMXhWuFKJOM0BT+MpyEO2iwAv8hytIA
	btsLNyDayNr7GOZofmiVg24uPISDfKOix86GB2r26KRZAxV3CAmeg/EZgjlKPFALHLF+rj
	W6qDhGUMZIbq1FBe7+V0SXRtsy5jHbc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1661940178;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UghZOtEbbNtkuyHw6OG+q34Eguh17rpI6TW2xy+k26s=;
	b=Fsjsh2O/oToKVq/H89joyhrl1vB+8BTBfApNgEKpxECOhMpD8okC2XulgoKvPMmysJjbXj
	bGEzv3xuk/Jor7Bg==
Received: from suse.de (unknown [10.163.43.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by relay2.suse.de (Postfix) with ESMTPS id C064A2C142;
	Wed, 31 Aug 2022 10:02:50 +0000 (UTC)
Date: Wed, 31 Aug 2022 11:02:49 +0100
From: Mel Gorman <mgorman@suse.de>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com,
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev,
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
	void@manifault.com, peterz@infradead.org, juri.lelli@redhat.com,
	ldufour@linux.ibm.com, peterx@redhat.com, david@redhat.com,
	axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
	nathan@kernel.org, changbin.du@intel.com, ytcoode@gmail.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
	vschneid@redhat.com, cl@linux.com, penberg@kernel.org,
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com,
	elver@google.com, dvyukov@google.com, shakeelb@google.com,
	songmuchun@bytedance.com, arnd@arndb.de, jbaron@akamai.com,
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com,
	kernel-team@android.com, linux-mm@kvack.org, iommu@lists.linux.dev,
	kasan-dev@googlegroups.com, io-uring@vger.kernel.org,
	linux-arch@vger.kernel.org, xen-devel@lists.xenproject.org,
	linux-bcache@vger.kernel.org, linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 03/30] Lazy percpu counters
Message-ID: <20220831100249.f2o27ri7ho4ma3pe@suse.de>
References: <20220830214919.53220-1-surenb@google.com>
 <20220830214919.53220-4-surenb@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20220830214919.53220-4-surenb@google.com>

On Tue, Aug 30, 2022 at 02:48:52PM -0700, Suren Baghdasaryan wrote:
> From: Kent Overstreet <kent.overstreet@linux.dev>
> 
> This patch adds lib/lazy-percpu-counter.c, which implements counters
> that start out as atomics, but lazily switch to percpu mode if the
> update rate crosses some threshold (arbitrarily set at 256 per second).
> 
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>

Why not use percpu_counter? It has a per-cpu counter that is synchronised
when a batch threshold (default 32) is exceeded and can explicitly sync
the counters when required assuming the synchronised count is only needed
when reading debugfs.

-- 
Mel Gorman
SUSE Labs
