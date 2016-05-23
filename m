From: "Sricharan" <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: RE: [RFC 8/9] drivers: of: call iommu_bus_add_dev after
	iommu_configure_ops
Date: Mon, 23 May 2016 14:17:01 +0530
Message-ID: <000801d1b4cf$af951cb0$0ebf5610$@codeaurora.org>
References: <1461599894-1969-1-git-send-email-sricharan@codeaurora.org>
	<1461599894-1969-9-git-send-email-sricharan@codeaurora.org>
	<898fef51-39a0-09af-4eb9-9a6581ffbe77@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <898fef51-39a0-09af-4eb9-9a6581ffbe77-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
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
To: 'Marek Szyprowski' <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, will.deacon-5wv7dgnIgG8@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Marek,

>On 2016-04-25 17:58, Sricharan R wrote:
>> Now that the device's iommu ops are configured at probe time,
>> the device has to be added to the iommu late.
>>
>> Signed-off-by: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>> ---
>>   drivers/of/device.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/of/device.c b/drivers/of/device.c
>> index 57a5f2d..722115c 100644
>> --- a/drivers/of/device.c
>> +++ b/drivers/of/device.c
>> @@ -6,6 +6,7 @@
>>   #include <linux/of_iommu.h>
>>   #include <linux/dma-mapping.h>
>>   #include <linux/init.h>
>> +#include <linux/iommu.h>
>>   #include <linux/module.h>
>>   #include <linux/mod_devicetable.h>
>>   #include <linux/slab.h>
>> @@ -154,6 +155,9 @@ int of_dma_configure_ops(struct device *dev, struct device_node *np)
>>   	dev_dbg(dev, "device is%sbehind an iommu\n",
>>   		iommu ? " " : " not ");
>>
>> +	if (iommu)
>> +		iommu_bus_add_dev(dev);
>> +
>
>This causes build break when IOMMU subsystem is not enabled:
>
>drivers/of/device.c: In function 'of_dma_configure_ops':
>drivers/of/device.c:159:3: error: implicit declaration of function
>'iommu_bus_add_dev' [-Werror=implicit-function-declaration]
>    iommu_bus_add_dev(dev);
>    ^

Ah ok. Thanks for pointing this out. I will repost, with this fixed.
I also realised that PATCH 9, might cause a issue in NON-DT
builds and needs a correction. But otherwise, i am waiting for
suggestions/feedback on how to proceed with this series.

Regards,
 Sricharan
