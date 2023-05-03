Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0EDDF44
	for <iommu@lists.linux.dev>; Wed,  3 May 2023 19:45:41 +0000 (UTC)
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-b996127ec71so8165502276.0
        for <iommu@lists.linux.dev>; Wed, 03 May 2023 12:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683143140; x=1685735140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bq44fWKfzB7azpC5445h4zSgjB+E0XG23Sx5k3P/Wrs=;
        b=mNn8mOJ969yUibKfAWrXgatuIFi6FVIM4EsSSH9KQ1Go4d1sYzKZHUi8VHjbX6pfWa
         OlJ16nZGAbvURg1kkDTdEvJDfJPD2YhA8jF3Bo81PkL1ob0v9cS2gkR4gCqMlpmjnr/s
         tWs9Fu3MohlaypLe2rIvRSkpy7E5gp65K6pp8163QEUwdmBPDYTBTVK0GaffIx+/jWG1
         GkJ4oD48JkxrW+rrbEhXrrnBxumK3LN05X4J4kXdI0k+pYkkAnfDQi3ANZniOpY63cWz
         Q+VUnUlPsKkbZjKcze+vAukdxm3Nrif9W+zvOKGcMfCU5FAKE+MOBW4LpPVOFpo/QEqA
         mUdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683143140; x=1685735140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bq44fWKfzB7azpC5445h4zSgjB+E0XG23Sx5k3P/Wrs=;
        b=ik3wlCNdFEmoP1WkESSOIjiI0Ox9kAZFSOFZs72HWzre9Ao1QbS0/Ckhf98Nt0yD3+
         SFWWW35iApIlVe/v+8CPFJLnOurV0UW29HCzPg9NTCj7Gy78+JAah46OlhSTImejHQNp
         fB+zObisnWEafbgVsUsKY1XQBerXzSchyQdjk66x7Gofzo2G/mh5+J6Qo7K6wi7W7Yrt
         VHSYFRnRC0+NZr565DjCNxSAy0GAzcXTcQ0OI/PdzAwLwszheKJaCnhjT4bPsd92n0LV
         3XAUnNXBOpFu+Ba50ZulmRIFDsMG1MR1BZ1KwgQIWypGWXIKAKC0t7EVPC4x6HnsAXDA
         E2iA==
X-Gm-Message-State: AC+VfDwdqXvVbjj6znqHOaxeCcmoEcfjIpt2/NxFvH00a0Bu0R+Jx/8i
	jyzrS7fUOJpmhtAo+nM5pztUCF1wK4y4gsZiCXpvLQ==
X-Google-Smtp-Source: ACHHUZ611vK/8POrb92/ZC137MJ/7lfkX+qvV2x7CR/VSAZxV6421Yhl76g7YvjnquNOZJwUgKJzKQx8X6OL1TqAAdQ=
X-Received: by 2002:a25:4f86:0:b0:b9a:9ad4:1d3 with SMTP id
 d128-20020a254f86000000b00b9a9ad401d3mr18494816ybb.5.1683143140255; Wed, 03
 May 2023 12:45:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230501165450.15352-1-surenb@google.com> <20230501165450.15352-35-surenb@google.com>
 <ZFIO3tXCbmTn53uv@dhcp22.suse.cz> <CAJuCfpHrZ4kWYFPvA3W9J+CmNMuOtGa_ZMXE9fOmKsPQeNt2tg@mail.gmail.com>
 <b8ab89e6-0456-969d-ed31-fa64be0a0fd0@intel.com>
In-Reply-To: <b8ab89e6-0456-969d-ed31-fa64be0a0fd0@intel.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 3 May 2023 12:45:29 -0700
Message-ID: <CAJuCfpGq4CjFLJ=QdQZUJPN72ecvWhVi_vUKrOz5_DvMAM07EQ@mail.gmail.com>
Subject: Re: [PATCH 34/40] lib: code tagging context capture support
To: Dave Hansen <dave.hansen@intel.com>
Cc: Michal Hocko <mhocko@suse.com>, akpm@linux-foundation.org, kent.overstreet@linux.dev, 
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
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

On Wed, May 3, 2023 at 8:26=E2=80=AFAM Dave Hansen <dave.hansen@intel.com> =
wrote:
>
> On 5/3/23 08:18, Suren Baghdasaryan wrote:
> >>> +static inline void rem_ctx(struct codetag_ctx *ctx,
> >>> +                        void (*free_ctx)(struct kref *refcount))
> >>> +{
> >>> +     struct codetag_with_ctx *ctc =3D ctx->ctc;
> >>> +
> >>> +     spin_lock(&ctc->ctx_lock);
> >> This could deadlock when allocator is called from the IRQ context.
> > I see. spin_lock_irqsave() then?
>
> Yes.  But, even better, please turn on lockdep when you are testing.  It
> will find these for you.  If you're on x86, we have a set of handy-dandy
> debug options that you can add to an existing config with:
>
>         make x86_debug.config

Nice!
I thought I tested with lockdep enabled but I might be wrong. The
beauty of working on multiple patchsets in parallel is that I can't
remember what I did for each one :)

>
> That said, I'm as concerned as everyone else that this is all "new" code
> and doesn't lean on existing tracing or things like PAGE_OWNER enough.

Yeah, that's being actively discussed.

>
