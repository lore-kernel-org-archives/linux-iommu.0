Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9723C39
	for <iommu@lists.linux.dev>; Wed, 15 Feb 2023 18:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676486082; x=1708022082;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xqpsHtcfNvJw/Y7dtWUa5FrDokwdID3lZj/BycG68iw=;
  b=F9DWfXe+Wwl/PC8SSmhuLpOTYAfJUMg0VdIBOyd7bPasySebVJ+4zx8X
   /yYu5htM9i7Tt2imiamYMQ6t7MtkQbQrSu+MzXFuKRZKfRl5xCp5n59AN
   O18eKslcaBhoUTs/IRg4UFN5rkzQIIwiM07dmahsE4lTAIEkH9iysdpQn
   NnQ5dLXGtN0Qsd0Fl9mjwbJRWPh2Wm4npGOWTAomKPjCwLsXb4L/al0Nd
   g6kzhf9XvEUHLq0GQe51YFF0v7U+M8ZlXz5ZdMJ/NcceOY3rUbtGs9AFD
   9d7/GkiQHgpVRN4mF21CGM8THRrOIQQzQRnDVqYyz2GHr0zN6nzAVRMmp
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10622"; a="332821619"
X-IronPort-AV: E=Sophos;i="5.97,300,1669104000"; 
   d="scan'208";a="332821619"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 10:34:41 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10622"; a="671783944"
X-IronPort-AV: E=Sophos;i="5.97,300,1669104000"; 
   d="scan'208";a="671783944"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 10:34:41 -0800
Date: Wed, 15 Feb 2023 10:38:22 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, Jason Gunthorpe <jgg@nvidia.com>, Lu Baolu
 <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Jean-Philippe
 Brucker" <jean-philippe@linaro.com>, Robin Murphy <robin.murphy@arm.com>,
 Will Deacon <will@kernel.org>, "David Woodhouse" <dwmw2@infradead.org>,
 "Raj, Ashok" <ashok.raj@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v2 2/3] iommu/sva: Stop using ioasid_set for SVA
Message-ID: <20230215103822.6235ada9@jacob-builder>
In-Reply-To: <BN9PR11MB527670F77FADCB351E41F8B78CA39@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230214064414.1038058-1-jacob.jun.pan@linux.intel.com>
	<20230214064414.1038058-3-jacob.jun.pan@linux.intel.com>
	<BN9PR11MB527670F77FADCB351E41F8B78CA39@BN9PR11MB5276.namprd11.prod.outlook.com>
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

Hi Kevin,

On Wed, 15 Feb 2023 03:24:18 +0000, "Tian, Kevin" <kevin.tian@intel.com>
wrote:

> > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Sent: Tuesday, February 14, 2023 2:44 PM
> > 
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > 
> > Instead SVA drivers can use a simple global IDA to allocate PASIDs for
> > each mm_struct.
> > 
> > Future work would be to allow drivers using the SVA APIs to reserve
> > global PASIDs from this IDA for their internal use, eg with the DMA API
> > PASID support.  
> 
> I think DMA API PASID will need new API around this IDA. SVA APIs should
> be just for SVA.
> 
> > +void mm_pasid_drop(struct mm_struct *mm)
> >  {
> > -	return mmget_not_zero(mm);
> > -}
> > +	pr_alert("%s %d", __func__, mm->pasid);
> > +	if (likely(!pasid_valid(mm->pasid)))
> > +		return;
> > 
> > -/**
> > - * iommu_sva_find() - Find mm associated to the given PASID
> > - * @pasid: Process Address Space ID assigned to the mm
> > - *
> > - * On success a reference to the mm is taken, and must be released with
> > mmput().
> > - *
> > - * Returns the mm corresponding to this PASID, or an error if not
> > found.
> > - */
> > -struct mm_struct *iommu_sva_find(ioasid_t pasid)
> > -{
> > -	return ioasid_find(&iommu_sva_pasid, pasid, __mmget_not_zero);
> > +	ida_free(&iommu_global_pasid_ida, mm->pasid);
> >  }  
> 
> when moving this function following line is missed:
> 
> 	mm->pasid = INVALID_IOASID;
> 
not needed, mm is gone by now.

> btw the current placement looks asymmetric. We now have
> mm_pasid_init() and mm_pasid_set() in mm.h while mm_pasid_drop()
> in iommu-sva.c.
> Is it cleaner to introduce a iommu_sva_free_pasid() helper and then
> call it from mm_pasid_drop() in mm.h?
That is what we had before, it seems logical to me. Jason?

Thanks,

Jacob
