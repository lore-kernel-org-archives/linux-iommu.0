Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780CDED2
	for <iommu@lists.linux.dev>; Wed,  3 May 2023 09:45:02 +0000 (UTC)
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-5f6058c0761so21461346d6.1
        for <iommu@lists.linux.dev>; Wed, 03 May 2023 02:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683107101; x=1685699101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vu1/caV96gPScaPWMCtnkWIUIUcxiUGOiQt9hLifgPw=;
        b=VhDxBqzjRGO4xEvrUoTELhpqFpNqdt+CVDZ+RfOG21FgkmixgwMMdwK/NneQ7mOOcc
         yhGPzgIBNau3G+2U9K7Xt4a9gdggrYOnkpWS/wNla11FYYg09l2IaImcnU5+b9MibRcR
         k9v90h1Rsd7vskA6KQe8SRuvpU0sLUxitSFfsDPXj87uFGSdWAnrfcOx/eIuqMMyzqhk
         CZB3LVF8x3HzsHEtVrXZagn8mwxC1GFztjcfWkPZzT8tLdcTHbvRug9Ltx2dxhrAfuC2
         +waxUOke8lDu/8kEPIx91rOnvSt36w2a70UZk/8uywir3znA4RllKMN+w9ENvaPVPtXq
         x7ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683107101; x=1685699101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vu1/caV96gPScaPWMCtnkWIUIUcxiUGOiQt9hLifgPw=;
        b=TABJ8s+vB4avC8DxFkhOU5hDKH29Z8kIkNne7hLMQmzgROu1POF8OSjUBIGhsAi3nI
         Env5vpTLjCZA0awgIYbyoicXSFsOzHx/NoKlaG6fp/z7EAcU9VpcrBmIXrBZ9O2J2N69
         LGaHI2dhjKc4nFA15o1dU90ht5McTxVLERkgazr2lAY/ITX8nt+t5lKWOfXhBjypTMW0
         Lp4jCGF/hz9pZtwHZWqP4trdAJ10+Hh+orgM5ZpUf59C6uLXW/w1lQUnRbFTbCFtYdMO
         9SxsFOatDj3uAR3kthymCtfnOdREgBqmX1KaEmL6NNh9xh060oe+44ufHHUPcqwFuleN
         EZHg==
X-Gm-Message-State: AC+VfDxj2RbuQhnhXBj2keGcEN69/dpWoJ0/b+pYtnPmjEDWgu8/aZfn
	N+Dd0Tt32yNvo+/ZUpAsi/AofAWf+XMeKvMXYlU=
X-Google-Smtp-Source: ACHHUZ6yi+LLZmqHyLDaoBpk27DTVexvbnD/0m840PDBVgRRMFVAguYf3NnMhxz4oEixavoWuRx1ThmZystGlNmkfIs=
X-Received: by 2002:a05:6214:2629:b0:61b:17bd:c603 with SMTP id
 gv9-20020a056214262900b0061b17bdc603mr10563566qvb.9.1683107101117; Wed, 03
 May 2023 02:45:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230501165450.15352-1-surenb@google.com> <20230501165450.15352-2-surenb@google.com>
 <ouuidemyregstrijempvhv357ggp4tgnv6cijhasnungsovokm@jkgvyuyw2fti>
 <ZFAUj+Q+hP7cWs4w@moria.home.lan> <b6b472b65b76e95bb4c7fc7eac1ee296fdbb64fd.camel@HansenPartnership.com>
 <ZFCA2FF+9MI8LI5i@moria.home.lan> <2f5ebe8a9ce8471906a85ef092c1e50cfd7ddecd.camel@HansenPartnership.com>
 <20230502225016.GJ2155823@dread.disaster.area> <b6857aad-4cfc-4961-df54-6e658fca7f75@suse.cz>
