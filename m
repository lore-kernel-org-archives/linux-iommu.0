From: Anup Patel <anup.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v2 2/4] iommu/arm-smmu: Invoke DT probe from
	arm_smmu_of_setup()
Date: Fri, 19 Feb 2016 08:44:20 +0530
Message-ID: <CAALAos-62Oo8KxODCvkLto5yeKfaTaXKfdrfVUz8nEmTb2p68Q@mail.gmail.com>
References: <1454908652-15317-1-git-send-email-anup.patel@broadcom.com>
	<1454908652-15317-3-git-send-email-anup.patel@broadcom.com>
	<001f01d16a43$ef47d3b0$cdd77b10$@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <001f01d16a43$ef47d3b0$cdd77b10$@codeaurora.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Sricharan <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Device Tree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Linux Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Vikram Prakash <vikramp-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, BCM Kernel Feedback <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Linux ARM Kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Feb 18, 2016 at 5:30 PM, Sricharan <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> wrote:
> Hi,
>
>> -----Original Message-----
>> From: linux-arm-kernel [mailto:linux-arm-kernel-
>> bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org] On Behalf Of Anup Patel
>> Sent: Monday, February 08, 2016 10:48 AM
>> To: Catalin Marinas; Joerg Roedel; Will Deacon; Robin Murphy; Sricharan R;
>> Linux IOMMU; Linux ARM Kernel
>> Cc: Mark Rutland; Device Tree; Scott Branden; Pawel Moll; Ian Campbell;
> Ray
>> Jui; Linux Kernel; Vikram Prakash; Rob Herring; BCM Kernel Feedback; Kumar
>> Gala; Anup Patel
>> Subject: [PATCH v2 2/4] iommu/arm-smmu: Invoke DT probe from
>> arm_smmu_of_setup()
>>
>> The SMMUv1/SMMUv2 driver is initialized very early using the
>> IOMMU_OF_DECLARE() but the actual platform device is probed via normal
>> DT probing.
>>
>> This patch uses of_platform_device_create() from arm_smmu_of_setup() to
>> ensure that SMMU platform device is probed immediately.
>>
>> Signed-off-by: Anup Patel <anup.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
>> ---
>>  drivers/iommu/arm-smmu.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c index
>> 2c8f871..02cd67d 100644
>> --- a/drivers/iommu/arm-smmu.c
>> +++ b/drivers/iommu/arm-smmu.c
>> @@ -40,6 +40,7 @@
>>  #include <linux/of.h>
>>  #include <linux/of_address.h>
>>  #include <linux/of_iommu.h>
>> +#include <linux/of_platform.h>
>>  #include <linux/pci.h>
>>  #include <linux/platform_device.h>
>>  #include <linux/slab.h>
>> @@ -1956,10 +1957,15 @@ static int __init arm_smmu_init(void)
>>
>>  static int __init arm_smmu_of_setup(struct device_node *np)  {
>> +     struct platform_device *pdev;
>>
>>       if (!init_done)
>>               arm_smmu_init();
>>
>> +     pdev = of_platform_device_create(np, NULL, NULL);
>> +     if (IS_ERR(pdev))
>> +             return PTR_ERR(pdev);
>> +
>>       of_iommu_set_ops(np, &arm_smmu_ops);
>
>  A question here is,  There was a probe deferral series [1], to take care of
> deferred
>  probing of devices behind iommus. With that this sort of early device
> probing during setup
>  should not be required and also it clears other dependencies of iommus on
> clocks, etc, if any.
>  My intention was to check whats the right way to do this  ? (or) point me
> to any updates
>  on the probe deferral series that I miss ?
>
> [1]  http://lkml.iu.edu/hypermail/linux/kernel/1505.3/03280.html

I think probe deferral is better way of handling this. I will drop this
patch.

Thanks,
Anup
