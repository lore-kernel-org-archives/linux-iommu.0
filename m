Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBEC46BBCF
	for <iommu@lists.linux.dev>; Thu,  8 Jan 2026 11:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767872269; cv=none; b=SaGkwRPnwQfDKVS68f/UonTLUtRae//c4gJt1bq1B8+QZDIe1we4OBm0no7AJX68yzp0MMSRZ7QgR+ms4l2g6QBkMFwUngg1ym3Vlo3HAd8ebfjgmzOqWo1ELWW5Nf6/Lw7Gqmq6B3gDZSqUWdfJ1ihGU0UbrKRbJPmz/cmrmYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767872269; c=relaxed/simple;
	bh=hXMtQUgw4lOusUBMYTp6horW7LCwBe3omUVA+LVM/Xs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eVWT8XLqf0/3IDnxEpK6trFQ9KEzLNIrvsjMVPbvQlkqvAQWC7sE3bMpee8FzR41gZph+5PUwXNo4Bsgazoqqp4y0wxVdvDqazEFMWbEAP/lWKRKGF0SotgXhczb0X5oworMRP6RyvEZ7yppncMIZnUZ4UbeEWON3uq+je0LmXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YH57ldTy; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YH57ldTy"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4779e2ac121so130795e9.1
        for <iommu@lists.linux.dev>; Thu, 08 Jan 2026 03:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767872264; x=1768477064; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SeCkOM2Cu2fdrKkUm4jDLC5UzEO1Q6YJYSDtB9D9vrY=;
        b=YH57ldTyu86LFicGogcUqIRIouE2qcTUlhTlgjUwtdg0QpczCEKkMQ80QVCkLsLO3i
         j5qL6sb65is/UsvExTfcRiKE7WNqdFSaLTOutfg8al6PLcocXg83FNcYuX31rNFLf+0E
         BSQ0v+vq9N73t2ovioMHOouq8wSSCa/DfCjbe+t6ffdJvkOVdrggenaiWCPe6YvSHwr0
         vKOapsxcHyltWt7ZAphQGEg+hN+NIrXN0bjEu3rtuKnrYCdN2rPj8aLEmbLfTECc9YsY
         AD8IhGK3/4QrYEYH2/5ujIUjkGZDGCbM8MUVTlFXjVhxAPDylbLBuLHWWu5ilOaxpTzg
         eKgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767872264; x=1768477064;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SeCkOM2Cu2fdrKkUm4jDLC5UzEO1Q6YJYSDtB9D9vrY=;
        b=uv8eaWe1iX8NeEMUfYJL7dKUWDpig7Clw06CHLSvmDdR0u9FxG9RCmujRhglGN7TOQ
         VwjygY+TgeexD8Up6OXg2md2TZ9m6jeYmSJq4E4Tju3xWakwdj3kw83ekJrRX60lhO3+
         UYDXQ6WAa3j4ieWNzGQARW/KBW/id8+8PJnTduBgjfoAgUL29XiO4xKFfI+LvjyHO81r
         v7XErauTkW6ggzf0xjgEotETJdCS+H6XpLCFWTmzq754D5pshDzpo9qSBvqbHyAcS89e
         4KiFy6B/4ZwlLGTJojCS8ae6lYKnlsxmm0p0iuj3oH9Vyxn4d/sh6XeOj+kuyZXrPEbW
         hgEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXswbQuzaS6nw3prJppv39kv4E/XKhG3eZCXtcPpAzAV7FnTeMqYvG7PDlqEc7ng9gscxx9VA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzvZNAiG0jKROxuyeiXv2GsS5PVahzTCm1VLC9F/r3tSSopv5XB
	yw/zeSzDYA+DKfjUScpDv6ECpxhvtkQ0am8qidMtah5fhVmNhcmH/3+83YFc2a2KLg==
X-Gm-Gg: AY/fxX7O0BTfsnht64vRUKt+fDxRyZ3U/oCeBDABSGV4MvHVA6ABq380x+zQB1LrulR
	bpG18FCjCny+nrUJ/8Gvfy6MDa31Pt82N1MaDO8l+pRcyKRcAGICiyTgkgibOc+cGVshu470/kT
	VT+Mutl+6rMC+De6aL4L3+usapHZiEmk6rVIy5PyBug8rNz9J0ThFJv+qTFTwjyPdCM8svKI5B6
	kmVQovveUcnzPnv0YAbGIOsSF/76ySsf87CtAU3z6bRbtB62R2bN8GWqG6G6cWxEUW1vRuhbupU
	7GA7HB90t8XHHC5MQ4pEdPObatZvzKvwHVHcpwVHslqsr0G7K0BDH9EpXMSNEDYcirIuDU2x3P7
	qIoZ7b2sDLJuOEcXfrqkztjW0GNrDjY7/+S4VuHSjVZzMidPSszNp71I35OANLmQGzH17hLHao1
	/khUMDyiUI63ynwsyaTnHGf5++C9se97tujCajmsI2MaFycQeB7MoG
