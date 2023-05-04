Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B9D7E
	for <iommu@lists.linux.dev>; Thu,  4 May 2023 02:25:34 +0000 (UTC)
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-52c6f81193cso899571a12.1
        for <iommu@lists.linux.dev>; Wed, 03 May 2023 19:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683167134; x=1685759134;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X+UY7cUQaVo4x4W0WCSPsCuWeI5BUJEgh7i3Xst55/Y=;
        b=Rp/D+oug52h2Ti6mXmuImpIIDf60HeMLUvF0iIK2vttPwspm5hYlNosuEHVSrbtxTw
         U1aaOkS4o4kHX9lqnCC9bE9Qv4BkTepdXgX1eP7e7ih03h1Znb/fBHAFzIs3ZLAdzyf8
         Bdy+N5QGo07p0OmImH8mBW0eWTxAwcVTxazuYtPxC6BmtMp0/XcbyFMmmZorx8qew2E9
         Ccf9SafoTVOkRODhvQ6MQpCKPYkFE27/aFmb6+IC+s7J6n+xuSEgUyUsQVp7VEWj1Bkv
         v88EEfrZMkPXlnUNcgeQfwXyllZK7EU5nBpftptzpU3ovg2Ugby7Q+WZX0I3unGEo1Nj
         E0SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683167134; x=1685759134;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X+UY7cUQaVo4x4W0WCSPsCuWeI5BUJEgh7i3Xst55/Y=;
        b=gembcDxVstwZnYF5+Uv7J8uWXq0hOg6dojgDsGzbQ3iOjbH1TeqsKyqNXp7j04s3Jo
         wlN0pSu5FQJZyFj5PyO0RH4i26M2VfA6lMUYeX/dS5Ch2P6gpYiAqv9b/hCKGvHzSjse
         9dcmWcT+JXP50lRgrlFzCcwjNDXR4J/QUnk+eOu3arca3RcPcQc1v0FZ+/UUAD8z6fU0
         fgoLnveLzqltvvki8FBMo+vKEaOrYR7uer/+RUUqOm1QPDPnxOzqUqL4lGYQsJG9a1PN
         LLJEIPA5Sa5nbwp4LhfTNY9HPg3rOb61lYsHu6ssN1jzCofKbysxr27ek1b4xZQhnejl
         rtSQ==
X-Gm-Message-State: AC+VfDx9Z7ezFf7MRKvXy5zw1pEAMTN0I2LfWiMxL7fvlWoJP2Z5WtYj
	0bKIo/9VUQJ7eDOqpKQoXaI=
X-Google-Smtp-Source: ACHHUZ50+OLepUnrnAHDGfxFP5Am44d3DN07c8wNpuEHGpwvY2J63vbecqy2vRXUZik9ScPzDJ5gvw==
X-Received: by 2002:a17:902:c94e:b0:1ab:2758:c8a4 with SMTP id i14-20020a170902c94e00b001ab2758c8a4mr2512871pla.0.1683167133231;
        Wed, 03 May 2023 19:25:33 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:6454])
        by smtp.gmail.com with ESMTPSA id w4-20020a170902d70400b0019ac7319ed1sm2987721ply.126.2023.05.03.19.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 19:25:32 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 3 May 2023 16:25:30 -1000
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
Message-ID: <ZFMXmj9ZhSe5wyaS@slm.duckdns.org>
References: <20230503180726.GA196054@cmpxchg.org>
 <ZFKlrP7nLn93iIRf@slm.duckdns.org>
 <ZFKqh5Dh93UULdse@slm.duckdns.org>
 <ZFKubD/lq7oB4svV@moria.home.lan>
 <ZFKu6zWA00AzArMF@slm.duckdns.org>
 <ZFKxcfqkUQ60zBB_@slm.duckdns.org>
 <CAJuCfpEPkCJZO2svT-GfmpJ+V-jSLyFDKM_atnqPVRBKtzgtnQ@mail.gmail.com>
 <ZFK6pwOelIlhV8Bm@slm.duckdns.org>
 <ZFK9XMSzOBxIFOHm@slm.duckdns.org>
 <CAJuCfpE4YD_BumqFf2-NC8KS9D+kq0s_o4gRyWAH-WK4SgqUbA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpE4YD_BumqFf2-NC8KS9D+kq0s_o4gRyWAH-WK4SgqUbA@mail.gmail.com>

Hello,

On Wed, May 03, 2023 at 01:14:57PM -0700, Suren Baghdasaryan wrote:
> On Wed, May 3, 2023 at 1:00 PM Tejun Heo <tj@kernel.org> wrote:
> > Another related question. So, the reason for macro'ing stuff is needed is
> > because you want to print the line directly from kernel, right?
> 
> The main reason is because we want to inject a code tag at the
> location of the call. If we have a code tag injected at every
> allocation call, then finding the allocation counter (code tag) to
> operate takes no time.
>
> > Is that
> > really necessary? Values from __builtin_return_address() can easily be
> > printed out as function+offset from kernel which already gives most of the
> > necessary information for triaging and mapping that back to source line from
> > userspace isn't difficult. Wouldn't using __builtin_return_address() make
> > the whole thing a lot simpler?
> 
> If we do that we have to associate that address with the allocation
> counter at runtime on the first allocation and look it up on all
> following allocations. That introduces the overhead which we are
> trying to avoid by using macros.

I see. I'm a bit skeptical about the performance angle given that the hot
path can be probably made really cheap even with lookups. In most cases,
it's just gonna be an extra pointer deref and a few more arithmetics. That
can show up in microbenchmarks but it's not gonna be much. The benefit of
going that route would be the tracking thing being mostly self contained.

That said, it's nice to not have to worry about allocating tracking slots
and managing hash table, so no strong opinion.

Thanks.

-- 
tejun
