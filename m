Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE4338C2B8
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 17:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778695041; cv=none; b=VlIFacxXMY/dDNmqu2nQ4QkXO4w3l9DPKj8D9/zO9LNu7kNpFPvSgkpAQQAqONnuigO880SVJBGcuAytHKPTrRNhhWz4OCT46vcucNVE0K9Nw6igYbBC8vLETWBf5pQ+RNGWoP+tSF3ECCfB/uLWaJ2QsII9GCQhAvqZ6UIOIng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778695041; c=relaxed/simple;
	bh=QKN3YqFmH0/TeY985PphVsKphrajBj6NCp6nMBNJqi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pC18hzi1nFUaGRBkmaIS6U+GB5pk63+Li0h5+Bij0DJA+yJhi1RbdKFff0YWHc9pstUfxtQfyN2jX1wUCnJ8MnwrJldKnHjEb8zFsa/eMaZj6eIjtyhmDhi12pWrHdBJkGiJbrIEsbq9PusDun32XvtUrIh9PtyVIu+/2arfTR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JK5DFKCY; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JK5DFKCY"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2b46da8c48eso925ad.1
        for <iommu@lists.linux.dev>; Wed, 13 May 2026 10:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778695037; x=1779299837; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rumaNYmYuf6e0hytuftPfqmK7NdxUKC1PH7+SuVwJzI=;
        b=JK5DFKCYUWA95Fpb+z+8J9S9HgzbBionroCX6IFaQL6F+9+Q5GHYUY1PPJcryInUml
         Fnbdk1F9z/+yLGr8EP188PJUB1A7m7FJhya+AaH1AzaZArY6UsatRrbajYsU8np5N5Ip
         ZtIXIugiz52S6xGsA/fvdx5BBTdgls0k0IIWUxQ0M57DFFCocpsuSpYEw0org3IRrNSU
         eaimpi6nSAfwCGWt7x4rfYo1R8PZkeya3qY5xX97EWCiOBg0SAUwLwXE/JOzZbE2z4OM
         BVVriO90UnTOSUQ7oNoonmvai2LtG+jmWZaTCqpPqmfiksyiPXijrLm1vpSdncvMJupT
         NFew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778695037; x=1779299837;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rumaNYmYuf6e0hytuftPfqmK7NdxUKC1PH7+SuVwJzI=;
        b=nVoe2YBroOI2BpTIoj+KKRtz2fzzQTUZvoFXnyFurs1UlvGYF7fhs/T21UUdKJ7nrk
         W1FweyzEKRb2At5UVC939TVB0SWoO9H82H7yfzVnYfNPhEeqiiE4Uon0z0qYk/ZnqpaF
         8Ouxpqk1OVY+0Z+ogoL0t61x6TpzurUDi8AvBGZE2yrD+gQqbRYq65YNmqtYU0yxk3bI
         9MNq3owxim7tUN4+2hqhzPZa39a+CNvNgxbRr4S0IISVYfOjAPI8dWhBY88/q07NXihc
         HVSvpk5aG1B9FOMPm9FssVZ6TJ33fDXjDWB68TKAeF7qrQXc81/awULFk+4pp0mhVD+z
         u9kw==
X-Gm-Message-State: AOJu0YzUwiEE1dxuVUZ18eCnVEfsaM1Aotk6tyhsVQ9pcMyBsbGD43WV
	CuWg33DzyikkrujER94o99ERLeShzi4Lpme+byPVoZXhVxk21GltYz8gZGo0hHZvktoVZSxDot4
	3b1EkZA==
