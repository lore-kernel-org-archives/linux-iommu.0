From: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v3 06/10] iommu/sva: Search mm by PASID
Date: Tue, 25 Sep 2018 12:59:33 +0800
Message-ID: <bb2e42bb-175a-3368-4a53-8872e63e8d3e@linux.intel.com>
References: <20180920170046.20154-1-jean-philippe.brucker@arm.com>
	<20180920170046.20154-7-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180920170046.20154-7-jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
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
To: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ilias.apalodimas-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, liguozhu-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, christian.koenig-5C7GfCeVMHo@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi,

On 09/21/2018 01:00 AM, Jean-Philippe Brucker wrote:
> The fault handler will need to find an mm given its PASID. This is the
> reason we have an IDR for storing address spaces, so hook it up.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
> ---
>   drivers/iommu/iommu-sva.c | 26 ++++++++++++++++++++++++++
>   include/linux/iommu.h     |  7 +++++++
>   2 files changed, 33 insertions(+)
> 
> diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
> index 5ff8967cb213..ee86f00ee1b9 100644
> --- a/drivers/iommu/iommu-sva.c
> +++ b/drivers/iommu/iommu-sva.c
> @@ -636,6 +636,32 @@ void iommu_sva_unbind_device_all(struct device *dev)
>   }
>   EXPORT_SYMBOL_GPL(iommu_sva_unbind_device_all);
>   
> +/**
> + * iommu_sva_find() - Find mm associated to the given PASID
> + * @pasid: Process Address Space ID assigned to the mm
> + *
> + * Returns the mm corresponding to this PASID, or NULL if not found. A reference
> + * to the mm is taken, and must be released with mmput().
> + */
> +struct mm_struct *iommu_sva_find(int pasid)
> +{
> +	struct io_mm *io_mm;
> +	struct mm_struct *mm = NULL;
> +
> +	spin_lock(&iommu_sva_lock);
> +	io_mm = idr_find(&iommu_pasid_idr, pasid);

The same thing here. We can't guarantee that a pointer of mm_struct type
is associated with a pasid value when pasid is also used for other
purposes. If hardware reports a bad pasid, this function might run into
problem.

Best regards,
Lu Baolu

> +	if (io_mm && io_mm_get_locked(io_mm)) {
> +		if (mmget_not_zero(io_mm->mm))
> +			mm = io_mm->mm;
> +
> +		io_mm_put_locked(io_mm);
> +	}
> +	spin_unlock(&iommu_sva_lock);
> +
> +	return mm;
> +}
> +EXPORT_SYMBOL_GPL(iommu_sva_find);
> +
>   /**
>    * iommu_sva_init_device() - Initialize Shared Virtual Addressing for a device
>    * @dev: the device
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 429f3dc37a35..a457650b80de 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -987,6 +987,8 @@ extern int __iommu_sva_bind_device(struct device *dev, struct mm_struct *mm,
>   				   void *drvdata);
>   extern int __iommu_sva_unbind_device(struct device *dev, int pasid);
>   extern void iommu_sva_unbind_device_all(struct device *dev);
> +extern struct mm_struct *iommu_sva_find(int pasid);
> +
>   #else /* CONFIG_IOMMU_SVA */
>   static inline int iommu_sva_init_device(struct device *dev,
>   					unsigned long features,
> @@ -1016,6 +1018,11 @@ static inline int __iommu_sva_unbind_device(struct device *dev, int pasid)
>   static inline void iommu_sva_unbind_device_all(struct device *dev)
>   {
>   }
> +
> +static inline struct mm_struct *iommu_sva_find(int pasid)
> +{
> +	return NULL;
> +}
>   #endif /* CONFIG_IOMMU_SVA */
>   
>   #endif /* __LINUX_IOMMU_H */
> 
