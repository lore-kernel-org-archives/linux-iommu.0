Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A44412FB1F
	for <iommu@lists.linux.dev>; Fri, 16 Feb 2024 16:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708102021; cv=none; b=QjQtLJ3+AnAPHYRE9KLXAK9VWgznKZmFUJo+S7DPUGom9YEyFO159MVstDuBtEOY210pf8anSKEHVwiFd7nCT2AY3DnRxjTzGNVa889ubtikfA7nTWn/8C/zuyBJZCQ+OwMgIghnUcTUq1x+WU7bO1zgxYqpxDJOb7ICuIX/iTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708102021; c=relaxed/simple;
	bh=/5/86K2Z1hDqoZIqP7XxaxYaiR6tJyE2BrZYnn5TkeE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OoHZ99JaaxIQNaQgnj8BIQJDwlA1B2a6WJSkNr3sCQOaGH/DId5U3yX3BlVojN3uOgRQMI3sIR4RRRxY8SCRwogtmpE3ssRS8gSvRFO+0DUE3uFnbl5WdJgyH5LFuF80bzr2GOlHYw8FfKrKkf4KHSP+96qgnbCe/CHt6+vIk58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=axbr/Jt8; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="axbr/Jt8"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dc742543119so1038217276.0
        for <iommu@lists.linux.dev>; Fri, 16 Feb 2024 08:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708102018; x=1708706818; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/5/86K2Z1hDqoZIqP7XxaxYaiR6tJyE2BrZYnn5TkeE=;
        b=axbr/Jt8wrdM+6WXlEU6Xbi1A7x0Lsb1jGSyNZALFFcTMrXWobFybh5o1uFHZuNgUa
         A5pi6wip6kkAr0YBkuSuTsJFpbDoSZSmpRDY3IQ4PyjWQyX/7vBRAhxhuY0M4JIUD6+B
         KmVZ7T4I+aGRQegKiVZSp+fxZoV0ArFN7au1DD0bo4cKvthScmySGUC1o+Yyh2pUPWEb
         bS/dIzw2doinb4tO5xegNTeRvPykNNBA7spuDNrBbTWfTLlT15t1uP99AUFkEMayuuwp
         ur9PmLFLfgCpkHi1+TED+477CWTNCuWXCloHRiUqoSTku4JF4CReWo4/gWUamO1gFcfb
         2YZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708102018; x=1708706818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/5/86K2Z1hDqoZIqP7XxaxYaiR6tJyE2BrZYnn5TkeE=;
        b=E0X0GajXGGlfXR3ga4MUpl1iGARv4dE/upmRd02/PNJneMNtclo4VwuK/jwwJJQFBd
         X8e/6OET8kCq6KnLhPDKpfFXeBU3K6y2/6o/GRtavTSEyuOGoSoP0FrXUd6vnD6RegbE
         Sndn7GHmnCJ/QVuXt9tnKv8+MCshGsIWaT05NqUxjsp8bfJdwkpbkVH+Duw4P7gLwx7X
         1qhMEky9HirsvTBbWYozxRJvAdu88bFNdXeNzSxyVrvA4jlhrXCCmNXeDv1sZ6L6BdoW
         ftVI88NM4A5JEMyXVg04ft4ojnxBqYn3GD5dUtvo2nKGtAwNrMstSzMfACeDRT0byO4E
         kkKQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7VY7hHEuHG41TtXyVGwN0YH04scPQgSOxbDJyieThLRqPWdso5UV+hGpaRYjd2TQmarEwnyULLaPB9n8akYXPg+t/NBA=
X-Gm-Message-State: AOJu0YxsuofkFVwTt5uGw7JD+mcTrcSc296pKNTk+T/SkNo3ErB57qcN
	RZ33f1XWioE3I+J0k3yv3IXH3EJoR1XdDERip42U87dFqVXNC0grmHpJdPBysh5EdCgOF3sXEaO
	B54418INB4jD78ci0uLoyHjvnAp67g6R9xtts
X-Google-Smtp-Source: AGHT+IHpVHS0ppvETjTRvFKcu78rYESIPuQ3727VZfvfJc5knt0q+oxLKdnegsBYKFjwcpEUJdgoCQszaHZUroSf3Gc=
X-Received: by 2002:a25:ae44:0:b0:dcc:6894:4ad4 with SMTP id
 g4-20020a25ae44000000b00dcc68944ad4mr5406936ybe.56.1708102018033; Fri, 16 Feb
 2024 08:46:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240212213922.783301-1-surenb@google.com> <20240212213922.783301-19-surenb@google.com>
 <2e26bdf7-a793-4386-bcc1-5b1c7a0405b3@suse.cz>
In-Reply-To: <2e26bdf7-a793-4386-bcc1-5b1c7a0405b3@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 16 Feb 2024 08:46:47 -0800
Message-ID: <CAJuCfpGUH9DNEzfDrt5O0z8T2oAfsJ7-RTTN2CGUqwA+m3g6_w@mail.gmail.com>
Subject: Re: [PATCH v3 18/35] mm: create new codetag references during page splitting
To: Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	corbet@lwn.net, void@manifault.com, peterz@infradead.org, 
	juri.lelli@redhat.com, catalin.marinas@arm.com, will@kernel.org, 
	arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com, 
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com, 
	hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org, 
	ndesaulniers@google.com, vvvvvv@google.com, gregkh@linuxfoundation.org, 
	ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	bristot@redhat.com, vschneid@redhat.com, cl@linux.com, penberg@kernel.org, 
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com, 
	elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 6:33=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 2/12/24 22:39, Suren Baghdasaryan wrote:
> > When a high-order page is split into smaller ones, each newly split
> > page should get its codetag. The original codetag is reused for these
> > pages but it's recorded as 0-byte allocation because original codetag
> > already accounts for the original high-order allocated page.
>
> Wouldn't it be possible to adjust the original's accounted size and
> redistribute to the split pages for more accuracy?

I can't recall why I didn't do it that way but I'll try to change and
see if something non-obvious comes up. Thanks!

>
