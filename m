Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498753B8D65
	for <iommu@lists.linux.dev>; Wed,  7 Jan 2026 15:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767799509; cv=none; b=qh8+hCOslb8KDLfP4+zL6vezhJgfTPrjfeP3ZyneCSnohthxNiwhYgrZfnEdttKgGyoRRs64I0Bvc6jQT2Q2/AaQLTtvindiIw9Esec+W+HMFaZtAYo0dZab2pKWjqzzzl0HG4FpAIjC9IWudBmnOAp+0R9xoLv9vVkKBLaBg9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767799509; c=relaxed/simple;
	bh=9FNzeog4COCy9LuoTkzFA4bpW5oB7/uHLvwqjcx59m0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pZ9hLTCemJeZNrThMfEM7/bBNlGSVczHAnGECPND7TjZ8Qg0r6hq3Q9TpX1W/g94gNU6RP2AFsbm+nV1/ak/7lFIEJ8YeK43Rbg8ofiPqP+rXXYlxXbSlwHTNdD2PsmGOCpPomc6Mkqea/ihN517QoFSzum9EU0hKOPsVdGnK/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cVPKp7Nl; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cVPKp7Nl"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2a1462573caso83595ad.0
        for <iommu@lists.linux.dev>; Wed, 07 Jan 2026 07:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767799507; x=1768404307; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mL3jyZUpIqGDPVZblrA8h5rKljtD6YCYa6ewKnuMe84=;
        b=cVPKp7NlslIDQRS6ds+Vsk8ErnqoEXG4hRhSVnl2uIktFk+fJZNGRln8MMn5L5ek3N
         gSZ+DGyJAOyVHQNPa4Yy6ZN3Tv/uSm7QCkZsfwD8AyEqlqrBuXyDiy8DgmgDDc0GPKLM
         DFfcwI2NXM9yA05eXtXiO1zd0sMqR7tOpfWHcRQOKclI1HpBqC4XaLueya4KrdQXvQw1
         HCnmYc2HFGGubaKu5zyjG7qtg+86vc7hBgZnxAaamZvvceEG7jmKs+jrwOPvztT90clg
         F6oRer+YTEdFys/IZvj490TqhkaUU4jdrk88V9yIb90uHgMvuHtyKLrPgO1TblqSX2Yh
         QrHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767799507; x=1768404307;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mL3jyZUpIqGDPVZblrA8h5rKljtD6YCYa6ewKnuMe84=;
        b=NYaVETTGAyYC3Mftnwc2tHEFJtXzjC5e/L9EyWT9Vv3uwokjGHo9GOdDeVgGAOgIq+
         JbrzX99y9kQ/huzsSylpKYxneo0t2iJ8hmwdKCq9FiJXmmCeyW9CLTth9lmJYfUVu2iL
         Xa/LgE/HTd+mFyzlYlYA+IVI/Eu4mgPQkvFKYwtt+FFvBX6xikvN5VZbuBAGxROVsocj
         rWeyEgZsVJDPoWb4KPUZrGe3n8m80EzWpu/u31pHVRk8t27mYc6jU5CQxDQrL+MxDofy
         jiEALm10xLnDXx6p3ezXlrP1+iSzTS3oVG2O40Yr4bWuBd+ALhmRS8D3cnbCPPDD57wn
         /gjg==
X-Forwarded-Encrypted: i=1; AJvYcCXNeUbF18rP8p/rCbqwO/P4+LlsYLm0XqaWZ957Uu2pisFQWFMLbF5woLMkJ2Xqdoj5aNM4eQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxfQgYOefDLvSVJ2lelYOHFKqdEORBlWcdCNkpnSHafecogJ/DZ
	Vjlbf+yxZ3MRgqzBZ4tx52zvwsuWG0jqighWWyt2ycVKW5D71rgtNXN/oemBhQPM6ZvcwKgk0Oe
	FlCPD0w==
