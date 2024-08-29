Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846491B1D61
	for <iommu@lists.linux.dev>; Thu, 29 Aug 2024 17:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724953250; cv=none; b=MHsCO395Gzcnj6+WIEAaEVx/3nAdkcHoiYJ/OTGkWq6Bz0EggW8gVLQxGzqllglyclUzNmUxZUV4lDvemj2/9EX4eS8zmObJGupFfmFeL595JFDWTNGwEuX3J67nXg5dtKW02uyMl1GQZjD0bG/CJ8TjzyBpJlA8yNeJJetGngQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724953250; c=relaxed/simple;
	bh=Lvrosnxdk/spGd+eI/XzO9GpJu3MWng8sl5G0q2l1VE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ggNCfkVci0zsQSOOXBuYJOyNsRHj0p/LBl7+MVTaCIGJQyJ50o0nCi7Z7qX72bKSbGkr230RtQaHyyKPQBfWvudqyHAGSWN3jBnISM+vLvYb5SfzH5Rx1fRy0BHLM4ZQtigvGC6W/FuvAazCsC/ZUc81qroTPdSsDUBBAl1ZOZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=LEbbV/a6; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="LEbbV/a6"
Received: from DESKTOP-0403QTC. (unknown [20.236.11.69])
	by linux.microsoft.com (Postfix) with ESMTPSA id A883C20B7165;
	Thu, 29 Aug 2024 10:40:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A883C20B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1724953249;
	bh=TGsL0WA6x/nUevrGtw8feZ55hg4QhUJgvbnvMMUfpy0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LEbbV/a6XTDRUX/lpGJXnOgn2Wzokg61oPhA+qQoGU6z9fleAA4gVK4q4K6/9bomh
	 Ah/wL6TuLKjVp3k06uA611nKMZ5SvPgLe4TJlLcltCmZg0aIXTMsZASzXjaRim1W4P
	 a2QoXFDZew44SoyGBiwOhuPdJpcbFjrlKBJKPk7c=
Date: Thu, 29 Aug 2024 10:40:47 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Yi Liu <yi.l.liu@intel.com>,
 iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
 baolu.lu@linux.intel.com, kevin.tian@intel.com
Subject: Re: [PATCH 1/5] iommu: Enhance domain allocation code to take
 additional flags
Message-ID: <20240829104047.56137eda@DESKTOP-0403QTC.>
In-Reply-To: <b57b8846-9d13-4ede-98ba-2d09268c15ce@amd.com>
References: <20240821133554.7405-1-vasant.hegde@amd.com>
	<20240821133554.7405-2-vasant.hegde@amd.com>
	<20240821163147.GZ3468552@ziepe.ca>
	<67436cba-3d05-4528-9519-231b8396ed51@intel.com>
	<20240822124433.GD3468552@ziepe.ca>
	<0ca31cc6-1741-40d1-b8c1-20e6b4fc955a@intel.com>
	<8215e4d4-2077-4fca-a002-27ddbfc0ddf2@amd.com>
	<20240828145224.2e949806@DESKTOP-0403QTC.>
	<6741bdcc-d9ca-4090-805b-3a7f4a4d650a@amd.com>
	<20240829121002.GV3468552@ziepe.ca>
	<b57b8846-9d13-4ede-98ba-2d09268c15ce@amd.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Vasant,

On Thu, 29 Aug 2024 18:17:38 +0530
Vasant Hegde <vasant.hegde@amd.com> wrote:

> Jason, Jacob,
> 
> 
> On 8/29/2024 5:40 PM, Jason Gunthorpe wrote:
> > On Thu, Aug 29, 2024 at 04:21:32PM +0530, Vasant Hegde wrote:  
> >>>> Note that when we use NESTED page table it will have both v1 (L2
> >>>> / stage 2 level) and v2 page table (L1 / stage 1 level). Even in
> >>>> this setup V2 page table inside guest can support PASID.
> >>>>  
> >>> Sorry I am still confused. So V2 can support both PASID and no
> >>> PASID (untagged DMA). For the nested case, if the guest wants to
> >>> allocate a UNMANAGED domain, would you use V1? If this code in
> >>> [3/5] below runs in the guest:  
> >>
> >> In nested scenario, Guest will always use V2 page table (and host
> >> will use V1 page table).  
> > 
> > Sure, that is how it must work but..
> >   
> >>> static struct iommu_domain *amd_iommu_domain_alloc(unsigned int
> >>> type)
> >>>
> >>> 	/*
> >>> 	 * Force IOMMU v1 page table when allocating
> >>> 	 * domain for pass-through devices.
> >>> 	 */
> >>> 	if (type == IOMMU_DOMAIN_UNMANAGED)
> >>> 		pgtable = AMD_IOMMU_V1;
> >>>
> >>> Hardware-wise, in nested case, can V1 be used in L1/S1 for DMA w/o
> >>> PASID?  
> >>
> >> Actually no. L1 (Guest) will use V2 page table.   
> > 
> > Where is the code for this? How does it work today?
> > 
> > I have the same confusion as Jacob where I don't see the driver
> > making the distinction - ie as above...  
> 
> Sorry. I was only thinking about HW vIOMMU support.
> 
> Today we have two modes:
> 1) Device passthrough : No IOMMU support inside guest. Host will use
> V1 page table.
> 
> 2) Emulated amd-iommu driver in qemu :
> For some reason (which I am not aware) emulated AMD IOMMU driver in
> qemu implemented V1 page table. So if we use emulated IOMMU it will
> use V1 page table in guest. But this doesn't support DMA for
> passthrough devices.
> 
> Hence it worked fine so far.
> 
> For HW-vIOMMU where we will have nested page table, Host will be in
> V1 and Guest will be in V2 page table. We need to add few checks to
> detect and use appropriate page table. It should be part of nested
> page table support.
> 
Thanks for explaining. I am curious to see how vIOMMU is virtualized,
since for each guest DTE (assume it is the same format as host), you
would need a Host Page Table Root Pointer (SPA) then add PASID support
in GCR3 table.

I don't know where the guest can get the host page table root pointer,
perhaps just ignored?

On Intel, guest can just do S1 only, S2 pointer can be ignored
architectually based on PGTT (PASID Granular Translation Type).

Thanks,

Jacob
