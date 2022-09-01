Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F135C82
	for <iommu@lists.linux.dev>; Thu,  1 Sep 2022 14:48:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DDEAC433D6;
	Thu,  1 Sep 2022 14:48:08 +0000 (UTC)
Date: Thu, 1 Sep 2022 10:48:39 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Peter Zijlstra <peterz@infradead.org>, Suren Baghdasaryan
 <surenb@google.com>, akpm@linux-foundation.org, mhocko@suse.com,
 vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev,
 mgorman@suse.de, dave@stgolabs.net, willy@infradead.org,
 liam.howlett@oracle.com, void@manifault.com, juri.lelli@redhat.com,
 ldufour@linux.ibm.com, peterx@redhat.com, david@redhat.com,
 axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
 nathan@kernel.org, changbin.du@intel.com, ytcoode@gmail.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, bsegall@google.com,
 bristot@redhat.com, vschneid@redhat.com, cl@linux.com, penberg@kernel.org,
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
Message-ID: <20220901104839.5691e1c9@gandalf.local.home>
In-Reply-To: <20220901143219.n7jg7cbp47agqnwn@moria.home.lan>
References: <20220830214919.53220-1-surenb@google.com>
	<20220830214919.53220-4-surenb@google.com>
	<YxBWczNCbZbj+reQ@hirez.programming.kicks-ass.net>
	<20220901143219.n7jg7cbp47agqnwn@moria.home.lan>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 1 Sep 2022 10:32:19 -0400
Kent Overstreet <kent.overstreet@linux.dev> wrote:

> On Thu, Sep 01, 2022 at 08:51:31AM +0200, Peter Zijlstra wrote:
> > On Tue, Aug 30, 2022 at 02:48:52PM -0700, Suren Baghdasaryan wrote:  
> > > +static void lazy_percpu_counter_switch_to_pcpu(struct raw_lazy_percpu_counter *c)
> > > +{
> > > +	u64 __percpu *pcpu_v = alloc_percpu_gfp(u64, GFP_ATOMIC|__GFP_NOWARN);  
> > 
> > Realize that this is incorrect when used under a raw_spinlock_t.  
> 
> Can you elaborate?

All allocations (including GFP_ATOMIC) grab normal spin_locks. When
PREEMPT_RT is configured, normal spin_locks turn into a mutex, where as
raw_spinlock's do not.

Thus, if this is done within a raw_spinlock with PREEMPT_RT configured, it
can cause a schedule while holding a spinlock.

-- Steve
