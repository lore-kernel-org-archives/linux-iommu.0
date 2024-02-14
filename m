Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB9C19472
	for <iommu@lists.linux.dev>; Wed, 14 Feb 2024 20:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707942665; cv=none; b=ONZ2PdcPGjGhRY1KjHNiIVnQbl9xvSewJeY08+Sfd+B5hCXuGFP9q+eFZ2ee5hdhJigXjb3CN42f3649dmkOBxfPDtNma5Zyb13wXDsW9D3c4m9pFdrtywdFBt2Z+QdlVVGBU6QveuKV5mYDIaqe4BpJghWvgv5iu49I75p4YH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707942665; c=relaxed/simple;
	bh=Vd0j1FX9Ch3W6HoLjw5jsyZYk+r6JPnPHoqpsjH65ZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QrobwqNGW1435jvJFVaeWq36AhFhptfdN1OH1GYK9Azabe3cAJBNKWBumPGZRkVDiXssd4OjK43S1FHOXFYJIVyI+WBDMF7xB21vvu9aZqyBf3Uholf3oQSIYUWNoFWwQtOj+C3PA2Y3m3XCXxXlzedim3F3SACdYaHt5J4/W+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ClFaRg5v; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ClFaRg5v"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dcc80d6004bso106510276.0
        for <iommu@lists.linux.dev>; Wed, 14 Feb 2024 12:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707942662; x=1708547462; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NcEj/SyVb+AY5aiDL6vEY+YAlLL1EeaxcCrjK4Q+5oY=;
        b=ClFaRg5v4n4YA/CqYiY2C9k9D++gF50PPR+fgwDYKsPoHhoN8Ji2/MfKkAhVrSXel6
         85Vd9rfMmdx9qHc/l69+Oif/YOZ8aoMmGykuRRjZrt8fHiJ0VSIW8SInWPgKG3zKF8LJ
         rEMdjEp54Izu7P21gqfL0VSFGvfhXKxAhILAwc6dTOH8TblRwhuFMJc8qn69mVArRAsb
         RvKkylxdVclmtdbbtCB7x5iVxnPtcTQ0bnYxGxaalwLTHG8aokTvMKlD8MCqxsAEkrYN
         7b0I9TckT9naRU4o/vbF1Li4Z1G1FAS7mNST5FdBDOOkiG/3Wg5uuHTp2Hf8BVI9FSOS
         M8Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707942662; x=1708547462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NcEj/SyVb+AY5aiDL6vEY+YAlLL1EeaxcCrjK4Q+5oY=;
        b=sOBfGadIiimqgb/vboxXd8OU+tpa+ofSVd7GmQUIiL73kVXeTtx/tmWSUQvsG1jquf
         NzabpHOZK4c0mG/uwb6TC5pFKwekSEImaG9G7O0a+vMTO8rG8QaTb71ZutZqMq5qsRyv
         EhT9sDzQjC/A67S0ikozm0OpKlvoLEC5QCcd+SCeUNLekEyPUBoPBmf9RbYgHGBErPmo
         hJW/vG+5FHwSVODnAP5LNPBlheqt6I+lbmcvGBF9W1jIzSBUUXzF7k2vPJhBFPDAbPIz
         XnJzkruXJxQkJ/MqAv2lk45bWrQE5bmy6XkVid7SzIvxvI0B1tkY4gHFEtC/NssANmiP
         ghOw==
X-Forwarded-Encrypted: i=1; AJvYcCVloRqDmj+uFIl1eSlzAn9gKbhjjBCrJfwZzWxHvkKcU2FwmcVau2dZeZ8MTgm5FvXRXHqJwe4ElhUSQh/EytK72991fho=
X-Gm-Message-State: AOJu0YwxRVpzcKtPIaq/ThNqcf1imoSUqdiqocr8WOJpGUTBWVsz8pWG
	1gCXBoiySKAn2TNATFt8PArm63Q4HO7sv3plQNByCF+RpXuEOMca5o15jfVqmMkVsW0e8Mw+po7
	0iKaKCRIYQRZraezz6C9Kd2Lfsnm52d7TkJ1E
X-Google-Smtp-Source: AGHT+IFqoJj5aCwpmg00G6ZaLb2aiZ8b3im8fm6yEl4ijg46+lI254clzZhzLZ0Iv0kb6bhFH6lVLC2hnoLSZAsSoRU=
X-Received: by 2002:a25:4115:0:b0:dc6:bbeb:d889 with SMTP id
 o21-20020a254115000000b00dc6bbebd889mr3283052yba.52.1707942662262; Wed, 14
 Feb 2024 12:31:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240212213922.783301-1-surenb@google.com> <4f24986587b53be3f9ece187a3105774eb27c12f.camel@linux.intel.com>
 <CAJuCfpGnnsMFu-2i6-d=n1N89Z3cByN4N1txpTv+vcWSBrC2eg@mail.gmail.com> <Zc0f7u5yCq-Iwh3A@google.com>
In-Reply-To: <Zc0f7u5yCq-Iwh3A@google.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 14 Feb 2024 12:30:49 -0800
Message-ID: <CAJuCfpEbdC4k=4aeEO=YfX2tZhkdOVaehAv9Ts7S42B_bmm=Ow@mail.gmail.com>
Subject: Re: [PATCH v3 00/35] Memory allocation profiling
To: Yosry Ahmed <yosryahmed@google.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 12:17=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com=
> wrote:
>
> > > > Performance overhead:
> > > > To evaluate performance we implemented an in-kernel test executing
> > > > multiple get_free_page/free_page and kmalloc/kfree calls with alloc=
ation
> > > > sizes growing from 8 to 240 bytes with CPU frequency set to max and=
 CPU
> > > > affinity set to a specific CPU to minimize the noise. Below are res=
ults
> > > > from running the test on Ubuntu 22.04.2 LTS with 6.8.0-rc1 kernel o=
n
> > > > 56 core Intel Xeon:
> > > >
> > > >                         kmalloc                 pgalloc
> > > > (1 baseline)            6.764s                  16.902s
> > > > (2 default disabled)    6.793s (+0.43%)         17.007s (+0.62%)
> > > > (3 default enabled)     7.197s (+6.40%)         23.666s (+40.02%)
> > > > (4 runtime enabled)     7.405s (+9.48%)         23.901s (+41.41%)
> > > > (5 memcg)               13.388s (+97.94%)       48.460s (+186.71%)
> >
> > (6 default disabled+memcg)    13.332s (+97.10%)         48.105s (+184.6=
1%)
> > (7 default enabled+memcg)     13.446s (+98.78%)       54.963s (+225.18%=
)
>
> I think these numbers are very interesting for folks that already use
> memcg. Specifically, the difference between 6 & 7, which seems to be
> ~0.85% and ~14.25%. IIUC, this means that the extra overhead is
> relatively much lower if someone is already using memcgs.

Well, yes, percentage-wise it's much lower. If you look at the
absolute difference between 6 & 7 vs 2 & 3, it's quite close.

>
> >
> > (6) shows a bit better performance than (5) but it's probably noise. I
> > would expect them to be roughly the same. Hope this helps.
> >
> > > >
> > >
> > >
