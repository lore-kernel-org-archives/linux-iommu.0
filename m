From: "Liu, Yi L" <yi.l.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH v4 17/22] iommu/intel-svm: report device page request
Date: Mon, 14 May 2018 06:56:11 +0000
Message-ID: <A2975661238FB949B60364EF0F2C257439BEFA7F@SHSMSX104.ccr.corp.intel.com>
References: <1521774734-48433-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1521774734-48433-18-git-send-email-jacob.jun.pan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1521774734-48433-18-git-send-email-jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
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
To: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David
	Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "Wysocki, Rafael J" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Raj, Ashok" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Jacob,

Same comment with the one to patch 16, pci_get_bus_and_slot() is
deprecated, may update accordingly.

Thanks,
Yi Liu

> From: Jacob Pan [mailto:jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org]
> Sent: Friday, March 23, 2018 11:12 AM
> 
> If the source device of a page request has its PASID table pointer bound to a guest,
> the first level page tables are owned by the guest.
> In this case, we shall let guest OS to manage page fault.
> 
> This patch uses the IOMMU fault reporting API to send fault events, possibly via VFIO,
> to the guest OS. Once guest pages are fault in, guest will issue page response which
> will be passed down via the invalidation passdown APIs.
> 
> Recoverable faults, such as page request reporting is not limitted to guest use. In
> kernel driver can also request a chance to receive fault notifications.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Signed-off-by: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/iommu/intel-svm.c | 71 ++++++++++++++++++++++++++++++++++++++++---
> ----
>  include/linux/iommu.h     |  1 +
>  2 files changed, 62 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c index
> 99bc9bd..bdc702c 100644
> --- a/drivers/iommu/intel-svm.c
> +++ b/drivers/iommu/intel-svm.c
> @@ -580,6 +580,56 @@ static bool is_canonical_address(u64 addr)
>  	return (((saddr << shift) >> shift) == saddr);  }
> 
> +static int prq_to_iommu_prot(struct page_req_dsc *req) {
> +	int prot = 0;
> +
> +	if (req->rd_req)
> +		prot |= IOMMU_FAULT_READ;
> +	if (req->wr_req)
> +		prot |= IOMMU_FAULT_WRITE;
> +	if (req->exe_req)
> +		prot |= IOMMU_FAULT_EXEC;
> +	if (req->priv_req)
> +		prot |= IOMMU_FAULT_PRIV;
> +
> +	return prot;
> +}
> +
> +static int intel_svm_prq_report(struct page_req_dsc *desc) {
> +	int ret = 0;
> +	struct iommu_fault_event event;
> +	struct pci_dev *pdev;
> +
> +	memset(&event, 0, sizeof(struct iommu_fault_event));
> +	pdev = pci_get_bus_and_slot(desc->bus, desc->devfn);
> +	if (!pdev) {
> +		pr_err("No PCI device found for PRQ [%02x:%02x.%d]\n",
> +			desc->bus, PCI_SLOT(desc->devfn),
> +			PCI_FUNC(desc->devfn));
> +		return -ENODEV;
> +	}
> +
> +	/* Fill in event data for device specific processing */
> +	event.type = IOMMU_FAULT_PAGE_REQ;
> +	event.addr = (u64)desc->addr << VTD_PAGE_SHIFT;
> +	event.pasid = desc->pasid;
> +	event.page_req_group_id = desc->prg_index;
> +	event.prot = prq_to_iommu_prot(desc);
> +	event.last_req = desc->lpig;
> +	event.pasid_valid = 1;
> +	/* keep track of PRQ so that when the response comes back, we know
> +	 * whether we do group response or stream response. SRR[0] and
> +	 * private[54:32] bits in the descriptor are stored.
> +	 */
> +	event.iommu_private = *(u64 *)desc;
> +	ret = iommu_report_device_fault(&pdev->dev, &event);
> +	pci_dev_put(pdev);
> +
> +	return ret;
> +}
> +
>  static irqreturn_t prq_event_thread(int irq, void *d)  {
>  	struct intel_iommu *iommu = d;
> @@ -628,6 +678,16 @@ static irqreturn_t prq_event_thread(int irq, void *d)
>  				goto no_pasid;
>  			}
>  		}
> +		/* If address is not canonical, return invalid response */
> +		if (!is_canonical_address(address))
> +			goto bad_req;
> +
> +		/*
> +		 * If prq is to be handled outside iommu driver via receiver of
> +		 * the fault notifiers, we skip the page response here.
> +		 */
> +		if (!intel_svm_prq_report(req))
> +			goto prq_advance;
> 
>  		result = QI_RESP_INVALID;
>  		/* Since we're using init_mm.pgd directly, we should never take @@
> -638,9 +698,6 @@ static irqreturn_t prq_event_thread(int irq, void *d)
>  		if (!mmget_not_zero(svm->mm))
>  			goto bad_req;
> 
> -		/* If address is not canonical, return invalid response */
> -		if (!is_canonical_address(address))
> -			goto bad_req;
> 
>  		down_read(&svm->mm->mmap_sem);
>  		vma = find_extend_vma(svm->mm, address); @@ -673,12 +730,6
> @@ static irqreturn_t prq_event_thread(int irq, void *d)
> 
>  		if (WARN_ON(&sdev->list == &svm->devs))
>  			sdev = NULL;
> -
> -		if (sdev && sdev->ops && sdev->ops->fault_cb) {
> -			int rwxp = (req->rd_req << 3) | (req->wr_req << 2) |
> -				(req->exe_req << 1) | (req->priv_req);
> -			sdev->ops->fault_cb(sdev->dev, req->pasid, req->addr, req-
> >private, rwxp, result);
> -		}
>  		/* We get here in the error case where the PASID lookup failed,
>  		   and these can be NULL. Do not use them below this point! */
>  		sdev = NULL;
> @@ -704,7 +755,7 @@ static irqreturn_t prq_event_thread(int irq, void *d)
> 
>  			qi_submit_sync(&resp, iommu);
>  		}
> -
> +	prq_advance:
>  		head = (head + sizeof(*req)) & PRQ_RING_MASK;
>  	}
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h index 94cfda8..dbe2866
> 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -42,6 +42,7 @@
>   * if the IOMMU page table format is equivalent.
>   */
>  #define IOMMU_PRIV	(1 << 5)
> +#define IOMMU_EXEC	(1 << 6)
> 
>  struct iommu_ops;
>  struct iommu_group;
> --
> 2.7.4
