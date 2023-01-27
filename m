Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1AE3205
	for <iommu@lists.linux.dev>; Fri, 27 Jan 2023 16:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674836956; x=1706372956;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yjsj1vDvUUtLPugYITiBGXva07h6yyBafFBFB22irG0=;
  b=Sf8izAQyKF/K1EtR4VStTclJXAfJxIAfmjLZlucmp1IbgUL63EEZj9wf
   JmCBSJp1tIS1ksh+BcStwDBbtQjd4S6MyZjgtM0ifR9tXXspCzz08p5UQ
   zPMKdNgpYXgDMXC8XOhGyQYOQ95r1qIAKgyRN1h424PScFMFMLTKEgcKg
   V7P1rAh14xaoaX12cSRLvQAjprKG8pKgkmpYW6xN4ag54b56OcQxOvBHx
   XsC/ncq5WCduh86NvhK7kXvMBtdtoS99jHY3gjdEEhuZXSh3GuM2R70S6
   y13J69N38/NlTVKqYXGfLOkQ0Gk3wcdtuKeihQsId/CF/uT7Pjot7SyDe
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="315075861"
X-IronPort-AV: E=Sophos;i="5.97,251,1669104000"; 
   d="scan'208";a="315075861"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 08:29:15 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="731902592"
X-IronPort-AV: E=Sophos;i="5.97,251,1669104000"; 
   d="scan'208";a="731902592"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 08:29:15 -0800
Date: Fri, 27 Jan 2023 08:32:45 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, hch@lst.de, jgg@nvidia.com,
 baolu.lu@linux.intel.com, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v2 5/8] iommu: Switch __iommu_domain_alloc() to device
 ops
Message-ID: <20230127083245.1a0bc8e1@jacob-builder>
In-Reply-To: <389082e3-f4c3-4e84-a2d0-629612eed305@arm.com>
References: <cover.1674753627.git.robin.murphy@arm.com>
	<23b51c84247cb36e96c242d3aef8ef555b6d05cd.1674753627.git.robin.murphy@arm.com>
	<20230126152237.2f8b681f@jacob-builder>
	<389082e3-f4c3-4e84-a2d0-629612eed305@arm.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Robin,

On Fri, 27 Jan 2023 11:42:27 +0000, Robin Murphy <robin.murphy@arm.com>
wrote:

> On 2023-01-26 23:22, Jacob Pan wrote:
> > Hi Robin,
> > 
> > On Thu, 26 Jan 2023 18:26:20 +0000, Robin Murphy <robin.murphy@arm.com>
> > wrote:
> >   
> >>   
> >> +static int __iommu_domain_alloc_dev(struct device *dev, void *data)
> >> +{
> >> +	struct device **alloc_dev = data;
> >> +
> >> +	if (!dev_iommu_ops_valid(dev))
> >> +		return 0;
> >> +
> >> +	WARN_ONCE(*alloc_dev && dev_iommu_ops(dev) !=
> >> dev_iommu_ops(*alloc_dev),
> >> +		"Multiple IOMMU drivers present, which the public
> >> IOMMU API can't fully support yet. You may still need to disable one
> >> or more to get the expected result here, sorry!\n"); +
> >> +	*alloc_dev = dev;
> >> +	return 0;
> >> +}
> >> +
> >>   struct iommu_domain *iommu_domain_alloc(struct bus_type *bus)
> >>   {
> >> -	return __iommu_domain_alloc(bus, IOMMU_DOMAIN_UNMANAGED);
> >> +	struct device *dev = NULL;
> >> +
> >> +	/* We always check the whole bus, so the return value isn't
> >> useful */
> >> +	bus_for_each_dev(bus, NULL, &dev, __iommu_domain_alloc_dev);
> >> +	if (!dev)
> >> +		return NULL;  
> > Since __iommu_domain_alloc_dev() will always return 0,
> > bus_for_each_dev() will never breakout until the whole dev list is
> > iterated over. If so, would dev only record the last one? i.e. prior
> > results get overwritten.  Maybe a misunderstood the logic.  
> 
> Yes, as the comment points out, the intent is to walk the whole bus to 
> check it for consistency. Beyond that, we just need *a* device with 
> IOMMU ops; it doesn't matter at all which one it is. It happens to be 
> the last one off the list because that's what fell out of writing the 
> fewest lines of code.
> 
> (You could argue that there's no need to repeat the full walk if the 
> WARN_ONCE has already fired, but I'd rather keep the behaviour simple 
> and consistent - this is only meant to be a short-term solution, and 
> it's not a performance-critical path)
That make sense now, thank you for the explanation.


Jacob
