Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1941922F2
	for <iommu@lists.linux.dev>; Thu, 29 Aug 2024 12:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724933278; cv=none; b=LfGy4FQrygC7LljqcZlKvZLqv6bmjQK4W9ZxTtrPg4A4msYrhKj1y5au15SqwxoLkIuvw8Dp85CWOpsTjBLStt2BNmfGnz0xfqn0oo/5HTcz9KbmwaVxzKffB1dVHjv9CdvjKN9swsi9k7xiUFrK7LqMEgGC+lXkvZnnPn2vE9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724933278; c=relaxed/simple;
	bh=Nf3CAxLtlz8uAbGAT+7taAPjope5qXY1PBkjsxs7vdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=URiENSpa7Oga8BQvVNBJAshsZeEkQsRBQgB1WdryI+/NJJSDkJWKn4aMZDvD/czsXlSnw8I5q0A6ZDkeWcjCPm32Fc4z1Hwme2rhdIUc3C+qrwidPoH8JFL33pXqHgHyO/HwLG4tdIImI8ZRECt05qPWdLsZzf8s9n2dmzwxKtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=DXdBoHti; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="DXdBoHti"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-45685a3b1d8so2425491cf.1
        for <iommu@lists.linux.dev>; Thu, 29 Aug 2024 05:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1724933276; x=1725538076; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xb3+07iy9NTaVPK92198+wLvvVC/Nq0ZQtaVfVkE/gM=;
        b=DXdBoHtiEBRPECnJ3sScQfV4QGQghFBb0k7snClTnYIGEtF3c1TF+OcHzZCw0zqBPX
         59yXR9Bzmlv55/KsvSA8EOWyJqloIyAYyifTeMXsyPdktu4rbLo/QUrbKIdd6Edb7zFX
         CLhpTocLB6WVupEX6g02AYKRmQdzRCzmiP0PX+DiGiM7Vfx/en366oRwlMRQa4iCvKPQ
         JgH4mgiNbl+ljmGokGzI87yDdbS8U78f+TS8VdFuU4gnna8j0nAD5wXuHfDBC43Gt2Ti
         TiBVu2G7UU91FReinS4B8l5hQQ3UP3Bh0ht9udDqqftRYToHKyT+FLJ+5M4wWyREVj4X
         bPUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724933276; x=1725538076;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xb3+07iy9NTaVPK92198+wLvvVC/Nq0ZQtaVfVkE/gM=;
        b=VfXEB6DfMo9OzKc3AH//HTLxutauzUn3FDwdm5Hu7/gh5G4cnZ9X0unubjc4TsRm6y
         vEviRM1NpskYC3mqnTBvA8Wy5ucfAh+sid5VaN+nRQ0gYp9u9HlzsGMVWgUEuRfl+0Rk
         cS6V9Fmfq1G0usVNHuYKKqbFnu2djZbjVRA4eJ8VfX70t6RYU2ULT88+4lJejpMx8PSH
         4rZ0lAPvGVzjiNDgYZCZ7mf6ii+0vMBhQ9IRV/pj0ZwbzIW/GLJz8DtBIJz5XzbRcmdn
         4RJlDNQVvgg301BncGuRU2V1JOROoAVFh/8xYkKT8frzNegaHLK8FuUK20qwfAJuKsD2
         VAQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNRFdDywyPbp3oHp/ms/Y8nxCcH5TO8NrXs2PhsM5+MwDKdjKeg1QL3ptdLoUybVfywP5xjw==@lists.linux.dev
X-Gm-Message-State: AOJu0YycDeCP59GPc+iag6HSggDrzOVCwETxFsemP0fmyMd8s9YBFFYZ
	K2ZuuUomtfQjaEwKPqQTbtZ3m3y4o0AGrZg/C5848wss7L4YfzclogSFBt1AwAY=
X-Google-Smtp-Source: AGHT+IH/5FQ+vPJhqbN9c15Uc86CJ39bOFxfZbCDjJIWH/ya9lQDuX9DcvEIhSSVh+BpE3Fy6Cl/pQ==
X-Received: by 2002:ac8:7dc6:0:b0:456:4736:7dc1 with SMTP id d75a77b69052e-45680320e35mr32266511cf.29.1724933275823;
        Thu, 29 Aug 2024 05:07:55 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45682c82882sm4308951cf.13.2024.08.29.05.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 05:07:54 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sjdwP-007TcX-Ew;
	Thu, 29 Aug 2024 09:07:53 -0300
Date: Thu, 29 Aug 2024 09:07:53 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Dan Williams <dan.j.williams@intel.com>,
	pratikrajesh.sampat@amd.com, michael.day@amd.com,
	david.kaplan@amd.com, dhaval.giani@amd.com,
	Santosh Shukla <santosh.shukla@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Michael Roth <michael.roth@amd.com>, Alexander Graf <agraf@suse.de>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>, Lukas Wunner <lukas@wunner.de>
Subject: Re: [RFC PATCH 07/21] pci/tdisp: Introduce tsm module
Message-ID: <20240829120753.GU3468552@ziepe.ca>
References: <20240823132137.336874-1-aik@amd.com>
 <20240823132137.336874-8-aik@amd.com>
 <20240827123242.GM3468552@ziepe.ca>
 <6e9e4945-8508-4f48-874e-9150fd2e38f3@amd.com>
 <20240828234240.GR3468552@ziepe.ca>
 <d9bd104b-e1a0-4619-977c-02a27fc2e5b0@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9bd104b-e1a0-4619-977c-02a27fc2e5b0@amd.com>

On Thu, Aug 29, 2024 at 02:57:34PM +1000, Alexey Kardashevskiy wrote:

> > > Is "extend the MAP_DMA uAPI to accept {gmemfd, offset}" enough for the VFIO
> > > context, or there is more and I am missing it?
> > 
> > No, you need to have all the virtual PCI device creation stuff linked
> > to a VFIO cdev to prove you have rights to do things to the physical
> > device.
> 
> The VM-to-VFIOdevice binding is already in the KVM VFIO device, the rest is
> the same old VFIO.

Frankly, I'd rather not add any more VFIO stuff to KVM. Today KVM has
no idea of a VFIO on most platforms.

Given you already have an issue with iommu driver synchronization this
looks like it might be a poor choice anyhow..

> I wonder if there is enough value to try keeping the TIO_DEV_* and TIO_TDI_*
> API together or having TIO_DEV_* in some PCI module and TIO_TDI_* in KVM is
> a non-confusing way to proceed with this. Adding things to the PCI's sysfs
> from more places bothers me more than this frankenmodule. Thanks,

I wouldn't mix them up, they are very different. Just because they are
RPCs to the same bit of FW doesn't really mean they should be together
in the same interfaces or ops structures.

Jason
