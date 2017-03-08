From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH V8 01/11] iommu/of: Refactor of_iommu_configure() for
	error handling
Date: Wed, 8 Mar 2017 19:28:48 +0000
Message-ID: <76844d3e-ae7a-5113-1a76-18312e9f51ce@arm.com>
References: <1486136933-20328-1-git-send-email-sricharan@codeaurora.org>
	<1486136933-20328-2-git-send-email-sricharan@codeaurora.org>
	<8701bfbe-e52e-0e26-2a71-f5f81684de70@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <8701bfbe-e52e-0e26-2a71-f5f81684de70-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>, Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org, hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 08/03/17 18:58, Jean-Philippe Brucker wrote:
[...]
>>  static const struct iommu_ops
>> -*of_pci_iommu_configure(struct pci_dev *pdev, struct device_node *bridge_np)
>> +*of_pci_iommu_init(struct pci_dev *pdev, struct device_node *bridge_np)
>>  {
>>  	const struct iommu_ops *ops;
>>  	struct of_phandle_args iommu_spec;
>> +	int err;
>>  
>>  	/*
>>  	 * Start by tracing the RID alias down the PCI topology as
>> @@ -123,56 +146,56 @@ static int __get_pci_rid(struct pci_dev *pdev, u16 alias, void *data)
>>  	 * bus into the system beyond, and which IOMMU it ends up at.
>>  	 */
>>  	iommu_spec.np = NULL;
>> -	if (of_pci_map_rid(bridge_np, iommu_spec.args[0], "iommu-map",
>> -			   "iommu-map-mask", &iommu_spec.np, iommu_spec.args))
>> -		return NULL;
>> +	err = of_pci_map_rid(bridge_np, iommu_spec.args[0], "iommu-map",
>> +			     "iommu-map-mask", &iommu_spec.np,
>> +			     iommu_spec.args);
>> +	if (err)
>> +		return ERR_PTR(err);
> 
> This change doesn't work with of_pci_map_rid when the PCI RC isn't behind
> an IOMMU:
> 
>         map = of_get_property(np, map_name, &map_len);
>         if (!map) {
>                 if (target)
>                         return -ENODEV;
>                 /* Otherwise, no map implies no translation */
>                 *id_out = rid;
>                 return 0;
>         }
> 
> Previously with no iommu-map, we returned -ENODEV but it was discarded by
> of_pci_iommu_configure. Now it is propagated and the whole device probing
> fails. Instead, maybe of_pci_map_rid should always return 0 if no
> iommu-map, and the caller should check if *target is still NULL?

Ah yes, Tomasz had found breakages with the "mmu-masters" binding
before, and I'd already pushed out a fixup for this one[1], but I forgot
that that discussion was all off-list (out of diplomatic concern that
the breakage might have been intentional - it wasn't, honest!)

Now that rc1 is out I should re-do that branch with v8 of this series
plus the fixups folded in, unless Sricharan beats me to it.

Thanks for the reminder,
Robin.

[1]:http://www.linux-arm.org/git?p=linux-rm.git;a=commitdiff;h=0049a34e523506813995c05766f5e2c16d616354

> 
> Thanks,
> Jean-Philippe
