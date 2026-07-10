Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5F33806AD
	for <iommu@lists.linux.dev>; Fri, 10 Jul 2026 18:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783709851; cv=none; b=Kr7e6FcK60/csejYCfKTFxtmlu9c8OMDd1QZp1aRZKeyqIw5jUout6tfcgUt4JABqolwagrbe07DmIkzI8LqufD7b684xlwsy+CcHFkxnK+lwmPdDKm9JmawTdwWj8XlijJFaMZN6PI2btQsTu6TMdydqt77wp/uf+kIWxaK3nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783709851; c=relaxed/simple;
	bh=mfAQ6U6Pagde6/OTMZV/3pa3xVR9imBJSf9e6QtJA6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BYCRSO0E/mfA+w2ag2LSNhMC6gHlS5NjqupkOaT5PeYLX5MHyqNuz05zJjU/hl7dKqPyK4NIC82yI1WwgjouDH1vgnr3e1w6NPZ5dDU3oabmXb/WE8mTWQag1F7gS8rBry1jBhpeCQ129O6q/zOogAeYKIJAPaGDdAMV5emFB48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=f01Mp37R; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="f01Mp37R"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-92eafc94c9cso66162485a.0
        for <iommu@lists.linux.dev>; Fri, 10 Jul 2026 11:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783709847; x=1784314647; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kUriDsQ9XZtRyYKZZfoXUueFFJuZPgSg6lCZHNic6sM=;
        b=f01Mp37Rvqx+Y5DQaHEiRaHGaE3CXSciZUFtTOLy89uy2S9wF3zm/kJ/11ZiwtJ/Qt
         /V933YFidtQTmYGlyIo0x+hFsGW+uTYvyaIvsY8apT1lv+CIPNi/i65kcqC+PFL11a4R
         bMJRJIpHsXnPZOQy8OFkDYdHGAzErqakPqsdD8amfm0+a0auRH594/3VMKjoah5JgCfk
         eX+3njX0/Gt+GuN0+COYdzLkBohoNFResqTw50DPEnVDWrUl7NIgmhm0MRMePO4x4yNY
         yxbBxjGtDu3CSAvQp/7eqd8QTfleGdV9EQg9by2+lhFCoYCTrVUt69REpm83AL2PP7au
         HG4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783709847; x=1784314647;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kUriDsQ9XZtRyYKZZfoXUueFFJuZPgSg6lCZHNic6sM=;
        b=XVlqcBolGWudo8iUL24gsjda1v+mJlpFG2BvX/sJLKfKqf/g57pae8jDYepGPRawYz
         b2rapeVbhLdhJWvpPYldXTOgAgxC96rfiuWeFp00IYi39RuwvxSpF4E2c47bjA7QJ8uM
         eU8dDfYjpGRWiV9ZUziFqKGxXwTNODVkzYf1Ige0bVOEx2pTI3qqpr1NCM/tc3M03qhg
         INIVCaH1rd670NZEAyNlIE4E4YFhN9URtbviXBnB9uk+nXKUnNzo7jxI9iXevMWVaqkw
         EJe0Oe1u8yClwUYcQarbnFU8JOiHIvBCjLbZnpxVuj4q8NFszJLfnBcdhC8vsIlcvQ9L
         81ow==
X-Forwarded-Encrypted: i=1; AHgh+Rr/QuxKZUsiBBCKR91FqHDIIqGNxLopHAHO/H5HdSF6CczNWEC3vmElbCasZs08X+GleQw2wg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyUbuqNXNMtPNtPvshu6trS0Q2ySDoD+dcCTP51PchuSYKWh4q9
	zkc+2CgC5LIpuj3aMabAHH69BDZyfdCpCngqIs9IRFopSxnLXyX8g9ZZhoCGEL5MBsc=
X-Gm-Gg: AfdE7cl8C9p/oYE3lTh+jp/xWScVSRdIyvIkh34IMajgTtCTfHSRFYdhmNCF8ke3/Vv
	l5Gdyiacwco9rSiDmLikiBXdzAFF4L2b9fe0uxOu6OfdahEm/6vZmLYzdMq5wuTowIFY+Q43kai
	g7SsTgZ7xwxb+4o1BRU1exTdaSvQkxAjWH32eR7t26rpjK2cY8nslW2AOsc2JgK9mjGP55CXfAw
	01ty9CcyHqplpmH6S8QuJGMxkdORZD0AWHyLRX4nAaiKwCuWShWSxuX6B3rQ+vqX3gbP2S0hjw9
	i5ftp6j5cmWk10wBEwnm7S3Sa/O84ZGZ9rC+4W2XHE06GhrT5kILIgr2AznUPOaCRZitgQZE2j8
	TICTvI/cT5lRClA+qk3vKni5mafGBPseLYQR5RATayzqUaZu3zQGWMdnjfMGd3uXAeRAGhxKEHk
	CdPD7nj+H6EmSB3/RBwIHzK6Csw35Gnu56rsI3ZM75/UuZoo2o9zjOIUFKWlbdeXJULkUA
X-Received: by 2002:a05:620a:d8e:b0:92e:9d63:a6f2 with SMTP id af79cd13be357-92ef2c1ab7bmr45629785a.70.1783709846741;
        Fri, 10 Jul 2026 11:57:26 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5cfdf6fsm275995385a.24.2026.07.10.11.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 11:57:26 -0700 (PDT)
Date: Fri, 10 Jul 2026 14:57:21 -0400
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
Subject: Re: [PATCH 23/30] mm/vma: make vma_set_range() static, drop
 insert_vm_struct() decl
Message-ID: <alFAkWCnkYv--Us0@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <62efd70f9f39570724c9552cc7f2aeb5c322b2ff.1782735110.git.ljs@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62efd70f9f39570724c9552cc7f2aeb5c322b2ff.1782735110.git.ljs@kernel.org>

On Mon, Jun 29, 2026 at 01:23:34PM +0100, Lorenzo Stoakes wrote:
> With __install_special_mapping() moved to vma.c, vma_set_range() can be
> made into a static function there and is now completely isolated from the
> rest of mm.
> 
> While we're here, we can also remove the insert_vm_struct() declaration
> from mm.h - the function is implemented in vma.c and already declared in
> vma.h, and has no users outside of mm.
> 
> Also update the VMA userland tests to reflect this change.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>
> ---
>  5 files changed, 8 insertions(+), 24 deletions(-)

Net negative lines of code, the best kind of commit

Reviewed-by: Gregory Price <gourry@gourry.net>
