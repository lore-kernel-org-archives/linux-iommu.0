From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2 03/40] iommu/sva: Manage process address spaces
Date: Thu, 6 Sep 2018 12:10:14 +0100
Message-ID: <ec209a7f-dfc4-c762-3ad8-491eeb8e8744@arm.com>
References: <20180511190641.23008-1-jean-philippe.brucker@arm.com>
	<20180511190641.23008-4-jean-philippe.brucker@arm.com>
	<d785ec89-6743-d0f1-1a7f-85599a033e5b@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <d785ec89-6743-d0f1-1a7f-85599a033e5b-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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
To: Auger Eric <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org
Cc: xieyisheng1-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, ilias.apalodimas-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, rfranz-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, rgummal-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, liubo95-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, christian.koenig-5C7GfCeVMHo@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 05/09/2018 13:14, Auger Eric wrote:
>> +static struct io_mm *
>> +io_mm_alloc(struct iommu_domain *domain, struct device *dev,
>> +	    struct mm_struct *mm, unsigned long flags)
>> +{
>> +	int ret;
>> +	int pasid;
>> +	struct io_mm *io_mm;
>> +	struct iommu_sva_param *param = dev->iommu_param->sva_param;
>> +
> don't you need to check param != NULL and flags are compatible with
> those set at init?

It would be redundant, parameters are already checked by bind().
Following your comment below I think this function should also be called
under iommu_param->lock

>> +	idr_preload(GFP_KERNEL);
>> +	spin_lock(&iommu_sva_lock);
>> +	pasid = idr_alloc(&iommu_pasid_idr, io_mm, param->min_pasid,
>> +			  param->max_pasid + 1, GFP_ATOMIC);
> isn't it param->max_pasid - 1?

max_pasid is the last allocatable PASID, and the 'end' parameter of
idr_alloc is exclusive, so this needs to be max_pasid + 1.

>> +static int io_mm_attach(struct iommu_domain *domain, struct device *dev,
>> +			struct io_mm *io_mm, void *drvdata)
>> +{
>> +	int ret;
>> +	bool attach_domain = true;
>> +	int pasid = io_mm->pasid;
>> +	struct iommu_bond *bond, *tmp;
>> +	struct iommu_sva_param *param = dev->iommu_param->sva_param;
>> +
>> +	if (!domain->ops->mm_attach || !domain->ops->mm_detach)
>> +		return -ENODEV;
> don't you need to check param is not NULL?

As mm_alloc, this is called by bind() which already performs argument checks

>> +
>> +	if (pasid > param->max_pasid || pasid < param->min_pasid)
> pasid >= param->max_pasid ?

max_pasid is inclusive

>> +	ret = domain->ops->mm_attach(domain, dev, io_mm, attach_domain);
> the fact the mm_attach/detach() must not sleep may be documented in the
> API doc.

Ok

>>  int __iommu_sva_bind_device(struct device *dev, struct mm_struct *mm,
>>  			    int *pasid, unsigned long flags, void *drvdata)
>>  {
>> -	return -ENOSYS; /* TODO */
>> +	int i, ret = 0;
>> +	struct io_mm *io_mm = NULL;
>> +	struct iommu_domain *domain;
>> +	struct iommu_bond *bond = NULL, *tmp;
>> +	struct iommu_sva_param *param = dev->iommu_param->sva_param;
>> +
>> +	domain = iommu_get_domain_for_dev(dev);
>> +	if (!domain)
>> +		return -EINVAL;
>> +
>> +	/*
>> +	 * The device driver does not call sva_device_init/shutdown and
>> +	 * bind/unbind concurrently, so no need to take the param lock.
>> +	 */
> what does guarantee that?

The doc for iommu_sva_bind_device mandates that iommu_sva_device_init()
is called before bind(), but nothing is said about unbind and shutdown.
I think that was just based on the assumption that the device driver
doesn't have any reason to call unbind and shutdown concurrently, but
taking the lock here and in unbind is probably safer.

>> +	ret = io_mm_attach(domain, dev, io_mm, drvdata);
>> +	if (ret)
>> +		io_mm_put(io_mm);
> dont't you want to free the io_mm if just allocated?

We do: if the io_mm has just been allocated, it has a single reference
so io_mm_put frees it.

>> + * @mm_attach: attach io_mm to a device. Install PASID entry if necessary
>> + * @mm_detach: detach io_mm from a device. Remove PASID entry and
>> + *             flush associated TLB entries.
> if necessary too?

Right

Thanks,
Jean
