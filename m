From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 01/37] iommu: Introduce Shared Virtual Addressing API
Date: Tue, 13 Feb 2018 12:40:13 +0000
Message-ID: <b3c190e7-1a33-971e-b86c-a9725118ba05@arm.com>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
	<20180212183352.22730-2-jean-philippe.brucker@arm.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D191002823@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D191002823-0J0gbvR4kThpB2pF5aRoyrfspsVTdybXVpNB7YpNyf8@public.gmane.org>
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
To: "Tian, Kevin" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, "bharatku-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org" <bharatku-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, "Raj,
	Ashok" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "shunyong.yang-PT9Dzx9SjPiXmMXjJBpWqg@public.gmane.org" <shunyong.yang-PT9Dzx9SjPiXmMXjJBpWqg@public.gmane.org>, "rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Catalin Marinas <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, "xuzaibo-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <xuzaibo-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "ilias.apalodimas-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <ilias.apalodimas-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org" <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sudeep Holla <Sudeep.Holla-5wv7dgnIgG8@public.gmane.org>, "rfranz-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org" <rfranz-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "christian.koenig-5C7GfCeVMHo@public.gmane.org" <christian.koenig-5C7GfCeVMHo@public.gmane.org>, "lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Kevin,

Thanks for taking a look!

On 13/02/18 07:31, Tian, Kevin wrote:
>> From: Jean-Philippe Brucker
>> Sent: Tuesday, February 13, 2018 2:33 AM
>>
>> Shared Virtual Addressing (SVA) provides a way for device drivers to bind
>> process address spaces to devices. This requires the IOMMU to support the
>> same page table format as CPUs, and requires the system to support I/O
> 
> "same" is a bit restrictive. "compatible" is better as you used in coverletter. :-)

Indeed

[..]
>> +config IOMMU_SVA
>> +	bool "Shared Virtual Addressing API for the IOMMU"
>> +	select IOMMU_API
>> +	help
>> +	  Enable process address space management for the IOMMU API. In
>> systems
>> +	  that support it, device drivers can bind process address spaces to
>> +	  devices and share their page tables using this API.
> 
> "their page table" is a bit confusing here.

Maybe this is sufficient:
"In systems that support it, drivers can share process address spaces with
their devices using this API."

[...]
>> +
>> +/**
>> + * iommu_sva_device_init() - Initialize Shared Virtual Addressing for a
>> device
>> + * @dev: the device
>> + * @features: bitmask of features that need to be initialized
>> + * @max_pasid: max PASID value supported by the device
>> + *
>> + * Users of the bind()/unbind() API must call this function to initialize all
>> + * features required for SVA.
>> + *
>> + * - If the device should support multiple address spaces (e.g. PCI PASID),
>> + *   IOMMU_SVA_FEAT_PASID must be requested.
> 
> I think it is by default assumed when using this API, based on definition of
> SVA. Can you elaborate the situation where this flag can be cleared?

When passing a device to userspace, you could also share its non-pasid
address space with the process. It requires a new domain type so is left
as a TODO in patch 2/37. I did get requests for this feature, though I
think it was mostly for prototyping. I guess I could remove the flag, and
reintroduce it as IOMMU_SVA_FEAT_NO_PASID later on.

>> + *
>> + *   By default the PASID allocated during bind() is limited by the IOMMU
>> + *   capacity, and by the device PASID width defined in the PCI capability or
>> in
>> + *   the firmware description. Setting @max_pasid to a non-zero value
>> smaller
>> + *   than this limit overrides it.
>> + *
>> + * - If the device should support I/O Page Faults (e.g. PCI PRI),
>> + *   IOMMU_SVA_FEAT_IOPF must be requested.
>> + *
>> + * The device should not be be performing any DMA while this function is
> 
> remove double "be"
> 
>> + * running.
> 
> "otherwise the behavior is undefined"

ok

[...]
>> +	ret = domain->ops->sva_device_init(dev, features, &min_pasid,
>> +					   &max_pasid);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* FIXME: racy. Next version should have a mutex (same as fault
>> handler) */
>> +	dev_param->sva_features = features;
>> +	dev_param->min_pasid = min_pasid;
>> +	dev_param->max_pasid = max_pasid;
> 
> what's the point of min_pasid here?

Arm SMMUv3 uses entry 0 of the PASID table for the default (non-pasid)
context, so it needs to set min_pasid to 1. AMD IOMMU recently added a
similar feature (GIoSup), if I understood correctly.

Thanks,
Jean
