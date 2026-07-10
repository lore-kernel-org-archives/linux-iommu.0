Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314143806D7
	for <iommu@lists.linux.dev>; Fri, 10 Jul 2026 19:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783711568; cv=none; b=q3tQ9mskAailbeX8YLP/eqBkO/LN3nYb6nuA/1GwrxI8OuGJv8x8lIImPprZCMoKvC8+1R/wqrk/K++AD0khQCDte07iTmq6QN47tYl6Enk29HR9MwLPPelXvHZpO2ryOYMj7TbTVh5h52RK+KRZ443Um/l2/jEptw+AyMmeK+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783711568; c=relaxed/simple;
	bh=QOojT1E2vhWM7tSRUHih+fCOI5zTfyzCTjJ63JRhM4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jxzdmgpe5UTxqVjGZdv2VUQZ67uLkIlqa2gBQKPw3wIwCp2rlT0gJKfgdi7+8gK//tcf7mb0GkeGXX3R0WKgZLZtIQKMjwEdMPchPmDV5q9JJ4YWzkSR/JvsBmxHpaws5nJHfvTyMJOL0FtYhFQ2RngAwPm9Vn1gEXHQ1XQLsbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=t5Rdmx2V; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="t5Rdmx2V"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-920f33347f5so69158085a.3
        for <iommu@lists.linux.dev>; Fri, 10 Jul 2026 12:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783711565; x=1784316365; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aHwFumUUjp1dZn3azv3jRxV2z4/4b2Y11BxxEMyANyA=;
        b=t5Rdmx2VbxobuutWDOQ0jbPrbugbeu+ltfEbBj9iQo1cDpDsabycrEgxeKau71AfE0
         S+XlLC3pM8HgEo+NF9vBX4JS77wu6GKI8vxKXkL65xoeipj+UvJnZmjGHQnhm1m84oO0
         Sm+2GVCjJBJdWBVnY0OXPLBCjb228E7op0FlHi3mOYmb3o6kgSVP+y0SU6hTE0t1GIUY
         lvUnR3sG9vY3kbSXZOFE38QZelI+l2s0AWHoRwJV6DtkiHRJFBGFS+hHdA63ZV0Fk8C4
         FS+BxoHgVU9KOfSZwOzsihcsdIsbSeqbreE+AiEa9c3ogLdiN3Os69VShKR7IYz54ZWW
         OygA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783711565; x=1784316365;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aHwFumUUjp1dZn3azv3jRxV2z4/4b2Y11BxxEMyANyA=;
        b=n3BYOenHVWOWBTYjfQbSgnUp89yS9vwmJ3Cvc9/Wu//IxP6e9EP7U50KEjvwp3Pbhe
         cp4ldnnhEYCOEjOQGtBV8QRR8PuVQ+KYRdo6oB7XVFvp4Gkcsx5TfJ+1kUOr4AijOETp
         BKwnmsczslz2Z3nubz2BxqgBxYiqjUdE4E4gub9f1jzs6PKQaCXHVyiEtvY+eiLYkRmT
         YfzhF85azeHQ44hswcBn1Pf/qqVh2pLpmR3Uv3JxLCjbxGh5H/qtKnIFriewCT9lV1Lc
         jzpKl7Scxxk0CiE4+vrUKHY2659CxehoHvNuurXuwQNbA2UAw2zoExvI/5pCLUfR7ZMs
         vOuw==
X-Forwarded-Encrypted: i=1; AHgh+Rrx/020vCMFFRi47YjoiooXS0lfI/beYpubjNamW3/CFCicPaAticyerL+bPf5jc+oVMHPEbA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyqNo1NP+ywP/SICkhQDVmwqZDwWBgOLmlI2f9KMcjC4c7BghQ3
	Wt2KGKvjO3cowsAoJupvn8H/N4ZcqSJNQUluXPLti9P9ri9c6u3sdFlTwMw6xW+KLQI=
X-Gm-Gg: AfdE7cmB4D8dJTFAHmOP5w65JcpB7rk+pzsv9WglD8lmzb9/MdBr8Rukr2z4H3l7oTh
	DySPF2prsi9cYJGi9/4E6Rz/QW+vOGn2xy8YamkTFXHuONM0i4CE5EHqELFZM5c5FlGYtTbidNI
	pkpIBPfZz4VefBKv07T6Yb1UB0ceEGDW42a6yhoDcBBYf+KKjmwAmcc3eDowupGDlDqlXHoz3sB
	wYUHKpJk1HgIvEg71+1vhQqrXBOMtlJWfl9qhUppD1e4Xolbk/X3a3Nn0MAUTRHQc8GxRqZ1P1Z
	64FNrk2tYdfsUY0DNppTo2l6oeeluBpSNIuuakCg68RWymR/jiwL8a55rPrdZGu0KRAr5mCrIex
	WqjCexLzizlpyWpg6/Ucaj9AgNm0E4R9gPugwo9a/aPM7+n9dTT1wTNyhUIXOFxBj+MY2iTkMEI
	O1Es0uY7kV3H0z3txiXr+6znnFTLFys22LHHqQY2ATzCEZVLflxdGEIC+n8l3RWPyGUkwSfrmNP
	BzcOuA=
X-Received: by 2002:a05:620a:2993:b0:915:8502:f7f6 with SMTP id af79cd13be357-92ef2b575e8mr66564685a.35.1783711565033;
        Fri, 10 Jul 2026 12:26:05 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5d37540sm265182485a.38.2026.07.10.12.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 12:26:04 -0700 (PDT)
Date: Fri, 10 Jul 2026 15:25:59 -0400
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
Subject: Re: [PATCH 27/30] mm/vma: correct incorrect vma.h inclusion
Message-ID: <alFHR3fg8K1-SITK@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <22d0f4e3fe11f6fd1312734e242d008267ad142c.1782735110.git.ljs@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22d0f4e3fe11f6fd1312734e242d008267ad142c.1782735110.git.ljs@kernel.org>

On Mon, Jun 29, 2026 at 01:23:38PM +0100, Lorenzo Stoakes wrote:
> The only files which should be including vma.h are the implementation files
> for the core VMA logic - vma.c, vma_init.c, and vma_exec.c.
> 
> This is in order to allow for userland testing of core VMA logic. In this
> cases, vma_internal.h and vma.h are included, providing both the
> dependencies upon which the core VMA logic requires and its declarations.
> 
> Userland testable VMA logic is achieved by having separate vma_internal.h
> implementations for userland and kernel.
> 
> Callers other than the core VMA implementation should include internal.h
> instead. This header does not need to include vma_internal.h as it only
> contains the vma.h declarations, for which the includes already present
> suffice.
> 
> Update code to reflect this, update comments to reflect the fact there are
> 3 VMA implementation files and document things more clearly.
> 
> While we're here, slightly improve the language of the comment describing
> vma_exec.c.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Reviewed-by: Gregory Price <gourry@gourry.net>

> +/*
> + * To allow for userland testing we place internal dependencies in
> + * vma_internal.h and external VMA API declarations in vma.h.
> + */
...
> +/*
> + * To allow for userland testing we place internal dependencies in
> + * vma_internal.h and external VMA API declarations in vma.h.
> + */
...
> +/*
> + * To allow for userland testing we place internal dependencies in
> + * vma_internal.h and external VMA API declarations in vma.h.
> + */

Do you actually need 3 copies of this comment or just one copy in
vma_internal.h?
