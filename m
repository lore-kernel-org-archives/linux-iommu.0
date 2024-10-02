Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB93712E1E9
	for <iommu@lists.linux.dev>; Wed,  2 Oct 2024 19:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727895780; cv=none; b=ELCpnPQjK253/au7dPiBwxzalovcK6vammUf9PT56aUQpu61FOhVGU02U1No0tp9TK6uGWVkNm7EWVQy3+8n8TPQEzcieuMDJi7HyDAuXDD4D1zBAOKbiKHLTVqBrx7fiVftsQ9Q89ml/L8akvi3OdhqfpUZZ/7oKqJNsT2I4SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727895780; c=relaxed/simple;
	bh=v7qvzppCk2gv73xuGD+Wb54KMy7S8BFl0AviVJAzKuE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HcGgRAGVCOYygEM21G1Gay/lo/tyYSDWYY4ARQZPqgfR2jB6SpyixcgMaDhxa/qQ2EG5KFfTqlrqBaoLHrptJ+BqpNIjavJXalKuFbAC/0nzqNo6GcrgCfAh7swbaUgkggYfEEc5kT5QGGD9ZIDIJVHnrQv2mIC6kEaE50cGuaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=OYcvRs/F; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="OYcvRs/F"
Received: from DESKTOP-0403QTC. (unknown [20.236.11.29])
	by linux.microsoft.com (Postfix) with ESMTPSA id C9FFC20CECC9;
	Wed,  2 Oct 2024 12:02:57 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C9FFC20CECC9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1727895778;
	bh=wR5SMsBFejHIGI+WVoJNafrggxElwEppO4g29/gjVGg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Reply-To:From;
	b=OYcvRs/FZV4N7AZGS0a5IFnualxtI0tq9Hztdl7Bhn0NWeiP/BbXMot5WZXoVzZse
	 N9blJ03KpgQv0n6W0CTXDat5pKHhYBh1ejzahw9x78s9hfHFXfxKNjdCxOlGqY0PVS
	 jO+SeT9WS5BV0b1FscI83tU7sizOIlmLOfNgiWS0=
Date: Wed, 2 Oct 2024 12:02:56 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Vasant Hegde <vasant.hegde@amd.com>, Baolu Lu
 <baolu.lu@linux.intel.com>, iommu@lists.linux.dev, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
 yi.l.liu@intel.com, kevin.tian@intel.com, jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v2 3/8] iommu: Add new flag to explictly request PASID
 capable domain
Message-ID: <20241002120256.73a383f8@DESKTOP-0403QTC.>
In-Reply-To: <20241002142331.GG1369530@ziepe.ca>
References: <20240911101911.6269-1-vasant.hegde@amd.com>
	<20240911101911.6269-4-vasant.hegde@amd.com>
	<a3e09a90-0b63-4332-9e25-a5832d5ec8b2@linux.intel.com>
	<dc29a3e4-04ba-4bfe-b06b-67c4d5bdb5a1@amd.com>
	<c6a29fc4-f08d-4601-a0f2-ef1b5d26a87a@amd.com>
	<20241002142331.GG1369530@ziepe.ca>
Reply-To: jacob.pan@linux.microsoft.com, Easwar Hariharan
 <eahariha@linux.microsoft.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Jason,

On Wed, 2 Oct 2024 11:23:31 -0300
Jason Gunthorpe <jgg@ziepe.ca> wrote:

> On Thu, Sep 26, 2024 at 04:31:52PM +0530, Vasant Hegde wrote:
> > >> Previously, the default domain was allocated by
> > >> domain_alloc_paging or domain_alloc. Now, it will be allocated
> > >> through domain_alloc_user, which, based on my understanding, is
> > >> intended for user domain allocation.  
> > > 
> > > Right. This was discussed in during v1 [1] and Jason suggested to
> > > rename this API to domain_alloc_paging_extended() after
> > > everything settles.  
> > 
> > Sorry. Missed to add the link
> > 
> > [1]
> > https://lore.kernel.org/linux-iommu/20240821163147.GZ3468552@ziepe.ca/
> >
Slightly off topic, in [1], you mentioned the following flow for
iommu_group_alloc_default_domain()
{
...
	if (req_type || iommu_def_domain_type == IOMMU_DOMAIN_IDENTITY)
{ dom = iommu_group_alloc_identity_domain();
		if (req_type || !IS_ERR(dom))
			return dom;
		/*
		 * if iommu_def_domain_type == IDENTITY fails then fall
through
		 * to PAGING
		 */
	}

If we were to have a vIOMMU that only supports "identity" and "sva"
domains, there would be no need to fall back to PAGING. I don't see any
issues if we take care of vendor driver iommu_ops accordingly. But
wanted to see if I missed anything.
 

> Yeah, I think this is the right way to go. We just misnamed the _user
> op, lets correct it.
> 
> We end up with a simple op that most drivers use and then the more
> complex op that iommufd capable drivers will implement.
> 
> We work to merge things so drivers only implement one of the two ops.
> 
> Jason

