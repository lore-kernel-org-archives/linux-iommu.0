From: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [RFC PATCH 03/10] iommu/vt-d: Allocate groups for mediated devices
Date: Tue, 24 Jul 2018 10:22:19 +0800
Message-ID: <5B568D5B.5050606@linux.intel.com>
References: <1532239773-15325-1-git-send-email-baolu.lu@linux.intel.com>
	<1532239773-15325-4-git-send-email-baolu.lu@linux.intel.com>
	<A2975661238FB949B60364EF0F2C257439CA143E@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <A2975661238FB949B60364EF0F2C257439CA143E-0J0gbvR4kTg/UvCtAeCM4rfspsVTdybXVpNB7YpNyf8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Liu, Yi L" <yi.l.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Kirti Wankhede <kwankhede-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "Raj, Ashok" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Kumar,
	Sanjay K" <sanjay.k.kumar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Sun, Yi Y" <yi.y.sun-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Pan,
	Jacob jun" <jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi,

On 07/23/2018 12:44 PM, Liu, Yi L wrote:
>> From: Lu Baolu [mailto:baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org]
>> Sent: Sunday, July 22, 2018 2:09 PM
>>
>> With the Intel IOMMU supporting PASID granularity isolation and protection, a
>> mediated device could be isolated and protected by an IOMMU unit. We need to
>> allocate a new group instead of a PCI group.
> Existing vfio mdev framework also allocates an iommu group for mediate device.
>
> mdev_probe()
>   |_ mdev_attach_iommu()
>        |_ iommu_group_alloc()

When external components ask iommu to allocate a group for a device,
it will call pci_device_group in Intel IOMMU driver's @device_group
callback. In another word, current Intel IOMMU driver doesn't aware
the mediated device and treat all devices as PCI ones. This patch
extends the @device_group call back to make it aware of a mediated
device.

Best regards,
Lu Baolu

>
> IMHO, this patch actually do a wrapper to the group allocation API. The reason is: it
> is not necessary to apply the group allocation rules when the allocation is for mediated
> device. Instead, just allocate a new one for it. :)
>
> Thanks,
> Yi Liu
>> Cc: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>> Cc: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>> Cc: Kevin Tian <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>> Cc: Liu Yi L <yi.l.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>> Signed-off-by: Sanjay Kumar <sanjay.k.kumar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>> Signed-off-by: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>> ---
>>  drivers/iommu/intel-iommu.c | 13 ++++++++++++-
>>  1 file changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c index
>> 3ede34a..57ccfc4 100644
>> --- a/drivers/iommu/intel-iommu.c
>> +++ b/drivers/iommu/intel-iommu.c
>> @@ -5276,6 +5276,17 @@ static void intel_iommu_put_resv_regions(struct device
>> *dev,
>>  	}
>>  }
>>
>> +static struct iommu_group *intel_iommu_device_group(struct device *dev)
>> +{
>> +	if (dev_is_pci(dev))
>> +		return pci_device_group(dev);
>> +
>> +	if (dev_is_mdev(dev))
>> +		return iommu_group_alloc();
>> +
>> +	return ERR_PTR(-EINVAL);
>> +}
>> +
>>  #ifdef CONFIG_INTEL_IOMMU_SVM
>>  int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct intel_svm_dev
>> *sdev)  { @@ -5370,7 +5381,7 @@ const struct iommu_ops intel_iommu_ops = {
>>  	.remove_device		= intel_iommu_remove_device,
>>  	.get_resv_regions	= intel_iommu_get_resv_regions,
>>  	.put_resv_regions	= intel_iommu_put_resv_regions,
>> -	.device_group		= pci_device_group,
>> +	.device_group		= intel_iommu_device_group,
>>  	.pgsize_bitmap		= INTEL_IOMMU_PGSIZES,
>>  };
>>
>> --
>> 2.7.4
>
