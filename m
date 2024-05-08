Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC871372
	for <iommu@lists.linux.dev>; Wed,  8 May 2024 00:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715127912; cv=none; b=ZShtVbJe35c/ik2hFtE/qtH2b+/Dri2LSqpGWwrKbr0RFVl/YZXj6nLw2CstHeXWGb6m6+5d9Y4pJR4ogJSPE+N+6RheZ9jwsxc0m5iBxsNKE+da4viofNGCCjxQ21Ugin67+rfyWZ/+oKnYTdcFLYYQelLYT37W/WXz+w50A8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715127912; c=relaxed/simple;
	bh=lwJncAe+bf7pRUOxcV0HmRnNwUlF2rdTBkMOBrZ2rk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EPxltriGXx0/w9JtXdiRRR+uZKDyAi9ar0uUutB8fQgKhWYvpT60IsJx/6NY4lJAT9ykfNr2ZZKyNhi9FlHGjDiJL8X7C6WhqCJMmBZQk7G9OhwHm/QG5fmwrP7hEQ/7o41x8qI2+1p2ryXmRw1fS262Xh2lz2exNjQEnp1fjLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=EGbb+J4R; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="EGbb+J4R"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-43d18a7c1deso2826721cf.0
        for <iommu@lists.linux.dev>; Tue, 07 May 2024 17:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1715127909; x=1715732709; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=62oVLAkCTGDCTLLKSqh+lJU6r7gjh1o4XBhOsw5N1rI=;
        b=EGbb+J4RvgdQP3YgrEDAgo6F+R9FZJ12wQxqIJDBt0OYwNDeWNpy2RAmnYKQD9LSlI
         B9Gpglz4ZjgkU+7o0lLJrZFRAK2ZoFvdg6NubHTsKnH769KLnB1j4Xemtff92QO4PKV0
         IPkysm4B225MbIHnNESj30BAtOhT8VIzSGbX/qBeE+PvG0JvAKwifUEiYc+XYwd5Cdvw
         Wzg59K+Pef3CangcIpGF8fJmMMkMjMk4pBZJGJ+atH6cJTZv6XTCwmx4oqXRjzYeO4SN
         5daQ8N1xG4WInQV/HeBCwqv3+3mE5HufEa7gqVB+CLDRlMC9heGj7OpbmugqNceQW2WN
         OojA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715127909; x=1715732709;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=62oVLAkCTGDCTLLKSqh+lJU6r7gjh1o4XBhOsw5N1rI=;
        b=iAHIHIzTVl2Ch6BP4lyMr/ci2O0G2AXXrCsdIJaA+2wY02MpYuzazdvb8Q7J8CpQwB
         iayPHrUQtdlPMFd13kah71Daz4gtDIgG93/kYOvsVOvrmjY3np8bVAAjueIEfty62U5G
         F9oxX8cz+cySLv0+pCcvL3VmuZTm46dZ1dkmOB35v9LBTsBv7fa/At+AyL+fAfyEia5j
         8Ht0FNVumI6gWEsW4BUwYCKdaOMZ22S0uxqL4kvJO1PynoMR55bTQ3BAOUYOQp4OCYvg
         iS+sCZc4V8qWrVJagZss62gLqtOIVnhxSuYOkT/8t0l3T7mDHNrQrQwTg4VeZ05dUB6M
         ApFg==
X-Forwarded-Encrypted: i=1; AJvYcCWNsZiqrhYDgO7qTybu344jsUM/ksbIyg19bJbosgFhgrQZKMwkh8tY/oZzCJp5RLyYVvRkI+zPFlqFX45JKw1xucoH4GA=
X-Gm-Message-State: AOJu0YzXSPXVyse+wxNZnTNmw5J6ocjZlvocmauvWTzv4YjRLP2YqRsl
	EBTyZI/O+muq5By40Lr6jUiZ590hi4Rv3Ko3P0UvxxixEX2vBRi8jxT8Qa8qjnA=
X-Google-Smtp-Source: AGHT+IFTxEBXk6pFTSfXuSIuCjv+y/O+PL/HIbz5Je8O0KKZUh3tsAMV/ImOlBAPfnNJTqCSHSBJgg==
X-Received: by 2002:ac8:5e54:0:b0:439:b456:25b6 with SMTP id d75a77b69052e-43d8f7cbbe6mr61262901cf.30.1715127908960;
        Tue, 07 May 2024 17:25:08 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id hx1-20020a05622a668100b004364d940d3dsm6840475qtb.96.2024.05.07.17.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 17:25:08 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s4V7M-0005JK-22;
	Tue, 07 May 2024 21:25:08 -0300
Date: Tue, 7 May 2024 21:25:08 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 7/9] iommufd: Associate fault object with
 iommufd_hw_pgtable
Message-ID: <20240508002508.GQ4718@ziepe.ca>
References: <20240430145710.68112-1-baolu.lu@linux.intel.com>
 <20240430145710.68112-8-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430145710.68112-8-baolu.lu@linux.intel.com>

On Tue, Apr 30, 2024 at 10:57:08PM +0800, Lu Baolu wrote:
>  /**
> @@ -412,6 +415,9 @@ enum iommu_hwpt_data_type {
>   * @data_type: One of enum iommu_hwpt_data_type
>   * @data_len: Length of the type specific data
>   * @data_uptr: User pointer to the type specific data
> + * @fault_id: The ID of IOMMUFD_FAULT object. Valid only if flags field of
> + *            IOMMU_HWPT_FAULT_ID_VALID is set.
> + * @__reserved2: Padding to 64-bit alignment. Must be 0.
>   *
>   * Explicitly allocate a hardware page table object. This is the same object
>   * type that is returned by iommufd_device_attach() and represents the
> @@ -442,6 +448,8 @@ struct iommu_hwpt_alloc {
>  	__u32 data_type;
>  	__u32 data_len;
>  	__aligned_u64 data_uptr;
> +	__u32 fault_id;
> +	__u32 __reserved2;
>  };
>  #define IOMMU_HWPT_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_HWPT_ALLOC)

[..]

> @@ -359,7 +359,7 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
>  	IOCTL_OP(IOMMU_GET_HW_INFO, iommufd_get_hw_info, struct iommu_hw_info,
>  		 __reserved),
>  	IOCTL_OP(IOMMU_HWPT_ALLOC, iommufd_hwpt_alloc, struct iommu_hwpt_alloc,
> -		 __reserved),
> +		 __reserved2),

This is now how the back compat mechanism works. The value here is the
absolute minimum size, it should never increase. The first __reserved
is always the right value.

If you change it then old userspace that doesn't include the fault_id
will stop working.

Jason
