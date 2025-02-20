Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F70428F5
	for <iommu@lists.linux.dev>; Thu, 20 Feb 2025 01:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740013375; cv=none; b=Q0dMFJtpF3kDkvpao3d40Lfo8JQgHKdqGGn8w2LVWRCiumOuOyNCBtXztNR8JS4GQP9rmIamzOmR0oUTmdcNF/dwMaXoWi7ofPaEiJNffuak2bYQpWQyE1bIvTkAylVRwp93Cz0dALb/LZob1rtax3dCiVZvLcCSItjzN7E2JC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740013375; c=relaxed/simple;
	bh=ZhTrlgc+69pvUq4i22CA5jurxLSucq94AvJJuIwOxmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hTKuDTHdW95Z52EQMwZYTz8He3ikwredTTZOlF6nJ8cBD4CMTIxxa764Q4gXRXyK8pfqclIIPWwZL/rNqygSz3OAYLMLn38QN0ToDziK8wGrFjy1Cpz1Yy14w9qDrnOA0tuq7umQxE8piiOY0cQA6dMf0J2zYKo4K2j0WS+JRUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=HSHk+Oai; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="HSHk+Oai"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6e65baef2edso3129976d6.2
        for <iommu@lists.linux.dev>; Wed, 19 Feb 2025 17:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1740013371; x=1740618171; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CRs/JKSwsGTXcOODWipBNJ36S3MEcNOB+8tXv5oqvN0=;
        b=HSHk+OaifPzqIOjy2wPQ8/zYPSas2v+OFH74DODin/h4k1BqQqGk/WZtdaloqv3l6Q
         QR6g/j/q0YOsh796kKV++hiLAizbJANMAZXK8I54u10omuxMBFBqTaCOf1pRjZpOO0ri
         47U8w7lDLgypFqJp9xChFILSIyUyq/bFWsNS9WTh8GrUtzXlpB48HQalYATXz0rq4T27
         vvd8i+l1EvjYiOTPjSQMIS6t3ebJlxqGMVjKvDxoXjPsr+vMTl6PciKjASRLH6D5oSGy
         qtzwM8AK76Z2XVnbSBxdgdaztCuBqemarxZZ5NVX6D9D8knwhaOKCYigrLInslSqrZ4r
         lrXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740013371; x=1740618171;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CRs/JKSwsGTXcOODWipBNJ36S3MEcNOB+8tXv5oqvN0=;
        b=jIA4HNxaGWZzwV7VOQwV6ZYhLUCfdyKpOD/LRdiTE/yhMbAXKUByoMTfgs1USryvPD
         qyqdP23LHbq7cQnVNr1qZdVkQUEoIuBFunUifcaR8/5NbpeH94urQdGhWp86FqxQazjE
         3WLTwWIvXb3cvU5lo8fDG1N8Mpe3etxzTJWI8nOgWWA15RGqGxUS6fYVK8OxkSlcbP1j
         fEQi7gH59fmXahBEPeMdKx5iStJJNesUqMfLbwHBH2YUpZgYrn7gEOn4fNEgy3SuMDn3
         qBVDHfMwrx/n6eiu12VebZGLEjxv+9Gyex7/EQDLiC8NjOCOnbrryTvwLfVJpMaNAbnx
         3fWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjTiBRJaCBkyByri13iLDUO44NwaZ5YccALrBj5QQUoe5dWEelJ8uALhpnh3bUD/oxd54Hdg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzyif/3x5XSymHh4sbz4Q19J3Kd0yPXfcOujIASnT/TQyJ/wgkE
	ePRLiZRedthZ5JHiTM3RbH7sazrR98aotCkpgnFCF9XPeX60xuuOfb171AkSHHg=
X-Gm-Gg: ASbGncsZwVCw7G4djsa7ITMc746RO6oGJJA9RdIxOjtQRK19WDlbc0BWkuSTYcipLpq
	TF/s7UNy5jb8BqdHUHvULkeDmzxWSW5TrxzxTtWZJu14btPDHwLkNhWAgw2wOvRfyhPf8hR/mbp
	8cxdZzSndgbEvzqAzj7CQFX/1ySmypL0TlG6gOPbS6QA24TLJvZsZ3ulqFMd1NSUgMXw+3K1xoE
	eJPOiUExMt0pyQ4n4ixmQWE/zo+ZIAfToFJ5zbqnEhmpLtFSGNufkiduVqjgu0ayCCFjcUo56EM
	MAtTxn2LRsQIroeGm1CwknZfEFKGLVJtBGcx25eeKMbxJoZHJW3IwyiSKJJ5eqmz
X-Google-Smtp-Source: AGHT+IELnZYcib0uVQ5YAM0A6QDyvBF/tj8DmFXHYAT7rDf1dWIAeZvN7kiG5K6bL1Spk0FG/2Rv+w==
X-Received: by 2002:a05:6214:19e8:b0:6e6:6252:ad1d with SMTP id 6a1803df08f44-6e6a4b91dc7mr7604826d6.20.1740013371423;
        Wed, 19 Feb 2025 17:02:51 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d9f31fdsm80390616d6.69.2025.02.19.17.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 17:02:50 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tkuxm-00000000D72-1DAT;
	Wed, 19 Feb 2025 21:02:50 -0400
Date: Wed, 19 Feb 2025 21:02:50 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
	Zhangfei Gao <zhangfei.gao@linaro.org>,
	Zhou Wang <wangzhou1@hisilicon.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/12] iommufd/selftest: Put iopf enablement in domain
 attach path
Message-ID: <20250220010250.GQ3696814@ziepe.ca>
References: <20250214061104.1959525-1-baolu.lu@linux.intel.com>
 <20250214061104.1959525-9-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214061104.1959525-9-baolu.lu@linux.intel.com>

On Fri, Feb 14, 2025 at 02:11:00PM +0800, Lu Baolu wrote:
> @@ -197,11 +201,19 @@ static int mock_domain_nop_attach(struct iommu_domain *domain,
>  	if (domain->dirty_ops && (mdev->flags & MOCK_FLAGS_DEVICE_NO_DIRTY))
>  		return -EINVAL;
>  
> +	return mock_dev_enable_iopf(dev, domain);
> +}

This isn't going to work for a replace type operation? Maybe like:

if (old_domain->iopf_handler && !domain->iopf_handler)
	return mock_dev_disable_iopf(dev, domain);
if (old_domain->iopf_handler && domain->iopf_handler)
        return 0;
return mock_dev_enable_iopf(dev, domain);

?

Jason
