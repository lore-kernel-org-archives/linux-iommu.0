Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9561733EA
	for <iommu@lists.linux.dev>; Tue,  2 May 2023 15:20:04 +0000 (UTC)
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-74df41e2e61so187313085a.3
        for <iommu@lists.linux.dev>; Tue, 02 May 2023 08:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683040803; x=1685632803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2UFtU6oUaOr0vAs1hqgYmpK0GvH9Lqd4XIp3l76+ytw=;
        b=fQDTcAPBcFMm48S9mQhBubJHQt6Rf9v6Z4dCuVwj56NHh0dP3ICDHdXuGTZQ7fhY6f
         NVwsf2cgqzJ2oTH5E3+K89qprKrCbOGTByhEvyoyI4jzL38CLohj4Pemx6+zekp7fjIC
         C0wfN5ZD3wmwhLkep7s0ZqbRXr8rVSrCyB0q6Z4CQD4ucuL/biAEe5lz0MuYDAeeY6uB
         gtH3nfcpQt9FqSzoPBxOU/XU4QDMDDdYIjdcF09D6jE8LNvs6UBNJcq1K4MKCbG+pFI5
         zN03kdFjS2HNT9cI3ETBPM+TTHt6uAO2dPGj9O13t7gNwcK/SiD5lyjyY8em9DO5HFop
         7wkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683040803; x=1685632803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2UFtU6oUaOr0vAs1hqgYmpK0GvH9Lqd4XIp3l76+ytw=;
        b=VPuKQWAXf1SlX+gcPrTTCFNcLC9LFNy11S7M/dF4GZWgwF6L+Hgzbnq5/A2O8v9LjM
         G3AXHJYXcK7euWFwoJuW49he9OLO7AIYneY9TSVwxfQ0WM3sQ6CvroE61k+VgsnHOZBm
         M6XNULavozRUOYw/G77eTOimc60VzqqU9UpfIr/5BN1Itwct6fqbYT2j1hwwIN+bRwGt
         bZwAn3OcmqJNSmQRqo1MOJ91/5kId4xxJAcwIyWfzpe0Q4oBOlX7mC/j77wa0tCKdOZR
         WQPd6XNiObLKr5XtNpdLhHlIT5QXIOWz/ySaFHUxaSz7KhEAJuSlrUXoT+YdbkwHUp7+
         SE8A==
X-Gm-Message-State: AC+VfDyUdPAwXPIfldSDdR8q7Fg0iH2KR3hynbN2LpZ8P7YWywgcZFxg
	WzJlVr2fqT0QziMcgPPF70Qpn91c6ZiODIS27J0=
X-Google-Smtp-Source: ACHHUZ67Igwm6oW+sm04elsLKOyKN7r+O3KyU1vf/G+3Yx3wp2o4Cnb08XQGYvjqZI+LStbSVoSMitBc6Z9kx2rMSo8=
X-Received: by 2002:a05:6214:124a:b0:5f1:6892:7449 with SMTP id
 r10-20020a056214124a00b005f168927449mr5506301qvv.28.1683040803341; Tue, 02
 May 2023 08:20:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230501165450.15352-1-surenb@google.com> <20230501165450.15352-2-surenb@google.com>
 <ouuidemyregstrijempvhv357ggp4tgnv6cijhasnungsovokm@jkgvyuyw2fti>
 <ZFAUj+Q+hP7cWs4w@moria.home.lan> <b6b472b65b76e95bb4c7fc7eac1ee296fdbb64fd.camel@HansenPartnership.com>
 <ZFCA2FF+9MI8LI5i@moria.home.lan> <CAHp75VdK2bgU8P+-np7ScVWTEpLrz+muG-R15SXm=ETXnjaiZg@mail.gmail.com>
 <ZFCsAZFMhPWIQIpk@moria.home.lan>
In-Reply-To: <ZFCsAZFMhPWIQIpk@moria.home.lan>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 2 May 2023 18:19:27 +0300
Message-ID: <CAHp75VdvRshCthpFOjtmajVgCS_8YoJBGbLVukPwU+t79Jgmww@mail.gmail.com>
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

On Tue, May 2, 2023 at 9:22=E2=80=AFAM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
> On Tue, May 02, 2023 at 08:33:57AM +0300, Andy Shevchenko wrote:
> > Actually instead of producing zillions of variants, do a %p extension
> > to the printf() and that's it. We have, for example, %pt with T and
> > with space to follow users that want one or the other variant. Same
> > can be done with string_get_size().
>
> God no.

Any elaboration what's wrong with that?

God no for zillion APIs for almost the same. Today you want space,
tomorrow some other (special) delimiter.

--=20
With Best Regards,
Andy Shevchenko
