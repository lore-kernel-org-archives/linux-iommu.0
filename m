Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BE010A31
	for <iommu@lists.linux.dev>; Wed, 14 Feb 2024 06:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707891629; cv=none; b=HDtg/LN4/Yy/bh+XCnsLSlMC82SYzAvK2Ps3q0jtvT6cEYtFUAHV/pUmBgWsQcF+KhQGEbsYqLoN6Qy1lHLLotGspciooNtW39+XW6urJgoRLUa4m6TRJrNyI4y2/6zSFSFwonfUe87Xeia2eoXfWcRDPD2re0EhucA9vvZr9JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707891629; c=relaxed/simple;
	bh=mPZvfWNgR9UvijIIJJg1XLOXvrF3xKs/y4S11I2T7Mc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PPrk01opNk85xyZ0cHEqMFxkOnpWevPdMJfdvO/pLJzO8JEOnHTXKTTk7jlTivsAGLnTR0ZZ8mFpHRfHOiVfmCNJi6WKzAnyRR8zgEnODTLTAK9AuUaEoMplugWqNDwZ6boaSOAkmMFv+flKq5Zc+0HF4UyK+wkySHWAzczP9Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=J6yjyEWk; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="J6yjyEWk"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-42a8a3973c5so26129131cf.2
        for <iommu@lists.linux.dev>; Tue, 13 Feb 2024 22:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1707891626; x=1708496426; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mPZvfWNgR9UvijIIJJg1XLOXvrF3xKs/y4S11I2T7Mc=;
        b=J6yjyEWkhetPz6G1vL/e50iZRBcg+omKgWxdlRZND2CCHcEerW8haAUhyix0o1BJYi
         90EPxsTbIV9XWu6loT77m1c8J9uxY79iu/hAnqh9kW34fCnt+O/d8Bic5RfhL27qH9U8
         nfTm5+ke106p23dKNFHdzfzuzGECi2tb8ip+y7+Omwt7+qmqDbEQbmE9jENfh0Z9jOX1
         QBKf9FCuE9VspeIbRCaJ2pOyTPISTWFMtgyYXRGpywpPteCGKYCqYJq3xXeBHcA+afpm
         TNEzKBgp8DpASu+iT0VHNPvDr0/5jKKxoeVNODONtEoFIGgFD0VTRUHfdWXttX1ewtbC
         KOIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707891626; x=1708496426;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mPZvfWNgR9UvijIIJJg1XLOXvrF3xKs/y4S11I2T7Mc=;
        b=Yq9OhfDQgflqW8xBQU0x48G9wj0cGVNoO09zh3niPw4LfYFI1mPukUui+P3COOBuoa
         shl+7pCT5Gxj0gkE86Eoc0H7SGEjkMSi+NXJ1ar4EmuqGOB6gcjXHBQo6cLvxlxOBUBg
         uxW1VPNYTaQXnjOBoiBrYmYCUZksC7lK7BCctep/Bf47Uh2BhE0G7FcyGVmNVvUjokb3
         JV/e8gzrmo1B6T/iPGF0HqX1oMaBHOr6ZVBON1v/m+luYcJBhgIQaizATUntiCUSVquf
         azGbai6hhszht+3Upx5Yji6j5WA47/Zp0S66Ks9q2QqJwmGkvCpkMttejk2GphQvTNMp
         Y5rw==
X-Forwarded-Encrypted: i=1; AJvYcCWNVNM1e1G+HnAg0dnHdcpaAA8NfX6uGfYtMvXDa/N/AfB8WXKFQscQyXywSUFeeERxz1OGL+qFRKZvCRuYauL62z88iIE=
X-Gm-Message-State: AOJu0YzR4nJ1FGaA+4/LMW5MwKydgYseENGIoos1NCTdU5gflCCmhmVi
	ehmsqAX9SHF2kgdfeR97C02i6bqurNrzbrj1FlZO5fHW6A/TljWmfKoSLsKLPgQ=
