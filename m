Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B450E509EEB
	for <iommu@lists.linux.dev>; Tue, 29 Sep 2026 00:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790640003; cv=none; b=qYjiuhBQGD3YaIQkilRa1OB6ZLKyVYN5Lu0RpcDDDrke/0AJ2VgmNdW83LB0UtKuMGCgAZ8FQU6OMwXdEMgdZFO7Ms7PtBs7rD85lv6P5Bb/vdEeeg8p8OkP6phnM4RWcrbA8SILVzmr6Sed5ABzAqrI6e88ITax6gE2Xu7F+zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790640003; c=relaxed/simple;
	bh=ot+I73SaU9sqn64543aeRD7kwAJJI21fZVn6OsikOA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rl5OCBZHypiEJRseAxfj0ofZhtDnwhmYpnqjxCVNFonVW+8rQ23kPTaPLbr5UlZHivehjXkPvyKJejsYNhG/ej1lh0NutO7+BiSeK/paqJIAaK0b7HI2xQ1aIIUL73RmFt5C3Ij83u3xph0R053Qm8/DwwzAqbPJcYOWkLbu4Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mZIxcZk9; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mZIxcZk9"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2d8fd7a3f38so9645ad.1
        for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 17:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790640001; x=1791244801; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kp5ei0/iKnj9mU7W/OT7FmtL2iwT8AA400ktoI4ALho=;
        b=mZIxcZk9d3D0Dta2sHwNNLkAJrR+dqXdmkEvBQtJzs4xPTTVdPwewWUuikRgDeR3it
         ycic84Hmi0LYhrARBefnX4E9CaIOYr9qahharXWy6+wDVcbKlVenoZPlNxJan+X2kcyM
         MG1FxV3xfkptld6WCtRKQbxD6iggqAyu7vurdHqU0T2zpbXU6XH8i/blbh4IUB9x+3Tr
         7nb951k6/R82+0S8FuMCz0Xxs05TZQRTRUopWcfLcL5LvuHqdUNW0aMHmxCHeqXWpLfS
         Rn6WeGrZkQDLrolP3rnuTqNP2mSpNCrgt0JfC00yAzoVCj2OZqmuNP4qNt0rsMNDFB3K
         cvFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790640001; x=1791244801;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kp5ei0/iKnj9mU7W/OT7FmtL2iwT8AA400ktoI4ALho=;
        b=wzppI7GC/kHeo+l5rQNpTtdsXpHc1whElJ90JLUCFoAkyAfxfXbiEs7LMyr+4emF7n
         DDKdoIuVRB7hzN1fzc/aMSLis2GONUJszwgSVfCGMVIvsLh7aUCGN7lBhWPrcpYUYUL0
         iC5kaXqR1o6VhFFVxYT6w/6qI7A33mffi36QqN+yeqEN5cyYsiMj39t318hazD5y8GEm
         VQ8cuUpOnwDC0hfo6uGYNS3D4J7GIpWprOfPWnOrqWhcO+R5iUUdjXE3dMN1i7OTLkM7
         cGc5kYgo52QmkMcAe90ap6/+tVwGn9tBJhBkO+RTcKBuBL1CI4cDQVroY8LSVNXxlKqd
         zhCw==
X-Forwarded-Encrypted: i=1; AKwUvBxJ+kiD7VDMQRJGz0AkJU3xriMqwot6XNOQ0fS1B53ROrqZAqaiU+hQo9VuJJVOPI0HQK62EQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYLG2jpIIn7yyUxqQ1YJWZNrSQBBhOh7rvAwiW/yJaHoFm72GT+E
	2zYYdF/NU6TSPXiNlJOTcloQkq3mWMAgtxljZdSPVxx3GvqJccSH6TDcSgn+GiNlxw==
X-Gm-Gg: AYBFou0HCCLcjJoYuVSUvOHNwGq9/8rvTl39AY78dniiOvd1ZqYnvFV4Jrfhpdb9BJA
	C0YHxrloeccVQDdtf9OP1l9Fpsca1nmHVZ3OP5OKlWrQM6MpJJH9itQqDdlphXXIoZSY1xiVyb/
	fGSaDDGYWxp+GxBX1kgqdoWSSvpifo2MkIm/k1i5gcy89hMyeQBAPVkwPy8/EcB5QQWxkwCVCHk
	eNEc0LMHCFrlt/0+HnjBCYJGMJUWMJQ4gIE0qUKRJEmqmIJmNbS5bXDF8hnK+/pGR4hFjJX2+xu
	Wrv3gMmc77GHLw70vKuZAO1rZbZ/mZg35S0bDz7dwa/vdmYITXmKcF5iX7oPwrpsiGfWW2GyABC
	kh5pmvpaRJTO7ggE2c8SpMPVtlErTQZwxXV/WkMKuhzp/frD5HvHSapw2MXyglH6+YOjelJmCxV
	EOhtcE3ItopT1nxyk6mgdckMRZ0nrQaz72AWBNhxn7PoAAmwsDKqNfqwKNJi1HZDYQrZXw4VXpM
	wjedkGYBE9344kwXwNhiiCBhNE1L5/RAUYb
X-Received: by 2002:a17:903:2b0d:b0:2c9:d89f:fd98 with SMTP id d9443c01a7336-2e2c608146fmr1652085ad.1.1790640000240;
        Mon, 28 Sep 2026 17:00:00 -0700 (PDT)
Received: from google.com (105.211.142.34.bc.googleusercontent.com. [34.142.211.105])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df91444797sm47124675ad.58.2026.09.28.16.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 16:59:59 -0700 (PDT)
Date: Mon, 28 Sep 2026 23:59:54 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, will@kernel.org,
	robin.murphy@arm.com, joro@8bytes.org, jgg@ziepe.ca,
	nicolinc@nvidia.com, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v2 1/5] iommu/arm-smmu-v3: Ensure L2 tables are visible
 before L1 ptrs
Message-ID: <arr_eqQJtOAIT4Pd@google.com>
References: <20260924085616.300650-1-smostafa@google.com>
 <20260924085616.300650-2-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924085616.300650-2-smostafa@google.com>

On Thu, Sep 24, 2026 at 08:56:12AM +0000, Mostafa Saleh wrote:
> Commit 6fabce53f6b9 ("iommu/arm-smmu-v3: Add a missing dma_wmb() for hitless STE update")
> adds a dma_wmb() to arm_smmu_write_entry() to make sure stream tables
> and context descriptors are observed first.
> 
> However, STE L1 table descriptors are configured directly
> via WRITE_ONCE(), where before that they were zeroed with memset()
> inside dma_direct_alloc() then written to abort in via memset() also
> in arm_smmu_init_initial_stes() without a barrier in both cases which
> means that the SMMUv3 can observe the allocated table before the
> written descriptors causing it to fetch random data.
> 
> Similarly in arm_smmu_write_cd_l1_desc() where the L1 CD is written
> after dma_alloc_coherent() with no barriers.
> 
> Add dma_wmb() in both cases.
> 
> Fixes: 48ec83bcbcf5 ("iommu/arm-smmu: Add initial driver support for ARM SMMUv3 devices")
> Reported-by: Sashiko <>
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Mostafa Saleh <smostafa@google.com>

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
