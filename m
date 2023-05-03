Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802E42103
	for <iommu@lists.linux.dev>; Wed,  3 May 2023 18:06:13 +0000 (UTC)
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-52867360efcso3692474a12.2
        for <iommu@lists.linux.dev>; Wed, 03 May 2023 11:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683137173; x=1685729173;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4cv7r3p/uGjVZzfVGJD3+oUJmj97nEyjDPWByIKN3z4=;
        b=kBIOUh53OZR1fn3Tl9vhMiJMS2FInFLP+lUhlPMor7jTDMLunrtCSmTdzMWMH2FwCJ
         YVGqfGBLCcFxyEZqWGvgdtkqh7q9mW9TITc2zQ1MEl9Z4dyRAIRBQgQ/GqXqe64yJJJD
         jtv1N2E+Q8wb/Xz4JW2RS+0z2DdUghhXRvmD4NcDBMi7YahwOEPgg0vNKS60VKG0vC0s
         rVXB8P21/jbXTCpjmQQRTHqlVfjdnNcak2Qa/aW6mlFKobaN4n+shXYE6Y3F+F5hgEAG
         f9bKyMjVy+ACvR4cf5kNhW2+TZwy4NkBNj9YXF9ja+6/87G38J+6YdFn2/3Ki55ZW1Z2
         6s2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683137173; x=1685729173;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4cv7r3p/uGjVZzfVGJD3+oUJmj97nEyjDPWByIKN3z4=;
        b=engtF97pP2817YXtZHAuShWFmllsOTxwcvHGMM8+9+pO+wVBBAIKsHR6QBRSVETU3R
         lAUH7vhhizmSv06dS7oks0yfV7IPKarRcVHTe/SBUK/+Gjks+3V7SEv054UfPjskI9O/
         fPXaCEMZou7VzyIZ7Ka5KuVD481wwO0rcSWbgC8jl1u8RMzQZc8+b0Y1++KQurLtN0uW
         EMxUQIcai7KOLz12vPK2PhiWzxAHcnbpNhliw27MAiRCY4PMK8YGu8vF1dmB+I4tbYYk
         +LKspeYLnopUdJoVSXzcSCjDBSznYjLcXhSkSLf5sq7H5rB8a+qKr+UqR+RvowUiuCPD
         Krtw==
X-Gm-Message-State: AC+VfDwWThbFMZjdT/u7jtcCnFYdLEbHOCnk23SM3oJkO6gJaduYqWs3
	O26rLRXzy3TKKsxyfUa/lO4=
X-Google-Smtp-Source: ACHHUZ6Ys0BQM8tQyYEoKSFpV2WCvnyoLhkkNSy/RU10JosALh+3fJA0w6WaI2GGSjVNqyUuFYx0fQ==
X-Received: by 2002:a17:90a:850a:b0:24e:1f8:b786 with SMTP id l10-20020a17090a850a00b0024e01f8b786mr11008096pjn.19.1683137172717;
        Wed, 03 May 2023 11:06:12 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:6454])
        by smtp.gmail.com with ESMTPSA id g4-20020a1709026b4400b001a183ade911sm21931204plt.56.2023.05.03.11.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 11:06:12 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 3 May 2023 08:06:10 -1000
From: Tejun Heo <tj@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Michal Hocko <mhocko@suse.com>, akpm@linux-foundation.org,
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev,
	mgorman@suse.de, dave@stgolabs.net, willy@infradead.org,
	liam.howlett@oracle.com, corbet@lwn.net, void@manifault.com,
	peterz@infradead.org, juri.lelli@redhat.com, ldufour@linux.ibm.com,
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
Message-ID: <ZFKikp0Poqen1kNv@slm.duckdns.org>
References: <20230501165450.15352-1-surenb@google.com>
 <ZFIMaflxeHS3uR/A@dhcp22.suse.cz>
 <ZFIOfb6/jHwLqg6M@moria.home.lan>
 <ZFISlX+mSx4QJDK6@dhcp22.suse.cz>
 <ZFIVtB8JyKk0ddA5@moria.home.lan>
 <ZFKNZZwC8EUbOLMv@slm.duckdns.org>
 <CAJuCfpEFV7ZB4pvnf6n0bVpTCDWCVQup9PtrHuAayrf3GrQskg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpEFV7ZB4pvnf6n0bVpTCDWCVQup9PtrHuAayrf3GrQskg@mail.gmail.com>

Hello, Suren.

On Wed, May 03, 2023 at 10:42:11AM -0700, Suren Baghdasaryan wrote:
> > * The framework doesn't really have any runtime overhead, so we can have it
> >   deployed in the entire fleet and debug wherever problem is.
> 
> Do you mean it has no runtime overhead when disabled?

Yes, that's what I meant.

> If so, do you know what's the overhead when enabled? I want to
> understand if that's truly a viable solution to track all allocations
> (including slab) all the time.

(cc'ing Alexei and Andrii who know a lot better than me)

I don't have enough concrete benchmark data on the hand to answer
definitively but hopefully what my general impresison would help. We attach
BPF programs to both per-packet and per-IO paths. They obviously aren't free
but their overhead isn't signficantly higher than building in the same thing
in C code. Once loaded, BPF progs are jit compiled into native code. The
generated code will be a bit worse than regularly compiled C code but those
are really micro differences. There's some bridging code to jump into BPF
but again negligible / acceptable even in the hottest paths.

In terms of execution overhead, I don't think there is a signficant
disadvantage to doing these things in BPF. Bigger differences would likely
be in tracking data structures and locking around them. One can definitely
better integrate tracking into alloc / free paths piggybacking on existing
locking and whatnot. That said, BPF hashtable is pretty fast and BPF is
constantly improving in terms of data structure support.

It really depends on the workload and how much overhead one considers
acceptable and I'm sure persistent global tracking can be done more
efficiently with built-in C code. That said, done right, the overhead
difference most likely isn't gonna be orders of magnitude but more like in
the realm of tens of percents, if that.

So, it doesn't nullify the benefits a dedicated mechansim can bring but does
change the conversation quite a bit. Is the extra code justifiable given
that most of what it enables is already possible using a more generic
mechanism, albeit at a bit higher cost? That may well be the case but it
does raise the bar.

Thanks.

-- 
tejun
