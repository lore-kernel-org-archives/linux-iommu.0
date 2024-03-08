Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A2356473
	for <iommu@lists.linux.dev>; Fri,  8 Mar 2024 19:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709924744; cv=none; b=GJI2lK9qT3/EmRtivolIelU8akkzxgMx6OZT9WsH4uGX54W3ZpSsTh4wwCIZDbcNuPSiyYo0+5kXKNO+7WqjNL5KsV/wcLdESm33hgm5P+yzrrrAI8m7GviVtlEzU+4zEdoTX8Xy2ghmRiP+PC7rNPgyLXvn199udYIyd13yc5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709924744; c=relaxed/simple;
	bh=ILaKu4J8rSQrN8d6WmZQitsoeFgh+zPlpkPgOdLz644=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rVkxl/SYlyv0dQStYjIlN5ekTVALwVbc+d5lYsX9Ee9clEJfVWajYXf/gZ+iaSiJsRkqRTGc97iKOyAznp1g5sJrZMBYcI9YtBDlWWlOYJ0ZYwFGm9H9Nlqrp4syruh1sZiME2sEKN68aEV5bGzsFqPtwjlfR5YRpXOkCc3l0xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=XcMbwQlV; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="XcMbwQlV"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2210a266118so844154fac.1
        for <iommu@lists.linux.dev>; Fri, 08 Mar 2024 11:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1709924740; x=1710529540; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7qMRR7sLkZVUANHdEsXoEoSh+RPGbp+63DXPrOksx9o=;
        b=XcMbwQlViVDgPHGwU0y8z3QC7griIvJa4m3Vmk9jhaFCjzPikfWTDPj8+Ku2bFNTYV
         40yhhEFX5YztRJ/uIfyi01Kk/rHDhvHXTwGkxbFcXVvngekgmDMKuBkU7r1vHMDK7UqV
         QjQr3CWJb9RPolZDwCYRKw3/NNZIHgOqRj3kyxPAr9j7OH2jnCCe40LCQFp2UNYHF3KL
         MSenvD+SEQlR1LHXLKsAIvwct7ejgXOdJdoxrVXvqk/G3QmbLmmQpcDt6dvb2deUNkKj
         qGpsc8jCw3YuwPZpP3HgYdGQSVHW1oURmQMgKAu7hRSuQ6I7RRH5SM5a1TtdVKhiFdcp
         Ac6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709924740; x=1710529540;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7qMRR7sLkZVUANHdEsXoEoSh+RPGbp+63DXPrOksx9o=;
        b=ew2UncvtWjpM+3qMNFCzU0X8IRTIN1zrcjKIzZ2ULRsRDPkifLj8omC8LnYRTyhIK7
         4J6Ow2qnXOPS2AZvNcCLupTggXxab2WtuEag/iHuiinaK06DFFzfFnOlNgYemEk7h+Ce
         FcByzhvyL1dWod2fbG1IX5/dV25SoaJwM6ppVu2VHUzNcr9o+xSLBEyrlq21g7xQh2Y3
         cuvz+NjVuvCQ17rgdSfFi5Pb8hIdmO7FOYQSG4upJ3spdLemJIvj7AVh3VX9ttIm3ttk
         mjTsqwVJ/SAU+dZ8q2InFkFgTdX/0IEQ+l8hzdQ8eY9n04k2Wd2ZgKMWRCTt7fNoO+0X
         AUzA==
X-Forwarded-Encrypted: i=1; AJvYcCXKtdGk+CPe6lmGLgpKD3zwhVSVzZUe081crQc8MVXn6FmKyYXc1tjbWpvzOz1MoftV+zbW7pz6eeGOD7NUyfJB421VcZ0=
X-Gm-Message-State: AOJu0Yxz4OIQ0gEATLK/RzsNQbYAxXscJxBkxdAAYnMMDpWmZvkldefs
	cxUw4ZkkZB4YpE1OA1sIAS8MhQD0tA4v6+zgFurfqP5YaUivz5GkMfPUXnBuKsc=
X-Google-Smtp-Source: AGHT+IFDoglDB8jr4C0bRLZGs90q16mK5wPOyxs6caLbupPbYv27tZdKsh1cc0oiSg/2ojAvVJQeAA==
X-Received: by 2002:a05:6870:844f:b0:220:fc89:db73 with SMTP id n15-20020a056870844f00b00220fc89db73mr42008oak.0.1709924740712;
        Fri, 08 Mar 2024 11:05:40 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id la12-20020a056871410c00b00221847430e2sm1485oab.30.2024.03.08.11.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 11:05:40 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rifXH-007kGb-7w;
	Fri, 08 Mar 2024 15:05:39 -0400
Date: Fri, 8 Mar 2024 15:05:39 -0400
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
Subject: Re: [PATCH v3 5/8] iommufd: Associate fault object with
 iommufd_hw_pgtable
Message-ID: <20240308190539.GY9225@ziepe.ca>
References: <20240122073903.24406-1-baolu.lu@linux.intel.com>
 <20240122073903.24406-6-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122073903.24406-6-baolu.lu@linux.intel.com>

On Mon, Jan 22, 2024 at 03:39:00PM +0800, Lu Baolu wrote:

> @@ -411,6 +414,8 @@ enum iommu_hwpt_data_type {
>   * @__reserved: Must be 0
>   * @data_type: One of enum iommu_hwpt_data_type
>   * @data_len: Length of the type specific data
> + * @fault_id: The ID of IOMMUFD_FAULT object. Valid only if flags field of
> + *            IOMMU_HWPT_FAULT_ID_VALID is set.
>   * @data_uptr: User pointer to the type specific data
>   *
>   * Explicitly allocate a hardware page table object. This is the same object
> @@ -441,6 +446,7 @@ struct iommu_hwpt_alloc {
>  	__u32 __reserved;
>  	__u32 data_type;
>  	__u32 data_len;
> +	__u32 fault_id;
>  	__aligned_u64 data_uptr;
>  };

?? We can't add fault_id in the middle of the struct??

> +	if (cmd->flags & IOMMU_HWPT_FAULT_ID_VALID) {
> +		struct iommufd_fault *fault;
> +
> +		fault = iommufd_get_fault(ucmd, cmd->fault_id);
> +		if (IS_ERR(fault)) {
> +			rc = PTR_ERR(fault);
> +			goto out_hwpt;
> +		}
> +		hwpt->fault = fault;
> +		hwpt->domain->iopf_handler = iommufd_fault_iopf_handler;
> +		hwpt->domain->fault_data = hwpt;
> +		hwpt->fault_capable = true;

I wonder if there should be an iommu API to make a domain fault
capable?

Jason
