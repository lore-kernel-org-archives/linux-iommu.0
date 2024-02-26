Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C06C12DDAB
	for <iommu@lists.linux.dev>; Mon, 26 Feb 2024 17:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708969747; cv=none; b=CcvLa8Nxon1Fj3USx3WlTe3ZqyWkpOEgIdcwysr9YflQEBTrF9KTttFBLIGDkKFEPOc5Dd8KZXuxbWjzQf50HWsiVgQTiKw604oEhrryDz6i153Ej+RUxbrROs+T5UziX5/8JEEFH5WGuYpBxF1fYHOOoM51f+ttWQaj5bUvo+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708969747; c=relaxed/simple;
	bh=kjTgbrtrQFudnQ2Ks1fdChZ9nj/O1JwPt17wu4Lp+yo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XfIykhA66WVzuYMqxMeup0QC9YM0FGYINz1M2WoTjb/jx6Nu2PsOXNbZTpGOLAtgVWEooTJB5uluS0+GcZlaTlbCI63kCZLMWmaHTuBfybsCClJAgXcSQDPbwyyogY9flTIzDPcvkMiOvP+BOyAjp/h6NZ/RSEJ9l99134107xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dPZOry64; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dPZOry64"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d269b2ff48so38457001fa.3
        for <iommu@lists.linux.dev>; Mon, 26 Feb 2024 09:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708969742; x=1709574542; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E2MfOrnw8vcrCKgg1+LRA9aXdiQ7KcRVPoPiOl2oNZk=;
        b=dPZOry64vOzEu8vacfkeCy1vH0ZSYZqfo3rqvHA2Tj0GzNSnKBo28PwyDinWnKcCTN
         1RoyRI0hHjnCckJ2qW3Ioe1iBTzZD5LCHxFUkNDcEtbeoAvA5MNzcMeTB0rOf+6PlpwS
         6qjanUzSOsn2pGiNh6/2eCUaVjJYPHXqWB5kjKowN7lUmgj2HYPjrxWnuTUVVy0T+7aE
         x/X5MBqZ4vvu6ez/kLGULALDmmah4VYmJf5XpGG9I7lap5tpxldqXBbZDW6O3Upykmky
         w+V8eNQceXKDvRgi6U/EAkZxJ1XQ7bOLQjJ1FEKeFPZWm36uK/onALyuIw3hyMSeIfKb
         Xbig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708969742; x=1709574542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E2MfOrnw8vcrCKgg1+LRA9aXdiQ7KcRVPoPiOl2oNZk=;
        b=aNWWaLfgUUiUjIeQEwkmNvkRGcN+PWgrgN8v56KsqWiu0JyHNkBXczLjMUUHytrMic
         cXL14e6HWliTwP2Wu+v3IFq2dRQJkmesAP4VktTXPeSLHNi2IGplv+x/VvwtNW/cFXid
         gF4e6JfJEftWZRg40EHHC2m72g2HNVdWN+m3Q1XUJnZA/W3PDDWjYn9q98IQncywMp2t
         uokqdQXV6DdIj6g8cACYhbzuxx1XtLhcXRRPCVvCljIEsSjkscexIWolnGw0Q44Yjinm
         JNFsWB7I8VHNu7I+X8p5eXVMnU/8iG5bT1sS6Iya9UMTXx0+58Bx+uzATz3SEjvBQTaY
         7pEA==
X-Forwarded-Encrypted: i=1; AJvYcCX8ScxPbZilyKi2dsKbugKCF2ZHGfNbB1As4nUtLIB8ENW08+R6mqgoWjsOgAWx4lJ1P83XiRgWi9mUF11I4cQ/VCdKMgk=
X-Gm-Message-State: AOJu0YyUKl21YUrP8zDgGZQRoLidcE5xYrS52DSFv6SS7y1+lGYcL+FD
	ck/55QQCRCYyV+hFaw+l2TcRf2ZR9WTcnJxEo88jpMqTzkz80ExUTQJhXTpfNNa4+sb8JrG8R1D
	WTBgzjUxKUg8pz9UwSKjXzy5zbWbUBl+bYMap
X-Google-Smtp-Source: AGHT+IGMkZ+7cEJwol9OFFnPnlkwO7m64F/71T4BMwZRitgeDSyoz1rib12v0dNYQtXiC2DOXiB0AGgmNnmExOErSa0=
X-Received: by 2002:a2e:b889:0:b0:2d2:6676:3b0f with SMTP id
 r9-20020a2eb889000000b002d266763b0fmr6282519ljp.22.1708969741996; Mon, 26 Feb
 2024 09:49:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com> <20240221194052.927623-6-surenb@google.com>
 <f68e7f17-c288-4dc9-9ae9-78015983f99c@suse.cz>
In-Reply-To: <f68e7f17-c288-4dc9-9ae9-78015983f99c@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 26 Feb 2024 09:48:46 -0800
Message-ID: <CAJuCfpEQPgg6-TD+-PEsVRXnK=T0Ak6TvMiwz7DbS-q9YxsVcg@mail.gmail.com>
Subject: Re: [PATCH v4 05/36] fs: Convert alloc_inode_sb() to a macro
To: Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
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
	cgroups@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 7:44=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 2/21/24 20:40, Suren Baghdasaryan wrote:
> > From: Kent Overstreet <kent.overstreet@linux.dev>
> >
> > We're introducing alloc tagging, which tracks memory allocations by
> > callsite. Converting alloc_inode_sb() to a macro means allocations will
> > be tracked by its caller, which is a bit more useful.
> >
> > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > ---
> >  include/linux/fs.h | 6 +-----
> >  1 file changed, 1 insertion(+), 5 deletions(-)
> >
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index 023f37c60709..08d8246399c3 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -3010,11 +3010,7 @@ int setattr_should_drop_sgid(struct mnt_idmap *i=
dmap,
> >   * This must be used for allocating filesystems specific inodes to set
> >   * up the inode reclaim context correctly.
> >   */
> > -static inline void *
> > -alloc_inode_sb(struct super_block *sb, struct kmem_cache *cache, gfp_t=
 gfp)
>
> A __always_inline wouldn't have the same effect? Just wondering.

I think inlining it would still keep __LINE__ and __FILE__ pointing to
this location in the header instead of the location where the call
happens. If we change alloc_inode_sb() to inline we will have to wrap
it with alloc_hook() and call kmem_cache_alloc_lru_noprof() inside it.
Doable but this change seems much simpler.

>
> > -{
> > -     return kmem_cache_alloc_lru(cache, &sb->s_inode_lru, gfp);
> > -}
> > +#define alloc_inode_sb(_sb, _cache, _gfp) kmem_cache_alloc_lru(_cache,=
 &_sb->s_inode_lru, _gfp)
> >
> >  extern void __insert_inode_hash(struct inode *, unsigned long hashval)=
;
> >  static inline void insert_inode_hash(struct inode *inode)
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>
