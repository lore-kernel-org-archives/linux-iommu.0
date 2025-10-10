Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263BD26CE28
	for <iommu@lists.linux.dev>; Fri, 10 Oct 2025 22:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760134173; cv=none; b=BfVDojfE/1JujYNZBbb+BmCnIfzAqw9h8aRuDArszW2EVAQYRuHxPnhSmrFg9M3iwr3zhroDfDoagX4rISFOpiUvoaS1K24sApgBYdwRshIlMQndyd2py0NCzguQmaO8ScMGSOgyIEwRp471gh+cXSP5SPH7dTx5Mf6Y1/54CXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760134173; c=relaxed/simple;
	bh=whVp2qZBbeukaKmVgYtaHYfETEJJ1mPdQ4+rkrdkiFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RIlr3qkKEvGjg4yi7MaatyenrnXKO0PThrgmtctuIW/nYWQaCufMN1WrubxB/0XtyuEhUqaNJI7ToIKfazFIvS5+SRA4obJtWBvNabi4mfynOvPu1URZRijLfUTk2fdOReYpT7MpD8IXTydTeVUd3zy1Lof7V9PH9R3TvXxHCXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z0FqpvSO; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z0FqpvSO"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-42f6af58c39so239755ab.0
        for <iommu@lists.linux.dev>; Fri, 10 Oct 2025 15:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760134170; x=1760738970; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LWDl81NsDb6bdxq6lZZ3Oo5fI0gR9e+s7CI7q6rmrnY=;
        b=Z0FqpvSOLH4pxIyURk7TZpWE2A9Y9VKDoJ7Apiohyf7ZlFS9wUSSNtQSZxUBmhKgBY
         s2zP+Q0y5yai5Xd6GVsjiHqxqArV1aFbnwGLWvvp+V43XKrpOELDgT6A2mFfF8DaD/X5
         H3I5pnG7mzT0Ht6Vt4QTdtqzbkMKYHdD6VF3iIypzHOIBKYYF7ar8AkqJif5VmH5D0N8
         79FRPQcw1usYUsoQD5D77r5QJd1Tg1avE0T2dMYcHr56mDoJzxIXXV4deukqBD3NYblO
         msDAqK1RkTJ+GYMOU24Fvs7K+aMdgmU/0Fo0SYwMHMIjd9xUqQnZhcs4bE8ZQFaLgobD
         DmrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760134170; x=1760738970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LWDl81NsDb6bdxq6lZZ3Oo5fI0gR9e+s7CI7q6rmrnY=;
        b=unHbs4zzq/XMzhgcI/EPzgkNVVFxnNbPNRpRpE0VlJWSvYQF6LCCEFr48MZ7jxuokn
         Rar1aZG/q6sejJfrpWh30DWqtbn/LjBXD/Aq2D34BPMr7n7/sqv/pE3h4WmVy3KNs332
         XVoIj5mC912PKd8kP2uKJpZ1jzat+h3i3BzrwSuZwG50X8Ln+lNRPzXQdH08F6w3TFYX
         tJ4kAf1IBpQ6lEJiQ+Xc+5YLdNvcG0lHyqpfWxKP2kfkFz8+RlSKNMS2pDClynz0Zdc4
         B/rZVk55evZXEY2Ur8divWG6aIKmtrHEY2ZpZDDd5wC5c7sJmCYhfOzoMWoF5aHE1Cw5
         4CsA==
X-Forwarded-Encrypted: i=1; AJvYcCUN++DaYCl9LCS43WhuSbFWIGx6oB3MvSz7bAmpRmZ9NRjK6SMKmCtszLHopkX8fFauy9CE1A==@lists.linux.dev
X-Gm-Message-State: AOJu0YyE6p6YDk2Fbs/2DrOYJD/dFhp38Jdgp0qCHlzU6Wiusc+gYAvM
	Tv9kn4HaPChFsWDaAPWzUOp20E4f+1oawB+FNMvyhH8zSflf9xHD0/XXt8aqGAnVV9F6rxHD5lH
	5/txE6Wh8/TILakipq5kXresFJi3rkNKanCPU8xte
X-Gm-Gg: ASbGncvP4gqHSlCgMhU3G3oyRXrdYzmrOKw9of2BGUhSR49EdshJlxQvfmxWRBMEuew
	o3H8NsVHf9f/m+eewZR500WfRe101HtSg5EPtJguwgDpkIwa4M3kpqhB16wq3Puf5PXCYbsqrt5
	ez3nDUUux00/WJMMHhv2tkZBAMBe6WuW1fgeaEOW3tSg8IROwR6MJeEDTEqZaOb0LIzQlGjZM0+
	EXRB9hyFCA78kjE8I/c+G1tOUzn6kM=
