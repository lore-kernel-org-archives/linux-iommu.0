Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6327019D090
	for <iommu@lists.linux.dev>; Thu,  5 Sep 2024 13:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725543655; cv=none; b=P8wtBAZ3hMslNz+ugwRZtve6VJDIIown20PFFldxWrC4LfvywNyvElOI74CcTVmIQ0uPTnpRjyYe52IrapFvvEQhnI3PWvX34a4XYAHIzhT+RSrl5fhSRXMmpIRgwdXcLVS97Tbk8xEypuqJtQH3amyn3hXJRh0Xhb/DsuCmvNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725543655; c=relaxed/simple;
	bh=AxPtjHYuOVtkkcmxIcpgFsQxIf83bf8J45zt3NGqfPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TCDfAqk0PymM8CGy8E6zz7N9As/+VKtHrHJCF9LyzKKJaOkkkSkbbFO+IP6Zeh1eJFT23q5du/W8QofEI/urL34+Nx17H6heCKVSxpcQlEQ/Pa0Sw4fkO09AYFgogcXRvn0jOJ7xmm8OkGHOH2jld02nDmL5KuZ0BUCxXESVW6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=kAasOHyx; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="kAasOHyx"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-456954d0396so4669271cf.3
        for <iommu@lists.linux.dev>; Thu, 05 Sep 2024 06:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1725543652; x=1726148452; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UVryk+sEYmFSRDSp/0MfOEJVaFXd2+NxfDVIFtGzX2A=;
        b=kAasOHyxFvGt5aIfXYjt5qFu6ZJn9Ybmk7Lk/blPaAh7LFD6lPsWyZfV0yQ5hes3qr
         dMXN/5KzeREcUivXYx4qlxMJ3iDfE43HC45L9ffouuTyaKxegmYwBqL/fTaSx1rOtAAk
         N9ijtv29+Y6FS9770Hr6yi58412QSYSUiIiDUoowkXHcqp7L/iB/1j1PEXzf09lX5FIQ
         BPPVE0ev7ehaLUJFWsmZfl/1oNTiSAv67vam6HVobXqMrgP2Y8ALWShQv6lwmIbyT93g
         7OKmMibANxn6rU4yNkB7djN7kCGJKyM3KqRH3J2dyM1ZoX/PL86CGwO5iExZWdkxbjCN
         TYqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725543652; x=1726148452;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UVryk+sEYmFSRDSp/0MfOEJVaFXd2+NxfDVIFtGzX2A=;
        b=OX+EGJR8Hk7mWtUrlP6z669Yd6zXX8j8IMwVqizVhBAkpyJsTEQM2atuXOg8k68M6Z
         WasOTAyTEnkHjK9QLippbAD43hPHjylSc7qM6waDpagmgLnKl4LdfWah3QSou/sVMHWu
         PyxFBQLYUgqRWGV9mIdifVhc7GbUvLsuQEJMogFnqsB7XARNiUlFc9gjHy+CNGLtOAzK
         /fVNEkrqdbZrZS9SLYCupl4WoDaGIIqSO3mekALoGiUTrH6rN/wnrYjwhioFN2KuliC1
         QwocigqYR77eKyAe5XbIQjy0/8fM+sOHDB6mrWy+kjytX9WC+dbQ1IgKjvpgb9AjPnor
         Lq8w==
X-Forwarded-Encrypted: i=1; AJvYcCVJ4lUsGr0RcsKLHLzux81Ok4u035xIndbTWHXC4KJx73EYi18SdC6VzkpC1kdBYP6q40i/vw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz/tAL6kuVnedlyWltUybFOVIqwXvFATgyDQFGyvggQMrqJ2Ch8
	NL95HU6RMNZBE1/1bUcZUjgBcpWXrIyb1fkhOCwh+Hjc2ZLM4u5TS0hPL2qKalY=
X-Google-Smtp-Source: AGHT+IEUdiC6y6FiD5Qy2DoUR0vrZOWliBVAargS1d8t8110/9207+SXKsATbVvJ1NnKgXhpPCa79g==
X-Received: by 2002:a05:622a:420c:b0:457:e3dd:498e with SMTP id d75a77b69052e-457e3dd4b3dmr105811761cf.9.1725543652193;
        Thu, 05 Sep 2024 06:40:52 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45801dc366csm7138601cf.93.2024.09.05.06.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 06:40:51 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1smCjD-00CZyU-0k;
	Thu, 05 Sep 2024 10:40:51 -0300
Date: Thu, 5 Sep 2024 10:40:51 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: dwmw2@infradead.org, baolu.lu@linux.intel.com, joro@8bytes.org,
	will@kernel.org, robin.murphy@arm.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] iommu/vt-d: Use PCI_DEVID() macro
Message-ID: <20240905134051.GA2994907@ziepe.ca>
References: <20240829021011.4135618-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829021011.4135618-1-ruanjinjie@huawei.com>

On Thu, Aug 29, 2024 at 10:10:11AM +0800, Jinjie Ruan wrote:
> The macro PCI_DEVID() can be used instead of compose it manually.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  drivers/iommu/intel/iommu.c         | 4 ++--
>  drivers/iommu/intel/irq_remapping.c | 4 ++--
>  drivers/iommu/intel/pasid.c         | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
