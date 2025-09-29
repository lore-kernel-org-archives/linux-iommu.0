Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2975B309F03
	for <iommu@lists.linux.dev>; Mon, 29 Sep 2025 15:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759161447; cv=none; b=Q5WTRdQNy/AXaobact+iQx+mkOPWhzDqNvqCcZXZSPi01bowlTXLQhA8/GbYx2EMY9U5BY2jUQ9Ira4P12OcFP+xmpyU75EtmF3hM0aVj+yjg2YYWogAGOB8L0lOuYCzgP8eJKgC3stQmZJ7Ft/quoUxZh+TTmKeAOr7g8zn0Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759161447; c=relaxed/simple;
	bh=7QbCbDrd6B4VUX/ig7npD513FdOAo1ndXjpy9P0UES0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k/9NKleS3TgR3kcnORMmtX28UmL0WBtKYVrk5+mj4W6UjerE/3kdEzuKcicRGvIA72DJlh5QIDOxZV2LWmUQ4KVyCWSeaaR/dCr6FpoNlh0+NZHAQeBrlXS+IWweAGIqzVMrH1VnkzOGQEDztvypNfUgjV7itvrvOJuxAAQsqOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=D4Obtsh7; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="D4Obtsh7"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-854fcb187b2so539530585a.2
        for <iommu@lists.linux.dev>; Mon, 29 Sep 2025 08:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1759161445; x=1759766245; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rae0hraJRZQjoYrQUcng1cfyBx+zL1Bo8BbPQlyO8G4=;
        b=D4Obtsh7O1y7EX5pFN2I3XQHa4p/a9RIu67TaFe2FZ6cK9HkXQQ5eTq/KAI/uw4dhK
         EZd+H+3nzJNsF5B1xRKcNr1V8SokT+pdE3ZgaR4+1TBJghDAoYoMusPYpa8N2n5H4Qbc
         qM8A5FjFPRRM0YtTWKeLfgJj34iPI87I9O9Du5kRp2YliH4WrCsq9uuxTX8Akzvwhhhk
         zUYgKtzV1nLNPAc36JA3T0yx37hKyOLUeHZ4IsLzW7ns+ESw5BwFD1Pott31ssD0xjof
         IWGDEKZ/ZYl0BcMwLI3ethGfIRSyKYjNgA0UOk3QnP+jxl/4P/OQ5o/vmQB8Xs3nAetV
         A4ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759161445; x=1759766245;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rae0hraJRZQjoYrQUcng1cfyBx+zL1Bo8BbPQlyO8G4=;
        b=D6U+i6E7Ftz7ldk+2TGOXdaaWLdW6Ss158AcbSPZgDoWWZgDVBjYBs7qeUQMMpvKAi
         jp7kpLkl2UymWdVIlA5rz23U4TxZCNpWbrkcnIZXqQWPebHppPcADVB9XPbS4tPWcam3
         9VFwZM82qKBM3VwLZhn7aAuTrQgSMAN19G2mxMKcpQaXYR7mFoSDCjoYt11t1+hEAmPF
         elZCWSzw3yaShY0TevXvtmhANgjb95qUDUhcYBLs/D9Zcu6o8gZBKm6+XMTl+Ty6jFxy
         IFU2yJV9z8MgyqlDRls64yDysW+iDaE4p18NFjT/MHW/m7AWlTxBfLdguIgWK2LnOV02
         6M1w==
X-Forwarded-Encrypted: i=1; AJvYcCV3AAEutPC0eSplXsAd21IUGcLm6JM1Z3LwFBgdh+zJZmkWBtFmOUYFiGhT1cn0EgxPGYFEkA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwXpBkai9b8Qnd30ZkMLjy3fMwrgXxjv8Xz8jRKFfG9Asgu8Dgq
	S7cp5uFoV0miS7+CilTnMhPb1MxdS1K71UiEOKhYuIb2BkkwP2XqoyjrPLqB90Vk7Jlzv33G9IO
	UaY+4
X-Gm-Gg: ASbGnctm+Vc2NkPqw2qRO/rYG/fw9LbQGoYij2B8SEh2O7C8J3i5VD8TPt2Jmjgdip1
	Zetq6Mb0/y1pgbF36pyp3rEt3HFMGK0qiGn9MIt5tRCCqYaH1AT2QOu0R5hzFBNoAyfQWwyNJDM
	XBmMxmzVdJNmMORR2LrKHjkR8R4l8KMRaoZRTP9IAXmeZ5t1FaI3CqOZK2kLxqkG+kDKNTCvEHG
	DW6kfM15GWmCaIdcyXTVECL0bR0G/MjVE0TDHyw60KFbJz6i3NcX+K9W4RyMNtEYPIo/qN+P2zR
	hIMb5ZkHiF8chbXW7Vr0lBFIVw8ik17m09HXPm7H43iPcvDqM2MA4peCegluu90nEOU557jU
X-Google-Smtp-Source: AGHT+IEwPUHI08JC6OI673GcS8cwi1tgSzL6koeiwALjAQD9ty06B2a251wKjNfOuyeMLizVY7Kz7A==
X-Received: by 2002:a05:620a:28d5:b0:866:a24e:2eaf with SMTP id af79cd13be357-866a24e3319mr985596285a.66.1759161444827;
        Mon, 29 Sep 2025 08:57:24 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-85c307acfb2sm830379085a.39.2025.09.29.08.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 08:57:24 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v3GFf-0000000CM69-2XTb;
	Mon, 29 Sep 2025 12:57:23 -0300
Date: Mon, 29 Sep 2025 12:57:23 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, iommu@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>,
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com,
	zhuyifei@google.com, Chris Li <chrisl@kernel.org>, praan@google.com
Subject: Re: [RFC PATCH 08/15] iommu/vt-d: Implement live update
 preserve_iommu_context
Message-ID: <20250929155723.GE2695987@ziepe.ca>
References: <20250928190624.3735830-1-skhawaja@google.com>
 <20250928190624.3735830-9-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250928190624.3735830-9-skhawaja@google.com>

On Sun, Sep 28, 2025 at 07:06:16PM +0000, Samiullah Khawaja wrote:
> +static int unpreserve_iommu_context(struct intel_iommu *iommu, int end)
> +{
> +	struct context_entry *context;
> +	int i;
> +
> +	if (end < 0)
> +		end = ROOT_ENTRY_NR;
> +
> +	for (i = 0; i < end; i++) {
> +		context = iommu_context_addr(iommu, i, 0, 0);
> +		if (context)
> +			WARN_ON_ONCE(kho_unpreserve_folio(virt_to_folio(context)));

Wrong function. IIRC all of these allocations came from iommu-pages.c
and have struct page metadata.

iommu-pages needs to participate in restoring them and put back it's
struct page information.

>  static int preserve_iommu_state(struct intel_iommu *iommu,
>  				struct iommu_unit_ser *ser)
>  {
> -	pr_warn("Not implemented\n");
> -	return 0;
> +	int ret;
> +
> +	spin_lock(&iommu->lock);
> +	ret = preserve_iommu_context(iommu);
> +	if (ret)
> +		goto error;
> +
> +	ret = kho_preserve_folio(virt_to_folio(iommu->root_entry));
> +	if (ret) {
> +		unpreserve_iommu_context(iommu, -1);
> +		goto error;
> +	}
> +
> +	ser->phys_addr = iommu->reg_phys;
> +	ser->root_table = __pa(iommu->root_entry);
> +	atomic_set(&iommu->preserved, 1);

Why all these atomics??

Also most probably this should all be flowing through the core code as
I think the core code has to genericall prevent attach/detach/probe
from happing once serialization has started.

Jason
