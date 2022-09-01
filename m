Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071795C82
	for <iommu@lists.linux.dev>; Thu,  1 Sep 2022 14:43:19 +0000 (UTC)
Date: Thu, 1 Sep 2022 10:43:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1662043398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nOHSW3FDpFxopIM9LbojW3h32sP5UuFpnfFE44cGJM8=;
	b=DYXiWVC0vy4teLKZQztFxvW1KXEKgsv/W8GLVht+MMEppphvXl1beWtjobZtBs7ufDfyf1
	/Az+HrU+UnzwRWndfnxlx9U/cWoea5qHWVDTW/7rGq5kcj9ODLnVIRzkPJn+RdzRKpoYMZ
	5Z1XsUa8iU3hq/D237KbAKpwZVrQllY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
	mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org,
	roman.gushchin@linux.dev, mgorman@suse.de, dave@stgolabs.net,
	willy@infradead.org, liam.howlett@oracle.com, void@manifault.com,
	juri.lelli@redhat.com, ldufour@linux.ibm.com, peterx@redhat.com,
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org,
	masahiroy@kernel.org, nathan@kernel.org, changbin.du@intel.com,
	ytcoode@gmail.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	bristot@redhat.com, vschneid@redhat.com, cl@linux.com,
	penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com,
	glider@google.com, elver@google.com, dvyukov@google.com,
	shakeelb@google.com, songmuchun@bytedance.com, arnd@arndb.de,
	jbaron@akamai.com, rientjes@google.com, minchan@google.com,
	kaleshsingh@google.com, kernel-team@android.com, linux-mm@kvack.org,
	iommu@lists.linux.dev, kasan-dev@googlegroups.com,
	io-uring@vger.kernel.org, linux-arch@vger.kernel.org,
	xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 27/30] Code tagging based latency tracking
Message-ID: <20220901144311.ywhhdaigweyy7eo6@moria.home.lan>
References: <20220830214919.53220-1-surenb@google.com>
 <20220830214919.53220-28-surenb@google.com>
 <YxBbFUirdlbXDaZA@hirez.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxBbFUirdlbXDaZA@hirez.programming.kicks-ass.net>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev

On Thu, Sep 01, 2022 at 09:11:17AM +0200, Peter Zijlstra wrote:
> On Tue, Aug 30, 2022 at 02:49:16PM -0700, Suren Baghdasaryan wrote:
> > From: Kent Overstreet <kent.overstreet@linux.dev>
> > 
> > This adds the ability to easily instrument code for measuring latency.
> > To use, add the following to calls to your code, at the start and end of
> > the event you wish to measure:
> > 
> >   code_tag_time_stats_start(start_time);
> >   code_tag_time_stats_finish(start_time);
> > 
> > Stastistics will then show up in debugfs under
> > /sys/kernel/debug/time_stats, listed by file and line number.
> > 
> > Stastics measured include weighted averages of frequency, duration, max
> > duration, as well as quantiles.
> > 
> > This patch also instruments all calls to init_wait and finish_wait,
> > which includes all calls to wait_event. Example debugfs output:
> 
> How can't you do this with a simple eBPF script on top of
> trace_sched_stat_* and friends?

I know about those tracepoints, and I've never found them to be usable. I've
never succesfully used them for debugging latency issues, or known anyone who
has.

And an eBPF script to do everything this does wouldn't be simple at all.
Honesly, the time stats stuff looks _far_ simpler to me than anything involving
tracing - and with tracing you have to correlate the start and end events after
the fact.
