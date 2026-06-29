Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E83843E9C3
	for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 16:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782748870; cv=none; b=X64PwdgMZ9O/DL4XjUeDwpkwQmicWTSsE2OaKSsZYgO5iGK5xeUd+eIIte0ol9p3lTKvLJopcp1PFKaXVmP+QpKtyJ/G1yMrku0GGW6fa5yCn7tzZpyX+RJl8Bz2CxJetCVbnbQWSX0nalRGfBSbtV5YL20iQfbpKP7m46pPAMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782748870; c=relaxed/simple;
	bh=z4dmX8dXcX6a8GqR+YBU+JEoYI0/LpvWh746yKHnt/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NU+Qqty2jbO041WCOU9soXuii6bojkhUgx5rUArxz0GUQPOc7yHCAqM289ifeOTHEsimSTeoRjqSgrxO+Jvzi+czLx6tjvM9dpT895wgWC+tuseSdP9kjBN/w5kzJhhmJbY7MIfD90+Bks41BwlE4VHPV2VKSvW07/wJIRSy8Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Ie1cm6V9; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Ie1cm6V9"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-664d7863920so1141063d50.0
        for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 09:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1782748868; x=1783353668; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4iCXvcvVpnsYDr5kbvWXbUhbyvnE3mHOMHboZJmxShw=;
        b=Ie1cm6V9kh//i8i/M5/thLew53lRrmLlqwW2MjLivpulJ6p5cFT8mBRkf+iMpjMUfb
         54So9HZqyEfzgHPKvAU01XyXhB61mJ/qOBWdci99/9s1qTq+ENG7yeUqJ0GYMnDWw0Yu
         b+gQm+SDU899nBGK118x6P0wiH4XzKRI2EHWN1L38A1wBLrDxJvhxb3QX6OgTgCXgsfL
         nTow8e91NcEcWnnRh+ifzTpV2ch8wFA+9S4ZV1hs+1gA4aKqnERLIfzQSHubSeDyStDa
         335vBkEBkXvkLccXYumhPcSkovU3Qx/kBi5b+mZTQxcOJB36r/oa1jiXpcsGFgF7c2JQ
         SDtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782748868; x=1783353668;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4iCXvcvVpnsYDr5kbvWXbUhbyvnE3mHOMHboZJmxShw=;
        b=J7C01aVYA4xJMXBDQvSDuO3GFECQ6Gh5Ht0AoPlUTjzlYJKpa55QmyN5puRTbM2BDB
         gG9P7Ow5r6XNQvrB9FUnHNsr7nm38LUZpu7d4RkybYOcYrX9WLFW6V1KHkp5rEUvDUzy
         DdtdZbquLEbLBq2VmFVQRh6cqraraL2F/4RUf8uxkDsLqj/DTvlCKiSs7Ly39On/be1O
         ED2Ml1reOxt13kQ3Bxh1GOG+UB/88xouTyixwKNHTFo9EZOi0Z0kucYHbbNm2D80xxvD
         EgK0rG/LGMh4mkXSX7c2GZvUoo5xOb7CNnP8R3z+3Yw67unw/QyaNUpA1rxN/1kV797Q
         MSpw==
X-Forwarded-Encrypted: i=1; AHgh+RrZ0+KuYlaY5n9k4anOwEDCosw07+tBMjC5Eu6eC/LYZ0KqaInoSb/P1ubYhI7g4b0hMNxajw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzUwARGjvGYPLdwGJsKyM7oDY5ZPTmeHloRG6nsA4MmOFPh3aG2
	5IYIGvCx7tv6B6ZgHdkHcw11Mchdvab/JAocLBqGx3ab+Ok3uZ81ddSd9TZ4aIGcmGU=
X-Gm-Gg: AfdE7cmA8aVxDW07Qu4ulblSqHt7FMHAFL7k63dvKEd5n9eEZhEs88VB9J9S9MA2h8z
	2a9+H3R84ex56JuR+EKuf3LlE8+f1kFtlsvkAyid4WNvItaS35LYZ1fs+FhGRPhr5RG13rmlYj8
	MREJN8E8jPTGyMPqT4LshaVNmD6TbGvGc+sCuNsEFHeXHvUmNMUZT7UQN9ifBjI/qOljkWMABDl
	Uk819feZYPploXcDncDWRqvo35D30GiW/inpgiNAqBXGsk8UzA9B2sSxzyhiFJsbqyHuBlZ3zjH
	H+fYcUVZ3/eRJRzRx1291M/8Scn/bUD9lN+0QuEJ2RQSkfeKN8Qq5USsCKL7exuAp7kvqy1ZI8V
	cBa2Y7fn/c9fU19VgdUOdtFP8pWQXBqCjbG+6Lt7UnqeFFpHsRQnNboNV7z1hAi7Ak2dS7fkU4X
	p0IckiZcV/WnPC5NwScu1rwW4wAcqf8eK37EHcxpuK8+ocI/mEXUfXGr+PS0iaJLE7uuirWA9Ki
	lZMR4w=
X-Received: by 2002:a05:690e:d8c:b0:664:e66e:f965 with SMTP id 956f58d0204a3-664f974638cmr245066d50.7.1782748868214;
        Mon, 29 Jun 2026 09:01:08 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f1a717edc7sm1112836d6.36.2026.06.29.09.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 09:01:07 -0700 (PDT)
Date: Mon, 29 Jun 2026 12:01:02 -0400
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
Subject: Re: [PATCH 05/30] mm/rmap: update mm/interval_tree.c comments
Message-ID: <akKWvnU2Ua-8ceSb@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <80d482a927b2e9862487b812e0ab48ebc1289a70.1782735110.git.ljs@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80d482a927b2e9862487b812e0ab48ebc1289a70.1782735110.git.ljs@kernel.org>

On Mon, Jun 29, 2026 at 01:23:16PM +0100, Lorenzo Stoakes wrote:
> Update the file comment to clarify that both file-backed and anonymous
> interval trees are provided, referencing the relevant data types for
> clarity.
>

Isn't this self-evident by nature of the function definitions?
(one takes a vm_area_struct, the other takes an anon_vma_chain)

> -	VM_BUG_ON_VMA(vma_start_pgoff(node) != vma_start_pgoff(prev), node);
> +	VM_WARN_ON_ONCE_VMA(vma_start_pgoff(node) != vma_start_pgoff(prev), node);
>  

For my own edification - I know not to add new BUG(), should I be
converting BUG->WARN/something when i find them in areas i happen to be
working in?

~Gregory
