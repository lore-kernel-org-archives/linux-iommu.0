Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010853C35
	for <iommu@lists.linux.dev>; Mon,  5 Sep 2022 08:58:38 +0000 (UTC)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-32a09b909f6so64853937b3.0
        for <iommu@lists.linux.dev>; Mon, 05 Sep 2022 01:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Mcscb+4yg14w1rBiRtYpdW9I8YuY8tTeWXrlK9wFWrU=;
        b=Z8sZwX0UrQNHUyE15uUzUljN1G5+XUXWn7ozlWkNQaPS0v+13+PWoolzvMZEH/2/s6
         LYS6ZELiyvlMT62CZWUyH+h/p1jXfwfZLcOF83nbGfa1U5bzWw0uJywA1Nq6g4RggQN9
         M+azNg9wtAjIuHGBIaj/LBqqtGG4wC1BksRWLrapbeVhca09DWdw9aO+S7lkiOmT419k
         B7LBrz0EVZ5dFwwSikfSkFiCRf8G7DmN1ptEdy0ZLUUkT5MXom1MAu8JaMJrJbPX6xsQ
         z/gVg/ZkLNO66Ao9RVZbmyzaUupGI6+7kFaD3U0bHdpOYObc1T0hLgrkbVZFP/rVpApA
         /zsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Mcscb+4yg14w1rBiRtYpdW9I8YuY8tTeWXrlK9wFWrU=;
        b=ta+Lq6cMUVJjavyqIFOHax6rngcaHXzAoGl6+kuMkd5c8KOJdkyelxfcD/py2KIUlm
         +H05fYZJaZhDEtZE0ODjDFZHyx01+GwjswKoGMq2deWs1FP+KkEHBSCWnAkEUJT+yH9U
         iWPzJJ6HkT7YWsFygX9yxzveV5PqfmrS2H3KAtFnDmX/krFT4RqkY7SJSu+E+/DH0xFW
         cyGmszw6Aka62lv2SfIuDkbeMs5RXxg/A8oYwd/eQVLkjoHcxlAJ+rZGlZxzBsEVMeY4
         zOGQSfeHOHw21D/I7GB0KKbQ3BQa4hf6cx2IgpkWdsM1NiRUd7b67C6agxvoU8Av21/c
         WFqQ==
X-Gm-Message-State: ACgBeo3BG7nP3n3sdUASWB1/9zNpLoEiankotC9iVT4BvO9WI44Hws8h
	zJ1NCDES+5XiRsVu+aMsTcNdmFPHr2GgHkPoDK96zw==
X-Google-Smtp-Source: AA6agR4vColk4VOoxJ3aA1AZBZ3YZkQTsja6zG5W+nyEUjeTUXHJb0eacFw2AD+E2b0jt8egp4/3QX6cb8SK35bLOpk=
X-Received: by 2002:a81:bb41:0:b0:328:fd1b:5713 with SMTP id
 a1-20020a81bb41000000b00328fd1b5713mr38838381ywl.238.1662368317652; Mon, 05
 Sep 2022 01:58:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220830214919.53220-1-surenb@google.com> <Yw8P8xZ4zqu121xL@hirez.programming.kicks-ass.net>
 <20220831084230.3ti3vitrzhzsu3fs@moria.home.lan> <20220831101948.f3etturccmp5ovkl@suse.de>
 <Yw88RFuBgc7yFYxA@dhcp22.suse.cz> <20220831190154.qdlsxfamans3ya5j@moria.home.lan>
 <YxBc1xuGbB36f8zC@dhcp22.suse.cz> <CAJuCfpGhwPFYdkOLjwwD4ra9JxPqq1T5d1jd41Jy3LJnVnhNdg@mail.gmail.com>
 <YxEE1vOwRPdzKxoq@dhcp22.suse.cz> <CAJuCfpFrRwXXQ=wAvZ-oUNKXUJ=uUA=fiDrkhRu5VGXcM+=cuA@mail.gmail.com>
 <YxWvbMYLkPoJrQyr@dhcp22.suse.cz>
