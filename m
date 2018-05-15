From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 0/4] iommu/vt-d: Several cleanup patches
Date: Tue, 15 May 2018 16:35:18 +0200
Message-ID: <20180515143517.dyabef7n2xnmecaa@8bytes.org>
References: <1525410499-18632-1-git-send-email-baolu.lu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1525410499-18632-1-git-send-email-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>, ashok.raj@intel.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Fri, May 04, 2018 at 01:08:15PM +0800, Lu Baolu wrote:
> Lu Baolu (4):
>   iommu: Clean up the comments for iommu_group_alloc
>   iommu/vt-d: Clean up unused variable in find_or_alloc_domain
>   iommu/vt-d: Clean up pasid quirk for pre-production devices
>   iommu/vt-d: Remove unnecessary parentheses
> 
>  drivers/iommu/intel-iommu.c | 36 +++---------------------------------
>  drivers/iommu/intel-svm.c   |  2 +-
>  drivers/iommu/iommu.c       |  1 -
>  include/linux/intel-iommu.h |  1 -
>  4 files changed, 4 insertions(+), 36 deletions(-)

Applied, thanks.
