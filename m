Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0D386AE5
	for <iommu@lists.linux.dev>; Wed, 21 Feb 2024 21:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708549905; cv=none; b=iO6dpZTYfU6gV9CxuY98CPs/EWLvCue4Vz63EzoVj4BpBRx+ALpd631LTp5gYxCQ0Ues9hQJxAqBXOqFUk2d2zEWYNT8p0LSLzJdMyS654LGIV/ym2jmEARntE1zgd2TP68LIYlJAscC56l/e257tWQSeOPf1FQbspE9qgur4n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708549905; c=relaxed/simple;
	bh=azPaND/xFc8atz8F6WN4yBES0vGIQl6FM+kHStQ3aX0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rprGb9kf2k5fXWKekmIBRajjwuuRFe/Qne9BrbM9bBPOp2e7InfTsacqmLGhVyTayQ8aa5i4Qahl1cLDvCkWHJ8w+/VWk1OJWaRVOQHrkyyYa/KDUDR6NsPoObltA8CNH3V1pnGlj9eV1fjhPA3VkwA8U//vpty4ZV6S3vbJi3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=D8EN61mf; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="D8EN61mf"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-42a4516ec46so2062531cf.0
        for <iommu@lists.linux.dev>; Wed, 21 Feb 2024 13:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1708549902; x=1709154702; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=azPaND/xFc8atz8F6WN4yBES0vGIQl6FM+kHStQ3aX0=;
        b=D8EN61mfnFFCkQMBLGepChjEknIVmI9iDRaJ824phkgQGP59tEMGfgP4oe1/aNjW7l
         TYGaH7jD/DHj6fG9wNLQtgdY2THuEbrJFnO2w3SW4TcY+BPHj0R1TTFIaLQ2KDUwvLJt
         b7YY4RA47Ew+vRPwr29j4BoFhdzScsE9VtqYeWlynW62G0KoksACwW1J65QObBjKNFBQ
         ubZ3xMTU80KiKY51AwcOVlvRc4lHowH3F6aQXBSC9nGr5xQemlT+zmsiNDgQJRRsc3BM
         6GPnak6VZOfmgVfOBTdFWwlBvfQDTOmLVZXjXbuuzIU0M+g2wnFn6YGRQ99QOGynNfAN
         wWwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708549902; x=1709154702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=azPaND/xFc8atz8F6WN4yBES0vGIQl6FM+kHStQ3aX0=;
        b=nSldoxbB1TmYx/dGsqPxNODKbd8aqPmXFiitLvOmhj1n9OQMEspxUl3RLCE1kmvBX3
         I6U/BtXHfhsLeqg9BmTrJj+vF+Zcg+FgqMYZZLp7gnbwU29DiserrY322EzrQJEDqA3w
         6fk+dkrfN7phyRWt/rnlJMV728RF8JTUks874S6eEt7wP1ysFsSEre3N9JmX5gSySj/L
         NmJvP4gYQal1vks1P3TdIJpuO3jJjSTqg60WUFTcZH0kuze+m8hbwdARLJVKKda4F8R+
         BRpVDNvsp3dvOPOLgWkxKNxIZHuQffp3+RDXukF2sTfyk3xq5C45vHWh3suQHPWs69XJ
         MEZw==
X-Forwarded-Encrypted: i=1; AJvYcCUYHI4RalxXsav5dKAHj/A9aXAFqRkqymF52TMc/TwODUFC7Gblzrt239zwhJp0tf8UtuU8cRlJStpLBEin4JBIu7KH7LM=
X-Gm-Message-State: AOJu0YxjO/Tebr7dwy+mORxzJ61q4GxSSl6maGLjNsCd69dBdYLUjU8k
	9AXj5t4Y1Iw51+k99EHHOqyrZ0BVW/zFhlVGqCx87bj3rX27YqsQ0ezY2FGmOY4qmDXFnpKACgq
	A0TEf1kACWrlFsgT1lDTPGRpTKn27Zyus9/yDbw==
X-Google-Smtp-Source: AGHT+IEHXmwL8Aza8YxstZPNawifsEoPmvz+hNBFt6a/ALIjCAdVsEQDIakNnjXyrMZE7cImyXSV0z0ORZ0TJZY1zT8=
X-Received: by 2002:a05:622a:1a0c:b0:42e:3f7a:819b with SMTP id
 f12-20020a05622a1a0c00b0042e3f7a819bmr1401231qtb.8.1708549901753; Wed, 21 Feb
 2024 13:11:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com> <20240221194052.927623-3-surenb@google.com>
In-Reply-To: <20240221194052.927623-3-surenb@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 21 Feb 2024 16:11:05 -0500
Message-ID: <CA+CK2bAs4t1UhLBahnG9GmFYgW2KxdO7PZkPwD4Wbv7oE+aMhA@mail.gmail.com>
Subject: Re: [PATCH v4 02/36] asm-generic/io.h: Kill vmalloc.h dependency
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com, 
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, yosryahmed@google.com, yuzhao@google.com, 
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

On Wed, Feb 21, 2024 at 2:41=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> From: Kent Overstreet <kent.overstreet@linux.dev>
>
> Needed to avoid a new circular dependency with the memory allocation
> profiling series.
>
> Naturally, a whole bunch of files needed to include vmalloc.h that were
> previously getting it implicitly.
>
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
