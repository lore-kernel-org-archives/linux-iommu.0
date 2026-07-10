Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34347383316
	for <iommu@lists.linux.dev>; Fri, 10 Jul 2026 19:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783712329; cv=none; b=aOgJegAJKmYJ1Sptl5QSIZ54IcbgyVcRBqN+afYCcaimakUEL4fKxMpe5dLx3sb7elwdKUtZrLysH0B+38tCskEAnlmdzZOHmxWFV/ps+k6y5UPmADHsX8+6m1AV2EOYm9UbHlPgYyHmG0M33slcXt7IOX2CWR0CZSejUtAemNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783712329; c=relaxed/simple;
	bh=93/k6XquwkESRTY8Qvhh+3gNAdxoxyU3Cel9zV++PQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tmjSUcV5PUCkMmGlDZI6fBkX1avCwbsD1lwAcOYkkJI/mSX7FWH88SC+mfVz7DhDjVftxsX/T2LATj2WJADS3+v8Vay+Gzsh3vE1CHAlUAOmSAPsTdbYEXXydBzD+XkypJYLhbp8Qj58b//U03XaXS69N2OUbP5oN0XWitbzgTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=cVuh1+1M; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="cVuh1+1M"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8f29ec73064so9233446d6.1
        for <iommu@lists.linux.dev>; Fri, 10 Jul 2026 12:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783712326; x=1784317126; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=68XwZpqFqsaLFsxYJLdxs3+k1PzHke/kGWmUPy80R6g=;
        b=cVuh1+1MhRK3K5pvOdw7+QA2ATUN0eS7xVBE0jQGX2d/p3FYarOI4x1u3QUY4g/b/U
         LJrPzph/5vT88SCUJnCMOm0j/UUPj61VMKdExz/BjlhaXG9ZNI/T8tmzi37KLSJoY9oZ
         XR7r4HPb3iDw6QAhhXFSNOtA5LLs0vuZkhaKYMdEtVuxcwK6X2T1ltTtwtkhgITaG+Mm
         7beaNVu3zCBxpfqwYpNox7Yr5zlc4NKh8ewyOyhAiJB2TXmniTj1gYW6wTw71vDmC5PJ
         0CoxnzqDD9n2q1lTAPojIRVIR4Hh2XKlj4x2ok9DgyjR14uQd4VQl1ee58lDqDSgNaM5
         +/Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783712326; x=1784317126;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=68XwZpqFqsaLFsxYJLdxs3+k1PzHke/kGWmUPy80R6g=;
        b=POfw910rbvdO8wfgjoMVqfp6pk4cMbCzP/CYPTrrBlmC3Gir8hDkv0qfFexo/8PqZ+
         IeW1sst/HbhkKTQFtoOjGEfxyj+MZBM7XM4GkKFfj0Mxl1IZDNuVvita5IrsnVX9HBM1
         lpdJiW+4iwZF1od/dbgU/J+t1YrZMVLg9ioI8kBvFJufpSGTMyVuppnnVK3Sua6qKmOt
         OLeihTmvu139GScO29YZ5q5tUbrDttQemOCD8/fS1jveQQgQ9yuYhtwyaSmpselUkesE
         aRWdsTNmDipS2x83C7jQMBltnK6DZl6VD4ImM3khTMD7J3tEbhr+xX3Pnc1Z23LM1Yye
         fnGg==
X-Forwarded-Encrypted: i=1; AHgh+Ro0ALlhcR2EW0xCR3jw80vejbesIys7g7kE5UB0EZ/KLAj9g6LHnH4KNJE9CC8E0C+/9pRifw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyb6TEeCEQVMRj9M6Hc8G1a/0kgjibOjc7wTPG1bCZMCX8EOMFn
	RCzECAZ7rmzEumWYCyPES1pzVfj9Mo9axZpOnHiayiuoRX9Ea6RPspkb9XdcnbeIYfc=
X-Gm-Gg: AfdE7cl2raEb6oay62thwl3IDFzSSs7FLZvnpDzO5yoMnrWb/ruh/GTXl+Qx/BZCmHm
	VaS+Alta/UHrG/vvNoUlnOMi2tcEuemAY3ztAaD/RS3066CmJ1uPO/1J12+gc+08TeO0ALkWPrq
	YTj9OcOUn621IKq9sUuqTQmtEDmNfn9iEEt5kUN4HsswDq1eYtFS67zXelclSdLTQJ5PnexcwD7
	DShxV6XdQ/U7QGtnfL0Ryl74Zro7wybBhFSxEdwuS6ZTyk16qJuqtnq7FhqJNS7F2rsg9B1zj5c
	A8lbSntqZox03TAi4/pZpMRY6cY6OZiH729LkbTabgzzU3zTs3t8m1ALpJQe4863zRGjijnnn3N
	WR9l7G1E7Q3QGZWSTD3DZQpWZMzP9l8hStQpTjwZmjbNQW84zWiLyRYiKOUytysw+4GjcPeGrvK
	UCcGzoWY1Hcq03G+oAKzO9DdSOgM/z567A4aVgAOgyjyJ2mSEJ/4ReLl3YOB3P/E3DUq0d
X-Received: by 2002:a05:6214:4b08:b0:8dd:fde8:68c7 with SMTP id 6a1803df08f44-90402c685c0mr4983166d6.30.1783712326120;
        Fri, 10 Jul 2026 12:38:46 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd87c9500sm48486486d6.46.2026.07.10.12.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 12:38:45 -0700 (PDT)
Date: Fri, 10 Jul 2026 15:38:40 -0400
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
Subject: Re: [PATCH 28/30] mm/vma: use guard clauses in
 can_vma_merge_[before, after]()
Message-ID: <alFKQOJrgiJl0p_t@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <213918ef85ed427d29d0635db6b07b15280d3bb0.1782735110.git.ljs@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <213918ef85ed427d29d0635db6b07b15280d3bb0.1782735110.git.ljs@kernel.org>

On Mon, Jun 29, 2026 at 01:23:39PM +0100, Lorenzo Stoakes wrote:
> Rather than combining a bunch of conditionals in a single expression,
> simplify by inverting the mergeability requirements into guard clauses.
> 
> that is - instead of checking what must be true for the conditions to be
> met, instead check the inverse of the requirements and return false if any
> are true, defaulting to true.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Reviewed-by: Gregory Price <gourry@gourry.net>