In-Reply-To: <YxWvbMYLkPoJrQyr@dhcp22.suse.cz>
From: Marco Elver <elver@google.com>
Date: Mon, 5 Sep 2022 10:58:01 +0200
Message-ID: <CANpmjNOYNWSSiV+VzvzBAeDJX+c1DRP+6jedKMt3gLNg8bgWKA@mail.gmail.com>
Subject: Re: [RFC PATCH 00/30] Code tagging framework and applications
To: Michal Hocko <mhocko@suse.com>
Cc: Suren Baghdasaryan <surenb@google.com>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Mel Gorman <mgorman@suse.de>, Peter Zijlstra <peterz@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Davidlohr Bueso <dave@stgolabs.net>, Matthew Wilcox <willy@infradead.org>, 
	"Liam R. Howlett" <liam.howlett@oracle.com>, David Vernet <void@manifault.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Laurent Dufour <ldufour@linux.ibm.com>, 
	Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
	mcgrof@kernel.org, masahiroy@kernel.org, nathan@kernel.org, 
	changbin.du@intel.com, ytcoode@gmail.com, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Benjamin Segall <bsegall@google.com>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>, 
	Christopher Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
	42.hyeyoo@gmail.com, Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Shakeel Butt <shakeelb@google.com>, Muchun Song <songmuchun@bytedance.com>, arnd@arndb.de, 
	jbaron@akamai.com, David Rientjes <rientjes@google.com>, Minchan Kim <minchan@google.com>, 
	Kalesh Singh <kaleshsingh@google.com>, kernel-team <kernel-team@android.com>, 
	linux-mm <linux-mm@kvack.org>, iommu@lists.linux.dev, kasan-dev@googlegroups.com, 
	io-uring@vger.kernel.org, linux-arch@vger.kernel.org, 
	xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org, 
	linux-modules@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 5 Sept 2022 at 10:12, Michal Hocko <mhocko@suse.com> wrote:
> On Sun 04-09-22 18:32:58, Suren Baghdasaryan wrote:
> > On Thu, Sep 1, 2022 at 12:15 PM Michal Hocko <mhocko@suse.com> wrote:
> [...]
> > > Yes, tracking back the call trace would be really needed. The question
> > > is whether this is really prohibitively expensive. How much overhead are
> > > we talking about? There is no free lunch here, really.  You either have
> > > the overhead during runtime when the feature is used or on the source
> > > code level for all the future development (with a maze of macros and
> > > wrappers).
> >
> > As promised, I profiled a simple code that repeatedly makes 10
> > allocations/frees in a loop and measured overheads of code tagging,
> > call stack capturing and tracing+BPF for page and slab allocations.
> > Summary:
> >
> > Page allocations (overheads are compared to get_free_pages() duration):
> > 6.8% Codetag counter manipulations (__lazy_percpu_counter_add + __alloc_tag_add)
> > 8.8% lookup_page_ext
> > 1237% call stack capture
> > 139% tracepoint with attached empty BPF program
>
> Yes, I am not surprised that the call stack capturing is really
> expensive comparing to the allocator fast path (which is really highly
> optimized and I suspect that with 10 allocation/free loop you mostly get
> your memory from the pcp lists). Is this overhead still _that_ visible
> for somehow less microoptimized workloads which have to take slow paths
> as well?
>
> Also what kind of stack unwinder is configured (I guess ORC)? This is
> not my area but from what I remember the unwinder overhead varies
> between ORC and FP.
>
> And just to make it clear. I do realize that an overhead from the stack
> unwinding is unavoidable. And code tagging would logically have lower
> overhead as it performs much less work. But the main point is whether
> our existing stack unwiding approach is really prohibitively expensive
> to be used for debugging purposes on production systems. I might
> misremember but I recall people having bigger concerns with page_owner
> memory footprint than the actual stack unwinder overhead.

This is just to point out that we've also been looking at cheaper
collection of the stack trace (for KASAN and other sanitizers). The
cheapest way to unwind the stack would be a system with "shadow call
stack" enabled. With compiler support it's available on arm64, see
CONFIG_SHADOW_CALL_STACK. For x86 the hope is that at one point the
kernel will support CET, which newer Intel and AMD CPUs support.
Collecting the call stack would then be a simple memcpy.
