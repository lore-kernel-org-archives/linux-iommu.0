From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 2/2] iommu/vt-d: Helper function to query if a pasid has
 any active users
Date: Wed, 17 May 2017 14:59:23 +0200
Message-ID: <20170517125923.GE11068@8bytes.org>
References: <1494441543-8216-1-git-send-email-ashok.raj@intel.com>
 <1494441543-8216-2-git-send-email-ashok.raj@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1494441543-8216-2-git-send-email-ashok.raj@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ashok Raj <ashok.raj@intel.com>
Cc: linux-kernel@vger.kernel.org, CQ Tang <cq.tang@intel.com>, linux-pci@vger.kernel.org, Jean-Phillipe Brucker <jean-philippe.brucker@arm.com>, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

On Wed, May 10, 2017 at 11:39:03AM -0700, Ashok Raj wrote:
> From: CQ Tang <cq.tang@intel.com>
> 
> A driver would need to know if there are any active references to a
> a PASID before cleaning up its resources. This function helps check
> if there are any active users of a PASID before it can perform any
> recovery on that device.
> 
> To: Joerg Roedel <joro@8bytes.org>
> To: linux-kernel@vger.kernel.org
> To: David Woodhouse <dwmw2@infradead.org>
> Cc: Jean-Phillipe Brucker <jean-philippe.brucker@arm.com>
> Cc: iommu@lists.linux-foundation.org
> 
> Signed-off-by: CQ Tang <cq.tang@intel.com>
> Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> ---
>  drivers/iommu/intel-svm.c | 30 ++++++++++++++++++++++++++++++
>  include/linux/intel-svm.h | 20 ++++++++++++++++++++
>  2 files changed, 50 insertions(+)

Applied, thanks.
