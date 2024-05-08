Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB89372
	for <iommu@lists.linux.dev>; Wed,  8 May 2024 00:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715127766; cv=none; b=sSqULDqbubmQueqqXHrzF2P/UP+4eMEMOfDmjM+Jhf20EQHjG2fBYlrhlvP9O82H7XLO6p3N/fp6/2l2Acvleg3KCxpJ8rmWXYp0ASgYftEKcZ67K3LDQI3tONF34wDxcgovAQwtkAJNnU/aguqSJcCKaCOETyn3beIQUnOO1XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715127766; c=relaxed/simple;
	bh=WGmcAoiIYkBzYTcnI6cjBMVdcLKjLO/t8etJMyy0xdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A4HcKh9fz255KZJqLWD7XLfWwY0t/22qDk+qteyahJOaTt3uzp5DzPYJAZaova6z07XWu/grJwZcMfFknJ/xLfh1PasY+VZr5W0lZJUfhVIYdbvR1fLqnLdC9VnX/kpIFDSigrkf+ebze0W4wfQIN2nnKFJAJKmrL+Zc6OS/GQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=GYcwzm16; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="GYcwzm16"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-47f2f9f2ac8so456755137.2
        for <iommu@lists.linux.dev>; Tue, 07 May 2024 17:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1715127763; x=1715732563; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0vVlsRAg17DQsgwypHbQum2UTPFFlE+iz9hu2GQEt7A=;
        b=GYcwzm16Z31AfENL1pQNk0nbtgn9R38fGN62rxYC5BTSu8CEB4UYozXhHGGFfqHDjl
         xkzp6iAldRQvsS0Kl56e2NqN/6X7GEKlAviwWRig09KSLuNwgZhO5N7lj3FDXQzs6En1
         OGkNwowWQTWdPodaMqq/E0puWSvNAlFEbptyX1HP/o9YSyAIXWs329sOhkmNAw2eoaJD
         p9UwFVdaAXV+hw3/3mmlTCZ50jVKkTMQNdgyXF3ya57ECNzn7dI3tGvb6XGG+t+DUrjy
         /TU9zCl0u5LY4uPxX0dQOFUwRTisHcK1TLx0/PzcvOO+Gb5JvJ3E4yef2DHZueyfPqhm
         8LDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715127763; x=1715732563;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0vVlsRAg17DQsgwypHbQum2UTPFFlE+iz9hu2GQEt7A=;
        b=RE4JCpgcH6BjZMCN62q5I1Lc4WNIxZGXtrrotw6aG9U3YPgTZDw+jNwI0HKkhyTb0R
         d+18ZExFUOWj6NPUuzbDEv6oXwsY5YRBMW47zhdfxA2kjHbWPlz77vOMJ8ijZkFXYJz0
         KzHloSMIQyN3qKAw7jAqTej+ikYligoPFkGQVYbHpQzayu5BuEy0oEqxqdHZKy98ZEII
         k3j+g+YK2mDY+9OdGetX3ObSQCpcP9BG7qEj4S/pd9pg/AegkWF3EKBTEj/r9qJIAfF3
         kLxurUwG8uPdKCQrBM06Zryj3pQY+hb0N0BYz51bZsUHa1CWqsZlYg0d1qtMS5+v31qP
         hfPw==
X-Forwarded-Encrypted: i=1; AJvYcCWLKmaZ/3B2wWD+OIeIy9mLhAR/6Ygoan+luztuEWrUSL3DmazaNvkwJkZs2O/8mP6Jdd7/tcnQCSvE/e+VE8Q3UK7SUJE=
X-Gm-Message-State: AOJu0YzxkDKsgjUxEF9pnWcpI5+HWS0pIO8TvALxMuyji5KXt9sHkWLG
	eaehTDkpaTuQzpCn1OMFFTjwA7fg56qzNYIV1gvRsa918WA9+Zy+uKPpHjObhxk=
X-Google-Smtp-Source: AGHT+IECNvqKHwlIYvkCbsFT5xd8nj9nklkhaiaz6B3Vn7SJl6jIjBbaZQht1v4nImwi8swZj3JkDQ==
X-Received: by 2002:a67:f554:0:b0:47b:d787:9ca6 with SMTP id ada2fe7eead31-47f3c2f99d9mr1007624137.18.1715127763605;
        Tue, 07 May 2024 17:22:43 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id o6-20020a0ccb06000000b006a13cf08fd4sm1804740qvk.66.2024.05.07.17.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 17:22:43 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s4V50-00059G-L2;
	Tue, 07 May 2024 21:22:42 -0300
Date: Tue, 7 May 2024 21:22:42 -0300
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
Subject: Re: [PATCH v5 5/9] iommufd: Add iommufd fault object
Message-ID: <20240508002242.GP4718@ziepe.ca>
References: <20240430145710.68112-1-baolu.lu@linux.intel.com>
 <20240430145710.68112-6-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430145710.68112-6-baolu.lu@linux.intel.com>

On Tue, Apr 30, 2024 at 10:57:06PM +0800, Lu Baolu wrote:
> +static ssize_t iommufd_fault_fops_read(struct file *filep, char __user *buf,
> +				       size_t count, loff_t *ppos)
> +{
> +	size_t fault_size = sizeof(struct iommu_hwpt_pgfault);
> +	struct iommufd_fault *fault = filep->private_data;
> +	struct iommu_hwpt_pgfault data;
> +	struct iommufd_device *idev;
> +	struct iopf_group *group;
> +	struct iopf_fault *iopf;
> +	size_t done = 0;
> +	int rc;
> +
> +	if (*ppos || count % fault_size)
> +		return -ESPIPE;
> +
> +	mutex_lock(&fault->mutex);
> +	while (!list_empty(&fault->deliver) && count > done) {
> +		group = list_first_entry(&fault->deliver,
> +					 struct iopf_group, node);
> +
> +		if (list_count_nodes(&group->faults) * fault_size > count - done)
> +			break;

Can this list_count be precomputed when we build the fault group?

> +
> +		idev = group->attach_handle->idev;
> +		if (!idev)
> +			break;

This check should be done before adding the fault to the linked
list. See my other note about the race.

> +
> +		rc = xa_alloc(&idev->faults, &group->cookie, group,
> +			      xa_limit_32b, GFP_KERNEL);
> +		if (rc)
> +			break;

This error handling is not quite right, if done == 0 then this should
return rc.


> +
> +		list_for_each_entry(iopf, &group->faults, list) {
> +			iommufd_compose_fault_message(&iopf->fault,
> +						      &data, idev,
> +						      group->cookie);
> +			rc = copy_to_user(buf + done, &data, fault_size);
> +			if (rc) {
> +				xa_erase(&idev->faults, group->cookie);
> +				break;

Same here

(same comment on the write side too)

Jason
