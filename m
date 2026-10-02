Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A792438490
	for <iommu@lists.linux.dev>; Fri,  2 Oct 2026 13:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790946393; cv=none; b=uhxDJr/jon7O8fK3O3OcfQI3WWCgGmu5/AtC8AM/TjoInTBWjSs4D2qR80ifK7OTOANdfMKuBpnSCXXNCYnNiQpFQOuzIOE3XTsqiMnXF+Noiel82UDdQZN5+frcI6QU7fvnVQ9HJoy0+3OcTFhmgjTyETvfatAhNRSRdJtoSVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790946393; c=relaxed/simple;
	bh=OxoSJ4srJKDimtpmkHPLj3pXrTAzJqY42lZbitdgufg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lhRaq0cIDhGRlrQtNRPRRWlwrlNexC8pUci+5Qn16g02HxdnbHVLLj0hY5+tzBU4Bygur82pnwdpDY06eBpp0IWeYqSJJD+ZAVHB6bhUcYMeCMhuxkA9P/EC0erkdeTGB4SFSQATnoXvBffgxOEb9uid44A+D/+V4645V3hEomY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=BxEPJwlp; arc=none smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="BxEPJwlp"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-3411e0ace58so9932567eec.0
        for <iommu@lists.linux.dev>; Fri, 02 Oct 2026 06:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1790946384; x=1791551184; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=M1eeIXXEBO6PHS8yDF6wQU14zHl2iX5iGebTQR/5ZsM=;
        b=BxEPJwlpUKi9xI6nbQwO7IB0KzGwoU6hW0JPBdxWfL+G5xoQgtUOiY2xAtrqaWVq93
         pRQyo6q2SV+GbkGp12LGB5pyUABhKF9IOSG+pYRV62Z1N6J/B/nJpO1DpDwMa+Q6nHnc
         vs2q0izypTwPEKEgYTktS/QUh2cX47365Plmvgb6k3bfsh4UkzH8Ju+fgz+Ko1EILEB0
         F47UQLJfzTr1mepjgoLmv0C2TSLE0LVggHhYBD/EBIc4bCkSmJlilk8Bv8LBJHW176gk
         O1IzXVguvDsvvBeiAqvuzTtzHy8QOrJK8StpSbEO09Gu6Elcu6+dJgjfL43ZcRCCVfEY
         a1Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790946384; x=1791551184;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M1eeIXXEBO6PHS8yDF6wQU14zHl2iX5iGebTQR/5ZsM=;
        b=hkLjN4P4O/OHGx9nP1VngGtZd2xSgVvPjt+reJuWUQxwWRB++k/svtyhJUwIwt87Pc
         M4Ibe7oHnqQuoQHMdkKfbJzAzxxhht0NRixtPMjoeABZd2xB05Q1zAYxCw5ZbzvyIOyT
         8QdRgLzujLhV4WPbCKI61XRTeYpDPEnOFHa4e0BGZbUyMDSYlstSD6SwHiMFyTcBtsLQ
         4pBWubu+ogFy85lZbe1w1vZZf3Yh4+QL9GPYfQ6RBoJLn3BIFKmY+HfJ0zFg+gMd8C0X
         4MjP6wyb4KrFoH9yRqCEwupB/bfXXeyjrShGcU3yGPonpXP0IIOAacUOGSvZ9Arwp2dp
         3SOA==
X-Forwarded-Encrypted: i=1; AKwUvBx2MmkrUpiXxPo16kIuTBckgWBqgtmzQQU5+k9isLDgLnmBF32m/a8UOypjqjBiG/VY+qzBSg==@lists.linux.dev
X-Gm-Message-State: AFuF++mSRtnKmnHzOOQMHEl1Z7xeH28s7BrYGYuyBsl51lzD6qG7hU6D
	iaSQyTa+KwM3fVULL8O6JhKTchVMdj6/yx09D1ZCVBGwQLHGKvszojMLjeOceu6OaeM=