X-Google-Smtp-Source: AGHT+IEheEysfffoa2UToJd25UhCG01OYZFDrESO0ecdrZ/jfSjqLqSlKoaOdjO8BC9OyiGuvNfvS8dJfmUrxJvS6qg=
X-Received: by 2002:a05:622a:1111:b0:4b3:1617:e617 with SMTP id
 d75a77b69052e-4e6eabcef17mr26585351cf.11.1760134169530; Fri, 10 Oct 2025
 15:09:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251010011951.2136980-7-surenb@google.com> <20251010202034.58002-1-sj@kernel.org>
In-Reply-To: <20251010202034.58002-1-sj@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 10 Oct 2025 15:09:18 -0700
X-Gm-Features: AS18NWAqrvtXxssXuPoUdtLG3YkWXccAtAeaTjudhXcSXDHpPbRX_NTpHoxKXI4
Message-ID: <CAJuCfpHmLpE-7U2_efn9XqK=3SM+zRw-jUkDgJRBW=2tWZTepg@mail.gmail.com>
Subject: Re: [PATCH 6/8] add cleancache documentation
To: SeongJae Park <sj@kernel.org>
Cc: akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, vbabka@suse.cz, alexandru.elisei@arm.com, 
	peterx@redhat.com, rppt@kernel.org, mhocko@suse.com, corbet@lwn.net, 
	axboe@kernel.dk, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	hch@infradead.org, jack@suse.cz, willy@infradead.org, 
	m.szyprowski@samsung.com, robin.murphy@arm.com, hannes@cmpxchg.org, 
	zhengqi.arch@bytedance.com, shakeel.butt@linux.dev, axelrasmussen@google.com, 
	yuanchu@google.com, weixugc@google.com, minchan@kernel.org, 
	linux-mm@kvack.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 1:20=E2=80=AFPM SeongJae Park <sj@kernel.org> wrote=
:
>
> Hello Suren,

Hi SJ!

>
> On Thu,  9 Oct 2025 18:19:49 -0700 Suren Baghdasaryan <surenb@google.com>=
 wrote:
>
> > Document cleancache, it's APIs and sysfs interface.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  Documentation/mm/cleancache.rst | 112 ++++++++++++++++++++++++++++++++
> >  MAINTAINERS                     |   1 +
>
> I think this great document is better to be linked on mm/index.rst.

Ack.

>
> Also, would it make sense to split the sysfs interface part and put under
> Documentation/admin-guide/mm/ ?

Hmm. I guess that makes sense.

>
> >  2 files changed, 113 insertions(+)
> >  create mode 100644 Documentation/mm/cleancache.rst
> >
> > diff --git a/Documentation/mm/cleancache.rst b/Documentation/mm/cleanca=
che.rst
> > new file mode 100644
> > index 000000000000..deaf7de51829
> > --- /dev/null
> > +++ b/Documentation/mm/cleancache.rst
> > @@ -0,0 +1,112 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +Cleancache
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Motivation
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Cleancache is a feature to utilize unused reserved memory for extendin=
g
> > +page cache.
> > +
> > +Cleancache can be thought of as a folio-granularity victim cache for c=
lean
> > +file-backed pages that the kernel's pageframe replacement algorithm (P=
FRA)
> > +would like to keep around, but can't since there isn't enough memory. =
So
> > +when the PFRA "evicts" a folio, it stores the data contained in the fo=
lio
> > +into cleancache memory which is not directly accessible or addressable=
 by
> > +the kernel (transcendent memory) and is of unknown and possibly
> > +time-varying size.
>
> IMHO, "(transcendent memory)" better to be dropped, as it has removed by =
commit
> 814bbf49dcd0 ("xen: remove tmem driver").

Ah, good point. Will remove.

>
> > +
> > +Later, when a filesystem wishes to access a folio in a file on disk, i=
t
> > +first checks cleancache to see if it already contains required data; i=
f it
> > +does, the folio data is copied into the kernel and a disk access is
> > +avoided.
> > +
> > +The memory cleancache uses is donated by other system components, whic=
h
> > +reserve memory not directly addressable by the kernel. By donating thi=
s
> > +memory to cleancache, the memory owner enables its utilization while i=
t
> > +is not used. Memory donation is done using cleancache backend API and =
any
> > +donated memory can be taken back at any time by its donor without no d=
elay
>
> "without delay" or "with no delay" ?

