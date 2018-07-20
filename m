From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v5 0/9] iommu/vt-d: Improve PASID id and table management
Date: Fri, 20 Jul 2018 14:45:01 +0200
Message-ID: <20180720124500.rvtprtyemfmddbbt@8bytes.org>
References: <1531554422-6874-1-git-send-email-baolu.lu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1531554422-6874-1-git-send-email-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>, ashok.raj@intel.com, sanjay.k.kumar@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com, yi.l.liu@intel.com, yi.y.sun@intel.com, peterx@redhat.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Sat, Jul 14, 2018 at 03:46:53PM +0800, Lu Baolu wrote:
> Lu Baolu (9):
>   iommu/vt-d: Global PASID name space
>   iommu/vt-d: Avoid using idr_for_each_entry()
>   iommu/vt-d: Apply global PASID in SVA
>   iommu/vt-d: Move device_domain_info to header
>   iommu/vt-d: Add for_each_device_domain() helper
>   iommu/vt-d: Per PCI device pasid table interfaces
>   iommu/vt-d: Allocate and free pasid table
>   iommu/vt-d: Apply per pci device pasid table in SVA
>   iommu/vt-d: Remove the obsolete per iommu pasid tables

Applied, thanks.
