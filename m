Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D21A3205
	for <iommu@lists.linux.dev>; Mon,  3 Apr 2023 20:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680554452; x=1712090452;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5V7tfHtJX0OGp/o2K2RrvADYKgIPEcvGJ9Py6xIMOM8=;
  b=GPqIq4BeEcmWbyNKJ6ZeFTyh5xG9ddxV4I1Pe64ap9/JpC9MTXX2Azs0
   ajUsLWL+uYiOssj4JCWW0NW6juXi3FccGT5JMW6U1JdUCsOvtE9A806Lq
   X4PHOx/nTGw5EAnzickX0OTcUMC7uez2G13D7l83KTvM8hAUJBe4jZNbP
   tLSxcK79GNdhD2cCIDqbInfs1Sqe/z1++S9ApmYc2W0ZGsvXqqCzsqcBh
   YZ7XulnhzXUbKlzW9N6qPqKHlul8MFZqTqs3/aAOjXbCzN+etcE6cRlo8
   nOcw2tug6O5LjTVEuuBiFBum4pvOD+jOoH35DaHWTaX7U6vgsoqW7aARt
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="428298975"
X-IronPort-AV: E=Sophos;i="5.98,315,1673942400"; 
   d="scan'208";a="428298975"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 13:40:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="716422725"
X-IronPort-AV: E=Sophos;i="5.98,315,1673942400"; 
   d="scan'208";a="716422725"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 13:40:51 -0700
Date: Mon, 3 Apr 2023 13:44:57 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev, Robin Murphy
 <robin.murphy@arm.com>, Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel
 <joro@8bytes.org>, dmaengine@vger.kernel.org, vkoul@kernel.org, Will Deacon
 <will@kernel.org>, David Woodhouse <dwmw2@infradead.org>, Raj Ashok
 <ashok.raj@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu
 <yi.l.liu@intel.com>, "Yu, Fenghua" <fenghua.yu@intel.com>, Dave Jiang
 <dave.jiang@intel.com>, Tony Luck <tony.luck@intel.com>, "Zanussi, Tom"
 <tom.zanussi@intel.com>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v3 3/7] iommu/sva: Support allocation of global PASIDs
 outside SVA
Message-ID: <20230403134457.25f56d11@jacob-builder>
In-Reply-To: <d20a04fc-e0a8-32ee-0d4a-083338d4179b@linux.intel.com>
References: <20230331231137.1947675-1-jacob.jun.pan@linux.intel.com>
	<20230331231137.1947675-4-jacob.jun.pan@linux.intel.com>
	<d20a04fc-e0a8-32ee-0d4a-083338d4179b@linux.intel.com>
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

On Sat, 1 Apr 2023 21:16:39 +0800, Baolu Lu <baolu.lu@linux.intel.com>
wrote:

> > +/**
> > + * @brief
> > + *	Reserve a PASID from the SVA global number space.
> > + *
> > + * @param min starting range, inclusive
> > + * @param max ending range, inclusive
> > + * @return The reserved PASID on success or IOMMU_PASID_INVALID on
> > failure.
> > + */  
> 
> Nit: the comments here also need to be changed accordingly.
good catch! will fix.

Thanks,

Jacob
