Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FDBD4F392B;
	Mon, 28 Sep 2026 22:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790634246; cv=none; b=MgIusAm0nHDs1mfboJXK+8pO5q43PVha6yBPPp9+MA0cWd/odYcNqfwdCTCWogrdkxet+nXAgGBP7hM9BIOle+m5mzjalRDcsSWMxLlqKVSrUSLyxZq6hQRvyunmL0W7DbwBYOyNYIZcnyPF8sW9fC+eMwTJOYJBSyeA4Ga8Ijc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790634246; c=relaxed/simple;
	bh=yWgL9R8J6QfXxcaXNP6NyG6bCWOtvD6I5vqArl62G4k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=emrXv5LIV933zRwRSq4RoX6Z72XgT8z/LbpOX0uKpOF4PgsiNfhRWkyldOxQT7RcMHe1W1fAhT3OBG5mNXl2KDhUJJ8cyRx8ZvNidzdsNxPszT5xtmBM4UJjTFXIe+utPPFM3yiQSAONDSyAXVJOh7An6BKM/dXZM5uuQxK6HcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=gAI7EDjq; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="gAI7EDjq"
Received: from localhost (unknown [20.236.10.163])
	by linux.microsoft.com (Postfix) with ESMTPSA id A060820B716A;
	Mon, 28 Sep 2026 15:23:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A060820B716A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1790634193;
	bh=cTAy/BNC2U75pwxrEQc/VQ2Mbb57wX4ATnB/0hzfS3A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gAI7EDjqyqQ3DD7dzjcplEewID1FzVgGMiszzqePOOKyl6tBjAXDFze5Wz3Qgzx41
	 ZndL0a+CbpuSvtMmsPAH+Q0/I7U7HqNBxw6FrKEMUllabi+KmjQXKZSGN5vT+fv8nt
	 Biy2cV00WKQ2Zpxj4uclJ9HcIlVmLAUorXbDUZto=
Date: Mon, 28 Sep 2026 15:24:02 -0700
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
Message-ID: <20260928152402.000079ce@linux.microsoft.com>
In-Reply-To: <20260928182022.GD1616761@nvidia.com>
References: <20260917140159.1163281-1-aneesh.kumar@kernel.org>
	<20260917140159.1163281-6-aneesh.kumar@kernel.org>
	<179027891416.104879.10365675178574704349.b4-review@b4>
	<yq5ald8pkhj7.fsf@kernel.org>
	<20260925122305.GG9354@nvidia.com>
	<yq5a5wzpr7b9.fsf@kernel.org>
	<20260928121147.GP9354@nvidia.com>
	<yq5azex1peqt.fsf@kernel.org>
	<20260928161738.GB1616761@nvidia.com>
	<20260928110854.00003ff0@linux.microsoft.com>
	<20260928182022.GD1616761@nvidia.com>
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

On Mon, 28 Sep 2026 15:20:22 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Mon, Sep 28, 2026 at 11:08:54AM -0700, Jacob Pan wrote:
> > Hi Jason,
> > 
> > On Mon, 28 Sep 2026 13:17:38 -0300
> > Jason Gunthorpe <jgg@nvidia.com> wrote:
> >   
> > > On Mon, Sep 28, 2026 at 09:09:06PM +0530, Aneesh Kumar K.V wrote:
> > >   
> > > > Does that mean the SMMU driver will return viommu_ops before
> > > > iommu_ops->viommu_init() is called? If so, should viommu_init()
> > > > be moved into viommu_ops?    
> > > 
> > > That's probably the cleanest arrangement, yeah. Then the TSM ops
> > > are just the same 'get_viommu_ops' call under TSM and it is easy
> > > to put in a flag 'must have null hwpt' that goes at the right
> > > point. 
> > This should also work for the parentless hypervisor vIOMMU in my
> > RFC: https://lore.kernel.org/linux-iommu/20260925190742.1575380-1-jacob.pan@linux.microsoft.com/T/#t  
> 
> Yes! That case is very similar, the hypervisor under Linux is a close
> cousin to RMM/TDX.
> 
> > I will give below a try, I currently have below (can be avoided if
> > get_viommu_ops() can simply return NULL for the hypervisor type):  
> 
> The amd_iommufd_get_viommu_ops() must only permit its own type, but
> AMD doesn't have a type right now because they are merging their
> patches bit by bit..
> 
> ARM already returns NULL:
> 
> > > +const struct iommufd_viommu_ops *
> > > +arm_smmu_get_viommu_ops(struct device *dev, enum
> > > iommu_viommu_type viommu_type) {
> > >  	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
> > >  	struct arm_smmu_device *smmu = master->smmu;
> > >  
> > >  	if (!(smmu->features & ARM_SMMU_FEAT_NESTING))
> > > +		return NULL;  
> 
> Though I wonder why would you check for IOMMU_VIOMMU_TYPE_HYPERVISOR
> in the amd driver?
> 
It is an early capability check. AMD vIOMMUs require a nesting
parent, while IOMMU_VIOMMU_TYPE_HYPERVISOR is parentless. Returning
zero prevents the core from allocating an AMD vIOMMU and calling
viommu_init() with a NULL parent. As you said above, AMD doesn't have a
allowed vIOMMU type yet.

> Maybe hyperv should be a TSM?  Maybe we should also route the
> get_viommu through the the "kvm" fd somehow?
Just to understand this better, are you suggesting to do away with
hv-iommu-root driver in the context of external domain attach, instead
let mshv (hyperv) register as a vIOMMU external provider?


