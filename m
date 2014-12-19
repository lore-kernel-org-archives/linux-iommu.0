From: "Zhang, Yang Z" <yang.z.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [v3 06/26] iommu, x86: No need to migrating irq for VT-d
	Posted-Interrupts
Date: Fri, 19 Dec 2014 01:46:06 +0000
Message-ID: <A9667DDFB95DB7438FA9D7D576C3D87E0AC04E77@SHSMSX104.ccr.corp.intel.com>
References: <1418397300-10870-1-git-send-email-feng.wu@intel.com>
	<1418397300-10870-7-git-send-email-feng.wu@intel.com>
	<A9667DDFB95DB7438FA9D7D576C3D87E0AC0486D@SHSMSX104.ccr.corp.intel.com>
	<E959C4978C3B6342920538CF579893F00230A649@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <E959C4978C3B6342920538CF579893F00230A649-0J0gbvR4kTg/UvCtAeCM4rfspsVTdybXVpNB7YpNyf8@public.gmane.org>
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
To: "Wu, Feng" <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org" <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, "mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, "x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "gleb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <gleb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, "alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Wu, Feng wrote on 2014-12-19:
> 
> 
> Zhang, Yang Z wrote on 2014-12-18:
>> jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
>> Cc: eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
>> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Wu, Feng
>> Subject: RE: [v3 06/26] iommu, x86: No need to migrating irq for
>> VT-d Posted-Interrupts
>> 
>> Feng Wu wrote on 2014-12-12:
>>> We don't need to migrate the irqs for VT-d Posted-Interrupts here.
>>> When 'pst' is set in IRTE, the associated irq will be posted to
>>> guests instead of interrupt remapping. The destination of the
>>> interrupt is set in Posted-Interrupts Descriptor, and the
>>> migration happens during vCPU scheduling.
>>> 
>>> However, we still update the cached irte here, which can be used
>>> when changing back to remapping mode.
>>> 
>>> Signed-off-by: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>>> Reviewed-by: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>>> ---
>>>  drivers/iommu/intel_irq_remapping.c | 6 +++++-
>>>  1 file changed, 5 insertions(+), 1 deletion(-) diff --git
>>> a/drivers/iommu/intel_irq_remapping.c
>>> b/drivers/iommu/intel_irq_remapping.c index 48c2051..ab9057a
>>> 100644
>>> --- a/drivers/iommu/intel_irq_remapping.c +++
>>> b/drivers/iommu/intel_irq_remapping.c @@ -977,6 +977,7 @@
>>> intel_ir_set_affinity(struct irq_data *data, const struct cpumask
>>> *mask,  {
>>>  	struct intel_ir_data *ir_data = data->chip_data; 	struct irte *irte =
>>>  &ir_data->irte_entry; +	struct irte_pi *irte_pi = (struct irte_pi
>>>  *)irte; 	struct irq_cfg *cfg = irqd_cfg(data); 	struct irq_data *parent
>>>  = data->parent_data; 	int ret;
>>> @@ -991,7 +992,10 @@ intel_ir_set_affinity(struct irq_data *data,
>>> const struct cpumask *mask,
>>>  	 */
>>>  	irte->vector = cfg->vector;
>>>  	irte->dest_id = IRTE_DEST(cfg->dest_apicid);
>>> -	modify_irte(&ir_data->irq_2_iommu, irte);
>>> +
>>> +	/* We don't need to modify irte if the interrupt is for posting. */
>>> +	if (irte_pi->pst != 1)
>>> +		modify_irte(&ir_data->irq_2_iommu, irte);
>> 
>> What happens if user changes the IRQ affinity manually?
> 
> If the IRQ is posted, its affinity is controlled by guest (irq <--->
> vCPU <----> pCPU), it has no effect when host changes its affinity.

That's the problem: User is able to changes it in host but it never takes effect since it is actually controlled by guest. I guess it will break the IRQ balance too.

> 
> Thanks,
> Feng
> 
>> 
>>> 
>>>  	/*
>>>  	 * After this point, all the interrupts will start arriving
>> 
>> 
>> Best regards,
>> Yang
>>


Best regards,
Yang
