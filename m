From: Andriy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 01/18] drivers core: Add I/O ASID allocator
Date: Tue, 9 Apr 2019 13:00:49 +0300
Message-ID: <20190409100049.GC9224@smile.fi.intel.com>
References: <1554767973-30125-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1554767973-30125-2-git-send-email-jacob.jun.pan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1554767973-30125-2-git-send-email-jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
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
Cc: "Tian, Kevin" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Raj Ashok <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Apr 08, 2019 at 04:59:16PM -0700, Jacob Pan wrote:
> From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
> 
> Some devices might support multiple DMA address spaces, in particular
> those that have the PCI PASID feature. PASID (Process Address Space ID)
> allows to share process address spaces with devices (SVA), partition a
> device into VM-assignable entities (VFIO mdev) or simply provide
> multiple DMA address space to kernel drivers. Add a global PASID
> allocator usable by different drivers at the same time. Name it I/O ASID
> to avoid confusion with ASIDs allocated by arch code, which are usually
> a separate ID space.
> 
> The IOASID space is global. Each device can have its own PASID space,
> but by convention the IOMMU ended up having a global PASID space, so
> that with SVA, each mm_struct is associated to a single PASID.
> 
> The allocator doesn't really belong in drivers/iommu because some
> drivers would like to allocate PASIDs for devices that aren't managed by
> an IOMMU, using the same ID space as IOMMU. It doesn't really belong in
> drivers/pci either since platform device also support PASID. Add the
> allocator in drivers/base.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
> ---
>  drivers/base/Kconfig   |   7 ++++
>  drivers/base/Makefile  |   1 +
>  drivers/base/ioasid.c  | 106 +++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/ioasid.h |  40 +++++++++++++++++++
>  4 files changed, 154 insertions(+)
>  create mode 100644 drivers/base/ioasid.c
>  create mode 100644 include/linux/ioasid.h
> 
> diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
> index 059700e..e05288d 100644
> --- a/drivers/base/Kconfig
> +++ b/drivers/base/Kconfig
> @@ -182,6 +182,13 @@ config DMA_SHARED_BUFFER
>  	  APIs extension; the file's descriptor can then be passed on to other
>  	  driver.
>  
> +config IOASID
> +	bool

> +	default n

Redundant.

> +	help
> +	  Enable the I/O Address Space ID allocator. A single ID space shared
> +	  between different users.

> +/**
> + * ioasid_free - Free an IOASID
> + * @ioasid: the ID to remove
> + */
> +void ioasid_free(ioasid_t ioasid)
> +{
> +	struct ioasid_data *ioasid_data;
> +
> +	idr_lock(&ioasid_idr);
> +	ioasid_data = idr_remove(&ioasid_idr, ioasid);
> +	idr_unlock(&ioasid_idr);
> +

> +	if (ioasid_data)
> +		kfree_rcu(ioasid_data, rcu);

I think it makes sense to add a helper macro to rcupdate.h
(and we have several cases in kernel that can utilize it)

#define kfree_non_null_rcu(ptr, rcu_head)		\
	do {						\
		if (ptr)				\
			kfree_rcu(ptr, rcu_head);	\
	} while (0)

as a more common pattern for resource deallocators.

> +}

-- 
With Best Regards,
Andy Shevchenko
