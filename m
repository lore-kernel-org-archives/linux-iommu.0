Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693713EB810
	for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 15:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782747080; cv=none; b=EePOLQa4Ylf2nmQlPm7iWwjzJC/c+T2gK1q/0KtIZRA3vpOfyoKlBbMyEblAmYHkI5OuS4lgZQifuXXRzvRrs8hpUFm+LYycapS6NLPVCW8GgptZj8BFvqahfPDk4AfXZFJ/IXGylKWPPb7bdVAj74BBI9Isn5LPE+EOHAdG+Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782747080; c=relaxed/simple;
	bh=eSLebA2K6K0JqwA20gSpIaLBxceDZU1DyvE+HEyhHoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dmSr0KxdSJiC4qLf8uFC4EAf3vEa+eD+iDa4oxCkILUrXKvRWLCGnaTDzhcQqzN8IlVXtpg0WLFnl7vj1YiImUvm0xWBpf+FDWoLHNZ6WJWXqDCw4C8L+nKm7mVEAO8Vwnq7Q3BR9foPfSSw2oVyF7PTdPxfiTZg0eC0bqsA/lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=ixk/6iiM; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="ixk/6iiM"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-6a1133217easo1369728eaf.2
        for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 08:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1782747077; x=1783351877; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TtnRVAeDbe2jCD/DHkmGFKsvQqrt7nLFRBhYCay7qN4=;
        b=ixk/6iiMBqEtYZ1TFLxzipN2MI1SDz5m+sdkHlRgPpGJSNl/NKtFPtNjRJUFWOy9vE
         3Emx16WDSvd+Eqe9/xGpPUfpGrmpPFMkPM863hEKBrsTHFmkHrYf+UZ2MVQqF7PGoLeB
         549LflqTcyZAu/qLFbmCYzCftSvnLSlqPILlpCfkTqz5Nb5tB1PbDCenBOHJ1lTdWoC4
         modxbuMzK2o1L7CwDVJM3F7dQ05XYMZaQe011BMwVYF7Yfap62N+uU/bZOX7SA3kjQCI
         hHnZ9B89RuKjdEzVvyPxlbXM3Z7NZaMdyYN0SBX82HaqcAzxRBkAUkIbm3/QrB9zkN33
         FlbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782747077; x=1783351877;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TtnRVAeDbe2jCD/DHkmGFKsvQqrt7nLFRBhYCay7qN4=;
        b=L+4uYRtqW58Xs6zBG9I9Sj7ZpJcjpm74rKQ/LeFyWbmYeAYs7/9AzjTvwwHim1MvbC
         fUsWhsDlLDOWFhVkWaLsB/yXznosC94Jj4nVkKDh3LcKZZk51VgJRoRwANo2L7QYm+2l
         Ibg54+hVhCJ+g8FJyivOJBLoW7eTy5R6GoaPGucF/98ywb5WwGbSaYSzLnAOkKWmoRrJ
         g12alRfQcrRkkJhJps22E9WK3LbkHCOa6P+AGPT8VGQKz9Qfx6PnofuKLN/MdXYQ/t2j
         k02c09SUKUPXw1OUNiCW4eDClXcde8Uh+zCZkY6H6rvSyx4Qk0SSYmKlMA7B+HwEqL2l
         gH9w==
X-Forwarded-Encrypted: i=1; AFNElJ/rqEA3mM/Vp5NNukbTPfL1wUfZU1chsdOIMklTq/T6v8yY9iRCmsrs2UHmyjI3WxxwuUu6MA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwrcU7Hadw40NAvk5hEUBbN8QxGVEdmYjmUI3U20TI3OwCnmt3t
	DMgAfOGywH8tIOTlkJhnl2g9W8Ik20WMP4SlrnanwdexI7hmUmHWYyWXrhyHqli0Dlo=
X-Gm-Gg: AfdE7clGylXmM7jWclJB962YRVrWRFPFOxj72A/C/LyRX9r8TcwtXJTWK5trZaK5qos
	OQ4R+iCRnvDFQnrAkU5Qs0CrWLuNDIfFZkKB/jJNZgDU1g/Ru1hKZ2/14ETx9l+cpVk/ZkGMWwl
	gFu4luw2yb/kBLe55VSlehG+kK3IlJ1+COMqKYjKiZEX1hc24C/7edbAfdh1FhV32HKv+bkhjlr
	X7u5K/qH5x9/+ccfandKLbVzxBuinG5qzLb+tDWG1wY7Z3pFn4CEFdXWsQMndTT4/e1jDsVqi3K
	be4GMZ1rv6XlX+RlSp0UmpUhaTkDtMaI+BWdDw1wvd2bSvpOmc2u8WHNBccscMIv8bVEcUr9N+v
	sic5xtADAJloofxEIMmTbNGEYNFOPXZfUX41U35ZZWOkitLITgZEW1KQgLY2wdPOwOPmyvNQwxk
	WRgaAxQy6JpXtF4sPQW7DLGzhPlxI7qBzBwe3g2ET9veQdCxzG+9U6sx1jEAL3tmAQc2WEoKaDt
	jBGPeQ=
X-Received: by 2002:a4a:e914:0:b0:6a1:524b:1f5 with SMTP id 006d021491bc7-6a1891b6f09mr98038eaf.42.1782747077395;
        Mon, 29 Jun 2026 08:31:17 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e6213b95esm9184285a.5.2026.06.29.08.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 08:31:16 -0700 (PDT)
Date: Mon, 29 Jun 2026 11:31:11 -0400
From: Gregory Price <gourry@gourry.net>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Russell King <linux@armlinux.org.uk>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Simon Schuster <schuster.simon@siemens-energy.com>,
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Christian Koenig <christian.koenig@amd.com>,
	Huang Rui <ray.huang@amd.com>, Ankit Agrawal <ankita@nvidia.com>,
	Alex Williamson <alex@shazbot.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Dan Williams <djbw@kernel.org>, Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	"Liam R . Howlett" <liam@infradead.org>,
	Matthew Wilcox <willy@infradead.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>, SeongJae Park <sj@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>, Hugh Dickins <hughd@google.com>,
	Mike Rapoport <rppt@kernel.org>, Kees Cook <kees@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org,
	linux-sgx@vger.kernel.org, etnaviv@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org, linux-tegra@vger.kernel.org,
	kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-mm@kvack.org, iommu@lists.linux.dev,
	linux-perf-users@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
	damon@lists.linux.dev, Pedro Falcato <pfalcato@suse.de>,
	Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>,
	Jann Horn <jannh@google.com>
Subject: Re: [PATCH 02/30] mm: add kdoc comments for vma_start/last_pgoff()
Message-ID: <akKPvwYs-4TwYwKO@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <8c618dfd7de419e3b797b8bd1cd921d4c5b8878b.1782735110.git.ljs@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c618dfd7de419e3b797b8bd1cd921d4c5b8878b.1782735110.git.ljs@kernel.org>

On Mon, Jun 29, 2026 at 01:23:13PM +0100, Lorenzo Stoakes wrote:
> Describe what vma_start_pgoff() and vma_last_pgoff() actually provide in
> detail.
> 
> This is in order that we can differentiate this between functions that will
> be added in a subsequent patch which provide a different page offset.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Reviewed-by: Gregory Price <gourry@gourry.net>

