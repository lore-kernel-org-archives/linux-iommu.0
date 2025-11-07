Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583BA2DEA80
	for <iommu@lists.linux.dev>; Fri,  7 Nov 2025 19:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762543837; cv=none; b=LWo9ZEgxHnupZt8ahorGklkR73hz6GGMgwI8VA/WpKy8jCE3ULTHjn2d+k7/4r1GKPjMBGnJRZ7qMzMjBN88Yideu5K47t/wL8EYfj3SpJcGO8j2mh+KSbwwV47bNg66HUNX2bb95BaT/wUuYOL1KQDvSuIEZnq1ESa0SIjj0KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762543837; c=relaxed/simple;
	bh=XygVhSD3HlTOEAa9BQJmws4+jogICxDOzJiVToEZzsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JwTo0Ili1UtfgDd3/g2Yu+8XC+NbQgl2RtuQHLz6vubGjXjtX1TZmQqPJ85aCW21fms3gmAJQ7iS3EcMaeow8MfRJTWtjL4tSdZXNe4r+sosu3lmcJZFS1cZ9NWOrjdRqeinYzsHQOo2S+fS4sLFsf9gINxQB9Di64ThmaZssDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E9LmNs0o; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E9LmNs0o"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2959197b68eso22665ad.1
        for <iommu@lists.linux.dev>; Fri, 07 Nov 2025 11:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762543836; x=1763148636; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ii2K5/lD+aBTxicdOXZF0Rxje4qtvj62/HMAMykB+YY=;
        b=E9LmNs0otLNsIcVq/z9VACWQciHziipAwIGyN1xma2c9lRHE8LWJ8C1VJARMc/akTI
         UhObIkwUm4elb2ft673nyfq9eXoI3hX9MY2zbAVYmAOKQGcmU0e3Ol1PzbMKf850qgmY
         P8fGoFOFHne7POIYShhMfma8w4f2TgVvSbeYfkWmXYfpwdKF7mIIEL+IVUXGQsf3tLeD
         A8NVTL8Ikcs4uEk/dQncy0V08RAf2yzyFDiNFputJYNXQ3p+y7j/QI7EdV0goyja1+Bn
         9jcxhH3M/YKPE6AbSDzfEuY0rDtt4Nm6Vn8X//x2JBFzKj1CsY2mITlNLK/53CQDDvcJ
         XoGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762543836; x=1763148636;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ii2K5/lD+aBTxicdOXZF0Rxje4qtvj62/HMAMykB+YY=;
        b=UjFrNLeTP4wl5BYjZFV1sE3MscVm/s12BYaD7V0yWDCU2n8tB57fv8+WQ1W26DFeBp
         20JS8rw4R92JprT629lJooyxYX2ZZt8pKIUXLBFfShHFhbmxOAoje1Wi8ESuzMg9oWwm
         LWRLOEl5geQDS3G05QDIrL6pAPfnAxBZ9ts2oHIHORChWAWHQxwyc9HB9cwRgGvkjKuV
         EBkoeBpWGoBuoJ7MeAMTp7QtshgUCTCo+7grdNuBiOimfOgd4pvPi5+Dmwim+sYr/M6/
         noAkAFvLKb3qXV632rONk4ivMh/a5yFzJ4PE06bSA/r4NS9qvix7pESwozDXjA97LRbf
         pfRA==
X-Forwarded-Encrypted: i=1; AJvYcCURkTgUR7qhbOqCafwyi7yX/yR76R84Ov2Ch89SZVq8A6SPSt67NrfZuTL+N12lm/KrsalaMQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzsY5nr1WiCjipcvTxZ46igTcgLpazNEfcQ14rTM470SZyM8NZR
	4TGMgutQJU/Zfog/zUKUzvdB7um46X/bHHm3RZDntxvUJ+oE/d60eBKtpdzPB0hv4A==
X-Gm-Gg: ASbGnctpvPRU1U/A/UlhCUe5qCEvjgAfgiw3LY0uqJkujFyETFzopcKorGmR7yjhCZF
	gn6stX6wJVybcql/xcqL5p82sNjxU0303YIQghck37GZF0hY8z4CkShmMF9B/olB4E4EFJ7GYFf
	G3wxX9d31QYpY2L1V1OFqqbrgJDvv1rLNw6M6ftD1DV0u4VDKsAdE1XRnaJ2VbrNiQhsfTbEZyF
	vLKCsb+Qaf1I7QbAiy/byugRBST289wp+ZIrXLNCkVCv4zCuLgeNvfD9YekDpObYa5/bm3g8HNg
	2s+BzLfh+RhOaZp55p46N7ngUIwH0ScPU6jpS1yybiX/UuYTqBRmGOaLtg73+jTmkWsygdX09YE
	PMmxs48QQMDy8pwQPjsg5bez/whP06c+mMGSVLn7hXp4mO/2LZQ0jyPAXPbuKvBy4B1SPD4Pt2Y
	DWjYZ5vprM0QnB6zcx9eGmT6lprOua5A0YOIVrtsffMCkUYESu
X-Google-Smtp-Source: AGHT+IGrZxEpsvavP2SSGDlxEEDNvgmombMxNJOrhRHYLBt6v8Cu6925mPYDaXVNFvL+7VqE7SGZkQ==
X-Received: by 2002:a17:903:32c1:b0:297:d83c:9c37 with SMTP id d9443c01a7336-297e56624e7mr492925ad.12.1762543834993;
        Fri, 07 Nov 2025 11:30:34 -0800 (PST)
Received: from google.com (164.210.142.34.bc.googleusercontent.com. [34.142.210.164])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341a68aa1edsm10072092a91.1.2025.11.07.11.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 11:30:34 -0800 (PST)
Date: Fri, 7 Nov 2025 19:30:28 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Ryan Huang <tzukui@google.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Daniel Mentz <danielmentz@google.com>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Fix error check in
 arm_smmu_alloc_cd_tables
Message-ID: <aQ5I1OYwWbfbA95X@google.com>
References: <20251107190917.2858684-1-tzukui@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107190917.2858684-1-tzukui@google.com>

On Fri, Nov 07, 2025 at 11:09:17AM -0800, Ryan Huang wrote:
> In arm_smmu_alloc_cd_tables(), the error check following the
> dma_alloc_coherent() for cd_table->l2.l1tab incorrectly tests
> cd_table->l2.l2ptrs.
> 
> This means an allocation failure for l1tab goes undetected, causing
> the function to return 0 (success) erroneously.
> 
> Correct the check to test cd_table->l2.l1tab.
> 
> Fixes: e3b1be2e73db ("iommu/arm-smmu-v3: Reorganize struct arm_smmu_ctx_desc_cfg")
> Signed-off-by: Daniel Mentz <danielmentz@google.com>
> Signed-off-by: Ryan Huang <tzukui@google.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks for the fix!
-Praan
