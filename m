From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC 6/9] iommu/vt-d: track device with pasid table bond to a
	guest
Date: Thu, 22 Jun 2017 16:54:35 -0600
Message-ID: <20170622165435.1e9efbce@w520.home>
References: <1497478983-77580-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1497478983-77580-7-git-send-email-jacob.jun.pan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1497478983-77580-7-git-send-email-jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Tian,
	Kevin" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, 14 Jun 2017 15:23:00 -0700
Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:

> When PASID table pointer of an assigned device is bond to a guest,

s/bond/bound/

> the first level page tables are managed by the guest. However, only
> host/physical IOMMU can detect fault events, e.g. page requests.
> Therefore, we need to keep track of which device has its PASID table
> pointer bond to a guest such that page request and other events can

same and throughout...

> be propagated to the guest as needed.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Signed-off-by: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/iommu/intel-iommu.c | 19 +------------------
>  include/linux/intel-iommu.h | 19 +++++++++++++++++++
>  2 files changed, 20 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 6b8e997..9765277 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -416,24 +416,6 @@ struct dmar_domain {
>  					   iommu core */
>  };
>  
> -/* PCI domain-device relationship */
> -struct device_domain_info {
> -	struct list_head link;	/* link to domain siblings */
> -	struct list_head global; /* link to global list */
> -	u8 bus;			/* PCI bus number */
> -	u8 devfn;		/* PCI devfn number */
> -	u8 pasid_supported:3;
> -	u8 pasid_enabled:1;
> -	u8 pri_supported:1;
> -	u8 pri_enabled:1;
> -	u8 ats_supported:1;
> -	u8 ats_enabled:1;
> -	u8 ats_qdep;
> -	struct device *dev; /* it's NULL for PCIe-to-PCI bridge */
> -	struct intel_iommu *iommu; /* IOMMU used by this device */
> -	struct dmar_domain *domain; /* pointer to domain */
> -};
> -
>  struct dmar_rmrr_unit {
>  	struct list_head list;		/* list of rmrr units	*/
>  	struct acpi_dmar_header *hdr;	/* ACPI header		*/
> @@ -5547,6 +5529,7 @@ static int intel_iommu_bind_pasid_table(struct iommu_domain *domain,
>  				DMA_CCMD_MASK_NOBIT,
>  				DMA_CCMD_DEVICE_INVL);
>  	iommu->flush.flush_iotlb(iommu, did, 0, 0, DMA_TLB_DSI_FLUSH);
> +	info->pasid_tbl_bond = 1;
>  	spin_unlock_irqrestore(&iommu->lock, flags);
>  
>  
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index 8df6c91..ed39c56 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -434,6 +434,25 @@ struct intel_iommu {
>  	u32		flags;      /* Software defined flags */
>  };
>  
> +/* PCI domain-device relationship */
> +struct device_domain_info {
> +	struct list_head link;	/* link to domain siblings */
> +	struct list_head global; /* link to global list */
> +	u8 bus;			/* PCI bus number */
> +	u8 devfn;		/* PCI devfn number */
> +	u8 pasid_supported:3;
> +	u8 pasid_enabled:1;
> +	u8 pasid_tbl_bond:1;	/* bond to guest PASID table */
> +	u8 pri_supported:1;
> +	u8 pri_enabled:1;
> +	u8 ats_supported:1;
> +	u8 ats_enabled:1;
> +	u8 ats_qdep;
> +	struct device *dev; /* it's NULL for PCIe-to-PCI bridge */
> +	struct intel_iommu *iommu; /* IOMMU used by this device */
> +	struct dmar_domain *domain; /* pointer to domain */
> +};
> +
>  static inline void __iommu_flush_cache(
>  	struct intel_iommu *iommu, void *addr, int size)
>  {
