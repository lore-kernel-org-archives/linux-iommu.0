Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008962F2A
	for <iommu@lists.linux.dev>; Tue, 28 Mar 2023 20:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680036478; x=1711572478;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IrBf2jxsIsqUqVNuSjNZZnkzHVlM3YG0iaidUQD274k=;
  b=RPeevk5KtmUBNtPg5lZMLqI/rbeEXHsYn+nn/g1hBdIkRlOu9EArdV6o
   XRecXq4xVdzCGRsGpNU1EcGONRKgkdxMRZ9t2fe9C6NcHKXHb7ZH1cMfb
   k1WMFGfq/hy/CdnmuuVM557UFPKaEGCMdUMczm1INQTzATwQyULYNJiy1
   6foM8OgLGy3rdxJoMLeFbMbHOvNsoPf3zoXKaKBuGjHtpLY3i66LgFYXj
   iPvWz7txy3YmzbjxLXsqiMRLSLYUz0Ow2BV8a/VUPEBDIwqVcxIxQI4Ii
   2iIC8E7Y8Hvlrh7NlT4DbYy3PNdRlcNjoVRLs2zKr/IZaLC3TQo1hAl9E
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="329147439"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="329147439"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 13:47:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="1013712586"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="1013712586"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 13:47:57 -0700
Date: Tue, 28 Mar 2023 13:52:00 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev, Jason
 Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
 dmaengine@vger.kernel.org, vkoul@kernel.org, Robin Murphy
 <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, David Woodhouse
 <dwmw2@infradead.org>, Raj Ashok <ashok.raj@intel.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>, "Yu, Fenghua"
 <fenghua.yu@intel.com>, Dave Jiang <dave.jiang@intel.com>, Tony Luck
 <tony.luck@intel.com>, "Zanussi, Tom" <tom.zanussi@intel.com>,
 jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v2 4/8] iommu/vt-d: Reserve RID_PASID from global SVA
 PASID space
Message-ID: <20230328135200.139f280a@jacob-builder>
In-Reply-To: <20230328092919.372f0545@jacob-builder>
References: <20230327232138.1490712-1-jacob.jun.pan@linux.intel.com>
	<20230327232138.1490712-5-jacob.jun.pan@linux.intel.com>
	<41d31adf-577e-431c-c400-2708885400c1@linux.intel.com>
	<20230328092919.372f0545@jacob-builder>
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

Hi Baolu,

On Tue, 28 Mar 2023 09:29:19 -0700, Jacob Pan
<jacob.jun.pan@linux.intel.com> wrote:

> > > On VT-d platforms, RID_PASID is used for DMA request without PASID. We
> > > should not treat RID_PASID special instead let it be allocated from
> > > the global SVA PASID number space.    
> > 
> > It's same to AMD and ARM SMMUv3, right? They also need an explicit
> > reservation of PASID 0.
> >   
> yes, all IOMMU drivers need to do that. I will give it a try but might
> need help to place the call.
It might be simpler to just let SVA code allocate from 1 up instead of 0
(as is in the current code). Global PASID allocator would still allow the
full range from 0 to max. Then there is no change to architectures that
don't support non-zero RID_PASID. For VT-d, it would still work in the
future when we have nonzero RID_PASID. is that reasonable?

Thanks,

Jacob
