Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C6933F38A
	for <iommu@lists.linux.dev>; Fri,  8 May 2026 20:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778272519; cv=none; b=tvaSQukxMvpvnwjg1PxdGCphNXLHk92qYNqCtWsvG86NXvnwGmO2APJPuCgNK/PREB+1YqmHQULoEydAe4J4HL549YFdDrC8fo+7Jo93DVQrlQXUp7K+zZszCfxYX1VGz/ipzJTHHPuWvmX2kLIqc/viDvkz+DII/mwdavr/pbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778272519; c=relaxed/simple;
	bh=/RXh760jgpmBXWYza11o+sjayeAl1AGvqWbQvG3+uvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PcTGf21D9Ob9ynGMCzJmXVkVz/qIhGF/UiTsK9Sf32X2QR0mZ3pQJv0IEjxAoEQrAgU8jiOEbjF9w+QgITnXtJP78PTfCihOoUwOMpUMDbv1YYmv4JdVHSbGwi779Ulzcq47LjnRVmMh+YyzPcPOvR8kNZGeyCCsxhvHYBQLjdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oG17tuWf; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oG17tuWf"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso445ad.0
        for <iommu@lists.linux.dev>; Fri, 08 May 2026 13:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778272517; x=1778877317; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/SXlitbk32WOyBlu30f95rRaQhj+JA3b3XmJB516F7k=;
        b=oG17tuWfYsxwiY489+TIweoPnQpb9KQcuVaY6NGJE8yJZeg/P7xul16vR6VqS07wjH
         OolhszmXXiRAfCKsIi5DCFP/DZ9qx/JWdTcMuECXU8cIY7Ga7rz1QHxuPmDqlWboyvch
         0bxU0ioLdx1niAHt/WrNfGbIcvB02H41d3SD9ra/9L0YFXWnM7xugolTnleN4RJcUe4s
         FTCIZrzRSo5u89k4/Xv/ikEIAxbxhGZK08X+iz+A1ePaQEAnqYHv6a7mO7baFOULkqi2
         R2WcUmkr+Vt7Ief3rs9PRPjNNfgufKQeiM0ilHEkX3t7qm+qJn7t/5kKJ7KYbrezNwu4
         o6rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778272517; x=1778877317;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/SXlitbk32WOyBlu30f95rRaQhj+JA3b3XmJB516F7k=;
        b=b/vADaw6N0HqZ5HZSG/hqaeYS0zbLfdngy696sMIyfJc/+IHI4YMvppwVfwcgVqUXS
         d2utme4B5qodyvhjz8mf0gq9OSoP4z9LrfP2BbfBHkcG0wxCavirDslm/UjevRIR8kXV
         i1diZp8noCJtxkz5nql8gNL4dTwcRVzZ3kNuSdFJCJmKo0RPSWpzBCgEhCYSjw2zay+y
         XoaTOU70i7AOdjPl8duSPlD1JaebP/NvASfggc7Q1b5ZEWG1t3uTKSvKqo+/Uqo7Xpcs
         cWKK3AKScVplN5GhVZKA6XRz0Bcog3TcGaeuz/wfvp3haOmFyJvoiboke8Mqve4n5e24
         64LQ==
X-Forwarded-Encrypted: i=1; AFNElJ+GKEo5g05TZRlnnkO1gT57M3qzlqJO+p579g0KwUhLgg/Xpa2DNihwl+NB4AIDcoysD6Kqww==@lists.linux.dev
X-Gm-Message-State: AOJu0YylPMnf1bcX/R3zmUJgdel3DSNyYb9Z69Pi16dv1GWTME9WZF44
	zpG2pa7V/u/hRgwE8h4kYS+zEIQFIHaTWeArnp43gWlEhWqwrIKwL2Tsgg44akXVnA==
X-Gm-Gg: Acq92OFwcJgwtvcduUNbj/WaDDKfcyI6Vnb5gg5K3jHyzgC/+Wlk5bpjmeOPEPvKqMT
	+dwzILyRj2XqZeZzIUDyyi+UwQS/mqsyRBThLo25hmLGtQBA7aEv2lYCBAsenPAuu7AdjNccDFo
	PVEJCRGjadSJsg+LSZDPMUdraGJ1DoaL1h3UvzB28e9BEeXn4NXzRi/VM+CO26M9TCHfOtAnDVn
	USVMBkzlT1kfMBbBo03DgHnf1BER0+zGD64qSQiC4+2gHYchA/VX2neG2IGLXyg2jR22+X1ensi
	A/tG9R+oXL9UV0iSBFuYObu2TLDTB0UeXSZ3k9WA/ESyFtQOF+nrGJkLpejQzY5SkpbKd5Hgs6w
	ozwRy/GGA1fkv4cQIoTIm4Xj+jU8HLj4dlabJe/yLOAThbPR4lPMKD4mU8QW6A/7idDU8hDqlI9
	8ZjmxikGKXlcUolsbQ0lHTCBv3lWPmCeyUfr+/RJ0ksJ2DLvunrsIzs/6VVYdgmocb1otE
X-Received: by 2002:a17:903:3884:b0:2ba:30f:33e0 with SMTP id d9443c01a7336-2bc747f25cbmr741565ad.20.1778272516852;
        Fri, 08 May 2026 13:35:16 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-367c1f48517sm689352a91.10.2026.05.08.13.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 13:35:16 -0700 (PDT)
Date: Fri, 8 May 2026 20:35:09 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>, Albert Ou <aou@eecs.berkeley.edu>,
	iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	linux-riscv@lists.infradead.org,
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Tomasz Jeznach <tjeznach@rivosinc.com>,
	Will Deacon <will@kernel.org>,
	Andrew Jones <andrew.jones@oss.qualcomm.com>,
	Fangyu Yu <fangyu.yu@linux.alibaba.com>, patches@lists.linux.dev
Subject: Re: [PATCH v2 3/8] iommupt: Add PT_FEAT_DETAILED_GATHER
Message-ID: <af5I_Xps4Ma-qUDx@google.com>
References: <0-v2-b5156f657dc1+25f-iommu_riscv_inv_jgg@nvidia.com>
 <3-v2-b5156f657dc1+25f-iommu_riscv_inv_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3-v2-b5156f657dc1+25f-iommu_riscv_inv_jgg@nvidia.com>

On Fri, May 08, 2026 at 11:53:02AM -0300, Jason Gunthorpe wrote:
> Generating the ARM SMMUv3 and RISC-V invalidation commands optimally
> requires some additional details from iommupt:
> 
> - leaf_levels_bitmap is used to compute the ARM Range Invalidation
>   Table Top Level hint
> 
> - leaf_levels_bitmap is also used to compute the stride when
>   generating single invalidations to invalidate once per leaf
> 
> - table_levels_bitmap also computes the ARM TTL for future cases when
>   there are no leaves
> 
> Put these under a feature since only two drivers need to calculate
> them.
> 
> This is also useful for the coming kunit iotlb invalidation test to
> know more about what invalidation is happening.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---

The conditional gathering via PT_FEAT_DETAILED_GATHER looks nice.

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
