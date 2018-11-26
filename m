From: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v4 4/8] iommu/vt-d: Attach/detach domains in auxiliary mode
Date: Mon, 26 Nov 2018 10:37:02 +0800
Message-ID: <4d864fbe-e07f-24fd-0e04-aff8083921c9@linux.intel.com>
References: <20181105073408.21815-1-baolu.lu@linux.intel.com>
	<20181105073408.21815-5-baolu.lu@linux.intel.com>
	<d714fb14-6217-f9c7-a5b2-2fc67e4bcd4c@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <d714fb14-6217-f9c7-a5b2-2fc67e4bcd4c-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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
To: Auger Eric <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Kirti Wankhede <kwankhede-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, tiwei.bie-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>, sanjay.k.kumar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, yi.y.sun-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi,

On 11/23/18 6:49 PM, Auger Eric wrote:
> Hi Lu,
> 
> On 11/5/18 8:34 AM, Lu Baolu wrote:
>> When multiple domains per device has been enabled by the
>> device driver, the device will tag the default PASID for
>> the domain to all DMA traffics out of the subset of this
>> device; and the IOMMU should translate the DMA requests
>> in PASID granularity.
>>
>> This extends the intel_iommu_attach/detach_device() ops
>> to support managing PASID granular translation structures
>> when the device driver has enabled multiple domains per
>> device.
>>
>> Cc: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>> Cc: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>> Cc: Kevin Tian <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>> Signed-off-by: Sanjay Kumar <sanjay.k.kumar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>> Signed-off-by: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>> Signed-off-by: Liu Yi L <yi.l.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>> ---
>>   drivers/iommu/intel-iommu.c | 192 +++++++++++++++++++++++++++++++-----
>>   include/linux/intel-iommu.h |  10 ++
>>   2 files changed, 180 insertions(+), 22 deletions(-)
>>
>> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
>> index 2c86ac71c774..a61b25ad0d3b 100644
>> --- a/drivers/iommu/intel-iommu.c
>> +++ b/drivers/iommu/intel-iommu.c
>> @@ -2477,6 +2477,7 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
>>   	info->iommu = iommu;
>>   	info->pasid_table = NULL;
>>   	info->auxd_enabled = 0;
>> +	INIT_LIST_HEAD(&info->auxiliary_domains);
>>   
>>   	if (dev && dev_is_pci(dev)) {
>>   		struct pci_dev *pdev = to_pci_dev(info->dev);
>> @@ -5010,35 +5011,134 @@ static void intel_iommu_domain_free(struct iommu_domain *domain)
>>   	domain_exit(to_dmar_domain(domain));
>>   }
>>   
>> -static int intel_iommu_attach_device(struct iommu_domain *domain,
>> -				     struct device *dev)
>> +/*
>> + * Check whether a @domain will be attached to the @dev in the
>> + * auxiliary mode.
>> + */
>> +static inline bool
>> +is_device_attach_aux_domain(struct device *dev, struct iommu_domain *domain)
>>   {
>> -	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
>> -	struct intel_iommu *iommu;
>> -	int addr_width;
>> -	u8 bus, devfn;
>> +	struct device_domain_info *info = dev->archdata.iommu;
>>   
>> -	if (device_is_rmrr_locked(dev)) {
>> -		dev_warn(dev, "Device is ineligible for IOMMU domain attach due to platform RMRR requirement.  Contact your platform vendor.\n");
>> -		return -EPERM;
>> -	}
>> +	return info && info->auxd_enabled &&
>> +			domain->type == IOMMU_DOMAIN_UNMANAGED;
>> +}
>>   
>> -	/* normally dev is not mapped */
>> -	if (unlikely(domain_context_mapped(dev))) {
>> -		struct dmar_domain *old_domain;
>> +static void auxiliary_link_device(struct dmar_domain *domain,
>> +				  struct device *dev)
>> +{
>> +	struct device_domain_info *info = dev->archdata.iommu;
>>   
>> -		old_domain = find_domain(dev);
>> -		if (old_domain) {
>> -			rcu_read_lock();
>> -			dmar_remove_one_dev_info(old_domain, dev);
>> -			rcu_read_unlock();
>> +	assert_spin_locked(&device_domain_lock);
>> +	if (WARN_ON(!info))
>> +		return;
>>   
>> -			if (!domain_type_is_vm_or_si(old_domain) &&
>> -			     list_empty(&old_domain->devices))
>> -				domain_exit(old_domain);
>> +	domain->auxd_refcnt++;
>> +	list_add(&domain->auxd, &info->auxiliary_domains);
>> +}
>> +
>> +static void auxiliary_unlink_device(struct dmar_domain *domain,
>> +				    struct device *dev)
>> +{
>> +	struct device_domain_info *info = dev->archdata.iommu;
>> +
>> +	assert_spin_locked(&device_domain_lock);
>> +	if (WARN_ON(!info))
>> +		return;
>> +
>> +	list_del(&domain->auxd);
>> +	domain->auxd_refcnt--;
>> +
>> +	if (!domain->auxd_refcnt && domain->default_pasid > 0)
>> +		intel_pasid_free_id(domain->default_pasid);
>> +}
>> +
>> +static int domain_add_dev_auxd(struct dmar_domain *domain,
>> +			       struct device *dev)
>> +{
>> +	int ret;
>> +	u8 bus, devfn;
>> +	unsigned long flags;
>> +	struct intel_iommu *iommu;
>> +
>> +	iommu = device_to_iommu(dev, &bus, &devfn);
>> +	if (!iommu)
>> +		return -ENODEV;
>> +
>> +	spin_lock_irqsave(&device_domain_lock, flags);
>> +	if (domain->default_pasid <= 0) {
>> +		domain->default_pasid = intel_pasid_alloc_id(domain, PASID_MIN,
>> +				pci_max_pasids(to_pci_dev(dev)), GFP_ATOMIC);
>> +		if (domain->default_pasid < 0) {
>> +			pr_err("Can't allocate default pasid\n");
>> +			ret = -ENODEV;
>> +			goto pasid_failed;
>>   		}
>>   	}
>>   
>> +	spin_lock(&iommu->lock);
> You may comment your nested lock policy somewhere.

Yes. I will add below comments.

/*
  * iommu->lock must be held to attach domain to iommu and setup the
  * pasid entry for second level translation.
  */

>> +	ret = domain_attach_iommu(domain, iommu);
>> +	if (ret)
>> +		goto attach_failed;
>> +
>> +	/* Setup the PASID entry for mediated devices: */
>> +	ret = intel_pasid_setup_second_level(iommu, domain, dev,
>> +					     domain->default_pasid);
>> +	if (ret)
>> +		goto table_failed;
>> +	spin_unlock(&iommu->lock);
>> +
>> +	auxiliary_link_device(domain, dev);
>> +
>> +	spin_unlock_irqrestore(&device_domain_lock, flags);
>> +
>> +	return 0;
>> +
>> +table_failed:
>> +	domain_detach_iommu(domain, iommu);
>> +attach_failed:
>> +	spin_unlock(&iommu->lock);
>> +	if (!domain->auxd_refcnt && domain->default_pasid > 0)
>> +		intel_pasid_free_id(domain->default_pasid);
>> +pasid_failed:
>> +	spin_unlock_irqrestore(&device_domain_lock, flags);
>> +
>> +	return ret;
>> +}
>> +
>> +static void domain_remove_dev_aux(struct dmar_domain *domain,
>> +				  struct device *dev)
>> +{
>> +	struct device_domain_info *info;
>> +	struct intel_iommu *iommu;
>> +	unsigned long flags;
>> +
>> +	if (!is_device_attach_aux_domain(dev, &domain->domain))
>> +		return;
>> +
>> +	spin_lock_irqsave(&device_domain_lock, flags);
>> +	info = dev->archdata.iommu;
>> +	iommu = info->iommu;
>> +
>> +	intel_pasid_tear_down_entry(iommu, dev, domain->default_pasid);
>> +
>> +	auxiliary_unlink_device(domain, dev);
>> +
>> +	spin_lock(&iommu->lock);
>> +	domain_detach_iommu(domain, iommu);
>> +	spin_unlock(&iommu->lock);
>> +
>> +	spin_unlock_irqrestore(&device_domain_lock, flags);
>> +}
>> +
>> +static int __intel_iommu_attach_device(struct iommu_domain *domain,
>> +				       struct device *dev)
>> +{
> Maybe introducing __intel_iommu_attach_device in a patch prior to that
> one would help the review.

Yes. Will use a separated patch to introduce this helper.

>> +	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
>> +	struct intel_iommu *iommu;
>> +	int addr_width;
>> +	u8 bus, devfn;
>> +
>>   	iommu = device_to_iommu(dev, &bus, &devfn);
>>   	if (!iommu)
>>   		return -ENODEV;
>> @@ -5071,7 +5171,47 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
>>   		dmar_domain->agaw--;
>>   	}
>>   
>> -	return domain_add_dev_info(dmar_domain, dev);
>> +	if (is_device_attach_aux_domain(dev, domain))
>> +		return domain_add_dev_auxd(dmar_domain, dev);
> why not putting this directly  into intel_iommu_attach_device_aux()?
>> +	else
>> +		return domain_add_dev_info(dmar_domain, dev);
> and this into intel_iommu_attach_device() as
> __intel_iommu_attach_device() is the common part now?

Good suggestion.

>> +}
>> +
>> +static int intel_iommu_attach_device(struct iommu_domain *domain,
>> +				     struct device *dev)
>> +{
>> +	if (device_is_rmrr_locked(dev)) {
>> +		dev_warn(dev, "Device is ineligible for IOMMU domain attach due to platform RMRR requirement.  Contact your platform vendor.\n");
>> +		return -EPERM;
>> +	}
> shouldn't we test this in the common part (ie. in
> __intel_iommu_attach_device). Don't RMRR also impact aux domains ?

RMRR is only for Request ID based DMA translation. Aux domain uses
pasid-granular translation, hence should not be impacted by RMRR.

Furthermore, as far as I know, RMRR only used for legacy devices and
should never be used with modern devices.

>> +
>> +	if (is_device_attach_aux_domain(dev, domain))
>> +		return -EPERM;
>> +
>> +	/* normally dev is not mapped */
>> +	if (unlikely(domain_context_mapped(dev))) {
>> +		struct dmar_domain *old_domain;
>> +
>> +		old_domain = find_domain(dev);
>> +		if (old_domain) {
>> +			rcu_read_lock();
>> +			dmar_remove_one_dev_info(old_domain, dev);
>> +			rcu_read_unlock();
>> +
>> +			if (!domain_type_is_vm_or_si(old_domain) &&
>> +			    list_empty(&old_domain->devices))
>> +				domain_exit(old_domain);
>> +		}
>> +	}
>> +
>> +	return __intel_iommu_attach_device(domain, dev);
>> +}
>> +
>> +static int intel_iommu_attach_device_aux(struct iommu_domain *domain,
>> +					 struct device *dev)
>> +{
>> +	return is_device_attach_aux_domain(dev, domain) ?
>> +			__intel_iommu_attach_device(domain, dev) : -EPERM;
>>   }
>>   
>>   static void intel_iommu_detach_device(struct iommu_domain *domain,
>> @@ -5080,6 +5220,12 @@ static void intel_iommu_detach_device(struct iommu_domain *domain,
>>   	dmar_remove_one_dev_info(to_dmar_domain(domain), dev);
>>   }
>>   
>> +static void intel_iommu_detach_device_aux(struct iommu_domain *domain,
>> +					  struct device *dev)
>> +{
>> +	domain_remove_dev_aux(to_dmar_domain(domain), dev);
>> +}
>> +
>>   static int intel_iommu_map(struct iommu_domain *domain,
>>   			   unsigned long iova, phys_addr_t hpa,
>>   			   size_t size, int iommu_prot)
>> @@ -5436,6 +5582,8 @@ const struct iommu_ops intel_iommu_ops = {
>>   	.domain_free		= intel_iommu_domain_free,
>>   	.attach_dev		= intel_iommu_attach_device,
>>   	.detach_dev		= intel_iommu_detach_device,
>> +	.attach_dev_aux		= intel_iommu_attach_device_aux,
>> +	.detach_dev_aux		= intel_iommu_detach_device_aux,
>>   	.map			= intel_iommu_map,
>>   	.unmap			= intel_iommu_unmap,
>>   	.iova_to_phys		= intel_iommu_iova_to_phys,
>> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
>> index 6b198e13e75e..678c7fb05e74 100644
>> --- a/include/linux/intel-iommu.h
>> +++ b/include/linux/intel-iommu.h
>> @@ -473,9 +473,11 @@ struct dmar_domain {
>>   					/* Domain ids per IOMMU. Use u16 since
>>   					 * domain ids are 16 bit wide according
>>   					 * to VT-d spec, section 9.3 */
>> +	unsigned int	auxd_refcnt;	/* Refcount of auxiliary attaching */
>>   
>>   	bool has_iotlb_device;
>>   	struct list_head devices;	/* all devices' list */
>> +	struct list_head auxd;		/* link to device's auxiliary list */
>>   	struct iova_domain iovad;	/* iova's that belong to this domain */
>>   
>>   	struct dma_pte	*pgd;		/* virtual address */
>> @@ -494,6 +496,11 @@ struct dmar_domain {
>>   					   2 == 1GiB, 3 == 512GiB, 4 == 1TiB */
>>   	u64		max_addr;	/* maximum mapped address */
>>   
>> +	int		default_pasid;	/*
>> +					 * The default pasid used for non-SVM
>> +					 * traffic on mediated devices.
>> +					 */
>> +
>>   	struct iommu_domain domain;	/* generic domain data structure for
>>   					   iommu core */
>>   };
>> @@ -543,6 +550,9 @@ struct device_domain_info {
>>   	struct list_head link;	/* link to domain siblings */
>>   	struct list_head global; /* link to global list */
>>   	struct list_head table;	/* link to pasid table */
>> +	struct list_head auxiliary_domains; /* auxiliary domains
>> +					     * attached to this device
>> +					     */
>>   	u8 bus;			/* PCI bus number */
>>   	u8 devfn;		/* PCI devfn number */
>>   	u16 pfsid;		/* SRIOV physical function source ID */
>>
> Thanks
> 
> Eric
> 

Best regards,
Lu Baolu