X-Gm-Gg: AY/fxX4SeXxdmhG8fIu2TXVFiwaA0ygcoJrSYoJtKBmZOOuyyvaCHrLswuMov2hV8Xx
	sgE3gi583BhwhdXpKdVBKKxRTlH/qGpQ8YRX+vY+YpxMYVvOOggZwPvB4IsV0+0j6xkGsuwlsut
	vIqW2y3/n3d+ucHp+nftCK4+suDzJjpuCcDDrsUzIy2+l5cgUvFHwgNPUPYbEWp217W208bAuLk
	HuYZsBdtqLGUsMbVI1qYlP8U50YUXvQO41W7Q5LDVawEpZ8guVDMkEvSIyYn+/8TicVcUv4Wus4
	6JmBVKXmgMSrF/MshW88XVRqY5YTdIQQJggr3lBpjHV0A6HLw6A295pUCTmpWADgnX8vugPtHAE
	PAlOuaLx+y1GlVZGlewcSnFARGJA6IAG7VaZpNPm7T+CsNHb6oRPGRPFH0LG5joccWRL0HOzyHi
	xOXUxWv4MAZHnNza8iI70kKRnGeWTVqRZ/4DdQgjICQDSriFju
X-Received: by 2002:a17:902:c950:b0:292:b6a0:80df with SMTP id d9443c01a7336-2a3edbc4a49mr2836835ad.10.1767799507191;
        Wed, 07 Jan 2026 07:25:07 -0800 (PST)
Received: from google.com (222.245.187.35.bc.googleusercontent.com. [35.187.245.222])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cc96ca7a9sm5548384a12.25.2026.01.07.07.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 07:25:06 -0800 (PST)
Date: Wed, 7 Jan 2026 15:24:59 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-mm@kvack.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, corbet@lwn.net, joro@8bytes.org,
	will@kernel.org, robin.murphy@arm.com, akpm@linux-foundation.org,
	vbabka@suse.cz, surenb@google.com, mhocko@suse.com,
	jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com,
	david@redhat.com, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, rppt@kernel.org, xiaqinxin@huawei.com,
	baolu.lu@linux.intel.com, rdunlap@infradead.org
Subject: Re: [PATCH v5 0/4] iommu: Add IOMMU_DEBUG_PAGEALLOC sanitizer
Message-ID: <aV56y9KcAS8mC7Uk@google.com>
References: <20260106162200.2223655-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260106162200.2223655-1-smostafa@google.com>

On Tue, Jan 06, 2026 at 04:21:56PM +0000, Mostafa Saleh wrote:
> Overview
> --------
> This patch series introduces a new debugging feature,
> IOMMU_DEBUG_PAGEALLOC, designed to catch DMA use-after-free bugs
> and IOMMU mapping leaks from buggy drivers.
> 
> The kernel has powerful sanitizers like KASAN and DEBUG_PAGEALLOC
> for catching CPU-side memory corruption. However, there is limited
> runtime sanitization for DMA mappings managed by the IOMMU. A buggy
> driver can free a page while it is still mapped for DMA, leading to
> memory corruption or use-after-free vulnerabilities when that page is
> reallocated and used for a different purpose.
> 

Thanks for this series! This is really helpful!

