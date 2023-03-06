Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20718566C
	for <iommu@lists.linux.dev>; Mon,  6 Mar 2023 17:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678124418; x=1709660418;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jYQf0+QQ92IJa7rmg3xs0GynrfCE+yIEFalz9+F5Bow=;
  b=BFfAslfYqSFY+UK0JtyTL+LZcLcw2zTOO3NS8XqjfyOrtWdrOy1UeSiA
   sdNftk0YAWLaf5YdumJG0U5Yjzj5RlFynVYyGaXt5L3TDRTaukBeyRKNr
   Kh0y25dP2pSTz3Yb5mcZG1nxfWL+OzY10AxEu4rzdpN3Za4fFkxwBo8lP
   r64C44ra59olyJzO7WHrmgn2lpruKjhTFG7Ohc6E5Vfl+UlfgwdMoDpWW
   QhMniEM2QBV3vSgorgr4p6TCYMZWaD4hwZ/jy2P7NOaIoS3wjTAQfF5kF
   j2hcAReNWdHverQ3bHpV/XAHrruuSBfwvS5QMm29xLCB7obZORJ+bcTCe
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="363242789"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="363242789"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 09:40:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="745156852"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="745156852"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 09:40:17 -0800
Date: Mon, 6 Mar 2023 09:44:08 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, LKML
 <linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel
 <joro@8bytes.org>, "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
 "vkoul@kernel.org" <vkoul@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Will Deacon <will@kernel.org>, David Woodhouse <dwmw2@infradead.org>, "Raj,
 Ashok" <ashok.raj@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Yu,
 Fenghua" <fenghua.yu@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>,
 "Luck, Tony" <tony.luck@intel.com>, "Zanussi, Tom" <tom.zanussi@intel.com>,
 jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH 3/4] iommu/sva: Support reservation of global PASIDs
Message-ID: <20230306094408.2d675d5b@jacob-builder>
In-Reply-To: <ZAXkLN39VUSl+t65@nvidia.com>
References: <20230302005959.2695267-1-jacob.jun.pan@linux.intel.com>
	<20230302005959.2695267-4-jacob.jun.pan@linux.intel.com>
	<BN9PR11MB52765C5E0DC0759880C08E258CB29@BN9PR11MB5276.namprd11.prod.outlook.com>
	<20230303134753.660d0755@jacob-builder>
	<ZAXkLN39VUSl+t65@nvidia.com>
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

Hi Jason,

On Mon, 6 Mar 2023 09:01:32 -0400, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Fri, Mar 03, 2023 at 01:47:53PM -0800, Jacob Pan wrote:
> > Hi Kevin,
> > 
> > On Thu, 2 Mar 2023 09:43:03 +0000, "Tian, Kevin" <kevin.tian@intel.com>
> > wrote:
> >   
> > > > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > > Sent: Thursday, March 2, 2023 9:00 AM
> > > > 
> > > > Global PASID allocation is under IOMMU SVA code since it is the
> > > > primary use case.  However, some architecture such as VT-d, global
> > > > PASIDs are necessary for its internal use of DMA API with PASID.    
> > > 
> > > No, global PASID is not a VT-d restriction. It's from ENQCMD/S hence a
> > > device requirement.  
> > I meant VT-d based platforms, it is kind of intertwined in that ENQCMDS
> > does not restrict RIDPASID!=DMA PASID, vt-d does. Without this
> > restriction, there wouldn't be a need for this patch. Let me reword.  
> 
> No, Kevin is right, there is nothing about VT-d that needs global
> PASID values.
> 
> The driver should be managing RID2PASID itself to avoid conflicting
> with any in-use PASID, either by changing RID2PASID on demand or by
> setting it to a value that is not part of the PASID number space, eg
> we can make 0 entirely invalid, or the driver can reduce max_pasid of
> the devices it controls and use PASID_MAX.
> 
I see, thank you both. how about
"This patch provide an API for device drivers to request global PASIDs as
needed. The device drivers will then gain the flexibility of choosing
PASIDs not conflicting with anyone in-use."


Thanks,

Jacob
