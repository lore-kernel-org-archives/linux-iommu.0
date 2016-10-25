From: "Sricharan" <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: RE: [PATCH 2/4] iommu/arm-smmu: Add pm_runtime/sleep ops
Date: Tue, 25 Oct 2016 11:57:37 +0530
Message-ID: <008e01d22e88$e575ac90$b06105b0$@codeaurora.org>
References: <1477070066-15044-1-git-send-email-sricharan@codeaurora.org>
	<1477070066-15044-3-git-send-email-sricharan@codeaurora.org>
	<CANLsYkw8Y-5MkeM2U9fLWX951Mo7ErsMCUBjSx3-0689jWD4rQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CANLsYkw8Y-5MkeM2U9fLWX951Mo7ErsMCUBjSx3-0689jWD4rQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: 'Mathieu Poirier' <mathieu.poirier-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Will Deacon' <will.deacon-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, 'Srinivas Kandagatla' <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi,

>On 21 October 2016 at 11:14, Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> wrote:
>> The smmu needs to be functional when the respective
>> master/s using it are active. As there is a device_link
>> between the master and smmu, the pm runtime ops for the smmu
>> gets invoked in sync with the master's runtime, thus the
>> smmu remains powered only when needed.
>>
>> There are couple of places in the driver during probe,
>> master attach, where the smmu needs to be clocked without
>> the context of the master. So doing a pm_runtime_get/put sync
>> in those places separately.
>>
>> Signed-off-by: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>> ---
>>  drivers/iommu/arm-smmu.c | 109 ++++++++++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 108 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>> index 083489e4..45f2762 100644
>> --- a/drivers/iommu/arm-smmu.c
>> +++ b/drivers/iommu/arm-smmu.c
>> @@ -45,6 +45,7 @@
>>  #include <linux/of_iommu.h>
>>  #include <linux/pci.h>
>>  #include <linux/platform_device.h>
>> +#include <linux/pm_runtime.h>
>>  #include <linux/slab.h>
>>  #include <linux/spinlock.h>
>>
>> @@ -373,6 +374,8 @@ struct arm_smmu_device {
>>         u32                             num_global_irqs;
>>         u32                             num_context_irqs;
>>         unsigned int                    *irqs;
>> +       int                             num_clocks;
>> +       struct clk                      **clocks;
>>
>>         u32                             cavium_id_base; /* Specific to Cavium */
>>  };
>> @@ -430,6 +433,31 @@ static struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
>>         return container_of(dom, struct arm_smmu_domain, domain);
>>  }
>>
>> +static int arm_smmu_enable_clocks(struct arm_smmu_device *smmu)
>> +{
>> +       int i, ret = 0;
>> +
>> +       for (i = 0; i < smmu->num_clocks; ++i) {
>> +               ret = clk_prepare_enable(smmu->clocks[i]);
>> +               if (ret) {
>> +                       dev_err(smmu->dev, "Couldn't enable clock #%d\n", i);
>> +                       while (i--)
>> +                               clk_disable_unprepare(smmu->clocks[i]);
>> +                       break;
>> +               }
>> +       }
>> +
>> +       return ret;
>> +}
>> +
>> +static void arm_smmu_disable_clocks(struct arm_smmu_device *smmu)
>> +{
>> +       int i;
>> +
>> +       for (i = 0; i < smmu->num_clocks; ++i)
>> +               clk_disable_unprepare(smmu->clocks[i]);
>> +}
>> +
>>  static void parse_driver_options(struct arm_smmu_device *smmu)
>>  {
>>         int i = 0;
>> @@ -1187,11 +1215,13 @@ static void arm_smmu_master_free_smes(struct iommu_fwspec *fwspec)
>>         int i, idx;
>>
>>         mutex_lock(&smmu->stream_map_mutex);
>> +       pm_runtime_get_sync(smmu->dev);
>
>Since this is generic code it is probably a good idea to check the
>return value, same for _put_sync() below.

 Ok, i will do it for V2.

>
>>         for_each_cfg_sme(fwspec, i, idx) {
>>                 if (arm_smmu_free_sme(smmu, idx))
>>                         arm_smmu_write_sme(smmu, idx);
>>                 cfg->smendx[i] = INVALID_SMENDX;
>>         }
>> +       pm_runtime_put_sync(smmu->dev);
>>         mutex_unlock(&smmu->stream_map_mutex);
>>  }
>>
>> @@ -1424,9 +1454,11 @@ static int arm_smmu_add_device(struct device *dev)
>>         while (i--)
>>                 cfg->smendx[i] = INVALID_SMENDX;
>>
>> +       pm_runtime_get_sync(smmu->dev);
>>         ret = arm_smmu_master_alloc_smes(dev);
>>         if (ret)
>>                 goto out_free;
>> +       pm_runtime_put_sync(smmu->dev);
>>
>>         return 0;
>>
>> @@ -1650,6 +1682,44 @@ static int arm_smmu_id_size_to_bits(int size)
>>         }
>>  }
>>
>> +static int arm_smmu_init_clocks(struct arm_smmu_device *smmu)
>> +{
>> +       const char *cname;
>> +       struct property *prop;
>> +       int i;
>> +       struct device *dev = smmu->dev;
>> +
>> +       smmu->num_clocks =
>> +               of_property_count_strings(dev->of_node, "clock-names");
>> +
>> +       if (smmu->num_clocks < 1)
>> +               return 0;
>> +
>> +       smmu->clocks = devm_kzalloc(dev,
>> +                                   sizeof(*smmu->clocks) * smmu->num_clocks,
>> +                                   GFP_KERNEL);
>> +
>> +       if (!smmu->clocks) {
>> +               dev_err(dev, "Failed to allocate memory for clocks\n");
>> +               return -ENODEV;
>> +       }
>> +
>> +       i = 0;
>
>Please do the initialisation above when you declare the variable.

     ok, will change it.

Regards,
 Sricharan
