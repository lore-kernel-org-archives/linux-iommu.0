Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4D41635A4
	for <iommu@lists.linux.dev>; Tue,  7 May 2024 15:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715094920; cv=none; b=I/JSar2Z5PqXCM6zUVBV5tUiKrnrahvLU6JdhRYff2OsCu3L+vw7+wyIZOivXZzUaV9I1zi6E7AZUYUhdzbbEq41LvOMqC7NI7P1pVGZHLFyjxgO/EaW4UHEEuvR7tic38ZGVS8Wh2Qkah0sVys9t/59gvyj69xrlKmF0RjEMgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715094920; c=relaxed/simple;
	bh=gF84VCMPJTVEggmFhKFaP/dcKdSzxcXmZFhnXWJW44w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WYzf45zdc4otoK8LO0DX2ZMNF5oDnIPb8wP2m2A0nY7CCNyq4akO883Z7HNL7mzXmFpb+9NTy8BhZRfnVGBwfc3A0gs6uEB2wRNoJuXnWffaRjmjfOR9Irpx+Pw8BwH4bWcvC5FmFOab+RhsxpRSlQMWLS4CKzWa3rcHqUakh5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=MjO1LM9s; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="MjO1LM9s"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-23f02e15fd6so1530651fac.1
        for <iommu@lists.linux.dev>; Tue, 07 May 2024 08:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1715094917; x=1715699717; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dkqGl/7x0OwO56SYs+uVQbq7OCSGKYp1K0+HP7Qmbg8=;
        b=MjO1LM9sYLXjjBF70cT+7P5gkOdi6kRpZb/UqM+SpZ3Swkw+cLaDMA+qxCJiilU39N
         nqYXHpSdWTb9ghACaY5ro38hXsEqBTUZTHst+/0NyOkZdJ2GfluoID1+v3CQ8q36mvUH
         mfjXu1TrIeO+/3oW3H7YVbnHxVvqgs2dmVMaCXNdZpyHgSIPbvbNcS6RQQl0ebLxx2sp
         YC+xkrAYDYH4+0Y8J+A3QGkfhaUxYTe9cK9nDzUu/3LCYuTXsdCKavIBSjPovdVhuwoa
         6HekKTkh+NesXBo9bTrZr4333Sdx6MXoG9ATVCK35CQ5symW5/HGhJoMoFvSTj/q4Yr+
         KWag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715094917; x=1715699717;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dkqGl/7x0OwO56SYs+uVQbq7OCSGKYp1K0+HP7Qmbg8=;
        b=dZ9jWAJ+RKgK64Dvz2LY7YErDW/lKnOk7dVGA1LOomZoNbXaukQZp5lWRoYfB2sr3U
         HwwOiO/d0W4CnVRzuNF3X+gkMETswCPUOEi0Jc3WiB+QRLWhAgA2DgJJona+wgrlVh9f
         LXrHDzfSiIi1+QvJcVk4Mm2qbbENxpmmU7ZFnFyFoohrPEIs7vfHwPv/lx9KUYa9LJ5Z
         h7QhY/GgjAHg0Qq+cGXNRXaUTQ/BDBsitg/OjMFd8CsvlsmNOicU12RzoLtfcn//JnHO
         DZw8sOa0Xtqf+MJtuSvvdfpJl/Hh93zi4mS/nBF13FNT3L33OFRgf4HQ6dTdkD+7fYW8
         6kQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWh+CVPuh+L0Yonjl/P17vGatHpwGfvkEu3ooFUOAaumiA6IuQbsUF1Qp9S9+5oJdCQXBL66TTBdCumtntQeMhKaLLygL8=
X-Gm-Message-State: AOJu0YyjzERPTlQwAC8MM0mfGG7Nj2n8L1rauRxR1Io1QvpjHhMcfbZx
	/a1ukEW8tUXzyva/sXjJiFuD/4O6ALVCttajZSghV6j4ZaDfey4KeJ6+pZ6nP1s=
X-Google-Smtp-Source: AGHT+IGUoxvdjNdzspF19Ce1OuUkdsrFCLLK5IkafH8wCvTsMAF8ekXOGHUiIHhabayOnNY5P/EIZA==
X-Received: by 2002:a05:6870:d205:b0:23f:ba88:d5ac with SMTP id g5-20020a056870d20500b0023fba88d5acmr5660623oac.53.1715094917705;
        Tue, 07 May 2024 08:15:17 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id pn27-20020a0568704d1b00b002397a883e7csm2552861oab.12.2024.05.07.08.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 08:15:16 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s4MXE-0083RU-0c;
	Tue, 07 May 2024 12:15:16 -0300
Date: Tue, 7 May 2024 12:15:16 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Zong Li <zong.li@sifive.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	tjeznach@rivosinc.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, kevin.tian@intel.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH RFC RESEND 3/6] iommu/riscv: support GSCID
Message-ID: <20240507151516.GK901876@ziepe.ca>
References: <20240507142600.23844-1-zong.li@sifive.com>
 <20240507142600.23844-4-zong.li@sifive.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507142600.23844-4-zong.li@sifive.com>

On Tue, May 07, 2024 at 10:25:57PM +0800, Zong Li wrote:
> @@ -919,29 +924,43 @@ static void riscv_iommu_iotlb_inval(struct riscv_iommu_domain *domain,
>  	rcu_read_lock();
>  
>  	prev = NULL;
> -	list_for_each_entry_rcu(bond, &domain->bonds, list) {
> -		iommu = dev_to_iommu(bond->dev);
>  
> -		/*
> -		 * IOTLB invalidation request can be safely omitted if already sent
> -		 * to the IOMMU for the same PSCID, and with domain->bonds list
> -		 * arranged based on the device's IOMMU, it's sufficient to check
> -		 * last device the invalidation was sent to.
> -		 */
> -		if (iommu == prev)
> -			continue;
> -
> -		riscv_iommu_cmd_inval_vma(&cmd);
> -		riscv_iommu_cmd_inval_set_pscid(&cmd, domain->pscid);
> -		if (len && len >= RISCV_IOMMU_IOTLB_INVAL_LIMIT) {
> -			for (iova = start; iova < end; iova += PAGE_SIZE) {
> -				riscv_iommu_cmd_inval_set_addr(&cmd, iova);
> +	/*
> +	 * Host domain needs to flush entries in stage-2 for MSI mapping.
> +	 * However, device is bound to s1 domain instead of s2 domain.
> +	 * We need to flush mapping without looping devices of s2 domain
> +	 */
> +	if (domain->gscid) {
> +		riscv_iommu_cmd_inval_gvma(&cmd);
> +		riscv_iommu_cmd_inval_set_gscid(&cmd, domain->gscid);
> +		riscv_iommu_cmd_send(iommu, &cmd, 0);
> +		riscv_iommu_cmd_iofence(&cmd);
> +		riscv_iommu_cmd_send(iommu, &cmd, RISCV_IOMMU_QUEUE_TIMEOUT);

Is iommu null here? Where did it come from?

This looks wrong too. The "bonds" list is sort of misnamed, it is
really a list of invalidation instructions. If you need a special
invalidation instruction for this case then you should allocate a
memory and add it to the bond list when the attach is done.

Invalidation should simply iterate over the bond list and do the
instructions it contains, always.

>  static void riscv_iommu_iodir_update(struct riscv_iommu_device *iommu,
> -				     struct device *dev, u64 fsc, u64 ta)
> +				     struct device *dev, u64 fsc, u64 ta, u64 iohgatp)

I think you should make a struct to represent the dc entry.

Jason