In-Reply-To: <b6857aad-4cfc-4961-df54-6e658fca7f75@suse.cz>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 3 May 2023 12:44:24 +0300
Message-ID: <CAHp75VddBGrrkRGQcU=ZOXANaj2SznPGG4eQ8Q2NrGYbLK7Xog@mail.gmail.com>
Subject: Re: [PATCH 01/40] lib/string_helpers: Drop space in string_get_size's output
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Dave Chinner <david@fromorbit.com>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org, 
	mhocko@suse.com, hannes@cmpxchg.org, roman.gushchin@linux.dev, 
	mgorman@suse.de, willy@infradead.org, liam.howlett@oracle.com, corbet@lwn.net, 
	void@manifault.com, peterz@infradead.org, juri.lelli@redhat.com, 
	ldufour@linux.ibm.com, catalin.marinas@arm.com, will@kernel.org, 
	arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
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
	cgroups@vger.kernel.org, Andy Shevchenko <andy@kernel.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, 
	Paul Mackerras <paulus@samba.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	=?UTF-8?B?Tm9yYWxmIFRyw6/Cv8K9bm5lcw==?= <noralf@tronnes.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 3, 2023 at 12:28=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 5/3/23 00:50, Dave Chinner wrote:
> > On Tue, May 02, 2023 at 07:42:59AM -0400, James Bottomley wrote:
> >> On Mon, 2023-05-01 at 23:17 -0400, Kent Overstreet wrote:
> >> > On Mon, May 01, 2023 at 10:22:18PM -0400, James Bottomley wrote:
> >> > > It is not used just for debug.  It's used all over the kernel for
> >> > > printing out device sizes.  The output mostly goes to the kernel
> >> > > print buffer, so it's anyone's guess as to what, if any, tools are
> >> > > parsing it, but the concern about breaking log parsers seems to be
> >> > > a valid one.
> >> >
> >> > Ok, there is sd_print_capacity() - but who in their right mind would
> >> > be trying to scrape device sizes, in human readable units,
> >>
> >> If you bother to google "kernel log parser", you'll discover it's quit=
e
> >> an active area which supports a load of company business models.
> >
> > That doesn't mean log messages are unchangable ABI. Indeed, we had
> > the whole "printk_index_emit()" addition recently to create
> > an external index of printk message formats for such applications to
> > use. [*]
> >
> >> >  from log messages when it's available in sysfs/procfs (actually, is
> >> > it in sysfs? if not, that's an oversight) in more reasonable units?
> >>
> >> It's not in sysfs, no.  As aren't a lot of things, which is why log
> >> parsing for system monitoring is big business.
> >
> > And that big business is why printk_index_emit() exists to allow
> > them to easily determine how log messages change format and come and
> > go across different kernel versions.
> >
> >> > Correct me if I'm wrong, but I've yet to hear about kernel log
> >> > messages being consider a stable interface, and this seems a bit out
> >> > there.
> >>
> >> It might not be listed as stable, but when it's known there's a large
> >> ecosystem out there consuming it we shouldn't break it just because yo=
u
> >> feel like it.
> >
> > But we've solved this problem already, yes?
> >
> > If the userspace applications are not using the kernel printk format
> > index to detect such changes between kernel version, then they
> > should be. This makes trivial issues like whether we have a space or
> > not between units is completely irrelevant because the entry in the
> > printk format index for the log output we emit will match whatever
> > is output by the kernel....
>
> If I understand that correctly from the commit changelog, this would have
> indeed helped, but if the change was reflected in format string. But with
> string_get_size() it's always an %s and the change of the helper's or a
> switch to another variant of the helper that would omit the space, wouldn=
't
> be reflected in the format string at all? I guess that would be an argume=
nt
> for Andy's suggestion for adding a new %pt / %pT which would then be

(Note, there is no respective %p extension for string_get_size() yet.
%pt is for time and was used as an example when its evolution included
a change like this)

> reflected in the format string. And also more concise to use than using t=
he
> helper, fwiw.



--=20
With Best Regards,
Andy Shevchenko
