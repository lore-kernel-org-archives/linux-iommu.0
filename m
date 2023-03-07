Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E077FBA3E
	for <iommu@lists.linux.dev>; Tue,  7 Mar 2023 17:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678210692; x=1709746692;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AOProkfN/IGTr09CgulYGyixQP6qyB6RLNl6DtWsadA=;
  b=MgQ9eQlza0ndLXd9fZ8hTztuTYWbszwG1NkBPINEwUK4s3Vszu1cQ6GV
   eLoDTj55EqGRrVXuddjDwNMFoySkz8cyifrZ+T6WbmuCYqtntEkCkX/8r
   YxO75jgiMN6L8COrFRXh1I2UpjzNnwONTotWvAwCUWdu9mR0umCWGzKKR
   Wl/BleqBEnH6ZpPl/dH5iyA5ZZb4Bs0hi2/uHthUaIFNXAUVOuXZoQY0a
   YuPvcfVSzGCzSScsV5RnLBhkJUQNsJl23jeshskovUSu+xko2d9AuxCZB
   BcZUUikpX5LEYkXH0TtZUFha8IzgtQL7AF7FcwvENyR7WPYTfPP7fuU9w
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="398497864"
X-IronPort-AV: E=Sophos;i="5.98,241,1673942400"; 
   d="scan'208";a="398497864"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 09:38:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="786772295"
X-IronPort-AV: E=Sophos;i="5.98,241,1673942400"; 
   d="scan'208";a="786772295"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 09:38:11 -0800
Date: Tue, 7 Mar 2023 09:42:03 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, Jean-Philippe Brucker
 <jean-philippe@linaro.org>, LKML <linux-kernel@vger.kernel.org>,
 iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, Jean-Philippe
 Brucker <jean-philippe@linaro.com>, Dave Hansen <dave.hansen@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, X86 Kernel <x86@kernel.org>,
 bp@alien8.de, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra
 <peterz@infradead.org>, corbet@lwn.net, vkoul@kernel.org,
 dmaengine@vger.kernel.org, linux-doc@vger.kernel.org, Robin Murphy
 <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, David Woodhouse
 <dwmw2@infradead.org>, Raj Ashok <ashok.raj@intel.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>, "Yu, Fenghua"
 <fenghua.yu@intel.com>, Dave Jiang <dave.jiang@intel.com>, Kirill Shutemov
 <kirill.shutemov@linux.intel.com>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v4 3/6] iommu/sva: Stop using ioasid_set for SVA
Message-ID: <20230307094203.4dc51ff4@jacob-builder>
In-Reply-To: <ZAHzAa0mnilf0N9K@nvidia.com>
References: <20230301235646.2692846-1-jacob.jun.pan@linux.intel.com>
	<20230301235646.2692846-4-jacob.jun.pan@linux.intel.com>
	<3b7fb4d3-1fe9-a3be-46ad-c271be9f96c7@linux.intel.com>
	<20230302091707.58d59964@jacob-builder>
	<794c7dad-2e62-3afa-ea10-92179b0d1659@linux.intel.com>
	<20230303093235.GB361458@myrica>
	<3b2c6fe9-821f-9b84-acb6-777e8517a0fc@linux.intel.com>
	<ZAHzAa0mnilf0N9K@nvidia.com>
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

On Fri, 3 Mar 2023 09:15:45 -0400, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Fri, Mar 03, 2023 at 05:57:41PM +0800, Baolu Lu wrote:
> > On 2023/3/3 17:32, Jean-Philippe Brucker wrote:  
> > > > I suppose the common thing is reserving some kind of special
> > > > PASIDs.  
> > > Are you planning to use RID_PASID != 0 in VT-d?  Otherwise we could
> > > just communicate min_pasid from the IOMMU driver the same way we do
> > > max_pasid.
> > > 
> > > Otherwise I guess re-introduce a lighter ioasid_alloc() that the IOMMU
> > > driver calls to reserve PASID0/RID_PASID.  
> > 
> > Yes. We probably will use a non-zero RID_PASID in the future. An
> > interface to reserve (or allocate) a PASID from iommu_global_pasid_ida
> > should work then.  
> 
> Just allowing the driver to store XA_ZERO_ENTRY would be fine
> 
So we provide APIs for both?
1. alloc a global PASID, returned by this API
2. try to reserve a global PASID given by the driver, i.e.
	xa_cmpxchg(&iommu_global_pasid_ida.xa, 2, NULL, XA_ZERO_ENTRY,
			 GFP_KERNEL);
seems #1 is sufficient.

Thanks,

Jacob
