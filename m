Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9849F321E
	for <iommu@lists.linux.dev>; Wed,  3 May 2023 13:21:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 334EFC433D2;
	Wed,  3 May 2023 13:21:31 +0000 (UTC)
Date: Wed, 3 May 2023 09:21:28 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Michal Hocko <mhocko@suse.com>, Suren Baghdasaryan <surenb@google.com>,
 akpm@linux-foundation.org, vbabka@suse.cz, hannes@cmpxchg.org,
 roman.gushchin@linux.dev, mgorman@suse.de, dave@stgolabs.net,
 willy@infradead.org, liam.howlett@oracle.com, corbet@lwn.net,
 void@manifault.com, peterz@infradead.org, juri.lelli@redhat.com,
 ldufour@linux.ibm.com, catalin.marinas@arm.com, will@kernel.org,
 arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com,
 dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com,
 david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
 nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev,
 rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com,
 yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com,
 hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org,
 ndesaulniers@google.com, gregkh@linuxfoundation.org, ebiggers@google.com,
 ytcoode@gmail.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
 bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, cl@linux.com,
 penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com,
 glider@google.com, elver@google.com, dvyukov@google.com,
 shakeelb@google.com, songmuchun@bytedance.com, jbaron@akamai.com,
 rientjes@google.com, minchan@google.com, kaleshsingh@google.com,
 kernel-team@android.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-modules@vger.kernel.org,
 kasan-dev@googlegroups.com, cgroups@vger.kernel.org
Subject: Re: [PATCH 00/40] Memory allocation profiling
Message-ID: <20230503092128.1a120845@gandalf.local.home>
In-Reply-To: <ZFIVtB8JyKk0ddA5@moria.home.lan>
References: <20230501165450.15352-1-surenb@google.com>
	<ZFIMaflxeHS3uR/A@dhcp22.suse.cz>
	<ZFIOfb6/jHwLqg6M@moria.home.lan>
	<ZFISlX+mSx4QJDK6@dhcp22.suse.cz>
	<ZFIVtB8JyKk0ddA5@moria.home.lan>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 3 May 2023 04:05:08 -0400
Kent Overstreet <kent.overstreet@linux.dev> wrote:

> > The burden is on you and Suren. You are proposing the implement an
> > alternative tracing infrastructure.  
> 
> No, we're still waiting on the tracing people to _demonstrate_, not
> claim, that this is at all possible in a comparable way with tracing. 

It's not my job to do your work for you!

I gave you hints on how you can do this with attaching to existing trace
events and your response was "If you don't think it's hard, go ahead and
show us." No! I'm too busy with my own work to do free work for you!

https://lore.kernel.org/all/20220905235007.sc4uk6illlog62fl@kmo-framework/

I know it's easier to create something from scratch that you fully know,
than to work with an existing infrastructure that you need to spend effort
and learn to make it do what you want. But by recreating the work, you now
pass the burden onto everyone else that needs to learn what you did. Not to
mention, we would likely have multiple ways to do the same thing.

Sorry, but that's not how an open source community is suppose to work.

-- Steve
