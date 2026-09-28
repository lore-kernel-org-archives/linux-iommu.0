Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048753ACEFF
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 19:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790624757; cv=none; b=pJbdQnOCXEJnyBowTdYgSpJdBCDuIaIJlHZ3UER6e5lTXAaRaAFHwWte++3OrIbo0dNh0ETK2oik2dWq73ISRX8bMoo2LAgOCtDh3BvuIaUE8Y8DYZ/rj1SyisjYaiv2Hdqb0HEpGfbGVYgcJA870/IDYhVrZOkALg/O4hnnQD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790624757; c=relaxed/simple;
	bh=CTM77BtBAxRz/NUGhlV6ePIrWWx8detoQl79hBAb/aA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=InrYq/XPG0xxC8Uk47uNBA+QyGaLJBZOL6y6Ol+/iR5lITaQzbAfbWz8ADF/IGAHeLqpc5VgOll6jjGKZL0i6HCkrhauv1rQJT1hBzUzaogFt8guIScTM+WMZvnLKkBduEBA+J8evyYNSnPFCLMBRUqMDYvHKmpLQG9eOC5R9jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NC7MJVm8; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NC7MJVm8"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2db33db4de9so12565ad.0
        for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 12:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790624755; x=1791229555; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=J1T7FYtEHLzKBOAf0DCFYQLvpaY4ZVWXjng9Q2koYuQ=;
        b=NC7MJVm8cdFGN3HqNk9tBA4B+neR8rSpZDLHBtpZiRVxlPtAhERabKC5EyLKtWIYxl
         CNtePmQq/APWxG26RQBlMnHEv9n6W5gh/3jM0060vmKcZWCG7iTqlcXfIx94VvBeNZIt
         B9f9t+W8asR7lKNbl3wpKUTKqHM0drPsznXknE0GbpJXnspQb8en8YsnhtJiiURxCjbR
         +FnxwILsH0L4/tRRNn0HMoZ212Ks49qDVMRVnWGrpAG+i1kC1xvITvaAGlkcL+lUWqOr
         MC6Q2EbC8dWB0OHUetabQ6TM+ARW/t+R+x2MwPVgLOFWVYIpeZ+gK/XCChh3mRUhW55i
         LvMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790624755; x=1791229555;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J1T7FYtEHLzKBOAf0DCFYQLvpaY4ZVWXjng9Q2koYuQ=;
        b=FRfEv3/Uh/8Q57g8DUE1awHNX4E9H4AR6/rmM5Y2sTu3LJXF3vn9GgUxkPQzQhTVhn
         CN1OzlNzZOpvd71CtCDKmP9WIWI6gp+a29+JL5wrjeRedm66N8CQkCXrCPpHx+iYI/C5
         pWONszv8ZR9o6t/YpMeBC6UgJpfnka14vJAOgOua5QWl1/Tck4UtCozkvUWOdLcwFgcl
         CnLvtgQ3lc6o8jfl/Z2qasbJ1iTgRgYJ1NfcYC+xtyfHUI/cuL1zyD6O2pAudNUE1rup
         NnDJh5xx9fu3GqE1alQrp9m5WWegPbnlzdAtwFRaUXFWyJgk1cRTQ1qH6jBY170JPYlC
         0E4g==
X-Forwarded-Encrypted: i=1; AKwUvBxCYXmZo2Vh4XIlaM2Jb+kYCmElVgNRw3YGUJJNrQ1uN4l27NWxmxaKd9o6ZvWtyokvgzQT0g==@lists.linux.dev
X-Gm-Message-State: AFq9FYIw3Lj1DHdic/wMfB9TlqIJzlEOa+gndK53u63rI4a1Hsbl7Qvp
	eK/v078F5ubSv8utIDxBkoc1UBSYFDMxhVAF01vHHVHToUQcmNyKvSUnMBJktNjr3w==
