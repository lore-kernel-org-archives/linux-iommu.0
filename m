Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679C9155336
	for <iommu@lists.linux.dev>; Wed, 19 Jun 2024 16:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718814889; cv=none; b=rXpw7ZBd1oUeQrLl4O8CRZLtoOLqF4gdXeK10OoXiE0DAzpnv95jxjJd1N0k+2kvX40zi97XZ0WOGvEi6s3GagAWRfIib332z0pxjyeS4v/G6hFHLT41u7MNlnrtPYUwqz0qN6JvYgzPcJ/XMFyU0H0So3ophZYXjYgrgZLDftY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718814889; c=relaxed/simple;
	bh=vz3OyqF6PjBb+NDoBEl8crxXV6LQcMi1lT8jRt8+XwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lbWWib1xZGI0gJoOR7N4M0fGFFE6hHmFEFL2/m1KjNiPbXZ5k1NRn9Sk6K9NCkPuC9EdeISW8d2Awjk5jWYw5d/lr2EPWJpj3oXj0D5pDcxgWIfB334S5KrvI/75CkN89LPuk/bTKKBG/SZZcduEJEdbOApf7pd+HvMx3mzHVlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=pUE8LaSx; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="pUE8LaSx"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6f98178ceb3so3792435a34.0
        for <iommu@lists.linux.dev>; Wed, 19 Jun 2024 09:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718814887; x=1719419687; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U0Z3MILfX5zi94LfosxPsrOvnWTNdLm10NYSBu4aEWY=;
        b=pUE8LaSxOYsYsf/8nIlOnm4Nn4lpmApISpfQvxPeT5XYjGwWSXGY37qX4JTS02M5+R
         jEq7nR6o4KKuFb/HG4gohsW2PPVDQiftRzo4+YcbPIw91SwbOG+s0H6iAnCHgpZlI5xl
         zT9JgxjW4cWP3lOS9AC3FtSAGcul30SGD5nrJAe29hfAcfsx2aMQAQwSXl4p6hDumL4Q
         wod17pinsXmdDCmSlfiiWDo8LPvmwkZfSZC0c1XNoLjxT0vS7AidGyl2KMF1kBnSh9TQ
         PfNYby2nMeEeIDvADKGHBCEM16Qg5U0wu+T0m2oEHX7VUaZQGVX6uZe7LORn4xZweaU6
         m8xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718814887; x=1719419687;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U0Z3MILfX5zi94LfosxPsrOvnWTNdLm10NYSBu4aEWY=;
        b=qsyWQ0OBLdeutQ6jGHf5gG4/xWiMWk4fsc42Y3xrQqZp+mJgUfbjeLNsu0UwNLOfAT
         sYgj7JuDR1xWqF86+b79mt7wB6w+YEMX2MZf289iNHpp6lsBrf+LzHev4eYpAJS9N32Q
         ovjX59map9yrQBhb57vtL/w8h6NmgWrtyWuFvvAHuX3ECsr4Aom9roRpJfXXH3YB9t+R
         Wdp0mg2i9miG7vqE34zl/UWOtxNNokvNsDt3CgipQvDBvXnyNTP6AbRlTJtDkp6x91kY
         MXscUKlNHytW7piUbGbL2ISGhaeNVff5kJ6KL6vyBcKBf56dHly7Hq3nSHM3Xu2YO3xj
         p/fg==
X-Forwarded-Encrypted: i=1; AJvYcCXkbruy38i+lxUU5Zv43OEP9lKguyZI3RWfY6G1SDy/KwNJKK936tYvaih0Xfx5HTYBFD+zEXoWwN6vHcfgn3GyVxYbkJk=
X-Gm-Message-State: AOJu0Yz4cUh7P52BdrrLrXsNq8h1muODq02i1utQdySZpyz032ya75aI
	c0Mzr+T265EVkIw7142mdd6Ahm2r58lrMfTasmL+lUszcXSpEGfuy2SzKLfx/f0=
X-Google-Smtp-Source: AGHT+IHbLaigtw0mJHzx/yQd28ehpS3L1U7ULHkxwkCKVmyGufSvndmmDVZaVUaeop0hhX6BCYc7SQ==
X-Received: by 2002:a05:6830:1243:b0:6f9:aaab:d34f with SMTP id 46e09a7af769-7007365c28amr2973145a34.6.1718814887452;
        Wed, 19 Jun 2024 09:34:47 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b4f8754a9bsm17821726d6.92.2024.06.19.09.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 09:34:46 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sJyGk-005ArA-0i;
	Wed, 19 Jun 2024 13:34:46 -0300
Date: Wed, 19 Jun 2024 13:34:46 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-v3: add missing MODULE_DESCRIPTION() macro
Message-ID: <20240619163446.GM791043@ziepe.ca>
References: <20240613-md-arm64-drivers-iommu-arm-arm-smmu-v3-v1-1-0e9f7584a5c8@quicinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613-md-arm64-drivers-iommu-arm-arm-smmu-v3-v1-1-0e9f7584a5c8@quicinc.com>

On Thu, Jun 13, 2024 at 12:44:17PM -0700, Jeff Johnson wrote:
> With ARCH=arm64, make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.o

Weird I never saw that..

> Add the missing invocation of the MODULE_DESCRIPTION() macro.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c | 1 +
>  1 file changed, 1 insertion(+)

Fixes: da55da5a42d4 ("iommu/arm-smmu-v3: Make the kunit into a module")
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
