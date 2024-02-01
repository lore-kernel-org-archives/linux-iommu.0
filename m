Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432EA5A4E0
	for <iommu@lists.linux.dev>; Thu,  1 Feb 2024 18:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706813486; cv=none; b=sstgzSiC7go17dxbei5KwrIBzewvoGpDh1jP2x12P2takJq448BW3GS9tLgS6RKUnBYBMjs04zJGFar0jd7zk3mTmL2H6Xt7JydtIhTKrSs2lfChEKqPduW2sQL+S5O20f6c0hasomGdzNBSIaBzkKIJ9TBtUErOXfABvPrfG6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706813486; c=relaxed/simple;
	bh=VHcJ6xWs04hidmGsT73m/Y3i4DiuzfZWRtIb+3lpzok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kSLI2ZyxFAAkQ1dKuafKzD+qtIJ3Hi4UmYf1y60m1Ppo/ReERiebUDup8+6XdcQ9O1F2Cii2W6mKx8AlzUWpsU9rLNsI6rX6HVsE72KS/BNO0f9dnqgRFzsI+t6WlW2iEuLjjG9MNn0hZp+eBwYW7+91jD/atn3QAfCJxUPTYCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=WaSG7SQc; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="WaSG7SQc"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-59a29a93f38so568911eaf.0
        for <iommu@lists.linux.dev>; Thu, 01 Feb 2024 10:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1706813483; x=1707418283; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p77+Yb3dKsfvXmR3TewTKl3c26QKWo2vZBB8I3U+sHQ=;
        b=WaSG7SQcVGAQEhnJdeG8CXAwQQ2iWxaLChbPqDFRIR4KZRl1ri9bhOI8qbdG4mvhdF
         aglmFUVqN+x95VpvMbX3jiHwW7n5opy65SR/2IUhuB/nNPTy3t1nnXNnDkhQgTZLDLFY
         OldY60sSsw6J779zw7zlLnawMqieSu+vMq3AXagaxZ28hvuzzRMtpY3NUgk1QHB5xY0p
         jTBIsTM4CZRIH98W0t2KssW3Zec4f9ynqRojqDmHs49Xt8peYlpAlDI+Qfbd4YTD9wOE
         AXePXlDLKx8qsv5aCdlhZi1RL6/x2xJVJOO4C8xexYtgfdcLTPWlbLY4131mHxSdhEhl
         oblg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706813483; x=1707418283;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p77+Yb3dKsfvXmR3TewTKl3c26QKWo2vZBB8I3U+sHQ=;
        b=ZJpCpJI2cxYeZ7rEsdCiGTC0ELSBo4jKjqOQ41l9plA1XP3odtVG30ChDdYaeLePy/
         nL2EoiP9x9JPYmfPplxSs+xdK+Oz0pXsUNrQB14R3lbu5eJTnGJm0W5VoAKh9uCr+2DR
         SGkxu3xYo9wsK6vlQTKkPQFZ381zEt5W+9c4IyvEHHHf5xi1N1XLPPkQQqR3YgCQHBIo
         Lcp0HsDfqoQB/UN/E6rW9V5sE2h9vpVFMjAFi7/pJCwaTTfKMiDzJLH2YVfxVt1VdvFp
         sH9K4EWdUfx2BlxAYpVB6SVBUEuXKvn7ult38rzcP4m6PkNPhGoZXCzyQwXU0LEjFDJH
         P6Ow==
X-Gm-Message-State: AOJu0Yy9MgmA8rdefptqRGQpGn/iqsTc6K8B01k2/dv9+XeZe3a5dy06
	iG5yY9QMga4HLTPM4BNb6JmXYxE/iVYkib2gvd+UGCldWJk6j5iw+on9z96Q5HY=
X-Google-Smtp-Source: AGHT+IFMoAnxKULi39aO7m6BPM1fTLc5B019ybyIeNNDcLE+XSsH8m2hpgDDe1/J6g4PiNvRN7POLA==
X-Received: by 2002:a05:6358:d5a9:b0:176:9e92:8e4 with SMTP id ms41-20020a056358d5a900b001769e9208e4mr6679494rwb.10.1706813482939;
        Thu, 01 Feb 2024 10:51:22 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVgrqUZUdVz/RpmagFWDqxEhYhk1n4VUeCRx9qSXBwQxtTPdAJbprqahZFqc1pH0i+YUK3bEMafVb01GoPynAn+44kPJDahDHT4ugduYQBbuliMhK7ybXZ9BW0wYClJLJUZCqP4j9ls0NHSPul72EUqecwQCPlyNnDQorDlwZZoD0ZNlPm2NFQ=
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id qj9-20020a056214320900b0068c67a3647dsm33796qvb.76.2024.02.01.10.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 10:51:22 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rVc9h-00AntZ-An;
	Thu, 01 Feb 2024 14:51:21 -0400
Date: Thu, 1 Feb 2024 14:51:21 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v6 17/17] iommu/amd: Introduce per-device domain ID to
 workaround potential TLB aliasing issue
Message-ID: <20240201185121.GO50608@ziepe.ca>
References: <20240125121135.8217-1-vasant.hegde@amd.com>
 <20240125121135.8217-18-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125121135.8217-18-vasant.hegde@amd.com>

On Thu, Jan 25, 2024 at 12:11:35PM +0000, Vasant Hegde wrote:

> Hence, avoid the TLB aliasing issue with v2 page table by allocating unique
> domain ID for each device even when multiple devices are sharing the same v1
> page table. Please note that this workaround would result in multiple
> INVALIDATE_IOMMU_PAGES commands (one per domain id) when unmapping a
> translation.

I think the bigger downside is that it causes V2 domains to become
IOTLB unsharable even in simple cases with no possible PASID.

BTW "workaround" is not quite right, this is "fix", and it is a
security problem to get this wrong.

Anyhow:

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index 79a07a2e4bec..d5786c33aee6 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -536,6 +536,7 @@ struct gcr3_tbl_info {
>  	u64	*gcr3_tbl;	/* Guest CR3 table */
>  	int	glx;		/* Number of levels for GCR3 table */
>  	u32	pasid_cnt;	/* Track attached PASIDs */
> +	u16	domid;		/* Per device domain ID */

It is minor, but per-table domain ID, not per device.

Same-gcr3 tables can always safely share the domain id.

> -static void __domain_flush_pages(struct protection_domain *domain,
> +static int domain_flush_pages_v2(struct protection_domain *pdom,
>  				 u64 address, size_t size)
>  {
>  	struct iommu_dev_data *dev_data;
>  	struct iommu_cmd cmd;
> -	int ret = 0, i;
> -	ioasid_t pasid = IOMMU_NO_PASID;
> -	bool gn = false;
> +	int ret = 0;
>  
> -	if (pdom_is_v2_pgtbl_mode(domain))
> -		gn = true;
> +	list_for_each_entry(dev_data, &pdom->dev_list, list) {

Suggest a future patch to add

lockdep_assert_held(&pdom->lock);

To all functions touching dev_list.. That locking is a bit obscure.
Also, I'm not sure using a spinlock with such a wide scope makes
sense. :|

Jason
