Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B163CBA2F
	for <iommu@lists.linux.dev>; Thu,  1 Jun 2023 15:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685634834; x=1717170834;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qxiOOdrYX4boDBzh8iGft9ewMpmmOEyU+ptNYZaGWPM=;
  b=XRba0qWQ7qrIXmqIUTMQemSeJNpPHF74aQZ5+mwyUKoRJ8Y7sZHCcqds
   MU7ttBNXwf8rgwsLYbTAEeKP0uZXhsCgc8UxL/G/VNfD+ylLi9thkNPaO
   T4gDDfIWNsGhtutF3ccvmDQmQE1A9cx9WOG8GH2tdTAxmkgtmXlc9GHTU
   Ha53wuZUP4r4GWcPf56fFeGzRajXYpxzVPQYKeRZEyK203kwjm6V3WwZ1
   OPbP8mHIZz89XCksgmDwi0te0Q/xwt+NEXbKMSXN984x7+wvbTf2TySvc
   fA7VtDDSIMuJhZqpD2S0u5TNQgOozE1xeIo7Ep6nE5+09X7dl0Q0xfX1X
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="335217771"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="335217771"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 08:53:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="881670636"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="881670636"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 08:53:53 -0700
Date: Thu, 1 Jun 2023 08:58:29 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev, Lu Baolu
 <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Robin Murphy
 <robin.murphy@arm.com>, Jean-Philippe Brucker <jean-philippe@linaro.com>,
 dmaengine@vger.kernel.org, vkoul@kernel.org, Will Deacon <will@kernel.org>,
 David Woodhouse <dwmw2@infradead.org>, Raj Ashok <ashok.raj@intel.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>, "Yu,
 Fenghua" <fenghua.yu@intel.com>, Dave Jiang <dave.jiang@intel.com>, Tony
 Luck <tony.luck@intel.com>, "Zanussi, Tom" <tom.zanussi@intel.com>,
 narayan.ranganathan@intel.com, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v7 0/4] Re-enable IDXD kernel workqueue under DMA API
Message-ID: <20230601085829.026a8c17@jacob-builder>
In-Reply-To: <ZHipgzmZ9q3Ihvk5@nvidia.com>
References: <20230523173451.2932113-1-jacob.jun.pan@linux.intel.com>
	<20230531213342.1a3f1508@jacob-builder>
	<ZHipgzmZ9q3Ihvk5@nvidia.com>
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

On Thu, 1 Jun 2023 11:21:55 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Wed, May 31, 2023 at 09:33:42PM -0700, Jacob Pan wrote:
> > Hi Jason,
> > 
> > Do you have any comments on this set? this is a follow-up of the IOASID
> > removal series.  
> 
> It looks OK in general, I see it still needs another spin before the
> driver part is OK?
Yes, I will get that from Baolu and test.

Thanks,

Jacob
