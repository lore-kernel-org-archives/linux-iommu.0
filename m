From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v3 2/9] iommu/of: Consolidate device creation workarounds
Date: Fri, 01 Jul 2016 14:02:14 +0200
Message-ID: <f820051f-6785-85ed-7c36-9b49e62e1200@samsung.com>
References: <cover.1467123945.git.robin.murphy@arm.com>
	<dc8ac0f397ea5c90937fb5c9974e4ab02e264bd8.1467123945.git.robin.murphy@arm.com>
	<611b2a77-e7e8-e1e2-85b5-4f469f3ebdf4@samsung.com>
	<577651D7.4030309@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <577651D7.4030309-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Robin,


On 2016-07-01 13:19, Robin Murphy wrote:
> Hi Marek,
>
> On 01/07/16 11:32, Marek Szyprowski wrote:
>> Hi Robin,
>>
>>
>> On 2016-06-28 17:48, Robin Murphy wrote:
>>> So far, all the users of the generic of_xlate configuration mechanism
>>> are resorting to explicit platform device creation to ensure the IOMMU
>>> device is ready before anything tries to refer to it. As I'm about to
>>> convert two more drivers that will need exactly the same thing, let's
>>> nip that proliferation in the bud and move it to a single place.
>>>
>>> A neat solution is to make of_get_iommu_ops() ensure an IOMMU device is
>>> instantiated before giving out its associated ops, since it's a fairly
>>> safe assumption that the ops aren't going to be much use if the IOMMU
>>> can't or won't exist to back them up.
>>>
>>> CC: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>>> CC: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
>>> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
>> Frankly, I would avoid moving this workaround to the iommu core. IMHO the
>> best solution would be to let IOMMU controllers to be instantiated as
>> normal
>> devices and implement proper support in the device core for waiting for the
>> iommu controller. Then the workaround can be removed from exynos and mtk
>> iommu drivers. What's the status of IOMMU deferred probe patches?
> I think revisiting probe ordering is now second-from-top on my to-do
> list after this lot. This patch was kind of thinking ahead to get the
> "touch all the drivers" aspect out of the way before it grows any
> bigger, and all the development can then happen in the core code alone,
> but I admit it's not a particularly strong argument.
>
>> I've encountered a serious problems with current code (the one which
>> instantiates iommu controller devices from iommu driver) and its
>> integration
>> with power domains, clocks and runtime pm, which were not possible to
>> resolve
>> without iommu deferred probe.
> OK. Do you have any plans to try tweaking the current workaround, or is
> it really not worth it?

I will keep it as is until the core will be ready for initializing Exynos
iommu driver simply from the core_initcall (or other), which will just do
platform_driver_register(&exynos_sysmmu_driver).

>   FWIW I do have an Exynos 5410 (Odroid-XU) on my
> desk which I could theoretically test things on, but I suspect it would
> take a fair amount of work to get the SYSMMUs and relevant media bits up
> and running on top of Krzysztof's basic support.

It should be quite easy to get Exynos DRM with HDMI display working on
Odroid XU1, I can take a look in that after getting back from holidays
(probably after 17th July).

> Will: for the time being, the alternative to this patch would be to
> squash the following change into patch 7/9 (without either, patch 8/9
> doesn't really work).
>
> Robin.
>
> -----8<-----
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index e4c3916efba9..c002ff06b625 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -2678,6 +2678,14 @@ module_exit(arm_smmu_exit);
>
>   static int __init arm_smmu_of_init(struct device_node *np)
>   {
> +	static bool registered;
> +
> +	if (!registered)
> +		registered = !arm_smmu_init();
> +
> +	if (!of_platform_device_create(np, NULL, platform_bus_type.dev_root))
> +		return -ENODEV;
> +
>   	of_iommu_set_ops(np, &arm_smmu_ops);
>
>   	return 0;
>
>

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
