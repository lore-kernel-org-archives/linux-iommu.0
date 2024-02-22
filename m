Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC593984B
	for <iommu@lists.linux.dev>; Thu, 22 Feb 2024 10:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708596013; cv=none; b=Uv2nMzC+h1qcMacnjluX+t3ML3WPacxkmYYV49z0uSrs5qISvUjtNwYePwvDdgCNXvbxjNzukkYXhq3BOCVTiuz7dZCLxhlaahZI3LmawXhImvpz0z19C8UXz9lo59/KJVZEmg3naiZHENRfv/qqFkoMuc7NqJMAB87Mlrqs0bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708596013; c=relaxed/simple;
	bh=xY3a5A8TczyzS4EQy7YnxSv2e9KYZLcka7tIrv2ih1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nqbd31aa19VdmqdeXdPW4sZR2UV0KjkPXWZCrhPc1knETFjSLaZ5RjKyLIq6bsp4BluM6bcUk63C3XnyeRp64osc4tf2boapCbjObOMJebQ38AxVjmunKHo+8e/eiJPn3W07ojlZucZlW6y+dBPG2XdzRNFV8jmqCmbCG24qvPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NFIBDm+R; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NFIBDm+R"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-7d6275d7d4dso3935464241.2
        for <iommu@lists.linux.dev>; Thu, 22 Feb 2024 02:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708596010; x=1709200810; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xY3a5A8TczyzS4EQy7YnxSv2e9KYZLcka7tIrv2ih1k=;
        b=NFIBDm+RIC24aYODAadmmWvqiqDPmHQ8BS+lLHJlOqe2wz1hRhCchh9Y77xhd8H/O2
         WDcSRaU3/86o2E9jMGk6xPYotOQNrTzShYILhOdkpGGSoKrwA+E/oxJhx6/Lj5Kg7/iH
         8JEAhnGuTpARMCkUib9oiJLvodl0YzV4I65VSD2HAErY2V/yanKkgaWNLrX4SXoZxJHk
         L+3Wbt/Jk9XY49h6pPvotxLFQJzELX/OZLdXF9AFDUwjTrsqnJV9WoBEmVb3RnlvU9FP
         3CahIXl9WYRDD4P+Zt/EEbte9SAMqimF1W6gb8cPI2qSQgm2PAo46DGi4sZiHQ59moEm
         KV5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708596010; x=1709200810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xY3a5A8TczyzS4EQy7YnxSv2e9KYZLcka7tIrv2ih1k=;
        b=RVJvPyDrktbqzobSl9F9WTrrhq0lkIRVIUBradRt7uublPkOUC5Q1MRNKceo18DDnj
         PubFehF4wXIXid7Ix0aR4XBb7P0lNRJTJD1yWcqxOKkbAC1PVmxat/ZAfx33Xo7hSR3H
         KITu2tr0QQ6hKNJPXztN1o7Km32YzeDxpN/gVjS7H/HYv1tsLPa0rb/rxPoXSzfC5CM0
         yMGtF7Qma36Eqxj3y4grDbn3Q1lparEqrwdpN8kTKAp1Q8mwl8qvxvK8gRESEoLnOfbU
         O0rnL9F6tjmhJHy8RdwFDttx+3K/IBo+3JtjNpFHrVEOHFBWa56Jh7QGNwAWmh7j6qjo
         BjtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdLElG/OtppN6g8CQt2cHZMnwwvDx1wG+thANwaZC5rxtlM8taXBBKSe5JIPyPpaEm35FIN62tEhj6zW5ogT3Voz2/Fdw=
X-Gm-Message-State: AOJu0YzGULqfyFOCDqio1FEWv9JWn+OS59XCA2kelM8ysKOaIgo5FmEr
	VQHblGmjJHAnH2/lcNIUErK428xQAlrObS7pGEsHRfkHXqvaYjz8fZTsZFBbjvDjKzRfI+MrZX2
	0L/mVbTAt3iD6YpMNlEDLyDc9uy5B1OO2+Rdl
X-Google-Smtp-Source: AGHT+IHtNH9SG5kviHG0Zp4ObgcElY0QaPwq/WKIrJZZn0CRZo740etRowxrv/bo9NQSJHSXY5Ib9q+PDO3ajLn3tTQ=
X-Received: by 2002:a05:6102:1626:b0:470:4a6e:4a4e with SMTP id
 cu38-20020a056102162600b004704a6e4a4emr14352031vsb.29.1708596009136; Thu, 22
 Feb 2024 02:00:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com> <20240221194052.927623-25-surenb@google.com>
In-Reply-To: <20240221194052.927623-25-surenb@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 22 Feb 2024 10:59:57 +0100
Message-ID: <CAH5fLgiyouEuDGkbm3fB6WTOxAnTiDx=z6ADx7HN3BTMAO851g@mail.gmail.com>
Subject: Re: [PATCH v4 24/36] rust: Add a rust helper for krealloc()
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com, 
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
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
	cgroups@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 8:41=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> From: Kent Overstreet <kent.overstreet@linux.dev>
>
> Memory allocation profiling is turning krealloc() into a nontrivial
> macro - so for now, we need a helper for it.
>
> Until we have proper support on the rust side for memory allocation
> profiling this does mean that all Rust allocations will be accounted to
> the helper.
>
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> Cc: Miguel Ojeda <ojeda@kernel.org>
> Cc: Alex Gaynor <alex.gaynor@gmail.com>
> Cc: Wedson Almeida Filho <wedsonaf@gmail.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Gary Guo <gary@garyguo.net>
> Cc: "Bj=C3=B6rn Roy Baron" <bjorn3_gh@protonmail.com>
> Cc: Benno Lossin <benno.lossin@proton.me>
> Cc: Andreas Hindborg <a.hindborg@samsung.com>
> Cc: Alice Ryhl <aliceryhl@google.com>
> Cc: rust-for-linux@vger.kernel.org
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Currently, the Rust build doesn't work throughout the entire series
since there are some commits where krealloc is missing before you
introduce the helper. If you introduce the helper first before
krealloc stops being an exported function, then the Rust build should
work throughout the entire series. (Having both the helper and the
exported function at the same time is not a problem.)

With the patch reordered:

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

Alice
