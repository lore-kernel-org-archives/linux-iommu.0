From: "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH 1/1] iommu/vtd: Fix NULL pointer dereference in
        prq_event_thread()
Date: Mon, 5 Nov 2018 05:21:35 +0000
Message-ID: <A2975661238FB949B60364EF0F2C257439D5DF53@SHSMSX104.ccr.corp.intel.com>
References: <20181105021858.16958-1-baolu.lu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181105021858.16958-1-baolu.lu@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>
Cc: "Raj, Ashok" <ashok.raj@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
List-Id: iommu@lists.linux-foundation.org

Hi Baolu,

> From: iommu-bounces@lists.linux-foundation.org [mailto:iommu-
> bounces@lists.linux-foundation.org] On Behalf Of Lu Baolu
> Sent: Monday, November 5, 2018 10:19 AM
> To: Joerg Roedel <joro@8bytes.org>; David Woodhouse <dwmw2@infradead.org>
> Cc: Raj, Ashok <ashok.raj@intel.com>; linux-kernel@vger.kernel.org;
> iommu@lists.linux-foundation.org
> Subject: [PATCH 1/1] iommu/vtd: Fix NULL pointer dereference in prq_event_thread()
> 
> When handling page request without pasid event, go to "no_pasid"
> branch instead of "bad_req". Otherwise, a NULL pointer deference will happen there.
> 
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Sohil Mehta <sohil.mehta@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel-svm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c index
> db301efe126d..887150907526 100644
> --- a/drivers/iommu/intel-svm.c
> +++ b/drivers/iommu/intel-svm.c
> @@ -595,7 +595,7 @@ static irqreturn_t prq_event_thread(int irq, void *d)
>  			pr_err("%s: Page request without PASID: %08llx %08llx\n",
>  			       iommu->name, ((unsigned long long *)req)[0],
>  			       ((unsigned long long *)req)[1]);
> -			goto bad_req;
> +			goto no_pasid;
>  		}
> 
>  		if (!svm || svm->pasid != req->pasid) {
> --

I'm afraid it is still necessary to goto "bad_req". The following code behind
"bad_req" will trigger fault_cb registered by in-kernel drivers. It is reasonable
that PRQ without PASID can be handled by such callbacks. So I would suggest
to keep the existing logic.

                if (sdev && sdev->ops && sdev->ops->fault_cb) {
                        int rwxp = (req->rd_req << 3) | (req->wr_req << 2) |
                                 (req->exe_req << 1) | (req->priv_req);
                        sdev->ops->fault_cb(sdev->dev, req->pasid, req->addr, req->private, rwxp, result);
                 }

Thanks,
Yi Liu
