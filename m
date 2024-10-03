Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B6813A24A
	for <iommu@lists.linux.dev>; Thu,  3 Oct 2024 16:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727971239; cv=none; b=twDT1AwGjSaLWL6vDpfgNR4fegSGVCqX6W/jXB8l5ith/nc0X6MFTIwR97BZ5NxfcpslrVsagAt82qzAuItsdjqfgjb0xDfa0R94mS7EWsq/2w4yPRm8nOLHC3INh41FWJHwFNmJtRFM/XIThqAZ8ptuwK4h0j/QN43OjzMDLFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727971239; c=relaxed/simple;
	bh=S9Heq0WpuZ6WmlnuaHFa65PtorxwTsZHKxjodx9nGec=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cmyp7wLvU+1yMr9/m1F7U/WKS66h14azNSSWWKaQqo/Nh/oxX+2RJekXOEkNLvxz6VZn8JiTov70xmRGbEpcQ9V5c3vvfuXNqt/KKiC1japARGxJBbQQbtvU9rXOqaNHdWEQYQoAKIPBxoYjthB4ODC59fnTotmhHm8PFMioKU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=QMZAUmHY; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="QMZAUmHY"
Received: from DESKTOP-0403QTC. (unknown [50.53.30.84])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2F1EE20DB359;
	Thu,  3 Oct 2024 09:00:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2F1EE20DB359
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1727971237;
	bh=A7gKSv48cqda4nf5WWnQr3U87I3NaKDPw17PeDMZknM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Reply-To:From;
	b=QMZAUmHYJHRZy9dZc0IQ3LdxQjrTgr8RYdkE+u04fFoTauciq4ovRwn3iyNh1ZwtZ
	 sU0dRa3swIvty3iFFwYatcF7yBJsqr6cWW/cZYa8VeIPxNrokawYtaRald+c+xYL1R
	 gFJMhjFH5kdZOPqJk3xenODbo4tQTjAEAnPUMhck=
Date: Thu, 3 Oct 2024 09:00:35 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Easwar Hariharan <eahariha@linux.microsoft.com>, Vasant Hegde
 <vasant.hegde@amd.com>, Baolu Lu <baolu.lu@linux.intel.com>,
 iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, suravee.suthikulpanit@amd.com, yi.l.liu@intel.com,
 kevin.tian@intel.com, jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v2 3/8] iommu: Add new flag to explictly request PASID
 capable domain
Message-ID: <20241003090035.7c62c046@DESKTOP-0403QTC.>
In-Reply-To: <20241002190705.GM1369530@ziepe.ca>
References: <20240911101911.6269-1-vasant.hegde@amd.com>
	<20240911101911.6269-4-vasant.hegde@amd.com>
	<a3e09a90-0b63-4332-9e25-a5832d5ec8b2@linux.intel.com>
	<dc29a3e4-04ba-4bfe-b06b-67c4d5bdb5a1@amd.com>
	<c6a29fc4-f08d-4601-a0f2-ef1b5d26a87a@amd.com>
	<20241002142331.GG1369530@ziepe.ca>
	<66fd98e3.170a0220.23d7ae.c2a9SMTPIN_ADDED_BROKEN@mx.google.com>
	<20241002190705.GM1369530@ziepe.ca>
Reply-To: jacob.pan@linux.microsoft.com
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

On Wed, 2 Oct 2024 16:07:05 -0300
Jason Gunthorpe <jgg@ziepe.ca> wrote:

> > Slightly off topic, in [1], you mentioned the following flow for
> > iommu_group_alloc_default_domain()
> > {
> > ...
> > 	if (req_type || iommu_def_domain_type ==
> > IOMMU_DOMAIN_IDENTITY) { dom = iommu_group_alloc_identity_domain();
> > 		if (req_type || !IS_ERR(dom))
> > 			return dom;
> > 		/*
> > 		 * if iommu_def_domain_type == IDENTITY fails then
> > fall through
> > 		 * to PAGING
> > 		 */
> > 	}
> > 
> > If we were to have a vIOMMU that only supports "identity" and "sva"
> > domains, there would be no need to fall back to PAGING.  
> 
> That's illegal. If you support SVA the driver can and should support
> PAGING. I don't want to see SVA being special.
> 
> There must always be a DMA API domain of some kind, if identity
> doesn't work then paging must, otherwise the device is unusable.
> 

I also think that the PAGING domain is an integral part of any IOMMU
driver and must be included. However, from a use case point of view, we
can already have a configuration where, under a single IOMMU, some
devices use SVA while others (e.g., trusted devices) use the identity
domain.

My question is more about the incremental development of the pvIOMMU
guest driver. Since the PAGING domain requires more infrastructure than
SVA (e.g. may leverage your Generic Page Table work for constructing
S1; please correct me if that is not the intended usage), would it make
sense to add the PAGING domain after SVA and identity domain support?"

Thanks,

Jacob
