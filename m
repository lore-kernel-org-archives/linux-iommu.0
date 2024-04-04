Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D941912AACB
	for <iommu@lists.linux.dev>; Thu,  4 Apr 2024 16:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712249892; cv=none; b=YGZKKv3oaOu9JPl9o5C7bi9E8t0zi+fQliJAXd8z2fu9Ua+DTHrdOwAvTTIvliN0T779kIbU4CmO+XJiDWC+4KzxbyfujfKJyRboWYBtlixcWF5vXq/u6/048uTshOF9ZlW4vZtXd7Xqh8p59upOVbRvNlBESLLLege/f9DAEWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712249892; c=relaxed/simple;
	bh=Ug3wNn9rUYSiApUWsdmJAfxaH7gkdUjC0d0zsQR/y4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SDNxJe0pvwkjfIUAMgWWkhwlMCAPxGFiReggudSdf1sfN/F50atTXj/HV/D7eB2+nVbFbuPgWKlmMlOuUhNMS8OLVavoemiWXXCssguC7h1rwPe9A62fleIDdNosZW0Q7zQT6cJP+59tZQPi+5Xat0LmugoNAxRNp6Yw9vhzeJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t3699ZQN; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t3699ZQN"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-61587aa9f4cso11336587b3.3
        for <iommu@lists.linux.dev>; Thu, 04 Apr 2024 09:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712249890; x=1712854690; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SnNkrv9amLNSOChMZU1xiNRngWLHsWRGHJdyDWSVIjQ=;
        b=t3699ZQN71mgeza39+IMkbEbPYWFBcn7pCdaOXoef9fIdqFuJisDKZp/FnyHInd7xU
         ibH6XTdIai7hZMB3dgZHsp979ywlV+ST6IRGr5iHHDkMgmeNwAa7Klwa43nUZM4Ax4BL
         Ldl4ukJm6TSULrMs7JvpSmb067Yyg2ewimTT4NWmmXjEmEg7DdxqdbiRb5+2n4DyhoSS
         lbjYXSqNmR3QJ/i+KV3q7OL4uKUsDRWl+8PNLC9RnG9NWn8LR558PR0xcqR2e4qcNGLV
         MVMx+qJeMXmot0RDZUFbX8Q+8H5xx0g/qZsrCGYLEP4NlwbBL5FqhSUM6YH8lcB3y11u
         gGiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712249890; x=1712854690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SnNkrv9amLNSOChMZU1xiNRngWLHsWRGHJdyDWSVIjQ=;
        b=n0LUAM0C86bhmLmh30cpnuSWGs8PsL+bMAS4LTDM6gwjQh1WL26TftAX1y5bzszW3I
         xSW1/7YLbwTMrUzLC+b+qACaRHvNvkI7QlpU/PM1twyDK+JJCSLGxrRJYrJvEgDnTZxt
         tCLuqvOrPmEckjtasiepOeFzQse0WRsIgRrEjmCH9o3YrCjdj6NBjGr3rmukCD8HCzWh
         aE1krVrhCn5IrsRA4xeIpfloq40a6oVqMxuHH8IbdNJUovvGKjv7WypmmrD4svjdotzh
         N1L4OWFImpxBRzos8REgP+PyUeCQzhyY2f0/Sl5PIjCqc5Y9uvsjrP2r5NIeKsZ0lDhB
         en6A==
X-Forwarded-Encrypted: i=1; AJvYcCUl78Pf6QYIVALPjmgxI6gFYmjlJ1yGbr7e/9ncoQgV6lgz0f+8SmdubM786cNOto5qb6KTxmxIYNPBt8T2rulLHsJIVc8=
X-Gm-Message-State: AOJu0YztdFaMhMj+hZOgTRs6+pPU7Tp47YwypYHbUw2Y9HUzVRPznH8G
	UdYAHTX22BtNeoYCyUBU5+lG8P6WovRtMgiz/iEZ74ary/p/eZ72+c7UtHPwhGc8NHs+/oMopze
	YIaxlDdiCfoHTT2ecs0iBRpnhPkL2hVN5JEx5