X-Received: by 2002:a05:600c:4e0c:b0:47d:7428:d00c with SMTP id 5b1f17b1804b1-47d8ac49a26mr553445e9.17.1767872263247;
        Thu, 08 Jan 2026 03:37:43 -0800 (PST)
Received: from google.com (171.85.155.104.bc.googleusercontent.com. [104.155.85.171])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0e16d2sm16560217f8f.13.2026.01.08.03.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 03:37:42 -0800 (PST)
Date: Thu, 8 Jan 2026 11:37:39 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: linux-mm@kvack.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, corbet@lwn.net, joro@8bytes.org,
	will@kernel.org, robin.murphy@arm.com, akpm@linux-foundation.org,
	vbabka@suse.cz, surenb@google.com, mhocko@suse.com,
	jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com,
	david@redhat.com, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, rppt@kernel.org, xiaqinxin@huawei.com,
	baolu.lu@linux.intel.com, rdunlap@infradead.org
Subject: Re: [PATCH v5 0/4] iommu: Add IOMMU_DEBUG_PAGEALLOC sanitizer
Message-ID: <aV-XAxCca8qeNVGT@google.com>
References: <20260106162200.2223655-1-smostafa@google.com>
 <aV56y9KcAS8mC7Uk@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aV56y9KcAS8mC7Uk@google.com>

On Wed, Jan 07, 2026 at 03:24:59PM +0000, Pranjal Shrivastava wrote:
> On Tue, Jan 06, 2026 at 04:21:56PM +0000, Mostafa Saleh wrote:
> > Overview
> > --------
> > This patch series introduces a new debugging feature,
> > IOMMU_DEBUG_PAGEALLOC, designed to catch DMA use-after-free bugs
> > and IOMMU mapping leaks from buggy drivers.
> > 
> > The kernel has powerful sanitizers like KASAN and DEBUG_PAGEALLOC
> > for catching CPU-side memory corruption. However, there is limited
> > runtime sanitization for DMA mappings managed by the IOMMU. A buggy
> > driver can free a page while it is still mapped for DMA, leading to
> > memory corruption or use-after-free vulnerabilities when that page is
> > reallocated and used for a different purpose.
> > 
> 
> Thanks for this series! This is really helpful!
> 
> > Inspired by DEBUG_PAGEALLOC, this sanitizer tracks IOMMU mappings on a
> > per-page basis, as it’s not possible to unmap the pages, because it
> > requires to lock and walk all domains on every kernel free, instead we
> > rely on page_ext to add an IOMMU-specific mapping reference count for
> > each page.
> > And on each page allocated/freed from the kernel we simply check the
> > count and WARN if it is not zero, and dumping page owner information
> > if enabled.
> > 
> > Concurrency
> > -----------
> > By design this check is racy where one caller can map pages just after
> > the check, which can lead to false negatives.
> > In my opinion this is acceptable for sanitizers (for ex KCSAN have
> > that property).
> > Otherwise we have to implement locks in iommu_map/unmap for all domains
> > which is not favourable even for a debug feature.
> > The sanitizer only guarantees that the refcount itself doesn’t get
> > corrupted using atomics. And there are no false positives.
> > 
> > CPU vs IOMMU Page Size
> > ----------------------
> > IOMMUs can use different page sizes and which can be non-homogeneous;
> > not even all of them have the same page size.
> > 
> > To solve this, the refcount is always incremented and decremented in
> > units of the smallest page size supported by the IOMMU domain. This
> > ensures the accounting remains consistent regardless of the size of
> > the map or unmap operation, otherwise double counting can happen.
> > 
> > Testing & Performance
> > ---------------------
> > This was tested on Morello with Arm64 + SMMUv3
> > Did some testing Lenovo IdeaCentre X Gen 10 Snapdragon
> > Did some testing on Qemu including different SMMUv3/CPU page size (arm64).
> > 
> > I also ran dma_map_benchmark on Morello:
> > 
> > echo dma_map_benchmark > /sys/bus/pci/devices/0000\:06\:00.0/driver_override
> > echo 0000:06:00.0 >  /sys/bus/pci/devices/0000\:06\:00.0/driver/unbind
> > echo 0000:06:00.0 > /sys/bus/pci/drivers/dma_map_benchmark/bind
> > ./dma_map_benchmark -t $threads -g $nr_pages
> > 
> > CONFIG refers to "CONFIG_IOMMU_DEBUG_PAGEALLOC"
> > cmdline refers to "iommu.debug_pagealloc"
> > Numbers are (map latency)/(unmap latency), lower is better.
> > 
> > 			CONFIG=n    CONFIG=y    CONFIG=y
> > 			            cmdline=0   cmdline=1
> > 4K - 1 thread		0.1/0.6     0.1/0.6     0.1/0.7
> > 4K - 4 threads		0.1/1.1     0.1/1.0     0.2/1.1
> > 1M - 1 thread		0.8/21.2    0.7/21.2    5.4/42.3
> > 1M - 4 threads		1.1/45.9    1.1/46.0    5.9/45.1
> > 
> 
> Just curious to know if we've also measured the latency for larger
> mappings? e.g. 1G mapping backed by `n` 4K mappings?

