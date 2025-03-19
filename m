Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4DB1E1DF4
	for <iommu@lists.linux.dev>; Wed, 19 Mar 2025 12:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742385849; cv=none; b=qhLZ2aBMRE+D5tKrsIB/I5PDcICn2aTciIChGz6Uk0bhlOQ/dyliusugnN8Bf/aOYG3G01DkJaEFgaSisjoD+Y2o9RtiUgpHikZrxzH5ZBEQBZUYmT68rpg5Q4uCFWv3PpJW0bs+230gMmbU6E0ZOojxoN0PFg8GxOp12sTEXfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742385849; c=relaxed/simple;
	bh=AD8+ASrb49oYmuYfDC2fTxdzZCxtehPaYNi7PkJIPt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pz1Z2SGxHGqhaX6WuzV3/2QB7T2jiiOZAcOi1w0dXP0VRpMSvVA5k5iQJXxhsGzVzMMCarUQTzlH1LPbJSu8H2Q1BwXoSNAcDnW8lgpst+UxiwzNjuU79YuqEVucRz2g+iVWIWFEf9ei/HlxPJ0aJe4B32VGWvJ7l8XV/ggSxPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=kNEKXaDu; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="kNEKXaDu"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6e8efefec89so57616236d6.3
        for <iommu@lists.linux.dev>; Wed, 19 Mar 2025 05:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1742385845; x=1742990645; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MAyCxENHSaBMJRzBfPPLtA7uhu2XAFyInEjH2pl50vc=;
        b=kNEKXaDuX3Ukm51JsShul4VTMWBA6NzkRvCFjulNHJ08lME33MZxrBanYcJfZY9iJ0
         YtEYnIcXHZc2zpyoNntlvIDkDYW+YCMjsNwUK8JNwBMPY2kF0QEOSToWY0fXEknWmgEM
         bPSLSacfmUklF3pyMDWY7OZ+JSSQYU+lHvaZYu/+veaRfoDUE7f+x445dVmzih2bYRMt
         EJimR53uE9KAqsJFJLwKrfU5yvVcUL/bapY4afL34l63oPhOirCh/TKv+4P9yQzlPtJl
         R9xvqenTVetnmwfnSb9o03PmEUJXG/vW2K1c3MHYzKmA5XXKZDZG+OpMTRvBFVNwnaAt
         bplA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742385845; x=1742990645;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MAyCxENHSaBMJRzBfPPLtA7uhu2XAFyInEjH2pl50vc=;
        b=d34Z4luu7vII4EA7HQzQAabUad33RcOTlzgblTKTlGG0YHtYCvB/UkdNeN53/yXvJY
         fsXTnGCUEW6apLkfBgT1+TAcU5CkKP1UWH2ox5vdQ+OKf5DFywOxvnqNpy3JMwy6cYfF
         bIpfGinxKZQ8KeF7GAzbw51lPzibZ5CdIqFiYjn9j+HNWsdh2tKXF7ND0mr3FzINF7Hn
         bN42Wf1kTUQ8DGXb19L16dihN/PpRxKrLmZeioKCJO5KakG+EH6FJXX14TRnkW1QAbeZ
         i3FfjDk5/yVdRf+WWru6RX3gh1paJxavGv/1rS4EySipvh/MmU+lqlhn6PbAM541dNBO
         f4Jg==
X-Forwarded-Encrypted: i=1; AJvYcCVuJBYP8Pgb/7mzqlPG198w8SNUzUGwUsh3SedZXjzXSCCTTJev9oQuH/uWkDbQFZrDI8VT3A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxL83WrRqNTrmyfdFbnPjoiH+AhwtOhtrCgKRayErvOPEu4m2R/
	2UIrMmTkxfIkXEJe5qFwPcIR2A3YsP3oohfXT4Kabtwa2FQm83fTif3UyPncSZ/6/9S1oV1/p7h
	v
