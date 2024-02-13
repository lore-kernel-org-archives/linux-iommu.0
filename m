Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7233A94F
	for <iommu@lists.linux.dev>; Tue, 13 Feb 2024 00:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707784498; cv=none; b=Dq8j0GSUjjLnbUU+8uZd68GGMbHIYduGJmG61y8H2Jp0E6WUJr91g+1f5uaz3b1OCfuEWxhkXBx85eShtt55G53Rsnm4k4GF3rR7vG4nBpBpVrocbL/xcy5Gb+m7ztTBGk5nIwkVXQHjZORmGaWgdZqlrHjLnnXq7e12C/ZPs2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707784498; c=relaxed/simple;
	bh=UHD/3jMRU1ccG3YkQIqWf6JR5thVdXFBz5XlT+Q0DtQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KrhTCvwarLgegot1Xkf9XIvL1u7Jf9Y8B6VL/2r252RUygUSYWkDKZi0WXHphXGdytTAeLhb0PXzI7hs0/zvUJGyUj3ZR15mIr17IXiph5eCeTOusIDR1DDnvLYgFmKkXGTH0wbiGjK0J8DpudESEutXnYBdVkHWcMvgE/FmRCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RqohSG1i; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RqohSG1i"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dc745927098so3196794276.3
        for <iommu@lists.linux.dev>; Mon, 12 Feb 2024 16:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707784496; x=1708389296; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UHD/3jMRU1ccG3YkQIqWf6JR5thVdXFBz5XlT+Q0DtQ=;
        b=RqohSG1iFmpd0qLKEf4qMSPLqJI9gF+LfjgrlNzSHMpmLt/HpWY3tUoJAfIrasgNMK
         i/MX2CNGwEsdshM5Vn6/MWmizQkwxi5G24ylXEIqK9TqlLKux1xNoySJfPk3+sULBzye
         jpNgcwlJbcaeDjwmyAXi/3hjKOrfiVEMfLzbWCDzaO1bhzVrbxJy/Pzp9GF7ueuthH2Z
         sptfIkaE+7hwo43tTMqySgcCSiI5qc/jlE2rdd70dg0PdH9jJ6oDysdlIjOIs4yvAR26
         Qgu9bstRIfGBn9J3QLbamN5HfNGJu3V2Pkdeuo7F1KLnxvYFLu+lepa8fc/vskKtN6Lq
         GqZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707784496; x=1708389296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UHD/3jMRU1ccG3YkQIqWf6JR5thVdXFBz5XlT+Q0DtQ=;
        b=Od9i57PGm3cXmbhYS7eyqzwWyg5FIj5k/HYasiJknjK4+7NpjWa6i4HLVCCi1CH0pE
         n/KTVnTuT9esEpnBbGpPA38/zMGQqs5YplG67RDqUb10tNKWooG9oDZ5A8eng1RhoPY9
         ziukKrCOCog2/h5ul70+jwZLX6FdANIE025Tc3V/UZ41+tb3EuNA7+Z6azd06J/t0B34
         iMYCu/e3HjqzziESRaq0UuFZO+xQ/ma/zx8aZggWzD9VdAo1aCG8MgY49NwFXCIAwJZx
         qAp/50WkN5SzV3WbTW7/BbaXTt1Ucx4IIzmkTm+JHTcHmx4G+OyuArcwlvX14qGpZRPr
         1C1Q==
X-Forwarded-Encrypted: i=1; AJvYcCU62bkeAlwAhQJ45Uzccb9C1g1Q2Tvx1vvu5ILIwpK7d+FLO+ET6Yxf5uCmvISYRJNt7mV9ukXulrH480NIG6/y5b5vcgk=
X-Gm-Message-State: AOJu0Yw4dD73xqQhEsTaou2xlS7ILfQlAD5/lHOdunN4yEzSMFN01EQR
	pvGMtZ2Zmxuq1Ky2LtWwxWDIdT/XQobil0stgdbg6HY0AUhFlerfpYTYD6tYJWXRxDLWzPPBG1C
	5l/naaKupV4R91OWbN60CLR+dQY3TputOf+gx
X-Google-Smtp-Source: AGHT+IFjB55gPzAJ3uayg/3DbZropi86YtyNQzi/ARRSHghfRy48VLa7tw6T2sjep0csYIBMYiEo+U9Z3yu21UMYcUw=
X-Received: by 2002:a25:b389:0:b0:dcb:ca7e:7e6f with SMTP id
 m9-20020a25b389000000b00dcbca7e7e6fmr1832315ybj.55.1707784495521; Mon, 12 Feb
 2024 16:34:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240212213922.783301-1-surenb@google.com> <20240212213922.783301-24-surenb@google.com>
 <202402121631.5954CFB@keescook>
In-Reply-To: <202402121631.5954CFB@keescook>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 12 Feb 2024 16:34:44 -0800
Message-ID: <CAJuCfpHf+EUPL7ObG7ghVhQShcJJSwMjNcUAzeg-x1BoS5OeEw@mail.gmail.com>
Subject: Re: [PATCH v3 23/35] mm/slub: Mark slab_free_freelist_hook() __always_inline
To: Kees Cook <keescook@chromium.org>
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
	hughd@google.com, andreyknvl@gmail.com, ndesaulniers@google.com, 
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

On Mon, Feb 12, 2024 at 4:31=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
>
> On Mon, Feb 12, 2024 at 01:39:09PM -0800, Suren Baghdasaryan wrote:
> > From: Kent Overstreet <kent.overstreet@linux.dev>
> >
> > It seems we need to be more forceful with the compiler on this one.
>
> Sure, but why?

IIRC Kent saw a case when it was not inlined for some reason... Kent,
do you recall this?

>
> >
> > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>
> --
> Kees Cook
