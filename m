From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 08/10] iommu/vt-d: Check whether device requires
 bounce buffer
Date: Mon, 22 Apr 2019 18:47:55 +0200
Message-ID: <20190422164755.GC31181@lst.de>
References: <20190421011719.14909-1-baolu.lu@linux.intel.com> <20190421011719.14909-9-baolu.lu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190421011719.14909-9-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, ashok.raj@intel.com, jacob.jun.pan@intel.com, alan.cox@intel.com, kevin.tian@intel.com, mika.westerberg@linux.intel.com, pengfei.xu@intel.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

On Sun, Apr 21, 2019 at 09:17:17AM +0800, Lu Baolu wrote:
> +static inline bool device_needs_bounce(struct device *dev)
> +{
> +	struct pci_dev *pdev = NULL;
> +
> +	if (intel_no_bounce)
> +		return false;
> +
> +	if (dev_is_pci(dev))
> +		pdev = to_pci_dev(dev);
> +
> +	return pdev ? pdev->untrusted : false;
> +}

Again, this and the option should not be in a specific iommu driver.
