Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCC442846D
	for <iommu@lists.linux.dev>; Thu,  9 Jul 2026 15:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783612249; cv=none; b=LMhAIaxfDht+ENUOdOohWqil0moXkPS7/oB5y3M0wVcFCJeb2H1LvKBehh3UYJmq8jH5UfyXOl011e9gybhkNQ4rSUB/FxODG3OS1eyD40t7bgu6ofFF+o1BswU4qCZod4ilawVeYg3bFH/C5r5cIw2RgzIKZUgvz/0JYT8K1Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783612249; c=relaxed/simple;
	bh=ooFqL0kdzm3Mqvprf/ktKH8mQbzOh+NePJH/rGI4MOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TuPqacRz8n2bmt4Q9zuqTIZjP8+WJEkE0O31ZAKtRlsiOzNmjtvHw5oYeyJdlu+ysBakeMYkuOh5FIYm6rckk43w/drtD4e6p0lWj3rdtExG6YDoERI9OZsmbOutAeaeGlnB3WJ2u7ip7AF4SnuZoMppf/4JCj4XePoVakB2a3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=L/5sxBSZ; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="L/5sxBSZ"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-51c0c45c580so15065451cf.0
        for <iommu@lists.linux.dev>; Thu, 09 Jul 2026 08:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783612247; x=1784217047; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4H58DRU6wxIzBQ0PfS3OOFxFy6X9tDniNwjExlFI+ak=;
        b=L/5sxBSZ0ntzw1PPGdgtogqcUemzKFMUdkbeYGjGQG/pk8vhYEI57K+y9mXPavZxCG
         8cWIKiq8fX86SUuuhCS3XG0duNHMa5yXhjctG8X1nJLDxgiXIMgYGrXPi3H8s9ELQH/F
         F7VeoiMdJCzD1Kzk+yGUhdqgvizPF8FBBwXzmwe4uAZeyHmLs+keZYDCYoVzptEFdB8j
         Sb0hYUR4FWLcbJ5bM3zstPWb2gomBwTE9J9OLhYu9JzlYjJtzwvBi0HF4YynMxux4gQk
         5mRL2cgmsnrRiC4LWld0rYNf73fxWkB9SxLqGCvOn+PLve01pDrxsaCrLS69bReO9wdC
         4spw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783612247; x=1784217047;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4H58DRU6wxIzBQ0PfS3OOFxFy6X9tDniNwjExlFI+ak=;
        b=QyY8cEwgddpc7tkXowhKXSexcF34qsF2dpjO0pxrahWBjMJrkIYOZ2/QAeKKRNk/xj
         sPsIoMJnEIQ3e5tzrigaBTy8ljlIrej9xetQRGO3t0J0sd+2ykdXSx06vujFNXkzjeJs
         wDpsVdkNhzTUAIZMUsuiMPvhL91NKKs/MWXP0MSEgO96abXO8idwd2M2iv3MHCj0yyMo
         +7RAOz1ZQH1migyxUCBvb4l379EUJhLQ/fuqL7SzdCPaBVp8A9H9pMoelutCPIddqwsb
         R0rCNALteBrLZuRlaboVR3xsL4l0eIDTHqbR26RtQMN2h6Qh5CgpleSba8NPQ89nTUJ7
         l3EA==
X-Forwarded-Encrypted: i=1; AHgh+RpUf97epdjQhxbrd32Xlux6bk+u64HTXKsDT0/Iwkz84K35NOLwNvKiCXUlSU7cmYeSTW0DDA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxrqtZDEB8Gugq2DTnvTgU0LH6FYAv2+YbP6JOZRlQvYBFqLddv
	lLgM8fMj5xbdslBNhQxLtSYNAbP4oCNKViLOxeGRwRLatrmHcRu9cazuA3NgSgTWcpM=
X-Gm-Gg: AfdE7cnpqrCXIv7/SkG7G33ceFCoA7D8P5mnBXVq4JfFgKVBvdDIYwcyk8KYr+JDHQy
	bCCytUwheS3MWRw1OS7GyD+u0INw2ESL1SgBZKDpFad1JN4JhlcuQ4F+hLzvW8Be6KlfDcwmrOR
	tIYjIoozKSYiSXksSktH6peyAlwhHjf3PW5xug/JwHG9B9KaADxA03ysmfIiZQ7wQ628VgDC9+e
	TbLNnsArKtOwCVvr6IGloqpxIu+7PL6n0xw7meBZ8/O8XAhkInphNpT2Kp/5qg0EZ8ogSpimSaA
	Jk3PGQzDgzzxjzeeGsZvP/5LEPSxDycyeCjCY8Ux1oqfdCk1f1sKgvESa7GMbMT5Kc412oi/yM3
	maYt43xIpOrdmdR4F842V8YxWQk/dbWtJAjSxJ+NBB5/nJwF04+p3VZCbrgD3x1P72BBWyp9IIZ
	XOl0bDzlEI7kuvUQDc1UhRg27LOYNTvKr7mphVCfWtGySKvPxQbWB+7HNweyLjwgoPgS43
X-Received: by 2002:ac8:5f0a:0:b0:51a:8c9c:7f52 with SMTP id d75a77b69052e-51c8b40a675mr79940341cf.69.1783612246884;
        Thu, 09 Jul 2026 08:50:46 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c4202366csm161049781cf.30.2026.07.09.08.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 08:50:45 -0700 (PDT)
Date: Thu, 9 Jul 2026 11:50:40 -0400
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
Subject: Re: [PATCH 18/30] mm/vma: remove duplicative vma_pgoff_offset()
 helper
Message-ID: <ak_DUDt-1tb-V3b2@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <10671c2fc5d0dd4e3bf497181923e63e46053df1.1782735110.git.ljs@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10671c2fc5d0dd4e3bf497181923e63e46053df1.1782735110.git.ljs@kernel.org>

On Mon, Jun 29, 2026 at 01:23:29PM +0100, Lorenzo Stoakes wrote:
> This is doing what linear_page_index() does, so eliminate it and replace it
> with linear_page_index().
> 
> Update the VMA userland tests to reflect this change.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Reviewed-by: Gregory Price <gourry@gourry.net>

