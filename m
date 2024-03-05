Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECA33201
	for <iommu@lists.linux.dev>; Tue,  5 Mar 2024 00:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709599857; cv=none; b=tlazlnyitonDMjoH/iWwFnhaGxnUVKgXvOTEnH6fKzwTI2twrnhqjgWOZadtnTx0TC4UKoAf80QrganuKcwbqePcyait+P1YbYqRFq8IdFjsIQiS0MKSuOIotSsnBKswTna1ReY0sjsF11sy/L/sWast/PeB6pDtLeNXSySdqxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709599857; c=relaxed/simple;
	bh=Ni3P++ospk99Sffa320ZsmEiUPuQtu6RsGRdK+Fmbpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fLhbxqV4GObZ72jw8UX5bf4brjAnC63hVU/9udj/d6ihSMCx2Ev+4wqeeZ6kUJc2B4wmBYvBpI2+9iFMCIjC2sEaa7RX3h4cOICcQdv6M7tst8r/+8A8foMghUjV2x6hxqpi98FQl7PfdTNTXVM3f7zAwSVmBi7uBqCrYGt71T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=PN7ks0wv; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="PN7ks0wv"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-78831914027so31250585a.1
        for <iommu@lists.linux.dev>; Mon, 04 Mar 2024 16:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1709599855; x=1710204655; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yrE6sM0TkLfyyiXu3PISjBoXP87Nd5a+uHi0hsh2j8E=;
        b=PN7ks0wvicxsdTls2E8Rirv+8PshOmMRGCOsDZ4/AfSXrXG04gBRkS/HsG8USQ4jyE
         xXUZGYfvrQ3P6ztEnKhmcXg9d9ZHiZNX82QIg/aR/Tj+J1DUVqNaya/dJV2eh+bjN+b0
         hWPrpwt3lN8uffThmUzvIBRV+N6P3JG1gXxerb77jHASHDHpXOrpqWq0eqfc6p7T9g5V
         A7TmHaVI7lpf6J84RDbsJ7JqNhpjhXjdkynjbE99bY+ETn1vK1aq0EeHl43/dhexvWF7
         fCMxW2/acuVHW4P6PiHHbF5E7xI7DqUkQfvnGUa4dIP+qoo6YGA1xaBEjGUD4x/5bjbg
         Dm5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709599855; x=1710204655;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yrE6sM0TkLfyyiXu3PISjBoXP87Nd5a+uHi0hsh2j8E=;
        b=qU818Fdhx96PjjvJUAYfKCahai73GvltnkKYVUmE5dWcXLDnM/MyxYjtfRVcdYPEU4
         y1zAjVyG9p4hJ0Ay3mbm7XFA16XXBaNeN5i3BDHWlGkdtYLnlXhnt9te7bwIoSsxXAJb
         +K9bO4Jx9Q8Fnz9tn/6K+D7uRy+qm5KZ9ZV++opBPv2w5ro7KAHaaLODiAK0Kv3Vjyb2
         FGNGjO3B4b5A+opix+P85wZSjwIQ0hRDMCBYqBsxXmjLgliFuQ1Ddru/fpGSweXm2iqf
         0yEikeRuU9MPzVMXFD78yTP8zXieQv6A8B7kZpZeNeTBG9lYMWCE59ypgUqa4QL4s6Zf
         f4uw==
X-Gm-Message-State: AOJu0YwrLchJm6yQyDcU+mEMsNMMQd2ZFaXN919lDOGqZ+UwiVQWNvqx
	/MvW1mzGR+BRL7U/diArOXShOo6HKJTUYuIPgrpxZjkphsaHg8E1/OiJFsgbPwY=
X-Google-Smtp-Source: AGHT+IFpmphhv9P0JjNG2mtMK/OOg5uqMHgEjQPeEyNuudB2nxx86k+j0wGeY/Wtd/nwLNp6i8NJXw==
X-Received: by 2002:a0c:f80d:0:b0:68f:2e24:6156 with SMTP id r13-20020a0cf80d000000b0068f2e246156mr466088qvn.16.1709599854852;
        Mon, 04 Mar 2024 16:50:54 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id oi4-20020a05621443c400b0068f11ceb309sm4185325qvb.128.2024.03.04.16.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 16:50:54 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rhJ1B-00DcCD-RU;
	Mon, 04 Mar 2024 20:50:53 -0400
Date: Mon, 4 Mar 2024 20:50:53 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v6 13/15] iommu/amd: Initial SVA support for AMD IOMMU
Message-ID: <20240305005053.GH9225@ziepe.ca>
References: <20240209112930.63663-1-vasant.hegde@amd.com>
 <20240209112930.63663-14-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240209112930.63663-14-vasant.hegde@amd.com>

On Fri, Feb 09, 2024 at 11:29:28AM +0000, Vasant Hegde wrote:
> @@ -560,6 +567,16 @@ enum protection_domain_mode {
>  	PD_MODE_V2,
>  };
>  
> +/* Track dev_data/PASID list for the protection domain */
> +struct pdom_dev_data {
> +	/* Points to attached device data */
> +	struct iommu_dev_data *dev_data;
> +	/* PASID attached to the protection domain */
> +	ioasid_t pasid;
> +	/* For protection_domain->dev_data_list */
> +	struct list_head list;

'item' is a much better name than 'list'

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
> +	if (!is_pasid_valid(dev_data, pasid))
> +		return ret;
> +
> +	/* Make sure PASID is enabled */
> +	if (!is_pasid_enabled(dev_data))
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
> +	spin_lock_irqsave(&sva_pdom->lock, flags);
> +
> +	/* Setup GCR3 table */
> +	ret = amd_iommu_set_gcr3(dev_data, pasid,
> +				 iommu_virt_to_phys(domain->mm->pgd));
> +	if (ret) {
> +		kfree(pdom_dev_data);
> +		goto out_unlock;

BTW, I'm not confident in any of the error unwinds around command
execution failure. The sync failed, it doesn't mean the HW didn't
already load the new CD table entry. The driver is basically totally
wrecked at this point as it can't assume the new entry hasn't been
read and it can't assume the old entry is flushed out. :|

Otherwise looks good:

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
