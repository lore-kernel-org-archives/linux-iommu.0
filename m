Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE9C1B598
	for <iommu@lists.linux.dev>; Tue, 13 Feb 2024 08:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707812848; cv=none; b=NMLGDRqsfe4tcDwgDmTMl+jCC3tA5ZWZTl3VK6fQwsNThAnmBn6wGF/aQiQrClf3fpI8j/gSgGt5TtlYwYwn1m7BMgGwmY8NCEbpRaHASCACGga7RbYmqWAt2THBj8Ur4P2uwcmmBFZN7CL6fn9SABywRrMD9Xmdxsc7Yjl+y94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707812848; c=relaxed/simple;
	bh=uafGeBbQdA3tymCA3tWJBrlrcdnQCGekk71oGHgR4d0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HPsrsLVubW44MlvYIn8VmrOQxBAvP7hhsDoh/QmVF8xo/0ZY7fFvdgMUVY/2j8ut1XgGws8J9QQFjSNUGfE+pelEsTZ6M5k2IgWfDnm02mg8njrmHqZT+4Xen6rea2u/4ClEmte37t6WkRfMg+bovKGa+HfZgBCmsy7p2jJWt7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W+ZmIltg; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+ZmIltg"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a3c309236c1so340114966b.2
        for <iommu@lists.linux.dev>; Tue, 13 Feb 2024 00:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707812845; x=1708417645; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iNGA8ZHGAdrm/kUeu0sTwlf3VcWW6Pp9gwsOjSJOS+s=;
        b=W+ZmIltgzIVFVZR5nfDCT8P8eAKoPGxkwxAS9bcGYzay2812EWkei9fQJvKcufA9F5
         yanxVRVr2Y6WldZsq/blqtv68edHZ2CKmjI5VkZJOZLvINB67mPXsPW/OGKolf8wIWNa
         9s+L8umRb9vsE8yjPJcVYjzr8loUG4J5XEd9twxRrflf2D5u+cxvngStYrWJMg4YBpsy
         UrkNmRIRWaetBkIAQUDOznB9eocThGg+UaOD29jYld673xsX/wtwTuZrGVjHSiGuKDBC
         zPdP1Ee3ecwo1dMKEhM9caZO0zZbjKtGUxqSHNQKh3t/ESiCJt8WWknyx3L2B8xdv7Ee
         cTVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707812845; x=1708417645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iNGA8ZHGAdrm/kUeu0sTwlf3VcWW6Pp9gwsOjSJOS+s=;
        b=TUreD8uuAWKa5ebK5Gcdhdl3XpZ9bs9bhjfDAjAmn17fBaWzLhlM7dzn3AL7PDb4xC
         RYA/jvtxwhs8WQd6vdINRVGAECT+FonHXICmFZdAmtsjaOTJce9IRP6KhRLpbLWWR+Hy
         wJxwJNm1OLJZUc3cn1WMzpp5FWWrEF83f9ziH0q7gNYPBMSkunGRVoOdqinyUJBRS+JJ
         DyW2chcB0jbhtmiPm2MlRD0FyzM89yRFArHpWPEle8PG0LIP5gwbfdZIhx0DecU2Wu+C
         HpQ8hcrnHU6vzv2k2VVuuPfEetN3DHMtspvEuhipaghBLYIvJUe2P2q2xLApNp39R4to
         U/nQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfRyFXiC1LzXLJoqluESNwgHmX1B3PoejbRLA0SdqeRR/5pKvq6hWtM9BKhy+sJRam48azxEBqvWm2WvStoRD2YZFvfcs=
X-Gm-Message-State: AOJu0YxU77/lfqdJXziAjVgKmsiyLQ9WngKja6rHb2jqIj01ZdEwfvYC
	bQQvGZhTdUVbXxLEencz6iuH7yiUE68xedit4xgGLv/eG6b819o6ibTupaKEfpL8viE5wJ3dtY9
	7K3uegv8hl1ENWw1pVrjw41rkEVM=
X-Google-Smtp-Source: AGHT+IHiWMLrwo5bn92RcxNVJHJJozT1VynVrAKPo4QX0LJ4mwZF+SLpK21LEEy+wgmtP5RFPridAor3NfrCIEw3scE=
X-Received: by 2002:a17:906:ceca:b0:a38:3db5:a846 with SMTP id
 si10-20020a170906ceca00b00a383db5a846mr5777021ejb.67.1707812845309; Tue, 13
 Feb 2024 00:27:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240212213922.783301-1-surenb@google.com> <20240212213922.783301-2-surenb@google.com>
In-Reply-To: <20240212213922.783301-2-surenb@google.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 13 Feb 2024 10:26:48 +0200
Message-ID: <CAHp75Vek3DEYLHnpUDBo_bYSd-ksN_66=LQ5s0Z+EhnNvhybpw@mail.gmail.com>
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

On Mon, Feb 12, 2024 at 11:39=E2=80=AFPM Suren Baghdasaryan <surenb@google.=
com> wrote:
>
> From: Kent Overstreet <kent.overstreet@linux.dev>
>
> The new flags parameter allows controlling
>  - Whether or not the units suffix is separated by a space, for
>    compatibility with sort -h
>  - Whether or not to append a B suffix - we're not always printing
>    bytes.
>
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

It seems most of my points from the previous review were refused...

...

You can move the below under --- cutter, so it won't pollute the git histor=
y.

> Cc: Andy Shevchenko <andy@kernel.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: "Noralf Tr=C3=B8nnes" <noralf@tronnes.org>
> Cc: Jens Axboe <axboe@kernel.dk>
> ---

...

> --- a/include/linux/string_helpers.h
> +++ b/include/linux/string_helpers.h
> @@ -17,14 +17,13 @@ static inline bool string_is_terminated(const char *s=
, int len)

...

> -/* Descriptions of the types of units to
> - * print in */
> -enum string_size_units {
> -       STRING_UNITS_10,        /* use powers of 10^3 (standard SI) */
> -       STRING_UNITS_2,         /* use binary powers of 2^10 */
> +enum string_size_flags {
> +       STRING_SIZE_BASE2       =3D (1 << 0),
> +       STRING_SIZE_NOSPACE     =3D (1 << 1),
> +       STRING_SIZE_NOBYTES     =3D (1 << 2),
>  };

Do not kill documentation, I already said that. Or i.o.w. document this.
Also the _SIZE is ambigous (if you don't want UNITS, use SIZE_FORMAT.

Also why did you kill BASE10 here? (see below as well)

...

> --- a/lib/string_helpers.c
> +++ b/lib/string_helpers.c
> @@ -19,11 +19,17 @@
>  #include <linux/string.h>
>  #include <linux/string_helpers.h>
>
> +enum string_size_units {
> +       STRING_UNITS_10,        /* use powers of 10^3 (standard SI) */
> +       STRING_UNITS_2,         /* use binary powers of 2^10 */
> +};

Why do we need this duplication?

...

> +       enum string_size_units units =3D flags & flags & STRING_SIZE_BASE=
2
> +               ? STRING_UNITS_2 : STRING_UNITS_10;

Double flags check is redundant.

--=20
With Best Regards,
Andy Shevchenko
