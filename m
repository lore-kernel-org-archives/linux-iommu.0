From: "Liu, Yi L" <yi.l.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH 6/9] iommu/vt-d: Allocate and free pasid table
Date: Tue, 1 May 2018 09:22:22 +0000
Message-ID: <A2975661238FB949B60364EF0F2C257439BE752C@SHSMSX104.ccr.corp.intel.com>
References: <1523934202-21669-1-git-send-email-baolu.lu@linux.intel.com>
	<1523934202-21669-7-git-send-email-baolu.lu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1523934202-21669-7-git-send-email-baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: "Raj, Ashok" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Kumar,
	Sanjay K" <sanjay.k.kumar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Sun, Yi Y" <yi.y.sun-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Pan,
	Jacob jun" <jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

> From: Lu Baolu [mailto:baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org]
> Sent: Tuesday, April 17, 2018 11:03 AM
> 
> This patch allocates PASID table for a domain at the time when
> it is being created (if any devices using this domain supports
> PASID feature), and free it when the domain is freed.
> 
> Cc: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Cc: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Cc: Kevin Tian <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Cc: Liu Yi L <yi.l.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> ---
>  drivers/iommu/intel-iommu.c | 13 +++++++++++++
>  drivers/iommu/intel-svm.c   |  8 --------
>  include/linux/intel-iommu.h | 10 ++++++++--
>  3 files changed, 21 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index caa0b5c..99c643b 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -2460,6 +2460,18 @@ static struct dmar_domain
> *dmar_insert_one_dev_info(struct intel_iommu *iommu,
>  		dev->archdata.iommu = info;
>  	spin_unlock_irqrestore(&device_domain_lock, flags);
> 
> +	if (dev && dev_is_pci(dev) && info->pasid_supported) {
> +		if (pasid_enabled(iommu)) {
> +			size_t size, count;
> +
> +			size = sizeof(struct pasid_entry);
> +			count = min_t(int,
> +				      pci_max_pasids(to_pci_dev(dev)),
> +				      intel_pasid_max_id);
> +			ret = intel_pasid_alloc_table(dev, size, count);

No check for the return value?

> +		}
> +	}
> +
>  	if (dev && domain_context_mapping(domain, dev)) {
>  		pr_err("Domain context map for %s failed\n", dev_name(dev));
>  		dmar_remove_one_dev_info(domain, dev);
> @@ -4826,6 +4838,7 @@ static void dmar_remove_one_dev_info(struct
> dmar_domain *domain,
>  	unsigned long flags;
> 
>  	spin_lock_irqsave(&device_domain_lock, flags);
> +	intel_pasid_free_table(dev);
>  	info = dev->archdata.iommu;
>  	__dmar_remove_one_dev_info(info);
>  	spin_unlock_irqrestore(&device_domain_lock, flags);
> diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
> index 24d0ea1..3abc94f 100644
> --- a/drivers/iommu/intel-svm.c
> +++ b/drivers/iommu/intel-svm.c
> @@ -34,14 +34,6 @@
> 
>  static irqreturn_t prq_event_thread(int irq, void *d);
> 
> -struct pasid_entry {
> -	u64 val;
> -};
> -
> -struct pasid_state_entry {
> -	u64 val;
> -};
> -
>  int intel_svm_alloc_pasid_tables(struct intel_iommu *iommu)
>  {
>  	struct page *pages;
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index bee7a3f..08e5811 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -382,8 +382,14 @@ enum {
>  #define VTD_FLAG_TRANS_PRE_ENABLED	(1 << 0)
>  #define VTD_FLAG_IRQ_REMAP_PRE_ENABLED	(1 << 1)
> 
> -struct pasid_entry;
> -struct pasid_state_entry;
> +struct pasid_entry {
> +	u64 val;
> +};
> +
> +struct pasid_state_entry {
> +	u64 val;
> +};
> +
>  struct page_req_dsc;
> 
>  struct dmar_domain {

Overall, this patch looks good to me. But need to fix the comment above.

Reviewed-by: Liu, Yi L <yi.l.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

Regards,
Yi Liu
