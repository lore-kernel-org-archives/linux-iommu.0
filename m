Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EF3290E
	for <iommu@lists.linux.dev>; Thu, 22 Feb 2024 00:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708560778; cv=none; b=a7bTSzO2vT65KLFJJMOm74/83NSqbL43ZmHjh+mvjw7fLUixoVxI/IxRC7AoW1TKUH8IaMisSAYrtg/kNtVlZFBIOKTHSdAGhW3k5vBE39LBas5yNzflYjsBgAAKKC2q3zgngjxJugVWffF/FSq1R/noMd5L/lJ1ArzVb5r+0FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708560778; c=relaxed/simple;
	bh=yPsvw9vJzS5OOehh2obqY5C9ccmf1AALBE4na8IWGEE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LnoiFhMco08DZaoKqYWSVDhCBW25odnRvECoShZw6Snsitpt/fUti+mBHfN90J3Zq5zQqBc4AVFN/eu93YgsE/OSholZq6cEFwC5W/IzF9kWfJynRahjvxoBb3ih67rwhMXzkcQrYfTP4pBgd6U/B1AKQ37bxmhFGBU+g/KASnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=MdQ56T9u; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="MdQ56T9u"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-42dc883547fso7014281cf.3
        for <iommu@lists.linux.dev>; Wed, 21 Feb 2024 16:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1708560776; x=1709165576; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yPsvw9vJzS5OOehh2obqY5C9ccmf1AALBE4na8IWGEE=;
        b=MdQ56T9uxUZNZe7Kf7j9Z5y4tGnvZ92R7hOSfgYB4x0/wq1sj7DXs5yQT5/PaiyeOr
         HZusgyxNBv/kOxMRdGgJcubqhivmmnDVdw8GVUp7EawsjAmU9KPO5Ng1sX+FW2KjJ4D5
         TGK2AJh11kFYn86ID21eXvHTTJmNRT9H+qky/F551eBAKcsJi/DU0prT7g5UkarrnVJb
         9C7Gmr9q6PR0Fq1uspAHRuBUQZknVSm8eO4jye28dihiKTP8XX+UiW0xG7mQ+8vU9aTf
         SxZ1C6c6sljqicBIyyEBXCpx6096miX+XqNfcYLWhj1WLkmsdA34VwRTsGBYGNv6MQfd
         52TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708560776; x=1709165576;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yPsvw9vJzS5OOehh2obqY5C9ccmf1AALBE4na8IWGEE=;
        b=LJf+4I860gkzfdNQD6PjuSusMyiob6J/uxZjckHv9Rrrr77Ei/wawhmhNf5KJJ51Yd
         Dkz+B5J90Ny6rzYyu2agBQAb1yiiajmheT64sCg7Gq8AFYt5tJUe5H6By7ziE6LTtzi8
         12r2BXpmESlXPbhi8Kls1sOBdMDxzQFKpHeiS/d3Bo/On9KWCEmp7PQIPeayY5hOxibM
         OrUWyyd8ey0RsaCCXiEWnZsVJTegyAtdXfNVOCMMX1PGkSxGBOUEoSif6jr2nycL8IEn
         A0JzheaT20JwJjWnY4O8wi4BmLvDewMILzAMwW10bY2Mpajwk7wR3acWzducvVTZTa5t
         yc3w==
X-Forwarded-Encrypted: i=1; AJvYcCXHfH1HRfHK18TXkDwUNsKpKpCYjntY6p49oNXOoMOQhUc3cpNL7SWbelwvC4QOYERrxML++8zeVhQbQ1h2dMuVw2XfnRk=
X-Gm-Message-State: AOJu0YzOpZ26XwrdHLS/s+tzcZqY8sPn7VlFubf1GsIS4krZ6hXLvncK
	mShN9kVFzW7qfEU/4QgzY58NM6urjU8Q7tz8hSLCwkAfk07Lv3zvrn5Id5G/4n5TqW5+pKVQTBR
	y9TKd07vZrf0X20e0VwnzWoqXVikULYnG4fhotw==
X-Google-Smtp-Source: AGHT+IHC2jE3/DoAiHiK02zORvbTKUG6myX0k7i1f+aHTzOQJjz8xfPJY5H0xjNb5qm6LzazHkaY+DyA8GGq0QMoj/o=
X-Received: by 2002:a05:622a:1996:b0:42e:1911:93fc with SMTP id
 u22-20020a05622a199600b0042e191193fcmr11082250qtc.55.1708560775667; Wed, 21
 Feb 2024 16:12:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com> <20240221194052.927623-11-surenb@google.com>
In-Reply-To: <20240221194052.927623-11-surenb@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 21 Feb 2024 19:12:19 -0500
Message-ID: <CA+CK2bBBcJfgBU-O600Wx-2yHs6RUdhT+n0wsHtieU-rSHn-Ng@mail.gmail.com>
Subject: Re: [PATCH v4 10/36] slab: objext: introduce objext_flags as
 extension to page_memcg_data_flags
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
> Introduce objext_flags to store additional objext flags unrelated to memc=
g.
>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
