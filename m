Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1942DDF67
	for <iommu@lists.linux.dev>; Wed,  3 May 2023 20:00:30 +0000 (UTC)
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-64115eef620so7568707b3a.1
        for <iommu@lists.linux.dev>; Wed, 03 May 2023 13:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683144030; x=1685736030;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0HV83qXSxt0rJsxUhYqPsLXk4a5FBTNhGHWC84tLfFA=;
        b=T5ytdzQZFR/i6X3PRt8GPpsG1Y8I62q5m+7bcocFY5Cvsi6WjKKciTo/qMildNoBZe
         u85rUJbf90oBHRO2tw11PhVl1/2+PBLQR5fvlp3hzuHC/CfV94InI4lPsLH/RfX1qbI8
         ausoXPd6AA+d24SrubrUATq5ZGbTkNJHhzAmb4/I8cKntvdRB5ITs5umOnT9xtLYVW6J
         XelWqPKoBht+a4RuNCfbFoX3W+hTDToV7mxgM9rNIWkoPMCAeRQG8Dr+8MzArcAuR1Md
         bQM+fnzNC44jQ5pJFy8Oos8cJXJygO15rVG3lH4kT1O7gkNi5v7N3Otc1cZyartcRwPg
         eT9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683144030; x=1685736030;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0HV83qXSxt0rJsxUhYqPsLXk4a5FBTNhGHWC84tLfFA=;
        b=P8SsK6sT5+KtQJbdSbHaf3rygQEOPOLySEDDLGgqogAlgRij8VHagjHbNs/SVS2e3P
         Rqr3jGvk4aDD1/WVnDWpNSV4GZFD3LuuvfxAzWN3eD6aj/IwHh3CcuDOcaqRkIE4SD1q
         5UHg3lea+A5DXIZ/JcGNa5c/uKaSM4jA9H1+yGntpLVsXkVyOAqBFQF5JcfNt0OecNCz
         2BMBoSKrA2ksck9xngEO4t/doMTAdL8pzKbIG6U/cfnvlg7M6niUinXbenGZkTYWLwpQ
         4ttf8/ZkCB5J7cSqtzhfmYBj5hEk2CcqFoAI4+GDG/ERw0ofL8YKUrkm0ohHlojkwmzM
         AEmA==
X-Gm-Message-State: AC+VfDx4MjY73szVSa6lAScnznZwgg6ii7nnmXaa41i9JZdUkwzZZYQk
	+9ex0hUnnL/VYZCIU0TUwLE=
X-Google-Smtp-Source: ACHHUZ5olDzdTm5Ey2E+MQulD+SLoYUhuLqQV+Y8D7lSbEkzX4uIXZlIewj6XWYcqZ1z8grZ/iYmXg==
X-Received: by 2002:a05:6a20:1587:b0:f6:592a:7e3d with SMTP id h7-20020a056a20158700b000f6592a7e3dmr3740358pzj.7.1683144030189;
        Wed, 03 May 2023 13:00:30 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:6454])
        by smtp.gmail.com with ESMTPSA id w22-20020a63f516000000b0052873a7cecesm3042624pgh.0.2023.05.03.13.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 13:00:29 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 3 May 2023 10:00:28 -1000
From: Tejun Heo <tj@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@suse.com>, akpm@linux-foundation.org,
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
Message-ID: <ZFK9XMSzOBxIFOHm@slm.duckdns.org>
References: <ZFIVtB8JyKk0ddA5@moria.home.lan>
 <ZFKNZZwC8EUbOLMv@slm.duckdns.org>
 <20230503180726.GA196054@cmpxchg.org>
 <ZFKlrP7nLn93iIRf@slm.duckdns.org>
 <ZFKqh5Dh93UULdse@slm.duckdns.org>
 <ZFKubD/lq7oB4svV@moria.home.lan>
 <ZFKu6zWA00AzArMF@slm.duckdns.org>
 <ZFKxcfqkUQ60zBB_@slm.duckdns.org>
 <CAJuCfpEPkCJZO2svT-GfmpJ+V-jSLyFDKM_atnqPVRBKtzgtnQ@mail.gmail.com>
 <ZFK6pwOelIlhV8Bm@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFK6pwOelIlhV8Bm@slm.duckdns.org>

Hello,

On Wed, May 03, 2023 at 09:48:55AM -1000, Tejun Heo wrote:
> > If so, that's the idea behind the context capture feature so that we
> > can enable it on specific allocations only after we determine there is
> > something interesting there. So, with low-cost persistent tracking we
> > can determine the suspects and then pay some more to investigate those
> > suspects in more detail.
> 
> Yeah, I was wondering whether it'd be useful to have that configurable so
> that it'd be possible for a user to say "I'm okay with the cost, please
> track more context per allocation". Given that tracking the immediate caller
> is already a huge improvement and narrowing it down from there using
> existing tools shouldn't be that difficult, I don't think this is a blocker
> in any way. It just bothers me a bit that the code is structured so that
> source line is the main abstraction.

Another related question. So, the reason for macro'ing stuff is needed is
because you want to print the line directly from kernel, right? Is that
really necessary? Values from __builtin_return_address() can easily be
printed out as function+offset from kernel which already gives most of the
necessary information for triaging and mapping that back to source line from
userspace isn't difficult. Wouldn't using __builtin_return_address() make
the whole thing a lot simpler?

Thanks.

-- 
tejun