X-Google-Smtp-Source: AGHT+IFnioDUv96AzhWE99fGuZ2JnAOUfdgv/2QX4e5KUyJeUPqxV+8qOH1R7pvVEl8yrhK7A4y3Cw==
X-Received: by 2002:a05:622a:1045:b0:42c:70a8:1b3f with SMTP id f5-20020a05622a104500b0042c70a81b3fmr1875328qte.7.1707891626471;
        Tue, 13 Feb 2024 22:20:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; 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
Received: from localhost ([2620:10d:c091:400::5:6326])
        by smtp.gmail.com with ESMTPSA id l13-20020ac8078d000000b0042c613a5cf3sm1755053qth.33.2024.02.13.22.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 22:20:25 -0800 (PST)
Date: Wed, 14 Feb 2024 01:20:20 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com,
	vbabka@suse.cz, roman.gushchin@linux.dev, mgorman@suse.de,
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
	corbet@lwn.net, void@manifault.com, peterz@infradead.org,
	juri.lelli@redhat.com, catalin.marinas@arm.com, will@kernel.org,
	arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com,
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org,
	masahiroy@kernel.org, nathan@kernel.org, dennis@kernel.org,
	tj@kernel.org, muchun.song@linux.dev, rppt@kernel.org,
	paulmck@kernel.org, pasha.tatashin@soleen.com,
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com,
	hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org,
	ndesaulniers@google.com, vvvvvv@google.com,
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
	cgroups@vger.kernel.org
Subject: Re: [PATCH v3 00/35] Memory allocation profiling
Message-ID: <20240214062020.GA989328@cmpxchg.org>
References: <20240212213922.783301-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212213922.783301-1-surenb@google.com>

I'll do a more throrough code review, but before the discussion gets
too sidetracked, I wanted to add my POV on the overall merit of the
direction that is being proposed here.

I have backported and used this code for debugging production issues
before. Logging into a random host with an unfamiliar workload and
being able to get a reliable, comprehensive list of kernel memory
consumers is one of the coolest things I have seen in a long
time. This is a huge improvement to sysadmin quality of life.

It's also a huge improvement for MM developers. We're the first points
of contact for memory regressions that can be caused by pretty much
any driver or subsystem in the kernel.

I encourage anybody who is undecided on whether this is worth doing to
build a kernel with these patches applied and run it on their own
machine. I think you'll be surprised what you'll find - and how myopic
and uninformative /proc/meminfo feels in comparison to this. Did you
know there is a lot more to modern filesystems than the VFS objects we
are currently tracking? :)

Then imagine what this looks like on a production host running a
complex mix of filesystems, enterprise networking, bpf programs, gpus
and accelerators etc.

Backporting the code to a slightly older production kernel wasn't too
difficult. The instrumentation layering is explicit, clean, and fairly
centralized, so resolving minor conflicts around the _noprof renames
and the wrappers was pretty straight-forward.

When we talk about maintenance cost, a fair shake would be to weigh it
against the cost and reliability of our current method: evaluating
consumers in the kernel on a case-by-case basis and annotating the
alloc/free sites by hand; then quibbling with the MM community about
whether that consumer is indeed significant enough to warrant an entry
in /proc/meminfo, and what the catchiest name for the stat would be.

I think we can agree that this is vastly less scalable and more
burdensome than central annotations around a handful of mostly static
allocator entry points. Especially considering the rate of change in
the kernel as a whole, and that not everybody will think of the
comprehensive MM picture when writing a random driver. And I think
that's generous - we don't even have the network stack in meminfo.

So I think what we do now isn't working. In the Meta fleet, at any
given time the p50 for unaccounted kernel memory is several gigabytes
per host. The p99 is between 15% and 30% of total memory. That's a
looot of opaque resource usage we have to accept on faith.

For hunting down regressions, all it takes is one untracked consumer
in the kernel to really throw a wrench into things. It's difficult to
find in the noise with tracing, and if it's not growing after an
initial allocation spike, you're pretty much out of luck finding it at
all. Raise your hand if you've written a drgn script to walk pfns and
try to guess consumers from the state of struct page :)

I agree we should discuss how the annotations are implemented on a
technical basis, but my take is that we need something like this.

In a codebase of our size, I don't think the allocator should be
handing out memory without some basic implied tracking of where it's
going. It's a liability for production environments, and it can hide
bad memory management decisions in drivers and other subsystems for a
very long time.
