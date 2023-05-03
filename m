Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB9AD30C
	for <iommu@lists.linux.dev>; Wed,  3 May 2023 15:24:32 +0000 (UTC)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-55b7630a736so16342407b3.1
        for <iommu@lists.linux.dev>; Wed, 03 May 2023 08:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683127471; x=1685719471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3u3xUQKsQtY5MjJU7KWdFVlKdUwGfS6WMFqIdWoJCIo=;
        b=unFkvF+6wudO45usQ0U6AfJIfqhGP+H5/IVYvEVNkvB69qXh+JOZzYWL6W8iypwR8u
         WXtxZSQf4t68zEHXsPc28NiwHPUvvwS/M344xQ3tBObhdP7U9FItGEykPkPqu+eEbFFp
         okusA4UwcrZWf8Z51Zm29/RE04pDrtNIp/vD2aJp+XpBdU2UkRkKKny9uq/isdNkl+oO
         Skjuy9Oo1eMbcdvkjUdB3P7K+oZHaS/9IHtfkJQayp0An2kmfxp7oACjbZtN8XRdwT2w
         lxjzvHFT+zOFmdZqKIHE6BDxnTC8QY7tAueSdS/QBzC33/doZv3G/USW3EuK7WLdlbGW
         qF+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683127471; x=1685719471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3u3xUQKsQtY5MjJU7KWdFVlKdUwGfS6WMFqIdWoJCIo=;
        b=jIkvk0IirA/M1aD1te1VZBq/BG/WWDO+z3UZ5q67++lUhWX3kvzObL90d3/g8VQIsb
         oGHEHCyEk8KUuc+xZXIHLSviAJBUsgqsG2p3P/IlVy+zSNzRMH52V7IIIoD1UtvwLsqF
         9SKly/Xq+SQZBoeFnCMl3E0R0X5chrOLpCg1Excnm61aghS9g9cbggNphLlg3B6IAgmM
         D/eoB+jGo+jopNN+Cqzb/5RHAdTtZtx6lo815gKkro8igelJb0x/+UwhLm0dcLhR2hbh
         PCgoKKbMOaRWBW8cuQK+YiUpHnhG3KpXkuoMQ4EXytvEze3oxAPlduAL0rTG9sbbEnLM
         g61Q==
X-Gm-Message-State: AC+VfDxN5a2Z8fL8AFr2PI7NxG0sCAL4f+6mSLq27+BUiDXlT7BbceLL
	MR/YfDvcUKt5olfnYS20rVfZAgGskoC7Ziu7+PXsBw==
X-Google-Smtp-Source: ACHHUZ4QRO+chfCfz5/jv+a2xol9xihN+1wt+nUNWo6jdaruLvTBoFlz5eyhSEYcB7ZOQZ60IsdoPkHuL2yRnd5FS3c=
X-Received: by 2002:a0d:e296:0:b0:55a:4109:7f5a with SMTP id
 l144-20020a0de296000000b0055a41097f5amr11315408ywe.12.1683127470672; Wed, 03
 May 2023 08:24:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230501165450.15352-1-surenb@google.com> <20230501165450.15352-36-surenb@google.com>
 <ZFIPmnrSIdJ5yusM@dhcp22.suse.cz>
In-Reply-To: <ZFIPmnrSIdJ5yusM@dhcp22.suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 3 May 2023 08:24:19 -0700
Message-ID: <CAJuCfpGsvWupMbasqvwcMYsOOPxTQqi1ed5+=vyu-yoPQwwybg@mail.gmail.com>
Subject: Re: [PATCH 35/40] lib: implement context capture support for tagged allocations
To: Michal Hocko <mhocko@suse.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, vbabka@suse.cz, 
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

On Wed, May 3, 2023 at 12:39=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Mon 01-05-23 09:54:45, Suren Baghdasaryan wrote:
> [...]
> > +struct codetag_ctx *alloc_tag_create_ctx(struct alloc_tag *tag, size_t=
 size)
> > +{
> > +     struct alloc_call_ctx *ac_ctx;
> > +
> > +     /* TODO: use a dedicated kmem_cache */
> > +     ac_ctx =3D kmalloc(sizeof(struct alloc_call_ctx), GFP_KERNEL);
>
> You cannot really use GFP_KERNEL here. This is post_alloc_hook path and
> that has its own gfp context.

I missed that. Would it be appropriate to use the gfp_flags parameter
of post_alloc_hook() here?


> --
> Michal Hocko
> SUSE Labs
