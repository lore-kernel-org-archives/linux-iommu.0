Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1117A3148CF
	for <iommu@lists.linux.dev>; Wed, 11 Mar 2026 14:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773238374; cv=none; b=fqdumJgBACOAlKnP8aVE1zOWexRsXY9N8ykkdH+0yUTNqeiiDhucQZlapjUNxaPBQ36BCkeC3In0Pyc12qTtNGXYrDrDqTZKhkhJIWBaFiun7kTVWYS0ks30NK83GbtoTLkf9pLycREp18NbyKIa3ax6qd/WckIW8LmBLw45N34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773238374; c=relaxed/simple;
	bh=POUJjzeRhBIXfPGojdZfC417KH92loTKx1KmDpRcfoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UOFILufmQ1x0NV77RDfCoRWE4YOzD+YQwHX5ll6HkWOdN3OkS5KWvIliRx+V+hYG7R2xUNBnYM5yIJI7aVMYj0wN7krTWCY7vYrLCTQ1ip9X9ZHM1IJEiNoRf0/WMbFDuVUggUazDMORm+0k+OdBEmS29ZuNWsGAOkc5+ktoUhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-660be63279bso1544117a12.1
        for <iommu@lists.linux.dev>; Wed, 11 Mar 2026 07:12:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773238371; x=1773843171;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wIz9Fr5w5J45ZN4rxwvT/0kjXMGfLP1VpB2aKPOax7k=;
        b=IKniCNhiKKoXO1Olj62b3VZiPLn4+k79IAbNMdrAELD5loo+EvzkkRcQ6EDaQvsBCI
         SlnH5TCZkHpeqmZDDUDNnHPSEPsanQZXWjn1Yb9BeXZK0ajdHI+t4xDCTdXFaV16bZhi
         xtbsN/GUnWCAceCWKmfmqM+uNxJMgVj9IDn8iKGFb6Qc4v3EQExt/4T/P7icCJtSuUh0
         PHFrLEjGzy7WavMQnDIYPYrgMf+JL+D8LV+dXh00734BKmaJzRU6nEdKhYjHyLg2fuhs
         Ubnpqf0wpAKqCHIa/mP9BwVyx8MgYhwMMHNFc644TFqOo1oxX7IYX0aLMl3BpY4GA8/B
         elFg==
X-Forwarded-Encrypted: i=1; AJvYcCX8tx+LFCFX1zwVzE/VthvXp+NpOTogf8sVamXZO3kmD/ZFaESy8JhUZ+wZb14CjrsNIMxs0A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw8H0heeQ9TazMwau7raJdrv1d+8pttgheRSBRdbPnTONZ5uMgf
	l+PyWbR60sZWadlcGwpLtsjU5ed66W4b+6LFUdiFDXZHp3lj4PmsEY/rjwgZZeAELpraSQ==
X-Gm-Gg: ATEYQzzD3dVmyTyIfKCtYrPEr+1eVrG/P1itBipMWuCtwaOynHWbNe4WhGWYhCbSkCf
	JSxp+FybWNkZ+9F0e5wU8EgGnPzpg5gs+ndZ4+yADzKE0/cS0YPvDul4/Cce+PO85wT2vgaNmdn
	8WxZ2v+lesD3ZoT5TF1KJNB9NdcpAdPrb4oFZdIBwqF5xIx/o5Mrgl2bkZ26iOtTI0gevQ8McYT
	18nDbeExwCMXqIuu17e0jqN/0AOwV8xGyrkjPK4ZZkXkuv+AVuMcUeUyNAKx+g8kbgQp+pHV5JR
	KxJyUjXix6TGGidZnhxlkYiMNjRbSLy6rM8V7eYet6gcBdyiVrYQ2Qek5DkLKvGJHtDRppYdKko
	KQbQhkFwcy+vJwLmnzsGr0ErxYuE6Ct7Yplsnt/jXC1/er/AgK9L4DPM/imNaB1716fDVsVcHwA
	aMDAnao2kRGE4+WwWSl9V2/lNkewRNQ2AZ5Yah/0N6hMte4U1LE8qDEiz479bL
X-Received: by 2002:a17:907:3f90:b0:b93:61c7:4f09 with SMTP id a640c23a62f3a-b972d817b4emr170863766b.20.1773238371138;
        Wed, 11 Mar 2026 07:12:51 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b972de83676sm60327766b.29.2026.03.11.07.12.50
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 07:12:50 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b942b36de08so190583566b.1
        for <iommu@lists.linux.dev>; Wed, 11 Mar 2026 07:12:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVEff0W3C10HT1EbOMpkc0mXRuXDgc8/4l3o1Xo1v3pitTTuRmkJDr7GsWVAHLdv7N8SEbHgA==@lists.linux.dev
X-Received: by 2002:a17:907:6d16:b0:b88:4f25:81da with SMTP id
 a640c23a62f3a-b97113ff0b9mr462021166b.0.1773237981235; Wed, 11 Mar 2026
 07:06:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-15-bd63b656022d@avm.de> <20260310100750.303af303@gandalf.local.home>
 <20260311141332.b611237d36b61b2409e66cb3@kernel.org> <20260311100332.6a2ce4b1@gandalf.local.home>
In-Reply-To: <20260311100332.6a2ce4b1@gandalf.local.home>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 11 Mar 2026 15:06:07 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX4kRGLaKMzPuhS1Pmxh609eiqQW-cAS_jWBBbt-vE6SA@mail.gmail.com>
X-Gm-Features: AaiRm53WEGMMLW4z34e7P-lM1qFvsCJGZ_o4JNL5NPWbhJPKmcqz6k9bJcyL--8
Message-ID: <CAMuHMdX4kRGLaKMzPuhS1Pmxh609eiqQW-cAS_jWBBbt-vE6SA@mail.gmail.com>
Subject: Re: [PATCH 15/61] trace: Prefer IS_ERR_OR_NULL over manual NULL check
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Philipp Hahn <phahn-oss@avm.de>, amd-gfx@lists.freedesktop.org, 
	apparmor@lists.ubuntu.com, bpf@vger.kernel.org, ceph-devel@vger.kernel.org, 
	cocci@inria.fr, dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org, 
	gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org, 
	intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org, 
	linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, ntfs3@lists.linux.dev, 
	samba-technical@lists.samba.org, sched-ext@lists.linux.dev, 
	target-devel@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
	v9fs@lists.linux.dev, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="UTF-8"

Hi Steven,

On Wed, 11 Mar 2026 at 15:03, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Wed, 11 Mar 2026 14:13:32 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
>
> > Hmm, now IS_ERR_OR_NULL() is an inline function, so it is safe.
> > But if you want to use IS_ERR_OR_NULL() here, it will be better something like
> >
> > node = rhashtable_walk_next(&iter);
> > while (!IS_ERR_OR_NULL(node)) {
> >       fprobe_remove_node_in_module(mod, node, &alist);
> >       node = rhashtable_walk_next(&iter);
> > }
>
> But now you need to have a duplicate code in order to acquire "node"
>
> I think the patch just makes the code worse.

Obviously we need a new for_each_*() helper hiding all the gory internals?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
