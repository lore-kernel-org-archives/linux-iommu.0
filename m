From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [RFC PATCH] iommu/vt-d: Add IOTLB flush support for kernel
 addresses
Date: Tue, 20 Oct 2015 18:03:28 +0200
Message-ID: <20151020160328.GV27420@8bytes.org>
References: <1445356379.4486.56.camel@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <1445356379.4486.56.camel@infradead.org>
Sender: owner-linux-mm@kvack.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>, iommu@lists.linux-foundation.org, Sudeep Dutt <sudeep.dutt@intel.com>
List-Id: iommu@lists.linux-foundation.org

Hi David,

On Tue, Oct 20, 2015 at 04:52:59PM +0100, David Woodhouse wrote:
>  void flush_tlb_kernel_range(unsigned long start, unsigned long end)
>  {
> +	intel_iommu_flush_kernel_pasid(start, end);

A more generic naming would be good, and probably expose it through a
function in the IOMMU-API.

> +void intel_iommu_flush_kernel_pasid(unsigned long start, unsigned long end)
> +{
> +	struct dmar_drhd_unit *drhd;
> +	struct intel_iommu *iommu;
> +	unsigned long pages;

And I think, as a performance optimiztion, we should bail out early here
if the pasid has no users.



	Joerg

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
