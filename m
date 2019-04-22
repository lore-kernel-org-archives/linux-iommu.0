From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 07/10] iommu/vt-d: Keep swiotlb on if bounce page is
 necessary
Date: Mon, 22 Apr 2019 18:47:20 +0200
Message-ID: <20190422164720.GB31181@lst.de>
References: <20190421011719.14909-1-baolu.lu@linux.intel.com> <20190421011719.14909-8-baolu.lu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190421011719.14909-8-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, ashok.raj@intel.com, jacob.jun.pan@intel.com, alan.cox@intel.com, kevin.tian@intel.com, mika.westerberg@linux.intel.com, pengfei.xu@intel.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Jacob Pan <jacob.jun.pan@linux.intel.com>, Mika Westerberg <mika.westerberg@intel.com>
List-Id: iommu@lists.linux-foundation.org

On Sun, Apr 21, 2019 at 09:17:16AM +0800, Lu Baolu wrote:
> +static inline bool platform_has_untrusted_device(void)
>  {
> +	bool has_untrusted_device = false;
>  	struct pci_dev *pdev = NULL;
>  
>  	for_each_pci_dev(pdev) {
>  		if (pdev->untrusted) {
> +			has_untrusted_device = true;
>  			break;
>  		}
>  	}
>  
> +	return has_untrusted_device;

This shouldn't really be in the intel-iommu driver, should it?
This probably should be something like pci_has_untrusted_devices
and be moved to the PCI code.
