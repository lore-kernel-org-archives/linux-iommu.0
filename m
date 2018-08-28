From: Auger Eric <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v5 01/23] iommu: introduce bind_pasid_table API function
Date: Tue, 28 Aug 2018 10:34:19 +0200
Message-ID: <7c331f56-1ff8-7929-76bf-e73915a91ace@redhat.com>
References: <1526072055-86990-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1526072055-86990-2-git-send-email-jacob.jun.pan@linux.intel.com>
	<b6621306-fd32-7ede-ae88-7345898eb134@redhat.com>
	<20180827221422.57e233df@jacob-builder>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180827221422.57e233df@jacob-builder>
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
To: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Yi L <yi.l.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Raj Ashok <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Rafael Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Liu-i9wRM+HIrmnmtl4Z8vJ8Kg761KYD1DLY@public.gmane.org, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Jacob,

On 08/28/2018 07:14 AM, Jacob Pan wrote:
> On Fri, 24 Aug 2018 17:00:51 +0200
> Auger Eric <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> 
>> Hi Jacob,
>>
>> On 05/11/2018 10:53 PM, Jacob Pan wrote:
>>> Virtual IOMMU was proposed to support Shared Virtual Memory (SVM)
>>> use in the guest:
>>> https://lists.gnu.org/archive/html/qemu-devel/2016-11/msg05311.html
>>>
>>> As part of the proposed architecture, when an SVM capable PCI
>>> device is assigned to a guest, nested mode is turned on. Guest owns
>>> the first level page tables (request with PASID) which performs
>>> GVA->GPA translation. Second level page tables are owned by the
>>> host for GPA->HPA translation for both request with and without
>>> PASID.
>>>
>>> A new IOMMU driver interface is therefore needed to perform tasks as
>>> follows:
>>> * Enable nested translation and appropriate translation type
>>> * Assign guest PASID table pointer (in GPA) and size to host IOMMU
>>>
>>> This patch introduces new API functions to perform bind/unbind
>>> guest PASID tables. Based on common data, model specific IOMMU
>>> drivers can be extended to perform the specific steps for binding
>>> pasid table of assigned devices.
>>>
>>> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
>>> Signed-off-by: Liu, Yi L <yi.l.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>>> Signed-off-by: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>>> Signed-off-by: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>>> ---
>>>  drivers/iommu/iommu.c      | 19 +++++++++++++++++++
>>>  include/linux/iommu.h      | 24 ++++++++++++++++++++++++
>>>  include/uapi/linux/iommu.h | 33 +++++++++++++++++++++++++++++++++
>>>  3 files changed, 76 insertions(+)
>>>  create mode 100644 include/uapi/linux/iommu.h
>>>
>>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>>> index d2aa2320..3a69620 100644
>>> --- a/drivers/iommu/iommu.c
>>> +++ b/drivers/iommu/iommu.c
>>> @@ -1325,6 +1325,25 @@ int iommu_attach_device(struct iommu_domain
>>> *domain, struct device *dev) }
>>>  EXPORT_SYMBOL_GPL(iommu_attach_device);
>>>  
>>> +int iommu_bind_pasid_table(struct iommu_domain *domain, struct
>>> device *dev,
>>> +			struct pasid_table_config *pasidt_binfo)  
>> As Jean-Philippe, I must confessed i am very confused by having both
>> the iommu_domain and dev passed as argument.
>>
>> I know this was discussed when the RFC was submitted and maybe I
>> missed the main justification behind that choice. I understand that
>> at the HW level we want to change the context entry or ARM CD in my
>> case for a specific device. But on other hand, at the logical level,
>> I understand the iommu_domain is representing a set of translation
>> config & page tables shared by all the devices within the domain
>> (hope this is fundamentally correct ?!). So to me we can't change the
>> device translation setup without changing the whole iommu_device setup
>> otherwise this would mean this device has a translation configuration
>> that is not consistent anymore with the other devices in the same
>> domain. Is that correct? So can't we only keep the iommu_domain arg?
>>
> I agree with you on your understanding of HW and logical level. I think
> there is a new twist to the definition of domain introduced by having
> PASID and vSVA. Up until now, domain only means 2nd level mapping. In
> that sense, bind guest PASID table does not alter domain. For VT-d 2.5
> spec. implementation of the bind_pasid_table(), we needed some per
> device data, also flags such as indication for IO page fault handling.
> 
> Anyway, for the new VT-d 3.0 spec. we no longer need this API. In
> stead, I will introduce bind_guest_pasid() API, where per device PASID
> table is allocated by the host.

So what is the exact state of this series? Is it outdated as you don't
target VT-d 2.5 anymore? Will you keep the rest of the API?

Thanks

