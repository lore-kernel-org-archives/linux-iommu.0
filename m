From: "Sricharan" <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: RE: [PATCH 5/8] drivers: platform: Configure dma operations at probe
	time
Date: Tue, 16 Aug 2016 17:58:51 +0530
Message-ID: <000701d1f7b9$c2c4e8b0$484eba10$@codeaurora.org>
References: <1470696550-3416-1-git-send-email-sricharan@codeaurora.org>
	<1470696550-3416-6-git-send-email-sricharan@codeaurora.org>
	<14864888.EhQqoi8buh@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <14864888.EhQqoi8buh@avalon>
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
To: 'Laurent Pinchart' <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Laurent,

>Hi Sricharan,
>
>Thank you for the patch.
>
>On Tuesday 09 Aug 2016 04:19:07 Sricharan R wrote:
>> Configuring DMA ops at probe time will allow deferring device probe when
>> the IOMMU isn't available yet.
>>
>> Signed-off-by: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>> ---
>>  drivers/base/dd.c           | 11 +++++++++++
>>  drivers/base/dma-mapping.c  | 11 +++++++++++
>>  include/linux/dma-mapping.h |  3 +++
>>  3 files changed, 25 insertions(+)
>>
>> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
>> index 16688f5..b9978af 100644
>> --- a/drivers/base/dd.c
>> +++ b/drivers/base/dd.c
>> @@ -19,6 +19,7 @@
>>
>>  #include <linux/device.h>
>>  #include <linux/delay.h>
>> +#include <linux/dma-mapping.h>
>>  #include <linux/module.h>
>>  #include <linux/kthread.h>
>>  #include <linux/wait.h>
>> @@ -353,6 +354,10 @@ static int really_probe(struct device *dev, struct
>> device_driver *drv) if (ret)
>>  		goto pinctrl_bind_failed;
>>
>> +	ret = dma_configure_ops(dev);
>
>Your patch doesn't remove the of_dma_configure_ops() from
>of_platform_device_create_pdata(). Unless I'm mistaken, you will then end up
>configuring the DMA ops twice, which at least on ARM will be a no-op the
>second time:
    I did remove both of_dmaconfigure/deconfigure from other places, but
    i did as a separate next patch [1]  (should have been squashed here).
     I will squash for the next repost.

[1] https://www.spinics.net/lists/arm-kernel/msg522510.html

Regards,
 Sricharan
