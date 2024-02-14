Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3884F7C6D4
	for <iommu@lists.linux.dev>; Wed, 14 Feb 2024 17:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707930901; cv=none; b=oql+OjHYfjUxM4+MZ3osz3Z7qabH35xGZQsGHygK/hnqzKbN5zCIl/pPLDDyp7Ho+0tfCjaNkuF80DlwCDRNTm9Ehu/O3SeA2roCPxIOfPs4sRp9UVyBRKxq/LbvXqDebdR6NGPj8/2KBkjinv+q3A60zU1I4j/X0TZrPPKKtiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707930901; c=relaxed/simple;
	bh=sPCot6JJr6K4Y/nDZ6Ug5FbtqBuDWyih5na/iBbRBjk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nUl13Qv6nxZxBALd9QnA5tzl8OrlFfEb/kTGXEa7JD6H5FcGpUk3PFLUGAirSdung+yguJP2cSlQzc0dhira46dISUmX/LrJEXY3Aqx2QQs12o9K85zncD1M9VeI0pJ+i9vzyojzzZ29UQtZ18bvTnW+EFQQCDG9xF3acrtD1zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UcEHeRFJ; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UcEHeRFJ"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dc742543119so5024700276.0
        for <iommu@lists.linux.dev>; Wed, 14 Feb 2024 09:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707930898; x=1708535698; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LDg0vk5u/oyOZlQ8e31c3DglAzpuw7KxG8umDKGdfj8=;
        b=UcEHeRFJE87dZgUUvhdEXC6l2Kf0WYJvQx7K9v+i9L97kMSlSzs+mgE4qVroE2XWio
         Fw81GiqlMybfDVf3FNoQ2RBHGVH5j9jDkoepnQicqfpG/iQ9ntAhaIOLT0P2OUDCNVoA
         +5obAwTjzHj8JEXoQliwSEEIipBRV1qDnqJnwmEIh937oRWd9/OQ9spcfqhKA96We51F
         HH6KfMjEjAxYJMgX/ygyI6YYq6wY582OHe+A8/JnDe06G7vhtRNG4FjbETMrzJ/rX7OK
         1bEPx981oUGFvG9U/iK2uFHWs/cF6C5eiOmy1Lm/LUF/vVlXnjIXSkf2QNYX0enue4xn
         v9+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707930898; x=1708535698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LDg0vk5u/oyOZlQ8e31c3DglAzpuw7KxG8umDKGdfj8=;
        b=KNpV8RJdsUiPBR0N1YTdlMAltJmlpuc9xux7KZkjk7I+BMnfBD2CyuRZdmdCck1VAQ
         JT6n14kN9TebIt0PBa3zQoqdp0Du8EmvZk8qE6nsbSCzZiHqTGmXJLVcYRq+SdyJ7J7F
         9c7T2UnAAOz7VnakiBXM5hiS+6Z+36aLPlFUuJu2tVq9S8CUPluysOuE419GnIYEdmIl
         ZWWFlDtfuZhqid98Wqd92HKH9ZPkhWpIIqz5Lo+fgJfgp/+MH1ss2gOxctDTjjoZ+gaC
         M7d5R1LDI9PmmE9wchDaU8udTkRGtojZNeHl3+9Cj4Lzj2kQnWocXBzV1oA2sMYmG3IG
         8EXg==
X-Forwarded-Encrypted: i=1; AJvYcCUOlcZsoamfNMYdFN5Eh4k2iGWfohhAUmX8X/PqxHHbEwKV992rMJp74nE7wXW8A0XSkpFkljNyLvPfo3ezyIsmA+iBBEI=
X-Gm-Message-State: AOJu0YwEXBjtat2kHQDNQKK8rAv6PnnzrZMLxNkxwWcvBbY8IWwOUsGk
	Y86OkiKJA69xoPJz6wHVtVKCJxpuI8P+aFw3o6pbtPGxhKFBRjBNudRjEgqf7goul5NGe6cmAQE
	LQU0Nsk8kekfdxOg4zuCqXdt/eUwrJOw7duG0
