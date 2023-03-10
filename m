Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85942C957
	for <iommu@lists.linux.dev>; Fri, 10 Mar 2023 21:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678483963; x=1710019963;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ehc2G1Khk+7j9DBXV2qWdm7ZCJBZCQ3dNkGTzQyl2kg=;
  b=LG+DezhbxAV+NSx/OWhkF+q7LOXwxCLlNRb830s9+uvT9N+lhulmRg97
   Zc/ebI/9ghHCwhZDT7HoERIwNM97UjjDT3elF5u3OLYEyq2V7SH7YamXF
   tvEurEF+5c9s11r3Y145V5TkiwC3gP7Nvf06wm249DgTQPtVp0SRl1R+B
   0A/918jgi4ptSqC506cJb+BV5i68YpRAVEaVGtgU6Fxkx3vn9eS6jNwIR
   yprlad/2M/yq1XYkJnTA2zczuL7qcrNFPdXHWSUWJjezIyzDAdDf33j9A
   2LfQjsdBt/xeOovMSmzyReOGDXkQ0lN2A6L/xeS7jpZyEDBvS2fnM4tI/
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="335530951"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="335530951"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 13:32:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="766977604"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="766977604"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 13:32:35 -0800
Date: Fri, 10 Mar 2023 13:36:28 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev, Jason
 Gunthorpe <jgg@nvidia.com>, Lu Baolu <baolu.lu@linux.intel.com>, Joerg
 Roedel <joro@8bytes.org>, Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Dave Hansen <dave.hansen@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 X86 Kernel <x86@kernel.org>, bp@alien8.de, "H. Peter Anvin"
 <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, corbet@lwn.net,
 vkoul@kernel.org, dmaengine@vger.kernel.org, linux-doc@vger.kernel.org,
 Will Deacon <will@kernel.org>, David Woodhouse <dwmw2@infradead.org>, Raj
 Ashok <ashok.raj@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu
 <yi.l.liu@intel.com>, "Yu, Fenghua" <fenghua.yu@intel.com>, Dave Jiang
 <dave.jiang@intel.com>, Kirill Shutemov <kirill.shutemov@linux.intel.com>,
 Tony Luck <tony.luck@intel.com>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v5 2/7] iommu/sva: Move PASID helpers to sva code
Message-ID: <20230310133628.290c0efa@jacob-builder>
In-Reply-To: <30923327-6c08-f0c1-1b52-c1d818f3a3a2@arm.com>
References: <20230309222159.487826-1-jacob.jun.pan@linux.intel.com>
	<20230309222159.487826-4-jacob.jun.pan@linux.intel.com>
	<30923327-6c08-f0c1-1b52-c1d818f3a3a2@arm.com>
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

On Fri, 10 Mar 2023 20:00:52 +0000, Robin Murphy <robin.murphy@arm.com>
wrote:

> On 2023-03-09 22:21, Jacob Pan wrote:
> > Preparing to remove IOASID infrastructure, PASID management will be
> > under SVA code. Decouple mm code from IOASID. Use iommu-help.h instead
> > of iommu.h to prevent circular inclusion.
> > 
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> > v5:
> > 	- move definition of helpers to iommu code to be consistent with
> > 	  declarations. (Kevin)
> > 	- fix patch partitioning bug (Baolu)
> > v4:
> > 	- delete and open code mm_set_pasid
> > 	- keep mm_init_pasid() as inline for fork performance
> > ---
> >   drivers/iommu/iommu-sva.c    | 10 +++++++++-
> >   include/linux/ioasid.h       |  2 +-
> >   include/linux/iommu-helper.h | 12 ++++++++++++  
> 
> Eww, can we not? iommu-helper is very much just parts of a specific type 
> of bitmap-based IOVA allocator used by some crusty old arch-specific 
> IOMMU code and SWIOTLB. It is unrelated to the iommu.h IOMMU API, and 
> dragging that stuff into modern SVA-related matters seems bizarrely 
> inappropriate. Could we just move the mm_pasid stuff into ioasid.h here, 
> then maybe rename it to iommu-sva.h at the end if eradicating the old 
> name really matters?
thanks for explaining the history behind iommu-helper.h, having a new
include/linux/iommu-sva.h would probably be cleaner.

my original intent for using iommu-helper.h was to avoid problems by mm.h
#include iommu.h. So I just needed a separate small header. let me do
without iommu-helper.h.

Thanks,

Jacob
