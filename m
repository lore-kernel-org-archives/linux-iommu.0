Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537C23672BF
	for <iommu@lists.linux.dev>; Thu,  9 Jul 2026 15:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783610577; cv=none; b=N0vfMq7bWzuDWEWtiIDjFluI5he98roQ1Jb76biqz46Q9iO02tBOIQrrgNXR9y1PIyOH3LdicpdD6/CQVMnH4CNliCeGrF04cAS8/LGT4xR+iZvZfSSI6SvuEpYcGzQii2yFChtoddBf81+1E0IydDMGO4qyvXhYV0xI8/S/uy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783610577; c=relaxed/simple;
	bh=WZm0pCIlMCZnYkWqHCv0Ceyplb5Du4QgkvAdE7k9ZdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WnBAlqI1vShhb10f4sYkBqxNDGujMTWcFKVtL6twgCy/JAKoJgnn3vTIuFtEtu41qqTu9ojMggksCh7+vSPWcj7ndTnAKrKRMspFT2Hdpmz3YYSM4c3o+WWICxthsj26QIyVY8QTz+EIru3V/rP0CNzCYDljk600afSV41ude+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=oYxht2HI; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="oYxht2HI"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8ee88fce572so200676d6.1
        for <iommu@lists.linux.dev>; Thu, 09 Jul 2026 08:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783610574; x=1784215374; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8MCYdDNt+ln4FYDiI3hqZQpolLcmikZ66uE9gEYE70E=;
        b=oYxht2HICKu4TpvcAFuVPgHA68VHrPB7RnGrN3uTOtUDeraXIA6tYZENdWauT4IuWi
         CjLG62HmXTbfhWA9VU41kD/fL6KJ4kXYCjoNOOVAqs8Xrf4PVuQ1MGqQ+0hNjTgmXvxV
         jpvNiELF1Q76+By2wuW9052sBadINXJPojKqlKjVd7uzb1cSrEnz8Cz00m48NzSif7Dr
         s2/6lKjm9u9tWgDZQbtxaVPH2c65kd0LpStALAIOJbfntQ7Qh5O7GNUVJfs33fXKP/uP
         /wV7I8zBiIQQ6QCTUl+WX9UCGyLBGU0irIyGvlZXYycxJ7jdwZThCBFFrZb0YneiRWbW
         a9+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783610574; x=1784215374;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8MCYdDNt+ln4FYDiI3hqZQpolLcmikZ66uE9gEYE70E=;
        b=WN1lIsXfX892XNCWTfQRM0C57hbUP6b5d9dbeFH+sI4NptNec0yOd2CmaE5/JDuGkL
         mo/gXnWYJ/9LvVUFxlF4T5NybCpFBy/dTqnur5MWC1X+uEpQXEo8TPH41kfse070llmO
         WjfyDYB1cV/xGuQB1r2R4kTTLqoxoY2UY1eXTLPVjQYXmig0t+/sfFGl6u1c/fSoevfk
         rGt8nXKBoZdGjxXPpJFbYRCoHtNjAa0UpkRWAvCAeNQTaSFIindLkNTPsgJX97zOdoF7
         0Rdp6hi5owXRAg845BoKY9U9kQFSWUoEqPhaVHZv+KDv2NqBzEgvQ+5SWf7a8mXutuA6
         mcNg==
X-Forwarded-Encrypted: i=1; AHgh+RoWjzYVpcLKi7yMinf/bANkqEApSS2AQ9Ng7MhBX5vOnOpTVhP/iIxNc98v67F6lecoKwMb3w==@lists.linux.dev
X-Gm-Message-State: AOJu0YxtBHBXCjYkeXeIrXV9gT+UcdMTfCiR/YkmY+bU68E2BEfJS3vJ
	WM2ou082BFaxRrUn2gp/MEVpR9xTb6WilVEaQptK25Y408xgea6DkIYW4vDBVrnhuEw=
X-Gm-Gg: AfdE7clgdGzJc3AD4YSXQdxmweqq9K+VptTpYoKs/wWYYh6t3du0qObeQa5CAS3tmVp
	vembMritC80RcYjYzg8ACMGCp4SspmCQVlFVggTNG1rYHq38nHRVMmCwt1e7TZt0fewLloEmeU1
	z+TDnZoLzx3ZTEdb8CAugilQya2PY2hNKQF/EaS9Lj46rkE1todJNylhnv7IPsfuGlTUkFio8qA
	hJkC3ywiw/rPBaVhyE9JXb1+G0tO+xIMjenSbAAqPhwuNC9z3ILRnCugYe39OOeCBP0wFq4qsCl
	zhA5chn+gNpI/PWCmRKjiW4kBHBzuMlT7Fx/9HWa+40YGOAYPDv5ANYD4sLqPKWZUhMGI+3lnO0
	ynAetIWi/U7VmpIe6vBooWyhW+JOezjeKsMz56WiOEFDGY5vcjfWYGcXJWhu/0YvYxacQjaGvf8
	9Rb1cL9+RUHWBmLREIlPyA/Mf0zMD/jMqDtOaOzgRiXtegP6XBOtXyX9oookwCfxbCSAXg
X-Received: by 2002:a05:620a:28cf:b0:92e:68be:1c5 with SMTP id af79cd13be357-92ecf6165e4mr847751685a.21.1783610574232;
        Thu, 09 Jul 2026 08:22:54 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90b7fc3asm1638936985a.9.2026.07.09.08.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 08:22:52 -0700 (PDT)
Date: Thu, 9 Jul 2026 11:22:47 -0400
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
Subject: Re: [PATCH 15/30] mm: introduce and use linear_page_delta()
Message-ID: <ak-8x3TWsuhGzKlJ@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <eedf589778aaab33e6df2ad6556dcde536e13460.1782735110.git.ljs@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eedf589778aaab33e6df2ad6556dcde536e13460.1782735110.git.ljs@kernel.org>

On Mon, Jun 29, 2026 at 01:23:26PM +0100, Lorenzo Stoakes wrote:
> It's often useful to obtain the number of pages a given address lies at
> within a VMA.
> 
> Add linear_page_delta() to determine this and update linear_page_index() to
> make use of it.
> 
> Add comments to describe both linear_page_delta() and linear_page_index().
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Reviewed-by: Gregory Price <gourry@gourry.net>

