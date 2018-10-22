From: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [RFC PATCH 2/6] drivers core: Add I/O ASID allocator
Date: Mon, 22 Oct 2018 12:49:47 +0800
Message-ID: <9c6cd6c1-3569-4251-8344-fc9df0e743bc@linux.intel.com>
References: <20181019181158.2395-1-jean-philippe.brucker@arm.com>
	<20181019181158.2395-3-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20181019181158.2395-3-jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
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
Cc: kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, christian.koenig-5C7GfCeVMHo@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi,

On 10/20/18 2:11 AM, Jean-Philippe Brucker wrote:
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

One concern of moving pasid allocator here is about paravirtual
allocation of pasid.

Since there is only a single set of pasid tables which is controlled by
the host, the pasid is a system wide resource. When a driver running in
a guest VM wants to consume a pasid, it must be intercepted by the
simulation software and routed the allocation to the host via VFIO. Some
iommu arch's provide mechanisms to aid this, for example, the virtual
command interfaces defined in vt-d 3.0. Any pasid used in guest VM
should go through the virtual command interfaces.

Best regards,
Lu Baolu

> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
> ---
>   drivers/base/Kconfig   |   7 +++
>   drivers/base/Makefile  |   1 +
>   drivers/base/ioasid.c  | 140 +++++++++++++++++++++++++++++++++++++++++
>   include/linux/ioasid.h |  45 +++++++++++++
>   4 files changed, 193 insertions(+)
>   create mode 100644 drivers/base/ioasid.c
>   create mode 100644 include/linux/ioasid.h
> 
> diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
> index 3e63a900b330..9e41653467d7 100644
> --- a/drivers/base/Kconfig
> +++ b/drivers/base/Kconfig
> @@ -182,6 +182,13 @@ config DMA_SHARED_BUFFER
>   	  APIs extension; the file's descriptor can then be passed on to other
>   	  driver.
>   
> +config IOASID
> +	bool
> +	default n
> +	help
> +	  Enable the I/O Address Space ID allocator. A single ID space shared
> +	  between different users.
> +
>   config DMA_FENCE_TRACE
>   	bool "Enable verbose DMA_FENCE_TRACE messages"
>   	depends on DMA_SHARED_BUFFER
> diff --git a/drivers/base/Makefile b/drivers/base/Makefile
> index 704f44295810..79e83a1b344b 100644
> --- a/drivers/base/Makefile
> +++ b/drivers/base/Makefile
> @@ -23,6 +23,7 @@ obj-$(CONFIG_PINCTRL) += pinctrl.o
>   obj-$(CONFIG_DEV_COREDUMP) += devcoredump.o
>   obj-$(CONFIG_GENERIC_MSI_IRQ_DOMAIN) += platform-msi.o
>   obj-$(CONFIG_GENERIC_ARCH_TOPOLOGY) += arch_topology.o
> +obj-$(CONFIG_IOASID) += ioasid.o
>   
>   obj-y			+= test/
>   
> diff --git a/drivers/base/ioasid.c b/drivers/base/ioasid.c
> new file mode 100644
> index 000000000000..71ab7ee73ecb
> --- /dev/null
> +++ b/drivers/base/ioasid.c
> @@ -0,0 +1,140 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * I/O Address Space ID allocator. There is one global IOASID space, split into
> + * subsets. Users create a subset with DECLARE_IOASID_SET, then allocate and
> + * free IOASIDs with ioasid_alloc and ioasid_free.
> + */
> +#include <linux/idr.h>
> +#include <linux/ioasid.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +
> +struct ioasid_data {
> +	ioasid_t id;
> +	struct ioasid_set *set;
> +	void *private;
> +};
> +
> +static DEFINE_IDR(ioasid_idr);
> +
> +/**
> + * ioasid_alloc - Allocate an IOASID
> + * @set: the IOASID set
> + * @min: the minimum ID (inclusive)
> + * @max: the maximum ID (exclusive)
> + * @private: data private to the caller
> + *
> + * Allocate an ID between @min and @max (or %0 and %INT_MAX). Return the
> + * allocated ID on success, or INVALID_IOASID on failure. The @private pointer
> + * is stored internally and can be retrieved with ioasid_find().
> + */
> +ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
> +		      void *private)
> +{
> +	int id;
> +	struct ioasid_data *data;
> +
> +	data = kzalloc(sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return INVALID_IOASID;
> +
> +	data->set = set;
> +	data->private = private;
> +
> +	idr_preload(GFP_KERNEL);
> +	idr_lock(&ioasid_idr);
> +	data->id = id = idr_alloc(&ioasid_idr, data, min, max, GFP_ATOMIC);
> +	idr_unlock(&ioasid_idr);
> +	idr_preload_end();
> +
> +	if (id < 0) {
> +		kfree(data);
> +		return INVALID_IOASID;
> +	}
> +
> +	return data->id;
> +}
> +EXPORT_SYMBOL_GPL(ioasid_alloc);
> +
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
> +	kfree(ioasid_data);
> +}
> +EXPORT_SYMBOL_GPL(ioasid_free);
> +
> +struct ioasid_iter_data {
> +	struct ioasid_set *set;
> +	ioasid_iter_t func;
> +	void *data;
> +};
> +
> +static int ioasid_iter(int ioasid, void *p, void *data)
> +{
> +	struct ioasid_iter_data *iter_data = data;
> +	struct ioasid_data *ioasid_data = p;
> +
> +	if (iter_data->set != ioasid_data->set)
> +		return 0;
> +
> +	return iter_data->func(ioasid, ioasid_data->private, iter_data->data);
> +}
> +
> +/**
> + * ioasid_for_each - Iterate over IOASIDs for this set.
> + * @set: the IOASID set
> + * @func: called for each matching IOASID.
> + * @data: data passed to the callback
> + *
> + * Execute @func for all IOASIDs in the given set. If @func returns anything
> + * other than %0, the iteration stops and that value is returned from this
> + * function.
> + */
> +int ioasid_for_each(struct ioasid_set *set, ioasid_iter_t func, void *data)
> +{
> +	int ret;
> +	struct ioasid_iter_data iter_data = {
> +		.set	= set,
> +		.func	= func,
> +		.data	= data,
> +	};
> +
> +	idr_lock(&ioasid_idr);
> +	ret = idr_for_each(&ioasid_idr, ioasid_iter, &iter_data);
> +	idr_unlock(&ioasid_idr);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(ioasid_for_each);
> +
> +/**
> + * ioasid_find - Find IOASID data
> + * @set: the IOASID set
> + * @ioasid: the IOASID to find
> + *
> + * If the IOASID has been allocated for this set, return the private pointer
> + * passed to ioasid_alloc. Otherwise return NULL.
> + */
> +void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid)
> +{
> +	void *priv = NULL;
> +	struct ioasid_data *ioasid_data;
> +
> +	idr_lock(&ioasid_idr);
> +	ioasid_data = idr_find(&ioasid_idr, ioasid);
> +	if (ioasid_data && ioasid_data->set == set)
> +		priv = ioasid_data->private;
> +	idr_unlock(&ioasid_idr);
> +
> +	return priv;
> +}
> +EXPORT_SYMBOL_GPL(ioasid_find);
> diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
> new file mode 100644
> index 000000000000..cf6fb3496692
> --- /dev/null
> +++ b/include/linux/ioasid.h
> @@ -0,0 +1,45 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __LINUX_IOASID_H
> +#define __LINUX_IOASID_H
> +
> +#define INVALID_IOASID ((ioasid_t)-1)
> +typedef unsigned int ioasid_t;
> +typedef int (*ioasid_iter_t)(ioasid_t ioasid, void *private, void *data);
> +
> +struct ioasid_set {
> +	int dummy;
> +};
> +
> +#define DECLARE_IOASID_SET(name) struct ioasid_set name = { 0 }
> +
> +#ifdef CONFIG_IOASID
> +ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
> +		      void *private);
> +void ioasid_free(ioasid_t ioasid);
> +
> +int ioasid_for_each(struct ioasid_set *set, ioasid_iter_t func, void *data);
> +void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid);
> +
> +#else /* !CONFIG_IOASID */
> +static inline ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min,
> +				    ioasid_t max, void *private)
> +{
> +	return INVALID_IOASID;
> +}
> +
> +static inline void ioasid_free(ioasid_t ioasid)
> +{
> +}
> +
> +static inline int ioasid_for_each(struct ioasid_set *set, ioasid_iter_t func,
> +				  void *data)
> +{
> +	return -ESRCH;
> +}
> +
> +static inline void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid)
> +{
> +	return -ESRCH;
> +}
> +#endif /* CONFIG_IOASID */
> +#endif /* __LINUX_IOASID_H */
> 
