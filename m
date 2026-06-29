Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3101540B6E3
	for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 15:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782748497; cv=none; b=IzdlFcgiGFOjhgDZFSMOAjAf4Y66t70ehvySPgWuasArR5IkgSceqdYIkbDVCshX3mvz+Ai//LfyHe+W4X1oO/kMCvWddnFDnIXWXnjMkVEYyjoYbf+DSIucYFrJ/4W4XtRs2Ca0XU3fRQLKw6tx04reIdU9RebbX0TZkyURpJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782748497; c=relaxed/simple;
	bh=vSc4ORRRpUbp5nwMJk1U6F/78ha49jf3UdrgblxYv9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AnZLBzyJSbfRRzZUUSQ7rKhWsSWlYq2U8Dj5IY7mE/hLG0Ch2YAsxtDeOW0HEOY0KgDzr80kNbF4oO8sTP8d3nT1fbXvfQIay4FJve++RwbYnuxLhydzV968fVoVCJVN6UO0SpvyToijyWYH2xP6Bwx/ZxOwVAJNaGaQiaJ54sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=iIQgt3cf; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="iIQgt3cf"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8eabb1a9378so20742216d6.1
        for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 08:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1782748493; x=1783353293; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4r3nyg8MsZ+G0ckW9OOGJtlL6QAvCNLsDtm+wiwuKtE=;
        b=iIQgt3cfcOAwo1mrTmq2ufd7KBn7KaZZcIcwoYn3k/1jUjMHWhQGvQ4DQ3gdJVdNiv
         KWzQBVBW/ZL7XV/e2KjuKu2Zpg9i6fyTNG4Kv3m/G5jB6Znl9LTwS+ixCMc7GI2VBhik
         cO5j2exnCvxvPGgEQxFxF1HIPpi2nKZNOe8P+6lOhGTTR0wXZki9pQ0+HrKGWSnUMtxo
         cNIaiBPACH2+lUM7D/d/z7iry8ibk/Wp0if6q+Fr5Z92SVu//XAclq6DiXEO5yV1ilgi
         KBXBsaWOwQN6PO8T+2OHN362TYHjzMTXXgndYOp6HbtgRmOKbE/H2dcqzwzyuaMBJOVr
         d1ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782748493; x=1783353293;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4r3nyg8MsZ+G0ckW9OOGJtlL6QAvCNLsDtm+wiwuKtE=;
        b=h6DpfAjeCnRRN7uNOGPMLCcw8FB63FQ7wvl/lsDXbg2b8D4fWtW1fLKtpF49dVfspd
         zzHjAKeW0/wk9c1WglIiFVWLvjGQcQQO1/gBKqMeh2dPKZo1YFBH5DfHaHZVguqImyNh
         OR9SnAYBSDs6kvRyvbqiIfBYoiYYJkM4nGsfyT0yC9OJEt7xirteHPcqkduoX++u0/6e
         NLTNoEfWqtnvt18HhaLaNA/Bmoo1jCpRZ4I+iepDfIzJKfZw1vabCABT2XG3EV+B0kc9
         IwwKFcVutgcG+bQUg+pxS6DkPSaTR44d6w48ThjYuK4c6NK6Wpgm9gpvARgqureLmB33
         lNDQ==
X-Forwarded-Encrypted: i=1; AHgh+RqwOcCdTT+DiJKoZczVikNTHt9ND3+cVVNV/GOAv5xs26LVAzNE2tjtpiddwvlF7pjY2XEbSQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwF6FNXkUcmx4RHz+PAuAUCw3fUL9aq0DZyPYWGYOS5Ny/ft/au
	Yv/TlXhUN4n+x3qYfFZRe70rbmK+gkGDO/rgJwks0jp3Cmhf0YqRiGL4tLz724eeBWc=
X-Gm-Gg: AfdE7cnsodL9Nld8WTOU7oRGojeN80gnrw9hq6IZ32EEuH6xJFvT/cNb8jzTurE91vR
	kHgt9QKjroZpqi55H8SHjWmrkluwQvKemyIOKryYW5OrWG5htRh+9Lgv+OhDuxBzDG6rQ259NZL
	DjfykyNu4FfsOCjUr9DmaH7seiURA2a+cFvvIpl+npZ3oz5cM+UDVUird1vcnMiBtzFeLjTz8J/
	st1NiZVpk0ltHz0y65jxZw8ggqqL2Drou5IkmCmLnnXGIM0P5+xlL16IhDATzymtY+WnsMWpKXH
	l962M4KrXwWrHZOWNiNPUWjDrewnmqOQlcPU1qgj5XmHVVd09kgsubyzzbplO7NNdYgCGuHl90t
	sCr2+TzMer57nbFHDI6rrrgFcXLL05FpCXHqBHzSwkm858I1Xb4atalFOcYc7mYNWUkXsOJnW2z
	0yDGs39A0reQgucF+0K796tHqyBD1poCs2+fUDqPaacQdhPtcZ0H8nu8cNM/2QWYQgr1mtuK+2Y
	DHOi5s=
X-Received: by 2002:a05:6214:c65:b0:8f0:5b55:1f6c with SMTP id 6a1803df08f44-8f05b552223mr58558406d6.43.1782748492988;
        Mon, 29 Jun 2026 08:54:52 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f1a26f1b34sm1726396d6.3.2026.06.29.08.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 08:54:52 -0700 (PDT)
Date: Mon, 29 Jun 2026 11:54:47 -0400
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
Subject: Re: [PATCH 04/30] mm: introduce and use vma_end_pgoff()
Message-ID: <akKVR2wNSjbLDt1-@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <e379a1cb6a897126ad96e3a263fdb91d6c11f6cb.1782735110.git.ljs@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e379a1cb6a897126ad96e3a263fdb91d6c11f6cb.1782735110.git.ljs@kernel.org>

On Mon, Jun 29, 2026 at 01:23:15PM +0100, Lorenzo Stoakes wrote:
> We already have vma_last_pgoff() which retrieves the last page offset
> within a VMA.
> 
> However, code often wishes to span a page offset range, which requires the
> exclusive end of this range.
> 
> So provide this in vma_end_pgoff() and update vma_last_pgoff() to use this
> function.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Reviewed-by: Gregory Price <gourry@gourry.net>

