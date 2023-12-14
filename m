Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4113767E73
	for <iommu@lists.linux.dev>; Thu, 14 Dec 2023 18:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XrigHTtw"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-35f69467104so1585ab.1
        for <iommu@lists.linux.dev>; Thu, 14 Dec 2023 10:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702576936; x=1703181736; darn=lists.linux.dev;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=u/dpKKuYQW5rtb0ApzQxLFyCdBQuf8dsFO4Akckbgdg=;
        b=XrigHTtw12ylomsGZM/Lf9oO6KfX7XGwTYJ8PAnkElqPmMUteq5e0zbYargjMPvMBB
         RAp6MWC2hwenewVcWfbIphhLEpbcDUoqs9qgUdhu8xAqqeZ2iyofHOTxmqg2mZaE01Vz
         fqk22ICe06UOeGdCSFXvKFGvNUqBxlBRY4tGtVD1Z87CYe8Cqbz1TlkJgEx6FYA7xHol
         XSkNUPE7Y+sAzPz7pChIzygkrsAsXozg580gtGbZJDVWFPETJ7pW9rqTjkwA8HfD7ivu
         mtw9aqEykB2WFof3fmGskmO5v193JAH8ysbgYrnOZ34HBOWKpDa9FMMv5ckojimw4Enq
         M5CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702576936; x=1703181736;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u/dpKKuYQW5rtb0ApzQxLFyCdBQuf8dsFO4Akckbgdg=;
        b=cVcHcShB9kxlpFDaWZcZhIfvRoX4kbtwwT2BPZ4XO3U7vZN+27Rt+j8RHItyY1vt7n
         yp7XVyaXqxoKMfxvx+LJ1CrsB+m2JdYG0xyXsWTvvDHxN3x1tHsnI9fHe6Bt3MNQy8ae
         qXg31IQueglZR87aykmbeKeAB2m4gpxrivGkCKSaFPJDjaNjBdwKOiVebvcTPV/raKqb
         pp/FxYc4ZPEt2enPUbhCe20ATnPAiIfO0wVNqGuD/1KG3QkPw3UW5Il+glvEKT0AdFhT
         q6uvbl9rkJEMK2Wptm/7V/3YdwlQfVmTeRyIh/7HBwrt/yUSjFYSZ+eHg5OCAfGWk2Yk
         w9TA==
X-Gm-Message-State: AOJu0YzS+aMsAWWCSfQFER+qluehXI3Wquq/qa9Lr0DQd17T2ixrVOI2
	U0Hs9YL3WIHjutBLXDur1usROA==
X-Google-Smtp-Source: AGHT+IGGaPI6cnZcFngPnCAkiSRePhz5Ew4wWckTDOMgQet1/XMgO7hA9mFqQFlIbu1sIxtOg+DrJA==
X-Received: by 2002:a92:d209:0:b0:35f:7cfd:c5d0 with SMTP id y9-20020a92d209000000b0035f7cfdc5d0mr271054ily.22.1702576936243;
        Thu, 14 Dec 2023 10:02:16 -0800 (PST)
Received: from [2620:0:1008:15:740b:4c24:bdb6:a42a] ([2620:0:1008:15:740b:4c24:bdb6:a42a])
        by smtp.gmail.com with ESMTPSA id fm21-20020a056a002f9500b006cea0fd9afdsm12411929pfb.92.2023.12.14.10.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 10:02:15 -0800 (PST)
Date: Thu, 14 Dec 2023 10:02:14 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
cc: akpm@linux-foundation.org, alim.akhtar@samsung.com, alyssa@rosenzweig.io, 
    asahi@lists.linux.dev, baolu.lu@linux.intel.com, bhelgaas@google.com, 
    cgroups@vger.kernel.org, corbet@lwn.net, david@redhat.com, 
    dwmw2@infradead.org, hannes@cmpxchg.org, heiko@sntech.de, 
    iommu@lists.linux.dev, jernej.skrabec@gmail.com, jonathanh@nvidia.com, 
    joro@8bytes.org, krzysztof.kozlowski@linaro.org, linux-doc@vger.kernel.org, 
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
    linux-mm@kvack.org, linux-rockchip@lists.infradead.org, 
    linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev, 
    linux-tegra@vger.kernel.org, lizefan.x@bytedance.com, marcan@marcan.st, 
    mhiramat@kernel.org, m.szyprowski@samsung.com, paulmck@kernel.org, 
    rdunlap@infradead.org, robin.murphy@arm.com, samuel@sholland.org, 
    suravee.suthikulpanit@amd.com, sven@svenpeter.dev, 
    thierry.reding@gmail.com, tj@kernel.org, tomas.mudrunka@gmail.com, 
    vdumpa@nvidia.com, wens@csie.org, will@kernel.org, yu-cheng.yu@intel.com
