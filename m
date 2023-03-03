Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D391A938
	for <iommu@lists.linux.dev>; Fri,  3 Mar 2023 21:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677880101; x=1709416101;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qxJfn1HMo5o/TEK84TFNUVCEuwu46pEXGqZ2QTppX2c=;
  b=my4BYJfOoxl+c4npr821y4SyeWnRRBSHCjwyDsW+IUsBRhsn7dGjiIFD
   Dd1IfK6x5uDeWYsrOV+9eA5spVcXcROc/UULVCuDQi5rhkQ3Qv6mYJH1t
   1HcqfFS80GPdh5k9J1uy0VGgX7MVtjBAWGM95cIZs7PcFddkopFNKFFBi
   GvF5xf8GS5K4pFylK9kjZgntLLWqmIKrJ3YJNlowUhDOUbOzNfJy8WZrt
   s2S+ji4mzUmCvxHkd4OC0Ts3YiQ/ylphm4Bv9lA2deN7qD5dRGkybk14q
   FlL98e6vKuwQ5lSJbzRg0iAl+tMDHMAv9S3BSt/i7Mdi2NfJLSpxtYaGy
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="318989797"
X-IronPort-AV: E=Sophos;i="5.98,231,1673942400"; 
   d="scan'208";a="318989797"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 13:48:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="921252005"
X-IronPort-AV: E=Sophos;i="5.98,231,1673942400"; 
   d="scan'208";a="921252005"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 13:48:20 -0800
Date: Fri, 3 Mar 2023 13:52:09 -0800
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
Subject: Re: [PATCH 4/4] dmaengine/idxd: Re-enable kernel workqueue under
 DMA API
Message-ID: <20230303135209.16caf5ad@jacob-builder>
In-Reply-To: <063ed735-b8d1-1b44-67d7-78c3adb34074@linux.intel.com>
References: <20230302005959.2695267-1-jacob.jun.pan@linux.intel.com>
	<20230302005959.2695267-5-jacob.jun.pan@linux.intel.com>
	<063ed735-b8d1-1b44-67d7-78c3adb34074@linux.intel.com>
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

On Fri, 3 Mar 2023 09:19:48 +0800, Baolu Lu <baolu.lu@linux.intel.com>
wrote:

> On 3/2/23 8:59 AM, Jacob Pan wrote:
> > diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> > index f30eef701970..dadc908318aa 100644
> > --- a/drivers/dma/idxd/init.c
> > +++ b/drivers/dma/idxd/init.c
> > @@ -501,14 +501,52 @@ static struct idxd_device *idxd_alloc(struct
> > pci_dev *pdev, struct idxd_driver_d 
> >   static int idxd_enable_system_pasid(struct idxd_device *idxd)
> >   {
> > -	return -EOPNOTSUPP;
> > +	struct pci_dev *pdev = idxd->pdev;
> > +	struct device *dev = &pdev->dev;
> > +	struct iommu_domain *domain;
> > +	union gencfg_reg gencfg;
> > +	ioasid_t pasid;
> > +	int ret;
> > +
> > +	domain = iommu_get_domain_for_dev(dev);
> > +	if (!domain || domain->type == IOMMU_DOMAIN_BLOCKED)
> > +		return -EPERM;  
> 
> The idxd driver has claimed the DMA ownership of this device. Unless the
> idxd driver itself attached another domain, iommu_get_domain_for_dev()
> should never return a blocking domain.
> 
> "domain == NULL" happens when CONFIG_IOMMU_API is not set.
> 
> Furthermore, iommu_get_domain_for_dev() doesn't hold any refcount from
> the domain, so in theory it's not safe here because it possibly causes
> use-after-release case.
> 
> I would say iommu_get_dma_domain() or something similar is more suitable
> for use here. It directly returns the device's default domain and the
> iommu core guarantees that default domain will always valid during the
> life cycle of any device driver.
> 
will do, same as Jason's comments.

Thanks,

Jacob
