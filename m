Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB481849C4
	for <iommu@lists.linux.dev>; Wed,  3 Jul 2024 21:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720042228; cv=none; b=tHKulscmcchULDFC3tdVzyo/mTqZ1Cr5IV7dHY24HFsFwEq7iUfQ5s7y6xvK8H+ic8Xosw7Xf/DrAWhnQK5mX/2xGl+qmpsVYVNSo1Bn941Tw8mlWUdrHYKeJ2u/dOxclxLc2peVs+9TIkUA5RDZIZiMcVBe8OhNsMOlU1nWPAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720042228; c=relaxed/simple;
	bh=ItEwuW5FSpRgCqnKb7RkC8tFGprMzA77PgMMdX9re00=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=usdZQRp3q9HvQyySBiBES4CAJJdCNcPJpE1tYyuL5e8WP/RvII03LLgV4jgTTH+RQL1QNgles2KgdXFiKtpfQHZC+dryE7dlL6QVxs/XZxRN157zkXSN4SoaaDbB0o7Q+LmEUDsl6MYrFUoCCoNV+3ofcIoLHSOBPQX8P2XOcA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MGzNe3u+; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MGzNe3u+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720042227; x=1751578227;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ItEwuW5FSpRgCqnKb7RkC8tFGprMzA77PgMMdX9re00=;
  b=MGzNe3u+MPb1cf+nArcrfgCLaE+I4861YqXjXpwA3MqEXdsaa56HVrBg
   TqGzrP5DORVmmQjXlWmgewfuJVyizDWk6Top172NqpoQDyHlAfXYBylnZ
   mzNn7VJWHs3m2uVnoTq8I51qsehgG+a2ZOe7YZ2QrvdKP4nmldeUnnQ75
   L590IOqELaUz+kTKWEmFxR1kS0X0U75OU9Xu2gdAuMY2RpQAUHwrxVBiL
   mWh/+F8arNmrBEtbLiaYlm35ZTdSplJZ6UtoI9WZNrkfl13Bp63RxrB1L
   qV2iRbyY1WGYcv6KmG3YDipEVS4b0lbmzZs48ZR1G0Nlwknd+uD9tVerv
   A==;
X-CSE-ConnectionGUID: 1ZaCy742RAmWzso5JtC5Mg==
X-CSE-MsgGUID: B5RCrn1/Rcy/yHYMKQOxXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11122"; a="17432710"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="17432710"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 14:30:26 -0700
X-CSE-ConnectionGUID: 6Q02YzsqSby+QTuhpHgV+w==
X-CSE-MsgGUID: MWG1LX3gRTWV0L9D/kg+MA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="46173348"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.54.39.125])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 14:30:26 -0700
Date: Wed, 3 Jul 2024 14:35:39 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin
 Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian
 <kevin.tian@intel.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v3 1/2] iommu/vt-d: Add helper to flush caches for
 context change
Message-ID: <20240703143539.7ea1fac5@jacob-builder>
In-Reply-To: <1a2f66a2-a867-4203-8a76-dbced80bfeff@linux.intel.com>
References: <20240701112317.94022-1-baolu.lu@linux.intel.com>
	<20240701112317.94022-2-baolu.lu@linux.intel.com>
	<20240701214128.5523a1ea@jacob-builder>
	<28ade99a-13ad-4b01-aff2-711c006856fd@linux.intel.com>
	<20240702085749.2e2bbea5@jacob-builder>
	<1a2f66a2-a867-4203-8a76-dbced80bfeff@linux.intel.com>
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


On Wed, 3 Jul 2024 10:49:19 +0800, Baolu Lu <baolu.lu@linux.intel.com>
wrote:

> On 7/2/24 11:57 PM, Jacob Pan wrote:
> > On Tue, 2 Jul 2024 12:43:41 +0800, Baolu Lu<baolu.lu@linux.intel.com>
> > wrote:
> >   
> >> On 2024/7/2 12:41, Jacob Pan wrote:  
> >>> On Mon,  1 Jul 2024 19:23:16 +0800, Lu Baolu<baolu.lu@linux.intel.com>
> >>> wrote:
> >>>      
> >>>> +	if (flush_domains) {
> >>>> +		/*
> >>>> +		 * If the IOMMU is running in scalable mode and
> >>>> there might
> >>>> +		 * be potential PASID translations, the caller
> >>>> should hold
> >>>> +		 * the lock to ensure that context changes and cache
> >>>> flushes
> >>>> +		 * are atomic.
> >>>> +		 */
> >>>> +		assert_spin_locked(&iommu->lock);
> >>>> +		for (i = 0; i < info->pasid_table->max_pasid; i++) {
> >>>> +			pte = intel_pasid_get_entry(info->dev, i);
> >>>> +			if (!pte || !pasid_pte_is_present(pte))
> >>>> +				continue;  
> >>> Is it worth going through 1M PASIDs just to skip the PASID cache
> >>> invalidation? Or just do the flush on all used DIDs unconditionally.  
> >> Currently we don't track all domains attached to a device. If such
> >> optimization is necessary, perhaps we can add it later.  
> > I think it is necessary, because without tracking domain IDs, the code
> > above would have duplicated invalidations.
> > For example: a device PASID table has the following entries
> > 	PASID	DomainID
> > -------------------------
> > 	100	1
> > 	200	1
> > 	300	2
> > -------------------------
> > When a present context entry changes, we need to do:
> > qi_flush_pasid_cache(iommu, 1, QI_PC_ALL_PASIDS, 0);
> > qi_flush_pasid_cache(iommu, 2, QI_PC_ALL_PASIDS, 0);
> > 
> > With this code, we do
> > qi_flush_pasid_cache(iommu, 1, QI_PC_ALL_PASIDS, 0);
> > qi_flush_pasid_cache(iommu, 1, QI_PC_ALL_PASIDS, 0);//duplicated!
> > qi_flush_pasid_cache(iommu, 2, QI_PC_ALL_PASIDS, 0);  
> 
> Yes, this is likely. But currently enabling and disabling PRI happens in
> driver's probe and release paths. Therefore such duplicate is not so
> critical.
> 
> For long term, I have a plan to abstract the domain id into an object so
> that domains attached to different PASIDs of a device could share a
> domain id. With that done, we could improve this code by iterating the
> domain id objects for a device and performing cache invalidation
> directly.

Sounds good. It might be helpful to add a comment to clarify for others who
might wonder about the duplicates.

Reviewed-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

Thanks,

Jacob
