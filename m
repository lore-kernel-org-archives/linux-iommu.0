Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA49A5C81
	for <iommu@lists.linux.dev>; Wed,  7 Sep 2022 13:44:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E8F1C433C1;
	Wed,  7 Sep 2022 13:44:38 +0000 (UTC)
Date: Wed, 7 Sep 2022 09:45:18 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Michal Hocko <mhocko@suse.com>, Suren Baghdasaryan <surenb@google.com>,
 Mel Gorman <mgorman@suse.de>, Peter Zijlstra <peterz@infradead.org>, Andrew
 Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>,
 Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin
 <roman.gushchin@linux.dev>, Davidlohr Bueso <dave@stgolabs.net>, Matthew
 Wilcox <willy@infradead.org>, "Liam R. Howlett" <liam.howlett@oracle.com>,
 David Vernet <void@manifault.com>, Juri Lelli <juri.lelli@redhat.com>,
 Laurent Dufour <ldufour@linux.ibm.com>, Peter Xu <peterx@redhat.com>, David
 Hildenbrand <david@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 mcgrof@kernel.org, masahiroy@kernel.org, nathan@kernel.org,
 changbin.du@intel.com, ytcoode@gmail.com, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Benjamin Segall <bsegall@google.com>, Daniel Bristot de Oliveira
 <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>, Christopher
 Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, Joonsoo Kim
 <iamjoonsoo.kim@lge.com>, 42.hyeyoo@gmail.com, Alexander Potapenko
 <glider@google.com>, Marco Elver <elver@google.com>, Dmitry Vyukov
 <dvyukov@google.com>, Shakeel Butt <shakeelb@google.com>, Muchun Song
 <songmuchun@bytedance.com>, arnd@arndb.de, jbaron@akamai.com, David
 Rientjes <rientjes@google.com>, Minchan Kim <minchan@google.com>, Kalesh
 Singh <kaleshsingh@google.com>, kernel-team <kernel-team@android.com>,
 linux-mm <linux-mm@kvack.org>, iommu@lists.linux.dev,
 kasan-dev@googlegroups.com, io-uring@vger.kernel.org,
 linux-arch@vger.kernel.org, xen-devel@lists.xenproject.org,
 linux-bcache@vger.kernel.org, linux-modules@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 00/30] Code tagging framework and applications
Message-ID: <20220907094306.3383dac2@gandalf.local.home>
In-Reply-To: <20220907130323.rwycrntnckc6h43n@kmo-framework>
References: <YxBc1xuGbB36f8zC@dhcp22.suse.cz>
	<CAJuCfpGhwPFYdkOLjwwD4ra9JxPqq1T5d1jd41Jy3LJnVnhNdg@mail.gmail.com>
	<YxEE1vOwRPdzKxoq@dhcp22.suse.cz>
	<CAJuCfpHuzJGTA_-m0Jfawc7LgJLt4GztUUY4K9N9-7bFqJuXnw@mail.gmail.com>
	<20220901201502.sn6223bayzwferxv@moria.home.lan>
	<YxW4Ig338d2vQAz3@dhcp22.suse.cz>
	<20220905234649.525vorzx27ybypsn@kmo-framework>
	<Yxb1cxDSyte1Ut/F@dhcp22.suse.cz>
	<20220906182058.iijmpzu4rtxowy37@kmo-framework>
	<Yxh5ueDTAOcwEmCQ@dhcp22.suse.cz>
	<20220907130323.rwycrntnckc6h43n@kmo-framework>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 7 Sep 2022 09:04:28 -0400
Kent Overstreet <kent.overstreet@linux.dev> wrote:

> On Wed, Sep 07, 2022 at 01:00:09PM +0200, Michal Hocko wrote:
> > Hmm, it seems that further discussion doesn't really make much sense
> > here. I know how to use my time better.  
> 
> Just a thought, but I generally find it more productive to propose ideas than to
> just be disparaging.
> 

But it's not Michal's job to do so. He's just telling you that the given
feature is not worth the burden. He's telling you the issues that he has
with the patch set. It's the submitter's job to address those concerns and
not the maintainer's to tell you how to make it better.

When Linus tells us that a submission is crap, we don't ask him how to make
it less crap, we listen to why he called it crap, and then rewrite to be
not so crappy. If we cannot figure it out, it doesn't get in.

-- Steve
