Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0124D55E73
	for <iommu@lists.linux.dev>; Mon, 28 Oct 2024 15:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730128801; cv=none; b=I/T5nXz4C2y8r5m4HJP3N9N+WKLUzodyuRFmHjo1YTd6dRmYel4mdX2Zvqy5WO8lwxAdqufP5Ztl/ZmUg2K1cArIKc5bmEWutHhbnSvBE0FzYC/WvdM76a9Q2DCHbyrURMAinoDK2pMxOG+uYdpnF5c0JkLqF0MQon1cg1T1iDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730128801; c=relaxed/simple;
	bh=xdNf0o0clU3DE465zAXUm+Rd2WotEfme1AEpzs3uBNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N/AouLJgnDr5myPiYEyPycbX8YfmZ14YETNpHovnxj18absTstFXmWaBD533eQA1A4qqkZL7kwJjw8plBjrFmdN6bktoUanIpj5PMJIqJ1TdgRC2Ifb3x72L9Gg82pDpfu5N13A+Mp+2IUz5jlXfJsZGl4OLzmuzBhTx262HLtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=g9yp936Y; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="g9yp936Y"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7b1467af9dbso356436985a.0
        for <iommu@lists.linux.dev>; Mon, 28 Oct 2024 08:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1730128798; x=1730733598; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qJigOTYTqfDT9huiYTPD9HgB5N6CObDhxg9YJhW/KhU=;
        b=g9yp936Yr4Lvm8IRsMbVP4WVbPO+h0IjnsVIfjS6zPGiNR53mGmcqRfmp+sDqiCjUQ
         sU4YwTvTfkXBU+VmB6bSvapGHn8EK5fqc7drHOxe+L0z4bsPk3PSW3jixfL4xs0LXTfu
         YDSWZ7sui4CDiGn5nPqzI46EPp3WSa+LakcxFbNfp07+UNDCUArKe0LBDeqm85rv63YY
         9VpuNyCSozJlCIPsrHFYRmhCHcYLDNrxYGN2q/7kTB65x1LhYhA76+Vmr8/2lUTrY1XP
         9SO4YGE20+RvHnEEKf0+BJkDC1mqlPTUR/31bcvwMlO66M2znWXKqkCr2e62EzW6AafS
         WsJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730128798; x=1730733598;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qJigOTYTqfDT9huiYTPD9HgB5N6CObDhxg9YJhW/KhU=;
        b=hbUeT6AVt3fR00s7+OnWGh3IQUMxQHrU3+rakIbM8djLVjXi03tJJHgOTD5XtiwqM7
         PsibXI9HPKoPQbwTB8BldMTurmVB2rUW/2f/gAYBrUFDsJhu5OacwZsZaOJfT7Gnsg2A
         PwsEcuZFVdj1yFJIMpcmVpPpmuxy2jQRaPDP6YdFtkZJBoFCHmKVg+rinteiQaTLEPi4
         colrMpH+2rOCDF9ioPkAp2PvOzbRavzEMhE9bR7UCo2XqUY0CHIjMricDZfnypZzsTwq
         GGYckxfYKdXC+dum5fGsxch18DfZ+8gIJsWDrEC/kCY5ZnIdbod39lufEZeGOpO20PVs
         Gr/Q==
X-Gm-Message-State: AOJu0YxVU3nGLwCOHm9ZuFx3NyQblP3rhRomD6Re6vyl63y8iLTA/pRs
	IbAnj3fHog8VSpG+Hwy/JpIso5QdJ8okxiMHkcqlhUYU/zp7SPNPBzsfp0fh6AQ=
X-Google-Smtp-Source: AGHT+IEFvaZmblejtTxgtJsryiGSYy5dmrTKGer0LQLRm/NhnFi/+q0MEAzexfCP0H0Jqdj+qPF7SA==
X-Received: by 2002:a05:620a:1a81:b0:79f:1cf:551e with SMTP id af79cd13be357-7b193edab41mr1330264085a.5.1730128797789;
        Mon, 28 Oct 2024 08:19:57 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b18d291e0esm326954185a.39.2024.10.28.08.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 08:19:55 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1t5RX7-00000000Qkf-3kIA;
	Mon, 28 Oct 2024 12:19:53 -0300
Date: Mon, 28 Oct 2024 12:19:53 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
	yi.l.liu@intel.com, baolu.lu@linux.intel.com, kevin.tian@intel.com,
	jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v5 09/12] iommu/amd: Enhance amd_iommu_domain_alloc_user()
Message-ID: <20241028151953.GB20281@ziepe.ca>
References: <20241028093810.5901-1-vasant.hegde@amd.com>
 <20241028093810.5901-10-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028093810.5901-10-vasant.hegde@amd.com>

On Mon, Oct 28, 2024 at 09:38:07AM +0000, Vasant Hegde wrote:
> Previous patch enhanced core layer to check device PASID capability and
> pass right flags to ops->domain_alloc_user().
> 
> Enhance amd_iommu_domain_alloc_user() to allocate domain with
> appropriate page table based on flags parameter.
>   - If flags is empty then allocate domain with default page table type.
>     This will eventually replace ops->domain_alloc().
>     For UNMANAGED domain, core will call this interface with flags=0. So
>     AMD driver will continue to allocate V1 page table.
> 
>   - If IOMMU_HWPT_ALLOC_PASID flags is passed then allocate domain with v2
>     page table.
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> ---
>  drivers/iommu/amd/iommu.c | 32 +++++++++++++++++++++++++++-----
>  1 file changed, 27 insertions(+), 5 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
