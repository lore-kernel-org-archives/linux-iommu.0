Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200B833E34E
	for <iommu@lists.linux.dev>; Thu, 12 Mar 2026 18:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773339855; cv=none; b=iNPT8rcbYCvb5Sw7ebzVZozhXZNw4F0kF4ka56vl4PBW5DjxlkV+qKnw0Kq06zjQYoE2l//sYuXtgw8pnP+YldJRFYJm7QMRdrfc+ZxOM85FDpInzwDwAzUBG31iDxmNnuDFHGZqk3HGVw6qeet/a+jvW7l+OBDAPAdOQpV5RrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773339855; c=relaxed/simple;
	bh=Js6uY4bNsBispB98d3geMz5Hc1R12taoRNTZmFe6UO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PR9dFaPE2sBRafYeLrBF1d+UV0Bz6cWnXfXaayz6BsJ+Wj3pLWtFjX2ekZXzZfbMq39aS/4mBfRkDfQnlUP5WQ7OER/Q7EhowJ7+0FkuyrKS1TrzDQEB8MkXUlsZoaeT/WPzG2Hb+PLkSKKtqrNr2PKdojdRrn2WBsHAVd3d1Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d4iIc3vV; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d4iIc3vV"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-82985f42664so867608b3a.0
        for <iommu@lists.linux.dev>; Thu, 12 Mar 2026 11:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773339853; x=1773944653; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MK0tVrkFlYhtOCZ0KvjIJMhJp307ZXYuWb0oUy4onRw=;
        b=d4iIc3vV3PaqPY3JhtEeXfeH4RiP3fugWc3WEn2Q0uLy5bDsc4/sbK+35NR7aRE9rf
         AFuEw13I8jDgIrpqPxJRKHGI7cfSjqpnCzN56zrlZUzm8WSsyVDG5G4j41J5lJMV9qpI
         VAwDFishqYwDO72du0vhXFgsGFUCjF606WDajkuyw1DE3lY1rMMrozYDxgHkwQckJ9Ay
         SnKqc1b3SK7egYYYXgL2xHtQrASc6Dw63RNvKyCM7wzA2DwVsUdsoegLCpc+zeh3Ot6J
         v0WsctknzP3RaLRiyYHdoQlpoQwG4aWm4ujIwYIdY6kSW7Egv5JFOk3fdB2fqPOYrW5z
         ysmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773339853; x=1773944653;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MK0tVrkFlYhtOCZ0KvjIJMhJp307ZXYuWb0oUy4onRw=;
        b=a5LMKbIiAgNcJc/HHOWd2roCfHjc1On6BnJtGVZKDJdEgbA6CVvmyrSFWypE87vRQx
         xonkcb2nBiZVJ8CjbYR4BHFBYbTrl7omn3H68J6kN5DI4EpK4Of56uSLxPK7kenXWZKD
         XX2gLTEh6DhDCTAHp8S1VUg1vlPNCyQEOl8XYiIlQQ0Klq973J+dRWNlM2S7e3gRrIn7
         F/E6A9FovY3gBZMd1xkRC3qFCdHnLaLg7+6PgwbSB4u3MSpLhm7WFMXmvNBlxToNBBG9
         nfBrk7efdauDJOxCXLac3zGeDpGjunTBMLAbh25PSurobocNIY2wanUWbcRMfGSpVa7N
         yOyA==
X-Forwarded-Encrypted: i=1; AJvYcCVo7SQrdyI/EFhOAa1SwrQPRcXtsY8rCGn7GMcFkG/8EMnLriOm7KB5nVhImGAV3zEk3Tg+4A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxaoyMum2jN/0q6wnIOMGCKnwiJiO5Pc5fCfdpylp9iwFpp6Sa9
	5OC2Nyg+M35Q0z69NN8EGKZBenO/2oEIxUkV8vRhZvn+UAfav8h/tXpG
