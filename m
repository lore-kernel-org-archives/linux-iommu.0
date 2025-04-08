Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D234823C8CA
	for <iommu@lists.linux.dev>; Tue,  8 Apr 2025 21:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744148312; cv=none; b=hxSDop0Vzsx8LN1J+cGYeR41h58JEdjEL0QlvI1avFGpQMHzF3Z8TqJZAIhjZtaP5lvgMhR3xUbH7QaAsXFruzeElZlrJYVBIXt/uoLYaQdj6UCaJAMYvFvFCZOp9FsdATSy4UVDlroFe2eBpIEq4JJwrpA5r5AqlscAR2WFITM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744148312; c=relaxed/simple;
	bh=pu/YuOWH/Lc2fBaut8InW6ICN95wTACJ6MxryaqAaMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BEJOaOmQPiAve8E7FrZ4sdjIzxUPjRmPQRgrZRbz0krtQs+uqDkiyV7CNc5jUZtKBynTxDytVwx0tCXQDrwwdhYWJ0ZqzZvOD8XjqE/DcM0UaXC00xN2I2Yg/H1KtzdnPjw+dDHm2xQoHAviq2Hj9MxYDfyoIcj8cvQiTStOmWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Yb/PkHyt; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Yb/PkHyt"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c56321b22cso13492985a.1
        for <iommu@lists.linux.dev>; Tue, 08 Apr 2025 14:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1744148309; x=1744753109; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yxv9o50eGddEsUuD/tRbYvSgVoXDvHyaDodMka2QGFQ=;
        b=Yb/PkHytslMak66ad7KY7zgjudQHWJHs2K6f6ua2VjE4HyZOzjUQYnPy+S/ca61TZ5
         4TTnhxZX1EmCyIgRCC80QA7FB+MX/FOKCyKSa8pfCAtY7DBBtwpcYfK/HQNeyqcncMXo
         RE7IPP9CF3iLvPrTRiQJTECKelD7EoiuSiJrkhu2Wlg3P1C/twER/DYBMBZVVkUPqvjq
         8j2osoEEJk4WACeBopXt8Tmnn269OTajj3u57OU93vmdYAywrQCNzOFqIKjlvANRcg0i
         MfAhZk/gg1+5T1AYOfotBMm0asw6R7ZotrQOzw1y2sZcJalWsuo0hx9AU5Z2O3f+FHmt
         /yFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744148309; x=1744753109;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yxv9o50eGddEsUuD/tRbYvSgVoXDvHyaDodMka2QGFQ=;
        b=sj8ArTwF0d5zTzkxRJfBhp3v/Gyq05czrfHjvETogpeFAiAlWe3cypWaLlr3wyUEXw
         tiE6PiRKFn40vxyqMXoVUgjqK80NeJWv+krHLJ1Fvrc9sOALDx+8tm5+CgC25PCSfHoM
         LzjrThu9SIsk5amFkSVaXRfHRYtgQnoW1eZxfPFLWCUdDkAk8ishvS57XhKwHzrj40Jm
         5+Ye1sVGPsXb1vv2DAINHVH24RsV2QHAQvCIUxPwmRTjLN4QVOQ+6whaCksTb0BvNM/0
         gpddZLRkodBaX5HEdfogQ2TjS7tqZO3hH4PJ6vF0BO9xGHWL+Ey/I+ve5O1gC7Zm27g3
         yNaw==
X-Forwarded-Encrypted: i=1; AJvYcCUBgVjgzHN5krZ+PBoSs0HBjsMBYq5ZIdNevTZeyU2HV0Gh1DYqzMmzYmC9KFE1Aq/BvMKrug==@lists.linux.dev
X-Gm-Message-State: AOJu0YzA8GzbGUUKvVoJvwoS73FPq1biqEXPxY6Up/lR8O5NTatrdf8i
	UBaG6nIHablBV688UzvlWGLPdWR4UGCv8ypYKFZ8yxi01zxf28Htdfs7qVxFk4A=