Eric
> 
>>> +{
>>> +	if (unlikely(!domain->ops->bind_pasid_table))
>>> +		return -ENODEV;
>>> +
>>> +	return domain->ops->bind_pasid_table(domain, dev,
>>> pasidt_binfo); +}
>>> +EXPORT_SYMBOL_GPL(iommu_bind_pasid_table);
>>> +
>>> +void iommu_unbind_pasid_table(struct iommu_domain *domain, struct
>>> device *dev) +{
>>> +	if (unlikely(!domain->ops->unbind_pasid_table))
>>> +		return;
>>> +
>>> +	domain->ops->unbind_pasid_table(domain, dev);
>>> +}
>>> +EXPORT_SYMBOL_GPL(iommu_unbind_pasid_table);
>>> +
>>>  static void __iommu_detach_device(struct iommu_domain *domain,
>>>  				  struct device *dev)
>>>  {
>>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>>> index 19938ee..5199ca4 100644
>>> --- a/include/linux/iommu.h
>>> +++ b/include/linux/iommu.h
>>> @@ -25,6 +25,7 @@
>>>  #include <linux/errno.h>
>>>  #include <linux/err.h>
>>>  #include <linux/of.h>
>>> +#include <uapi/linux/iommu.h>
>>>  
>>>  #define IOMMU_READ	(1 << 0)
>>>  #define IOMMU_WRITE	(1 << 1)
>>> @@ -187,6 +188,8 @@ struct iommu_resv_region {
>>>   * @domain_get_windows: Return the number of windows for a domain
>>>   * @of_xlate: add OF master IDs to iommu grouping
>>>   * @pgsize_bitmap: bitmap of all possible supported page sizes
>>> + * @bind_pasid_table: bind pasid table pointer for guest SVM
>>> + * @unbind_pasid_table: unbind pasid table pointer and restore
>>> defaults */
>>>  struct iommu_ops {
>>>  	bool (*capable)(enum iommu_cap);
>>> @@ -233,8 +236,14 @@ struct iommu_ops {
>>>  	u32 (*domain_get_windows)(struct iommu_domain *domain);
>>>  
>>>  	int (*of_xlate)(struct device *dev, struct of_phandle_args
>>> *args); +
>>>  	bool (*is_attach_deferred)(struct iommu_domain *domain,
>>> struct device *dev); 
>>> +	int (*bind_pasid_table)(struct iommu_domain *domain,
>>> struct device *dev,
>>> +				struct pasid_table_config
>>> *pasidt_binfo);
>>> +	void (*unbind_pasid_table)(struct iommu_domain *domain,
>>> +				struct device *dev);
>>> +
>>>  	unsigned long pgsize_bitmap;
>>>  };
>>>  
>>> @@ -296,6 +305,10 @@ extern int iommu_attach_device(struct
>>> iommu_domain *domain, struct device *dev);
>>>  extern void iommu_detach_device(struct iommu_domain *domain,
>>>  				struct device *dev);
>>> +extern int iommu_bind_pasid_table(struct iommu_domain *domain,
>>> +		struct device *dev, struct pasid_table_config
>>> *pasidt_binfo); +extern void iommu_unbind_pasid_table(struct
>>> iommu_domain *domain,
>>> +				struct device *dev);
>>>  extern struct iommu_domain *iommu_get_domain_for_dev(struct device
>>> *dev); extern int iommu_map(struct iommu_domain *domain, unsigned
>>> long iova, phys_addr_t paddr, size_t size, int prot);
>>> @@ -696,6 +709,17 @@ const struct iommu_ops
>>> *iommu_ops_from_fwnode(struct fwnode_handle *fwnode) return NULL;
>>>  }
>>>  
>>> +static inline
>>> +int iommu_bind_pasid_table(struct iommu_domain *domain, struct
>>> device *dev,
>>> +			struct pasid_table_config *pasidt_binfo)
>>> +{
>>> +	return -ENODEV;
>>> +}
>>> +static inline
>>> +void iommu_unbind_pasid_table(struct iommu_domain *domain, struct
>>> device *dev) +{
>>> +}
>>> +
>>>  #endif /* CONFIG_IOMMU_API */
>>>  
>>>  #endif /* __LINUX_IOMMU_H */
>>> diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
>>> new file mode 100644
>>> index 0000000..cb2d625
>>> --- /dev/null
>>> +++ b/include/uapi/linux/iommu.h
>>> @@ -0,0 +1,33 @@
>>> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
>>> +/*
>>> + * IOMMU user API definitions
>>> + *
>>> + *
>>> + * This program is free software; you can redistribute it and/or
>>> modify
>>> + * it under the terms of the GNU General Public License version 2
>>> as
>>> + * published by the Free Software Foundation.
>>> + */
>>> +
>>> +#ifndef _UAPI_IOMMU_H
>>> +#define _UAPI_IOMMU_H
>>> +
>>> +#include <linux/types.h>
>>> +
>>> +/**
>>> + * PASID table data used to bind guest PASID table to the host
>>> IOMMU. This will
>>> + * enable guest managed first level page tables.
>>> + * @version: for future extensions and identification of the data
>>> format
>>> + * @bytes: size of this structure
>>> + * @base_ptr:	PASID table pointer
>>> + * @pasid_bits:	number of bits supported in the guest PASID
>>> table, must be less
>>> + *		or equal than the host supported PASID size.
>>> + */
>>> +struct pasid_table_config {
>>> +	__u32 version;
>>> +#define PASID_TABLE_CFG_VERSION_1 1
>>> +	__u32 bytes;
>>> +	__u64 base_ptr;
>>> +	__u8 pasid_bits;
>>> +};  
>> Don't we need to index all structs with iommu_ to protect the naming
>> spaces? Same comment on other patches impacting the uapi.
>>
> yeah, it would be better to use iommu_ prefix, i was thinking vfio also
> uses it and pasid itself is a industry standard.
>> A question about the alignment. Don't we need to be 64b aligned? VFIO
>> uapi structs are.
>>
> I am not sure about the benefit, this is not a HW interface nor on
> speed path.
>> Thanks
>>
>> Eric
>>> +
>>> +#endif /* _UAPI_IOMMU_H */
>>>   
> 
> [Jacob Pan]
> 
