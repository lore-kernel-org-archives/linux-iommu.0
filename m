Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465C179B78
	for <iommu@lists.linux.dev>; Wed, 28 Feb 2024 18:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709143522; cv=none; b=YC5lR/Mg5q60EfRTqvAaVtp1uA4WzMgu6/3UyCQ7K8Jck1M/sfgRQit28rnOYFGpvlfwyCEyBcWqL5HnYHRxfEOZMDqKmXpg0Ni0SR1VMBcIuWEoClizVIVbBCgrptYbVRxS25B3lHGGMYW4IXf89aoOPLvaVBqrf2sS76/y/Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709143522; c=relaxed/simple;
	bh=M5RWLefMMZcrjC6ohvg7ZMSlCbzmM6eu4zL9kM45cas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KcVkyPtdg4Go5faJUmvpLOab7WfodTGOytf+rffgLzIoUd6m7KFxWSGTRLHaheAn974Zi97Zvy6vghVP75Y32lYPJV//Tx3aiaDcXGHNT57zbjWuBSzvrMRBo2YB7yenXG7vRYGrSOusBcQTvyfFEOY0O83FEEsPoQQRZOogktI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ndNxK69o; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ndNxK69o"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dcbf82cdf05so51486276.2
        for <iommu@lists.linux.dev>; Wed, 28 Feb 2024 10:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709143520; x=1709748320; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M5RWLefMMZcrjC6ohvg7ZMSlCbzmM6eu4zL9kM45cas=;
        b=ndNxK69oEPPk5RNLRPjGCJIQZ/fYBB1hkUzLwm1a9ElrdjgqqvD8jD77CDYZmHGPfv
         AyIkbNim2r97hIZ1HoCPJzM3q55JFkUmZbC654iE1yZTtlgmgni6qgpFgOYA1tkvZww2
         fdLzE8LZFgG8N0FAAInNJ/tTkwd88Ipcl/3HMrOlzbY8+DKon5AoAJjDr34cnK9TlSLe
         UuO+pWkEnb1npJiAuqmWtiPj4enK6Te+x4C2F3xvCFzAdn9sXYrmreJkJocpTL8qCDeq
         E4MdIvbSp1bCzHChJHlXEFDUwRIrjpHkvayrl/VmxmKKqBbnmlkOAxPT/CXZLTBkYD1D
         02Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709143520; x=1709748320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M5RWLefMMZcrjC6ohvg7ZMSlCbzmM6eu4zL9kM45cas=;
        b=MKarQC30JsgMNbMYM4DIhc8+7aM8IWCTqmSpuSrkfUn0M8FEb7dmJIeTDawQL7qpxC
         cRyqkJX7sDP2QvTf9ApBSU6TxGuvf9e85mX/brJrB+evp5ym5Y8Wo5LO7LiXn3sAZOtR
         httZnia978FfxYX5I6640UkrMVxvvF0cs28zF3MnbEq+fUklrMCmfp1kFv2qLactSj8w
         LU87pgH1IfB5Y5cuJw3y8WZm3DzdHslzKau4Q951IPQKKNVxl0HdBmMsYj2Yliz33b3S
         jVtdvBMtbz4/qCQie4UYioVIJetSzdVuzJtLoSojKODsYmHW5Lk79xTSAEXA2Q92MAFz
         v/AQ==
X-Forwarded-Encrypted: i=1; AJvYcCW958mGwi717O7pOS3hyZOTcMtmCBlODEzuNR/WJ4Udk6cotziXs41Xyh8QpaxcKthk1/w16GEiTy13v61gAfGBL0Hcf5g=
X-Gm-Message-State: AOJu0Yxr+qJNhheJBwraRMOZAKAo0u3ZN9pXz8G1EL0/t1OxMa1OgTjU
	5Dg5KqcFbLdjghB9nBi+StjGKxJKXe2lv5R9FNb59ctuxm3MO+XYscv4W2A2gU7qZCAmLTIyJwG
	Vi5nSPFP+ul5qO+rMpj0rmhltUkBYqfDONPHC
X-Google-Smtp-Source: AGHT+IGXC8lezvXLfyLFgurkGO2/8+xbMmbLbWU2Dhx0X772e49nOZcLM0/mejcqQER1kvdSNB2vVup4Slt3VEZ2U4I=
X-Received: by 2002:a25:4687:0:b0:dc2:398b:fa08 with SMTP id
 t129-20020a254687000000b00dc2398bfa08mr21101yba.31.1709143520037; Wed, 28 Feb
 2024 10:05:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com> <20240221194052.927623-15-surenb@google.com>
 <1287d17e-9f9e-49a4-8db7-cf3bbbb15d02@suse.cz>
In-Reply-To: <1287d17e-9f9e-49a4-8db7-cf3bbbb15d02@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 28 Feb 2024 18:05:08 +0000
Message-ID: <CAJuCfpGSNut2st7vKYJE7NXb6BPjd=DFW_VEUKfw=hGyzUpqJw@mail.gmail.com>
Subject: Re: [PATCH v4 14/36] lib: add allocation tagging support for memory
 allocation profiling
To: Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
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

On Wed, Feb 28, 2024 at 8:29=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 2/21/24 20:40, Suren Baghdasaryan wrote:
> >
> > +static inline void alloc_tag_sub(union codetag_ref *ref, size_t bytes)
> > +{
> > + __alloc_tag_sub(ref, bytes);
> > +}
> > +
> > +static inline void alloc_tag_sub_noalloc(union codetag_ref *ref, size_=
t bytes)
> > +{
> > + __alloc_tag_sub(ref, bytes);
> > +}
> > +
>
> Nit: just notice these are now the same and maybe you could just drop bot=
h
> wrappers and rename __alloc_tag_sub to alloc_tag_sub?

Ack.

>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>
