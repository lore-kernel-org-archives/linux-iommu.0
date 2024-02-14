Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E7E13DBAF
	for <iommu@lists.linux.dev>; Wed, 14 Feb 2024 20:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707941875; cv=none; b=Ft6mQQjybmqsoyEXBiFwIcA4hdUYY7AaFCMvKmwxhnT5KQEjaI3iLNHGERBA24YbD8oHIxz7/1r+Qx8MM6YIREBuuJgWi/wwhOqdornTT02KmEJiBUh9TswTVnAujvkmRxCAcVfSoTb3Ovn/++q3Z6TyoEfuovmRQs7WQCvwmSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707941875; c=relaxed/simple;
	bh=LRwkqgTwbjojrvWlVJdTvGNtTmKNlI/lqhoWnlH86aU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pwABqscJGL3ui//2Rso6Nq2yZtNjD2qJeZBD2eXV3MUthwHplO58hnC3OANkmbCoV4Mxpr6jBdQg7QtIcUiy/Ad4G+rHKsRuTjDDjGiFX6DrcsR9SItxkdu5lNxF2NrK+P2YTf0QF+XSBoOAL5AinbnIP4PY8dmuJLsp5opdvGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=etar8qvb; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="etar8qvb"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-607b3038b3fso2170207b3.2
        for <iommu@lists.linux.dev>; Wed, 14 Feb 2024 12:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707941872; x=1708546672; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DFRgEJKqx8IUK/onZJk4TNjtYloWEJQ2VMeYiwjP0ZI=;
        b=etar8qvboe1SHCl2OCTMVoHcUgXV3Biv2PQJtFs6HYiZgQi2oop1ivK9pFM20EXgNW
         y1cw532Yah2E+6zBGOVaa/YOyuAwpqlfFUmA1IKj28J15CXjhc977XKatVSXepmzCJsi
         USx1kuTV/4Oo4zWjhEWfwzKEar7xqsRy6nJdzvMYaD467hs+UHL2SZCaPd4UExQfaVI/
         Kl7bfa6R0pfd35uEHQf/8dsBA57LkeV4SEcl6eXvd6Z1TMDkRfFP/OVMvPcTqkFKFkG5
         tyk3c6A/PAF0gqne7pmgDHD3gqjevkUXEFsayToe8Bs7dsGTqPO/8ALBLgbqYslU21TD
         gzfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707941872; x=1708546672;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DFRgEJKqx8IUK/onZJk4TNjtYloWEJQ2VMeYiwjP0ZI=;
        b=jV5MDKF0zP0TMKLIuer8AIYBjffDXzLdRn9+1ApvijXd/JWarRTKYNHIoKCRPIn0l6
         8SusdLbSYqOyh6USfdVvpK4IVVlx1/VcepYbcVHL0ts5eO0Zy9s+ejfKu6ch3z8CDF5f
         ybROoBQNO1IFB3gRW2WNYfFuDRL46BV5lvqJB5dKCNHMBghBzbvFlT3E3c/n64lZHZyv
         FjU/mTCfdzAN18pQEpgRp5TClB2+YGSbMsTTmXH7tdxlfLJ9Q/eDWLk/I7DBCr0WznK/
         98HVwYhiavRgu1PW4TI3MRBjFBPHT6Ak1Btbv3LqVSNs9KAVNjCyDCTgD8RZE4Q2M4Ac
         26bg==
X-Forwarded-Encrypted: i=1; AJvYcCXWWgSORl/9w3bdFeinJndQHcdjMIKX14vZy25kGCVnWd661cVFmVAhZO5UyeRHLdkt5Kzly3T6g3EUY4NedRnRYW2WM40=
X-Gm-Message-State: AOJu0YzvtCzgKq9KTa9C6dKGqKtMgD/+oPKlLSWmUPENvJm5h0HSuuT4
	al5rjIIL/XkMSUGptsy3xEx07y3SYtDqF7Av1MNgwfYePsCqQM59tzRyhtA7rAOWqJ/voT+tbVn
	iHx/g2acsbLqoWnWXOw==
X-Google-Smtp-Source: AGHT+IEEh8/ECloTKF61F6HKam49RgeIZc46jcrBkT8h5W2oQ9+AR1Ak+1Ihvk+tliAKuf+Xfoj/5sdOnEOLcBzz
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a0d:eac3:0:b0:5ff:b07b:fb83 with SMTP
 id t186-20020a0deac3000000b005ffb07bfb83mr555354ywe.4.1707941872610; Wed, 14
 Feb 2024 12:17:52 -0800 (PST)
Date: Wed, 14 Feb 2024 20:17:50 +0000
In-Reply-To: <CAJuCfpGnnsMFu-2i6-d=n1N89Z3cByN4N1txpTv+vcWSBrC2eg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240212213922.783301-1-surenb@google.com> <4f24986587b53be3f9ece187a3105774eb27c12f.camel@linux.intel.com>
 <CAJuCfpGnnsMFu-2i6-d=n1N89Z3cByN4N1txpTv+vcWSBrC2eg@mail.gmail.com>
Message-ID: <Zc0f7u5yCq-Iwh3A@google.com>
Subject: Re: [PATCH v3 00/35] Memory allocation profiling
From: Yosry Ahmed <yosryahmed@google.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>, akpm@linux-foundation.org, 
	kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	corbet@lwn.net, void@manifault.com, peterz@infradead.org, 
	juri.lelli@redhat.com, catalin.marinas@arm.com, will@kernel.org, 
	arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com, 
	yuzhao@google.com, dhowells@redhat.com, hughd@google.com, 
	andreyknvl@gmail.com, keescook@chromium.org, ndesaulniers@google.com, 
	vvvvvv@google.com, gregkh@linuxfoundation.org, ebiggers@google.com, 
	ytcoode@gmail.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com, 
	vschneid@redhat.com, cl@linux.com, penberg@kernel.org, iamjoonsoo.kim@lge.com, 
	42.hyeyoo@gmail.com, glider@google.com, elver@google.com, dvyukov@google.com, 
	shakeelb@google.com, songmuchun@bytedance.com, jbaron@akamai.com, 
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com, 
	kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

> > > Performance overhead:
> > > To evaluate performance we implemented an in-kernel test executing
> > > multiple get_free_page/free_page and kmalloc/kfree calls with allocation
> > > sizes growing from 8 to 240 bytes with CPU frequency set to max and CPU
> > > affinity set to a specific CPU to minimize the noise. Below are results
> > > from running the test on Ubuntu 22.04.2 LTS with 6.8.0-rc1 kernel on
> > > 56 core Intel Xeon:
> > >
> > >                         kmalloc                 pgalloc
> > > (1 baseline)            6.764s                  16.902s
> > > (2 default disabled)    6.793s (+0.43%)         17.007s (+0.62%)
> > > (3 default enabled)     7.197s (+6.40%)         23.666s (+40.02%)
> > > (4 runtime enabled)     7.405s (+9.48%)         23.901s (+41.41%)
> > > (5 memcg)               13.388s (+97.94%)       48.460s (+186.71%)
> 
> (6 default disabled+memcg)    13.332s (+97.10%)         48.105s (+184.61%)
> (7 default enabled+memcg)     13.446s (+98.78%)       54.963s (+225.18%)

I think these numbers are very interesting for folks that already use
memcg. Specifically, the difference between 6 & 7, which seems to be
~0.85% and ~14.25%. IIUC, this means that the extra overhead is
relatively much lower if someone is already using memcgs.

> 
> (6) shows a bit better performance than (5) but it's probably noise. I
> would expect them to be roughly the same. Hope this helps.
> 
> > >
> >
> >
