Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7038315253F
	for <iommu@lists.linux.dev>; Thu, 25 Apr 2024 20:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714075695; cv=none; b=ryyRVLDC9YKSv82mjRPMM4h8Pm8jLP18F2n4nmocx2vK/ju+EyT0gSI3qoX94II2QOvNy/eaxNCXmmmljhze103Q+xjxd655z/pH+8K3ctoViC4Ub3XJYBmqODzzHaQlzz0EuCVk75M7i6DudruJbeflHuDomtO+Jt/p/6UqfJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714075695; c=relaxed/simple;
	bh=7ciCYviadDCESvkbbfYYDhcw4dNfYDHt5C6Yzrv1psw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hq0FB8kQX+8G76A2d7z3NhOO4aXQQTbNWFEAmzuZgoTpKsXRPCEtUVh0nbWZdu57Z2U3C/IMVJsQcT0dTKcMx326GhA589NlDNY0Jues8IAy/tIMyQ5//QrdCtv7pKML6udVNsxKAB8l/FYLr9A+eQdZ3p6NUDeKoGu0RmZtPm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Rp7MZUlg; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Rp7MZUlg"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1e9451d8b71so12619705ad.0
        for <iommu@lists.linux.dev>; Thu, 25 Apr 2024 13:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714075692; x=1714680492; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ekH2ncVU5TU90wC0+JU7SiT8D9UwcwiJNzKzOJmDUPE=;
        b=Rp7MZUlgm2X3rhykkQhCf8GYMRrg8faxA4BZZcDlYWoHLLEAp8WPEN2YRNLD/KGjCK
         rIsffC1uQ6lElwKwjnEXTVRtbQIvVQ5ATeRwpTTGKD24vw14As6kKa6/1h5VNZuY3DEX
         GDpeCmZeaxY0krur7e/dMShErC09zToziyRYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714075692; x=1714680492;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ekH2ncVU5TU90wC0+JU7SiT8D9UwcwiJNzKzOJmDUPE=;
        b=nN074MNc1UAjeQlKUEpLHwYdMEYAIOsd7B44t13197fvILVHmMqPA/fNpwc/Q7Hxk9
         kOjbFNxk5mMRzipKtvHwVFxL0LXyuhr83Uf0QG6mrwnAm06wbIFTCfsH7RZvlEF4uNfH
         xV3qGPw8dquB1q0nUOXTXciHcZCHydP8qn64dmhLJKCMD/8DZG48tADahEUpivL6PEXv
         GTh0DzjWWMx6hk2dZTxrtMfSF989hwNgVzQsBiGAlLPmPnXeYiudWqT4BLHcaTDha53L
         vkTCe5oF9l3ScGC/1RwFJseoco/Q0+2HiUoDiKRqmbjwcx3AtrbL5y6RINw9um3GK2Of
         zc1w==
X-Forwarded-Encrypted: i=1; AJvYcCWX8OGuZsTwlRCf9AYpwJJKcyv2Krx2jv4bYQ68ZyTUqrN9HiiFYTHRt2bub8YeiFC6yH++dH1aB6x/zqcXhtrwMN/z1Zg=
X-Gm-Message-State: AOJu0YxnngGkOABtNMEyT7Ql0HaSeXEWPtyav1QoCNZHiPd1BnNCdM69
	yAet7tJjh1X2MW1K56xzK9d5iF8BDl0yu3HxuIhpvZJlpvvoR/aNK4nITwg+Dw==
X-Google-Smtp-Source: AGHT+IENLaRsnHeJ8vPQA0HMTgbKv7kjkvunXKY2OsqKLXqA91N5TvqvgatgH/rNiBbiRYXFmTuk2w==
X-Received: by 2002:a17:902:6548:b0:1e9:519:d464 with SMTP id d8-20020a170902654800b001e90519d464mr560628pln.65.1714075691780;
        Thu, 25 Apr 2024 13:08:11 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id m6-20020a1709026bc600b001e99ffdbe56sm8266309plt.215.2024.04.25.13.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 13:08:11 -0700 (PDT)
Date: Thu, 25 Apr 2024 13:08:10 -0700
From: Kees Cook <keescook@chromium.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com,
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev,
	mgorman@suse.de, dave@stgolabs.net, willy@infradead.org,
	liam.howlett@oracle.com, penguin-kernel@i-love.sakura.ne.jp,
	corbet@lwn.net, void@manifault.com, peterz@infradead.org,
	juri.lelli@redhat.com, catalin.marinas@arm.com, will@kernel.org,
	arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com,
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org,
	masahiroy@kernel.org, nathan@kernel.org, dennis@kernel.org,
	jhubbard@nvidia.com, tj@kernel.org, muchun.song@linux.dev,
	rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com,
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com,
	hughd@google.com, andreyknvl@gmail.com, ndesaulniers@google.com,
	vvvvvv@google.com, gregkh@linuxfoundation.org, ebiggers@google.com,
	ytcoode@gmail.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	bristot@redhat.com, vschneid@redhat.com, cl@linux.com,
	penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com,
	glider@google.com, elver@google.com, dvyukov@google.com,
	songmuchun@bytedance.com, jbaron@akamai.com, aliceryhl@google.com,
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com,
	kernel-team@android.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-modules@vger.kernel.org,
	kasan-dev@googlegroups.com, cgroups@vger.kernel.org
Subject: Re: [PATCH v6 00/37] Memory allocation profiling
Message-ID: <202404251307.FD73DE1@keescook>
References: <20240321163705.3067592-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321163705.3067592-1-surenb@google.com>

On Thu, Mar 21, 2024 at 09:36:22AM -0700, Suren Baghdasaryan wrote:
> Overview:
> Low overhead [1] per-callsite memory allocation profiling. Not just for
> debug kernels, overhead low enough to be deployed in production.

A bit late to actually _running_ this code, but I remain a fan:

Tested-by: Kees Cook <keescook@chromium.org>

I have a little tweak patch I'll send out too...

-- 
Kees Cook
