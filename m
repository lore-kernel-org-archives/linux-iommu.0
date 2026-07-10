Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A357F3B9920
	for <iommu@lists.linux.dev>; Fri, 10 Jul 2026 21:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783718655; cv=none; b=ucRTNa5UZX3VaDpTEVSBFr9DWSB3qvBtjf2Bk2V9HDqeSVAvLCzHzZ2mOITyQifihOTshopIyCVxM4YvTrFZ/rg9Q5IGsBcurcCvN26uP41WsnbW/Vq60zHNC+o4Xj+qq/qD1AVybccCfB/pP2JUwuSBl32zq5V09pct6HVW/8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783718655; c=relaxed/simple;
	bh=Yv3pRZ4OX8PGYFLQCiz3pIFR252YmyQ+OnNGPLtq1u0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HgdtxwP24yCmMXfZ6eWWLd2G3DEJgQO0XXDtJsFaclidDBFpkLtk9HzKAgnKjhMYOxp1DcokNPbbZES+adLg4Dh4eALYWCvT6d0kZRhAe7r3OIYwTXCkkyS+tWw7gwM0DOR9uiwzfj3LlVR9z2zQqPI8PWEwvSUPfSz4RsBubIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Q7HiJsRp; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Q7HiJsRp"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8f1a8e914a9so11790016d6.1
        for <iommu@lists.linux.dev>; Fri, 10 Jul 2026 14:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783718651; x=1784323451; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hyoj4hjMSeCH2l8wiR4N5JqU7D2zu2bS+BNg0w05A5I=;
        b=Q7HiJsRp/TDxn8sSiimThrgVQfGFNg/ntsKBFR0QjgGbFP3R6BD2v4yzwXLYAhmBqj
         ZylrYWtdUj9MnnNSL5UlplJYTwkRcKDyztTjHKyUl9RLkwip3Yagy5wFNnYM2HFzjgUI
         85wMahA2R8TiQGM7e7S/I9Vvn8WjgWE67Hoi7q749/ciAh53R+uS5Rmd8YjtqvS7dq63
         TOtZPZe/N94re4Nm+4owNzdvnlfKfqO8OohqLk0WfPqE+eDHvwXPCbBrmgak+XUxLyJH
         zQyNveu0he/1fpJVwHBNG6n+si4semcwhNL7WKhjvvq8Rvs/1Sf8ojAbkrkPFSp9mVje
         kWVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783718651; x=1784323451;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hyoj4hjMSeCH2l8wiR4N5JqU7D2zu2bS+BNg0w05A5I=;
        b=WtfCgTRLvetTyWgOz1cecWf2ZdfNR1PSWYiHZC5NfkGRKCdlEb9ozBNyMV4ofEPWMr
         J0DACEE7kzWVwKtEL+ECoDliLepW73FoApE1UHIMJY/lEBIT+6CZccu/0E8kplul6j8J
         +1bxkFjQCHKcbNo/PwsAdLwemW98cZkP7NJgZJ07iwUb6BqZkheWXAXO52JHP7IaKChh
         u15ERuPC3STd58FH7zPsxH9bPkdfZf01BAymOcn7nqIlQxQr0QVrt3lqRF8KQ5s9utEB
         DD7GCj7jx5Z4B8y/KwG+Y9Otbsf7j0yb5Z+cDkAT3I5ICOJMiomNkdU6j4JYj10sRTlo
         XlRg==
X-Forwarded-Encrypted: i=1; AHgh+RoErEt+HE6x5bLUrC/jkCUlxg8nLE4ODykKJjNR3wU78heEPC+xno6j7YvNmCaMcYoidjJsmg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwT6QFobMUhyKkQYAqUHB1TwgH8zVQN+WqI9ZLajzcyh9r075PT
	ijDp2mkYsXD5zw72i4NlsFyetUuKgchD4qsnBWHqg015bHk1q/Qw2p4tUbeLQi6zEdM=
