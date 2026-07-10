Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AF63B6356
	for <iommu@lists.linux.dev>; Fri, 10 Jul 2026 21:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783718225; cv=none; b=W2pJLwoGnxoiP0Dqih2G/Lu2L/qX6r0NCrYd5fwI52bLFf9KQaWjAEpd2qNSJy9lTphD/L665/c8StxcB5sSgtcieHzUmSIy7JfviZRXPzHTsbYK08cAoaPa5T5wSfd/T21DR5k2yvdtB+P9fSJdiOk5sJsiB9wmqQZCZkrDKJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783718225; c=relaxed/simple;
	bh=5KPNhmwijDAsBGeZ64JTaNX2be8iS/2XlIFbwRyt0OU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PXw7BIkq7EwLWASD33y2UHFuuTpZxM3hoyGB/G36BLCw1d6JSZ8tvtUmN/pGm8QrSyRxSlH0O2f2i6GsNh9CSVpyG1JNWSMerVKxEonz72ADIf0oPmyFMP/fEeVjmJUaBPT7JjrbV8U9uqETNnwgUdNwys2GfcP4sw0VffIPawY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=NF4Db+KP; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="NF4Db+KP"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-92e6a434cabso71488485a.1
        for <iommu@lists.linux.dev>; Fri, 10 Jul 2026 14:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783718220; x=1784323020; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Izor2xUYDxPFma+uXVb9laI9dziDM9wo4fE46zQgxzc=;
        b=NF4Db+KPHmJjx0k7hoOhuJhFYmjxZJfTii6/Phhvu7L5vZBIMCVWCuA3IwtOKeNzUk
         0ztsFjhqs+o1bsLKbQdG6IMMtAn/TgppCY4QlWLvrWY08+WvyThh+dKOTty9NFGsAExN
         byk3ZIdvrpaE/qam+xMUXP4Q1Gaz0t7gSP9Rbq9IOvTR12R5M4iE5zeFO7tJTPd2lhMS
         KO8FJFcIARYMUhqAc3kRD/FOdLtFxwwbFqkxO81BNYqc2plP9hzg4qpzYL2yOgYx+Nob
         j/vN01L1DmzUe0X8QAI5Y+nKnUYDNxMCIKJyWhIw+f37Vxaj9iCFwZFEkFfPG0DWlP9u
         nGqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783718220; x=1784323020;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Izor2xUYDxPFma+uXVb9laI9dziDM9wo4fE46zQgxzc=;
        b=mb69Pyv9/ahZl8fpIao2LYMvyr+ryOoQofEKq0G1M/vtCmPqKwefVkrCyZmWHsJOT2
         nQwOcPXmXBv0YRDpRjRojGLAixr4kzMG37Nj9JUxXZZOLFXUFKhA4YXb6rRshEP4NwZR
         T5DSCJnVBnkJAO/RZA9SjFM+jvImvchkxAHVQoS/do+Cow6mOPepCTaaqZV18b0LzeEk
         3Gvjzdc5y9M17ZnRoeMbkgiIJcYJLY9LM6vsMkzYd7TKvhfn+NEgeGuebST5mXgOwoKj
         Too4etfkPtuz4UOP11n3z+D/IXRpFFdZwtESW1LJZiVZVJes0o1Y+llbPxmNRytiX2Vi
         MQ8A==
X-Forwarded-Encrypted: i=1; AHgh+RqYiGPcjFET1QVB1anhKAhlIbvf9FXwLCsNTvqL1o5KTHwSDVP18eF6S0JtBp38Zz2SvBqOpw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzAVaswEXvNFbTpEErUjOUf7NCh4hO4559RJanSbMhgigT9YJu2
	a5A/8Q/wq7t8KUOuAIZIp0pVkW297z4bzIl8JhD38ZgrfmDibJUHaJhYJqP43eyZqYY=
X-Gm-Gg: AfdE7ck4UtnITx3j7ufH2T/4+w2VCObRVAB4zCcM/yE2vtflfnBymKF7rZEA6znIYuh
	6w3NNDEqTX6xzw0IETADmgJqmXjN5Dzvs0kTKWNsaa8ScjcZniBYqUQSuN43Z1XmM31VdUWYbhk
	Og+nk7JDGGVmWPspTwd1fDasQ5QaSfYtcQdXx8GcXqrQNuCm1R27LHvhsq48oR1w9sOuDJOYkKH
	EfQ7IVUgd6ewjnfW5H+p7ARIaz4hUG4YqEaJ+j6hHkd6ckwO7fyZbg5rWglwSYC9tMwGpz5lg+R
	WoyMhAzvSM4zzHPz4jCVNaqfR+tm1HJrK4s5hIbnViqU/FuWEiZD9xeDr4p1ObFZhJ9bYcCQz3t
	qy3MnVADqEfyg704Rx3TjYV/ini250osRIA39KH/5Kubp60tjYLYCCw0MiZM6UesHHoVnsRHJuW
	FmTbZtFnb40nTSEJLF5xjILUjFrNRlJ3lA9hIeDyanh5fQyuwbORFQYP/AaKTLZkalKKS4
X-Received: by 2002:a05:620a:2691:b0:92e:72a4:f290 with SMTP id af79cd13be357-92ef2b3518cmr83584585a.19.1783718217777;
        Fri, 10 Jul 2026 14:16:57 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd80fe218sm49983646d6.33.2026.07.10.14.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 14:16:57 -0700 (PDT)
Date: Fri, 10 Jul 2026 17:16:51 -0400
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
	Naoya Horiguchi <nao.horiguchi@gmail.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Christian Gmeiner <christian.gmeiner@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Christian Koenig <christian.koenig@amd.com>,
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
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-parisc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-perf-users@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, damon@lists.linux.dev,
	iommu@lists.linux.dev, kasan-dev@googlegroups.com,
	linux-sgx@vger.kernel.org, etnaviv@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org, linux-tegra@vger.kernel.org,
	kvm@vger.kernel.org, Russell King <linux+etnaviv@armlinux.org.uk>
Subject: Re: [PATCH v2 11/33] mm/rmap: rename anon_vma_interval_tree_*() to
 anon_rmap_tree_*()
Message-ID: <alFhQ71-WGGHo1sJ@gourry-fedora-PF4VCD3F>
References: <20260710-b4-pre-scalable-cow-v2-0-2a5aa403d977@kernel.org>
 <20260710-b4-pre-scalable-cow-v2-11-2a5aa403d977@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710-b4-pre-scalable-cow-v2-11-2a5aa403d977@kernel.org>

On Fri, Jul 10, 2026 at 09:16:52PM +0100, Lorenzo Stoakes wrote:
> To be consistent with the newly renamed mapping_rmap_tree_*(), rename the
> anon_vma_interval_tree_*() helpers to anon_rmap_tree_*().
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Nice.

Reviewed-by: Gregory Price <gourry@gourry.net>