X-Google-Smtp-Source: AGHT+IFzocTbMe8vXbVa4j69vx7gDqurZ3EaP/A9DOqxrZVhCKoBgWMQN08N6cMcnP1DyMjMOOc1HMd1b4SoKjvkySI=
X-Received: by 2002:a25:7443:0:b0:dcb:e82c:f7d with SMTP id
 p64-20020a257443000000b00dcbe82c0f7dmr2936932ybc.41.1707930897779; Wed, 14
 Feb 2024 09:14:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240212213922.783301-1-surenb@google.com> <Zctfa2DvmlTYSfe8@tiehlicka>
 <CAJuCfpEsWfZnpL1vUB2C=cxRi_WxhxyvgGhUg7WdAxLEqy6oSw@mail.gmail.com>
 <9e14adec-2842-458d-8a58-af6a2d18d823@redhat.com> <2hphuyx2dnqsj3hnzyifp5yqn2hpgfjuhfu635dzgofr5mst27@4a5dixtcuxyi>
 <6a0f5d8b-9c67-43f6-b25e-2240171265be@redhat.com> <CAJuCfpEtOhzL65eMDk2W5SchcquN9hMCcbfD50a-FgtPgxh4Fw@mail.gmail.com>
 <adbb77ee-1662-4d24-bcbf-d74c29bc5083@redhat.com> <r6cmbcmalryodbnlkmuj2fjnausbcysmolikjguqvdwkngeztq@45lbvxjavwb3>
 <CAJuCfpF4g1jeEwHVHjQWwi5kqS-3UqjMt7GnG0Kdz5VJGyhK3Q@mail.gmail.com> <20240214085548.d3608627739269459480d86e@linux-foundation.org>
In-Reply-To: <20240214085548.d3608627739269459480d86e@linux-foundation.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 14 Feb 2024 09:14:46 -0800
Message-ID: <CAJuCfpE3yQyMXX5izocnWaDuB5ATfqHi-JcvcTQSvmf9c2zS4A@mail.gmail.com>
Subject: Re: [PATCH v3 00/35] Memory allocation profiling
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, David Hildenbrand <david@redhat.com>, 
	Michal Hocko <mhocko@suse.com>, vbabka@suse.cz, hannes@cmpxchg.org, 
	roman.gushchin@linux.dev, mgorman@suse.de, dave@stgolabs.net, 
	willy@infradead.org, liam.howlett@oracle.com, corbet@lwn.net, 
	void@manifault.com, peterz@infradead.org, juri.lelli@redhat.com, 
	catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de, tglx@linutronix.de, 
	mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org, 
	peterx@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
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

On Wed, Feb 14, 2024 at 8:55=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Tue, 13 Feb 2024 14:59:11 -0800 Suren Baghdasaryan <surenb@google.com>=
 wrote:
>
> > > > If you think you can easily achieve what Michal requested without a=
ll that,
> > > > good.
> > >
> > > He requested something?
> >
> > Yes, a cleaner instrumentation. Unfortunately the cleanest one is not
> > possible until the compiler feature is developed and deployed. And it
> > still would require changes to the headers, so don't think it's worth
> > delaying the feature for years.
>
> Can we please be told much more about this compiler feature?
> Description of what it is, what it does, how it will affect this kernel
> feature, etc.

Sure. The compiler support will be in a form of a new __attribute__,
simplified example:

// generate data for the wrapper
static void _alloc_tag()
{
  static struct alloc_tag _alloc_tag __section ("alloc_tags")
      =3D { .ct =3D CODE_TAG_INIT, .counter =3D 0 };
}

static inline int
wrapper (const char *name, int x, int (*callee) (const char *, int),
         struct alloc_tag *callsite_data)
{
  callsite_data->counter++;
  printf ("Call #%d from %s:%d (%s)\n", callsite_data->counter,
          callsite_data->ct.filename, callsite_data->ct.lineno,
          callsite_data->ct.function);
  int ret =3D callee (name, x);
  printf ("Returned: %d\n", ret);
  return ret;
}

__attribute__((annotate("callsite_wrapped_by", wrapper, _alloc_tag)))
int foo(const char* name, int x);

int foo(const char* name, int x) {
  printf ("Hello %s, %d!\n", name, x);
  return x;
}

Which we will be able to attach to a function without changing its
name and preserving the namespace (it applies only to functions with
that name, not everything else).
Note that we will still need _noprof versions of the allocators.

>
> Who is developing it and when can we expect it to become available?

Aleksei Vetrov (google) with the help of Nick Desaulniers (google).
Both are CC'ed on this email.
After several iterations Aleksei has a POC which we are evaluating
(https://github.com/llvm/llvm-project/compare/main...noxwell:llvm-project:c=
allsite-wrapper-tree-transform).
Once it's in good shape we are going to engage with CLANG and GCC
community to get it upstreamed. When it will become available and when
the distributions will pick it up is anybody's guess. Upstreaming is
usually a lengthy process.

>
> Will we be able to migrate to it without back-compatibility concerns?
> (I think "you need quite recent gcc for memory profiling" is
> reasonable).

The migration should be quite straight-forward, replacing the macros
with functions with that attribute.

>
>
> Because: if the maintainability issues which Michel describes will be
> significantly addressed with the gcc support then we're kinda reviewing
> the wrong patchset.  Yes, it may be a maintenance burden initially, but
> at some (yet to be revealed) time in the future, this will be addressed
> with the gcc support?

That's what I'm aiming for. I just don't want this placed on hold
until the compiler support is widely available, which might take
years.

>
