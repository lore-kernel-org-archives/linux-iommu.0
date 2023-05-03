Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A5AEC8
	for <iommu@lists.linux.dev>; Wed,  3 May 2023 18:40:10 +0000 (UTC)
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-51f6461af24so3841176a12.2
        for <iommu@lists.linux.dev>; Wed, 03 May 2023 11:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683139209; x=1685731209;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sQ2ADeO1XgOmj5DxbzjpzikYpUTn+B695qqaLQsTl4A=;
        b=FAsEakodIYGZZ49hzhHq8Do+4wt23WK6jVIu98FKgEcC2IC28Yv1qcpIguYdAHmL41
         K6QXYVXYY9e0ydYBW/QaYBQ4kV1sgRKD0Z8m7VqP9eoT6OyuI2TEKLTHxSnuPoZ0/P86
         Ak//1N2uQgFgtt5vHB1OZ1Yr9lZGqpMPiXmn0PLHivzD9gD6C3pgBiZeck/EvcUad+D9
         AIqIEi6ySYiJEa/rjzcr1BnwS0cO5uVLCgZHYd00/2Qp62J0+g0bDyAUjzMrqC8es9RR
         PvNP8hKoKyN1VyTkZlWwEOSIbNVu+bisxPnpdL40o9ZuYAjxbUCiGJrKy44Q/i6wCbvS
         6MJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683139209; x=1685731209;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sQ2ADeO1XgOmj5DxbzjpzikYpUTn+B695qqaLQsTl4A=;
        b=OQgYKRasIaG7g2yiz45sqOie8iBnszCBWezuKkbFQm2NEOSO6DcbtEjk84JxAlAvbI
         OinRO8F2qtSuaNVNvMjXJZfI8veqxztIWpw5M9Z4y7LxOIQiIcY9udLZGIGyuATDCTru
         uPQPfl7ynPuhzKDrhX+9konn09ZjHhDD3mnqRiCm3YEZkYvv0mLN3Lls/u2PTHUBCq2/
         4BxbjAmcieMnswvmyUZiWY6+M5t3aW1m+KzyBPbIcSkpRXAfuQiK9jYqzLhhWjwTOFsB
         tkrk/9jpNQuk7ZXpj7/OswUA+SjzRKZ/h5d/upQmVpSIoNNlZMQNP7zz5lbTl3mmYuzi
         N70A==
X-Gm-Message-State: AC+VfDw8oQ289s5alR7KOjgwCMcvP1bPRqz6tXgMIPNV4vAR+X9Y07B5
	zYOjQI2VxjI7Ibks67pcsvg=
X-Google-Smtp-Source: ACHHUZ5HrlmzzWxl9cdU7mNdLYfBeR7MIFjXh85oRNOW13gF1ERuxzszMtMYq8KFsJoY0P2G/zpWtw==
X-Received: by 2002:a05:6a20:4286:b0:dd:7661:fb34 with SMTP id o6-20020a056a20428600b000dd7661fb34mr28426673pzj.51.1683139209307;
        Wed, 03 May 2023 11:40:09 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:6454])
        by smtp.gmail.com with ESMTPSA id u22-20020a634556000000b005287b22ea8esm12540790pgk.88.2023.05.03.11.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 11:40:08 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 3 May 2023 08:40:07 -1000
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
Message-ID: <ZFKqh5Dh93UULdse@slm.duckdns.org>
References: <20230501165450.15352-1-surenb@google.com>
 <ZFIMaflxeHS3uR/A@dhcp22.suse.cz>
 <ZFIOfb6/jHwLqg6M@moria.home.lan>
 <ZFISlX+mSx4QJDK6@dhcp22.suse.cz>
 <ZFIVtB8JyKk0ddA5@moria.home.lan>
 <ZFKNZZwC8EUbOLMv@slm.duckdns.org>
 <20230503180726.GA196054@cmpxchg.org>
 <ZFKlrP7nLn93iIRf@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFKlrP7nLn93iIRf@slm.duckdns.org>

On Wed, May 03, 2023 at 08:19:24AM -1000, Tejun Heo wrote:
> > Taking a step back though, given the multitude of allocation sites in
> > the kernel, it's a bit odd that the only accounting we do is the tiny
> > fraction of voluntary vmstat/meminfo reporting. We try to cover the
> > biggest consumers with this of course, but it's always going to be
> > incomplete and is maintenance overhead too. There are on average
> > several gigabytes in unknown memory (total - known vmstats) on our
> > machines. It's difficult to detect regressions easily. And it's per
> > definition the unexpected cornercases that are the trickiest to track
> > down. So it might be doable with BPF, but it does feel like the kernel
> > should do a better job of tracking out of the box and without
> > requiring too much plumbing and somewhat fragile kernel allocation API
> > tracking and probing from userspace.
> 
> Yeah, easy / default visibility argument does make sense to me.

So, a bit of addition here. If this is the thrust, the debugfs part seems
rather redundant, right? That's trivially obtainable with tracing / bpf and
in a more flexible and performant manner. Also, are we happy with recording
just single depth for persistent tracking?

Thanks.

-- 
tejun