X-Gm-Gg: ASbGnctI5NFU5GfOFYqxzmyzv/pjoNZsehq7qqxmwMg/wqCT0IiqlLL1d+i6YTYpGje
	4p/jy8gzSojoT6+WGMZ1TAvKRNQG9yTS/XpqbDE4052t1NBnNHpup2iBX5jEO5CbWZ/U/DXmJ14
	MjTrNW9gD4N1rebrcYJGrNaZTYOU9C/WfVm6UnnEfdmw9iOv9mv8uWy7nZx4uTrSyqeVBAVKqNz
	KzEMYs7l1jVPbWhSOHeeqDRNjB2xhUEwaa1IAy1v/860AfQR/qIFhc/MvRIefYAWj7DiRpEYmZM
	aBHNGaj1HEOUO9msRoKg4V3zLaz+czaZzOSI5kZCQm6T3tVZpfdVGTpzwrk3lITRQu82HTrIRC4
	/XCeRSYHIfGkvWz3f86TzaKi04n0g
X-Google-Smtp-Source: AGHT+IF2rdeEHiKMBmGX1q7qy3yZoap+uCClJ9CaVb+cXTsAtTre08hPYrRBXabP/U7Dpkwrjk/xHg==
X-Received: by 2002:a0c:e991:0:b0:6eb:2f30:55cd with SMTP id 6a1803df08f44-6eb2f3f99e7mr11121046d6.45.1742385845646;
        Wed, 19 Mar 2025 05:04:05 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eade24ea6esm79688666d6.52.2025.03.19.05.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 05:04:05 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tus9U-00000000TcL-2GEV;
	Wed, 19 Mar 2025 09:04:04 -0300
Date: Wed, 19 Mar 2025 09:04:04 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pranjal Shrivastava <praan@google.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Mostafa Saleh <smostafa@google.com>,
	Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev
Subject: Re: [RFC PATCH 5/5] iommu/arm-smmu-v3: Invoke pm_runtime before hw
 access
Message-ID: <20250319120404.GD10600@ziepe.ca>
References: <20250319004254.2547950-1-praan@google.com>
 <20250319004254.2547950-6-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319004254.2547950-6-praan@google.com>

On Wed, Mar 19, 2025 at 12:42:54AM +0000, Pranjal Shrivastava wrote:
> -static void arm_smmu_attach_dev_ste(struct iommu_domain *domain,
> +static int arm_smmu_attach_dev_ste(struct iommu_domain *domain,
>  				    struct device *dev,
>  				    struct arm_smmu_ste *ste,
>  				    unsigned int s1dss)
>  {

This can't be changed into something that fails! That would mess up
all the error handling if it ever blows up.

> @@ -3214,8 +3287,8 @@ static int arm_smmu_attach_dev_identity(struct iommu_domain *domain,
>  	struct arm_smmu_master master = dev_iommu_priv_get(dev);
>  
>  	arm_smmu_make_bypass_ste(master->smmu, &ste);
> -	arm_smmu_attach_dev_ste(domain, dev, &ste, STRTAB_STE_1_S1DSS_BYPASS);
> -	return 0;
> +	return arm_smmu_attach_dev_ste(domain, dev, &ste,
> +				       STRTAB_STE_1_S1DSS_BYPASS);
>  }
>  
>  static const struct iommu_domain_ops arm_smmu_identity_ops = {
> @@ -3233,9 +3306,8 @@ static int arm_smmu_attach_dev_blocked(struct iommu_domain *domain,
>  	struct arm_smmu_ste ste;
>  
>  	arm_smmu_make_abort_ste(&ste);
> -	arm_smmu_attach_dev_ste(domain, dev, &ste,
> -				STRTAB_STE_1_S1DSS_TERMINATE);
> -	return 0;
> +	return arm_smmu_attach_dev_ste(domain, dev, &ste,
> +				       STRTAB_STE_1_S1DSS_TERMINATE);
>  }

Because these functions are required to be non-failing.

This feels kind of wonky, if we need to update a STE but the PM is off
then we just need to update the STE memory with some synchornization
and do nothing else. We don't need to wake up the HW and issue a cache
flush if the powered off cache could never have held a copy anyhow.

Jason
