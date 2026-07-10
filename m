Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C96637AA8A
	for <iommu@lists.linux.dev>; Fri, 10 Jul 2026 18:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783709754; cv=none; b=gkLIyiQGUoLICdTVKUWVk1DnlLQO0lARqEJHAPO2f5oufYu2P845wDz+AGyJF17E57xCuF1lkt/lonH7JpKFcs1kOnsZWK76b4vU3sC17axUbqrTxvYV/HVm/Nt9IpNZWrN+BJ/tl5TXCpjpB/Aj/OX1PTN8w+IKs/OErDR3fbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783709754; c=relaxed/simple;
	bh=q8904xmXb7eGsUOPUyRn/bldwzD5EC9W3Q3lWVe9IXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=knAcEgwUKl4j88q1YkqeVC08wYEir6t1Uctl4v3SSChfCIdCt/FmG+nQsGCDbUGv4aqEnBF+nlPBS2RwTUHsEY2tQAeRU2lFy3OdWlOjp1koY1m/oe1r+eJmb7YSiaOmfZZ6FCKXjbpHVAhf2zH93/hBdKgc8vLeajILY/b9ms4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Keptb9vs; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Keptb9vs"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-51bfad59921so7789541cf.0
        for <iommu@lists.linux.dev>; Fri, 10 Jul 2026 11:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783709751; x=1784314551; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=35hzoYcsWEd72Qin3ApbTs4xBItRwQ29eotWM9K9y9M=;
        b=Keptb9vsCXdhhFTQhJhT33ohVbOJox1NhScoAhCPQduwA0K6Wx2nsZ2RGeW1hWKZM5
         J0rcp70YOLIvLlA2bpoXPyIQAu8ZrDN9Nl1czzD3hCx8Qtop5DhEnXsSX7mxLWRIkQOw
         2jrrKZ3EOfuL2z72Ip+DiIlKtDQQ2Ys5aLPPoNtHTr/fqXVxq2ueC/AaZDI2NSM5ljBT
         CxN4bD4oGMMJmGYzQsHHvIe4TX+3EbHjulZ3Zq/xpJMS7BX0ga+K/KWvR6bV6ozpsIlD
         4naBCOvDPpJWF8D6wWemDgHeHTdX30zpvyacAso1Pf13MVcma21gAeiiHoQ5qG5dttTF
         doDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783709751; x=1784314551;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=35hzoYcsWEd72Qin3ApbTs4xBItRwQ29eotWM9K9y9M=;
        b=fh6c1SMEB2IhCwS2QzAvD5Y+HYp7ad72r30UpGzxa6r2+bANc/3rrqQ/xphRFT7O7N
         63yjhh6RKcJ8xU4fC0zJNcli+/xdyHbfWdXTpV3oc5Oa5FLFNYcqcwccuZlild3RtPqO
         jqJoydT9jEEiREDdOrNlOATcCInXKeBGBrCsWbUkQbiKo7pXXeGIdwmOXa+EW159FCPJ
         I8stRTqjQGTw7TCtr/oWN8zwbR5MRw6HsJu+NFaF/WojD1v7CL6Xr6CR/8IzY0eNUBmO
         GQxJYhebiCfBbELgZkiS3PvyGPkAl/88VY69NT9kCebgzGhk0rzohstCRqcl26Mg+vcf
         0ttg==
X-Forwarded-Encrypted: i=1; AHgh+Ro27DPhERTjIYZrLTuP3LQNCtVrZvU+JzWKDDkTyXqvdG4FXnnAln/xsdaHe63XH29jdtAcWw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw/659SVpBcIDOgak2TwcMISs1Q5oQa53j604CGDCqIbuUee7Jt
	WhnBBynhdaxHkmTXHtf9EUDVUdHYhXzo22nc4XPgHdawpwoPONXr/dvCROZmGtGqEhI=
X-Gm-Gg: AfdE7ckpL1JxSiOZfUtfZZVPSPlKVFJ44KLzLkZ3fTG0/VuKjPjrxxRVqn1u0dr1VTI
	PXvA7MaNXzlyoFVdKXBHo6e9minI8XXMB/7WHx1oKpKbWGXXBq+tRARJZxdulaxqRLRWewQQxLc
	WGoKv9wmXje+DQnCnkJxPOeAxGYqNe60wqafMG5nqwbK28vLEhmynxzGzpC29m1KOsf0fN9k2Dj
	LiTLCQzUxv7OWrBcHbmLkc1jvWYb2iojWJC7L27IslHs9lFxBC+cRMNIUFWBXBrZ3hG8VLxDHBr
	TjTV+Q+SVv1aarGK67D+qZ8US6DMfaz5uMlSwNB5jqC5VrZC+tQCRV2yGZMEqJEOsKsF7j5u6KE
	8rIL9bJGIu+AD87j3qqCfjaTP2560PJyEFw+jACJtA2QoivrdS+ZdzerJ7pmf8u1oZ/Pxc++yU7
	SXflSqngIso1UxUCuUJZC9RFWmE/jOH+Re4ppJlWw4MPu5KMhZaGgfyKwZaGOh3PQ5+o6I
X-Received: by 2002:ac8:6112:0:b0:51a:f94e:ce51 with SMTP id d75a77b69052e-51cbf1fb386mr1548881cf.50.1783709750657;
        Fri, 10 Jul 2026 11:55:50 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51caace31a4sm22925021cf.12.2026.07.10.11.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 11:55:50 -0700 (PDT)
Date: Fri, 10 Jul 2026 14:55:45 -0400
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
Subject: Re: [PATCH 06/30] mm/rmap: parameterise vma_interval_tree_*() by
 address_space
Message-ID: <alFAMZNiJvxNpzGF@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <43050b10b53cdfc3627440e6b14ae2a9730b2a5c.1782735110.git.ljs@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43050b10b53cdfc3627440e6b14ae2a9730b2a5c.1782735110.git.ljs@kernel.org>

On Mon, Jun 29, 2026 at 01:23:17PM +0100, Lorenzo Stoakes wrote:
> The file-backed mapping interval tree functions vma_interval_tree_*()
> accept a raw rb_root_cached pointer to determine the tree in which they are
> operating.
> 
> However, in each case, this is always associated with an address_space data
> type.
> 
> So simply pass a pointer to that instead to simplify the code, and more
> clearly differentiate between these operations and those concerning
> anonymous mappings.
> 
> While we're here, make the generated interval tree functions static as they
> do not need to be used externally (any previously existing external users
> have now been removed).
> 
> We also rename VMA parameters from 'node' to 'vma' as calling this a node
> is simply confusing, update the input index types to pgoff_t since they
> reference page offsets and rename the parameters to pgoff_start and
> pgoff_last.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

nice

Reviewed-by: Gregory Price <gourry@gourry.net>

