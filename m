Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3C547AF65
	for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 14:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784038851; cv=none; b=PqHYUGef9A2Kv1tCICnqiTaT3TQ4AYR+arocWhVdpLw524YOpDGBy1NcVTg6Hr7liYGYIIVmx+lnjPpTx/bEWN2yo9+enFTakGFakXQek+IBHL//UUBlYSW06EAv/Bh/GUElfhukLHuy/VkSx0W29TcQ7AyXpEpldbQcuaGyj/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784038851; c=relaxed/simple;
	bh=ADFj06N0oqMVyrdNJZj5pfnva5x2yOwJyQdtFUKGENE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CCvIJQGi6tskT0NRr61JgS8SU1PGWqBU2GF5zQpoKQK7r/g3/f68MybCII4cqvpLvepTMJC8wI+sDZW8X4QjyPsw65E95bgctuxlZiwIi6KMW0+fgx/QmGKa3L08VQOhVPjMFg9yHHdo8oMRJLrxx4CYXrvA7NTyUTEmO+TtBHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XnpT5tmB; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XnpT5tmB"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cacef7d299so133975ad.1
        for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 07:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784038849; x=1784643649; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=q8PI+jedvflyq/VB7m0YvNOqkrFrLjJK6JjkfGkp2tY=;
        b=XnpT5tmBonYv/4Eua4QwtTR9KHywjAwBx1ibnWjGsWHUwARdwctz2TH8uc85+POduC
         Un3MviMAEEJMhXf3JVSf69GvspxpVT8anK9IZwfYVpXWI62p4IN3xM0XnAdTDMXkWW0j
         awucFVR+2gO0NWRceE3uf9gvxa2877/cYP2LP47l6pJ/T33XQvlVO5S5TzQlkNJHjb7k
         qxA18W671jkBiiJyZUcQC8VTwW69atKXJh7GzyzIvLmrxVY4TC60atwYYlNglyXmSJx2
         +BA+LKqgdl8ikaM2LhI3FpfoQh6ru58wgyAkBaXeRkik55dVgkFGR7XjpYS4USH80MSY
         zSKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784038849; x=1784643649;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q8PI+jedvflyq/VB7m0YvNOqkrFrLjJK6JjkfGkp2tY=;
        b=tGNXYEUAGcaZsfFS78G3AWZkFaZOKa+u4CBI0ZpO2e6+HffCXuClCJl8XnVt+ytNdY
         Vo2Z7gA6iQT3+0+SQKMgCF10rhR6TWPs/ts9IsbfCF4KwAdxR5aw7wMvpyl9olY/eisT
         taps+8bnMSBr1us35kFUg/kDu8Jp7ghrRc+OrglmDwdaL1V8LpF2IOXDyA+VB+yeYqqX
         ucnSbEf3yQJJOE0E+tSB0mYfvFp+h4sbCxAcQ8r4L+OYBrw575Up+GIQfoc4c9BHV15s
         rBtYf5eFEIWrmFMUS44QfhTN8dEw8kO/BbHRtyl2igCEDD4TBWs8QwVYfLWq+sv35sGY
         FbQg==
X-Forwarded-Encrypted: i=1; AHgh+Rpmy0qi1JPga7ksBmU0EVniwgmW5xzJaywMtOuVY5uSvOSrxxHi/AqnA+lLpUxoycFPceDskw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwijkxafP3S31afCJIJW2+Pzzr7eq++O8lGOL99nFrh0Bxkv97x
	TGcd90jehvXQYvQjRkXgt2QXPP6qViiS+BepAfpc/wujeeSJudaL3ERW2ld1Z3ulyA==
X-Gm-Gg: AfdE7cnJdy++8YVojqRwYnBhhC89ZUS7YIpQv26zNrJUApUS7jr83X+sw6Tl1DhJNH9
	5vvrW0v1LREgVp+cwcehW3k+5RRl8wlutuAz/z9Bw0KURlz1QYd1kRTqGI1PN4FZr54Fp9Pt2DE
	5Gu+kEE2yMOuhucP8USqQRcMt0n2dNxhukTxcO4kL1fNPEktDAXXcNy0W65z7XvgkvyRRQbLWSk
	Xo1qBNXgf+SOH5yICcN37UDFr3JlbgtEapcrKrw/Nuo5qFmpFVUAINosPJS8vai8cWq26O0sxjS
	qF3YdXfB84HymYictC2LSYSlKF6TMxDF35qryieG9IDvn2cRelI8793Blna6G1zF2y/vjjwtoEO
	0YVfUzJr5cgkf/MdMRioWFmDVI6UU9QG2PUB9BAdHT+9LHIzdu50S5lnV8H18MUhthu0C+/5onV
	C23KN9uyhM0EJh0ZBUSpVqXsjiIwFMbALJoUGzqBDZ5AHYnp8=
X-Received: by 2002:a17:903:26c6:b0:2ca:be81:b469 with SMTP id d9443c01a7336-2cee1134f8emr5728555ad.0.1784038849054;
        Tue, 14 Jul 2026 07:20:49 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f2389e8sm1590432b3a.8.2026.07.14.07.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 07:20:48 -0700 (PDT)
Date: Tue, 14 Jul 2026 14:20:43 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
	Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
	Kevin Tian <kevin.tian@intel.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] iommufd: Fix vDEVICE allocation lifecycle bugs
Message-ID: <alZFuwNz0RCcqawZ@google.com>
References: <cover.1783311134.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1783311134.git.nicolinc@nvidia.com>

On Sun, Jul 05, 2026 at 10:36:08PM -0700, Nicolin Chen wrote:
> Sashiko flagged a few bugs in how IOMMU_VDEVICE_ALLOC creates and validates
> a vDEVICE on a vIOMMU:
> 
>  - the core publishes a vDEVICE into the vIOMMU xarray before the driver's
>    vdevice_init() runs, so a concurrent invalidation can reach one it has
>    not yet accepted;
>  - the undersized-vdevice_size guard returns holding the igroup mutex,
>    deadlocking later vDEVICE operations on that group;
>  - the Arm SMMUv3 vIOMMU accepts a device without exactly one Stream ID:
>    an out-of-bounds streams[] read for none, stale ATC/IOTLB for several.
> 
> Fix each of them properly.
> 
> This is on Github:
> https://github.com/nicolinc/iommufd/commits/fix_vdevice_sashiko-v2
> 
> Changelog
> v2
>  * Add "Reviewed-by" from Kevin
>  * Patch-2: Add "Cc stable"; drop the out_release label by inlining the
>    xa_release() call
>  * Patch-2: Note that the reserved slot is hidden only via xa_* helpers
>  * Patch-3: Return -EOPNOTSUPP instead of -EINVAL
> v1
>  https://lore.kernel.org/all/cover.1782767110.git.nicolinc@nvidia.com/
> 
> Nicolin Chen (3):
>   iommufd/viommu: Release the igroup lock on the vdevice_size error path
>   iommufd/viommu: Publish a vDEVICE only after vdevice_init() succeeds
>   iommu/arm-smmu-v3-iommufd: Require exactly one Stream ID for a vDEVICE
> 
>  .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 15 +++++++++++++
>  drivers/iommu/iommufd/viommu.c                | 22 ++++++++++++++-----
>  2 files changed, 31 insertions(+), 6 deletions(-)
> 

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
