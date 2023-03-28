Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4D8A44
	for <iommu@lists.linux.dev>; Tue, 28 Mar 2023 05:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679982553; x=1711518553;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3umUbM9oJ7s5zHn3EjA5OyrI/C10PnQfI+nvrcZjrQI=;
  b=OSRUc88pFtXj8xq6CFiK71h/wAyqhlgZpVTgfVRDsYKs7JSWsUMmwNPu
   H3baTWaaXmJmB6090T8vnkXG9gtIodf5PPd+3kVH6kuvLI7n92/zZBO00
   1jWr5rFMJPWpQv2oJD7cmu4NgGp52hpvnfBMIMID0OynSe1pQ9viAemBj
   cCZdracTbajRq6QbBbo/6dH1wwkr4bPECbgYIALKlH4pMn9w0spH1wcN+
   UYG+uyS9KIs8WMH/FwAdeBG24gGS0gMK7niaNjsHcXEvQJr/FD2SLXsrR
   LdI5PTFZCADlJwqR+E1QajXGEm2Tcbr0tBQzDBTxPwmvatQGIXwfdpy4s
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="324371760"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="324371760"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 22:49:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="714128861"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="714128861"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by orsmga008.jf.intel.com with ESMTP; 27 Mar 2023 22:49:05 -0700
Message-ID: <71b60cc2-4ab0-3777-6bc9-3a6a4174f743@linux.intel.com>
Date: Tue, 28 Mar 2023 13:49:24 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc: baolu.lu@linux.intel.com, Robin Murphy <robin.murphy@arm.com>,
 Will Deacon <will@kernel.org>, David Woodhouse <dwmw2@infradead.org>,
 Raj Ashok <ashok.raj@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 Yi Liu <yi.l.liu@intel.com>, "Yu, Fenghua" <fenghua.yu@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Tony Luck <tony.luck@intel.com>,
 "Zanussi, Tom" <tom.zanussi@intel.com>
Subject: Re: [PATCH v2 5/8] iommu/vt-d: Make device pasid attachment explicit
Content-Language: en-US
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
 Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
 dmaengine@vger.kernel.org, vkoul@kernel.org
References: <20230327232138.1490712-1-jacob.jun.pan@linux.intel.com>
 <20230327232138.1490712-6-jacob.jun.pan@linux.intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230327232138.1490712-6-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/28/23 7:21 AM, Jacob Pan wrote:
> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
> index 65b15be72878..b6c26f25d1ba 100644
> --- a/drivers/iommu/intel/iommu.h
> +++ b/drivers/iommu/intel/iommu.h
> @@ -595,6 +595,7 @@ struct dmar_domain {
>   
>   	spinlock_t lock;		/* Protect device tracking lists */
>   	struct list_head devices;	/* all devices' list */
> +	struct list_head dev_pasids;	/* all attached pasids */
>   
>   	struct dma_pte	*pgd;		/* virtual address */
>   	int		gaw;		/* max guest address width */
> @@ -708,6 +709,7 @@ struct device_domain_info {
>   	u8 ats_supported:1;
>   	u8 ats_enabled:1;
>   	u8 dtlb_extra_inval:1;	/* Quirk for devices need extra flush */
> +	u8 dev_attached:1;	/* Device context activated */
>   	u8 ats_qdep;
>   	struct device *dev; /* it's NULL for PCIe-to-PCI bridge */
>   	struct intel_iommu *iommu; /* IOMMU used by this device */
> @@ -715,6 +717,12 @@ struct device_domain_info {
>   	struct pasid_table *pasid_table; /* pasid table */
>   };
>   
> +struct device_pasid_info {
> +	struct list_head link_domain;	/* link to domain siblings */
> +	struct device *dev;		/* physical device derived from */
> +	ioasid_t pasid;			/* PASID on physical device */
> +};

The dev_pasids list seems to be duplicate with iommu_group::pasid_array.

The pasid_array is de facto per-device as the PCI subsystem requires ACS
to be enabled on the upstream path to the root port.

pci_enable_pasid():
385         if (!pci_acs_path_enabled(pdev, NULL, PCI_ACS_RR | PCI_ACS_UF))
386                 return -EINVAL;

For such PCI topology, pci_device_group() always assigns an exclusive
iommu group (a.k.a. singleton group).

So, how about moving the pasid_array from struct iommu_group to struct
dev_iommu? With this refactoring, the individual iommu driver has no
need to create their own pasid array or list.

Instead of using iommu_group::mutex, perhaps the pasid_array needs its
own lock in struct dev_iommu after moving.

Best regards,
baolu
