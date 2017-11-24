From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH v3 15/16] iommu: introduce page response function
Date: Fri, 24 Nov 2017 12:03:50 +0000
Message-ID: <93661c1c-2d3b-295f-0b9d-52e50ea9e1d0@arm.com>
References: <1510944914-54430-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1510944914-54430-16-git-send-email-jacob.jun.pan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1510944914-54430-16-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Alex Williamson <alex.williamson@redhat.com>
Cc: Lan Tianyu <tianyu.lan@intel.com>, Jean Delvare <khali@linux-fr.org>
List-Id: iommu@lists.linux-foundation.org

On 17/11/17 18:55, Jacob Pan wrote:
> When nested translation is turned on and guest owns the
> first level page tables, device page request can be forwared
> to the guest for handling faults. As the page response returns
> by the guest, IOMMU driver on the host need to process the
> response which informs the device and completes the page request
> transaction.
> 
> This patch introduces generic API function for page response
> passing from the guest or other in-kernel users. The definitions of
> the generic data is based on PCI ATS specification not limited to
> any vendor.>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/iommu/iommu.c | 14 ++++++++++++++
>  include/linux/iommu.h | 42 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 56 insertions(+)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 97b7990..7aefb40 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1416,6 +1416,20 @@ int iommu_sva_invalidate(struct iommu_domain *domain,
>  }
>  EXPORT_SYMBOL_GPL(iommu_sva_invalidate);
>  
> +int iommu_page_response(struct iommu_domain *domain, struct device *dev,
> +			struct page_response_msg *msg)

I think it's simpler, both for IOMMU and device drivers, to pass the exact
structure received in the fault handler back to the IOMMU driver, along
with a separate response status. So maybe

int iommu_page_response(struct iommu_domain *domain, struct device *dev,
			struct iommu_fault_event *event, u32 response)

And then you'd just need to define the IOMMU_PAGE_RESPONSE_* values.

Thanks,
Jean
