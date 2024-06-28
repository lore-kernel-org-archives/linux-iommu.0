Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99FD1802E
	for <iommu@lists.linux.dev>; Sat, 29 Jun 2024 01:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719623515; cv=none; b=VZ56arHji+ihCMCEQZ/iLY6MfYiAMNHW8pNJRpw4dh+g0ISoHLwAYSH3jxqHurOV0R2yxZW5NZQabzoRUuUzsHCDzmucOGJypB5rHg+Twqx71eAN32d1JvV2d/nZSV8ctSIck2XVvnjOI+EYhRJ+b8iTZR/2HqJ8u8SWA4pFQ1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719623515; c=relaxed/simple;
	bh=aef4F0Bvpd2E+ekA6aOSsipc4x6PfNlwGk26KdC5swY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BIemQDYCuOygAPbazM0Fv9JTOvCMxBfZ3JqZNaTO/LgUwBHfU1/gXTAnwd9D052XFFoSD9MzbsfEPWYbxKBtBu47zfigfqpEYf8YSAoK1hO5I066iE2Rn0e3fhWeABkvlN9Qm3ngWPB26b90oA2U0MoGtcUdNHLcNwwIGrsMN7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=DmSVZQYb; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="DmSVZQYb"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3d5666a4860so664786b6e.2
        for <iommu@lists.linux.dev>; Fri, 28 Jun 2024 18:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1719623513; x=1720228313; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T+KbwleecXN3riScVDyiugaIffNMxefx2YjUriSCAW8=;
        b=DmSVZQYbMyp+afbRcdI33HOZO/UpkgBO4O9n1jcqhRnAm/otaDniGbGI8yZdw3EofS
         qPbPkBrgUVnUaw4DsMP6glatCp2SU+KehBsr6vOcw0o1VP0ZRZhKWfkRmKRY7ZQu5klj
         ryKANr1oPGAoaChLn/bvQmh8M5fy7RCBlH0mcRZ48SASFbyrwRLr4Z3LFi1wmg7ZcW3d
         ycNCjgT/4DDNy8PtlmQ/rVJINrxDLv3oos1+d3+uWbMULfwDt8w+HqAkWu8ZQdvj7W0S
         jZEV5qHlcrWrRUUgT8TFt+IsGxLkfZDeMOxShUu48aQUUJV3NRwAQzfEx6mpocP4EqQr
         K3dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719623513; x=1720228313;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T+KbwleecXN3riScVDyiugaIffNMxefx2YjUriSCAW8=;
        b=X9c6+kK5TUcw094uTF6PfUmsVPDnbeUGGmk+YrEHYyJJn2XqAMuVfl7AqCNAAKApyx
         heX5OnTMqgOBHGvz8TLMxIM7ZTD/6wyYTOeNgDeCoJlp+TFB+/gOfYaZpx3Ock4okTOH
         QrC13a/oqRnPDujsJEQ5MhEo9qxoRdH93UnNSqKwW66k0IiWrsKsrtFgE9VM3KBKl8yU
         TLJC/gC0AutZDWIv9xMBLh25HkooHmKHtP6y2ccYpMSvfsPzjKSUEAho6UEKF4tZp9o/
         JkFYMUHB0afW5L5t5jQLgqKFNJw1RJaH2gH1ZpwSI0lwGEX+UcZrqrseyfwZnpMCAXjI
         X3dA==
X-Forwarded-Encrypted: i=1; AJvYcCXRX8bjHVLDZYdp7dNT3GzjNOxOp6QsT+6AePlHQT6PthM3BDCId35imuj0G5JqW6Ec3uUL42GK5SprwscRKfWyjCywfvM=
X-Gm-Message-State: AOJu0YzlwdtKL5Ojf3BzcB9jy2G52SKegsiB5KLotAbiknmWpafsVGDn
	Mf+272pF7Qdl00mGC+FclAIDSYktepW13VZVVZdQClemFljHaW/39yEXz5nRmRk=
X-Google-Smtp-Source: AGHT+IGI3SD8A1N5RAQhEKo93yRDR33fQ3JlDGvi7EAwNp2DA4Cb9gac0LEseC9mjRgt/U5qth10Jw==
X-Received: by 2002:a05:6808:17a7:b0:3d6:342b:d7f3 with SMTP id 5614622812f47-3d6342bdbb0mr2109008b6e.52.1719623513063;
        Fri, 28 Jun 2024 18:11:53 -0700 (PDT)
Received: from ziepe.ca ([24.114.37.55])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c69b53be5sm1784142a12.16.2024.06.28.18.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 18:11:52 -0700 (PDT)
Received: from jgg by jggl with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sNJrv-0004oI-S0;
	Fri, 28 Jun 2024 19:14:59 -0300
Date: Fri, 28 Jun 2024 19:14:59 -0300
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
Subject: Re: [PATCH v7 00/10] IOMMUFD: Deliver IO page faults to user space
Message-ID: <Zn814+VwyCJ/okax@ziepe.ca>
References: <20240616061155.169343-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240616061155.169343-1-baolu.lu@linux.intel.com>

On Sun, Jun 16, 2024 at 02:11:45PM +0800, Lu Baolu wrote:

> Lu Baolu (10):
>   iommu: Introduce domain attachment handle
>   iommu: Remove sva handle list
>   iommu: Add attach handle to struct iopf_group
>   iommu: Extend domain attach group with handle support
>   iommufd: Add fault and response message definitions
>   iommufd: Add iommufd fault object
>   iommufd: Fault-capable hwpt attach/detach/replace
>   iommufd: Associate fault object with iommufd_hw_pgtable
>   iommufd/selftest: Add IOPF support for mock device
>   iommufd/selftest: Add coverage for IOPF test

Small remarks aside this all looks fine to me, send a v8 and I'll try
to pick it up next week

Thanks,
Jason
