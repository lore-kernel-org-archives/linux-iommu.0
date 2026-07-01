Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBBF401491
	for <iommu@lists.linux.dev>; Wed,  1 Jul 2026 09:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782899938; cv=none; b=ZSOr3kcRKzN8lZJLpQHpsLNSEYIIVwHBZuAZjaxWqOxSw1BAZcp0HavNKiVT3jylHhqJ4sw7/vhCcusDJ9VYOD1K+zAiaDTyaYrPgQQ9fCNNayq7WDcrq6xRFDsiHYv0Q2xfa5UxoQsz5873ar+vye8JMvjuSFiAXlJtVLpbTis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782899938; c=relaxed/simple;
	bh=v7yW10N5rdbaNr0AbgfvIKAE851swmfImkTSQtp0FiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DRY7YxwT705v6sEljihnQHpDyjAugnnRxAnzt0Xyof2oEy2Ns4AbAqFAMMgWqrPhbW5mmPQg5eeIAo/sej06ETAAFhoeW6EXgdyrq8EDSJk70eRupTROnRJftavducK2MswpYBWj6WCZI4CqCn55DV2tspfWB1Lf6nDpLkPuahU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OLP84vH0; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OLP84vH0"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-493bed621acso47215e9.0
        for <iommu@lists.linux.dev>; Wed, 01 Jul 2026 02:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782899936; x=1783504736; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7aPPO+1CYD+YBwvwpYgtZJkmXkRW2VjIt/FwgJ0T6qg=;
        b=OLP84vH0Kbrtve/0YR4uMxCFr67aKk2fwY/7W33ub4DPXIv3jnPffHK8efTKJjS3bu
         C0ooeEM1DSrev5sGnmL34iJ6pVd+J4TJ08GQx2mhct5YDtWqADfHs8imR1gU1c6V8Adt
         M1vcWgwtaMPemRhSwvnuljkSEisOygxts6eZOcxfp2yJcMhDnzMh+WO/ZTBEY3Jf2X/1
         NQ0AaVcOv+ES6wdLpjD1RgukiMw6qaZzUPRuY9AAMTEfJ/srRVJqL4eifhJ50BqmJoPf
         A8RRvkyykrDkm56SBsFh9UEV/3JHutMtghv0qd1/NrqZRjG30zitsLzSaXGL+nBUESfL
         viZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782899936; x=1783504736;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7aPPO+1CYD+YBwvwpYgtZJkmXkRW2VjIt/FwgJ0T6qg=;
        b=d3Xm3jkq+QpqFgi/AVNo8aGmPB+KTgx7iSbKulfYp9i2MY+nBfyyPgxu1iQNY1Jv/n
         CiXkyn9xMANGV+oCyhb70cS/UlSSWtr7yab9w5Q/xSf4EISf4pRYWtBPX4pKWluufhB0
         DS4i/x1BeTcmf/3EHe7M7HujOufg/jVpeyheUwYZ/55I/kzWrwBD2+ptb304XfgMq52y
         hmDLavrVkUKnWMvtLsFXGlXgoQm9KRj/38DTFHaMHA1gX5RIVvhXnVCIbS3UZ4bN+u4z
         MVfaTUzfz3a/Lt0BMjDfZ3kYViAUVCqCmhfb0hSvTPnGwOwy7B3YMksbFAwWBnJ+gPCV
         kuMw==
X-Forwarded-Encrypted: i=1; AFNElJ8HQWkVMmgXyOTd8PmOMeTTntU4RS21G3XuelXM6mAmcu3GRDCprr7FKCG5Oyy7h5v6yF7qtg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzPDnSfzYLMf0BmeBT1/B6KCHS09WXHcARCH/Zg/7wi9fcswcD1
	SzEP14BdqPedVm23GOjjmxdzoMTuNoogQkW+ERycF9An5SlCLVZzZ1BjP8EsUyWM1w==
X-Gm-Gg: AfdE7ck96xqUQQt9WzfIffGXiuE9iy8BsG/nuZgFXs1cjbo5zz6yYtKjYc4dxsT5BDR
	7Xq6JUPYm0wN86Tm+WGcg1YLCl6lbjm2PtXIhqGBfDNyuX/W4XSa8Eko65ZfqTUzqPNzp28veFH
	Wbyj9luHfLvEa9cJ1IEwuBVXPgE+j44S7mTwxHHqT4/yoz+zFm1gtDDoaY5kg2SvkUzZ8yiONbK
	KmknZ1RgAFqs3urIPNekOcfvjvyDsVcuYf4jJVELm2suWb2exxMt36zJw/ACJDw8bVZnSLudvmu
	qXTFK4i1Zd30ITCFzpQd6sLkr3NAAGFv4Rggr9UgeEQdjmfeFR/iDpd/PhGm7cT4d/B1dQhlBkK
	LRdozgNeV5ZTLbEZBkGlhTRIcLhW0Nz1M0vENe8rTBB2wr5ci29qrlSoDAR/9rC7PKMJGAZ829D
	vwF/holBAk5dYRNhXocVp60Z8lD0C2aDqkfqa1FnDML8nw9IPJAjE=
X-Received: by 2002:a05:600c:22d4:b0:493:b47f:a24 with SMTP id 5b1f17b1804b1-493c0bcab48mr503405e9.6.1782899935171;
        Wed, 01 Jul 2026 02:58:55 -0700 (PDT)
Received: from google.com (140.240.76.34.bc.googleusercontent.com. [34.76.240.140])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493bef17c82sm31881885e9.1.2026.07.01.02.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 02:58:54 -0700 (PDT)
Date: Wed, 1 Jul 2026 09:58:50 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, jgg@nvidia.com, joro@8bytes.org,
	praan@google.com, kees@kernel.org, baolu.lu@linux.intel.com,
	kevin.tian@intel.com, miko.lenczewski@arm.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	jamien@nvidia.com
Subject: Re: [PATCH rc v7 0/7] iommu/arm-smmu-v3: Fix device crash on kdump
 kernel
Message-ID: <akTk2uM0Kat4Jvrg@google.com>
References: <cover.1782799827.git.nicolinc@nvidia.com>
 <akPB6l-fuJUcg4a2@google.com>
 <akQYpCdwGnpKTnjN@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <akQYpCdwGnpKTnjN@nvidia.com>

On Tue, Jun 30, 2026 at 12:27:32PM -0700, Nicolin Chen wrote:
> (I think Jason has answered most of the questions here.)
> 
> On Tue, Jun 30, 2026 at 01:17:30PM +0000, Mostafa Saleh wrote:
> > For example, patch 4 disables the EVTQ to avoid events as there might
> > be a lot, why are they not fatal also?
> 
> FWIW, the PATCH-4 doesn't disable the EVTQ: EVTQ is disabled in
> kdump case prior to the series; PATCH-4 just makes sure it won't
> get enabled transiently.

Yes, I meant the patch disabling it even transiently because of DMA
faults, which was confusing to me because I though they are fatal anyway,
but I see Jason’s explanation now.

Thanks,
Mostafa

> 
> Nicolin