No, the max granule supported by dma_map_benchmark is 1024, which
is 4M for 4K kernels.
I thought 1M would be better for my setup, as I am using SMMUv3,
where 1MB includes many PTEs compared to 4M, and the 4K test will
cover the single PTE case, so we get more coverage.

Thanks,
Mostafa

> 
> > Changes in v5:
> > v4: https://lore.kernel.org/all/20251211125928.3258905-1-smostafa@google.com/
> > - Fix typo in comment
> > - Collect Baolu R-bs
> > 
> > Main changes in v4:
> > v3: https://lore.kernel.org/all/20251124200811.2942432-1-smostafa@google.com/
> > - Update the kernel parameter format in docs based on Randy feedback
> > - Update commit subjects
> > - Add IOMMU only functions in iommu-priv.h based on Baolu feedback
> > 
> > Main changes in v3: (Most of them addressing Will comments)
> > v2: https://lore.kernel.org/linux-iommu/20251106163953.1971067-1-smostafa@google.com/
> > - Reword the Kconfig help
> > - Use unmap_begin/end instead of unmap/remap
> > - Use relaxed accessors when refcounting
> > - Fix a bug with checking the returned address from iova_to_phys
> > - Add more hardening checks (overflow)
> > - Add more debug info on assertions (dump_page_owner())
> > - Handle cases where unmap returns larger size as the core code seems
> >   to tolerate that.
> > - Drop Tested-by tags from Qinxin as the code logic changed
> > 
> > Main changes in v2:
> > v1: https://lore.kernel.org/linux-iommu/20251003173229.1533640-1-smostafa@google.com/
> > - Address Jörg comments about #ifdefs and static keys
> > - Reword the Kconfig help
> > - Drop RFC
> > - Collect t-b from Qinxin
> > - Minor cleanups
> > 
> > Mostafa Saleh (4):
> >   iommu: Add page_ext for IOMMU_DEBUG_PAGEALLOC
> >   iommu: Add calls for IOMMU_DEBUG_PAGEALLOC
> >   iommu: debug-pagealloc: Track IOMMU pages
> >   iommu: debug-pagealloc: Check mapped/unmapped kernel memory
> > 
> >  .../admin-guide/kernel-parameters.txt         |   9 +
> >  drivers/iommu/Kconfig                         |  19 ++
> >  drivers/iommu/Makefile                        |   1 +
> >  drivers/iommu/iommu-debug-pagealloc.c         | 174 ++++++++++++++++++
> >  drivers/iommu/iommu-priv.h                    |  58 ++++++
> >  drivers/iommu/iommu.c                         |  11 +-
> >  include/linux/iommu-debug-pagealloc.h         |  32 ++++
> >  include/linux/mm.h                            |   5 +
> >  mm/page_ext.c                                 |   4 +
> >  9 files changed, 311 insertions(+), 2 deletions(-)
> >  create mode 100644 drivers/iommu/iommu-debug-pagealloc.c
> >  create mode 100644 include/linux/iommu-debug-pagealloc.h
> > 
> > -- 
> > 2.52.0.351.gbe84eed79e-goog
> > 
> > 
