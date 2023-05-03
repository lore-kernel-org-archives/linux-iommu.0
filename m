Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2440ADF44
	for <iommu@lists.linux.dev>; Wed,  3 May 2023 19:41:22 +0000 (UTC)
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-b9a7c1b86e8so7724778276.2
        for <iommu@lists.linux.dev>; Wed, 03 May 2023 12:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683142881; x=1685734881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7eRiiP2JCtlxvX+BHzTjXxhFfE3xb3L5Tko5xVivHIc=;
        b=njnY9/ZTWcA0YQLoTf3TUMfGQMs6qBR8x/WiO3YJ4m2rgzn9gPgiVmWeEd3meHgQOd
         veIE13lp/BEBibiOOZUNO+WD2iQQwInbq0mORyd3+wLWSUTFkhmbMs6fl3Tqmd3D0D5p
         V+y4b3/jKL+G7UEO8JQopzaWcrHdBR+imlq/VrwTOp1569eYFHFfi9pD7I53OyaoPSYd
         tj72nQLogAXIm5Pv95noTQ1YRpRrtHa+Dymto/1ndku51s0fuH/R0nkRvqq+7WbyeTBe
         or08gvlkQ55RtNC4M9pq8YNpCVr1Dsrvti1RMiJ42Ynp3MHUq3DPU/4MOuwmbk5VuygM
         Oy2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683142881; x=1685734881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7eRiiP2JCtlxvX+BHzTjXxhFfE3xb3L5Tko5xVivHIc=;
        b=K/EnXsl3t7zqb8FljjKHCLJLmAK+puvjomUTHU0YuaA+H2A48eGVMqGM4TcQcvjJ9S
         GsH9MWVijYhtHrxWM2x6sFu1HmWwA2UmdT603fVkPDNADaNXMaIKjOBLn5hEMBMIt/8f
         +bk2Zq4XQGdXPogH7hs8aGr1HnTp9GnwPiQHHre7onQM/YYe6/fF4mRe89N4QEbgg/1q
         lvPGt6R0nlhoVTVVLj+qPlO74BJSA8oxc2tO/Aac3vOF7CP+DijI9ea+1gZ6vhEUMhtk
         p/oTbHfnJfVXoHwnwTL5zA10Fsnf46Zrtxjux0B+Pk4/Qqc5Hv0OJja/ucxGh00otJsF
         0gaA==
X-Gm-Message-State: AC+VfDy81a6XkdoG5qXLdFd6UQQHvqc0r1XgsE+ayQTlcoJ8elEfj9yj
	XfkEDVdRidziH+3aUtLM7KGThu7AgvelQzO+l9f5mQ==
X-Google-Smtp-Source: ACHHUZ4RFT+eYjp8zpqFQpuduTlyNDeYqB8fD0xjOEnMllgaLgM5ug7v5zBN549JMpsUAooBfYdYqk6S3BpMrYkFeqQ=
X-Received: by 2002:a25:308a:0:b0:b9a:38b2:8069 with SMTP id
 w132-20020a25308a000000b00b9a38b28069mr18330170ybw.6.1683142880244; Wed, 03
 May 2023 12:41:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <ZFIMaflxeHS3uR/A@dhcp22.suse.cz> <ZFIOfb6/jHwLqg6M@moria.home.lan>
 <ZFISlX+mSx4QJDK6@dhcp22.suse.cz> <ZFIVtB8JyKk0ddA5@moria.home.lan>
 <ZFKNZZwC8EUbOLMv@slm.duckdns.org> <20230503180726.GA196054@cmpxchg.org>
 <ZFKlrP7nLn93iIRf@slm.duckdns.org> <ZFKqh5Dh93UULdse@slm.duckdns.org>
 <ZFKubD/lq7oB4svV@moria.home.lan> <ZFKu6zWA00AzArMF@slm.duckdns.org> <ZFKxcfqkUQ60zBB_@slm.duckdns.org>
In-Reply-To: <ZFKxcfqkUQ60zBB_@slm.duckdns.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 3 May 2023 12:41:08 -0700
Message-ID: <CAJuCfpEPkCJZO2svT-GfmpJ+V-jSLyFDKM_atnqPVRBKtzgtnQ@mail.gmail.com>
Subject: Re: [PATCH 00/40] Memory allocation profiling
To: Tejun Heo <tj@kernel.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@suse.com>, akpm@linux-foundation.org, vbabka@suse.cz, 
	roman.gushchin@linux.dev, mgorman@suse.de, dave@stgolabs.net, 
	willy@infradead.org, liam.howlett@oracle.com, corbet@lwn.net, 
	void@manifault.com, peterz@infradead.org, juri.lelli@redhat.com, 
	ldufour@linux.ibm.com, catalin.marinas@arm.com, will@kernel.org, 
	arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, muchun.song@linux.dev, rppt@kernel.org, 
	paulmck@kernel.org, pasha.tatashin@soleen.com, yosryahmed@google.com, 
	yuzhao@google.com, dhowells@redhat.com, hughd@google.com, 
	andreyknvl@gmail.com, keescook@chromium.org, ndesaulniers@google.com, 
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
	cgroups@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 3, 2023 at 12:09=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> On Wed, May 03, 2023 at 08:58:51AM -1000, Tejun Heo wrote:
> > On Wed, May 03, 2023 at 02:56:44PM -0400, Kent Overstreet wrote:
> > > On Wed, May 03, 2023 at 08:40:07AM -1000, Tejun Heo wrote:
> > > > > Yeah, easy / default visibility argument does make sense to me.
> > > >
> > > > So, a bit of addition here. If this is the thrust, the debugfs part=
 seems
> > > > rather redundant, right? That's trivially obtainable with tracing /=
 bpf and
> > > > in a more flexible and performant manner. Also, are we happy with r=
ecording
> > > > just single depth for persistent tracking?

IIUC, by single depth you mean no call stack capturing?
If so, that's the idea behind the context capture feature so that we
can enable it on specific allocations only after we determine there is
something interesting there. So, with low-cost persistent tracking we
can determine the suspects and then pay some more to investigate those
suspects in more detail.

> > >
> > > Not sure what you're envisioning?
> > >
> > > I'd consider the debugfs interface pretty integral; it's much more
> > > discoverable for users, and it's hardly any code out of the whole
> > > patchset.
> >
> > You can do the same thing with a bpftrace one liner tho. That's rather
> > difficult to beat.

debugfs seemed like a natural choice for such information. If another
interface is more appropriate I'm happy to explore that.

>
> Ah, shit, I'm an idiot. Sorry. I thought allocations was under /proc and
> allocations.ctx under debugfs. I meant allocations.ctx is redundant.

Do you mean that we could display allocation context in
debugfs/allocations file (for the allocations which we explicitly
enabled context capturing)?

>
> Thanks.
>
> --
> tejun
