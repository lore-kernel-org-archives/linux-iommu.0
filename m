Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69341329C54
	for <iommu@lists.linux.dev>; Fri,  1 May 2026 22:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777673333; cv=none; b=qZ8M6Pn4Yp/q/GYdsq5EKeOt02GpRy4uW0+IU5E3agnNdh+zqL4ZBYOnFM7XcUG7LjDI33lDwox4cxqkWnwbxxvA93gle2gpwvi7tjxfz/Vd6La0voRhnUz31vzDhkLup9HbyQ0i3gPejPZutJmzLmhXq/iQ1ghXmH1HN2ZE38c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777673333; c=relaxed/simple;
	bh=Gg8XwvR2iye8ftuUb9NqbqgTU1BVsr9N0mr1rcUra+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LlT7j0XBNUZacBcY4ezdhDSgBxcSjrC2tx1lkQ/OwYsDsBHUb1z2yAbK3E/3bx59WzzbBZkdbMcu5fniYWyuBlZnqjIOi5bkbUEhF4ZQBHAJSwxIB6OGqBDutzFzzqGBaFSEQW7e8CaXdXn2mFR38/f+DZN6GFwLKwmczvCzZPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TfFAeAFU; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TfFAeAFU"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2aae146b604so15058035ad.3
        for <iommu@lists.linux.dev>; Fri, 01 May 2026 15:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777673332; x=1778278132; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rIaBOF6T3Igmnhw7WxYJufQz1JELLjrBCUgq2t+SNoU=;
        b=TfFAeAFUKTHerlTvsC1GbwSbO4kbXOdZypyjIWUYdSWGQnU//ZVDqbRWbEYfduL8kO
         uxLo4e8ulraMOrROGYmVPJOArIk34+7t5addv4ZAY/1cRLop/qXGy4U0DQOwcQSV9s7y
         g7xThXxC9dBLGWtBk3m03XB1RWrMOvH6eLoF1tqxYRB0KQ/GCZMWCjq7b0D+7p/GGpxC
         2MyyUP5k6rANfYya02aHG2Mqg24hQbaKe6TUiSR/Y6Jy627y+pvI117wdjyf3eX3bt4C
         U2y2+pg2mjHgIEb+CzPqlVSr4D3hEhxDunV6hNZI2ioNgfCPLRUxfEUEQbeIDN96xMB9
         BaSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777673332; x=1778278132;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rIaBOF6T3Igmnhw7WxYJufQz1JELLjrBCUgq2t+SNoU=;
        b=QON44Xzq84Bf/1Hq67iaxBI9NuE2Ios5XYiCkN2pkvvMywoSxOivt/6JFG2V6XAQ6r
         GlxnNaqp3ljECokBEcZlHY8sjnMonFldtEAC84c7nanE1Xw417pIuJliOrfzkfTwiit7
         QDiSzzpZO39YaSHilMRzzXZxbfBk9QkTLRmnjFaShv24Wc8bLF6UpMIZq7kmQs9a0gTy
         VgGskqCir3ctAYjUMaaX/G1H6WvXWxcT7YbSbqHlJtH+0EhbhAUyVU/Xz7ReWiA1VD2H
         TaTw5bPdLzVqsUJ/K+lTPdQiRLWmE8Jvb64C/lVjCVE17/Jh3JcGaOgidX+Ep9fc1eJw
         i3TQ==
X-Forwarded-Encrypted: i=1; AFNElJ/2/VriJWvvr84FzEBhEdzbIW4lRZ1Y4yV32cm9WPjd1WTiywW5oDU3j0in9CJQhmLZt6pdAg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwnIEglSNsyRKI+o4CXZtIguepXIxuT/NHl3n3pkz8GxYMAhvh7
	GPhvv3rmFnMswO1usggVRfJUcr+hT1uyTQFVRhyvL02WMM93YrgV+UjEIyCOMcc+Dw==
X-Gm-Gg: AeBDieuunR7wwWMvRz9wvpqhwgT7ajqcqOiK3LdwmCQ94X1BJ+YQN22/DDISnmqjWEs
	6eYulNnktfllmRJzxt0JxZRzLdlGIIbEAysHly6k+jsPmO7ez/6tijAUaPZyUzblaFxuNrh/sAp
	65ZkcJ8rQfv2mhYpMFoYZamLYNNlbmMHUL7qrWsZ0NdrGO8BniqRl4HuqpC+upJGCBGXTznVw1s
	oahx3ohWkhTk1Tu7gwvG3hrFmWyNPguE93lD9239tKe7taK2ip/RY68S3FPQ0Z6M1f3TmD9h6Pz
	8ndvY3luV3jWHTLfrjnN4MREX/VZ3G2odLoOvIMwyDvECf57lFzUURE6wVS7PbwZUb59F1LPTg5
	nHFQbt0zwEkMbA7nBc+MWVu7ZPh2IEqZshzv3ooksfprY+od5dLbg3CNTn8LT1V5e+ZSlbRmaXs
	D55S6oirTYxzBT2I/LeQtY2FaTW2+RkXXkpcDTgg41X3XrM+t84i+PGf8zH9xoPsv/3jyfMv77f
	M/A0w==
X-Received: by 2002:a17:903:3c23:b0:2b2:41a9:8e10 with SMTP id d9443c01a7336-2b9f25e5495mr9622995ad.23.1777673331344;
        Fri, 01 May 2026 15:08:51 -0700 (PDT)
Received: from google.com (76.9.127.34.bc.googleusercontent.com. [34.127.9.76])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae6d123sm33770635ad.84.2026.05.01.15.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 15:08:50 -0700 (PDT)
Date: Fri, 1 May 2026 22:08:47 +0000
From: David Matlack <dmatlack@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>,
	Pranjal Shrivastava <praan@google.com>,
	Vipin Sharma <vipinsh@google.com>, YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH v2 03/16] iommu: Implement IOMMU domain preservation
Message-ID: <afUkbz0IQh98siYn@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-4-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427175633.1978233-4-skhawaja@google.com>

On 2026-04-27 05:56 PM, Samiullah Khawaja wrote:
> Add IOMMU domain ops that can be implemented by the IOMMU drivers if
> they support IOMMU domain preservation across liveupdate. The new IOMMU
> domain preserve, unpreserve and restore APIs call these ops to perform
> respective live update operations.
> 
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>

> +static int alloc_object_ser(struct iommu_array_hdr_ser **curr_array_ptr, u64 max_objs)
> +{
> +	struct iommu_array_hdr_ser *curr_array = *curr_array_ptr;
> +	struct iommu_array_hdr_ser *next_array;
> +

There's a trade-off being made in this function to leak deleted array
elements instead of trying to reuse them that warrants a comment.

> +	if (curr_array->nr_objects >= max_objs) {
> +		next_array = kho_alloc_preserve(PAGE_SIZE);
> +		if (IS_ERR(next_array))
> +			return PTR_ERR(next_array);
> +
> +		curr_array->next_array_phys = virt_to_phys(next_array);
> +		*curr_array_ptr = next_array;
> +		curr_array = next_array;
> +	}
> +
> +	return curr_array->nr_objects++;
> +}
