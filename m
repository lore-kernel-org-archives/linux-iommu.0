Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA0A132C07
	for <iommu@lists.linux.dev>; Thu, 15 Feb 2024 14:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708009138; cv=none; b=Jn3VESeeoTPzLJSCGe5eDleT5ulfCJJO5S4ExIwM/Ar31hkakYKnZoE0QboIf+o/IiGRDSjDpTAW69/UDgv1AHfFPtarXrRR0uWfuFPmgbknHIjrcDJgQDEGntEWF0OITP8u98EKE5jamR/zgL5TKgXa4X3GWs5tfUdObx5ZXvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708009138; c=relaxed/simple;
	bh=6IMij2aMCDzlI1InstPj/0SjhHnSgb7se0txHOjqYec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P1v/H9CnwgbcIlreQPtPOt7i+oj8a4D2OWeChEXKNnKGMu9UP+lUjuWNJnM7hsjn0DHz8sMd5v2YqibNVyN458u20SrXD6c1CfdT1bhv7X/zbrEaICCZ2PvHtVTnOirHQWUThOQfCgjsPYWWHraPkPg9TxpAUF7zcF1QRKuXkLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gKftFWrj; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gKftFWrj"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dc74e33fe1bso863370276.0
        for <iommu@lists.linux.dev>; Thu, 15 Feb 2024 06:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708009135; x=1708613935; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tw/wN6EwhF1l4GL2nZ/ht1qejqJOWh5ecVMENBzDBDY=;
        b=gKftFWrjMJHyH9s/4QYPDwWnufSCuS+vzix5rGC8bgZs8WBThr4a60bS8qoDbV8igj
         RvYXsGVsTvPRmwue2UfrBa7WZoJaz1gsyptDm1Oacv7rr5VsVCp35udb/w080dRgQKHw
         Q+K8Ja9neQSnRNPvbpfW1HtiiX3mki//cz2IKD+j1X1i4YqD7NWXIsN99afQWQ3eZ5y0
         5WQKtpQ6psqV12VVk2B/FNXmI6rSpvUZsR8WAeey/YKc4mJpCUhpfGpkSpZCLFaY/TtH
         TLA6TPL13iDeK1YYRtLR1TeR7GN5WfzVQoxcKxAtZER4f3HqbTaQdViqFfbBFap+Ue4t
         YDDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708009135; x=1708613935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tw/wN6EwhF1l4GL2nZ/ht1qejqJOWh5ecVMENBzDBDY=;
        b=ftvuViWdbMkKyBBEGZgIsbhj+/b8S/cPCAQLkyZP+2OADmK6xhwTgceRcsJcSRxqNA
         fH/mKZpx5fMjEBjsqMvu8VvCQg+TXxpfDKoCx6IednNKPmtVE6X3fg5GfpqRjUK0X8y3
         l2FfhPpC+/6bg1YDyqL35x3wrj94WVmiifuzeV5liDX8mkBv9vy1JyaaAPtJDFxqRL+9
         2uAnu3hVLaXhqzHkQj8uji0sClvSN90+WnwXdFxfkd1cJWcLdvLQkh3NKHMfu8zU2gEk
         mmED7zTKa8Zq/pqRslfpI3MsUPDFiHsxuKIv8Uz6rTns68Vbi+PVUi5ZymvLGXWG+I/4
         +rdA==
X-Forwarded-Encrypted: i=1; AJvYcCUcffR1u+kxMYePMtShNCzg68k5VbJL0QQLRQz+Y03YsK1KXIUx0t84k3024eLQgTH2TPdFeAGYij3F0pnZmJno632x+0k=
X-Gm-Message-State: AOJu0YyN+Jo5XyE1Rr3b3VpI4CcEiMoyqtKDbzRQQrpNh5odpT7Roz/+
	2b42lAKeIp0ocf0G/Pp+HblO5vA8KTNvNOg0PKKUmoklU+4XGhY2FQAVxAzjZLqv7pkj5WQnVbO
	ibt+jzTXYbpQqLZgQlyQ9842/1ErTXfiPoBNp
X-Google-Smtp-Source: AGHT+IHbdGXWcfbi3sM7zNcX3xbLXT1pZZDBplduLx68NqKeXRGL2TAUM4SLA4O1Gc053VxRA9U/P0Ad1H3i0YzTDwI=
X-Received: by 2002:a25:8750:0:b0:dbe:9509:141c with SMTP id
 e16-20020a258750000000b00dbe9509141cmr1821330ybn.30.1708009135319; Thu, 15
 Feb 2024 06:58:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240212213922.783301-1-surenb@google.com> <20240212213922.783301-32-surenb@google.com>
 <Zc3X8XlnrZmh2mgN@tiehlicka>
In-Reply-To: <Zc3X8XlnrZmh2mgN@tiehlicka>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 15 Feb 2024 06:58:42 -0800
Message-ID: <CAJuCfpHc2ee_V6SGAc_31O_ikjGGNivhdSG+2XNcc9vVmzO-9g@mail.gmail.com>
Subject: Re: [PATCH v3 31/35] lib: add memory allocations report in show_mem()
To: Michal Hocko <mhocko@suse.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, vbabka@suse.cz, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
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
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 1:22=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Mon 12-02-24 13:39:17, Suren Baghdasaryan wrote:
> [...]
> > @@ -423,4 +424,18 @@ void __show_mem(unsigned int filter, nodemask_t *n=
odemask, int max_zone_idx)
> >  #ifdef CONFIG_MEMORY_FAILURE
> >       printk("%lu pages hwpoisoned\n", atomic_long_read(&num_poisoned_p=
ages));
> >  #endif
> > +#ifdef CONFIG_MEM_ALLOC_PROFILING
> > +     {
> > +             struct seq_buf s;
> > +             char *buf =3D kmalloc(4096, GFP_ATOMIC);
> > +
> > +             if (buf) {
> > +                     printk("Memory allocations:\n");
> > +                     seq_buf_init(&s, buf, 4096);
> > +                     alloc_tags_show_mem_report(&s);
> > +                     printk("%s", buf);
> > +                     kfree(buf);
> > +             }
> > +     }
> > +#endif
>
> I am pretty sure I have already objected to this. Memory allocations in
> the oom path are simply no go unless there is absolutely no other way
> around that. In this case the buffer could be preallocated.

Good point. We will change this to a smaller buffer allocated on the
stack and will print records one-by-one. Thanks!

>
> --
> Michal Hocko
> SUSE Labs
