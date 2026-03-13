Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605F338D
	for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 00:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773360378; cv=none; b=ocli8DdV+/I+8gZpuXD87ZsET5vCPTnVCckaeYyvdJZhIpGMJyH6HdNQoDEPlwLQmDCPALUibci+RVU29OH3TMZxL50+w1K9ESNfxGaVnxW1VyWxFxqCHmOQvvj39l/6V5BRtCtpkf6KCi/7A6345no23peaFWo/DQKgzi7CynA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773360378; c=relaxed/simple;
	bh=eL5LvsGSGGSF2l9zq/UUkqKXKd8XDDntfZQplOnA3bA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WzCGiCr9+sjW2JL6qJP+nc8my+Z6xbj8SIgmeDyDKVFtXW2SjPUxHTqS89v1gsLZf4ll/KMpoQlQy29v2OlWTWTq+DkIqS6qRi7huNy31B9/CJmxZt4GsWxYAXL1Sv/RZDwWVlrVGcIMLumB2ch9QH+kMJfG5nnUcZPX4uH+pWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KwS7uULv; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KwS7uULv"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ae49120e97so37265ad.0
        for <iommu@lists.linux.dev>; Thu, 12 Mar 2026 17:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773360377; x=1773965177; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rlyxqPtomMiWV8bvIDXbVAzg1cPg4HdEZJgURcgSvqU=;
        b=KwS7uULvzs1W+igBIqx+iTNCbWast898O5KGEAvHPUD+itNI3kdePyL1HSVYUdEjDs
         NDYf5c68zC8DV7K1KcN0ruUwrL/9L1Ynj7QazBswKcQmNflTRR9p0TqPVyMhBjuOt7cS
         VXsG/EQ0BW4qioFeV+4np9pdZvCiZcHsIVlEzagSNE4bdr3AUjYA1SoXfcGEfagHirew
         3jdyF8AFkqmv0lqAnqfcsaxqcMqsU0TItx2sKSpYLADdmWHSryxxmjfOiLfY1CWg/kpu
         ciELbFfmOQKNej9RhGCVELR+//sT5dJLQOzWe0ItzJAwXr66bzjgvzcd8PR6Qqn2G59Z
         Zt3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773360377; x=1773965177;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rlyxqPtomMiWV8bvIDXbVAzg1cPg4HdEZJgURcgSvqU=;
        b=mQ1s3KvRCqHyYqefZWgoNpwgYP2WhyZDE/5Is/XjOFfhLbsnb5jmhYIh4c/n7/ivkY
         67L7Tbbxa8RiksBDu1WFQMre22wJ1eyuqzkH1bALZ4d8rgD28fudwGE0gWKbHpp6m/NG
         U8lDZUcNTi3XTJXcxWkuxSLPKYE3LP88JtjOMxDYm/TYHq2EKydHK07o6FBqgpl3PVbD
         +Szwl2DP8b9CK6H/hOvJJlV9dwI65+fJYaimg4/hpPTmC6r0ZgIXxzMxsMNiLzOusIO0
         EuDMzgwHQ6dtXnTQZAoP5xv4KWJ28bKExJ0D6P2Za/gxQhvLcSoMbV8+JLWh9jdmJ2h6
         qZ9g==
X-Forwarded-Encrypted: i=1; AJvYcCXz1oYV3v0rPg8EspSjjTAZ8WE3vmRGHwzePtco/rlM1ulpv1kUTWY4dSM+0CJtb8djgXWJBw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwIq17ShP6wTmeolR7uMKJSzJO0reFzKwDoENY1k00nJTOAdvwP
	VZovGOYBy6VvMn7Q7L0s5AJVcCINMkUAO4dMcj7AGAdLc8eJ3ifxqxmFNipne31rVw==
