Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679DF132499
	for <iommu@lists.linux.dev>; Mon, 26 Feb 2024 17:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708967613; cv=none; b=m2oidFbMjTf1t6/NAyWxUpKl07JqM+J4sCcbqPd2tPIbSoLOByBLrzi4PFSbpMqnV8XBjx1NIaBvMA/dLo4Zv05tBKcJJWWwNhVSm5sL+LnNlEK3vIY8TrSbDd3gKdAJ0NM4MMSypzLz0K+MMgSgKlupmBlweROrE22O0EvZXmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708967613; c=relaxed/simple;
	bh=EyV42V4YwospafBlBP85zlF0CzzIrV0ckGMLg38+cps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kOvWoly/E9OOxf3qvetBc1owsTPF7Xf0pVbtAPeUqZWsDfiPwL2yV3fmbhoZbmKiu8WMBTfcxDiZOMSVHSucyTdI6qhue3CDQLJwuz535nN/hF8sDRgIuxtu7PcmxD3tHCi/PotmyolYHh7m1Thldo9AT/pnS1MAmCtnl236c0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H5vsUWDf; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H5vsUWDf"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-60921c4dc27so363977b3.3
        for <iommu@lists.linux.dev>; Mon, 26 Feb 2024 09:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708967609; x=1709572409; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EyV42V4YwospafBlBP85zlF0CzzIrV0ckGMLg38+cps=;
        b=H5vsUWDf+NFgt1GV7xY7Rv+0wjBUjGmPpi1o1/Nxpu2RinxG87aWS5B6X6ia6h4uLd
         5AIlD1ZwAoQ5C6J4oGxFXotH2Pl/Z6052fjqjQdO1V2WgK8m903HBLRSzbNry2k4J4PX
         BjMpe2nRs93HR238AzSEyx8c0+9WI1dg2dIF8KY+odLDhJtj9atww870D8jif4Oaiw+5
         Deb9bUQUSVQDJc2zuYnZI2HU0isoFMF14TFKRSID5alUMQks/cGe15ZvvXPUPq9lH8zL
         3zKT6DD66DxZ7GMPkinRr172sMceGsI+bPuPAArOgVzmHHCeJuKk05gW2jFaZMG+wiAL
         N+qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708967609; x=1709572409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EyV42V4YwospafBlBP85zlF0CzzIrV0ckGMLg38+cps=;
        b=ms7/QFWK/KC24WV71hqrW9EwmxzyFnwy2hVOGRsxvnweQesNNGsjMi2LAeNdSJqhsD
         7oXd0DeyojZ5syWAFj0Xh0+cHxJi5FiEUBsJtu1cdIiAavNad7fo/33UUTfKm5WX/YPD
         NYOkNn5l8nZi0HWJSa3/SWkQm0v6gGOx6WTlMFI5PLBdrbsu92IyAUcaKqTiUghQHio1
         rEnfGZpnzVnkSid9EWk7KV83g97MXkbFC7H/tmx4O4VqvWBd+eXSxmE3ccvKhVBK5Nzt
         Q/KZiyjz10430rPq+NTMBvsO301ICms1yQNS0+y6+/DQt1V5WeqFXtMg2QM2buQW6NO5
         rcAA==
X-Forwarded-Encrypted: i=1; AJvYcCXvDHjYolzUY493w5yxXQ1A31GtIJYgDlU+JLTI3pGJ3sVZGvAa2cQCnvLX1yByhMTEvzJmoesYJuCXgb5M7IlkUYaBBiM=
X-Gm-Message-State: AOJu0YyldD/8ibQd9spDyRvlkWDyC8F6UJvGG2WZQacd6meNdnRLkpEt
	o0G06hs5NnsCSg3BrZ47YeVbVEB96Q1wRzkir9edQSVEP8B5sT8F+AqPYfyvNOsqmqG9Uf9Wyt+
	vk11BjqJvbYkBPRP0yBRK2HaUoXYpqDVJwgCK
X-Google-Smtp-Source: AGHT+IE/7/pQws6CVfL30UNt1mkliSDpCczaElkub3hA0YpEAm7Kcwht1trOE3ZU3RPvAg7BLiFgI/3lAi1UqBVzgIg=
X-Received: by 2002:a05:6902:210e:b0:dcd:1f17:aaea with SMTP id
 dk14-20020a056902210e00b00dcd1f17aaeamr6639276ybb.26.1708967608014; Mon, 26
 Feb 2024 09:13:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com> <20240221194052.927623-14-surenb@google.com>
 <a9ebb623-298d-4acf-bdd5-0025ccb70148@suse.cz>
In-Reply-To: <a9ebb623-298d-4acf-bdd5-0025ccb70148@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 26 Feb 2024 09:13:17 -0800
Message-ID: <CAJuCfpE6sJa2oHE2HrXAYuMeHd8JWd0deWa062teUs3bBRi2PA@mail.gmail.com>
Subject: Re: [PATCH v4 13/36] lib: prevent module unloading if memory is not freed
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

On Mon, Feb 26, 2024 at 8:58=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 2/21/24 20:40, Suren Baghdasaryan wrote:
> > Skip freeing module's data section if there are non-zero allocation tag=
s
> > because otherwise, once these allocations are freed, the access to thei=
r
> > code tag would cause UAF.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>
> I know that module unloading was never considered really supported etc.
> But should we printk something so the admin knows why it didn't unload, a=
nd
> can go check those outstanding allocations?

Yes, that sounds reasonable. I'll add a pr_warn() in the next version.
Thanks!

>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>
