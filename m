Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66915435ED5
	for <iommu@lists.linux.dev>; Fri, 10 Jul 2026 17:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783702831; cv=none; b=l6VmWEgG5hoBErDx+VThl3yxxHqIp/efK8Kl3toqyXChnYrsGAyt6/BLmJX2JfoECbZixfz5oNIB5J0gtM3qzedNLCgAT0NivqDp1mlIydTqvOXyMH+2haeOwmVRokGKLyTAWkx5f4a9CIkZnDjRLi7Y1zwcvP1RierlwLztGYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783702831; c=relaxed/simple;
	bh=YGid+hr9bqTYrw6cuH0h4G/6ZW94LLXxM1yR4vegyX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LaCtVVZzrbv0PSbEbf5J2Z0rakofVqb3p0m+F/+SSYp3Ue7ddi1353ThWHHqujMzEuQW+rcT2Z3i0SqfzwHENKTDWqNYU58aFozMvYCQ1jHO3nM5cwtQpjz5fdBNzcrk/zdOl9ssnofqUioxRkVKsEK7EWf0aHajkrpnvxbDpXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=R6+r1a94; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="R6+r1a94"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-902f92b8504so5500496d6.2
        for <iommu@lists.linux.dev>; Fri, 10 Jul 2026 10:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783702828; x=1784307628; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aHiYCqM8hSQa7B5ZpbJ9qj0q83p+UmFHrgLIko6Kvoc=;
        b=R6+r1a94V8BjPKnryJIwMRRxUYtSI6T8KYQ5kqfp0Roe7EVs5p7pg54f7XLvinc0Gu
         qC/H0Xfivvl0Lax45hCNF5k9HDOfLvhfZjDkNpxpyJTI3BqaCrHRcBSws1M+PdW4EfOE
         jBWQyGL/48r1XnvS3CBAKcxiLb2I4wu+UWxDQtEyqFXSYf3eoxxXAICM2DU1oG5ZvHOU
         oR6yukXrnE2mAgOgiptRpgUVXMXOXNpDDcRYCoj+66H7CUpVGNlA/1fusAAKwLjJRFgf
         /ywGGU3FXFom9nMuxvJZq7GXBFtmC8KRdsmmt+jHxcTRVVGlDsaSa0HHeRfxXglrs0v9
         WGJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783702828; x=1784307628;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aHiYCqM8hSQa7B5ZpbJ9qj0q83p+UmFHrgLIko6Kvoc=;
        b=i54lwA2Lh0rw+0XNzDpy9W8uW9Xs8qD0fa7V9sD7/rMtnK6npihK7xyuEqpd/VDYpb
         sqZ4lHWPLoDz9QuEzRT960QfV6D2pMfEJ3jnGmUwCeZ7+jDIAHeqGJfSflCzx/YhQ0sc
         o4mshmnBEt0VINMAzDIUAs0CAF0cJD7FB9m7HwSa+7DR5CQUFLG1vKoNm0JUFzfVq4gX
         DfDDP14f/TLRN1G72V+dJmyhFLH8Xl7PyEeO+3H6uW/A8I6vBblo1MMun2qnHWZai725
         l3PtgJr0GiZBpM1lemPMuc27meF2y77lpIWVI3Rbtzv/yEx3GxDxgYyjavp90prWK9Nd
         HWuQ==
X-Gm-Message-State: AOJu0YzfE5XzqoH3v1Ke1saWjpQvVBo4UwbPUXgURcdVy38KF3XO3LyB
	m6wXlzNu7sIKTHI1akD4UOYY0QrNVdOnxecI/PLd2UARC9imHWPRaROq/DqcH+rfXkw=
X-Gm-Gg: AfdE7clnJCusN5T1HDa8eDDUUVE+yw+9V+AzNUCdgam7yV2e8fFYIckz/W2MW+YIhdL
	pqmHFFO4JIGI/U5pQNphIl36DM7iNzKqXUPTJnhqDbuMDgcaF15CjwHGX6w22PBe5aIblQveNLf
	SD5F8bMGGUSOE71oxjn92WPFEDjYrcR1NKCUjlXzStcnkAx1JUmMfjA/yBvI/OquLVznspCbleY
	HsG3/JY1xztlNw4XVwy+PIF6DlAGq5l7APLgY+Ef0GyIfLmmy+gojRs9ceVWFvY51Pq1J8T5BpZ
	LEuJvRpqZ+HtoWZ+yYzJCTYTOn8pUGc8NWdgb/kyBhS3w/7SvRT9wnLrw1Z8TediwDg5f7ukKYD
	Jx1d1piyo+4o4kvLl3WxotZ1yoB8/GojMrOScE1fxFTRBqYl7vT+AC0dDOu+v
X-Received: by 2002:ad4:5764:0:b0:8ee:6e1e:e38e with SMTP id 6a1803df08f44-8fec342ea79mr153526046d6.34.1783702828117;
        Fri, 10 Jul 2026 10:00:28 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd5bbb1e1sm45465696d6.22.2026.07.10.10.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 10:00:24 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wiEaN-00000007aJa-3c9z;
	Fri, 10 Jul 2026 14:00:23 -0300
Date: Fri, 10 Jul 2026 14:00:23 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Shameer Kolothum <skolothumtho@nvidia.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, nicolinc@nvidia.com,
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	nathanc@nvidia.com, mochs@nvidia.com
Subject: Re: [PATCH v3 1/2] iommu/arm-smmu-v3: Manage teardown with devm
Message-ID: <20260710170023.GB1803712@ziepe.ca>
References: <20260629094106.251694-1-skolothumtho@nvidia.com>
 <20260629094106.251694-2-skolothumtho@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629094106.251694-2-skolothumtho@nvidia.com>

On Mon, Jun 29, 2026 at 10:41:05AM +0100, Shameer Kolothum wrote:
> arm_smmu_device_remove() manually frees the IOPF queue, destroys the
> vmid_map and disables the device, while the IRQs and queues are devm
> managed. devm unwinds only after remove() returns, so the cleanup runs
> in the wrong order. The IOPF queue is freed before the event-queue IRQ
> whose handler uses it.
> 
> Manage all of it with devm so the unwind order is correct. Free the IOPF
> queue and vmid_map via devm actions, and disable the device from one
> registered after arm_smmu_device_reset().
> 
> This is also a prerequisite for fixing a Tegra241 CMDQV CMD_SYNC
> use-after-free in the subsequent patch.
> 
> Cc: stable@vger.kernel.org
> Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 56 +++++++++++++++------
>  1 file changed, 40 insertions(+), 16 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