Subject: Re: [PATCH v2 10/10] iommu: account IOMMU allocated memory
In-Reply-To: <20231130201504.2322355-11-pasha.tatashin@soleen.com>
Message-ID: <c0d23d3e-39e6-57af-fd38-eb1b885d7da4@google.com>
References: <20231130201504.2322355-1-pasha.tatashin@soleen.com> <20231130201504.2322355-11-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 30 Nov 2023, Pasha Tatashin wrote:

> In order to be able to limit the amount of memory that is allocated
> by IOMMU subsystem, the memory must be accounted.
> 
> Account IOMMU as part of the secondary pagetables as it was discussed
> at LPC.
> 
> The value of SecPageTables now contains mmeory allocation by IOMMU
> and KVM.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  Documentation/admin-guide/cgroup-v2.rst | 2 +-
>  Documentation/filesystems/proc.rst      | 4 ++--
>  drivers/iommu/iommu-pages.h             | 2 ++
>  include/linux/mmzone.h                  | 2 +-
>  4 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index 3f85254f3cef..e004e05a7cde 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1418,7 +1418,7 @@ PAGE_SIZE multiple when read back.
>  	  sec_pagetables
>  		Amount of memory allocated for secondary page tables,
>  		this currently includes KVM mmu allocations on x86
> -		and arm64.
> +		and arm64 and IOMMU page tables.

Hmm, if existing users are parsing this field and alerting when it exceeds 
an expected value (a cloud provider, let's say), is it safe to add in a 
whole new set of page tables?

I understand the documentation allows for it, but I think potential impact 
on userspace would be more interesting.

>  
>  	  percpu (npn)
>  		Amount of memory used for storing per-cpu kernel
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> index 49ef12df631b..86f137a9b66b 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -1110,8 +1110,8 @@ KernelStack
>  PageTables
>                Memory consumed by userspace page tables
>  SecPageTables
> -              Memory consumed by secondary page tables, this currently
> -              currently includes KVM mmu allocations on x86 and arm64.
> +              Memory consumed by secondary page tables, this currently includes
> +              KVM mmu and IOMMU allocations on x86 and arm64.
>  NFS_Unstable
>                Always zero. Previous counted pages which had been written to
>                the server, but has not been committed to stable storage.
> diff --git a/drivers/iommu/iommu-pages.h b/drivers/iommu/iommu-pages.h
> index 69895a355c0c..cdd257585284 100644
> --- a/drivers/iommu/iommu-pages.h
> +++ b/drivers/iommu/iommu-pages.h
> @@ -27,6 +27,7 @@ static inline void __iommu_alloc_account(struct page *pages, int order)
>  	const long pgcnt = 1l << order;
>  
>  	mod_node_page_state(page_pgdat(pages), NR_IOMMU_PAGES, pgcnt);
> +	mod_lruvec_page_state(pages, NR_SECONDARY_PAGETABLE, pgcnt);
>  }
>  
>  /**
> @@ -39,6 +40,7 @@ static inline void __iommu_free_account(struct page *pages, int order)
>  	const long pgcnt = 1l << order;
>  
>  	mod_node_page_state(page_pgdat(pages), NR_IOMMU_PAGES, -pgcnt);
> +	mod_lruvec_page_state(pages, NR_SECONDARY_PAGETABLE, -pgcnt);
>  }
>  
>  /**
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 1a4d0bba3e8b..aaabb385663c 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -199,7 +199,7 @@ enum node_stat_item {
>  	NR_KERNEL_SCS_KB,	/* measured in KiB */
>  #endif
>  	NR_PAGETABLE,		/* used for pagetables */
> -	NR_SECONDARY_PAGETABLE, /* secondary pagetables, e.g. KVM pagetables */
> +	NR_SECONDARY_PAGETABLE, /* secondary pagetables, KVM & IOMMU */
>  #ifdef CONFIG_IOMMU_SUPPORT
>  	NR_IOMMU_PAGES,		/* # of pages allocated by IOMMU */
>  #endif
> -- 
> 2.43.0.rc2.451.g8631bc7472-goog
> 
> 
> 
