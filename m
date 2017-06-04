From: Ganapatrao Kulkarni <gpkulkarni-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] acpi/iort, numa: Add numa node mapping for smmuv3 devices
Date: Sun, 4 Jun 2017 09:34:54 +0530
Message-ID: <CAFpQJXWjxpiL=nfe2CFXBoUSL_a=h5kkZPpGFbJ9UxxfegKZ2Q@mail.gmail.com>
References: <1496325937-21113-1-git-send-email-ganapatrao.kulkarni@cavium.com>
	<20170601162142.GC19003@red-moon> <5930E085.8000404@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <5930E085.8000404-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Hanjun Guo <guohanjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Cc: Lv Zheng <lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, sudeep.holla-5wv7dgnIgG8@public.gmane.org, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jayachandran C <jnair-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Ganapatrao Kulkarni <ganapatrao.kulkarni-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Jun 2, 2017 at 9:20 AM, Hanjun Guo <guohanjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org> wrote:
> [+Cc Lv Zheng]
>
> On 2017/6/2 0:21, Lorenzo Pieralisi wrote:
>> On Thu, Jun 01, 2017 at 07:35:37PM +0530, Ganapatrao Kulkarni wrote:
>>> ARM IORT specification has provision to define Proximity domain
>>> in SMMUv3 IORT table. Adding required code to parse Proximity domain of
>>> SMMUv3 IORT table. Parsed Proximity domain is used to set numa_node
>>> of SMMUv3 platform devices.
>>>
>>> Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
>>> ---
>>>  drivers/iommu/arm-smmu-v3.c | 6 ++++++
>>>  include/acpi/actbl2.h       | 4 ++++
>>>  2 files changed, 10 insertions(+)
>>>
>>> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
>>> index 69d8506..98c2319 100644
>>> --- a/drivers/iommu/arm-smmu-v3.c
>>> +++ b/drivers/iommu/arm-smmu-v3.c
>>> @@ -2667,6 +2667,12 @@ static int arm_smmu_device_acpi_probe(struct platform_device *pdev,
>>>      if (iort_smmu->flags & ACPI_IORT_SMMU_V3_COHACC_OVERRIDE)
>>>              smmu->features |= ARM_SMMU_FEAT_COHERENCY;
>>>
>>> +    /* set numa proximity domain for smmv3 device */
>>> +    if (iort_smmu->flags & ACPI_IORT_SMMU_V3_PXM) {
>>> +            set_dev_node(dev, acpi_map_pxm_to_node(iort_smmu->pxm));
>>> +            dev_info(dev, "on NUMA node %d\n", dev_to_node(dev));
>> It should be done in acpi/arm64/iort.c at device creation time.
>
> Agreed.

thanks Lorenzo, i will update in next patch version.
>
>>
>>> +    }
>>> +
>>>      return 0;
>>>  }
>>>  #else
>>> diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
>>> index 4b306a6..c16ced8 100644
>>> --- a/include/acpi/actbl2.h
>>> +++ b/include/acpi/actbl2.h
>>> @@ -805,6 +805,9 @@ struct acpi_iort_smmu_v3 {
>>>      u32 pri_gsiv;
>>>      u32 gerr_gsiv;
>>>      u32 sync_gsiv;
>>> +    u8 pxm;
>>> +    u8 reserved1;
>>> +    u16 reserved2;
>
> I think changes to actbl2.h need to be split as a new patch
> which go via ACPICA updates,  Lv, could you share
> your comments here?

thanks Hanjun, looks like the changes should go to acpica repo and it should get
pulled in kernel.

Lv, can you please suggest on what should be done?
>
> Thanks
> Hanjun
>

thanks
Ganapat
