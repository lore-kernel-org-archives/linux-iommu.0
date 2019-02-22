From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v7 7/9] vfio/mdev: Add iommu related member in mdev_device
Date: Fri, 22 Feb 2019 06:34:38 -0800
Message-ID: <20190222143438.GA31016@infradead.org>
References: <20190222021927.13132-1-baolu.lu@linux.intel.com>
 <20190222021927.13132-8-baolu.lu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190222021927.13132-8-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Alex Williamson <alex.williamson@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>, kevin.tian@intel.com, ashok.raj@intel.com, tiwei.bie@intel.com, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, sanjay.k.kumar@intel.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, yi.y.sun@intel.com, jacob.jun.pan@intel.com, kvm@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Feb 22, 2019 at 10:19:25AM +0800, Lu Baolu wrote:
> A parent device might create different types of mediated
> devices. For example, a mediated device could be created
> by the parent device with full isolation and protection
> provided by the IOMMU. One usage case could be found on
> Intel platforms where a mediated device is an assignable
> subset of a PCI, the DMA requests on behalf of it are all
> tagged with a PASID. Since IOMMU supports PASID-granular
> translations (scalable mode in VT-d 3.0), this mediated
> device could be individually protected and isolated by an
> IOMMU.
> 
> This patch adds a new member in the struct mdev_device to
> indicate that the mediated device represented by mdev could
> be isolated and protected by attaching a domain to a device
> represented by mdev->iommu_device. It also adds a helper to
> add or set the iommu device.
> 
> * mdev_device->iommu_device
>   - This, if set, indicates that the mediated device could
>     be fully isolated and protected by IOMMU via attaching
>     an iommu domain to this device. If empty, it indicates
>     using vendor defined isolation, hence bypass IOMMU.
> 
> * mdev_set/get_iommu_device(dev, iommu_device)
>   - Set or get the iommu device which represents this mdev
>     in IOMMU's device scope. Drivers don't need to set the
>     iommu device if it uses vendor defined isolation.
> 
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Liu Yi L <yi.l.liu@intel.com>
> Suggested-by: Kevin Tian <kevin.tian@intel.com>
> Suggested-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> ---
>  drivers/vfio/mdev/mdev_core.c    | 18 ++++++++++++++++++
>  drivers/vfio/mdev/mdev_private.h |  1 +
>  include/linux/mdev.h             | 14 ++++++++++++++
>  3 files changed, 33 insertions(+)
> 
> diff --git a/drivers/vfio/mdev/mdev_core.c b/drivers/vfio/mdev/mdev_core.c
> index 0212f0ee8aea..9be58d392d2b 100644
> --- a/drivers/vfio/mdev/mdev_core.c
> +++ b/drivers/vfio/mdev/mdev_core.c
> @@ -390,6 +390,24 @@ int mdev_device_remove(struct device *dev, bool force_remove)
>  	return 0;
>  }
>  
> +int mdev_set_iommu_device(struct device *dev, struct device *iommu_device)
> +{
> +	struct mdev_device *mdev = to_mdev_device(dev);
> +
> +	mdev->iommu_device = iommu_device;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(mdev_set_iommu_device);

As said before, please make all new mdev/vfio exports EXPORT_SYMBOL_GPL
to fit the other exports in vfio.
