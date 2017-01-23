From: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v9 08/18] iommu/vt-d: Implement reserved region get/put
 callbacks
Date: Mon, 23 Jan 2017 12:57:33 +0100
Message-ID: <baddc4b4-2ef4-e44c-bed3-8e073b3992c1@redhat.com>
References: <1484859483-2866-1-git-send-email-eric.auger@redhat.com>
 <1484859483-2866-9-git-send-email-eric.auger@redhat.com>
 <20170123114624.GH4622@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170123114624.GH4622@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: eric.auger.pro@gmail.com, christoffer.dall@linaro.org, marc.zyngier@arm.com, robin.murphy@arm.com, alex.williamson@redhat.com, joro@8bytes.org, tglx@linutronix.de, jason@lakedaemon.net, linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org, drjones@redhat.com, linux-kernel@vger.kernel.org, pranav.sawargaonkar@gmail.com, iommu@lists.linux-foundation.org, punit.agrawal@arm.com, diana.craciun@nxp.com, gpkulkarni@gmail.com, shankerd@codeaurora.org, bharat.bhushan@nxp.com, geethasowjanya.akula@gmail.com, dwmw2@infradead.org
List-Id: iommu@lists.linux-foundation.org

Hi Will,

On 23/01/2017 12:46, Will Deacon wrote:
> [adding David Woodhouse, since he maintains this driver]

Thank you for adding David to the list.

Whoever is likely to pull this, please let me know if I need to respin
to add missed Will's Acked-by.

Thanks

