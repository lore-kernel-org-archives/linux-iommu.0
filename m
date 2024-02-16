Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB19713541F
	for <iommu@lists.linux.dev>; Fri, 16 Feb 2024 18:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708108922; cv=none; b=tuDfQ7NhFYjpjxh4dJxPnabNpvkcMqB5i73Uenpn4yvDSPIADIYxACQNDpwK5DWMOWmvqgcC6/ainX1bKQBtqjuKBw5mCwHyzWsbuxjGfoGfzmp5oZxegHpYbSci4uGlTfXZXHszGTi7qALE/g6t/hq6oInkfvVsaBondhit7dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708108922; c=relaxed/simple;
	bh=A1KZCaXPLmV5IjKi0NDr6st7BWpbT8lR31nOuGGGMbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i33i0mmM5TPUfAhn05VQ9v0abtRmlohGhPOXD+S5TQ+fGW7kDoXiUBPGEx1gEhNXvvMt/tR+BOGpK1u+olVcrhUia2exuM38Hla8b6E9q4VYiatYKnzoPi/RVAGa7h8OFF7rGPb67xeqmPqwXC/QrzBhZJ0ou5FbWU79ktH5gUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d8mucQqp; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d8mucQqp"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dc25e12cc63so2979321276.0
        for <iommu@lists.linux.dev>; Fri, 16 Feb 2024 10:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708108919; x=1708713719; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=faKyGS2bCJ2px0ud+d+mBkv9JBZNScCq7HyfBnLgGJM=;
        b=d8mucQqpf7B6biROPknNFaBFrrbBssk3ouaDGf7MLisLp6MmFPVhrd++AVvdgaqg1a
         pEwaEBBX28m+hJkm68ifbd+QJCVhsVl9vEhNJBrkx7XOVCRJ8v+7P0M7cQhhcVsjYerM
         a2XU87RDN2OzL9m+P8ieMCOxJWWmmz1FrNtVENNc+69zf5m8U8oDq+kc56LIaa5pPhFb
         URyR9twI/sL7XPZpUV/7CkXqqpXobhhJZOmX8XZ4nlt5/5ixtKlO5/pgYiIb2F7uIMcK
         fYoVmRohIlyMZ0njIYyjp2lQIPRm+tTHdTednQAacR8DkZ6AfrpRGgw2JfcxcARpI8T9
         I2/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708108919; x=1708713719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=faKyGS2bCJ2px0ud+d+mBkv9JBZNScCq7HyfBnLgGJM=;
        b=XkqtwYB1gNh/jIrr8kklEp/3ENKvq4Wu2yTzxy83Zc+/2zYov7i3tOE9iz9KJIQ6gj
         NESKwL/4XSeiS/OFFSLc3f3kubCqAPhkQGekvL2ws1WTd6rVoCGSDP9wu++1wPmj7Rvz
         b+A3ax82icZaopl2v0LB4t8bB4GjStTeeG+tV+Q+gUrKrVA0GlJHLA7SaYyvq8I0b+cT
         szjZede5MKly/ixhsJUY2fnHVfji9jsPrIJtOmWDZa3Oq63Uaqkl73ik1B0gYfmfzo/N
         ZRkn6ZJfLM4oJYvQpKkWJYeUlCAI1kpBBxn0WdZglvsjhXEx4YVxtJ5Cxu0X2QApFJhV
         PQuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLtai20fgWSpZtMBDv5ObnxvL1oB1EeVUWjmufOegJ/f+eIFH/awleRkMSr1+9NYALfVYEzkmWrt2zM9G6oRKimHOAGg8=
X-Gm-Message-State: AOJu0YyFZIDIIkMkEHoxeKx3DX9XThWWElxYU5VZ0wvDs9lV8v50NqJs
	L9LcXTowN9rKydXb7uWFJgo0wGB4jTdSKxPAK2BUIcQRwbvOM96FKFCcSzMHCWjdvld2LyYsa5j
	ShoTYj9pA5JfxEMNHA2I67YtbjrPSk26v6x/p
