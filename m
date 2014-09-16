From: Yijing Wang <wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: Re: [Patch Part3 V5 1/8] iommu/vt-d: Introduce helper function
	dmar_walk_resources()
Date: Tue, 16 Sep 2014 16:08:26 +0800
Message-ID: <5417EFFA.3090804@huawei.com>
References: <1410487848-6027-1-git-send-email-jiang.liu@linux.intel.com>
	<1410487848-6027-2-git-send-email-jiang.liu@linux.intel.com>
	<5412B9EE.3070708@huawei.com> <5417E322.9090201@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <5417E322.9090201-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Yinghai Lu <yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Rafael J . Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-hotplug-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

>>>  #include "irq_remapping.h"
>>>  
>>> +typedef int (*dmar_res_handler_t)(struct acpi_dmar_header *, void *);
>>> +struct dmar_res_callback {
>>> +	dmar_res_handler_t	cb[ACPI_DMAR_TYPE_RESERVED];
>>> +	void			*arg[ACPI_DMAR_TYPE_RESERVED];
>>> +	bool			ignore_unhandled;
>>> +	bool			print_entry;
>>
>> Why do we need a switch to control print ?
> We will walk DMAR entries several times during hotplug and only
> want to print once.

Fine, thanks for your explanation.

> 
>>
>>> +};
>>> +
>>>  
>>> +static int dmar_walk_resources(struct acpi_dmar_header *start, size_t len,
>>> +			       struct dmar_res_callback *cb)
>>
>> The name dmar_walk_resources easily make people think this is related with I/O or memory resources.
>> Do you have a better idea of this ?  What about dmar_walk_remapping_entry() or dmar_walk_remapping_structure() ?
> Good suggestion, I like dmar_walk_remapping_entries().
>>
>>> +{
>>> +	int ret = 0;
>>> +	struct acpi_dmar_header *iter, *next;
>>> +	struct acpi_dmar_header *end = ((void *)start) + len;
>>> +
>>> +	for (iter = start; iter < end && ret == 0; iter = next) {
>>> +		next = (void *)iter + iter->length;
>>> +		if (iter->length == 0) {
>>> +			/* Avoid looping forever on bad ACPI tables */
>>> +			pr_debug(FW_BUG "Invalid 0-length structure\n");
>>
>> What about use pr_warn() instead of pr_debug(), pr_debug() default is off.
> It seems a common practice for BIOS engineer to mark the last entry with
> zero length. So it will be annoying if we generate this debug message
> on product kernel.

OK.

> 
>>
>>> +			break;
>>> +		} else if (next > end) {
>>> +			/* Avoid passing table end */
>>> +			pr_warn(FW_BUG "record passes table end\n");
>>> +			ret = -EINVAL;
>>> +			break;
>>> +		}
>>> +
>>> +		if (cb->print_entry)
>>> +			dmar_table_print_dmar_entry(iter);
>>> +
>>> +		if (iter->type >= ACPI_DMAR_TYPE_RESERVED) {
>>> +			/* continue for forward compatibility */
>>> +			pr_debug("Unknown DMAR structure type %d\n",
>>> +				 iter->type);
>>
>> Same as above.
> This is typically caused by new DMAR specification. It will also be
> annoying too if  we also generate this debug message on an newer
> hardware platform with older linux kernel.

OK.

> 
>>
>>> +		} else if (cb->cb[iter->type]) {
>>> +			ret = cb->cb[iter->type](iter, cb->arg[iter->type]);
>>> +		} else if (!cb->ignore_unhandled) {
>>> +			pr_warn("No handler for DMAR structure type %d\n",
