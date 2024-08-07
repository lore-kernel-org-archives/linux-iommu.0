Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE031E2101
	for <iommu@lists.linux.dev>; Wed,  7 Aug 2024 12:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723034019; cv=none; b=MfUs3YfkwQyNAkXiuWoUlyZiIIuFA+2QwSPKz1t3BKyuBx6GmxXqOzPArZTyZesQ3p3wh1sQCRv+Ckm1unnoFLIh44QHVh2Se2pMKA6aNvPcGIsJQ7Xa5dq/VMfqHko2bkqHe4MOw6urUf2jaT6EkAfgCARaIHjNu2I469gcNcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723034019; c=relaxed/simple;
	bh=cZTz1rtqq0BJgnMRbCe88pCug4d1Vy8MfxR+z41Acnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kowAXDvjufEF5SiAOh0/07PS6RSp/2X7du6KoLN2vXeQgg1uJBQHrWwHBI9ciRGrLeN8Mzn46SSu8xU5ILlu0K9UnxuPZTAlpyOYUpbyW9JNnnGfUPUwo/TbxAbh6KBrTZsaP77NvH+HKBffbFpLWGYkDy1lll/pRxyZsh5C6Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=eIMQHq2f; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="eIMQHq2f"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-44feaa08040so8685511cf.2
        for <iommu@lists.linux.dev>; Wed, 07 Aug 2024 05:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1723034016; x=1723638816; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cZTz1rtqq0BJgnMRbCe88pCug4d1Vy8MfxR+z41Acnc=;
        b=eIMQHq2f/wbeACCiiyZ3Rxke3R3tt+a+/AgGJRihWUlnubUDkqLXZRE8TSDVVL+TO9
         9l8/kOmAN7PuquoFKbXAl1oYqaWONq6r/E49/40wBm6DZTFt/qU3j/6jA/xhSXIxb+ur
         htFwNGvv6SDEQG/L9d4+RvLGoaDWnTXMT2GHYwYTEen+7vVS8eqCMiUfVs6lxDpmW+3M
         ycXumu4Ub1kb1YyGl1WNxenU0pH+Wb7QhYmQOywntxRoSp3BZbD9EEz+iMgbgCXE0mnX
         iLTfQanSMB8IdHrtLgsphRBasbrjfIWm7LJ73bYt8gcWkQrJQA28+1cSqUjyAPfyPQ80
         iP3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723034016; x=1723638816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cZTz1rtqq0BJgnMRbCe88pCug4d1Vy8MfxR+z41Acnc=;
        b=HW2Q3CAYAKZO+6AlRrul43mm29nbGiWT0vdeNqH2rq565nFSDTguRc7k5/A40qdxmR
         tD9IcACNcXG9Z49x7PqDxPKiSpMQ0fkAJjsSmL6lKaCg1GNh77QO18BdwAn1JqXL9tcx
         cBxBwZLaGKH/ZE6fjtetUSyi2IbB1zm/rKuARlh+1sJ9PZFlyi+YfOuJsNhwfBZPAQTF
         +ppr7pkMow2MCuXz7ygoHlffnVeWWREmHscz0xPIJmkWfF3yYj4ZEAyyAcvmBbKR2oft
         KyLuUwPmnIwxucEVDDpUBDb1sEXVLurLMxnvpIT3znx0c4/L8a1CPUNEmDSP7xBprUYn
         J7LQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQeqPdQfdAXDhrmgMHmDLpZqRuVtJ5EhbmzLz3ELjq7hHFJQGDLDBTg3Zv+Us1hlkJC6vJMseKq6dwgctrQkz7J3/WzA0=
X-Gm-Message-State: AOJu0Yy2mDWhxYWVcpuXsLwhatkGOIGP3Sk5cQRY3s3CDwt8IF7qLxIS
	glGIMkcC3bLgwejkgz2navCKGRG676GtHjnlCNhO24nJwOQjZHd2ELYjq/jjM3s=
X-Google-Smtp-Source: AGHT+IE5FEbOjSf6Ld8l1Wma2w5ma1HbuFnR60MrGvNqKPBGouU+RjyCiZWYqcctzesBWiDh34A/7A==
X-Received: by 2002:a05:622a:153:b0:447:e8f5:b2d1 with SMTP id d75a77b69052e-45189326c5emr226028221cf.53.1723034016340;
        Wed, 07 Aug 2024 05:33:36 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-451c87fc919sm4389161cf.96.2024.08.07.05.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 05:33:35 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sbfrC-001p0y-KM;
	Wed, 07 Aug 2024 09:33:34 -0300
Date: Wed, 7 Aug 2024 09:33:34 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	suravee.suthikulpanit@amd.com, yi.l.liu@intel.com
Subject: Re: [PATCH RFCv2] iommu: Add domain type and flag to
 domain_alloc_paging()
Message-ID: <20240807123334.GE8473@ziepe.ca>
References: <20240801144523.11803-1-vasant.hegde@amd.com>
 <8e531f39-9d14-4d3b-8a52-c2e8ca026f9e@linux.intel.com>
 <098008f7-2b3e-405a-a096-947e5df560e6@amd.com>
 <20240806123452.GE676757@ziepe.ca>
 <6b197aac-c38f-4e6e-9d32-d74e1a5b3968@amd.com>
 <20240806173230.GS676757@ziepe.ca>
 <2c537d82-c511-4367-8a5c-29122745326d@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c537d82-c511-4367-8a5c-29122745326d@linux.intel.com>

On Wed, Aug 07, 2024 at 01:49:02PM +0800, Baolu Lu wrote:

> Convert paging domain to user domain allocation appears to be a
> reasonable solution. But I think it's not VFIO-only, vhost-vdpa is
> another case, right?

I suspect vhost-vdpa doesn't use PCI devices with a PASID cap.

Hopefully they will support iommufd before that becomes an issue :)

Jason
