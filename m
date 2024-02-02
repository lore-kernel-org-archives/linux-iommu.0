Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C72613F001
	for <iommu@lists.linux.dev>; Fri,  2 Feb 2024 15:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706887528; cv=none; b=J2J2oie3DUut5a5KXu+ugSt3cIwxNBdDJIhsxzHurn0OqzI6NV/UR5PdjKlAIBCexy5MnbuFHxfSqGZWv4+RbYHmEKclJ3lIksoJGDUChPogtumEH9PWSb8NxM9z2DgXbMFrchx4/6eFSKQynSxkealiuUCH5sKOARMThK/5cPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706887528; c=relaxed/simple;
	bh=fd5Fm5mndfJ8RH4PZODx22Pds+xpA0FGaYrAPc9LlQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jSxyN1y3JX8GvDCPejqMxfRv+fNAIRGglpa2GrO+xUXDDfH4yzTlHWNNOmIOUjAgVgQgXZjdUPHCiNch3B5H4850pYUIiM7kabz60kDkqGvO5Wu2pl4KELI5RftMcmkmQ09RwyF4k7IWs0Lz6B9GhntpE8cbF5fZ36jIJmAK+5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=P4QdQDJ8; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="P4QdQDJ8"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-218f4589f0cso920707fac.3
        for <iommu@lists.linux.dev>; Fri, 02 Feb 2024 07:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1706887525; x=1707492325; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kJn6Pun0u0IrpGUGH5bJmCoKGF2zOr8GqkkxvoOV3gw=;
        b=P4QdQDJ82wTZC9LH572lB9MRIUQJ6vV0d7WIdFtrKZWcLdvveN/CWvcv2yFDeyWJmq
         dR/3ZYGTvGMBLO4qHdR2Y8o+VLSaX6gtvbxjJXinQsWYEAUS8KGh5ll6vuareg8LRPMm
         B77WPibKRy5PozFVnQ3eREPFPi7ZeFHntYm29BDtHnWKVvyNefSTxSG2AW6VCJZb4g2X
         1qKm78DoEL9RnCswooF4uOHIty6PbTa+F0mF2IleH2S2pVSvSBjpfKlrhYXWnFPEu94p
         eY9sZp4X9VxstZJthvby+GMQ/ydmg4FDEp3U2SAqpCxkeRI+WQoPhMXIfLTwgBhddhm8
         Ugow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706887525; x=1707492325;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kJn6Pun0u0IrpGUGH5bJmCoKGF2zOr8GqkkxvoOV3gw=;
        b=MzX6I66nuKPVd2M5j0GS7lu3dhMogDwNNY3Qo/kFanMBW58QPqeiA334Sg+FSK5khH
         nHVMMvGSxwbj2VoS1KztfZDpUOpPTfl/IK54qIrnwJSPxnwjmZWXjKdC4MtMJfpVvNm/
         t5yusxqhcor6QQZmCw1c/oegrJwpegrn0tC0GVZzdsg+gMQzffpuGQAkYTUpWvr/+3of
         oM8QOcuoZK6YFsgtktaW9Si8qwlf4lYmBwBy57wKGggQ/exV1CZkfYYNgIpmud0u4F96
         gC7ba4a8SfYkic9rQ7JdW094jur3/MIDqhoBlRQoS0xqhjC1lkyo+Xs7UD8TnYY5ssw0
         iI1g==
X-Gm-Message-State: AOJu0YxRVN9MGjUI9f+Ce7GfFtQE1VNcYSHdTvkEDEs6auaTbrQJ8K9P
	1m+wclM4OETzv1TiIh1AXW8ThdN7+NwsU3dSPJ0u/leoteZL0ENTTcbtplGK1zM=
X-Google-Smtp-Source: AGHT+IFjtEtmhw7tyVHqXgOMPARhUKPjbqN6RvRWIQJPbUoXMSgZc6WtzIRi7SY109oNtzPGSkXSTQ==
X-Received: by 2002:a05:6870:d208:b0:219:3993:1b15 with SMTP id g8-20020a056870d20800b0021939931b15mr869011oac.39.1706887525191;
        Fri, 02 Feb 2024 07:25:25 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVL7TLlDSQcdbFst+eOoVLPjGDM+2b7ZqWaYc3tMI/jdhTRLkvMvtueEIYALWWNzOCM3unCF9ACmjHEL5yMwxfv8eSbaekz+Guqe2W8x76SAhxIA6B/JZvU4TGoE082acvKFJuJXO7R5rNqSUN8BAbxG1bMqCdP6EzOy07teJKzrV4VypVfIG8=
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id d13-20020a0cfe8d000000b0068c510634d1sm875653qvs.108.2024.02.02.07.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 07:25:24 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rVvPw-00AwC6-3F;
	Fri, 02 Feb 2024 11:25:24 -0400
Date: Fri, 2 Feb 2024 11:25:24 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v5 12/14] iommu/amd: Initial SVA support for AMD IOMMU
Message-ID: <20240202152524.GA2606743@ziepe.ca>
References: <20240118073339.6978-1-vasant.hegde@amd.com>
 <20240118073339.6978-13-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118073339.6978-13-vasant.hegde@amd.com>

