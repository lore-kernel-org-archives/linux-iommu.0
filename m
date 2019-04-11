From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v8 0/9] vfio/mdev: IOMMU aware mediated device
Date: Thu, 11 Apr 2019 17:19:17 +0200
Message-ID: <20190411151917.GA29810@8bytes.org>
References: <20190325013036.18400-1-baolu.lu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190325013036.18400-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Alex Williamson <alex.williamson@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>, ashok.raj@intel.com, sanjay.k.kumar@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, yi.l.liu@intel.com, yi.y.sun@intel.com, peterx@redhat.com, tiwei.bie@intel.com, xin.zeng@intel.com, iommu@lists.linux-foundation.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi Lu Baolu,

thanks for these patches!

On Mon, Mar 25, 2019 at 09:30:27AM +0800, Lu Baolu wrote:
> Lu Baolu (9):
>   iommu: Add APIs for multiple domains per device
>   iommu/vt-d: Make intel_iommu_enable_pasid() more generic
>   iommu/vt-d: Add per-device IOMMU feature ops entries
>   iommu/vt-d: Move common code out of iommu_attch_device()
>   iommu/vt-d: Aux-domain specific domain attach/detach
>   iommu/vt-d: Return ID associated with an auxiliary domain

I applied the patches above to my tree. The first patch is in a new
branch called 'api-features' and the other are in the x86/vt-d branch.

>   vfio/mdev: Add iommu related member in mdev_device
>   vfio/type1: Add domain at(de)taching group helpers
>   vfio/type1: Handle different mdev isolation type

Can you please address the minor concern on these patches, add all
review and acks and re-send?

Thanks,

	Joerg
