From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v7 0/9] vfio/mdev: IOMMU aware mediated device
Date: Tue, 26 Feb 2019 11:37:08 +0100
Message-ID: <20190226103707.GG20740@8bytes.org>
References: <20190222021927.13132-1-baolu.lu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190222021927.13132-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Alex Williamson <alex.williamson@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>, ashok.raj@intel.com, sanjay.k.kumar@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, yi.l.liu@intel.com, yi.y.sun@intel.com, peterx@redhat.com, tiwei.bie@intel.com, xin.zeng@intel.com, iommu@lists.linux-foundation.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org



On Fri, Feb 22, 2019 at 10:19:18AM +0800, Lu Baolu wrote:
> Lu Baolu (9):
>   iommu: Add APIs for multiple domains per device
>   iommu/vt-d: Move enable pasid out of CONFIG_INTEL_IOMMU_SVM
>   iommu/vt-d: Add per-device IOMMU feature ops entries
>   iommu/vt-d: Move common code out of iommu_attch_device()
>   iommu/vt-d: Aux-domain specific domain attach/detach
>   iommu/vt-d: Return ID associated with an auxiliary domain
>   vfio/mdev: Add iommu related member in mdev_device
>   vfio/type1: Add domain at(de)taching group helpers
>   vfio/type1: Handle different mdev isolation type

This looks mostly good to me from an IOMMU point of view. I have some
ideas for improving it further, but that can be left for later work. For
example, I wonder if it makes sense to track the enabled/disabled state
for features in core iommu code to safe the call-backs into the
iommu-drivers for the is_enabled checks.

When Alex Acks the vfio changes I am inclined to merge this for v5.1.

Regards,

	Joerg
