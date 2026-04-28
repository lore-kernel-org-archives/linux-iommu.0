Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE2144B696
	for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 13:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777383406; cv=none; b=Up6pBWTSXlFtN0/eZaS7gZaqUjLPWUTYnNLivRuIfpAdDX2VCA7Y8DCle3/rJ6r2w5GFhWWq4vXPtetKo2a05QOie0nii+1o24HeVqCdwtPw592ZDJn5fuUIfmN7pzDEnl8RHSQl9lWbwjF2g+kd9VUeyBCBktkxzszxgZG91s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777383406; c=relaxed/simple;
	bh=esToKOeJowsAkTTeyqSbmSIgmhGnHRhb2YdBS1u1Im0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aIeEjbKMxuEshGauUb7dAViX7X1FmWn7jAuRRkFVhPHelzGZ8qlfUZINBm3oJyY/zFs+3DzjuC4ofOaunMLqmxYSqoy4C5nicELLJSW7JlOgBnHxBeQkv/jAAEOKX8Eu22KlRblaMk6UkZy8cF8NOdwOgRqFjFLUYuQArfxdvxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=h9kio74k; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="h9kio74k"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8ec37d52c0dso1181058585a.0
        for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 06:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1777383404; x=1777988204; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eZ19NsW5fr6ajdZR5D4lYg3z8k9sQDPcT96d4+jJChg=;
        b=h9kio74kgageoD7BSmetnbmGxxwx3X31FstBnA4akCUp7EL+fD7F7Vn4q4iDhTeXeA
         oxqI21mr1sPTto/Ujb0oPu8lKvO7ExXzHdhHqpGz7Vpqx8CDbNsqrJzhSDxj512BPNTC
         9wfZz1k/OZMeodOtDWkqbbxRNdCTMDxZJyfBGv620hIrrtss0QanccVmt45igAqXOaGB
         xFIKQVQXq/WlAmSdh27vf3FmPpossgF2lkTHvcxrmAiMxncP1OxTmwXXxtktdWfXRAVU
         bMb09vZFARAlVfNX1Qe0ox5Uy1AX+sT+tasEiqO+jqBPROdkFmuknLd0/6PRjIQIX8Dk
         ikGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777383404; x=1777988204;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eZ19NsW5fr6ajdZR5D4lYg3z8k9sQDPcT96d4+jJChg=;
        b=cyqGvfVZsq7ADTIIc2Gf+unhHTi8wmbbqjGxU+Jn0CRmlkJPMzVLkseo2pO3yJeOfI
         opcPzQ0tqVcNBPW/o4N0mjoV6b0LM8KT3iRxBWmHo1AIHdamg+zzW92x6ckODrF7OHHA
         +k574g27gnm4MGFHm8ONoTxApyJ20TzGNPjy3woBaem2QO5sRiJoJ6+sNSvYoyKhygbB
         mnNUeeZza8YnHj6+rd0ji9CDT1Ia7ryUQh4be343pNCepcfxqKnRdjEOPUD8AueWZdwg
         xlzeORIQ4OvE+qTrQDrhYIHiiKO0iM5NrOgAoL4h8uK+cnEfRcyHMLPcLIuho/NmjBcU
         Gysw==
X-Forwarded-Encrypted: i=1; AFNElJ/0AvRr68ZFOMXKVceKdzU5MaADO3FD6YeKM3QLrVWIDHKB444U/sSXrHgW1wUNvEevnD5EMQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzeDFT3llRlbQsPIWWzZkOd1VRSUVK7E+4INt4C4J0Ug6UkcqiI
	zi9akXroRcXzYCgAQoS43zTkaGTGCoWoy6KbmsInyVt5VkRHvAoCuFeB7ilUmXSsxeQ=
X-Gm-Gg: AeBDiev57RZIYzUSr0RxiYVaFYjqH3y09oZQRpaUAFGPCVl+H5D3uMhQRpLrld8bX8i
	Hmp8iVTnjOVmnO0e1W7I9Nnx98SBUsDJsB1Y79q1XiaUUYod/4d0RlEUyzKeoXGXfqCYfacaCMj
	ZmUErYViWAqE0ClRwcBCZbZBGK3+dwi1LWNCkngfnHCpdJL6yrERlfOfINmCfk17H5gfosr3i2G
	Nc8BfF76xt7CLlxHsDP3siSgSikHnKTpSst1mM7MaLKkr/jMyPKjgCyFOgLPKk+l0hNsVCkcY/t
	hrCR2ieDAzhMS8y5qglozbscELUC2DcrT8J7vQb43kIXbdfAceTj1kZolW+iPhE1ht6EhWGk2E8
	hSqGfFxjNkRzOtPsQ8Bu7vCORvhMrc6iK5uh4dke2hC0HC/dIgDkIWMxDBp+aw1jC0jE0C7A/RG
	fPVQIAiMCmAhrs2zx6Rs4uandxZbHHCKXF6sJ91krT1dM531eWSDVCM/kCybjCLzchZxJS4bhnp
	npTI5Mcj5S2BED5
X-Received: by 2002:a05:620a:4002:b0:8ec:a621:a3af with SMTP id af79cd13be357-8f7d7d17f49mr430093585a.27.1777383404115;
        Tue, 28 Apr 2026 06:36:44 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8f7c7cd2becsm194526285a.29.2026.04.28.06.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 06:36:42 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wHicD-0000000Aii6-3yTF;
	Tue, 28 Apr 2026 10:36:41 -0300
Date: Tue, 28 Apr 2026 10:36:41 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: fangyu.yu@linux.alibaba.com
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	tjeznach@rivosinc.com, kevin.tian@intel.com,
	baolu.lu@linux.intel.com, vasant.hegde@amd.com, anup@brainfault.org,
	atish.patra@linux.dev, skhawaja@google.com, guoren@kernel.org,
	kvm@vger.kernel.org, iommu@lists.linux.dev,
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 07/11] iommupt: Don't preset D when RISC-V IOMMU
 dirty tracking on
Message-ID: <20260428133641.GF849557@ziepe.ca>
References: <20260428131359.34872-1-fangyu.yu@linux.alibaba.com>
 <20260428131359.34872-8-fangyu.yu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428131359.34872-8-fangyu.yu@linux.alibaba.com>

On Tue, Apr 28, 2026 at 09:13:55PM +0800, fangyu.yu@linux.alibaba.com wrote:
> From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> 
> When mapping writable pages, the RISC-V format code currently
> pre-sets the PTE D bit unconditionally.
> 
> If hardware dirty tracking is active (DC.tc.GADE set), the IOMMU
> sets D autonomously on the first write. Pre-setting D makes every
> new mapping appear dirty immediately and breaks dirty tracking.
> 
> Introduce PT_FEAT_RISCV_DIRTY_TRACKING_ACTIVE and, when set, leave
> D cleared for new writable mappings so hardware can capture the
> first write. Keep pre-setting D when dirty tracking is inactive.
> 
> Only meaningful for second-stage (iohgatp) page tables.

You shouldn't need anything like this, the D bit is managed by the
iommufd core appropriately. It *should* start out pre-set as that is
faster when not tacking. Only once dirty tracking is started does D
get cleared. User space is supposed to assume that everything is dirty
prior to its first D clear.

Jason