X-Google-Smtp-Source: AGHT+IF7B3akhgfxRrnqjce/FXowsw1E3eakccZbE6M28J8HXpTOkV5OPQcXw5mCpvOPKhYETIzOkOwrlUerT+o2JDc=
X-Received: by 2002:a5b:481:0:b0:dcc:9d30:58a0 with SMTP id
 n1-20020a5b0481000000b00dcc9d3058a0mr2683124ybp.64.1712249889460; Thu, 04 Apr
 2024 09:58:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240321163705.3067592-1-surenb@google.com> <20240321163705.3067592-6-surenb@google.com>
 <20240321133147.6d05af5744f9d4da88234fb4@linux-foundation.org>
 <gnqztvimdnvz2hcepdh3o3dpg4cmvlkug4sl7ns5vd4lm7hmao@dpstjnacdubq>
 <20240321150908.48283ba55a6c786dee273ec3@linux-foundation.org>
 <bliyhrwtskv5xhg3rxxszouxntrhnm3nxhcmrmdwwk4iyx5wdo@vodd22dbtn75> <CAJuCfpEO4NjYysJ7X8ME_GjHc41u-_dK4AhrhmaSMh_9mxaHSA@mail.gmail.com>
In-Reply-To: <CAJuCfpEO4NjYysJ7X8ME_GjHc41u-_dK4AhrhmaSMh_9mxaHSA@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 4 Apr 2024 09:57:55 -0700
Message-ID: <CAJuCfpEGJHs=ygb2_PNcqEy__dvhby5N7dvwnno=3pDEvE1+2g@mail.gmail.com>
Subject: Re: [PATCH v6 05/37] fs: Convert alloc_inode_sb() to a macro
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, jhubbard@nvidia.com, tj@kernel.org, 
	muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org, 
	pasha.tatashin@soleen.com, yosryahmed@google.com, yuzhao@google.com, 
	dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com, 
	keescook@chromium.org, ndesaulniers@google.com, vvvvvv@google.com, 
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, cl@linux.com, 
	penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, 
	glider@google.com, elver@google.com, dvyukov@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, aliceryhl@google.com, 
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com, 
	kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 3:47=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Thu, Mar 21, 2024 at 3:17=E2=80=AFPM Kent Overstreet
