Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9674A262A6
	for <iommu@lists.linux.dev>; Sat, 11 Apr 2026 12:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775911642; cv=none; b=ZVfhIiZTFFZphe6IS60WdI35HkP4jlrVzImEWkbDcWFjOw2KWYuSxgjQA4oqfoDDkOW5sOOx07xhdb8563si+4iWAiQWoS2Iiv+wvMNoFXaHIQva4Q8zao8dwnrROe4yrvtM9/r9DAs6WJzWkDydBuhm1J93JO8nOfe56OdnyLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775911642; c=relaxed/simple;
	bh=tjYHbSu1hvmQj4L9la7S9ox52KNgT9pVoxfzx6Q5Yiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A/TPYWd4lfMdPfyvmkHKdvQosEPDh0RezhmHNENHqnZExYTo3N4/zzK5ShROLtrNDQtD5wNpjO834rJDRXELC8KDx+DW3GRuhbUPBnUeCcNrACHR9C0vuOLluVj3IZXYGFRrOiizUGRhwNGLdClQHC9Y5pkDpBSXIo02VZTxaek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=B5Y13Ved; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="B5Y13Ved"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8cbc593a67aso266466485a.2
        for <iommu@lists.linux.dev>; Sat, 11 Apr 2026 05:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1775911639; x=1776516439; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eWppL+WJopnByItX0KjB3DQR4+wR3fIbz3ulvVygolU=;
        b=B5Y13VedEbwg2Qms03D9rhEK6jBpPGm9dHjlqLcPtV6eXR5o1MJjfk87G9e+LNX+aS
         D1BGNAZmhQn79MeQcNngpqkTV749y9UxnlnqS9Z+/6G9S5FRIp++aS1QqbV7zNGXfAAR
         640KlKoU9Y90s9KcUAovSUTum1ifbSq5M2tjtZfT8L89mIkK79Wa1KRvmKYeVOJOL80m
         B7BrH8M/kWB3KRX50OBZQuHICxs2FQtPNBhL4DkGQPNaP9CLoL8aGtX9MIEAHAEhjHyB
         djdjrnUHVBRdhAhi5BnBom3fEEfdd2sv2+f2oxpdi7EJI+/BAHmNtiUu7QqFjyNQM+7l
         7qSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775911639; x=1776516439;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eWppL+WJopnByItX0KjB3DQR4+wR3fIbz3ulvVygolU=;
        b=VGh+8InTY1W0RQqeRTlZ/g/ux7+3LOsYekGdb2bb0g7RpURP8sVqtU8Gs2Z5qMWzFg
         68bgvxhULfG60ssU/USFAlhJl7MUXVgld0praVK+HM7b+RlB2orotlYg23QexW4cAc3W
         hIzXx5MxJdj8XAbkJsfr1uHsT92EBHkZSLQ9Yg6zhPdcY/dY0e7WHFlvA2Pr13y6WIgW
         wxdSk1rlNvMA03UOPnxwzovcqBxN/KLegYJL68uDLwYFkc2xPLM1oTN8440oFmAwv41V
         Pp/OO4kZw+VLufE0ILEM7l7Nkh5DnHy1foO+I7loG5mUZP09GCg7xe04uLbNIQBY/Aaa
         vUnw==
X-Forwarded-Encrypted: i=1; AJvYcCVDkldlULSon/FBW3V3D5bnNl+ENapN/B24wAYpxLYm1dtgIK8KoEKIWC1sO7kUFmknbYbTeg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxbKMbUHzcqfgAYcz2kIo7fk0/0e25hEvKj6A2iwiFkINHqmyqa
	TX2xw6SlreI1ZyQufxnzEzRRP6i6Dr1kLA35l8qQsGPobX65PHssTJ39zGrxqKC24F8=
X-Gm-Gg: AeBDieupBMvq79Q40zdDBQjHp8l2/7qCJ49qKLz9NmRYPLN5HzpqbIiIpC/BPKfYwE1
	93Ofex/3Nz79jWbtzN7qFKL1p0jK/T6wONSjm02pArku+coH/LYuIQLH2mMy9HEtEV0M38bgd0W
	cwZ+bOquYCwvrAyVb+gPUs9MMM/4AmJ5mRif9Nu7JFzwkusSu83blofB2NEYlbP9HGp/Wb1Zxyu
	8BuFe9NA5HUwjqSzQbRGqjBmLbHxXD8bSOzbRq0E5tA1xllqohczxrZLXPXijGsBWk4p1ypTfmn
	wKGJGT8xUYD1TM5CBlwgsUyXr6QUeIm1U969G5P/XPhF2pojymEOUXfLTUTMtiXRnZ+3yhYtyX3
	lDa4HPjTkmbmIqh2H/95Kj30JH0HuZxxGTZ2fZ4LrVOEVrPuDEELe9KsiA5IqW8ASotoBNKpUsS
	IX3ZeycBIIwU2mwPsfiqfdtcdsQ9eE8deznYBMcdPdvtJqZHDEMCYFvFjIbKWi8iEKk/XZs5T0J
	4VmFg==
X-Received: by 2002:a05:620a:4155:b0:8cd:923a:87a0 with SMTP id af79cd13be357-8ddcd6fcfc0mr1003943885a.21.1775911639328;
        Sat, 11 Apr 2026 05:47:19 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ddb5f89d88sm426412085a.4.2026.04.11.05.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 05:47:18 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wBXk5-00000002Xff-27WZ;
	Sat, 11 Apr 2026 09:47:17 -0300
Date: Sat, 11 Apr 2026 09:47:17 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: fangyu.yu@linux.alibaba.com
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	tjeznach@rivosinc.com, kevin.tian@intel.com,
	baolu.lu@linux.intel.com, vasant.hegde@amd.com, guoren@kernel.org,
	iommu@lists.linux.dev, kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iommu/riscv: Advertise Svpbmt support to generic
 page table
Message-ID: <20260411124717.GE3694781@ziepe.ca>
References: <20260411022223.91029-1-fangyu.yu@linux.alibaba.com>
 <20260411022223.91029-2-fangyu.yu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260411022223.91029-2-fangyu.yu@linux.alibaba.com>

On Sat, Apr 11, 2026 at 10:22:22AM +0800, fangyu.yu@linux.alibaba.com wrote:
> From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> 
> The RISC-V IOMMU can optionally support Svpbmt page-based memory types
> in its page table format. When present,the generic page table code can
> use this capability to encode memory attributes (e.g. MMIO vs normal
> memory) in PTEs.
> 
> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> ---
>  drivers/iommu/riscv/iommu.c       | 2 ++
>  include/linux/generic_pt/common.h | 1 +
>  2 files changed, 3 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
