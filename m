From: "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH 1/3] iommu/vt-d: Missing checks for pasid tables if
 allocation     fails
Date: Thu, 19 Oct 2017 06:40:47 +0000
Message-ID: <A2975661238FB949B60364EF0F2C257439AFB902@SHSMSX104.ccr.corp.intel.com>
References: <1508373556-5340-1-git-send-email-baolu.lu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1508373556-5340-1-git-send-email-baolu.lu@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Lu Baolu <baolu.lu@linux.intel.com>, "joro@8bytes.org" <joro@8bytes.org>, "dwmw2@infradead.org" <dwmw2@infradead.org>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: iommu-bounces@lists.linux-foundation.org [mailto:iommu-
> bounces@lists.linux-foundation.org] On Behalf Of Lu Baolu
> Sent: Thursday, October 19, 2017 8:39 AM
> To: joro@8bytes.org; dwmw2@infradead.org
> Cc: iommu@lists.linux-foundation.org; linux-kernel@vger.kernel.org
> Subject: [PATCH 1/3] iommu/vt-d: Missing checks for pasid tables if allocation fails
> 
> intel_svm_alloc_pasid_tables() might return an error but never be checked by the
> callers. Later when intel_svm_bind_mm() is called, there are no checks for valid pasid
> tables before enabling them.
> 
> Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel-svm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c index
> f6697e5..43280ca 100644
> --- a/drivers/iommu/intel-svm.c
> +++ b/drivers/iommu/intel-svm.c
> @@ -292,7 +292,7 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int
> flags, struct svm_dev_
>  	int pasid_max;
>  	int ret;
> 
> -	if (WARN_ON(!iommu))
> +	if (WARN_ON(!iommu || !iommu->pasid_table))

[Liu, Yi L] Hi Baolu, I guess there also need a check to iommu->ecap , see if the pasid bit
is reported. thoughts?

Regards,
Yi L

>  		return -EINVAL;
> 
>  	if (dev_is_pci(dev)) {
> --
> 2.7.4
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
