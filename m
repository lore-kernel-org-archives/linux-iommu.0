From: Auger Eric <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v10 7/9] irqchip/gicv3-its: register the MSI global
	doorbell
Date: Sun, 19 Jun 2016 18:11:47 +0200
Message-ID: <eabd5d27-f19d-b641-2db6-775830bffc50@redhat.com>
References: <1465315288-5931-1-git-send-email-eric.auger@redhat.com>
	<1465315288-5931-8-git-send-email-eric.auger@redhat.com>
	<20160617163327.GA26522@e106794-lin.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20160617163327.GA26522-lfHAr0XZR/FyySVAYrpuPyZi+YwRKgec@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jean-Philippe Brucker <Jean-Philippe.Brucker-5wv7dgnIgG8@public.gmane.org>
Cc: yehuday-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, julien.grall-5wv7dgnIgG8@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, p.fedin-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, eric.auger.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Jean-Philippe,

On 17/06/2016 18:33, Jean-Philippe Brucker wrote:
> Hi Eric,
> 
> On Tue, Jun 07, 2016 at 04:01:26PM +0000, Eric Auger wrote:
>> This patch adds the registration of the MSI global doorbell in
>> gicv3-its driver.
>>
>> This will allow the msi layer to iommu_map this doorbell when
>> requested.
>>
>> Signed-off-by: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>> ---
>>  drivers/irqchip/irq-gic-v3-its.c | 14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>>
>> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
>> index 5eb1f9e..ed9dfce 100644
>> --- a/drivers/irqchip/irq-gic-v3-its.c
>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>> @@ -29,6 +29,8 @@
>>  #include <linux/of_platform.h>
>>  #include <linux/percpu.h>
>>  #include <linux/slab.h>
>> +#include <linux/iommu.h>
>> +#include <linux/msi-doorbell.h>
>>  
>>  #include <linux/irqchip.h>
>>  #include <linux/irqchip/arm-gic-v3.h>
>> @@ -1607,6 +1609,7 @@ static int __init its_probe(struct device_node *node,
>>  
>>  	if (of_property_read_bool(node, "msi-controller")) {
>>  		struct msi_domain_info *info;
>> +		phys_addr_t translater;
>>  
>>  		info = kzalloc(sizeof(*info), GFP_KERNEL);
>>  		if (!info) {
>> @@ -1614,10 +1617,21 @@ static int __init its_probe(struct device_node *node,
>>  			goto out_free_tables;
>>  		}
>>  
>> +		translater = its->phys_base + GITS_TRANSLATER;
>> +		err = msi_doorbell_register_global(its, translater,
>> +						sizeof(u32),
>> +						IOMMU_WRITE | IOMMU_MMIO, true);
> 
> This doesn't work :(

Sorry to hear that.

Thank you for testing with ITS. As mentioned in the part 3 cover letter,
I could not test assignment with this MSI controller; I now have access
to it so I am going to test it from next release onwards.
> 
> First we have its_probe registering the global mapping with
> doorbell->chip_data = its, which is a pointer to an its_node structure.
> 
> But when enabling MSIs for a device, its_irq_domain_alloc puts a pointer
> to an *its_device* into irq_data->chip_data. This seems to be a
> per-device structure, allocated by its_msi_prepare.
Hum OK, I missed the fact the chip_data was overwritten on
its_irq_domain_alloc. I will investigate what we have as other alternatives.

Thank you for the time spent on debugging that ;-)

Best Regards

Eric


> 
> The following call to msi_doorbell_lookup won't ever succeed, because it
> will compare its_node to its_device. I can't figure out how to fix it
> cleanly at the moment.
> 
> Jean-Philippe
> 
>> +		if (err)  {
>> +			kfree(info);
>> +			goto out_free_tables;
>> +		}
>> +
>> +
>>  		inner_domain = irq_domain_add_tree(node, &its_domain_ops, its);
>>  		if (!inner_domain) {
>>  			err = -ENOMEM;
>>  			kfree(info);
>> +			msi_doorbell_unregister(its);
>>  			goto out_free_tables;
>>  		}
>>  
>> -- 
>> 1.9.1
>>
