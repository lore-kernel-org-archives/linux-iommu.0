Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5AC354AD6
	for <iommu@lists.linux.dev>; Thu, 22 Jan 2026 23:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769125068; cv=none; b=UDbRyLKdU0xlse7DufYJD06AXU+VfO7VX7xebfehCahUBEDlOUKVj42aE6qBdMNOCr1ZlH2B/TUi0XUKay9u8ZcSWQ9RGYYpZJRxBRI1is9yrvCTmsm3n/KKgmUQ08ttenWcWj/N28Nb+3Ze0lHFFDKu+wzb5NPuFgT0iiszN6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769125068; c=relaxed/simple;
	bh=6XGtJQywpqmosyYrCosqc3I9CRVHTZWO+/CMBFEch+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sXPrZGDTGANkuT8z+IpxNhZ0PjVlmeY9Lf1n7NRAtzvojxqukZ8KzsL7Ncd7bs5SIvvBcm8cqI8tmgpDxnvJo4T1d/Rvevth8W566jWLXetb4rlQ9Q14aO/PDo5WuR7fJ44QJ0mwwkD3M/Rq1GLamo+d6DgQbh5+sH6p/jKrvq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ck7Zx8X9; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ck7Zx8X9"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8947e17968eso17558426d6.0
        for <iommu@lists.linux.dev>; Thu, 22 Jan 2026 15:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1769125061; x=1769729861; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FfXBu7LAWDQnsgm7Hb+Sdya9B9wy+rjzXCa0xANmbwc=;
        b=ck7Zx8X9fgp+osppFoQJEjXo3VjnKXmFVbK5EixdSz08v+MPeEyy6prKl7ePe7E4xq
         74WIsOn/0L1d7rNOFrQ5pBe7oSpoCbHrGxlFeeU3W5SjjI+Mitk58DRIkdE2wN+WioDZ
         kn+JDILzo99iHmxQIAVr1dtEN1IuaiO0fBajrPoeFYc3Tb7kCn4Dlw7s2lny+bi+PK0y
         GPGZIM3+bQKkLXAroHkThyXBlYk6X33GLNVbk71pmGP+2w0iskdCP+MCUjC7rd0KQ/xH
         lL13ny5848v0ilrrW6M5Bl93XEtj0ODQS8qTiD74JPUczo0qV8RQgLpCBPQML0ZAO5NJ
         goCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769125061; x=1769729861;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FfXBu7LAWDQnsgm7Hb+Sdya9B9wy+rjzXCa0xANmbwc=;
        b=a6Ir+p8qoB/GIiIb6x4/WbHV5fDoQyTUORMaip9C09pcsLMT4zex3+f1JFwrxwBd3A
         t4fOTQMAQraeUkZbLuuwYDZBMyEbrH0512OFkOSKhCx9a+SMj2SXG0I6Nzw+HftjJ0w4
         /dn/XLCA/B/5kXIuX+Xgwaeijr+9oFO7kThGwZ5GgcoWp7Ypy3jK+YQgA8PT9FEHH186
         N/N95qVezYT0xXZM46z7H72xjrKzB98yY54zYYMcCfqG1P1VmpzUMHDZp2eDtmUhOXqV
         qJUxMKRcF/AOJr3Nfvp2pqY8poRq1T6nKrfjiEODBf6hOvjMdKER9aQ8iAyIzP/3wczE
         HKZw==
X-Forwarded-Encrypted: i=1; AJvYcCVddQEhcqWJ3JH/bjnC6JGi5w05isO2Mb9D4Dij1IvDDNB6wK5+TvN8fzDikB3YoQQ45jOa7g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzIYH9VycAckohV4ZW1fV0yRWOd3jUS627NEmJv8nebEF81AQeh
	jh4/gKieJuydqcn5c7PwjdcUYcTuQLUqPPphruI5Rc1sicjoOT3Tufs5ItyuawtIUjI=
X-Gm-Gg: AZuq6aJOKSzrgkKJZLH2KZLc8xMCvzMWTAMgxLNj9CeM3CJg9Lt9R89H/XFT14Ma9yQ
	E4f5afbuoSI48+WNRJiX9TqHmkRrXUWUJMjjCYtyJ9UT2vsU7zDqbPlULNUKaiJipWavPUkeFT5
	YgknDNVejTpfMbpISu09wGqQURIYrDk/Ee+pLU3fRRG+HzRLlldXVO+IXZvfOH0y1WovHMPxiIQ
	Zt5Tn/vhsVo0FXiEBGqcWJtw3uuODR3cSTDTdgL9oriOsTVag+VMAB9JemR6ulLqxcy4UyVOUvP
	JvZvHodPQ4g9y/1EyIMXgCWjwzTyMrPkrD/+MbDTE5zZ9HMpabIiyvkaxt71WJo9FFYkce5Cu7t
	rh3/ebRqC8Ulo11OIVKE1i2owY9k/18Gfq8wJ/OI7bZNk7qAqZutaELgnR3c9e8+8SAmutXfHwT
	wE1WvTJKF3/+nKZN3qAXwkC5YzqBYKuLEXdzXlLvBpbreHD0H9vSHt3XPEKwiKQXd/wIA=
X-Received: by 2002:a05:6214:c2f:b0:88a:2fd1:b582 with SMTP id 6a1803df08f44-8949022bd07mr17695716d6.47.1769125061444;
        Thu, 22 Jan 2026 15:37:41 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89491821e98sm4770066d6.9.2026.01.22.15.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 15:37:40 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vj4FA-00000006gPw-1bNk;
	Thu, 22 Jan 2026 19:37:40 -0400
Date: Thu, 22 Jan 2026 19:37:40 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/amd: Fix type of type parameter to
 amd_iommufd_hw_info()
Message-ID: <20260122233740.GA1589888@ziepe.ca>
References: <20260122-amd-iommufd-fix-wifpts-v1-1-8ee604527875@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122-amd-iommufd-fix-wifpts-v1-1-8ee604527875@kernel.org>

On Thu, Jan 22, 2026 at 02:42:38PM -0700, Nathan Chancellor wrote:
> When building with -Wincompatible-function-pointer-types-strict, a
> warning designed to catch kernel control flow integrity (kCFI) issues at
> build time, there is an instance around amd_iommufd_hw_info():
> 
>   drivers/iommu/amd/iommu.c:3141:13: error: incompatible function pointer types initializing 'void *(*)(struct device *, u32 *, enum iommu_hw_info_type *)' (aka 'void *(*)(struct device *, unsigned int *, enum iommu_hw_info_type *)') with an expression of type 'void *(struct device *, u32 *, u32 *)' (aka 'void *(struct device *, unsigned int *, unsigned int *)') [-Werror,-Wincompatible-function-pointer-types-strict]
>    3141 |         .hw_info = amd_iommufd_hw_info,
>         |                    ^~~~~~~~~~~~~~~~~~~
> 
> While 'u32 *' and 'enum iommu_hw_info_type *' are ABI compatible, hence
> no regular warning from -Wincompatible-function-pointer-types, the
> mismatch will trigger a kCFI violation when amd_iommufd_hw_info() is
> called indirectly.
> 
> Update the type parameter of amd_iommufd_hw_info() to be
> 'enum iommu_hw_info_type *' to match the prototype in
> 'struct iommu_ops', clearing up the warning and kCFI violation.
> 
> Fixes: 7d8b06ecc45b ("iommu/amd: Add support for hw_info for iommu capability query")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  drivers/iommu/amd/iommufd.c | 2 +-
>  drivers/iommu/amd/iommufd.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com

Jason
