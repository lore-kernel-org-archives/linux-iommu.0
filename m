From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 1/1] iommu/vt-d: Handle memory shortage on pasid table
 allocation
Date: Tue, 25 Sep 2018 13:35:49 +0200
Message-ID: <20180925113549.GB18287@8bytes.org>
References: <20180901062416.6107-1-baolu.lu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180901062416.6107-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>, ashok.raj@intel.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Jacob Pan <jacob.jun.pan@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

On Sat, Sep 01, 2018 at 02:24:16PM +0800, Lu Baolu wrote:
> Pasid table memory allocation could return failure due to memory
> shortage. Limit the pasid table size to 1MiB because current 8MiB
> contiguous physical memory allocation can be hard to come by. W/o
> a PASID table, the device could continue to work with only shared
> virtual memory impacted. So, let's go ahead with context mapping
> even the memory allocation for pasid table failed.
> 
> Fixes: cc580e41260d ("iommu/vt-d: Per PCI device pasid table interfaces")
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Reported-and-tested-by: Pelton Kyle D <kyle.d.pelton@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel-iommu.c | 6 +++---
>  drivers/iommu/intel-pasid.h | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)

Applied, thanks.