X-Gm-Gg: ASbGncu464hzrX7ZNbUAMdAnGx2NGGEa7Km1Q0uvjPa+YZUHSxDXZhRH6G7gXQ+KG7R
	Ja1pqRfHT7eYJseXVv37SDin0sPi2T0YABJnQdQ8frnjuVtj4r/Xgp1T6Ggm3Ki+VN/l0AwBzCn
	1dWx51ykx9DLrr3qiLGFGJLApTYRlbF8eeIZVataKPM3Tr9rgKcm2RR1pYe6hkCnUXabbwpch8u
	anEBpywSXJ+AJgPRYOVE0Am/feu8US4HVuoNvVsac7hsM/FngI6wb6svr4c9tM4RmxOy4qw198H
	NmKpmuX1kKAva22+crRYWqX99WBNyn9liha8CTZzv7U6qBKjFm0+tSiaGEsZ20nyuSxR0n0cgIy
	1QTwZGtLReViEA7ys816EMN8=
X-Google-Smtp-Source: AGHT+IHk6WbyFTIcWDV5GB5Os6d2NKq5gE0pldA0lJWoLAcbSrKSUgBHDiW5s9PcXNYkhgATyty6uQ==
X-Received: by 2002:a05:620a:2788:b0:7c5:f48b:3c8 with SMTP id af79cd13be357-7c79cd473c5mr126299485a.14.1744148309611;
        Tue, 08 Apr 2025 14:38:29 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c76e94bbfbsm809430185a.46.2025.04.08.14.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 14:38:28 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u2GeK-00000008mG1-1mIv;
	Tue, 08 Apr 2025 18:38:28 -0300
Date: Tue, 8 Apr 2025 18:38:28 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>, Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] iommu: fix crash in report_iommu_fault()
Message-ID: <20250408213828.GC1727154@ziepe.ca>
References: <20250408213342.285955-1-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408213342.285955-1-pchelkin@ispras.ru>

On Wed, Apr 09, 2025 at 12:33:41AM +0300, Fedor Pchelkin wrote:
> The following crash is observed while handling an IOMMU fault with a
> recent kernel:
> 
> kernel tried to execute NX-protected page - exploit attempt? (uid: 0)
> BUG: unable to handle page fault for address: ffff8c708299f700
> PGD 19ee01067 P4D 19ee01067 PUD 101c10063 PMD 80000001028001e3
> Oops: Oops: 0011 [#1] SMP NOPTI
> CPU: 4 UID: 0 PID: 139 Comm: irq/25-AMD-Vi Not tainted 6.15.0-rc1+ #20 PREEMPT(lazy)
> Hardware name: LENOVO 21D0/LNVNB161216, BIOS J6CN50WW 09/27/2024
> RIP: 0010:0xffff8c708299f700
> Call Trace:
>  <TASK>
>  ? report_iommu_fault+0x78/0xd3
>  ? amd_iommu_report_page_fault+0x91/0x150
>  ? amd_iommu_int_thread+0x77/0x180
>  ? __pfx_irq_thread_fn+0x10/0x10
>  ? irq_thread_fn+0x23/0x60
>  ? irq_thread+0xf9/0x1e0
>  ? __pfx_irq_thread_dtor+0x10/0x10
>  ? __pfx_irq_thread+0x10/0x10
>  ? kthread+0xfc/0x240
>  ? __pfx_kthread+0x10/0x10
>  ? ret_from_fork+0x34/0x50
>  ? __pfx_kthread+0x10/0x10
>  ? ret_from_fork_asm+0x1a/0x30
>  </TASK>
> 
> report_iommu_fault() checks for an installed handler comparing the
> corresponding field to NULL. It can (and could before) be called for a
> domain with a different cookie type - IOMMU_COOKIE_DMA_IOVA, specifically.
> Cookie is represented as a union so we may end up with a garbage value
> treated there if this happens for a domain with another cookie type.
> 
> Formerly there were two exclusive cookie types in the union.
> IOMMU_DOMAIN_SVA has a dedicated iommu_report_device_fault().
> 
> Call the fault handler only if the passed domain has a required cookie
> type.
> 
> Found by Linux Verification Center (linuxtesting.org).
> 
> Fixes: 6aa63a4ec947 ("iommu: Sort out domain user data")
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
> ---

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

This should go to rc

> > iommu-dma itself isn't ever going to use a fault 
> > handler because it expects the DMA API to be used correctly and thus no 
> > faults to occur.
> 
> My first thought about this is that iommu-dma is not interested in
> installing a fault handler ever, okay. But why does it suppose that no
> faults would occur? It is a matter of "chance", firmware bugs, abovesaid
> DMA API abusing, etc... isn't it?

Yes, it should not happen, this driver is clearly buggy.

Jason
