Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCAB12F7F09;
	Tue, 29 Sep 2026 05:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790661330; cv=none; b=fM81fA1M6O49AQOHFYM0PqvFGttU4RSLq7Sh8cHKQG4ZhSFSSauniUiQd5MY4KQaXnKfRbNvvjZSxGZ9QpKPI8FCCqB6DQa9Aq2bv8gIgmYqL1Bl+gqgr/4MZe2fQy33v0B1AVQONnfbaqdTtVEES/dFH3kax/lOLLB4FbkNGYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790661330; c=relaxed/simple;
	bh=Fp3ASAfdwGkKv8Do8YeHQOXYlQNzOd7+pSHNk78Jv+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dWABAjaXMop+6EcfZ2cOGgjIrgZQnud02kwgH9hODq6d6XC1nz70Dzvr+I0jxHQxke4qvBdQCVMzTttYkJmIvejx3zDVbZC2ESc06z6qgjxmemu04aChig++bqdWmWTMqmEeTlUdf6AFO5CLSukYxJI6szhuAsb0elfbT/FflLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=AkPxVdjD; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="AkPxVdjD"
Received: from localhost (unknown [52.148.171.5])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9874020B7166;
	Mon, 28 Sep 2026 22:54:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9874020B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1790661276;
	bh=RqvZ73cpuNzHe1b0yJARkZbhTnZBRPHAmgqGr1m2fww=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AkPxVdjDCERw9peipuPPRQynyjaW2tN6h+VXzjWNM9NWri/sqSmXwEuD3q5SsBU2j
	 oJNGtMBTSjefMRdFCTF44Lo7OHpaCjJQTKkOqtRzvcWLxVSFhNue0DluJSVFMigZEb
	 NRAmYqCWk3RlxrpCOzuLOBZjh0CLngPFF4wQo8m8=
Date: Mon, 28 Sep 2026 22:55:24 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 linux-coco@lists.linux.dev, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Alexey Kardashevskiy
 <aik@amd.com>, Bjorn Helgaas <helgaas@kernel.org>, Joerg Roedel
 <joro@8bytes.org>, Jonathan Cameron <jic23@kernel.org>, Kevin Tian
 <kevin.tian@intel.com>, Nicolin Chen <nicolinc@nvidia.com>, Samuel Ortiz
 <sameo@rivosinc.com>, Steven Price <steven.price@arm.com>, Suzuki K Poulose
 <Suzuki.Poulose@arm.com>, Will Deacon <will@kernel.org>, Xu Yilun
 <yilun.xu@linux.intel.com>, Shameer Kolothum
 <shameerali.kolothum.thodi@huawei.com>, Paolo Bonzini
 <pbonzini@redhat.com>, jacob.pan@linux.microsoft.com
Subject: Re: [RFC PATCH v6 05/11] iommu: Add a helper to validate a vIOMMU
 parent
Message-ID: <20260928225524.00002b85@linux.microsoft.com>
In-Reply-To: <20260928230328.GE1616761@nvidia.com>
References: <179027891416.104879.10365675178574704349.b4-review@b4>
	<yq5ald8pkhj7.fsf@kernel.org>
	<20260925122305.GG9354@nvidia.com>
	<yq5a5wzpr7b9.fsf@kernel.org>
	<20260928121147.GP9354@nvidia.com>
	<yq5azex1peqt.fsf@kernel.org>
	<20260928161738.GB1616761@nvidia.com>
	<20260928110854.00003ff0@linux.microsoft.com>
	<20260928182022.GD1616761@nvidia.com>
	<20260928152402.000079ce@linux.microsoft.com>
	<20260928230328.GE1616761@nvidia.com>
Organization: LSG
X-Mailer: Claws Mail 3.21.0 (GTK+ 2.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Jason,

On Mon, 28 Sep 2026 20:03:28 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Mon, Sep 28, 2026 at 03:24:02PM -0700, Jacob Pan wrote:
> > > > > +arm_smmu_get_viommu_ops(struct device *dev, enum
> > > > > iommu_viommu_type viommu_type) {
> > > > >  	struct arm_smmu_master *master =
> > > > > dev_iommu_priv_get(dev); struct arm_smmu_device *smmu =
> > > > > master->smmu; 
> > > > >  	if (!(smmu->features & ARM_SMMU_FEAT_NESTING))
> > > > > +		return NULL;    
> > > 
> > > Though I wonder why would you check for
> > > IOMMU_VIOMMU_TYPE_HYPERVISOR in the amd driver?
> > >   
> > It is an early capability check. AMD vIOMMUs require a nesting
> > parent, while IOMMU_VIOMMU_TYPE_HYPERVISOR is parentless. Returning
> > zero prevents the core from allocating an AMD vIOMMU and calling
> > viommu_init() with a NULL parent. As you said above, AMD doesn't
> > have a allowed vIOMMU type yet.  
> 
> I'm a bit confused why a hyperv root parition has an AMD iommu inside
> it.. I thought that was what the hv-iommu-root driver was for?
> 
You are right, AMD iommu driver should never load in hyperv root.
I introduced this check in AMD driver for completeness as part of the
generic iommufd change.
https://lore.kernel.org/linux-iommu/20260925190742.1575380-3-jacob.pan@linux.microsoft.com/T/#u

> But we should fix the AMD driver to have a type (ooops that is a
> troublesome bug!),
Agreed.

> and you should call add-on-top drivers like TSM
> before calling the real iommu driver..
> 
I am not seeing a need for mshv to use the add-on driver like TSM,
since MSHV is not layered on top of a physical IOMMU driver.

Also, we don't have a T=0 to T=1 transition, our intended external
attach can be transitioned from a blocked domain, not from a paging
domain to external.

> > > Maybe hyperv should be a TSM?  Maybe we should also route the
> > > get_viommu through the the "kvm" fd somehow?  
> > Just to understand this better, are you suggesting to do away with
> > hv-iommu-root driver in the context of external domain attach,
> > instead let mshv (hyperv) register as a vIOMMU external provider?  
> 
> Maybe? I don't quite understand what you've got here..
> If the VM path doesn't interact with the iommut at all, which is how
> these CC cases are, then sure that might be a good idea.
I do think keeping the hv-iommu-root route is cleaner and logical. I
misunderstood your comment about "hyperv should be a TSM".

> I think you are going to have module dependency issues trying to get
> the mshv driver's info into the iommu driver, adding a "TSM" like
> driver would resolve that. ie mshv could just provide the viommu.
> 
I introduced a similar registration interface in hv-common to solve the
module dep issue. Will look into if I can leverage the vIOMMU helper
here.

> But, you do have a hv-iommu-root driver so it certainly can provide
> the viommu too, if that can be done cleanly.
> 
> I guess think about it ?
Yes, my RFC has hv-iommu-root provide the hypervisor vIOMMU directly,
and I think the resulting layering is clean. Could you review that
approach in the MSHV iommufd RFC thread? 

> 
> Jason

