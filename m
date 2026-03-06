Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE3636F404
	for <iommu@lists.linux.dev>; Fri,  6 Mar 2026 19:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772825727; cv=none; b=ZqEYs+fKdc2R74pu/A9Cin966rt1tYOKS1lqrS8Tx7AX42x+6UuhZW7QOewiGn1/r5ncp3BcAoB9L+TyMdx7rFqs64U2ihsxCiW4Ck6jfvz+n42WkC5VBvc97yvLhJlfrRf+8TtiYWy605hkAnnywzVKX4GiBpLms4j6iQITMfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772825727; c=relaxed/simple;
	bh=Wh5Z913UZEh7i6f061EXZd6SLJhL4kwsCncFeqW4SCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F65mIauppZZDGWM0WU43WDknPKWbD8PEeUs27Kdf8Rcxmn3J0ktnR7MhQ6HiIE6AbnGwmXy0/jd29C5Xaq9LQDHrdcgN+Cu6seyKhVKVbCc6NNsYBGIjR8wf/De7Bc/9loz0pBdwYmjZr6eJ8471XO/wg/7/n0IaHoc6Zh5y7Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4CRVl5Hx; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4CRVl5Hx"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ae3f822163so10265ad.0
        for <iommu@lists.linux.dev>; Fri, 06 Mar 2026 11:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772825725; x=1773430525; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wh5Z913UZEh7i6f061EXZd6SLJhL4kwsCncFeqW4SCA=;
        b=4CRVl5HxbkHRljHaJrTUkjNpdh4XQVAnnMxhIpy2PRiQPb8PXJHnoWb48Tvgcug8Ys
         mT62m6HhuJJHpboH3Z0mLjpliklp3xkI9rnRxIM5SrZaP2BYGngFckW1Y62pVp8HhVNY
         aT3juq5IvxQNgHvh8lmGGnyV7F8GBFNB8KORn16EDu9XXkBs/EEoKC4MaSoLFJKLwxVS
         rM2udqTzsO/+YKHp71U8QvV83wtA46CjQfkgMg+2capeBnJaKFHlskisYR9SnUus3wlv
         QnjOvijh3ip4m2zALcbx+gue4NARFDVetF9JJ7pPeCZElK5XmbYC8NDnO8Pm2Vo4qzUx
         S5sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772825725; x=1773430525;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wh5Z913UZEh7i6f061EXZd6SLJhL4kwsCncFeqW4SCA=;
        b=NIErVXdL816M5ZEYi3P6AB7ViGYVDDgarJLZ+28NsRXC+IuSOzJ88s/lbrza/RLRNd
         gyiwZyd7K8TvF/VEuazV1CTQOOolHUALSkhBYgpBvsT/YYgxVupRCSQ1mpsaWAfKIGDi
         CEkK6N9UZILdxN+cfTboDdFlSrHIEhmPijvowEbxC8CDn3mHC5HpBYb5RCLYtzcRvZzj
         5AIzUNb07ZjE5BnqV78aQu4IW52xFPQ7k0KBjddpglBPALbCy2R7aP5MKReY2d1gkZos
         iSuIjkHr/YAwoZ6E9iYnulmCZ3YVrXDKINlzk/1EWeRoe4DhUcM49/vaiJdnM/ovL4R+
         B+GA==
X-Forwarded-Encrypted: i=1; AJvYcCXDaMn5cS1KfONbRgCPNoINiLi/Ew6jL8bxuFpgGakwwF1crSxzJ5p2sLuMiR1IHgL9vNyhKA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwuzsBKZvQgzvXkCPnq3AmAGd1ZvWEpWa8IGyHvlt8Jd23HT5e/
	fmU62M9eZREF5pUvk6fVrKT3zOqRhrUN7/Fhux490+KCd+nHXu3QZgscPgXr8RuqkA==
