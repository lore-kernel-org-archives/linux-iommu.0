From: "Sricharan" <sricharan@codeaurora.org>
Subject: RE: [PATCH v2 3/4] iommu/exynos: Ensure that SYSMMU is added only      once to its master device
Date: Tue, 10 Jan 2017 10:04:19 +0530
Message-ID: <000c01d26afa$d2a6a2f0$77f3e8d0$@codeaurora.org>
References: <1483963436-29803-1-git-send-email-m.szyprowski@samsung.com>        <CGME20170109120412eucas1p27f3aab2d42712a9783d79bb4e06d01d5@eucas1p2.samsung.com>       <1483963436-29803-4-git-send-email-m.szyprowski@samsung.com> <fc7e0a6e-e65b-2a58-4c19-5bc31e36363c@arm.com>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <fc7e0a6e-e65b-2a58-4c19-5bc31e36363c@arm.com>
Content-Language: en-us
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Robin Murphy' <robin.murphy@arm.com>, 'Marek Szyprowski' <m.szyprowski@samsung.com>, iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org
Cc: 'Krzysztof Kozlowski' <krzk@kernel.org>, 'Bartlomiej Zolnierkiewicz' <b.zolnierkie@samsung.com>
List-Id: iommu@lists.linux-foundation.org

Hi,

>Hi Marek,
>
>On 09/01/17 12:03, Marek Szyprowski wrote:
>> This patch prepares Exynos IOMMU driver for deferred probing
>> support. Once it gets added, of_xlate() callback might be called
>> more than once for the same SYSMMU controller and master device
>> (for example it happens when masters device driver fails with
>> EPROBE_DEFER). This patch adds a check, which ensures that SYSMMU
>> controller is added to its master device (owner) only once.
>
>FWIW, I think it would be better to address that issue in the
>probe-deferral code itself, rather than fixing up individual IOMMU
>drivers. In fact, I *think* it's already covered in the latest version
>of the of_iommu_configure() changes[1], specifically this bit:
>
>	...
>	if (fwspec) {
>		if (fwspec->ops)
>			return fwspec->ops;
>	...
>
>Which should ensure that a successful IOMMU configuration happens
>exactly once between device creation and destruction.
>
>That said, this patch would still add robustness against actual error
>conditions, e.g. an erroneous DT which managed to specify the same
>phandle twice, although making it "if (WARN_ON(entry == data))" might be
>a good idea.
>

Yes, the latest version has the above mentioned fix of just returning back
from of_iommu_configure, if already configured. But anyways since this
patch is doing the check in xlate, which still can be called multiple times
even without deferring, incase of say multiple sids as well. But i
remember that sometime back Marek mentioned that the exynos
iommu currently always has "#iommu-cells = <0>" , but this patch might
be required if that changes as well.

Regards,
 Sricharan

>Robin.
>
>[1]:https://www.mail-archive.com/iommu@lists.linux-foundation.org/msg15333.html
>
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> ---
>>  drivers/iommu/exynos-iommu.c | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
>> index b0d537e6a445..8bf5a06a6c01 100644
>> --- a/drivers/iommu/exynos-iommu.c
>> +++ b/drivers/iommu/exynos-iommu.c
>> @@ -1253,7 +1253,7 @@ static int exynos_iommu_of_xlate(struct device *dev,
>>  {
>>  	struct exynos_iommu_owner *owner = dev->archdata.iommu;
>>  	struct platform_device *sysmmu = of_find_device_by_node(spec->np);
>> -	struct sysmmu_drvdata *data;
>> +	struct sysmmu_drvdata *data, *entry;
>>
>>  	if (!sysmmu)
>>  		return -ENODEV;
>> @@ -1272,6 +1272,10 @@ static int exynos_iommu_of_xlate(struct device *dev,
>>  		dev->archdata.iommu = owner;
>>  	}
>>
>> +	list_for_each_entry(entry, &owner->controllers, owner_node)
>> +		if (entry == data)
>> +			return 0;
>> +
>>  	list_add_tail(&data->owner_node, &owner->controllers);
>>  	data->master = dev;
>>
>>
>
>_______________________________________________
>iommu mailing list
>iommu@lists.linux-foundation.org
>https://lists.linuxfoundation.org/mailman/listinfo/iommu
