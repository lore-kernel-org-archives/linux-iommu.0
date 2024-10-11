Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2F2183CA5
	for <iommu@lists.linux.dev>; Fri, 11 Oct 2024 16:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728664316; cv=none; b=MLRwNB59n1Ek44Bo+otG5Y+MDJ+63rRN0fE+u17f/L+ATFA5rWmwhc+A7z9bOp1G5TovTL7dA8srM/c3HxUZUNbprTEHcVVLntszh8EHMsXPpfic/I0gxMeK+8kGuCE79i8fSXIguePfIgxbSGyr/tDLEmDNRv0APfBy+PBR2FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728664316; c=relaxed/simple;
	bh=woSR6Y75fZOeQBGQO24VdwIFZvxkz6FLKJFAaRwMgJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MR9+7ZMC5ZlgMSDU5IgZ/1EMYbHty288NgZV1pou2wxTAsX0DS/CK4TwSo23bHvh7G0OU2f70636tIM0p0qjDS8ny9IN+HCDcMMb1jX6Zieamw7FaoS+O3VidkiTxG6O84+HU0dZGa/yk6gPGC42cio7xSV5tIPNsVyPqN7Glbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Ckg9Av5D; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Ckg9Av5D"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7b1205e0e03so7302985a.3
        for <iommu@lists.linux.dev>; Fri, 11 Oct 2024 09:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1728664314; x=1729269114; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NwEPzyjMz9lNyBSEKsUJavhwQs/1hDwuBWtKqgoIY1I=;
        b=Ckg9Av5DGcRizkllN23+tPdAi6Ev5H4QGxyW8w/zS7mETdMOtjV2XJUuDO145Mh/Xq
         jxe4AWRzOtrEVBtJJfL/mOnVHTV/PwJwF9S+LhOcWDrG8rsNlpQgncI2GfFzaEQOBk0+
         LhADP0SzenWuB3Eq2DY9yZO9Jg0oSsA1fpT9G/d7NOz3rR3Qbo6kf0HNorM0j7B4nWeW
         QmbhpvkS58qb67yP0KR+4TJ2yV8OKbctLOTqFkY893NtzsBM9iVtoYWUJcUPkicpLnQJ
         xMmsWSlL8bARlqIWl5zutUVH1QbT1aFw/n9aQtnBtDfM6GNsqqhouU2Wop9lIhI5CdFb
         YPJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728664314; x=1729269114;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NwEPzyjMz9lNyBSEKsUJavhwQs/1hDwuBWtKqgoIY1I=;
        b=qZy+aMCUjXSP0I0v2diWyrg6JAdCgHul2ZY73gpprXE4ExOF8Xxbm+MBVhqQNkuq8X
         AaHYUNLm96sg33+2M7vlcI4O396WnbeoYyC3lZl4OwKWv0F5pFZeakciIJRa9IW3cmWc
         ZUE6wVmIUSCS8fLkzc8YDdU/ZK81peSqaDS4E/8cMqT1+fR64i7mp89U19VIdgYQ+Srh
         Go33kdH6httTer/BgotrL7nMPInYjf7l3v+E16U1VyipNnj+HmpN9TZGHOURwGm6ZY7+
         FOjxKNSArVWDSrA4xHOEYYFNYbVTFC23ue2LZtMArQf/+s3UuqMjaC8SXDmceiQdI9Gp
         HJbg==
X-Gm-Message-State: AOJu0YyDwUGZPE+8QB7HTySeMyXbQD8p4aqG7E3k5QGdayEZtbhMAObR
	c6tj/k8Wu8v+bwrolnYM21KJxkq5qaPdJWrkrkujvvi4Fw8gt1/aeDl4UcmGJ5Y=
X-Google-Smtp-Source: AGHT+IFSqYpeyoL3JBtt2icvevdHUOGvDnGIXVpy91lCgbjPXgn3EqB0Bri9z5CcvXC6KNpLC2+w8w==
X-Received: by 2002:a05:620a:2622:b0:7b1:1cf6:cfb9 with SMTP id af79cd13be357-7b11cf6d056mr281355985a.55.1728664313746;
        Fri, 11 Oct 2024 09:31:53 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b11c0a8902sm55860385a.31.2024.10.11.09.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 09:31:53 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1szIYS-007eRe-Rv;
	Fri, 11 Oct 2024 13:31:52 -0300
Date: Fri, 11 Oct 2024 13:31:52 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	Vasant Hegde <vasant.hegde@amd.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] iommu/vt-d: Refine intel_iommu_domain_alloc_user()
Message-ID: <20241011163152.GP762027@ziepe.ca>
References: <20241011042722.73930-1-baolu.lu@linux.intel.com>
 <20241011042722.73930-8-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011042722.73930-8-baolu.lu@linux.intel.com>

On Fri, Oct 11, 2024 at 12:27:22PM +0800, Lu Baolu wrote:
> The domain_alloc_user ops should always allocate a guest-compatible page
> table unless specific allocation flags are specified.
> 
> Currently, IOMMU_HWPT_ALLOC_NEST_PARENT and IOMMU_HWPT_ALLOC_DIRTY_TRACKING
> require special handling, as both require hardware support for scalable
> mode and second-stage translation. In such cases, the driver should select
> a second-stage page table for the paging domain.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
