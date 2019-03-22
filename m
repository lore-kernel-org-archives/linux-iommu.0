From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 1/2] iommu/vt-d: Check capability before disabling
 protected memory
Date: Fri, 22 Mar 2019 10:38:11 +0100
Message-ID: <20190322093811.GB18669@8bytes.org>
References: <20190320015834.22653-1-baolu.lu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190320015834.22653-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>, ashok.raj@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com, yi.l.liu@intel.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Jacob Pan <jacob.jun.pan@linux.intel.com>, mark gross <mgross@intel.com>
List-Id: iommu@lists.linux-foundation.org

On Wed, Mar 20, 2019 at 09:58:33AM +0800, Lu Baolu wrote:
> The spec states in 10.4.16 that the Protected Memory Enable
> Register should be treated as read-only for implementations
> not supporting protected memory regions (PLMR and PHMR fields
> reported as Clear in the Capability register).
> 
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: mark gross <mgross@intel.com>
> Suggested-by: Ashok Raj <ashok.raj@intel.com>
> Fixes: f8bab73515ca5 ("intel-iommu: PMEN support")
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel-iommu.c | 3 +++
>  1 file changed, 3 insertions(+)

Applied both, thanks.