X-Gm-Gg: ATEYQzwdL4wz0poH0qMLMGX8aZnTzyFxtH9Bt8+ScRn7JN3fqbOyti9v6O/lKW66yGb
	/ICp7wYGTYCx5NJIeWQKiOe1zXR65Ia/QA/jvP4essuiA5vR0A9Zys4hPHwaLDbBoneRJuUhDFf
	BRV8KneY88ZN8cU1SFtswsjDQKWM3CiSixKSB1JIXTN9x96GnIrJy/ZoHb6OyI9UXqQgyy5vqC5
	lfY6XGVfcHLj7tb1+nUKtdZSXBawFtH5Rmm9D8DHJbNoDekH0IO/QYrM3ZXscc8QMEKYwW04lJL
	6uOxoLH2MoLPTjwvZ6RAMXLt/wQPxLJKOJGaaopsr2EP03hpgLPyfFMne0SKMvzshv9z6ZPVqxf
	dqnP3wXnngCEYRE3ZWob2cj06VkftCGCEK7VlbTEfFbv//SuCSjqxuABeN5GRayC91gTcqUb/3h
	x/35ApjTUXABPaafrGTNvS0P3S7JG9N9ONSEmACWgWJi6FICPGTZf+/jY1zNs3Lg==
X-Received: by 2002:a17:902:f545:b0:2a7:d266:d84a with SMTP id d9443c01a7336-2ae8ae4e111mr191585ad.17.1772825724928;
        Fri, 06 Mar 2026 11:35:24 -0800 (PST)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83fb3cc3sm27116245ad.73.2026.03.06.11.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 11:35:24 -0800 (PST)
Date: Fri, 6 Mar 2026 19:35:19 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, 
	bhelgaas@google.com, rafael@kernel.org, lenb@kernel.org, praan@google.com, 
	kees@kernel.org, smostafa@google.com, Alexander.Grest@microsoft.com, 
	kevin.tian@intel.com, miko.lenczewski@arm.com, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-pci@vger.kernel.org, vsethi@nvidia.com
Subject: Re: [PATCH v1 2/2] iommu/arm-smmu-v3: Recover ATC invalidate timeouts
Message-ID: <aasmWvA-sqi0KJwO@google.com>
References: <cover.1772686998.git.nicolinc@nvidia.com>
 <ca7ab934bf0f433b62a5c15d42241632c4cb9366.1772686998.git.nicolinc@nvidia.com>
 <20260305153911.GT972761@nvidia.com>
 <6416b7fe-0190-4c7b-9a62-5da7d5eea794@linux.intel.com>
 <20260306130006.GF1651202@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260306130006.GF1651202@nvidia.com>

On Fri, Mar 06, 2026 at 09:00:06AM -0400, Jason Gunthorpe wrote:
>On Fri, Mar 06, 2026 at 11:22:52AM +0800, Baolu Lu wrote:
>> I believe this issue is not unique to the arm-smmu-v3 driver. Device ATC
>> invalidation timeout is a generic challenge across all IOMMU
>> architectures that support PCI ATS. Would it be feasible to implement a
>> common 'fencing and recovery' mechanism in the IOMMU core so that all
>> IOMMU drivers could benefit?
>
>I think yes, for parts, but the driver itself has to do something deep
>inside it's invalidation to allow the flush to complete without
>exposing the system to memory corruption - meaning it has to block
>translated requests before completing the flush

Yes and currently the underlying drivers have software timeouts
(AMD=100millisecond, arm-smmu-v3=1second) defined which could timeout
before the actual ATC invalidation timeout occurs. Do you think maybe
the timeout needs to be propagated to the caller (flush callback) so the
memory/IOVA is not allocated to something else? Or blocking translated
requests for such devices should be enough?
>
>I don't see how that can be made too generalized since we are running
>this flush stuff in irq and reclaim contexts, it has to be very small
>and targtted without memory allocation or sleeping locks.
>

>Jason
>
