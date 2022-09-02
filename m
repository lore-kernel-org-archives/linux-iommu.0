Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC557E
	for <iommu@lists.linux.dev>; Fri,  2 Sep 2022 00:24:52 +0000 (UTC)
Received: by mail-yb1-f177.google.com with SMTP id 193so1035592ybc.10
        for <iommu@lists.linux.dev>; Thu, 01 Sep 2022 17:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=/pPOPbPw8AnpH29BUzSqTrm5ZvDmaEgEyFxuBQlNiEg=;
        b=JFydOg9QoPX5QvCMFfTX+qzkxy7dX+yug3qLsycd8X5fIiKliNhG2sOdd7n2FZxg0x
         wlIQ0PSe2w+jF1eYJALDSn9VwIQg7e+fojjEXzmIOWtowrPcZ8vVaDgvGlc5viuLzbLq
         BuWwUYh3dJTjnuDVzKYwlUlnzQN1dlqhuf8e4UUJj0Gz3yVOw7ZhtZlACThcN+JogWbQ
         XLiaLX50zBOT8vT4sikyfQhvA5G9n7Ys1zkULvj3Bu6V7OPgO3m2SYNlgkEGLVgRXA6S
         YaT8WKnNiPs7HVTvCKPZfxYMJ9fk0eCfVfQjSQqADIJwkH1wr6+8aSYndPr9n1G1vqpS
         RvLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=/pPOPbPw8AnpH29BUzSqTrm5ZvDmaEgEyFxuBQlNiEg=;
        b=RTO1lt+tEcinLiUdTVxJqSRMFD1ZmRJZIXSErTccm/GVNegsLLSao4hMHNwLesDZXz
         ecL3Bi1mmFPJo5ZUydXrJeXX2oK4lt+uAvYPhH90qDQ1fH3pmwpKKN2BSIkjeOK81yJR
         kUSYT+nNz15weEn3X5XtI1ryMir8XcrtKe+ppBxZnKTb2EjJLgnSmz/v9p+CeXgmaAnx
         qZibeyEVyohpImNXebfA+L5bE3dvn/mAh36WeOenN9hmHF6aKouR2aOTU0zZ82DjwZ5c
         StfQy2Ws3DpRrVkhpCCkDNl5rr6JqQStDtkXG6m9XwxAhv7zMsgRk37x8wd4N1NaThp0
         rP0A==
X-Gm-Message-State: ACgBeo0+kGz6DHstzZ93dDeUK+9726cqcVh5ifY+wZUYG0V0gsGkTuL3
	LhWtNl7fCC5EcXN1PytgxUS5Tjb55AjodPjUxJPdMw==
X-Google-Smtp-Source: AA6agR5/Ulv2F+QXTz0x1dcq0Ynnhj3rjvCeoD8VrxwV966KDu/pwW+2XwncQnNg3JY46QNFp+MHM1SP5XYuAvh7JKU=
X-Received: by 2002:a05:6902:705:b0:695:b3b9:41bc with SMTP id
 k5-20020a056902070500b00695b3b941bcmr21283555ybt.426.1662078291363; Thu, 01
 Sep 2022 17:24:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220830214919.53220-1-surenb@google.com> <20220830214919.53220-15-surenb@google.com>
 <YxFC9NSQ7OADTEwp@P9FQF9L96D.corp.robot.car>
In-Reply-To: <YxFC9NSQ7OADTEwp@P9FQF9L96D.corp.robot.car>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 1 Sep 2022 17:24:40 -0700
Message-ID: <CAJuCfpGRL72qghDf9bNsp_K0kabvLBs5ags2hHXn-5_Ar8RX5A@mail.gmail.com>
Subject: Re: [RFC PATCH 14/30] mm: prevent slabobj_ext allocations for
 slabobj_ext and kmem_cache objects
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>, Johannes Weiner <hannes@cmpxchg.org>, 
	Mel Gorman <mgorman@suse.de>, Davidlohr Bueso <dave@stgolabs.net>, 
	Matthew Wilcox <willy@infradead.org>, "Liam R. Howlett" <liam.howlett@oracle.com>, 
	David Vernet <void@manifault.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Laurent Dufour <ldufour@linux.ibm.com>, 
	Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
	mcgrof@kernel.org, masahiroy@kernel.org, nathan@kernel.org, 
	changbin.du@intel.com, ytcoode@gmail.com, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Benjamin Segall <bsegall@google.com>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>, 
	Christopher Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
	42.hyeyoo@gmail.com, Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Shakeel Butt <shakeelb@google.com>, 
	Muchun Song <songmuchun@bytedance.com>, arnd@arndb.de, jbaron@akamai.com, 
	David Rientjes <rientjes@google.com>, Minchan Kim <minchan@google.com>, 
	Kalesh Singh <kaleshsingh@google.com>, kernel-team <kernel-team@android.com>, 
	linux-mm <linux-mm@kvack.org>, iommu@lists.linux.dev, kasan-dev@googlegroups.com, 
	io-uring@vger.kernel.org, linux-arch@vger.kernel.org, 
	xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org, 
	linux-modules@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, Sep 1, 2022 at 4:41 PM Roman Gushchin <roman.gushchin@linux.dev> wrote:
>
> On Tue, Aug 30, 2022 at 02:49:03PM -0700, Suren Baghdasaryan wrote:
> > Use __GFP_NO_OBJ_EXT to prevent recursions when allocating slabobj_ext
> > objects. Also prevent slabobj_ext allocations for kmem_cache objects.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>
> Patches 12-14 look good to me.
> It's probably to early to ack anything, but otherwise I'd ack them.

Thank you for reviewing!

>
> Thanks!