X-Gm-Gg: AYBFou00MTerunfge0dlxJ1Bq/zIc+KIweek/OdV1Mk1MYeTGOzA+a8yppjWiiPvHhS
	AR10bqeMyB0Pibg5HO7ehTbbVo891U8gkM6ReZJoJ8iMg/RNOnHFmY+oEUNr8FV/5X4fBKmi+iR
	6i8/+OgmJOg3RntuZrQqXzFv29T3MUrGWJaMD+AUjm4C4nKzvNsgkILTw5GkvLVQn8CYuZCzSeb
	ZivPE9QC17yjHsqHvdMHZ0H8Ik6pb2vAxsXSz84Jm44AV8g6W3KzKkFplW++g1xAh91L1ogJTR5
	qCyyRrXnfjxmR0C2SlNMsJ/Z6ktwC5nrLJVD5qODkokR7WHyucvrVr6d32crRtm5ViNQ8/Qwlq8
	Zn9oDzjQg5cu3adILx/YHAb3iwuSVfAyYbhBBuCLx+jHIg6Gau1hAtWrbpIi5+8ADPlNf9R88r3
	gmGJcYStBW9Wo74XmnolyfvDw6xyC0FAXxwl+E/teoqebRdmG60TPNiDbuTkhCmcGUFVgIOCcyR
	/uvnPACPGS9Ocagzy4crH/u4mTUACjmYJKe
X-Received: by 2002:a17:903:4b0c:b0:2d5:db3d:1a42 with SMTP id d9443c01a7336-2dfa9773f0fmr8136125ad.15.1790624754609;
        Mon, 28 Sep 2026 12:45:54 -0700 (PDT)
Received: from google.com (105.211.142.34.bc.googleusercontent.com. [34.142.211.105])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4926b3f9fsm1077587a91.0.2026.09.28.12.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 12:45:54 -0700 (PDT)
Date: Mon, 28 Sep 2026 19:45:45 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Jonathan Corbet <corbet@lwn.net>, iommu@lists.linux.dev,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Jean-Philippe Brucker <jpb@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Will Deacon <will@kernel.org>, David Matlack <dmatlack@google.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev,
	Samiullah Khawaja <skhawaja@google.com>,
	Mostafa Saleh <smostafa@google.com>, stable@vger.kernel.org,
	Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
Subject: Re: [PATCH v7 0/9] Organize the SMMUv3 invalidation flow so iommupt
 can use it
Message-ID: <arrD6aTjENIsa4sO@google.com>
References: <0-v7-e84261bbe7cd+2ea80b-smmu_tlbi_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0-v7-e84261bbe7cd+2ea80b-smmu_tlbi_jgg@nvidia.com>

On Mon, Sep 21, 2026 at 08:55:08PM -0300, Jason Gunthorpe wrote:
> [ This is part of the patch pile to move SMMUv3 over to the generic page
> table, the precursor patches have been merged now. What's left:
>  1) Organize the SMMUv3 invalidation flow so iommupt can use it
>  2) Use the generic iommu page table for SMMUv3
> 
> The first patch should ideally go to -rc
> 
> The whole branch is here:
>    https://github.com/jgunthorpe/linux/commits/iommu_pt_arm64/
> ]
> 
> iommupt has a design that focuses on building a single iommu_iotlb_gather
> for arbitary batches of map/unmap operations. The gather uses the free
> list and it captures invalidations of tables, leaves and supports mixed
> levels.
> 
> The introduction of PT_FEAT_DETAILED_GATHER provides some additional
> information that is useful for ARM: the damage bitmaps for the table and
> leaf changes.
> 
> Prior to switching SMMUv3 over to use iommupt prepare for this by
> reworking the internal invalidation to work on the same data format that
> iommupt will produce. Bridge the invalidations generated by io-pgtable
> into the new format. The conversion is simple enough, io-pgtable generates
> invalidation operations that have only a single set bit in
> table_levels_bitmap/leaf_levels_bitmap, so we can convert the io-pgtable
> provided size into the proper level leaf or table bit.
>

[...]

FWIW, I was able to run dma_map_benchmark for 4K & 2M 
(-g 1 / -g 512, 1..256 threads) and I observe no change in map/unmap
latency vs. base, no measurable overhead on the leaf unmap hot path.

Tested-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
