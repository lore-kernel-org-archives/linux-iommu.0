Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E88468E
	for <iommu@lists.linux.dev>; Mon,  5 Sep 2022 18:08:33 +0000 (UTC)
Received: by mail-il1-f178.google.com with SMTP id v15so4938782iln.6
        for <iommu@lists.linux.dev>; Mon, 05 Sep 2022 11:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=hbTvjCqXtfZwCNAPDugxhLvbO4tPW4uXsytclFMPf88=;
        b=BWl6tEU0Jv/5Ok7izOy2X+2XFHIjW2yJwE8yMIwADusWnEOeQC8si1U6iks3IFTXtR
         5tbbeyYCmyTiKFNMcU3D2cV+gb/s5ohOcUII9kU6FU7ji/Zh8BrlwKsCQaRcerXV6BGZ
         8PlGGmZZYHPvdH+WgSsyR10w9r/j2bW/3D0lAGkx1tIn87fB5RB3pcjDyqMnvPGCsyas
         uH/yoycyrf5kaO5p9L7J37V/vDYJvxKCrEBpA8AorAMThecIv/vXA5VLdyTk9mhWPhlm
         xhk4J8Awk+fBDhqAh5Kc3xuDELqvWV7xGoRQ08TJNeQzRqgNOVW6ruxsZF0Lyj7+Dw3B
         m0Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=hbTvjCqXtfZwCNAPDugxhLvbO4tPW4uXsytclFMPf88=;
        b=Ho8frM7MXLt9tu5/fFuvzoFShthyG4eOYMi1JWpZojSn1nrQdVkWj66wFBRorEWjmX
         oOX7Ejf5vPDtBb3FQTYk4te+d0stnvjHA7YsDlc8Af5TkcK/7FuO0O60Iy3IRMphP70w
         /Ge8MMazd+caVfOKSwHncwZHG1ArdDY46bY/a+38kNFAzgWVRRNFDVAHfARJ5DKpsxPg
         X7gBboThMkRep216qQsb7fjXanDOockEy/57SW0ITSR6aUnsCiv83r54FyAQKFxwi4GR
         Fj5rYR/H433L/nUU+klYtRU+xb3o3FCh5Et8ztzG+uMmNBAyXao+1P8lQXDUqSQzZdl6
         tkHg==
X-Gm-Message-State: ACgBeo3iu/PJi/wtGRjI3Mpi/4vCpbKhLb5iwsl5PId0X+TWj0/c1Imp
	1x3q58K13kXr7fgQPDn+eT8LlKRZrkNHO8BOnE5r+A==
X-Google-Smtp-Source: AA6agR4Rv/lC85vS43o4ySf3NvmJunla0lbszDaoWXhv+p4vulk9P6WBBoE0T5B+Wry+ZoXPm1CE94n4VZxipIKzyxQ=
X-Received: by 2002:a92:ca06:0:b0:2eb:391a:a2a4 with SMTP id
 j6-20020a92ca06000000b002eb391aa2a4mr16719486ils.199.1662401312639; Mon, 05
 Sep 2022 11:08:32 -0700 (PDT)
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
 <20220905110713.27304149@gandalf.local.home>
In-Reply-To: <20220905110713.27304149@gandalf.local.home>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 5 Sep 2022 11:08:21 -0700
Message-ID: <CAJuCfpF-O6Gz2o7YqCgFHV+KEFuzC-PTUoBHj25DNRkkSmhbUg@mail.gmail.com>
Subject: Re: [RFC PATCH 00/30] Code tagging framework and applications
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Michal Hocko <mhocko@suse.com>, Kent Overstreet <kent.overstreet@linux.dev>, 
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
	Benjamin Segall <bsegall@google.com>, Daniel Bristot de Oliveira <bristot@redhat.com>, 
	Valentin Schneider <vschneid@redhat.com>, Christopher Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, 42.hyeyoo@gmail.com, 
	Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Shakeel Butt <shakeelb@google.com>, Muchun Song <songmuchun@bytedance.com>, arnd@arndb.de, 
	jbaron@akamai.com, David Rientjes <rientjes@google.com>, Minchan Kim <minchan@google.com>, 
	Kalesh Singh <kaleshsingh@google.com>, kernel-team <kernel-team@android.com>, 
	linux-mm <linux-mm@kvack.org>, iommu@lists.linux.dev, kasan-dev@googlegroups.com, 
	io-uring@vger.kernel.org, linux-arch@vger.kernel.org, 
	xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org, 
	linux-modules@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, Sep 5, 2022 at 8:06 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Sun, 4 Sep 2022 18:32:58 -0700
> Suren Baghdasaryan <surenb@google.com> wrote:
>
> > Page allocations (overheads are compared to get_free_pages() duration):
> > 6.8% Codetag counter manipulations (__lazy_percpu_counter_add + __alloc_tag_add)
> > 8.8% lookup_page_ext
> > 1237% call stack capture
> > 139% tracepoint with attached empty BPF program
>
> Have you tried tracepoint with custom callback?
>
> static void my_callback(void *data, unsigned long call_site,
>                         const void *ptr, struct kmem_cache *s,
>                         size_t bytes_req, size_t bytes_alloc,
>                         gfp_t gfp_flags)
> {
>         struct my_data_struct *my_data = data;
>
>         { do whatever }
> }
>
> [..]
>         register_trace_kmem_alloc(my_callback, my_data);
>
> Now the my_callback function will be called directly every time the
> kmem_alloc tracepoint is hit.
>
> This avoids that perf and BPF overhead.

Haven't tried that yet but will do. Thanks for the reference code!

>
> -- Steve
