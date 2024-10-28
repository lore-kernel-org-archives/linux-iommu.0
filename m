Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8841D7E5F
	for <iommu@lists.linux.dev>; Mon, 28 Oct 2024 15:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730129169; cv=none; b=LuxJPkHYwVS1IDVjc2tTWCdRWPPlWzbhD6cQsV3nhMtmilP6Kj7PgwzZRrLOqLdVrjhgRNqkxGSsW/fDQ/Y5YewcCv4svMeXW39MBoGu2+biVBnOfZZIgkPm/JqcjxroUUIjLcMlxhyNch1NqYmilGhyejQRYri96BA/4FdLs9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730129169; c=relaxed/simple;
	bh=j2SBIvpSVeLUKjVZiruc3UPwsTj/VwDFAie1dmdbxPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gKG72vxUxOGYEUxEVlAyVya+PqbA/ici99tFybBP5m9LkbhqR0L/d4hqHzZWM2AeZD1x/oDU1nTufFZnM8ihU8SdyPwcd2KdAikI0XHj1PgKE6aJ1No5hQvwv7RYH7NqHsqLSTgI+HMmcy7W/64YAxvSFDDP+QRfL1PrNGa0c+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=G/dTIvDM; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="G/dTIvDM"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7b15d7b7a32so392471885a.1
        for <iommu@lists.linux.dev>; Mon, 28 Oct 2024 08:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1730129166; x=1730733966; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PONPf2xc+KiVv41aiqAdvLUYgbsUNJqanPuvWa8rFiI=;
        b=G/dTIvDM/diJDNzkmd2v4OxL5NdB3LuZJhDSIHSVfb6iTndxst68kaBai/Bay+4kn9
         gLrh55+4DVp2kO5sZAzv/GyVkmvU6462xapUDD3qJ2kRGgBwa2oUBrtPKwtdqD7dfjFm
         xid3YofXfpJ2mI2VIomr9z7xPBAKz8bK3UbZlD2KA6Zl/U4Smi8SKVXl7a1mafJs2bQ5
         uF09uokRvZuzBih6StaV7ZAI9QL8r75l8BqhixIyX/YGAS/yW9qUIvNuOYxpAAAIdvse
         IHgWd3n4syR9HJV5ymGlElOEypvDvmsj0RU31vmUmSvJnSSxdILBh/UppJrKUmYA3NKg
         FYtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730129166; x=1730733966;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PONPf2xc+KiVv41aiqAdvLUYgbsUNJqanPuvWa8rFiI=;
        b=sBlhlxxq460dHNTMhqcsBvQw2yI1kGqr7JXbQ/o861c9nKHVuWqn6a2fI059kmLfqP
         Bbiy6SkIvuh9eDhVjXsbYxLqWb721QGEzuuAFsmCLaO85vt/4iQZmXooRiaWvQ/IicPe
         w0wtQnqNXLzqWilHsLvp6/Tkvf1Z3p6JG+DgwASfIFi9kTdLs1wEdBd5h9Vw6emAg9f8
         X8TQin3RjcYuYkhaglc2z8T0W59degblNZangTlfaXt991opFJfFpaKMWOjy8CyLwrLH
         XLrRuPB2tZfTii/ninrpNolFImPDvMB5KFPQOOuKZy6vfAeBv/2nXG/W5b+WXWDycpIZ
         G9Ng==
X-Gm-Message-State: AOJu0Yztp/B4Y0Luv7mdVbGsbWFs1vmHMRWNonk5IlXceRQdyfcLUDv7
	tD62YyaqFRFa23duOgGl7XDZALLv5HClZ7c+woEOu5ENu7RgVNuWlJENM/vxWZtJ/O05fv0fS72
	4
X-Google-Smtp-Source: AGHT+IF3/h+F9RNY7AVTEjHqyoA4zJU9PrTGmlYUUa7lbZYJRxjWCfmSsss4JXB+i4+OseUgFy91RQ==
X-Received: by 2002:a05:620a:44c1:b0:7ac:e879:1a20 with SMTP id af79cd13be357-7b193ee1612mr1185378385a.1.1730129166478;
        Mon, 28 Oct 2024 08:26:06 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b18d3310ebsm328157285a.76.2024.10.28.08.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 08:26:05 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1t5Rd6-00000000Qlp-31ST;
	Mon, 28 Oct 2024 12:26:04 -0300
Date: Mon, 28 Oct 2024 12:26:04 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, suravee.suthikulpanit@amd.com
Subject: Re: [PATCH v4 01/12] iommu/amd/pgtbl_v2: Take protection domain lock
 before invalidating TLB
Message-ID: <20241028152604.GC20281@ziepe.ca>
References: <20241028113148.5774-1-vasant.hegde@amd.com>
 <20241028113148.5774-2-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028113148.5774-2-vasant.hegde@amd.com>

On Mon, Oct 28, 2024 at 11:31:37AM +0000, Vasant Hegde wrote:
> Commit c7fc12354be0 ("iommu/amd/pgtbl_v2: Invalidate updated page ranges
> only") missed to take domain lock before calling
> amd_iommu_domain_flush_pages(). Fix this by taking protection domain
> lock before calling TLB invalidation function.
> 
> Fixes: c7fc12354be0 ("iommu/amd/pgtbl_v2: Invalidate updated page ranges only")
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/io_pgtable_v2.c | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
