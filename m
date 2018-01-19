From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFCv2 PATCH 05/36] iommu/process: Bind and unbind process to and
	from devices
Date: Fri, 19 Jan 2018 10:27:53 +0000
Message-ID: <e2753b59-2b9e-ffc6-a7b8-0ed23df38e10@arm.com>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
	<20171006133203.22803-6-jean-philippe.brucker@arm.com>
	<0772e71e-4861-1e7b-f248-88aaba8bf2fc@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <0772e71e-4861-1e7b-f248-88aaba8bf2fc-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
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
To: Sinan Kaya <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Cc: Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, "gabriele.paoloni-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <gabriele.paoloni-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Catalin Marinas <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "rfranz-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org" <rfranz-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, "lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org" <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Sudeep Holla <Sudeep.Holla-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Sinan,

On 19/01/18 04:52, Sinan Kaya wrote:
> Hi Jean-Philippe,
> 
> On 10/6/2017 9:31 AM, Jean-Philippe Brucker wrote:
>>  /**
>> + * iommu_process_bind_device - Bind a process address space to a device
>> + * @dev: the device
>> + * @task: the process to bind
>> + * @pasid: valid address where the PASID will be stored
>> + * @flags: bond properties (IOMMU_PROCESS_BIND_*)
>> + *
>> + * Create a bond between device and task, allowing the device to access the
>> + * process address space using the returned PASID.
>> + *
>> + * On success, 0 is returned and @pasid contains a valid ID. Otherwise, an error
>> + * is returned.
>> + */
>> +int iommu_process_bind_device(struct device *dev, struct task_struct *task,
>> +			      int *pasid, int flags)
> 
> This API doesn't play nice with endpoint device drivers that have PASID limitations.
> 
> The AMD driver seems to have PASID limitations per product that are not being
> advertised in the PCI capability.
> 
> device_iommu_pasid_init()
> {
>         pasid_limit = min_t(unsigned int,
>                         (unsigned int)(1 << kfd->device_info->max_pasid_bits),
>                         iommu_info.max_pasids);
>         /*
>          * last pasid is used for kernel queues doorbells
>          * in the future the last pasid might be used for a kernel thread.
>          */
>         pasid_limit = min_t(unsigned int,
>                                 pasid_limit,
>                                 kfd->doorbell_process_limit - 1);
> }
> 
> kfd->device_info->max_pasid_bits seems to contain per device limitations.
> 
> Would you be willing to extend the API so that the requester can impose some limit
> on the PASID value that is getting allocated.

Good point. Following the feedback for this series, next version adds
another public function:

int iommu_sva_device_init(struct device *dev, int features);

that has to be called by the device driver before any bind(). The intent
is to let some IOMMU drivers initialize PASID tables and other features
lazily, only if the device driver actually intends to use them. Maybe I
could change this function to:

int iommu_sva_device_init(struct device *dev, int features, unsigned int
max_pasid);

@features is a bitmask telling what the device driver needs (PASID and/or
page faults). If features has IOMMU_SVA_FEAT_PASID set, then device driver
can set a max_pasid limit, that we'd store in our private device-iommu
data. If max_pasid is 0, then we'd use the PCI limit.

Thanks,
Jean
