Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F773AC17
	for <iommu@lists.linux.dev>; Thu, 26 Oct 2023 18:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RJlgCGid"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-d81d09d883dso913400276.0
        for <iommu@lists.linux.dev>; Thu, 26 Oct 2023 11:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698345203; x=1698950003; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rsh3dPt2/r73NgmaoP1t7gGhxASdUa0L8chPdmn23Qo=;
        b=RJlgCGid0FyZcCxQWbKHGrYxx/JMAWYsr/Rs+CJc4C8LlcemCfAW122NBcrQlkme7e
         wQpIVnmv9lvmkVqjKhnL5EjZSqAEes/VCfAt88YJI3R0ntthgoF6xtPrJ2/7wAgkyJf1
         efgtHwKLl83lJZTpDFhsx0/Oir4jdzqrIPwkLK59EPkM3Hxd1EohQ9EFdnOVUwKsmhP8
         jjlHB4zLCkXX8NUYl/n08ZJOVK7YCETpT0bYUwMx2pCHKgvXD6xFJKzQDjz42YxQZ6X3
         cfZaZsaBQ+/b0RlMPdIxTNM6wuMew+fY9tUY7acr4bUlQG/UbYUkhyZcgFtlLlXflJpa
         cWHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698345203; x=1698950003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rsh3dPt2/r73NgmaoP1t7gGhxASdUa0L8chPdmn23Qo=;
        b=huc/G1M4q/IllrGg3zi09y6+/HBzoaZNEifXplRxTGiRNhYVljQ1mkvWkFcXg0J2oR
         vOGJVvrabQVTKHwY8UpSqSH5IZEtOrZqI/gljynC/PuXEFBgLpS1wVlkbRmqUkX481MC
         V+SsnmNhcA6+Xn13V6JkWFx7WivhSr78PYG75Qlx7VRaKjagKs5ZCM9KbwEvk2j3pF6J
         m8G6nUe/MdDt9JRsjmVu/1/vx5PMM6yCP2fqOh4n1COLutTCYyfvTLw9XHoJPw2bIr7u
         2b74nVFtMKD1Opiv5I808c58Gd4NzP8dxpmtd8CXYpJzfFW144b0JhGFOZJzxo5uvePo
         UYmA==
X-Gm-Message-State: AOJu0YyznxGOu/8jykgAmx0hKMA5gxBmfMic7GOTJ3Iv11mEose6znJ1
	AkKOH12L2WKFTpq3AzUXO/ps4ZNiv2+ORg/se0hDOA==
X-Google-Smtp-Source: AGHT+IHBtVGuULaTsqSbWWfK0JktN//Yobr+i2oSyvtEqBPvfhvTvIyFXXQYxmpnW+pXruM/MrOawuspY0l3Z4zpy28=
X-Received: by 2002:a25:74c5:0:b0:da0:46ad:fb46 with SMTP id
 p188-20020a2574c5000000b00da046adfb46mr114458ybc.41.1698345202763; Thu, 26
 Oct 2023 11:33:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231024134637.3120277-1-surenb@google.com> <20231024134637.3120277-29-surenb@google.com>
 <87h6me620j.ffs@tglx>
In-Reply-To: <87h6me620j.ffs@tglx>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 26 Oct 2023 18:33:09 +0000
Message-ID: <CAJuCfpH1pG513-FUE_28MfJ7xbX=9O-auYUjkxKLmtve_6rRAw@mail.gmail.com>
Subject: Re: [PATCH v2 28/39] timekeeping: Fix a circular include dependency
To: Thomas Gleixner <tglx@linutronix.de>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com, 
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	corbet@lwn.net, void@manifault.com, peterz@infradead.org, 
	juri.lelli@redhat.com, ldufour@linux.ibm.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, mingo@redhat.com, dave.hansen@linux.intel.com, 
	x86@kernel.org, peterx@redhat.com, david@redhat.com, axboe@kernel.dk, 
	mcgrof@kernel.org, masahiroy@kernel.org, nathan@kernel.org, dennis@kernel.org, 
	tj@kernel.org, muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org, 
	pasha.tatashin@soleen.com, yosryahmed@google.com, yuzhao@google.com, 
	dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com, 
	keescook@chromium.org, ndesaulniers@google.com, vvvvvv@google.com, 
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, cl@linux.com, 
	penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, 
	glider@google.com, elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2023 at 5:33=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> On Tue, Oct 24 2023 at 06:46, Suren Baghdasaryan wrote:
> > From: Kent Overstreet <kent.overstreet@linux.dev>
> >
> > This avoids a circular header dependency in an upcoming patch by only
> > making hrtimer.h depend on percpu-defs.h
>
> What's the actual dependency problem?

Sorry for the delay.
When we instrument per-cpu allocations in [1] we need to include
sched.h in percpu.h to be able to use alloc_tag_save(). sched.h
includes hrtimer.h. So, without this change we end up with a circular
inclusion: percpu.h->sched.h->hrtimer.h->percpu.h

[1] https://lore.kernel.org/all/20231024134637.3120277-32-surenb@google.com=
/

>