X-Gm-Gg: AfdE7cnl56HCPxoyX4MRT/He2+6Om3GGD6KqDU4Ox9Po+idPCclnEPrImm7LgpaIkBS
	xKpwGmH2Tgv67sdeWUDzgnVzTkczail1ivf0tV7bYS6kijGl8fakUPIQE+6L2RsHctTTGbfroYd
	uQ5QN4BjWKOrs/Sh74FYb/Z/WzwWteZzkFXZWHxn+DEdj/w4BFOYCAj761x55sacLfoQB7IGxCu
	FBG1p9z7+C0lYf7w0dAntKTsxT2O6P6weNVsUJDlem/8iwJZOBlBoQnLJm4AnLAvfwHJ4Z9hYPo
	HB6CvycU/6j1aSrn/0dBLCHg2c2OPcGJnc3J+dVec0+O+oDmkBwBjTdJYksd9zrY/r5uNBgMBEn
	ugorMmxRei0BkIvp05O4alT1HKeAGtpYfV5lkfGtdxLNivrwBeUiLvdali5lz3XIKf8PsNel5F6
	tXOIHedGzSiZbLx6PLwyPDEmN6FimF6cpPxRk5hYhhjMUWGxJFYzU9g4CZfoopkCV3lCRd
X-Received: by 2002:a05:6214:5b10:b0:901:730f:5eab with SMTP id 6a1803df08f44-9040038208amr9843886d6.27.1783718650605;
        Fri, 10 Jul 2026 14:24:10 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd82e9d5csm50431486d6.41.2026.07.10.14.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 14:24:09 -0700 (PDT)
Date: Fri, 10 Jul 2026 17:24:03 -0400
From: Gregory Price <gourry@gourry.net>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>,
	Harry Yoo <harry@kernel.org>, Jann Horn <jannh@google.com>,
	Lance Yang <lance.yang@linux.dev>, Pedro Falcato <pfalcato@suse.de>,
	Russell King <linux@armlinux.org.uk>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Simon Schuster <schuster.simon@siemens-energy.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Dan Williams <djbw@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>,
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Christian Gmeiner <christian.gmeiner@gmail.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Ankit Agrawal <ankita@nvidia.com>,
	Alex Williamson <alex@shazbot.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Usama Arif <usama.arif@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-parisc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-perf-users@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, damon@lists.linux.dev,
	iommu@lists.linux.dev, kasan-dev@googlegroups.com,
	linux-sgx@vger.kernel.org, etnaviv@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org, linux-tegra@vger.kernel.org,
	kvm@vger.kernel.org, Russell King <linux+etnaviv@armlinux.org.uk>
Subject: Re: [PATCH v2 22/33] mm/vma: introduce vma_assert_can_modify()
Message-ID: <alFi5J3-UQtvTzxV@gourry-fedora-PF4VCD3F>
References: <20260710-b4-pre-scalable-cow-v2-0-2a5aa403d977@kernel.org>
 <20260710-b4-pre-scalable-cow-v2-22-2a5aa403d977@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710-b4-pre-scalable-cow-v2-22-2a5aa403d977@kernel.org>

On Fri, Jul 10, 2026 at 09:17:03PM +0100, Lorenzo Stoakes wrote:
> vma_assert_write_locked() and vma_assert_attached() are useful for their
> own purposes, however VMA code absolutely does allow the modification of
> non-write locked VMAs if they are at that point detached (i.e. unreachable
> from anywhere).
> 
> It's therefore useful to be able to assert that a VMA is either
> detached (modification doesn't matter) or write locked (you're explicitly
> locked for modification).
> 
> Therefore introduce vma_assert_can_modify() for this purpose.
> 
> While we're here, make vma_is_attached() available generally - if
> !CONFIG_PER_VMA_LOCK, then there's no sense in which a VMA is
> detached (vma_mark_detached() is a noop), so have this default to true in
> this case.
> 
> Also update VMA userland tests to reflect this change, correcting the
> previously open-coded vma_assert_[attached,detached]() there.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Reviewed-by: Gregory Price <gourry@gourry.net>
