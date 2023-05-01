Received: from out-20.mta0.migadu.com (out-20.mta0.migadu.com [91.218.175.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573908C05
	for <iommu@lists.linux.dev>; Mon,  1 May 2023 21:17:14 +0000 (UTC)
Date: Mon, 1 May 2023 17:16:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1682975831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WS5IfKwTPa1bKv8dROPMPn7bpsB6bxr/+mMUnulbyXo=;
	b=lW6pMkkITA3yRW/sjDAKtYtv7Nl+AYeAS5qW1/WcLz5hQIZOXhmptquOd9Uo4YjlLQagEj
	l8KwsV9hdfnmKeThBO+Hem6g0VYZI6AYnyFLRYZNX5+S78AIIBPNkxPLEdu52Lb7u0ovlq
	VCSzQAFEVndS+FYqBuYKLLIDbnpmrsU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
	mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org,
	roman.gushchin@linux.dev, mgorman@suse.de, willy@infradead.org,
	liam.howlett@oracle.com, corbet@lwn.net, void@manifault.com,
	peterz@infradead.org, juri.lelli@redhat.com, ldufour@linux.ibm.com,
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
	cgroups@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Noralf =?utf-8?B?VHLDr8K/wr1ubmVz?= <noralf@tronnes.org>
Subject: Re: [PATCH 01/40] lib/string_helpers: Drop space in
 string_get_size's output
Message-ID: <ZFAsS5f6eGSyxF/+@moria.home.lan>
References: <20230501165450.15352-1-surenb@google.com>
 <20230501165450.15352-2-surenb@google.com>
 <ouuidemyregstrijempvhv357ggp4tgnv6cijhasnungsovokm@jkgvyuyw2fti>
 <ZFAUj+Q+hP7cWs4w@moria.home.lan>
 <CAHp75VeJ_a6j3uweLN5-woSQUtN5u36c2gkoiXhnJa1HXJdoyQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VeJ_a6j3uweLN5-woSQUtN5u36c2gkoiXhnJa1HXJdoyQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Mon, May 01, 2023 at 10:57:07PM +0300, Andy Shevchenko wrote:
> On Mon, May 1, 2023 at 10:36 PM Kent Overstreet
> <kent.overstreet@linux.dev> wrote:
> >
> > On Mon, May 01, 2023 at 11:13:15AM -0700, Davidlohr Bueso wrote:
> > > On Mon, 01 May 2023, Suren Baghdasaryan wrote:
> > >
> > > > From: Kent Overstreet <kent.overstreet@linux.dev>
> > > >
> > > > Previously, string_get_size() outputted a space between the number and
> > > > the units, i.e.
> > > >  9.88 MiB
> > > >
> > > > This changes it to
> > > >  9.88MiB
> > > >
> > > > which allows it to be parsed correctly by the 'sort -h' command.
> 
> But why do we need that? What's the use case?

As was in the commit message: to produce output that sort -h knows how
to parse.

> > > Wouldn't this break users that already parse it the current way?
> >
> > It's not impossible - but it's not used in very many places and we
> > wouldn't be printing in human-readable units if it was meant to be
> > parsed - it's mainly used for debug output currently.
> >
> > If someone raises a specific objection we'll do something different,
> > otherwise I think standardizing on what userspace tooling already parses
> > is a good idea.
> 
> Yes, I NAK this on the basis of
> https://english.stackexchange.com/a/2911/153144

Not sure I find a style guide on stackexchange more compelling than
interop with a tool everyone already has installed :)
