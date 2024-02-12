Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45644D5A3
	for <iommu@lists.linux.dev>; Mon, 12 Feb 2024 22:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707776074; cv=none; b=uytTem+br5c2i9LReUuRRxJ0+mcQzSGMmaVIY8wyATx5QGgbE6xWCm6im9xQdMFbfYnKv69/Ey/+PgklJou4sRKvJCMoin/p7eFlZjP2St8qVGp5utOXTeFsOPmZIv78RcOX43PpYLpqZOUp6orq5l0x8hMd9w7f+CX/UGcPFmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707776074; c=relaxed/simple;
	bh=h3lvxY7RwFA2qmllpedkHyA1V2cF2YBOaMy0Y3HF4OQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iHYpgVa1EnALkhmF/pfkLFRYvqgayRKB+RvQEAAkFuTERJygsGW7S8GaWCtRyZRSO9gedONv9u8g9gX/pCQ5ulYRRCVGC0zIUb9riagkq+NiK/4KGABGwLX8IphwPWJF48laSOSlBhLNtSrvzdvzqo2knO5PAKl0s+lSbi/zFC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Hcp2EL0y; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Hcp2EL0y"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-290b37bb7deso2688448a91.0
        for <iommu@lists.linux.dev>; Mon, 12 Feb 2024 14:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707776072; x=1708380872; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RIxrgJSE63hrU/LEeVrXgeewq/cIy3PkJ41qNbyzIVA=;
        b=Hcp2EL0yJXmN/81p0Z9EqcTbQRCUw1QSMSWNd9m4E49hvxpN4RrqPUW/3ay9sEXiBY
         bGFvzUqJJY2AmDOd/l/t0ut5WE0k1wTRqs4ZVTvfVwnrVAAA+EOBC/byGMdMilkwNgG4
         1AqNP6kke1QKwxCiEkd9KhSKaQrtoLwVdcdiI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707776072; x=1708380872;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RIxrgJSE63hrU/LEeVrXgeewq/cIy3PkJ41qNbyzIVA=;
        b=tdDLcEJDlf3BOQ3OqYQ0JLDif2oW1bYLiNYxgYNN3osNq5Xke6jmcJsMZ5rSxVLcSJ
         8rFwwfj5hyEtPjHOpoAjGv3WQfpuwy8m/IPPaYZtP+hmFagLRRp0liWNgnumEY19TLTx
         NcoPlq23p1tg+XcE7ILXsvtrWGZWA1jMJl1gu++bH3j/bGaApNqxA+/mEF0/MI6GCNWx
         SnDfa0eeMEVV8RgLZ8/3ivYhRPxPBCJPUxMA/J7UAznB7xiHT1OdcM5z4RDhTGSBXOLi
         nO1fmabJ9HJgvDS31u224H2wPSJtHYewflKAyX8jy8jtHi1BEQMC9htq+6S9O5tybmsb
         5+aA==
X-Forwarded-Encrypted: i=1; AJvYcCVfbM7/BmCVrdgpJuarg7ooTVCozaIhpg848tBBwhygEN0KMQaUImNvF30yJKh4u4MjyTKsz1YlAjK+YOFC7QE/vYc5PUY=
X-Gm-Message-State: AOJu0Yyz5nUYVYZfvH4ZwwnMvKE25zq+txZMmW2YRlLE2pR0kLEja4RZ
	ElEzSxebbfi80zb0zp28/MRXdYLXvmb47M7tg0LlV0IlRuZysamLfFW+85MHHg==
X-Google-Smtp-Source: AGHT+IFiqvYFTcqWnH4OIf/1Dh8kKaLyS7c6HZ8FWCh2Bts+fuw53yU8/1Sv6ViBQjb2otqFVY6FxA==
X-Received: by 2002:a17:90b:f0a:b0:297:202a:3ba6 with SMTP id br10-20020a17090b0f0a00b00297202a3ba6mr5321895pjb.0.1707776072170;
        Mon, 12 Feb 2024 14:14:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVsNU/8NsDmZt/wglKpjvkWUqHuMmKfr1qDw7hshzseGvRlVn91OWfIWbwPNUldThoFCWHouAaiCcJaR42pa2ZOj+4fu2K/RLpokhW/LHNcfv2bpUoorqtQmMzzcr2uE77OUtmraZBpl3sk2+0JkP3q2aqFPvO8/oCz10/YOwXZph6krxIzkBVwaNb3wv/BrgWTPxyHhkA/nJZtQbzZAwr7loqQ/pCv/14+512lJkj6b5pedTy1UYbPe8fCvkg/xo7qb21F+hs+Z375s58m1Yaqt2RqOXotKP+i3q2TaHpNYX7+Qm1cOW+PXXl0zvf9L5VQfmLrwbCN3rKQhZW/nxd+mxJsLIzrBbjLbMZ0pkF3X38ElFtwskqogWZO17OXKEFqsMjg8CcNd+OrzYfm8i/+GWQ2aoFnvE/VOIsG/Ftpg1X8Xjb9NUgZKHW9NcJAKH9ypNH/EyYK1p4u4VLqY9iriSV6bAxOqn6+QslEU1mHLsLSoMCDXP9iT2o9sZPWgMHL2KdE2sxLxLDrmrAQw82/6vIDTAiOP+gfpX5103QSU+zIn09beoujZ5rXZoEFP2EV4cXNa2fOMDgr7UNTZOyXZY5zdYF8ty4SkdCJI3+tJOtPvCNSgNrNGfOVWTOKs9FTVkNVt8KD/AR23yzqYgL3hH9cLzUNzLgthNx3j8FdaGaJuMjOB+oaxAvuEuwe4ekk5L+mT0ksuIbsY55UWlDcgj1J1Ekfcl8tppAS5UCbJ6oiNYA73Q==
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q31-20020a17090a752200b002970cb0c22dsm1120551pjk.49.2024.02.12.14.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 14:14:31 -0800 (PST)
Date: Mon, 12 Feb 2024 14:14:31 -0800
From: Kees Cook <keescook@chromium.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com,
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev,
	mgorman@suse.de, dave@stgolabs.net, willy@infradead.org,
	liam.howlett@oracle.com, corbet@lwn.net, void@manifault.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, peterx@redhat.com, david@redhat.com,
	axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org,
	muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org,
	pasha.tatashin@soleen.com, yosryahmed@google.com, yuzhao@google.com,
	dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com,
	ndesaulniers@google.com, vvvvvv@google.com,
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
	vschneid@redhat.com, cl@linux.com, penberg@kernel.org,
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com,
	elver@google.com, dvyukov@google.com, shakeelb@google.com,
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com,
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-arch@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com,
	cgroups@vger.kernel.org
Subject: Re: [PATCH v3 06/35] mm: introduce __GFP_NO_OBJ_EXT flag to
 selectively prevent slabobj_ext creation
Message-ID: <202402121414.EACBD205@keescook>
References: <20240212213922.783301-1-surenb@google.com>
 <20240212213922.783301-7-surenb@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212213922.783301-7-surenb@google.com>

On Mon, Feb 12, 2024 at 01:38:52PM -0800, Suren Baghdasaryan wrote:
> Introduce __GFP_NO_OBJ_EXT flag in order to prevent recursive allocations
> when allocating slabobj_ext on a slab.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
