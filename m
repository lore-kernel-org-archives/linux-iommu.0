Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C9B3AC0FE
	for <iommu@lists.linux.dev>; Mon, 11 May 2026 07:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778486213; cv=none; b=DWmkgdjg/Y43TSGgMEMu2C3ihQ7TcvfqJhYqoSX+OO7i3Th7iJ7A6J8DwbsHl35KyGiC3A+dT3EWSnmTHbypfc6uKcK+gCYUTfV3VzDFUPsiL5R/mjfQa4TvxcAjFAp73758frL2h60wfTWJQI6dbRKcG0+2LyLp3xfDHGwGHuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778486213; c=relaxed/simple;
	bh=kdL4PNsOX6mz5DbR4xt+4lvMH7nnV1ort4ldJMlDfJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QiUTAAf+7AvqRxeciGRwyVT+O9i2IcPvrvEfajMkENCr1j9Xh4TG/kuHcNEm8gAavvgdyygcZBTw778y9trQbSGwTJfc8wprLhxUNNdVNSJ+LNIBy6sIABxbByWzpvZGjGC/thIIZUuF1/K//7H6CH1ygVjDn/G9YMBKp4jED3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=oQD9nSEq; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="oQD9nSEq"
Received: from 8bytes.org (p200300f6af1d9600f5faa5cebd6c042e.dip0.t-ipconnect.de [IPv6:2003:f6:af1d:9600:f5fa:a5ce:bd6c:42e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 41ECA1C3E81;
	Mon, 11 May 2026 09:56:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1778486191;
	bh=kdL4PNsOX6mz5DbR4xt+4lvMH7nnV1ort4ldJMlDfJI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oQD9nSEqlCi3VNSUVxTGVmL7V2OTyE9VZOFViIb3A7DckknaIDAsckH/K0/XoTCMk
	 nPEoyVckdez7Da2ub6bIAM6p8oHDfQQfIaIPIJkM+YyIVCQIc2c3T2V0V8yG1x9uNv
	 kRAItTkUYpCGOMVBK9LNCCjGDKYiqctK70HvcY/l4G4L4HxmjXyw6h65ySXYTGaL8X
	 mV2UTOgO90Oj7Magxx4CvP8VGRTy3WSkRjS+u/7ZDjuq0OVLcjcn6QM0LndtY9hLUU
	 BS+SyLs9bWYQ8s0NDyZjBBg+/9xwPdOYLNRNremZ9ovcugTIlQEPF66PWpOOmzHmv3
	 VzkCZs9RFLcQA==
Date: Mon, 11 May 2026 09:56:30 +0200
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: fangyu.yu@linux.alibaba.com
Cc: will@kernel.org, robin.murphy@arm.com, pjw@kernel.org, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, tjeznach@rivosinc.com, 
	jgg@ziepe.ca, kevin.tian@intel.com, baolu.lu@linux.intel.com, 
	vasant.hegde@amd.com, anup@brainfault.org, nutty.liu@hotmail.com, jgg@nvidia.com, 
	guoren@kernel.org, iommu@lists.linux.dev, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] iommu/riscv: Support Svpbmt memory types in
 generic_pt
Message-ID: <unecry3tpor6u2dnitimpenvmet56ly72p6mfsfqmcupowo35u@vuju76n33jqo>
References: <20260414110212.79526-1-fangyu.yu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414110212.79526-1-fangyu.yu@linux.alibaba.com>

On Tue, Apr 14, 2026 at 07:02:10PM +0800, fangyu.yu@linux.alibaba.com wrote:
> Fangyu Yu (2):
>   iommu/riscv: Advertise Svpbmt support to generic page table
>   iommupt: Encode IOMMU_MMIO/IOMMU_CACHE via RISC-V Svpbmt bits
> 
>  drivers/iommu/generic_pt/fmt/riscv.h | 8 ++++++++
>  drivers/iommu/riscv/iommu.c          | 2 ++
>  include/linux/generic_pt/common.h    | 4 ++++
>  3 files changed, 14 insertions(+)

Applied, thanks.