X-Gm-Gg: AYBFou2mRQE174EGR17QgXtLjXxM5DkLti+QFWFp3gRO62V2p+a8663ePhYTYigcL+X
	W2kqD+/X38TjDVykIjyCprDCfsFx4OOvB+R2JsCmEUAy/kcpp/JXJmkqj24Rot7YWz7w4zguMmr
	dQ4s8dP1PmqzIFZl7QL01piTNudDhexhDrECFon3Vv0M5kz2WkM4/RtNpdasYOsFviWe7diLOPf
	2zmi4k2Y1aCpnnGrR1QOa+tc0RhHGfq7AGKe7seRadGKAsbXNHbwzWKMBZpgBGwtX8KjsoQQU/C
	7HOcsWYtmojVTXRVC81i1WwQq9CWBzVxyMk5wsCh5lFQzo/gA/EsesZguesM4sD6itYCOmg/9hC
	pSA56mU4i6I3JAuriXETlucCiCWe495aN7161gLIFkYSN2J0hCQLhgO41wLOmnI06mYGameqsfL
	2BcuaFOVbUWwb8G+VweL4550hMLmB25v5P0s4JGVoeKlxl
X-Received: by 2002:a05:7022:1587:b0:148:c6ec:13b3 with SMTP id a92af1059eb24-14f5b71069amr3573874c88.17.1790946384348;
        Fri, 02 Oct 2026 06:06:24 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14f46da52aesm5332231c88.10.2026.10.02.06.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 06:06:23 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xCcxy-0000000GZnx-1o1m;
	Fri, 02 Oct 2026 10:06:22 -0300
Date: Fri, 2 Oct 2026 10:06:22 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Sonang Patel <sonangp@nvidia.com>, linux-coco@lists.linux.dev,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <helgaas@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Will Deacon <will@kernel.org>, Xu Yilun <yilun.xu@linux.intel.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v6 11/11] PCI/TSM: Add reference-counted contexts for
 vdevice providers
Message-ID: <20261002130622.GB3481470@ziepe.ca>
References: <20260917140159.1163281-1-aneesh.kumar@kernel.org>
 <20260917140159.1163281-12-aneesh.kumar@kernel.org>
 <arq2Ql3-q9EApe3X@sonangrm.nvidia.com>
 <20260928230834.GL163130@ziepe.ca>
 <yq5av77ktyrs.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5av77ktyrs.fsf@kernel.org>

On Fri, Oct 02, 2026 at 11:44:15AM +0530, Aneesh Kumar K.V wrote:
> Jason Gunthorpe <jgg@ziepe.ca> writes:
> 
> > On Tue, Sep 29, 2026 at 12:17:30AM +0530, Sonang Patel wrote:
> >> On Thu, 17 Sep 2026 19:31:59 +0530, Aneesh Kumar K.V (Arm) wrote:
> >> > +		if (is_pci_tsm_pf0(pdev)) {
> >> > +			if (pci_tsm_disconnect(pdev))
> >> > +				pci_warn(pdev, "TSM connection is still in use\n");
> >> > +		} else {
> >> > +			tsm_remove(pdev->tsm);
> >> > +		}
> >> 
> >> What happens if the PCI device is removed (e.g. sysfs remove, surprise
> >> hot-unplug) while the vDEVICE/TDI still exists?
> >> Since removal cannot be refused, should the remove path still force
> >> the unbind/unlock?
> >
> > vfio prevents that. It currently will block the sysfs remove until
> > vfio is closed.
> 
> This came up during a Codex review of my patch set. The question is what
> happens if function 1 is assigned to the guest and function 0 is then
> removed through sysfs. Is that allowed? 

It can happen and I don't know we can do anything to prevent it.

> If so, it could be a problem because function 1 is not unbound and
> can continue to be used, while
> removing function 0 tears down DOE and IDE via:
> 
> 	pci_doe_destroy(dev);
> 	pci_ide_destroy(dev);

Ah, PCI sig keeps on giving..

The actual measurements are per function but the SPDM channel is per
device!

At least for RMM is this a problem? It looks like the spec handles
this case the function 0 destroys IDE and commands related to the
other functions will just start failing.

So I would expect the OS implementation here to have similar
properties that even though function 0 is gone the other functions
still 'work' in that they get the RMM defined failures for these
conditions.

Basically, this shouldn't result in a TSM hot unplug of function
1.. Trying to do multi-device operations is always a locking mess it
should be avoided.

Jason