> Inspired by DEBUG_PAGEALLOC, this sanitizer tracks IOMMU mappings on a
> per-page basis, as it’s not possible to unmap the pages, because it
> requires to lock and walk all domains on every kernel free, instead we
> rely on page_ext to add an IOMMU-specific mapping reference count for
> each page.
> And on each page allocated/freed from the kernel we simply check the
> count and WARN if it is not zero, and dumping page owner information
> if enabled.
> 
> Concurrency
> -----------
> By design this check is racy where one caller can map pages just after
> the check, which can lead to false negatives.
> In my opinion this is acceptable for sanitizers (for ex KCSAN have
> that property).
> Otherwise we have to implement locks in iommu_map/unmap for all domains
> which is not favourable even for a debug feature.
> The sanitizer only guarantees that the refcount itself doesn’t get
> corrupted using atomics. And there are no false positives.
> 
> CPU vs IOMMU Page Size
> ----------------------
> IOMMUs can use different page sizes and which can be non-homogeneous;
> not even all of them have the same page size.
> 
> To solve this, the refcount is always incremented and decremented in
> units of the smallest page size supported by the IOMMU domain. This
> ensures the accounting remains consistent regardless of the size of
> the map or unmap operation, otherwise double counting can happen.
> 
> Testing & Performance
> ---------------------
> This was tested on Morello with Arm64 + SMMUv3
> Did some testing Lenovo IdeaCentre X Gen 10 Snapdragon
> Did some testing on Qemu including different SMMUv3/CPU page size (arm64).
> 
> I also ran dma_map_benchmark on Morello:
> 
> echo dma_map_benchmark > /sys/bus/pci/devices/0000\:06\:00.0/driver_override
> echo 0000:06:00.0 >  /sys/bus/pci/devices/0000\:06\:00.0/driver/unbind
> echo 0000:06:00.0 > /sys/bus/pci/drivers/dma_map_benchmark/bind
> ./dma_map_benchmark -t $threads -g $nr_pages
> 
> CONFIG refers to "CONFIG_IOMMU_DEBUG_PAGEALLOC"
> cmdline refers to "iommu.debug_pagealloc"
> Numbers are (map latency)/(unmap latency), lower is better.
> 
> 			CONFIG=n    CONFIG=y    CONFIG=y
> 			            cmdline=0   cmdline=1
> 4K - 1 thread		0.1/0.6     0.1/0.6     0.1/0.7
> 4K - 4 threads		0.1/1.1     0.1/1.0     0.2/1.1
> 1M - 1 thread		0.8/21.2    0.7/21.2    5.4/42.3
> 1M - 4 threads		1.1/45.9    1.1/46.0    5.9/45.1
> 

Just curious to know if we've also measured the latency for larger
mappings? e.g. 1G mapping backed by `n` 4K mappings?

> Changes in v5:
> v4: https://lore.kernel.org/all/20251211125928.3258905-1-smostafa@google.com/
> - Fix typo in comment
> - Collect Baolu R-bs
> 
> Main changes in v4:
> v3: https://lore.kernel.org/all/20251124200811.2942432-1-smostafa@google.com/
> - Update the kernel parameter format in docs based on Randy feedback
> - Update commit subjects
> - Add IOMMU only functions in iommu-priv.h based on Baolu feedback
> 
> Main changes in v3: (Most of them addressing Will comments)
> v2: https://lore.kernel.org/linux-iommu/20251106163953.1971067-1-smostafa@google.com/
> - Reword the Kconfig help
> - Use unmap_begin/end instead of unmap/remap
> - Use relaxed accessors when refcounting
> - Fix a bug with checking the returned address from iova_to_phys
> - Add more hardening checks (overflow)
> - Add more debug info on assertions (dump_page_owner())
> - Handle cases where unmap returns larger size as the core code seems
>   to tolerate that.
> - Drop Tested-by tags from Qinxin as the code logic changed
> 
> Main changes in v2:
> v1: https://lore.kernel.org/linux-iommu/20251003173229.1533640-1-smostafa@google.com/
> - Address Jörg comments about #ifdefs and static keys
> - Reword the Kconfig help
> - Drop RFC
> - Collect t-b from Qinxin
> - Minor cleanups
> 
> Mostafa Saleh (4):
>   iommu: Add page_ext for IOMMU_DEBUG_PAGEALLOC
>   iommu: Add calls for IOMMU_DEBUG_PAGEALLOC
>   iommu: debug-pagealloc: Track IOMMU pages
>   iommu: debug-pagealloc: Check mapped/unmapped kernel memory
> 
>  .../admin-guide/kernel-parameters.txt         |   9 +
>  drivers/iommu/Kconfig                         |  19 ++
>  drivers/iommu/Makefile                        |   1 +
>  drivers/iommu/iommu-debug-pagealloc.c         | 174 ++++++++++++++++++
>  drivers/iommu/iommu-priv.h                    |  58 ++++++
>  drivers/iommu/iommu.c                         |  11 +-
>  include/linux/iommu-debug-pagealloc.h         |  32 ++++
>  include/linux/mm.h                            |   5 +
>  mm/page_ext.c                                 |   4 +
>  9 files changed, 311 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/iommu/iommu-debug-pagealloc.c
>  create mode 100644 include/linux/iommu-debug-pagealloc.h
> 
> -- 
> 2.52.0.351.gbe84eed79e-goog
> 
> 
