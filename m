Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F236385D98
	for <iommu@lists.linux.dev>; Fri, 10 Jul 2026 19:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783710789; cv=none; b=WKeBKNDMy6JmBSxyZNXl6N2EV+zH7YesfXpe/iNdV46yu7bGwIHXDS5LZi3g6+sGwnpoaVNUPYK9aUr0gwbAIZX8pAyNHBa53NW2Pwheq/oBYrZGN0jTxFyOj7NZ9+hCMVmROGftoF9iSKXTLNBMtA2pYYRCckx+MNj+xwcBdnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783710789; c=relaxed/simple;
	bh=mbUpbN9JA5TocILiu7DT262VDuT+uIcfX8rdIywuDIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vE0sdlAFszq9ZEzKTDvgeuDq+lfbvlz1PU1XDMeZnjLkgXMzSW2CfYIrfq4tGNJkUuZjeY8Igsmi2cw/HvQ9w1nJEuVmpvBwc5WsiWGUNerwor9Z6smT3U8iFe72mmM0TWTxdX9BukV2hdA5BPFbP17JUUyVC0x0cVtHC5csuXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=emp+E+xu; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="emp+E+xu"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8f0d6853360so10618116d6.0
        for <iommu@lists.linux.dev>; Fri, 10 Jul 2026 12:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783710788; x=1784315588; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Zl1BBUQ1SVF8WlDcAjuqmqY9e/JVxV3t5chHRhyKtnA=;
        b=emp+E+xuEF4Pi35rZSj9QybSslmgqmdh7uzh9NdrGQKIqCnhn9LfOMszXEW8BZUsET
         O1in1/OxmZJegmX8Cw6luPUdsb6JupA7Lrtxp2+5DZYaZbCY6XezsM3tzQlHnYo5/x6h
         k+2x489RgBkqgM5bOLvhTU/UfgDM0LBD2+eHHS+BpeQse6k4PQw7YjfT1qb34S9G6kEw
         jM0W5PjVJpr63pgUdkkTVX95kUlqnZWUn+i0RC5iMDo+p2i0NtzsrbPbclEMSqpvsTXb
         kHRVymv10NdwBBrQHZQrNmtqYFqjXGRtuJSejwrLa7s4OVOM63yPOXpeju2ctGe+yRlj
         bGxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783710788; x=1784315588;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Zl1BBUQ1SVF8WlDcAjuqmqY9e/JVxV3t5chHRhyKtnA=;
        b=k3qa9lPwk2J9178YH7BrFm9VQ0Y46RfE+4jo8SG+qKabW14lbRN3f9RwbbH6It7Zpf
         c106p8RD+qMeqKYRg6+YsPxDvy6qkK6Xaq9Np+waAl8N1roo2+h+ijNr5eQ4rRJrtszx
         IyBiA1gZ/7yzeaaaTF0bXzDXynLssk7ogxFg8i+DP2lh3OyJaqGnp6AhxPVJvjfIBUFc
         nbScTp+nvqkmw49vQuanvLCJXEY1Cz2BRTCk0HnUD10wmNZA01Z2EBUJV4xRPBtKUDLy
         vtzwMJKPoLTjvGdR4V+CQYx5vAVS9lRDyS337EGaqV/iF5SZRI0vZdSSKYhMp0fPEMrP
         5UOg==
X-Forwarded-Encrypted: i=1; AHgh+RrNDH+1lWrJ8d6J7jEhQJOiojXm425HSlBvJVE0GzJi7yqK33MGAHG/0Z7g0TqfSutZ6MkWQQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzSH7A4dLxxFLrArKGshlPuCNSxhpD7CSUOu+YnheQF/YT0Kiqj
	DjInnPe8TfpHpmaGCg5tJ/Vg4ZJl1dOW+tyQDlTuHLzQpAFs0zG1FdU1yZfFwSJCqLc=
X-Gm-Gg: AfdE7cmaV7ZQYGkc23MYKcLTwbARopNdOz50OCj104aKfsr43nSePsgQ8LeJlda0cr9
	cZjnTBmrNZxKBkwNVLSMJtP5Ln/HziMpGSH3YpaxuRs1TJ5gF0C8bwYk9v20Qxm2oIQ1LwrYqyP
	/mOgMkltEuJ4RQNdCSJ/zNTekVTVv14kXpcwseCgzn/C3mhdBSPBabOBKMwtkjz2ryilfynGKBJ
	TZ1jDa78xG/qGXVlwhq4/DWzby/O/s3dsFSWBoLJQteOvYBSsmwKPyHmRv864oC1xn/D2DCmlMp
	0B9z3fAprKN+Bk/8nEqp+mxpWZ8BxeMlDC2WbaUqS+P9bdH1co+W+KwSNzFartqhQw8G8pfkPaT
	z4aeYqFWT1z3JcjSC4P3VdGG/X/YvDxyJCK5uh4ZEDTher0sL+2v318mIqyT72ynJMsakyh6V+A
	wk55R6J+8l5DaxTSchAhbnoOGD7YyfQ7BmRDTELPtxQN5wscWr4qfsS0KTMsUb+0u2F3t6
X-Received: by 2002:a05:6214:450c:b0:8f0:9d9c:52c2 with SMTP id 6a1803df08f44-903fe450e5fmr5228126d6.5.1783710782628;
        Fri, 10 Jul 2026 12:13:02 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd87c9128sm47321526d6.45.2026.07.10.12.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 12:13:02 -0700 (PDT)
Date: Fri, 10 Jul 2026 15:12:57 -0400
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
Subject: Re: [PATCH 25/30] mm/vma: update vmg_adjust_set_range() to offset
 pgoff instead
Message-ID: <alFEOTiJw2g--9F1@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <910f7b5be78232304dc7ca01cd57c6f5ca8f3d13.1782735110.git.ljs@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <910f7b5be78232304dc7ca01cd57c6f5ca8f3d13.1782735110.git.ljs@kernel.org>

On Mon, Jun 29, 2026 at 01:23:36PM +0100, Lorenzo Stoakes wrote:
> We are calculating the pgoff as an offset, since we have vma_add_pgoff()
> and vma_sub_pgoff() available, just offset this value directly and use
> __vma_set_range() for vma->vm_[start, end] values.
> 
> We take care to update the range before offsetting the page offset, so the
> adjusted VMA's vm_start and vm_pgoff are mutually consistent at the point
> the page offset helpers operate - this matters once vma_set_pgoff() comes
> to assert invariants which relate the two.
> 

Given the prior code just did it in 3 lines of code with no special
dance, there's a presumption here that this is done in a critical
section and no external actor can see the inconsistent state?

(i.e. range is updated but offset is not)

Just think about this from a bisection/debugging standpoint.

> Doing so lays the foundation for future work which allows for use of
> virtual page offsets for MAP_PRIVATE-file backed mappings.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Reviewed-by: Gregory Price <gourry@gourry.net>