X-Gm-Gg: ATEYQzywXpSXS5RVFnnoSqR9ZvDrFk+IeVCAoPkJS1nhUHdZ9z39CPT1OZop6AgpFlY
	EfhdXwog9/o7F2hq/p6ekJcsIccq+ejuYOQ0LSoQgb3Pzwdn1tZDlvTeITV3mpQYte+Rmc6/KFr
	sNBccEcIzc8x+A8LwzEF8zyodbTTjV+oqsaziirFK8S41sWzH1FcrEiYo+aqy2XwukHea0651WV
	dvrt4OTx8YN4r8W4vrPE1zZnljuTp6gIstwBpV4a9mjs6g+VmoGQHkJ328ftYiN+RWtHHZlb3iS
	YBd/tKnIgvpczBK+6RbhnApRewd1arlcSg3sb8L7vJBQVU4Fz77c8J8Ki7gTYFFQQ8Pya6GO5nf
	7pLg7EvTxgIMOjeRu4OsdE81wLTkMk+g5aiwDZEPUekBE8N4WKO/VskrOKutqQphTaHLFbTo4X2
	VLOCUk8CQgZ/5rH2aOPAfe2bcHDmqSElqEHs3bRaC5wsu2Z0b7HdFXTfbV+VDlczttRw97
X-Received: by 2002:a17:902:f682:b0:2ae:45cc:aeb6 with SMTP id d9443c01a7336-2aecb498009mr1332885ad.6.1773360376014;
        Thu, 12 Mar 2026 17:06:16 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a07370353sm4849098b3a.51.2026.03.12.17.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 17:06:15 -0700 (PDT)
Date: Fri, 13 Mar 2026 00:06:11 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Cheng-Yang Chou <yphbchou0911@gmail.com>, will@kernel.org,
	robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, jserv@ccns.ncku.edu.tw
Subject: Re: [PATCH] iommu/arm-smmu-v3: Allocate cmdq_batch on the heap
Message-ID: <abNU80PsHwwk3ETJ@google.com>
References: <20260311094444.3714302-1-yphbchou0911@gmail.com>
 <abF6un_jrQ8zGZZ4@google.com>
 <abMEybRcTskHOjd1@eric-acer>
 <abNDK/d/8CpLhcyb@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abNDK/d/8CpLhcyb@Asurada-Nvidia>

On Thu, Mar 12, 2026 at 03:50:19PM -0700, Nicolin Chen wrote:
> On Fri, Mar 13, 2026 at 02:24:09AM +0800, Cheng-Yang Chou wrote:
> > On Wed, Mar 11, 2026 at 02:22:50PM +0000, Pranjal Shrivastava wrote:
> > > IMO, if we really want to address these, instead of kmalloc, we could
> > > potentially consider some pre-allocated per-CPU buffers (that's a lot of
> > > additional book-keeping though) to keep the data off the stack or
> > > something similar following a simple rule: The fast path must be 
> > > deterministic- no SLAB allocations and no introducing new failure points
> 
> > To resolve the stack warnings, I'm considering using per-CPU buffers in v2. 
> > Does this direction sound reasonable, or would you prefer to keep it as-is
> > to avoid the added complexity?
> 
> I don't think per-CPU buffers would work here either..
> 
> arm_smmu_atc_inv_master() is used in a preemptible context, while
> arm_smmu_atc_inv_domain() can be called from an irq context.
> 
> Think of a !SMP case for simplification: we only have one per-CPU
> buffer, which is not enough if an IRQ preempts the task context.

+1

> 
> Maybe having a smaller backup array on the stack that can be used
> when the heap allocation fails? Still, I don't see how to address
> it elegantly without losing some of the performance optimization.
> 

A backup array is no good either IMO, stack sizes are fixed at compile
time, the compiler will still count those bytes against the 1024-byte
limit regardless of whether the heap allocation succeeds or fails. If
the limit changes tomorrow, we'll have to adjust the "backup array size"
Furthermore, for deep call chains 'smaller' array can still be the straw
that breaks the boundary. 

As for a pre-allocated global buffer, the synchronization and bookkeeping
required to safely handle re-entrancy between task and IRQ contexts would
essentially require writing a custom allocator inside the driver.

Falling back to code paths based on transient heap availability also 
introduces non-deterministic behavior in a critical path which must 
remain reliable when the system is under pressure.

I'm still open to suggestions in case we're able to come up with a
solution that keeps the unmap paths equally performant and reliable..

Thanks,
Praan