> <kent.overstreet@linux.dev> wrote:
> >
> > On Thu, Mar 21, 2024 at 03:09:08PM -0700, Andrew Morton wrote:
> > > On Thu, 21 Mar 2024 17:15:39 -0400 Kent Overstreet <kent.overstreet@l=
inux.dev> wrote:
> > >
> > > > On Thu, Mar 21, 2024 at 01:31:47PM -0700, Andrew Morton wrote:
> > > > > On Thu, 21 Mar 2024 09:36:27 -0700 Suren Baghdasaryan <surenb@goo=
gle.com> wrote:
> > > > >
> > > > > > From: Kent Overstreet <kent.overstreet@linux.dev>
> > > > > >
> > > > > > We're introducing alloc tagging, which tracks memory allocation=
s by
> > > > > > callsite. Converting alloc_inode_sb() to a macro means allocati=
ons will
> > > > > > be tracked by its caller, which is a bit more useful.
> > > > >
> > > > > I'd have thought that there would be many similar
> > > > > inlines-which-allocate-memory.  Such as, I dunno, jbd2_alloc_inod=
e().
> > > > > Do we have to go converting things to macros as people report
> > > > > misleading or less useful results, or is there some more general
> > > > > solution to this?
> > > >
> > > > No, this is just what we have to do.
> > >
> > > Well, this is something we strike in other contexts - kallsyms gives =
us
> > > an inlined function and it's rarely what we wanted.
> > >
> > > I think kallsyms has all the data which is needed to fix this - how
> > > hard can it be to figure out that a particular function address lies
> > > within an outer function?  I haven't looked...
> >
> > This is different, though - even if a function is inlined in multiple
> > places there's only going to be one instance of a static var defined
> > within that function.
>
> I guess one simple way to detect the majority of these helpers would
> be to filter all entries from /proc/allocinfo which originate from
> header files.
>
> ~# grep ".*\.h:." /proc/allocinfo
>       933888      228 include/linux/mm.h:2863 func:pagetable_alloc
>          848       53 include/linux/mm_types.h:1175 func:mm_alloc_cid
>            0        0 include/linux/bpfptr.h:70 func:kvmemdup_bpfptr
>            0        0 include/linux/bpf.h:2237 func:bpf_map_kmalloc_node
>            0        0 include/linux/bpf.h:2256 func:bpf_map_alloc_percpu
>            0        0 include/linux/bpf.h:2256 func:bpf_map_alloc_percpu
>            0        0 include/linux/bpf.h:2237 func:bpf_map_kmalloc_node
>            0        0 include/linux/bpf.h:2249 func:bpf_map_kvcalloc
>            0        0 include/linux/bpf.h:2243 func:bpf_map_kzalloc
>            0        0 include/linux/bpf.h:2237 func:bpf_map_kmalloc_node
>            0        0 include/linux/ptr_ring.h:471
> func:__ptr_ring_init_queue_alloc
>            0        0 include/linux/bpf.h:2256 func:bpf_map_alloc_percpu
>            0        0 include/linux/bpf.h:2237 func:bpf_map_kmalloc_node
>            0        0 include/net/tcx.h:80 func:tcx_entry_create
>            0        0 arch/x86/include/asm/pgalloc.h:156 func:p4d_alloc_o=
ne
>       487424      119 include/linux/mm.h:2863 func:pagetable_alloc
>            0        0 include/linux/mm.h:2863 func:pagetable_alloc
>          832       13 include/linux/jbd2.h:1607 func:jbd2_alloc_inode
>            0        0 include/linux/jbd2.h:1591 func:jbd2_alloc_handle
>            0        0 fs/nfs/iostat.h:51 func:nfs_alloc_iostats
>            0        0 include/net/netlabel.h:281 func:netlbl_secattr_cach=
e_alloc
>            0        0 include/net/netlabel.h:381 func:netlbl_secattr_allo=
c
>            0        0 include/crypto/internal/acompress.h:76
> func:__acomp_request_alloc
>         8064       84 include/acpi/platform/aclinuxex.h:57
> func:acpi_os_allocate_zeroed
>            0        0 include/acpi/platform/aclinuxex.h:57
> func:acpi_os_allocate_zeroed
>            0        0 include/acpi/platform/aclinuxex.h:57
> func:acpi_os_allocate_zeroed
>            0        0 include/acpi/platform/aclinuxex.h:57
> func:acpi_os_allocate_zeroed
>            0        0 include/acpi/platform/aclinuxex.h:57
> func:acpi_os_allocate_zeroed
>         1016       74 include/acpi/platform/aclinuxex.h:57
> func:acpi_os_allocate_zeroed
>          384        4 include/acpi/platform/aclinuxex.h:57
> func:acpi_os_allocate_zeroed
>            0        0 include/acpi/platform/aclinuxex.h:57
> func:acpi_os_allocate_zeroed
>            0        0 include/acpi/platform/aclinuxex.h:57
> func:acpi_os_allocate_zeroed
>          704        3 include/acpi/platform/aclinuxex.h:57
> func:acpi_os_allocate_zeroed
>           32        1 include/acpi/platform/aclinuxex.h:57
> func:acpi_os_allocate_zeroed
>           64        1 include/acpi/platform/aclinuxex.h:52 func:acpi_os_a=
llocate
>            0        0 include/acpi/platform/aclinuxex.h:57
> func:acpi_os_allocate_zeroed
>           40        2 include/acpi/platform/aclinuxex.h:57
> func:acpi_os_allocate_zeroed
>            0        0 include/acpi/platform/aclinuxex.h:57
> func:acpi_os_allocate_zeroed
>            0        0 include/acpi/platform/aclinuxex.h:52 func:acpi_os_a=
llocate
>            0        0 include/acpi/platform/aclinuxex.h:57
> func:acpi_os_allocate_zeroed
>            0        0 include/acpi/platform/aclinuxex.h:52 func:acpi_os_a=
llocate
>            0        0 include/acpi/platform/aclinuxex.h:57
> func:acpi_os_allocate_zeroed
>            0        0 include/acpi/platform/aclinuxex.h:52 func:acpi_os_a=
llocate
>            0        0 include/acpi/platform/aclinuxex.h:57
> func:acpi_os_allocate_zeroed
>            0        0 include/acpi/platform/aclinuxex.h:52 func:acpi_os_a=
llocate
>           32        1 include/acpi/platform/aclinuxex.h:57
> func:acpi_os_allocate_zeroed
>            0        0 include/acpi/platform/aclinuxex.h:57
> func:acpi_os_allocate_zeroed
>            0        0 include/acpi/platform/aclinuxex.h:52 func:acpi_os_a=
llocate
>            0        0 include/acpi/platform/aclinuxex.h:57
> func:acpi_os_allocate_zeroed
>            0        0 include/acpi/platform/aclinuxex.h:52 func:acpi_os_a=
llocate
>        30000      625 include/acpi/platform/aclinuxex.h:67
> func:acpi_os_acquire_object
>            0        0 include/acpi/platform/aclinuxex.h:57
> func:acpi_os_allocate_zeroed
>            0        0 include/acpi/platform/aclinuxex.h:57
> func:acpi_os_allocate_zeroed
>            0        0 include/acpi/platform/aclinuxex.h:57
> func:acpi_os_allocate_zeroed
>            0        0 include/acpi/platform/aclinuxex.h:57
> func:acpi_os_allocate_zeroed
>            0        0 include/acpi/platform/aclinuxex.h:57
> func:acpi_os_allocate_zeroed
>            0        0 include/acpi/platform/aclinuxex.h:57
> func:acpi_os_allocate_zeroed
>            0        0 include/acpi/platform/aclinuxex.h:52 func:acpi_os_a=
llocate
>            0        0 include/acpi/platform/aclinuxex.h:67
> func:acpi_os_acquire_object
>            0        0 include/acpi/platform/aclinuxex.h:57
> func:acpi_os_allocate_zeroed
>            0        0 include/acpi/platform/aclinuxex.h:57
> func:acpi_os_allocate_zeroed
>          512        1 include/acpi/platform/aclinuxex.h:57
> func:acpi_os_allocate_zeroed
>            0        0 include/acpi/platform/aclinuxex.h:52 func:acpi_os_a=
llocate
>          192        6 include/acpi/platform/aclinuxex.h:52 func:acpi_os_a=
llocate
>            0        0 include/acpi/platform/aclinuxex.h:52 func:acpi_os_a=
llocate
>            0        0 include/acpi/platform/aclinuxex.h:57
> func:acpi_os_allocate_zeroed
>            0        0 include/acpi/platform/aclinuxex.h:52 func:acpi_os_a=
llocate
>            0        0 include/acpi/platform/aclinuxex.h:57
> func:acpi_os_allocate_zeroed
>            0        0 include/acpi/platform/aclinuxex.h:57
> func:acpi_os_allocate_zeroed
>          192        3 include/acpi/platform/aclinuxex.h:52 func:acpi_os_a=
llocate
>        61992      861 include/acpi/platform/aclinuxex.h:67
> func:acpi_os_acquire_object
>            0        0 include/acpi/platform/aclinuxex.h:57
> func:acpi_os_allocate_zeroed
>            0        0 include/acpi/platform/aclinuxex.h:57
> func:acpi_os_allocate_zeroed
>            0        0 include/acpi/platform/aclinuxex.h:67
> func:acpi_os_acquire_object
>            0        0 include/acpi/platform/aclinuxex.h:57
> func:acpi_os_allocate_zeroed
>            0        0 drivers/iommu/amd/amd_iommu.h:141 func:alloc_pgtabl=
e_page
>            0        0 drivers/iommu/amd/amd_iommu.h:141 func:alloc_pgtabl=
e_page
>            0        0 drivers/iommu/amd/amd_iommu.h:141 func:alloc_pgtabl=
e_page
>            0        0 include/linux/dma-fence-chain.h:91
> func:dma_fence_chain_alloc
>            0        0 include/linux/dma-fence-chain.h:91
> func:dma_fence_chain_alloc
>            0        0 include/linux/dma-fence-chain.h:91
> func:dma_fence_chain_alloc
>            0        0 include/linux/dma-fence-chain.h:91
> func:dma_fence_chain_alloc
>            0        0 include/linux/dma-fence-chain.h:91
> func:dma_fence_chain_alloc
>            0        0 include/linux/hid_bpf.h:154 func:call_hid_bpf_rdesc=
_fixup
>            0        0 include/linux/skbuff.h:3392 func:__dev_alloc_pages
>       114688       56 include/linux/ptr_ring.h:471
> func:__ptr_ring_init_queue_alloc
>            0        0 include/linux/skmsg.h:415 func:sk_psock_init_link
>            0        0 include/linux/bpf.h:2237 func:bpf_map_kmalloc_node
>            0        0 include/linux/ptr_ring.h:628 func:ptr_ring_resize_m=
ultiple
>        24576        3 include/linux/ptr_ring.h:471
> func:__ptr_ring_init_queue_alloc
>            0        0 include/net/netlink.h:1896 func:nla_memdup
>            0        0 include/linux/sockptr.h:97 func:memdup_sockptr
>            0        0 include/net/request_sock.h:131 func:reqsk_alloc
>            0        0 include/net/tcp.h:2456 func:tcp_v4_save_options
>            0        0 include/net/tcp.h:2456 func:tcp_v4_save_options
>            0        0 include/crypto/hash.h:586 func:ahash_request_alloc
>            0        0 include/linux/sockptr.h:97 func:memdup_sockptr
>            0        0 include/linux/sockptr.h:97 func:memdup_sockptr
>            0        0 net/sunrpc/auth_gss/auth_gss_internal.h:38
> func:simple_get_netobj
>            0        0 include/crypto/hash.h:586 func:ahash_request_alloc
>            0        0 include/net/netlink.h:1896 func:nla_memdup
>            0        0 include/crypto/skcipher.h:869 func:skcipher_request=
_alloc
>            0        0 include/net/fq_impl.h:361 func:fq_init
>            0        0 include/net/netlabel.h:316 func:netlbl_catmap_alloc
>
> and it finds our example:
>
>          832       13 include/linux/jbd2.h:1607 func:jbd2_alloc_inode
>
> Interestingly the inlined functions which are called from multiple
> places will have multiple entries with the same file+line:
>
>            0        0 include/linux/dma-fence-chain.h:91
> func:dma_fence_chain_alloc
>            0        0 include/linux/dma-fence-chain.h:91
> func:dma_fence_chain_alloc
>            0        0 include/linux/dma-fence-chain.h:91
> func:dma_fence_chain_alloc
>            0        0 include/linux/dma-fence-chain.h:91
> func:dma_fence_chain_alloc
>            0        0 include/linux/dma-fence-chain.h:91
> func:dma_fence_chain_alloc
>
> So, duplicate entries can be also used as an indication of an inlined all=
ocator.
> I'll go chase these down and will post a separate patch converting them.

I just posted https://lore.kernel.org/all/20240404165404.3805498-1-surenb@g=
oogle.com/
to report allocations done from the inlined functions in the headers
to their callers.
