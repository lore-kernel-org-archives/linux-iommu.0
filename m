Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67589D521
	for <iommu@lists.linux.dev>; Wed,  3 May 2023 14:32:10 +0000 (UTC)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-b9d8b458e10so7223642276.1
        for <iommu@lists.linux.dev>; Wed, 03 May 2023 07:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683124329; x=1685716329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HEvcpQRFstUtOR1Eu0GIXU3Feju4Sch+HPMbK8t4eZw=;
        b=YYnwd/M3xcBLc1VRnRyKFD9vkc0d2D3qgDDL79EsNRxNCa7TxdjY6Vm/bTYHRcE7zH
         T2JnRgsSoDgD7n4yPCSwILW+e/MLYDFGyYpwoik0lQZdi5X0T2moaEEdeGV9ciw/MI5/
         NOPLZ5QZ+txodD+d3urnPo1XZ7TbBY075JJgIj1bS5xtW/81qQMZFGqCUr2UqiRf22Np
         dbsSB0cEyq+/tGKFKGpOF1Jek93XjSTP2B0edRqRQbK7PoGDQgU8172qBF8QZwxPtO5N
         hOZVk15gzUMXIBEGld86wkoLF3lnnLnX9ksExP2peH7/jtY9tNGoj+EOq+rXAzkp7Swk
         j/fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683124329; x=1685716329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HEvcpQRFstUtOR1Eu0GIXU3Feju4Sch+HPMbK8t4eZw=;
        b=gwOoUCiw1IT35Ul6v9GZSxg29owdBqm9/3hWyVLDVnwO2U4iKT+USSuUG4mUclWQwv
         2wDJ6NalAVl8S7mp5bVd5O/VjhUispUZRsYdXVJoKPbeJqXLPTQS/Cz2M0Ul7TAjZkym
         x/sY0V/6AeD7Ny1dn54z+diJAAd6GjLyPuv9ld4PzIYaU3VbO1Pmkgiill/yFcTgC1Sp
         8XhTjWmXK9c9aatt1oY/CUPx0HymThWqFgm09UUqVUCL3vdv0Gh4ajz6/sLipaMvFTwc
         1GNwCUuCmy/rzVoPF0Mvke1sG7OvDePtBnOdq+4BNBUtfX7XR7pRuetU2c5b6LEoU5nn
         2mAg==
X-Gm-Message-State: AC+VfDww6Qf1Ekxtr7Vs5ixJ4WAyHN0QUHVK+Kl9Sa38/+RS0i7Y/pa6
	6a8cJA156ddojDxfUYIFJ2X4DojXrQiG4k2s4dgTxg==
X-Google-Smtp-Source: ACHHUZ62ugyZVwsnHBXMYjdbiWqDWizXIg764GF6n5Kz8ZrSC3IwTZiC2PVdnW1kxB49Xblr0EH+rbJRRflkUY+jBA4=
X-Received: by 2002:a25:7356:0:b0:b9d:de23:3c27 with SMTP id
 o83-20020a257356000000b00b9dde233c27mr12904071ybc.9.1683124329016; Wed, 03
 May 2023 07:32:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230501165450.15352-1-surenb@google.com> <ZFIMaflxeHS3uR/A@dhcp22.suse.cz>
 <ZFIOfb6/jHwLqg6M@moria.home.lan> <ZFISlX+mSx4QJDK6@dhcp22.suse.cz>
 <20230503115051.30b8a97f@meshulam.tesarici.cz> <ZFIv+30UH7+ySCZr@moria.home.lan>
 <25a1ea786712df5111d7d1db42490624ac63651e.camel@HansenPartnership.com>
In-Reply-To: <25a1ea786712df5111d7d1db42490624ac63651e.camel@HansenPartnership.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 3 May 2023 07:31:57 -0700
Message-ID: <CAJuCfpFZHOLxhrimPbLg+MjyzLR7U=C2Nk+i5Jc+-ZaNvnVu8Q@mail.gmail.com>
Subject: Re: [PATCH 00/40] Memory allocation profiling
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?= <petr@tesarici.cz>, 
	Michal Hocko <mhocko@suse.com>, akpm@linux-foundation.org, vbabka@suse.cz, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	corbet@lwn.net, void@manifault.com, peterz@infradead.org, 
	juri.lelli@redhat.com, ldufour@linux.ibm.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com, 
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com, 
	hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org, 
	ndesaulniers@google.com, gregkh@linuxfoundation.org, ebiggers@google.com, 
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

On Wed, May 3, 2023 at 5:34=E2=80=AFAM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Wed, 2023-05-03 at 05:57 -0400, Kent Overstreet wrote:
> > On Wed, May 03, 2023 at 11:50:51AM +0200, Petr Tesa=C5=99=C3=ADk wrote:
> > > If anyone ever wants to use this code tagging framework for
> > > something
> > > else, they will also have to convert relevant functions to macros,
> > > slowly changing the kernel to a minefield where local identifiers,
> > > struct, union and enum tags, field names and labels must avoid name
> > > conflict with a tagged function. For now, I have to remember that
> > > alloc_pages is forbidden, but the list may grow.
> >
> > Also, since you're not actually a kernel contributor yet...
>
> You have an amazing talent for being wrong.  But even if you were
> actually right about this, it would be an ad hominem personal attack on
> a new contributor which crosses the line into unacceptable behaviour on
> the list and runs counter to our code of conduct.

Kent, I asked you before and I'm asking you again. Please focus on the
technical discussion and stop personal attacks. That is extremely
counter-productive.

>
> James
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>
