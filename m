Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0B6153578
	for <iommu@lists.linux.dev>; Wed, 19 Jun 2024 16:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718815584; cv=none; b=m//4btWDC+39jrbL/A+BqWpuezXgz9eYUrIBItr4gRi9XIhL/ac5uyNAZkFLYqo38+h7dgRc10zNlrb6FDt1jFfBAA0/wLNoTLvCVACJkX+O4/5GmcsyS34AoW/QqNV3dE+pMUH2qAVamMsDSN4Rs02e1wFO0AnZOJHxPEC7O6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718815584; c=relaxed/simple;
	bh=i2wzYdncE4Uj1scV06TvR9t7Hu52uO38FhyEFQdg5Ek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F2fvwK++Qddz4J9ak8EcoknGeChYs9IvCuk/2A69N1pN8Cu8Z9OKFvydvfWX2rA/T93/zyxtMUbGa2kI82twUAOZvPAEtkzBomxMshozoWxI9Uc9fMGj3xAuXnWzNuh02G7g2kqX5YvI1cuNW4GuAxPo+8lFiuuvxy25OXrj9gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=b2HalYkp; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="b2HalYkp"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-25ca04d24dfso35311fac.0
        for <iommu@lists.linux.dev>; Wed, 19 Jun 2024 09:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718815582; x=1719420382; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E8mnx4OwG0UyI7bQS+VANjYh2iOUaECLFPS0ndpki1c=;
        b=b2HalYkp2AfqItLYPDY7pqSJ+g5hxA8LeLuMbXfRTfwBdN9x2EmeSzoPYzlpS/k06/
         W1oTu3dzWmsYP8mO39+ueExNE5C37raoxmIR6kUkYKstUk0NJoTI5SIgs2LQ2mddPV6O
         jOpWODdvPKV4p/TsODolCUnBZXkOiBgDw5J7maqyEKpmh94jTzelrA3snMdlv47RkT9n
         vNJn/YRA4AbqZqdYRMJt6KLgONzW9s98oYJ8/NA7c8apBj8r0Jtk9VHHGV/fid+QQhhV
         dHr/c/VamjWIuI37cH+MH7do9EWeoSDgBJqjI6cd932to0RI1ZJURaAdMPmZDAK8Ecoh
         CCEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718815582; x=1719420382;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E8mnx4OwG0UyI7bQS+VANjYh2iOUaECLFPS0ndpki1c=;
        b=Dgkrl/JDNcGtfllS0Te0O33M7fdzOQQ8Ryijm/XKA3fzFKwRorI0bmXjK0V2SYJWI5
         Pthuh3IRVS9vAUyIpokaSJu7+0AxWGb9dbv7hcb89GWeRGCGx00wMn/mIdH1IWYc81qM
         d4gy5eDLpEQ3wmVILGCS59LUQbX4WQyslvPVrF7OrdSdqa8Gb4CE9f18hIZoDVzM72x7
         jd/fW8oGHLzbGcqPyrK6TYVzhqNsUQtX9DOR/SqSfE2I92qvDTaybrl0ao/B0ceKSD9Z
         9zRdU5bMbEvNLKT1Eix+pDOkrY4FmPOK3PO385B9cd3RJsMqg6c4rwlloucUubPtSKfs
         8bAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcdbk3q0MAsrWbNliofV/2w9Xh8sYIJ446Q6Y+tmpZgTTcimERpC/H1QCOORelCOPrbLjISu397UcmH4A+Ft/iSWEaGRs=
X-Gm-Message-State: AOJu0YxPXi8ldqJPe4rExjJqwjlluoKIrtbJ6l0zaNoA+BU3H9qsZ5M3
	81E9z2qD58WIcOBkdhJsiiijFkYrManko8c8O8wYBntIQzXb5scJIETw04im9ic=
X-Google-Smtp-Source: AGHT+IGneY1pKAnHRD88iFVlCOLssoGEupUkhzfkeqqSHzdXECbdWncqaGkPBBeJ+2eGeeDCX1uBdw==
X-Received: by 2002:a05:6870:54:b0:24c:a415:fd4b with SMTP id 586e51a60fabf-25c94a0e479mr2674379fac.35.1718815581733;
        Wed, 19 Jun 2024 09:46:21 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798aaedbf4esm620998485a.38.2024.06.19.09.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 09:46:20 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sJyRw-005E9K-9z;
	Wed, 19 Jun 2024 13:46:20 -0300
Date: Wed, 19 Jun 2024 13:46:20 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix missed device TLB cache tag
Message-ID: <20240619164620.GN791043@ziepe.ca>
References: <20240619015345.182773-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240619015345.182773-1-baolu.lu@linux.intel.com>

On Wed, Jun 19, 2024 at 09:53:45AM +0800, Lu Baolu wrote:
> When a domain is attached to a device, the required cache tags are
> assigned to the domain so that the related caches could be flushed
> whenever it is needed. The device TLB cache tag is created selectively 
> by checking the ats_enabled field of the device's iommu data. This
> creates an ordered dependency between attach and ATS enabling paths.
> 
> The device TLB cache tag will not be created if device's ATS is enabled
> after the domain attachment. This causes some devices, for example
> intel_vpu, to malfunction.

What? How is this even possible?

ATS is controlled exclusively by the iommu driver, how can it be
changed without the driver knowing??

Jason
