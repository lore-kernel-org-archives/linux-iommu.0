Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EDE179A8
	for <iommu@lists.linux.dev>; Tue, 13 Feb 2024 08:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707813014; cv=none; b=j0TeUsNPfzK5yqLmiEVbziy1Tg7lidxiegdXTo4cOnkFdW39A6asAOi/LAq5sNdOZH/sx6cpBCKobk1yvgK/33WtJNqSCtFG9/ANp+XbbdtXGIYfn9iZzeKjcwJUcFIoYhdttc2Fjpgp9MZknlk0TEHHYSnjUF3eN+81d0G3czA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707813014; c=relaxed/simple;
	bh=CloOXvX3e3OyBad9i8X+MAxCoHVaXSE6mAVeTadKyHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o+7IfvuQr97sZeghIUE6MQ74ClueY4Y+b5rkDQirpEe0ZA1NXbcsKoNjiQ12cLg7YWTfkSjeilbAsm1qpZFnNWO/9sKe7nQGgTOe0+H5ESSzvf+NQkHsYp8VNWx62Yae7kvc8cBo85E+yOFd5i8MkhtYNsaE9MbarrZbcql0IqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c5unjb8q; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5unjb8q"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-55fc7f63639so5121287a12.1
        for <iommu@lists.linux.dev>; Tue, 13 Feb 2024 00:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707813011; x=1708417811; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UVoibj/kriuj68qpqrmYwyDO76NZZTUK51M4zJowuXg=;
        b=c5unjb8q9CWDUAlugzL2XUM/OyRn+puy5L8demCHeal+5T+rYWWoz7Wpd1uAv68xRR
         55/CqtJ7lxf4a02NjHcEmNLBqxqvkd/CvY5P4EDydZ6oJfzq7EIy4L+3O1n+A+RKMMlY
         WgnjxKtFnk9PNhQlyINYJCi0nxSre9bilKMkGE6ZZmczSyTxC0gi/YnFqIJ27TVZDr9B
         4eKW/YRiKkCVTf0Hp1y5QCTIBuFinSQtoC5UGH2g8bUmOUl3mcuhMfMqIfwO/cFqiyJb
         NXW0uyyK3jYFvcN0RA3VHnAt52pTBOaUfcaALRQ7ikqDb5hg8Szdmufpv7M3kYNsXdoQ
         r8WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707813011; x=1708417811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UVoibj/kriuj68qpqrmYwyDO76NZZTUK51M4zJowuXg=;
        b=NmfispRE6o85Y89ABeoD9M4lsajRkQczEhcrMafvdr0nXDgJ2qpV9cPhgTXGAUjCSz
         OJMlqH9DwoBggd2dPndIeAVIEpkU9So3Q53ciYpaNEtRG83oBViV/mrJcWaV0lxSssOK
         rJ89A64rQHbfmj1xGtsH3y1cqZoNdTpvafTTMSgts3YETx1iLQXnyCr6oQYYEDTx5SbW
         eonulPzd86+D0BZhoVgL0I9L7j8dmIPkuWpfKbicQFQ8lYrXbcGkWTgdbeh2Clwo8zGn
         c5RWZbueoGcs54yvOnDhtxbyP17g1ComN5E+wSjZCvNykAGReiLtlsZ7jIMBL/15LlIV
         7uvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVz1jO0iJUa8aWYfXQXWUdZAHJV03Gygl05ys99O5DeP6B67OK6VGESgt9T1GvIeB3BLNp+6wqkEf6Cf/kSg//1s/kBIE=
X-Gm-Message-State: AOJu0YwVWaU2ksr2Y3ZNcFuMiMzUro/JkWHTpPIIoxpuqSM3Yj3c7DkP
	Y3QN4J7qmUGaOvRWxQ6Ey+oMofN337br6IWAzAhLeRaSDTl02OcBDCbFIbqb2XE4NTCFiSGTahV
	yj0/SrKiHLMKk3l2QIlqJxO19Nas=
