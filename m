Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9BEA52
	for <iommu@lists.linux.dev>; Wed,  3 May 2023 18:19:27 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1aaff9c93a5so25582685ad.2
        for <iommu@lists.linux.dev>; Wed, 03 May 2023 11:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683137967; x=1685729967;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b8EyOQL7PrYcjENM7voIrei4tZKK2YZzqm7TQH+pwlU=;
        b=aZNjJ0sKerUq7u8EB+b0HNpoznz9cBQhrzzOvNvOKeztEz5atXm5CLpSRLxWpTflSR
         bxO698PfKyTFFeXOCQw+L4viOYGAfhQwycSh4dwa8tVAX89FbIuNkNMzVF/32CZveUnN
         lmZCFzArGY1PfzDmPf0qgKFQkNfkLEuxrzW+qQ+ci+jVIdPpjFyLGv4gyshMjEWMn+PU
         6c620nyXugQ2Wyt655L7CulVWSS+LO7irrkNzBdN5DIP2Vi2A2FOlTEtiS0NgBoGOQ5u
         6Yk7eTdeaMiyAwzgTLQwCB5153Vyr42Hf0ig6bVEn7Dn5xAQCmOPEPEY1yGnR7rX1ltt
         av/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683137967; x=1685729967;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b8EyOQL7PrYcjENM7voIrei4tZKK2YZzqm7TQH+pwlU=;
        b=VMH6LZjkElhCEwAIpRtyOEOOysokgOTTXmRqmj0JJYzCjYSfX1xFWZo2ahHu8IdQJs
         8mbSdNQ1GHteVlARYU1uPw6RlqJZ3zD6bcW3gZnjxMluPRyjqojIwhJJ9Sn+8saxjOqO
         uEhLfyTO/XAZ2HAUQzwmNmDCRaoFQUa/oVvGHdA6Z/PyNd3OPAp6rAdIiHGYaUoZgiH8
         rmw8PrzjwMZdYGtT2FU8JCt1oRuPqRTnSzCuzrBHQlh13fivtMvcfRMo8TTNHpSePKRz
         GQ3eLs3KRjUocxvs388rkXr8i6J0mvHGJNAY3HEKTMNJi0j6RhViEV49Ebg+xLQZTfUq
         CnBw==
X-Gm-Message-State: AC+VfDxCfkBSUij/aTW7NX9UbZDC1sNdFcbs5jp+1iHtLKViO7Aevwkq
	1syH8ifFxyWfywYa/Tj3CZY=
X-Google-Smtp-Source: ACHHUZ5kZePZEgjP5lSOR3ffglK7m6ZeFxMZWbG24/SHqDcb/SSEB/aGUwMNUi2KVWf0aSPpse9LEA==
X-Received: by 2002:a17:903:11c9:b0:1ab:16e0:ef49 with SMTP id q9-20020a17090311c900b001ab16e0ef49mr1056514plh.24.1683137966573;
        Wed, 03 May 2023 11:19:26 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:6454])
        by smtp.gmail.com with ESMTPSA id s2-20020a170902988200b0019a7d58e595sm21845154plp.143.2023.05.03.11.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 11:19:26 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 3 May 2023 08:19:24 -1000
From: Tejun Heo <tj@kernel.org>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
	vbabka@suse.cz, roman.gushchin@linux.dev, mgorman@suse.de,
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
	corbet@lwn.net, void@manifault.com, peterz@infradead.org,
	juri.lelli@redhat.com, ldufour@linux.ibm.com,
	catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, peterx@redhat.com, david@redhat.com,
	axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
	nathan@kernel.org, dennis@kernel.org, muchun.song@linux.dev,
	rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com,
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
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH 00/40] Memory allocation profiling
Message-ID: <ZFKlrP7nLn93iIRf@slm.duckdns.org>
References: <20230501165450.15352-1-surenb@google.com>
 <ZFIMaflxeHS3uR/A@dhcp22.suse.cz>
 <ZFIOfb6/jHwLqg6M@moria.home.lan>
 <ZFISlX+mSx4QJDK6@dhcp22.suse.cz>
 <ZFIVtB8JyKk0ddA5@moria.home.lan>
 <ZFKNZZwC8EUbOLMv@slm.duckdns.org>
 <20230503180726.GA196054@cmpxchg.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230503180726.GA196054@cmpxchg.org>

Hello,

On Wed, May 03, 2023 at 02:07:26PM -0400, Johannes Weiner wrote:
...
> > * Because tracking starts when the script starts running, it doesn't know
> >   anything which has happened upto that point, so you gotta pay attention to
> >   handling e.g. handling frees which don't match allocs. It's kinda annoying
> >   but not a huge problem usually. There are ways to build in BPF progs into
> >   the kernel and load it early but I haven't experiemnted with it yet
> >   personally.
> 
> Yeah, early loading is definitely important, especially before module
> loading etc.
> 
> One common usecase is that we see a machine in the wild with a high
> amount of kernel memory disappearing somewhere that isn't voluntarily
> reported in vmstat/meminfo. Reproducing it isn't always
> practical. Something that records early and always (with acceptable
> runtime overhead) would be the holy grail.
> 
> Matching allocs to frees is doable using the pfn as the key for pages,
> and virtual addresses for slab objects.
> 
> The biggest issue I had when I tried with bpf was losing updates to
> the map. IIRC there is some trylocking going on to avoid deadlocks
> from nested contexts (alloc interrupted, interrupt frees). It doesn't
> sound like an unsolvable problem, though.

(cc'ing Alexei and Andrii)

This is the same thing that I hit with sched_ext. BPF plugged it for
struct_ops but I wonder whether it can be done for specific maps / progs -
ie. just declare that a given map or prog is not to be accessed from NMI and
bypass the trylock deadlock avoidance mechanism. But, yeah, this should be
addressed from BPF side.

> Another minor thing was the stack trace map exploding on a basically
> infinite number of unique interrupt stacks. This could probably also
> be solved by extending the trace extraction API to cut the frames off
> at the context switch boundary.
> 
> Taking a step back though, given the multitude of allocation sites in
> the kernel, it's a bit odd that the only accounting we do is the tiny
> fraction of voluntary vmstat/meminfo reporting. We try to cover the
> biggest consumers with this of course, but it's always going to be
> incomplete and is maintenance overhead too. There are on average
> several gigabytes in unknown memory (total - known vmstats) on our
> machines. It's difficult to detect regressions easily. And it's per
> definition the unexpected cornercases that are the trickiest to track
> down. So it might be doable with BPF, but it does feel like the kernel
> should do a better job of tracking out of the box and without
> requiring too much plumbing and somewhat fragile kernel allocation API
> tracking and probing from userspace.

Yeah, easy / default visibility argument does make sense to me.

Thanks.

-- 
tejun
