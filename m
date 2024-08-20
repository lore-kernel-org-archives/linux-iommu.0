Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1852E18FDC0
	for <iommu@lists.linux.dev>; Tue, 20 Aug 2024 13:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724161918; cv=none; b=ZrmJ728ORfg6DSUANY/48K2+3VqQPBqI6gGNozgMMUUh9fSzaGcztVwL4tZrjyIlSouK7bhiKVSdCftqY38z2uje1ThjUAR5PywKXMKABida4zaBhn7mHa2BsdAH0eFYlDXlN8TXLdM3vI3ceMzi4iy2WD+ugbmmGEdzwWl+iB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724161918; c=relaxed/simple;
	bh=97OqfwoT8bEFm+agkfbPwaf/JyVQpFAXVsk7wW7MwcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QsbiPZ9yJ/PdQ6QIAGGz9hVZMyuPvVnam1i+k11z95pTpjOasgw9VeaFGs760bkJE2TjBvnPpW94Jiu+7y3InX+X5QSuAAI9FryEhGheUdsJ70dWNB3sE7WRmhUZqS9L7h8UHKUZx6roAu7SSxv7wfzm7CfFHxNnkLwwarbkJUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=GjESOEZk; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="GjESOEZk"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-44fe28eb1bfso30659341cf.0
        for <iommu@lists.linux.dev>; Tue, 20 Aug 2024 06:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1724161916; x=1724766716; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iPMBqKgTvu/q/t3NJNOvrEVL1q4BW88uaiAwCMNkjIY=;
        b=GjESOEZkkVVE/j5wDvPoiLzWPEvZvTk3eeoF3viKPgbo3TKvApjmN2QOS7eoJSKOk3
         FT8gxqt1Q5s3j/ssEsLuxHfBNQjYDaglW15+rCQ+7CB8lSzZ0fClYXtkrpGoGRZsMvy9
         vMvPTQQXarRv41idZrW9Z7dfTsDQesTzyurDmE4+Hqjvos+rAi7xz/spFXYQ/NmrA2gj
         Edd2RoWMrRT8Vuo59/NFGD0kD42GmcLmGSRutnzf2KMYsLSnOavr+lmRXJunb3yRjvVH
         XbX6I+9LzZcAxVFAJH8LgGnUfe3Gr9K4o+n19J61YG7BrQxa/6G5FXgz1o4UyefyXHfK
         Zb2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724161916; x=1724766716;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iPMBqKgTvu/q/t3NJNOvrEVL1q4BW88uaiAwCMNkjIY=;
        b=E1OTa7y7xj7xarMgT9cBaagbqvCYlGbYFZoeFdtCrzQjslYx7eVIKljNi/EyZsjk2U
         ktfSXZzhu6P5RXvi/VsaY4jif7G15oCB0i71Ur/6/G18ymCpJ7Ecds7VxMW3r4FjIk7G
         0dWpQltjncSZ6RSZdjZnfxhIVVdmmlGBgS0iLjieHSADwKYaBb0s9EMI3/rSAmIkTPFF
         xoZ11cjMIix1OYa9zAQcbuCDDoqC+EPmT53h/ihehvEDJhPz4Y+rGbnUkoNX60cp+FzM
         /FAK7694MsCF/Ii94qJjjmRAli52oKdUq2KvBz/UqPoaXGs4gwZWWS/btpILmaoOC+7w
         NbfA==
X-Forwarded-Encrypted: i=1; AJvYcCXtFRSDNnsuWzxUGDFbjNYkuu/OVWEQ7QSSH85nKi1DK4hoj65y4VmLzj811aTIuoIEB1h95Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzw/oXiHx6sQ+yKs92fTVLqxstW21LVHbzmNNrz7w7361xXaDF9
	NFiNVmArPdVK+TTjlxUgmn6E24dRUl7NApd7KLdIy6ariPa+arpoTRTR2oCNJdk=
X-Google-Smtp-Source: AGHT+IE8l4btvL7gxpv9mQUEjr4ul3TSWB5MNmKj7f4Jk9Pj3F1VoaUwJFVfS7skgn4lp6UUwD3NCQ==
X-Received: by 2002:a05:622a:1f13:b0:446:5ac5:f9dd with SMTP id d75a77b69052e-4537420d824mr161727411cf.14.1724161915910;
        Tue, 20 Aug 2024 06:51:55 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-454e904ff81sm5792571cf.35.2024.08.20.06.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 06:51:55 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sgPH7-002VqE-VD;
	Tue, 20 Aug 2024 10:51:53 -0300
Date: Tue, 20 Aug 2024 10:51:53 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Move PCI PASID enablement to probe path
Message-ID: <20240820135153.GW3468552@ziepe.ca>
References: <20240816104945.97160-1-baolu.lu@linux.intel.com>
 <6650ce02-ac85-4cb6-941c-cc7e8b6effc4@amd.com>
 <92b55591-e106-4366-ba5b-0588af50770f@linux.intel.com>
 <635b24b7-632d-4046-b82e-6ac6976686c9@amd.com>
 <0e807eec-ce51-42e2-9290-dc90c4210888@linux.intel.com>
 <20240819123400.GU3468552@ziepe.ca>
 <4d9c1513-8062-4594-a06a-c9f179abdaab@linux.intel.com>
 <72e59734-431e-4eb4-b27c-44eefab3dcb0@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72e59734-431e-4eb4-b27c-44eefab3dcb0@amd.com>

On Tue, Aug 20, 2024 at 02:00:08PM +0530, Vasant Hegde wrote:

> > Some architectures, including VT-d non-scalable mode, doesn't support
> > ATS translation and translated requests when it is working in the
> > IDENTITY domain mode. 

ARM has a similar issue.

ATS enablement should be done when the domain is attached in those
cases.

Arguably you don't want to turn ATS on anyhow for pure IDENTITY with
no PASID because it is just pointless.

> In that case, probably PCI ATS still need to be
> > disabled when such domain is attached and re-enabled when the domain is
> > detached.
> 
> Does it make sense to move both PASID/PRI enablement to probe() path? something
> like below :

It makes sense.

I don't see any ordering restriction in the PCI specification.

Notice that PASID does have a specific called out restriction:

	/*
	 * Note that PASID must be enabled before, and disabled after ATS:
	 * PCI Express Base 4.0r1.0 - 10.5.1.3 ATS Control Register
	 *
	 *   Behavior is undefined if this bit is Set and the value of the PASID
	 *   Enable, Execute Requested Enable, or Privileged Mode Requested bits
	 *   are changed.
	 */

> [I am assuming ops->dev_enable_feat() interface is going away]

Is the plan
 
>   - Enable device side PASID/PRI during ops->probe_device()

Yes

>   - In device attach path (ops->attach_dev()), depending on IOMMU, device and
> domain capability configure the features like PASID, IOPF and ATS. That means
> ATS enablement is still done at attach device path.

From a PCI perspective only ATS can be changed at this point..

The SW construct of IOPF can be changed during domain attachment.

Everything that is PF-only must be setup during probe_device only
otherwise SRIOV VFs will be broken insome cases.

See
https://lore.kernel.org/all/0-v1-0fb4d2ab6770+7e706-ats_vf_jgg@nvidia.com/
for this concept applied to ATS.

This means probe_device() has to do:

 - ATS properties 
 - PRI
 - PASID properties

At a minimum.

It would be nice if the iommu core code did this setup in one place
immediately after calling probe_device() but before attaching a
domain.

There is no particularly good reason to have this coded in all the
iommu drivers.

Jason