X-Gm-Gg: Acq92OH3X0v/mZFFTFiJ26LMuY17BqO2GJUFP5pKyQkgKoQjxCFJK5K/UY55JeCpm2o
	rjd5LaNQkwVcT+5T1S319s3cNw+uJifaiD5uVhVLazWEPAPVkcpLPbmnPM5j+Y0MFrBZN/yEjKG
	+S3N5edkAtthUHlkwBo9HrNzRK4WwxxyEUEAgxj3iTyyEH2G7HFRURRznE134NYd+NySmN7W2hO
	W4FhFmTPHDs1iz9cTFbkmyNpi7zvqjIHzu1F64nGafbeNhOwYbFRIfmwwWfOg/EXK70MrXRaehx
	pHmg7vkrxvs93HElCombbz1AODx1HKfa9Vs0kQnH7/kKs2ngIye+fYgpPllIHXrU9WbLv8vA0P9
	g8rSKZ6jhu505XhuFulliN663r5M9u4Es2vbiWhETX1ZgbUCZtaThdu+DjIsqXiMhs8KCYV4xtd
	bFiqKlq2XQoZbqfsgMUZRyYQ5DOQ9GRRTZ+IY+k2mMcyQLLl3Zsw9LcWWiz7vpUVk/iyAfaQ==
X-Received: by 2002:a17:902:ef0b:b0:2ba:dfa:328d with SMTP id d9443c01a7336-2bd55ecaa5fmr219545ad.1.1778695036910;
        Wed, 13 May 2026 10:57:16 -0700 (PDT)
Received: from google.com (153.46.83.34.bc.googleusercontent.com. [34.83.46.153])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e9fd64sm158045275ad.69.2026.05.13.10.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 10:57:16 -0700 (PDT)
Date: Wed, 13 May 2026 17:57:13 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, 
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joerg.roedel@amd.com>, Josua Mayer <josua@solid-run.com>, 
	Kevin Tian <kevin.tian@intel.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	patches@lists.linux.dev, Pranjal Shrivastava <praan@google.com>, 
	Mostafa Saleh <smostafa@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH rc 4/5] iommupt: Check for missing PAGE_SIZE in the
 pgsize_bitmap
Message-ID: <agS6jQII_2PsAuZh@google.com>
References: <0-v1-44b2fef88b25+d3-iommupt_map_rc_jgg@nvidia.com>
 <4-v1-44b2fef88b25+d3-iommupt_map_rc_jgg@nvidia.com>
 <agS04F8UmZwWZNao@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <agS04F8UmZwWZNao@google.com>

On Wed, May 13, 2026 at 05:46:22PM +0000, Samiullah Khawaja wrote:
>On Tue, May 12, 2026 at 01:46:16PM -0300, Jason Gunthorpe wrote:
>>Sashiko pointed out that the driver could drop PAGE_SIZE from the
>>pgsize_bitmap. That is technically allowed but nothing does it, and
>>such an iommu_domain would not be used with the DMA API today.
>>
>>Still, it is against the design and it is trivial to fix up. Lift
>>the PT_WARN_ON to the if branch and just skip the fast path.
>>
>>Fixes: dcd6a011a8d5 ("iommupt: Add map_pages op")
>>Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
>>---
>>drivers/iommu/generic_pt/iommu_pt.h | 4 ++--
>>1 file changed, 2 insertions(+), 2 deletions(-)
>>
>>diff --git a/drivers/iommu/generic_pt/iommu_pt.h b/drivers/iommu/generic_pt/iommu_pt.h
>>index 19b6daf88f2ab1..4877b05291c9d4 100644
>>--- a/drivers/iommu/generic_pt/iommu_pt.h
>>+++ b/drivers/iommu/generic_pt/iommu_pt.h
>>@@ -920,8 +920,8 @@ static int NS(map_range)(struct pt_iommu *iommu_table, dma_addr_t iova,
>>		return ret;
>>
>>	/* Calculate target page size and level for the leaves */
>>-	if (pt_has_system_page_size(common) && len == PAGE_SIZE) {
>>-		PT_WARN_ON(!(pgsize_bitmap & PAGE_SIZE));
>>+	if (pt_has_system_page_size(common) && len == PAGE_SIZE &&
>>+		likely(pgsize_bitmap & PAGE_SIZE)) {
>>		if (log2_mod(iova | paddr, PAGE_SHIFT))
>>			return -ENXIO;

After thought nit:

I wonder if the error handling of iova and paddr alignment should also
be deferred to non-fast path? Basically lift the iova and paddr check
in the parent if?
>>		map.leaf_pgsize_lg2 = PAGE_SHIFT;
>>-- 
>>2.43.0
>>
>
>Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