X-Gm-Gg: ATEYQzwks81BXhVmihO+wLiE020LOtP5dWrvcS/MdGPrZvz4KmtBukFnsvTBT8xBR3u
	p9BXWwPJKf7wOflMsEyzwjDMEbyHp93b8KyWvrsDzLN84dGl/fPaTDDLZjFMe2OcuP8r7fq4jgO
	xJadpp2bp04Ybnpra0fm57JulKOygrk/tt15zzjtjPxroRVC6HjD/h72sdPnVpLiC4G3ZC8cSXW
	ZtU9bJCzPXi5mPfYGgDV6Yinmshy93lMhTGXcGcqfIFvBeYsBOF0YSTbzfryclATmBjlV17AKcc
	mwkD2dfP4tnPFdkghg+8GQLwlI+SkF4p1fUKrGWd9Y5eERzo7SLPRYN4l4YocjthjllzECKn7A7
	gFQvEqTvYTwq+X0nKdbNLxsNiPxMAnGUoQxK8eVMJ7jRraWkvo3678iCJjFjqsSffw8j5OYLf4r
	9PsmgA0Fh9NkOhGq+lDwdHLoIeRhVDTBP7Y192JFcpGl8vXb5l9TPYCQbPwHg5
X-Received: by 2002:a05:6a00:23d2:b0:829:7b15:848 with SMTP id d2e1a72fcca58-82a198d6a4cmr413604b3a.48.1773339853254;
        Thu, 12 Mar 2026 11:24:13 -0700 (PDT)
Received: from eric-acer (36-225-72-126.dynamic-ip.hinet.net. [36.225.72.126])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a0738528fsm3708429b3a.56.2026.03.12.11.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 11:24:12 -0700 (PDT)
Date: Fri, 13 Mar 2026 02:24:09 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: will@kernel.org, robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	jserv@ccns.ncku.edu.tw
Subject: Re: [PATCH] iommu/arm-smmu-v3: Allocate cmdq_batch on the heap
Message-ID: <abMEybRcTskHOjd1@eric-acer>
References: <20260311094444.3714302-1-yphbchou0911@gmail.com>
 <abF6un_jrQ8zGZZ4@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abF6un_jrQ8zGZZ4@google.com>

On Wed, Mar 11, 2026 at 02:22:50PM +0000, Pranjal Shrivastava wrote:
> On Wed, Mar 11, 2026 at 05:44:44PM +0800, Cheng-Yang Chou wrote:
> > The arm_smmu_cmdq_batch structure is large and was being allocated on
> > the stack in four call sites, causing stack frame sizes to exceed the
> > 1024-byte limit:
> > 
> > - arm_smmu_atc_inv_domain: 1120 bytes
> > - arm_smmu_atc_inv_master: 1088 bytes
> > - arm_smmu_sync_cd: 1088 bytes
> > - __arm_smmu_tlb_inv_range: 1072 bytes
> > 
> > Move these allocations to the heap using kmalloc_obj() and kfree() to
> > eliminate the -Wframe-larger-than=1024 warnings and prevent potential
> > stack overflows.
> > 
> 
> Thanks for the patch. I agree that we should address these warnings, but
> moving these allocations to the heap via kmalloc_obj() in the fast path
> is problematic. Introducing heap allocation adds unnecessary latency and
> potential for allocation failure in hot paths.
> 
> So, yes, we are using a lot of stack but we're using it to do good
> things.. 
> 
> IMO, if we really want to address these, instead of kmalloc, we could
> potentially consider some pre-allocated per-CPU buffers (that's a lot of
> additional book-keeping though) to keep the data off the stack or
> something similar following a simple rule: The fast path must be 
> deterministic- no SLAB allocations and no introducing new failure points
> 
> The last thing we'd want is a graphic driver's shrinker calling
> dma-unmaps when the system is already under heavy memory pressure and 
> calling kmalloc leading to a circular dependency or allocation failure
> exactly when the system needs to perform the unmap the most.
> 
> Thanks,
> Praan

Hi Praan,

Thanks for the feedback.
I agree that kmalloc() is unsuitable for the SMMU fast path due to
potential deadlocks and the need for determinism.

To resolve the stack warnings, I'm considering using per-CPU buffers in v2. 
Does this direction sound reasonable, or would you prefer to keep it as-is
to avoid the added complexity?

-- 
Thanks,
Cheng-Yang
