Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBB5654
	for <iommu@lists.linux.dev>; Tue,  2 May 2023 05:34:35 +0000 (UTC)
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-61a62fc8b5bso19030666d6.2
        for <iommu@lists.linux.dev>; Mon, 01 May 2023 22:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683005674; x=1685597674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qrcuuma9akhRKA9cVsiv9Wp3Fts3/L+OpcqEI96PfXk=;
        b=QF1HVjPTepvbrQ9oJRLkb6f8AJvX+hO2zQE2ZY/l3fUgEFOfqL1wf8m0RGFQ4awGlN
         sWkxd9j28poLLl8dBgEc54m1kLx91P31/J3vbCIAx0/CoGXAsbwCOE363uYJGP9GkB5b
         3lymi+vNqj9QoS17H6nGkbM5o+IGDFDB9cd/G6K1hJSdkvWt972kMNAdb/+wzno7m9jZ
         f0XwZxnSXtuHXZc3vW87bizP3VIj3Spc6/Cesx4fCw9piQPSAItNDleA+xpCa+67Mn+G
         vzbu6giNBfMNRicZ3wSxkGrbLyqmcdrr5AdLiwR1ViUDz037I1qTRRGrjMrCbz3a2XiY
         9TDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683005674; x=1685597674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qrcuuma9akhRKA9cVsiv9Wp3Fts3/L+OpcqEI96PfXk=;
        b=kPo+9v1W36lGj09hqAkOK5pDgEL0vb2gZijWqw5vJlMhJNlV+LfIjQzysbbMlcDZ62
         H448JpICnFwk6XxuWeGiXY1+DwlJoCUdlZ7HVgneJP4nMdJyiUOSHNx9hMD7wI2spK06
         8hti4C13IZTXT6YIO9mYeXNY2gAAZfHgbEP7sXi186AOQ5ZjyFjiUfUYdtc/38JowEjT
         MA9Hu4vOYQlWcKO8BCQWgyCK+nAm2kXqJWyUCFNr/wTmU+Tszr+NNJmODPpCm7KZ4FNf
         zaN07dRQ1zYhPLqHNc2s/wqh/Q48eTMdznV+oKEDyqVbQoekSjzWzKGljywbNlBdRdTB
         Mu9Q==
X-Gm-Message-State: AC+VfDw3HVQv9U9db+oSp2YHSR9/tsTV/zxIrzp+cU68M01+2UEA2hgA
	F1xUAZ/z5VWh9jn49J+EB2iGlYqQW2iUmBZziLg=
X-Google-Smtp-Source: ACHHUZ6UI2cU+vYPscYDDBkkT3Plhp9qvN6okFjmkrVKfQQGe2MFQv7qiNq0uAhkrc7LvrOfXehK4e+SQ+W+CPsbV3k=
X-Received: by 2002:a05:6214:d04:b0:56e:aeaa:95b2 with SMTP id
 4-20020a0562140d0400b0056eaeaa95b2mr3054068qvh.9.1683005674261; Mon, 01 May
 2023 22:34:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230501165450.15352-1-surenb@google.com> <20230501165450.15352-2-surenb@google.com>
 <ouuidemyregstrijempvhv357ggp4tgnv6cijhasnungsovokm@jkgvyuyw2fti>
 <ZFAUj+Q+hP7cWs4w@moria.home.lan> <b6b472b65b76e95bb4c7fc7eac1ee296fdbb64fd.camel@HansenPartnership.com>
 <ZFCA2FF+9MI8LI5i@moria.home.lan>
In-Reply-To: <ZFCA2FF+9MI8LI5i@moria.home.lan>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 2 May 2023 08:33:57 +0300
Message-ID: <CAHp75VdK2bgU8P+-np7ScVWTEpLrz+muG-R15SXm=ETXnjaiZg@mail.gmail.com>
Subject: Re: [PATCH 01/40] lib/string_helpers: Drop space in string_get_size's output
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org, mhocko@suse.com, 
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	willy@infradead.org, liam.howlett@oracle.com, corbet@lwn.net, 
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

On Tue, May 2, 2023 at 6:18=E2=80=AFAM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
> On Mon, May 01, 2023 at 10:22:18PM -0400, James Bottomley wrote:

...

> > > If someone raises a specific objection we'll do something different,
> > > otherwise I think standardizing on what userspace tooling already
> > > parses is a good idea.
> >
> > If you want to omit the space, why not simply add your own variant?  A
> > string_get_size_nospace() which would use most of the body of this one
> > as a helper function but give its own snprintf format string at the
> > end.  It's only a couple of lines longer as a patch and has the bonus
> > that it definitely wouldn't break anything by altering an existing
> > output.
>
> I'm happy to do that - I just wanted to post this version first to see
> if we can avoid the fragmentation and do a bit of standardizing with
> how everything else seems to do that.

Actually instead of producing zillions of variants, do a %p extension
to the printf() and that's it. We have, for example, %pt with T and
with space to follow users that want one or the other variant. Same
can be done with string_get_size().

--=20
With Best Regards,
Andy Shevchenko
