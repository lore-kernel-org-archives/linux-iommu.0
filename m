From: "Sricharan" <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: RE: [PATCH V7 08/11] drivers: acpi: Handle IOMMU lookup failure with
	deferred probing or error
Date: Wed, 25 Jan 2017 13:01:47 +0530
Message-ID: <001501d276dd$1b395d80$51ac1880$@codeaurora.org>
References: <1485188293-20263-1-git-send-email-sricharan@codeaurora.org>
	<1485188293-20263-9-git-send-email-sricharan@codeaurora.org>
	<20170124123711.GA11996@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170124123711.GA11996@red-moon>
Content-Language: en-us
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: 'Lorenzo Pieralisi' <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Cc: linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, 'Sinan Kaya' <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, 'Tomasz Nowicki' <tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Lorenzo,

>[+hanjun, tomasz, sinan]
>
>It is quite a key patchset, I would be glad if they can test on their
>respective platforms with IORT.
>
>On Mon, Jan 23, 2017 at 09:48:10PM +0530, Sricharan R wrote:
>> This is an equivalent to the DT's handling of the iommu master's probe
>> with deferred probing when the corrsponding iommu is not probed yet.
>> The lack of a registered IOMMU can be caused by the lack of a driver for
>> the IOMMU, the IOMMU device probe not having been performed yet, having
>> been deferred, or having failed.
>>
>> The first case occurs when the firmware describes the bus master and
>> IOMMU topology correctly but no device driver exists for the IOMMU yet
>> or the device driver has not been compiled in. Return NULL, the caller
>> will configure the device without an IOMMU.
>>
>> The second and third cases are handled by deferring the probe of the bus
>> master device which will eventually get reprobed after the IOMMU.
>>
>> The last case is currently handled by deferring the probe of the bus
>> master device as well. A mechanism to either configure the bus master
>> device without an IOMMU or to fail the bus master device probe depending
>> on whether the IOMMU is optional or mandatory would be a good
>> enhancement.
>>
>> Signed-off-by: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>> ---
>>  drivers/acpi/arm64/iort.c  | 25 ++++++++++++++++++++++++-
>>  drivers/acpi/scan.c        |  7 +++++--
>>  drivers/base/dma-mapping.c |  2 +-
>>  include/acpi/acpi_bus.h    |  2 +-
>>  include/linux/acpi.h       |  7 +++++--
>>  5 files changed, 36 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
>> index bf0ed09..d01bae8 100644
>> --- a/drivers/acpi/arm64/iort.c
>> +++ b/drivers/acpi/arm64/iort.c
>> @@ -550,8 +550,17 @@ static const struct iommu_ops *iort_iommu_xlate(struct device *dev,
>>  			return NULL;
>>
>>  		ops = iommu_get_instance(iort_fwnode);
>> +		/*
>> +		 * If the ops look-up fails, this means that either
>> +		 * the SMMU drivers have not been probed yet or that
>> +		 * the SMMU drivers are not built in the kernel;
>> +		 * Depending on whether the SMMU drivers are built-in
>> +		 * in the kernel or not, defer the IOMMU configuration
>> +		 * or just abort it.
>> +		 */
>>  		if (!ops)
>> -			return NULL;
>> +			return iort_iommu_driver_enabled(node->type) ?
>> +			       ERR_PTR(-EPROBE_DEFER) : NULL;
>>
>>  		ret = arm_smmu_iort_xlate(dev, streamid, iort_fwnode, ops);
>>  	}
>> @@ -625,12 +634,26 @@ const struct iommu_ops *iort_iommu_configure(struct device *dev)
>>
>>  		while (parent) {
>>  			ops = iort_iommu_xlate(dev, parent, streamid);
>> +			if (IS_ERR_OR_NULL(ops))
>> +				return ops;
>>
>>  			parent = iort_node_get_id(node, &streamid,
>>  						  IORT_IOMMU_TYPE, i++);
>>  		}
>>  	}
>>
>> +	/*
>> +	 * If we have reason to believe the IOMMU driver missed the initial
>> +	 * add_device callback for dev, replay it to get things in order.
>> +	 */
>> +	if (!IS_ERR_OR_NULL(ops) && ops->add_device &&
>> +	    dev->bus && !dev->iommu_group) {
>> +		int err = ops->add_device(dev);
>> +
>> +		if (err)
>> +			ops = ERR_PTR(err);
>> +	}
>
>I think there is nothing ACPI specific in this add_device() replay
>path, so there is room for further DT/ACPI consolidation here.
>

ok, the only way is keep this in a function and call it for both DT and ACPI
cases.

>Without any further ado:
>
>Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>

Thanks for that.

Regards,
 Sricharan
