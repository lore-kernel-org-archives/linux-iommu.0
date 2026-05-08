Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B805D37D13D
	for <iommu@lists.linux.dev>; Fri,  8 May 2026 07:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778225393; cv=none; b=agCHtFpfjVGilkVre52U3/DDGLm61Mh24nSmxeD0x7cQL/QJROAxj2fawFlDkcWQACEsD0KerErgYp4wC4zLvTn3N/DOE2kekgCOS8z656pD9kpBF1EPgxfKcjnj6pqQTKKzG0yaoSYk8fGTrVmSxnMkQebC9uX8VNSrF6t+en0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778225393; c=relaxed/simple;
	bh=QA9hR0bSYIQ5D64x8sjWe6pmUWzl9IwQcukTQJ+tl4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N+6XEpEO5thZTHc1zBjlIwgM9M8O03CV28Tm/9H2QUtNherwY0jSA/jjI7X3cmyq3cxZH7pity1FAvyK45DMVfGSNitftV30RiMUxsI2PQ4sYTH/YsZCBtjiIwxXt/VA+T1u7OHQ1jXwPh30GcFyqRhaUOrq3mSCfu8Vc66Amw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KVuE53YF; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KVuE53YF"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ba3b9bcf69so54185ad.0
        for <iommu@lists.linux.dev>; Fri, 08 May 2026 00:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778225388; x=1778830188; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gtzgOVlx3+XiZk8bPWEWW2C41hmZeWg0/ZKf/2wFHh8=;
        b=KVuE53YF7yMwqCxUP5eDGRuofjiCkddWYBWzjsERFEA8UcrzcqjDC+nmgOU7J9ZZn8
         xsvlJO5hLSdJ7OXHywutl+x3TCZxa2dPRV/CXWKjsEkLm0pgYnjmbSxu9fMkQ4J1z4V+
         3t8AczqMsFoKdfrE+FpNx74GJmFLa5TrRFLjBHykhplhJSeWlGKR0yKn9ovfVw3E+Onm
         rl9vbA71f4ZrUbE/zPeJLP6kHfmEif5XtHBFrB6LYPasOhu7gYxHLnCxBEOpFjCOClQ8
         i7IqYBNvjrbv+tqAi6SGXaajXmSrxl94I4d7wLWdsxQrFT2jO1AEh9I1OLU8MYc6XW31
         +98A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778225388; x=1778830188;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gtzgOVlx3+XiZk8bPWEWW2C41hmZeWg0/ZKf/2wFHh8=;
        b=N0lTQ27wYeIquX+PcvJYF46UpA/7querV7TuiYBPwP4NJQCj73EfqKTaBqv7PIcCaK
         hRdhG4+fhs64durn/DByndPSEhUVpdnJdN4eacbiRRGdqwDEewYt3zP/pXNC2bbJ/LaN
         AjM/tVNFDcjJYVnRf2paI7glFit6AaXggILt3ivVsavItxmRMqeMIBrYfLWJ9NaMRxtc
         Beht0UDv4zX599axbzEW5jlEa6C6euSovLJi8vUjoFONCoGyx7vBHKCM0zDdnMvzOGnk
         ZIbfXe8rKTjFaLkbXPa5UFxVGACjRWqgu1uDvXYtM8FJRi3A4k91gb6eC7HZa9tuvkvU
         fATQ==
X-Gm-Message-State: AOJu0YwgpxbDHh66u1maqt6HdEU+SBcH7ZzXgmhJyhhJKjkI9WqUcHLM
	wIqKOjTN/xWJT2xpKlc8oTcl6UmGWgs2iV/Sp61fegmcTWjBYQumZxTFTd/P40O8VQ==
X-Gm-Gg: Acq92OGiDenZ2VAdaPoz6iM506GWxwQy9TGRVBbLgc4HzHZY/PidFh6WYXUBginKhKq
	+DY0IKoEp+VSfaKFVHbX/Sv6JC8iHpz4Z3m6UigsjgUQYP2D2Txakt1lC6nkni4rm7W9o8g0rM2
	xYcXxx0Js2HFjT07vXhjXmlprKEjMzJwXA3JWoO7xRETCra4+IFsLYfXm84IBo2CWb+rF0lOrdh
	2mHRXQNzNg6HAUh14lFzeectnjBUH/9u6c3Nm0dGB6fVtPCJqUG5Y7ersYEEHgWynNyoUDWqmRZ
	Wp318O7EaoNLBKLvtgs3Gq0C3l082igqjt8SGVq0CSwd5xTLXQCLCL/Xqyl21OXB9BeZDbgSm3Q
	tTvg5uQEIUQpvdc4MxRIZnOOg0f2gKvOFu6YV2XgpdeLVTwrAC9kRjOVZ0fsIY5NSi0H1BQVK3j
	wDepfUljyJ1DdVIOiIqDoQthu+1OlfVv5D8CzaU//H2LLQ1BBqyKY7uS3IOxtpQ9mBoDcT
X-Received: by 2002:a17:903:3c6d:b0:2b2:70ba:305c with SMTP id d9443c01a7336-2bae9a8bf41mr2914125ad.8.1778225386989;
        Fri, 08 May 2026 00:29:46 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e9fd64sm10355055ad.69.2026.05.08.00.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 00:29:46 -0700 (PDT)
Date: Fri, 8 May 2026 07:29:39 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Jonathan Hunter <jonathanh@nvidia.com>,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Krishna Reddy <vdumpa@nvidia.com>, Will Deacon <will@kernel.org>,
	David Matlack <dmatlack@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev,
	Samiullah Khawaja <skhawaja@google.com>,
	Mostafa Saleh <smostafa@google.com>
Subject: Re: [PATCH 1/9] iommu/arm-smmu-v3: Add struct arm_smmu_cmd to
 represent the HW format command
Message-ID: <af2Q47MaAECnRzvY@google.com>
References: <0-v1-b7dc0a0d4aa0+3723d-smmu_no_cmdq_ent_jgg@nvidia.com>
 <1-v1-b7dc0a0d4aa0+3723d-smmu_no_cmdq_ent_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1-v1-b7dc0a0d4aa0+3723d-smmu_no_cmdq_ent_jgg@nvidia.com>

On Fri, May 01, 2026 at 11:29:10AM -0300, Jason Gunthorpe wrote:
> Like STE/CD, add a wrapper struct around the u64 array to represent the
> already FIELD_PREP'd command data. Unlike the STE/CD this is a u64
> because the command submission path will have the swap to le64.
> 
> This makes the API clearer when a u64 is referring to a formatted
> command and makes the following changes easier to follow.
> 
> Move the command constants out of the struct and into an enum alongside
> the rest of the constants defining the HW format so the entire HW format
> is self contained and independent of struct arm_smmu_cmdq_ent.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
