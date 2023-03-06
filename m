Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69082CA7
	for <iommu@lists.linux.dev>; Mon,  6 Mar 2023 19:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678129252; x=1709665252;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yrqs2zzNZs4rk995C3e1KJ/BxQPhG0SO/C+asiFrH3k=;
  b=bNrv7IQJdA0fAv/Bqfid6qYrT7Ynvuw6d7RrWu1rTjOfSo0LAakkdKP2
   G0QwG287uQtvOSs2Cv2HfFBjdBGLIYskZIBuDBixYZrG8kkO1ZGPWldNR
   ku/Y+/hS6m2198W7GRfzOY/XP0P07+gB+ro1aQetOotvyjtHOQbPo6Isr
   kysYMu8hzVT6d1nokGxog+hp/i2a+5v2XKsIrL2SkSdX49NzIcm2CCBbW
   tv1BdxoQugrDsVsoKzvntIcqhkDE6MiNiREFsGKqiPlCBmAENHBL8sd97
   1rXYSaKTqTeZi1a+JwiVTHxJsGaIQnz4cgTr1YUt+h7S7xyBmj52ZFuo3
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="337969364"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="337969364"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 11:00:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="708763645"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="708763645"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 11:00:52 -0800
Date: Mon, 6 Mar 2023 11:04:43 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, LKML
 <linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel
 <joro@8bytes.org>, "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
 "vkoul@kernel.org" <vkoul@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Will Deacon <will@kernel.org>, "David Woodhouse" <dwmw2@infradead.org>,
 "Raj, Ashok" <ashok.raj@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Yu,
 Fenghua" <fenghua.yu@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>,
 "Luck, Tony" <tony.luck@intel.com>, "Zanussi, Tom" <tom.zanussi@intel.com>,
 jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH 1/4] iommu/vt-d: Implement set device pasid op for
 default domain
Message-ID: <20230306110443.4ca52204@jacob-builder>
In-Reply-To: <BN9PR11MB5276E48AA1680C76A3ED66AD8CB39@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230302005959.2695267-1-jacob.jun.pan@linux.intel.com>
	<20230302005959.2695267-2-jacob.jun.pan@linux.intel.com>
	<fad7f28f-b4e8-c1c3-4ca4-a48c5c6d7f4a@linux.intel.com>
	<BN9PR11MB52762957011E60E935E82CC88CB39@BN9PR11MB5276.namprd11.prod.outlook.com>
	<2c9115d0-f251-c284-63d6-73714edc96b4@linux.intel.com>
	<BN9PR11MB527634EA1ED5067D1FC0D7C68CB39@BN9PR11MB5276.namprd11.prod.outlook.com>
	<7f8983c8-b703-4960-67b5-97f4053329db@linux.intel.com>
	<BN9PR11MB5276E48AA1680C76A3ED66AD8CB39@BN9PR11MB5276.namprd11.prod.outlook.com>
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

On Fri, 3 Mar 2023 05:35:58 +0000, "Tian, Kevin" <kevin.tian@intel.com>
wrote:

> > From: Baolu Lu <baolu.lu@linux.intel.com>
> > Sent: Friday, March 3, 2023 12:38 PM
> > 
> > On 3/3/23 11:02 AM, Tian, Kevin wrote:  
> > >> From: Baolu Lu <baolu.lu@linux.intel.com>
> > >> Sent: Friday, March 3, 2023 10:49 AM
> > >>
> > >> On 3/3/23 10:36 AM, Tian, Kevin wrote:  
> > >>>> From: Baolu Lu <baolu.lu@linux.intel.com>
> > >>>> Sent: Thursday, March 2, 2023 10:07 PM  
> > >>>>> +
> > >>>>> +	if (!sm_supported(iommu) || !info)  
> > >>>>
> > >>>> @info has been referenced. !info check makes no sense.
> > >>>>
> > >>>> Add pasid_supported(iommu).
> > >>>>
> > >>>> Do you need to check whether the domain is compatible for this rid
> > >>>> pasid?  
> > >>>
> > >>> what kind of compatibility is concerned here? In concept a pasid
> > >>> can be attached to any domain if it has been successfully attached
> > >>> to rid. Probably we can add a check here that RID2PASID must
> > >>> point to the domain already.  
> > >>
> > >> "...if it has been successfully attached to rid..."
> > >>
> > >> We should not have this assumption in iommu driver's callback. The  
> > iommu  
> > >> driver has no (and should not have) knowledge about the history of
> > >> any domain.  
> > >
> > > but this is an op for default domain which must have been attached
> > > to RID2PASID and any compatibility check between this domain and
> > > device should be passed.  
> > 
> > This is an op for DMA, DMA-FQ and UNMANAGED domain. The IOMMU
> > driver
> > doesn't need to interpret the default domain concept. :-)
> >   
> 
> yes if we target a general callback for all those domain types.
> 
> and probably this is the right thing to do as in the end DMA type will
> be removed with Jason's cleanup
so, let me recap. set_dev_pasid() should make no assumptions of
ordering, i.e. it is equal to iommu_domain_ops.attach_dev().
It will be kind of the same as Baolu's old patch
https://lore.kernel.org/linux-iommu/20220614034411.1634238-1-baolu.lu@linux.intel.com/


Thanks,

Jacob