X-Google-Smtp-Source: AGHT+IEJnWKoDWpauMUL3nyzq5XZmrCjaSg8T+9prk1S1WBz+kj41C07IYkFdioVMXmJnJb7IpOv4ANZWqelmDdrwMM=
X-Received: by 2002:a25:fc23:0:b0:dc2:3a05:489 with SMTP id
 v35-20020a25fc23000000b00dc23a050489mr4194145ybd.14.1708108919211; Fri, 16
 Feb 2024 10:41:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240212213922.783301-1-surenb@google.com> <20240212213922.783301-8-surenb@google.com>
 <fbfab72f-413d-4fc1-b10b-3373cfc6c8e9@suse.cz> <tbqg7sowftykfj3rptpcbewoiy632fbgbkzemgwnntme4wxhut@5dlfmdniaksr>
 <ab4b1789-910a-4cd6-802c-5012bf9d8984@suse.cz> <CAJuCfpH=tr1faWnn0CZ=V_Gg-0ysEsGPOje5U-DDy5x2V83pxA@mail.gmail.com>
In-Reply-To: <CAJuCfpH=tr1faWnn0CZ=V_Gg-0ysEsGPOje5U-DDy5x2V83pxA@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 16 Feb 2024 18:41:46 +0000
Message-ID: <CAJuCfpGBCNsvK35Bq8666cJeZ3Hwfwj6mDJ6M5Wjg7oZi8xd0g@mail.gmail.com>
Subject: Re: [PATCH v3 07/35] mm/slab: introduce SLAB_NO_OBJ_EXT to avoid
 obj_ext creation
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, akpm@linux-foundation.org, mhocko@suse.com, 
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

On Thu, Feb 15, 2024 at 10:10=E2=80=AFPM Suren Baghdasaryan <surenb@google.=
com> wrote:
>
> On Thu, Feb 15, 2024 at 1:50=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> =
wrote:
> >
> > On 2/15/24 22:37, Kent Overstreet wrote:
> > > On Thu, Feb 15, 2024 at 10:31:06PM +0100, Vlastimil Babka wrote:
> > >> On 2/12/24 22:38, Suren Baghdasaryan wrote:
> > >> > Slab extension objects can't be allocated before slab infrastructu=
re is
> > >> > initialized. Some caches, like kmem_cache and kmem_cache_node, are=
 created
> > >> > before slab infrastructure is initialized. Objects from these cach=
es can't
> > >> > have extension objects. Introduce SLAB_NO_OBJ_EXT slab flag to mar=
k these
> > >> > caches and avoid creating extensions for objects allocated from th=
ese
> > >> > slabs.
> > >> >
> > >> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > >> > ---
> > >> >  include/linux/slab.h | 7 +++++++
> > >> >  mm/slub.c            | 5 +++--
> > >> >  2 files changed, 10 insertions(+), 2 deletions(-)
> > >> >
> > >> > diff --git a/include/linux/slab.h b/include/linux/slab.h
> > >> > index b5f5ee8308d0..3ac2fc830f0f 100644
> > >> > --- a/include/linux/slab.h
> > >> > +++ b/include/linux/slab.h
> > >> > @@ -164,6 +164,13 @@
> > >> >  #endif
> > >> >  #define SLAB_TEMPORARY            SLAB_RECLAIM_ACCOUNT    /* Obje=
cts are short-lived */
> > >> >
> > >> > +#ifdef CONFIG_SLAB_OBJ_EXT
> > >> > +/* Slab created using create_boot_cache */
> > >> > +#define SLAB_NO_OBJ_EXT         ((slab_flags_t __force)0x20000000=
U)
> > >>
> > >> There's
> > >>    #define SLAB_SKIP_KFENCE        ((slab_flags_t __force)0x20000000=
U)
> > >> already, so need some other one?
>
> Indeed. I somehow missed it. Thanks for noticing, will fix this in the
> next version.

Apparently the only unused slab flag is 0x00000200U, all others seem
to be taken. I'll use it if there are no objections.

>
> > >
> > > What's up with the order of flags in that file? They don't seem to
> > > follow any particular ordering.
> >
> > Seems mostly in increasing order, except commit 4fd0b46e89879 broke it =
for
> > SLAB_RECLAIM_ACCOUNT?
> >
> > > Seems like some cleanup is in order, but any history/context we shoul=
d
> > > know first?
> >
> > Yeah noted, but no need to sidetrack you.