X-Google-Smtp-Source: AGHT+IGx/YbYc3+LQ8reBTPjQn19LHdQNalJWBrwb4F8AS6CetNmE5OP52aorlUQ8qqrg2PWp0Ni3QIDkvdkx5+GGkc=
X-Received: by 2002:a17:907:7896:b0:a3d:704:d688 with SMTP id
 ku22-20020a170907789600b00a3d0704d688mr613690ejc.47.1707813011047; Tue, 13
 Feb 2024 00:30:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240212213922.783301-1-surenb@google.com> <20240212213922.783301-2-surenb@google.com>
 <CAHp75Vek3DEYLHnpUDBo_bYSd-ksN_66=LQ5s0Z+EhnNvhybpw@mail.gmail.com>
In-Reply-To: <CAHp75Vek3DEYLHnpUDBo_bYSd-ksN_66=LQ5s0Z+EhnNvhybpw@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 13 Feb 2024 10:29:34 +0200
Message-ID: <CAHp75VcftSPtAjOH-96wdyVhAYWAbOzZtfgm6J2Vwt1=-QTb=Q@mail.gmail.com>
Subject: Re: [PATCH v3 01/35] lib/string_helpers: Add flags param to string_get_size()
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com, 
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
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
	cgroups@vger.kernel.org, Andy Shevchenko <andy@kernel.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, 
	Paul Mackerras <paulus@samba.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	=?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 10:26=E2=80=AFAM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Mon, Feb 12, 2024 at 11:39=E2=80=AFPM Suren Baghdasaryan <surenb@googl=
e.com> wrote:
> >
> > From: Kent Overstreet <kent.overstreet@linux.dev>
> >
> > The new flags parameter allows controlling
> >  - Whether or not the units suffix is separated by a space, for
> >    compatibility with sort -h
> >  - Whether or not to append a B suffix - we're not always printing
> >    bytes.

And you effectively missed to _add_ the test cases for the modified code.
Formal NAK for this, the rest is discussable, the absence of tests is not.

> > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>
> It seems most of my points from the previous review were refused...
>
> ...
>
> You can move the below under --- cutter, so it won't pollute the git hist=
ory.
>
> > Cc: Andy Shevchenko <andy@kernel.org>
> > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Cc: Paul Mackerras <paulus@samba.org>
> > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > Cc: Jason Wang <jasowang@redhat.com>
> > Cc: "Noralf Tr=C3=B8nnes" <noralf@tronnes.org>
> > Cc: Jens Axboe <axboe@kernel.dk>
> > ---
>
> ...
>
> > --- a/include/linux/string_helpers.h
> > +++ b/include/linux/string_helpers.h
> > @@ -17,14 +17,13 @@ static inline bool string_is_terminated(const char =
*s, int len)
>
> ...
>
> > -/* Descriptions of the types of units to
> > - * print in */
> > -enum string_size_units {
> > -       STRING_UNITS_10,        /* use powers of 10^3 (standard SI) */
> > -       STRING_UNITS_2,         /* use binary powers of 2^10 */
> > +enum string_size_flags {
> > +       STRING_SIZE_BASE2       =3D (1 << 0),
> > +       STRING_SIZE_NOSPACE     =3D (1 << 1),
> > +       STRING_SIZE_NOBYTES     =3D (1 << 2),
> >  };
>
> Do not kill documentation, I already said that. Or i.o.w. document this.
> Also the _SIZE is ambigous (if you don't want UNITS, use SIZE_FORMAT.
>
> Also why did you kill BASE10 here? (see below as well)
>
> ...
>
> > --- a/lib/string_helpers.c
> > +++ b/lib/string_helpers.c
> > @@ -19,11 +19,17 @@
> >  #include <linux/string.h>
> >  #include <linux/string_helpers.h>
> >
> > +enum string_size_units {
> > +       STRING_UNITS_10,        /* use powers of 10^3 (standard SI) */
> > +       STRING_UNITS_2,         /* use binary powers of 2^10 */
> > +};
>
> Why do we need this duplication?
>
> ...
>
> > +       enum string_size_units units =3D flags & flags & STRING_SIZE_BA=
SE2
> > +               ? STRING_UNITS_2 : STRING_UNITS_10;
>
> Double flags check is redundant.



--=20
With Best Regards,
Andy Shevchenko
