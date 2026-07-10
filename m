Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A358A1C3BF7
	for <iommu@lists.linux.dev>; Fri, 10 Jul 2026 21:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783717803; cv=none; b=JUeDnriGMG4RFi8uZgwbqmd/SL9n53MBGb8ryPuEJghdHDLSjIB45OQYXNkIn2ISAlcNSY4/tDm4ysnj+RS61EQF6CcUItoMpUW7/WxBBilMlO6SfWl6o5c6k6QruPSHhTuQAKQoA3+T7gdtmWCzU6HzIONpmE+2+EMIbOVSFYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783717803; c=relaxed/simple;
	bh=dNW60Nn0Pk4RAFrYvjK4f4wy+wh7S7nAq4Uli4yrIhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=taTNjfe0AT1rgx1V64l1J3v6m6/VBE/TBq0+2DA0kQGwiHpa2fDL/h34HJUxGLg27r6z3PWjEIy/4QyRCjzxFrp7w0CnYLYkJZ0M4MLItZrFWTGKJEc8jQpKpS0NyBQU4E8nf0RopRsarK12K0kfMUrZgnNCJsLFUmMr4mzKnYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=aHFynClz; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="aHFynClz"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8ee6912d86dso10747056d6.1
        for <iommu@lists.linux.dev>; Fri, 10 Jul 2026 14:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783717801; x=1784322601; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FM5wmgcpnXqQ2LPOtHbLfNIfX5IHSF2YMfcySjsQd8k=;
        b=aHFynClzDDOQD7ei9HBmeJgjLIQY8GGp/CpjiVzj/NDq8IGhR7rSn07LuOg7qVqGg0
         qDT5B4V8EXV0FpkmMsRKvaNAzNcK1jjNEyVrMQLoLdl6fxoNH/yQRV4rm95XCdN9OEZ2
         FPjR7dUaLZXdedD9WT3T3UVBPEMSMqqVGzqcDrn9EJAoxuKduW6puD5HH5BZVD89ssqI
         Iv9DfSBXrHA44z3bMB5onYRx+9knA6ibZRjV8Umx545f6AaHNgsdgV+w5/duiKyFDJ8e
         JpUbLd8oLEdtZsNY92H1yu5FzB4CygpDaHj7e+qE83Vyh0u6lf5Lrg1NgrQ46EXxfFqP
         XDPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783717801; x=1784322601;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FM5wmgcpnXqQ2LPOtHbLfNIfX5IHSF2YMfcySjsQd8k=;
        b=fG16OGWbryizhZPb3KR/3vmLuAlQyiIkLDIG2qdKmWWDzxSSRb0DZz2TBvd9U6++12
         y6Ak+UaUa1lUjeFg7FA+LQzcflPx98lHzzX4ZMpFEnzwI9B5mCITY2SXl+Nh/UGFVERo
         i7Ud2zLJy4BnMqOidnSWxgtIYgEdwjUq9i+oDZnn4PnfvkJCNWqdyJSjhAD2Di7kK1Nw
         O0vx0ZUf7FoKsizoD08eZGolizBNMVo3J+ppgCiHh9DNq7q6aPlwr8BO+h1QNuj0ZFI5
         qIFsFXYjfxPdE4LEbxfsIyJYEALMVPHseuLgjMah7B5frxuyL5vuu68ObMomrLiKHXSw
         d8KA==
X-Forwarded-Encrypted: i=1; AHgh+RovSFmLGbGgt9eSRyXfpKNT9/jT8f1IhJsUHwkySPmw9XyDQC2S48g0C3otsbEo65AMGZJYGQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzuqT72D3V4H/X6t6mQXSJFtXVn6Yy8uWjNDj/ByHNvhB6njUDC
	fHebtyvKiBqplLxRowTGiT2aGmbNFaSE6fj/lr/4+AUJEETrVSv/jrmOEL/e4/9XtiY=
X-Gm-Gg: AfdE7clGJ9zbU3l4KScJaKaDSUisOSrf3lOXcr+loftVlA4KZFiiIOo+EpmO5IkomT3
	c+6a6r7wj0l3ySiRAMzr6M40vZE71B17Hu59TlxJWaqmBgYrkJTEnS2Ophx4IS5ERzeFqIa/L4S
	RRwjCOyv+YmYBRkjVBrrKk6WMaWOUTvvFezFbG1+CPORWQ7SuC6dhAAE67oaO5wEV8T+OKLgG8k
	jQURw8t69qAdgVkQXa8Af+vaxLaJGTQFLNZ/o+alJnqlYHLW6JOQgvqVwySynNPPJ4zYbgQj7po
	HoCcMFNq+aJx/eFl4zy6x5bBubj3U0z6lyqTfwHzefJghilqhpzbMed1/iRJX9EMv0sKTACx2fa
	BazQrw2HDUL5HALBUe1WhzXbtJQ53/cKIg6/SoPIcanGuVLzkDqgl/Koa7zMVfFa+9fUV7QfBRB
	A6ebzYeM9S6ZesZjgdsRQrsJ49yDRQhbEXAxF9lc9oXn/YGJRZsip3e9vZN+DWwaL90ITa
X-Received: by 2002:a05:6214:31a1:b0:8d1:d1e1:8360 with SMTP id 6a1803df08f44-90400b7f3e1mr9010646d6.39.1783717800595;
        Fri, 10 Jul 2026 14:10:00 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd87c8d4csm52955776d6.44.2026.07.10.14.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 14:09:59 -0700 (PDT)
Date: Fri, 10 Jul 2026 17:09:54 -0400
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
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>, SJ Park <sj@kernel.org>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Hugh Dickins <hughd@google.com>, Peter Xu <peterx@redhat.com>,
	Kees Cook <kees@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>,
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	Huang Rui <ray.huang@amd.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Ankit Agrawal <ankita@nvidia.com>,
	Alex Williamson <alex@shazbot.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Usama Arif <usama.arif@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	kasan-dev@googlegroups.com, linux-sgx@vger.kernel.org,
	etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
	linux-tegra@vger.kernel.org, kvm@vger.kernel.org,
	Russell King <linux+etnaviv@armlinux.org.uk>
Subject: Re: [PATCH v2 33/33] tools/testing/vma: output compared expression
 on ASSERT_[EQ, NE]()
Message-ID: <alFfopehgN0dkMzM@gourry-fedora-PF4VCD3F>
References: <20260710-b4-pre-scalable-cow-v2-0-2a5aa403d977@kernel.org>
 <20260710-b4-pre-scalable-cow-v2-33-2a5aa403d977@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710-b4-pre-scalable-cow-v2-33-2a5aa403d977@kernel.org>

On Fri, Jul 10, 2026 at 09:17:14PM +0100, Lorenzo Stoakes wrote:
> Update the macros to output the compared values at hex for easier debugging
> when test asserts fail.
> 
> We have to be careful not to re-evaluate expressions as they may have
> side-effects. So update the code to take local copies and use these for
> both the test and the debug output.

Aw you found it before i reported it :]

> 
> Also remove unused IS_SET() macro.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>


Reviewed-by: Gregory Price <gourry@gourry.net>