On Thu, Jan 18, 2024 at 07:33:37AM +0000, Vasant Hegde wrote:

> +static int iommu_pasid_enable(struct iommu_dev_data *dev_data)
> +{
> +	struct device *dev = dev_data->dev;
> +	int ret = 0;
> +
> +	spin_lock(&dev_data->lock);
> +
> +	if (is_pasid_enabled(dev_data))
> +		goto out;
> +
> +	if (!amd_iommu_pasid_supported()) {
> +		ret = -ENODEV;
> +		goto out;
> +	}
> +
> +	/* attach_device path enables device PASID feature */
> +	if (!dev_data->pasid_enabled) {

How many times are we testing for this? Just check if the gcr3 table
is installed once

> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	ret = amd_iommu_gcr3_init(dev_data, dev->iommu->max_pasids);
> +
> +out:
> +	spin_unlock(&dev_data->lock);
> +	return ret;
> +}

This seems like too much, and it doesn't need to be in a function..

1) Check directly if the gcr3 table is installed otherwise try to
install it. That might be a usefull function

2) Precompute the max pasids during device probe and store it in
iommu_dev_data. Just check if PASID >= max_pasid and fail

> +static void iommu_pasid_disable(struct iommu_dev_data *dev_data)
> +{
> +	spin_lock(&dev_data->lock);
> +
> +	if (!is_gcr3_table_empty(dev_data))
> +		goto out;

Caller already checked this

> +
> +	if (dev_data->gcr3_info.gcr3_tbl == NULL)
> +		goto out;

Can't happen, right?

> +
> +	amd_iommu_gcr3_uninit(dev_data);

Just write it out clearly in remove dev pasid

if (is_gcr3_table_empty(dev_data))
   amd_iommu_gcr3_uninit(dev_data);

> +static int iommu_setup_pasid_pri(struct iommu_dev_data *dev_data)
> +{
> +	struct pci_dev *pdev;
> +	int ret;
> +
> +	if (is_pasid_enabled(dev_data))
> +		return 0;
> +
> +	ret = iommu_pasid_enable(dev_data);
> +	if (ret)
> +		return ret;
> +
> +	pdev = dev_is_pci(dev_data->dev) ? to_pci_dev(dev_data->dev) : NULL;
> +	if (!pdev || !amd_iommu_pdev_pri_supported(pdev))
> +		return 0;
> +
> +	if (!dev_data->pri_enabled)
> +		return -EINVAL;
> +
> +	ret = amd_iommu_iopf_enable_device(dev_data->dev);
> +
> +	return ret;
> +}
> +
> +static void remove_dev_pasid(struct pdom_dev_data *pdom_dev_data)
> +{
> +	/* Update GCR3 table and flush IOTLB */
> +	amd_iommu_clear_gcr3(pdom_dev_data->dev_data, pdom_dev_data->pasid);

This is in the wrong place, there is only one DTE/GCR3 remove_dev is
touching. The list iteration below is just to clean up the tracking
list it should not touch HW. Move this up into
amd_iommu_remove_dev_pasid.

And these functions related to the tracking list should be more
general and called in more places. Just the tracking list itself
should have a few patches to create it and situate it generically in
the driver. Even the RID should be using the same mechanism.

> +int iommu_sva_set_dev_pasid(struct iommu_domain *domain,
> +			    struct device *dev, ioasid_t pasid)
> +{
> +	struct pdom_dev_data *pdom_dev_data;
> +	struct protection_domain *sva_pdom = to_pdomain(domain);
> +	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
> +	unsigned long flags;
> +	int ret = -EINVAL;
> +
> +	/* PASID zero is used for requests from the I/O device without PASID */
> +	if (pasid == 0 || pasid >= dev->iommu->max_pasids)
> +		return ret;
> +
> +	/* Make sure PASID/PRI is enabled */
> +	ret = iommu_setup_pasid_pri(dev_data);
> +	if (ret)
> +		return ret;
> +
> +	/* Add PASID to protection domain pasid list */
> +	pdom_dev_data = kzalloc(sizeof(*pdom_dev_data), GFP_KERNEL);
> +	if (pdom_dev_data == NULL)
> +		return ret;
> +
> +	pdom_dev_data->pasid = pasid;
> +	pdom_dev_data->dev_data = dev_data;
> +
> +	/* Setup GCR3 table */
> +	ret = amd_iommu_set_gcr3(dev_data, pasid,
> +				 iommu_virt_to_phys(domain->mm->pgd));
> +	if (ret) {
> +		kfree(pdom_dev_data);
> +		return ret;
> +	}
> +
> +	spin_lock_irqsave(&sva_pdom->lock, flags);
> +	list_add(&pdom_dev_data->list, &sva_pdom->dev_data_list);
> +	spin_unlock_irqrestore(&sva_pdom->lock, flags);

This doesn't seem right? The tracking list should be loaded before any
change is made visible to the HW, or at least under the same lock.

Jason