Ack. Will change to "without delay"

>
> > +and with guarantees success. Since cleancache uses this memory only to
> > +store clean file-backed data, it can be dropped at any time and theref=
ore
> > +the donor's request to take back the memory can be always satisfied.
> > +
> > +Implementation Overview
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Cleancache "backend" (donor that provides transcendent memory), regist=
ers
>
> Again, "transcendent memory" part seems better to be dropped.

Ack.

>
> > +itself with cleancache "frontend" and received a unique pool_id which =
it
> > +can use in all later API calls to identify the pool of folios it donat=
es.
> > +Once registered, backend can call cleancache_backend_put_folio() or
> > +cleancache_backend_put_folios() to donate memory to cleancache. Note t=
hat
> > +cleancache currently supports only 0-order folios and will not accept
> > +larger-order ones. Once the backend needs that memory back, it can get=
 it
> > +by calling cleancache_backend_get_folio(). Only the original backend c=
an
> > +take the folio it donated from the cleancache.
> > +
> > +Kernel uses cleancache by first calling cleancache_add_fs() to registe=
r
> > +each file system and then using a combination of cleancache_store_foli=
o(),
> > +cleancache_restore_folio(), cleancache_invalidate_{folio|inode} to sto=
re,
> > +restore and invalidate folio content.
> > +cleancache_{start|end}_inode_walk() are used to walk over folios insid=
e
> > +an inode and cleancache_restore_from_inode() is used to restore folios
> > +during such walks.
> > +
> > +From kernel's point of view folios which are copied into cleancache ha=
ve
> > +an indefinite lifetime which is completely unknowable by the kernel an=
d so
> > +may or may not still be in cleancache at any later time. Thus, as its =
name
> > +implies, cleancache is not suitable for dirty folios. Cleancache has
> > +complete discretion over what folios to preserve and what folios to di=
scard
> > +and when.
> > +
> > +Cleancache Performance Metrics
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> > +
> > +If CONFIG_CLEANCACHE_SYSFS is enabled, monitoring of cleancache perfor=
mance
> > +can be done via sysfs in the `/sys/kernel/mm/cleancache` directory.
> > +The effectiveness of cleancache can be measured (across all filesystem=
s)
> > +with provided stats.
> > +Global stats are published directly under `/sys/kernel/mm/cleancache` =
and
> > +include:
>
> ``/sys/kernel/mm/cleancache`` ?

Ack.

>
> > +
> > +``stored``
> > +     number of successful cleancache folio stores.
> > +
> > +``skipped``
> > +     number of folios skipped during cleancache store operation.
> > +
> > +``restored``
> > +     number of successful cleancache folio restore operations.
> > +
> > +``missed``
> > +     number of failed cleancache folio restore operations.
> > +
> > +``reclaimed``
> > +     number of folios reclaimed from the cleancache due to insufficien=
t
> > +     memory.
> > +
> > +``recalled``
> > +     number of times cleancache folio content was discarded as a resul=
t
> > +     of the cleancache backend taking the folio back.
> > +
> > +``invalidated``
> > +     number of times cleancache folio content was discarded as a resul=
t
> > +     of invalidation.
> > +
> > +``cached``
> > +     number of folios currently cached in the cleancache.
> > +
> > +Per-pool stats are published under `/sys/kernel/mm/cleancache/<pool na=
me>`
>
> ``/sys/kernel/mm/cleancache/<pool name>`` ?

Ack.

>
> > +where "pool name" is the name pool was registered under. These stats
> > +include:
> > +
> > +``size``
> > +     number of folios donated to this pool.
> > +
> > +``cached``
> > +     number of folios currently cached in the pool.
> > +
> > +``recalled``
> > +     number of times cleancache folio content was discarded as a resul=
t
> > +     of the cleancache backend taking the folio back from the pool.
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 1c97227e7ffa..441e68c94177 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -6053,6 +6053,7 @@ CLEANCACHE
> >  M:   Suren Baghdasaryan <surenb@google.com>
> >  L:   linux-mm@kvack.org
> >  S:   Maintained
> > +F:   Documentation/mm/cleancache.rst
> >  F:   include/linux/cleancache.h
> >  F:   mm/cleancache.c
> >  F:   mm/cleancache_sysfs.c
> > --
> > 2.51.0.740.g6adb054d12-goog
>
>
> Thanks,
> SJ

Thanks for the review!
