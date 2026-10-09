Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E78484237
	for <iommu@lists.linux.dev>; Fri,  9 Oct 2026 09:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791538521; cv=none; b=DNBJotFsoT7VUxHapdLMWQHWhOuXHj8lTO7gyqcv7v6T+qkDsbG1Fmo3MB3N43lA+LRJfw6l7fB06aeD2aiLrVagf1WTZhIcTrAb1ipS0SQPZzMB1tCWarZM84faGBRcrzR85S5wL0x6ofoyVt/AEsB5hjOspntR9bn1XTAJYNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791538521; c=relaxed/simple;
	bh=/c8N48QbtXgR/eVlCX4e1X5WhhCM4Hemay3LC9ggKPk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bkzV8jIRMc+NH5yV91Cufv504ldBqvQHVDXye48MHHiJrZPM/ixodBGJ5Uvogh6tCPrvsNdfFt78AASuAccMi/JduABMQ5qzCgFpVQbU1GnX1mvb9D8Sgh85eoSKV2l1Tw9/u98aG9QoDnCNa2BoHcUemNLbebSveYhpYPtLuB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=FskiCDHI; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="FskiCDHI"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a02718da81so29325975e9.1
        for <iommu@lists.linux.dev>; Fri, 09 Oct 2026 02:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1791538510; x=1792143310; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oJvujCG6Ef+ooO87W/Kfsk5ax+KDA0Y6he4rHd/9/6A=;
        b=FskiCDHIoeJ9VQFnOPR3rxAtR36tvY0SSA1sW+GE+5f9KwRRrfLG6Bf69zCJ242Ft+
         vuVCGUrEVGVl4Tti3n83zjLtkvnxQkd1Y1BCmFPZ9edNf5WybTSR2KwRY461v7NLzfI3
         va666H/rnkNdYEmTnu+f4EtDZEArC9/UXfD0zLkx3uAMsu+a8fYNgMurpPNZERS/Xq1l
         IYsP3aofloxlzjooA4jwlet4F7HgmuXYi91xom15pzgzjInoQgoT68V4NCf0eFBN3IID
         KwqClLhkQJHXRXzPDOwc/Dps7WvgCgfYB7+k4PJ4zOYKvTSewqXS7XpmppGKf5k6mMUq
         Cedw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791538510; x=1792143310;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oJvujCG6Ef+ooO87W/Kfsk5ax+KDA0Y6he4rHd/9/6A=;
        b=shCcC3FfjxV01fqJS7+1Y9ZOJOP60uB18TF6V/VASi5cjC9rqrVcAUkcc5x/p66Awa
         0DMOsSnzuaERbSG/OVd0Ubk+4c5FwEV1LiOSuDYdHr44sQ8+ZyhobMGtoTyxQ5DKmxWf
         P0UDJHRWX3zRGrIYD/2qkdw4yoGKcz98JfjqPrKufqhqE9rWngWQI/69EPQhPBGS3ryh
         uGqYHTWTSTUQciig5tKQZXqpBAU8unrsf4zhp65Fi/ltqJZP5bHmvLU6TNq5+ljI4PTg
         dPJ4nObtrSjgXCQ/9mz8ctS7e/wwx7SPQ8wl9XAPgnqw6JJQ9ZcypvwiIK+8NHCfskdd
         8i7A==
X-Forwarded-Encrypted: i=1; AKwUvBw5ExtgKfpJ2Gub+zZ1O0ZLvGDJgQ+Qx5vBRO0CH2wHbI6b+uXD9kxhicFAq9E4gTedByxe7g==@lists.linux.dev
X-Gm-Message-State: AFuF++lOx+orPNHEZ5KEaorZ0qNx1OzdJwtoYoQtvDb4uRJ8ZD4zoIYo
	YGIFjgcXEE61n/il4Cy02hixzQqSht+w+EI51XdxJjUmk66NAeCuG7SRmfuBrEF8J6k=
X-Gm-Gg: AYBFou1n+QVZd1yFmGPjEoEOAqtMQn0iFskj2e2YumU8+c3wFE4JRAzXhnJkbwc7bi0
	7IF247JwLm7SstVEbIhVSJzvLSe5a8eIEW7wdR2vs3psidI9osLofhw0k40I14qVv9p7oEAD+wq
	DBFvRv8SrPQ7cVwCoVuIdcd61RpFRqQhZlEo/IkPJSkkJzPGkLgDNWSN0zjhSxjxWgp3AI/Wpin
	b8gwOSGyb75zWb1rhb8YfiwZTd93xESOeDvlm5/fnNxo3wEEioTce5Dz9Dt3ep07OhCXxTvydND
	CPARPaCrVCGbuuESvRhAKnjWaCDCJcuD+iphhE97+ARLy4xpIdQONXMX14kZCwn/rvzohvb9qe5
	pYljmWUXyavcp3TyoZ3X6axUu2GuIVxa5zEUrra2zyhTmxXLWJ6NRAGMpErMGXgvpzTb8ib5faj
	f3efMPa1NJc+jXGjQjW4eqj2lr1zgmja9RPnUYngrZivWYc2BL1zUAnkw=
X-Received: by 2002:a05:600c:4f10:b0:4a0:d1f4:b1d1 with SMTP id 5b1f17b1804b1-4a18e4bff89mr26548565e9.24.1791538510535;
        Fri, 09 Oct 2026 02:35:10 -0700 (PDT)
Received: from localhost ([2a09:bac6:37a8:2696::3d8:4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bea1021sm43339765e9.10.2026.10.09.02.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 02:35:10 -0700 (PDT)
From: Matt Fleming <mfleming@cloudflare.com>
X-Google-Original-From: Matt Fleming <matt@readmodwrite.com>
Date: Fri, 9 Oct 2026 10:35:09 +0100
To: Joerg Roedel <joro@8bytes.org>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
	Ashish Kalra <ashish.kalra@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Sairaj Kodilkar <sarunkod@amd.com>, Baoquan He <bhe@redhat.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: [PATCH 0/2] iommu/amd: Fix device table setup in kdump kernels
Message-ID: <asi0gnLD2v2Ir5bX@matt-Precision-5490>
References: <20261002133143.3628181-1-matt@readmodwrite.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002133143.3628181-1-matt@readmodwrite.com>

On Fri, Oct 02, 2026 at 02:31:41PM +0100, Matt Fleming wrote:
> From: Matt Fleming <mfleming@cloudflare.com>
> 
> An AMD kdump kernel booted with crashkernel=512M,high and
> crashkernel=0,low fails to allocate its device table because there's no
> memory below 4G. IOMMU init fails and, on our systems with an Intel
> E810 NIC, the ice driver's TX queues time out, so the dump never gets
> sent.
> 
> Since commit 38e5f33ee359 ("iommu/amd: Reuse device table for kdump"), a
> kdump kernel normally reuses the previous kernel's table. Patch 1
> programs the new table if reuse fails. Patch 2 drops GFP_DMA32 for
> kdump kernels. Normal kernels still allocate below 4G, because that's
> what the kdump kernel checks before reusing the table.
> 
> On an AMD EPYC system with an E810 NIC, the kdump kernel without these
> patches failed the order-9 GFP_DMA32 allocation and its TX queues timed
> out. With these patches, the kdump kernel reused the old device table
> and the dump was written over the network.
> 
> Matt Fleming (2):
>   iommu/amd: Program device table when kdump reuse fails
>   iommu/amd: Don't allocate kdump device table from DMA32
> 
>  drivers/iommu/amd/init.c | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)

Hey Joerg, 

I know it was Plumbers and ksummit this week, but have you had chance
to look at these two patches?

Thanks,
Matt