Eric
> 
> Will
> 
> On Thu, Jan 19, 2017 at 08:57:53PM +0000, Eric Auger wrote:
>> This patch registers the [FEE0_0000h - FEF0_000h] 1MB MSI
>> range as a reserved region and RMRR regions as direct regions.
>>
>> This will allow to report those reserved regions in the
>> iommu-group sysfs.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>
>> ---
>> v6 -> v7:
>> - report RMRR regions as direct regions
>> - Due to the usage of rcu_read_lock, the rmrr reserved region
>>   allocation is done on rmrr allocation.
>> - use IOMMU_RESV_RESERVED
>>
>> RFCv2 -> RFCv3:
>> - use get/put_resv_region callbacks.
>>
>> RFC v1 -> RFC v2:
>> - fix intel_iommu_add_reserved_regions name
>> - use IOAPIC_RANGE_START and IOAPIC_RANGE_END defines
>> - return if the MSI region is already registered;
>> ---
>>  drivers/iommu/intel-iommu.c | 92 ++++++++++++++++++++++++++++++++++++---------
>>  1 file changed, 74 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
>> index 8a18525..bce59a5 100644
>> --- a/drivers/iommu/intel-iommu.c
>> +++ b/drivers/iommu/intel-iommu.c
>> @@ -440,6 +440,7 @@ struct dmar_rmrr_unit {
>>  	u64	end_address;		/* reserved end address */
>>  	struct dmar_dev_scope *devices;	/* target devices */
>>  	int	devices_cnt;		/* target device count */
>> +	struct iommu_resv_region *resv; /* reserved region handle */
>>  };
>>  
>>  struct dmar_atsr_unit {
>> @@ -4246,27 +4247,40 @@ static inline void init_iommu_pm_ops(void) {}
>>  int __init dmar_parse_one_rmrr(struct acpi_dmar_header *header, void *arg)
>>  {
>>  	struct acpi_dmar_reserved_memory *rmrr;
>> +	int prot = DMA_PTE_READ|DMA_PTE_WRITE;
>>  	struct dmar_rmrr_unit *rmrru;
>> +	size_t length;
>>  
>>  	rmrru = kzalloc(sizeof(*rmrru), GFP_KERNEL);
>>  	if (!rmrru)
>> -		return -ENOMEM;
>> +		goto out;
>>  
>>  	rmrru->hdr = header;
>>  	rmrr = (struct acpi_dmar_reserved_memory *)header;
>>  	rmrru->base_address = rmrr->base_address;
>>  	rmrru->end_address = rmrr->end_address;
>> +
>> +	length = rmrr->end_address - rmrr->base_address + 1;
>> +	rmrru->resv = iommu_alloc_resv_region(rmrr->base_address, length, prot,
>> +					      IOMMU_RESV_DIRECT);
>> +	if (!rmrru->resv)
>> +		goto free_rmrru;
>> +
>>  	rmrru->devices = dmar_alloc_dev_scope((void *)(rmrr + 1),
>>  				((void *)rmrr) + rmrr->header.length,
>>  				&rmrru->devices_cnt);
>> -	if (rmrru->devices_cnt && rmrru->devices == NULL) {
>> -		kfree(rmrru);
>> -		return -ENOMEM;
>> -	}
>> +	if (rmrru->devices_cnt && rmrru->devices == NULL)
>> +		goto free_all;
>>  
>>  	list_add(&rmrru->list, &dmar_rmrr_units);
>>  
>>  	return 0;
>> +free_all:
>> +	kfree(rmrru->resv);
>> +free_rmrru:
>> +	kfree(rmrru);
>> +out:
>> +	return -ENOMEM;
>>  }
>>  
>>  static struct dmar_atsr_unit *dmar_find_atsr(struct acpi_dmar_atsr *atsr)
>> @@ -4480,6 +4494,7 @@ static void intel_iommu_free_dmars(void)
>>  	list_for_each_entry_safe(rmrru, rmrr_n, &dmar_rmrr_units, list) {
>>  		list_del(&rmrru->list);
>>  		dmar_free_dev_scope(&rmrru->devices, &rmrru->devices_cnt);
>> +		kfree(rmrru->resv);
>>  		kfree(rmrru);
>>  	}
>>  
>> @@ -5203,6 +5218,45 @@ static void intel_iommu_remove_device(struct device *dev)
>>  	iommu_device_unlink(iommu->iommu_dev, dev);
>>  }
>>  
>> +static void intel_iommu_get_resv_regions(struct device *device,
>> +					 struct list_head *head)
>> +{
>> +	struct iommu_resv_region *reg;
>> +	struct dmar_rmrr_unit *rmrr;
>> +	struct device *i_dev;
>> +	int i;
>> +
>> +	rcu_read_lock();
>> +	for_each_rmrr_units(rmrr) {
>> +		for_each_active_dev_scope(rmrr->devices, rmrr->devices_cnt,
>> +					  i, i_dev) {
>> +			if (i_dev != device)
>> +				continue;
>> +
>> +			list_add_tail(&rmrr->resv->list, head);
>> +		}
>> +	}
>> +	rcu_read_unlock();
>> +
>> +	reg = iommu_alloc_resv_region(IOAPIC_RANGE_START,
>> +				      IOAPIC_RANGE_END - IOAPIC_RANGE_START + 1,
>> +				      0, IOMMU_RESV_RESERVED);
>> +	if (!reg)
>> +		return;
>> +	list_add_tail(&reg->list, head);
>> +}
>> +
>> +static void intel_iommu_put_resv_regions(struct device *dev,
>> +					 struct list_head *head)
>> +{
>> +	struct iommu_resv_region *entry, *next;
>> +
>> +	list_for_each_entry_safe(entry, next, head, list) {
>> +		if (entry->type == IOMMU_RESV_RESERVED)
>> +			kfree(entry);
>> +	}
>> +}
>> +
>>  #ifdef CONFIG_INTEL_IOMMU_SVM
>>  #define MAX_NR_PASID_BITS (20)
>>  static inline unsigned long intel_iommu_get_pts(struct intel_iommu *iommu)
>> @@ -5333,19 +5387,21 @@ struct intel_iommu *intel_svm_device_to_iommu(struct device *dev)
>>  #endif /* CONFIG_INTEL_IOMMU_SVM */
>>  
>>  static const struct iommu_ops intel_iommu_ops = {
>> -	.capable	= intel_iommu_capable,
>> -	.domain_alloc	= intel_iommu_domain_alloc,
>> -	.domain_free	= intel_iommu_domain_free,
>> -	.attach_dev	= intel_iommu_attach_device,
>> -	.detach_dev	= intel_iommu_detach_device,
>> -	.map		= intel_iommu_map,
>> -	.unmap		= intel_iommu_unmap,
>> -	.map_sg		= default_iommu_map_sg,
>> -	.iova_to_phys	= intel_iommu_iova_to_phys,
>> -	.add_device	= intel_iommu_add_device,
>> -	.remove_device	= intel_iommu_remove_device,
>> -	.device_group   = pci_device_group,
>> -	.pgsize_bitmap	= INTEL_IOMMU_PGSIZES,
>> +	.capable		= intel_iommu_capable,
>> +	.domain_alloc		= intel_iommu_domain_alloc,
>> +	.domain_free		= intel_iommu_domain_free,
>> +	.attach_dev		= intel_iommu_attach_device,
>> +	.detach_dev		= intel_iommu_detach_device,
>> +	.map			= intel_iommu_map,
>> +	.unmap			= intel_iommu_unmap,
>> +	.map_sg			= default_iommu_map_sg,
>> +	.iova_to_phys		= intel_iommu_iova_to_phys,
>> +	.add_device		= intel_iommu_add_device,
>> +	.remove_device		= intel_iommu_remove_device,
>> +	.get_resv_regions	= intel_iommu_get_resv_regions,
>> +	.put_resv_regions	= intel_iommu_put_resv_regions,
>> +	.device_group		= pci_device_group,
>> +	.pgsize_bitmap		= INTEL_IOMMU_PGSIZES,
>>  };
>>  
>>  static void quirk_iommu_g4x_gfx(struct pci_dev *dev)
>> -- 
>> 1.9.1
>>
