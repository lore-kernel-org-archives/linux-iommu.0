From: JeffyChen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [PATCH 1/9] iommu/of: Drop early initialisation hooks
Date: Fri, 12 Jan 2018 09:22:06 +0800
Message-ID: <5A580DBE.8000301@rock-chips.com>
References: <20180111082229.24011-1-jeffy.chen@rock-chips.com>
	<CGME20180111082537epcas3p274f6bfeb31f10742e8129dc0c877745e@epcas3p2.samsung.com>
	<20180111082229.24011-2-jeffy.chen@rock-chips.com>
	<60fdd375-ca74-0fea-c598-39a68b9e7735@samsung.com>
	<5A57471E.7020304@rock-chips.com>
	<faeccc75-79e9-ddb6-446d-88ab63fe4e1f@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <faeccc75-79e9-ddb6-446d-88ab63fe4e1f-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, jcliang-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

Thnaks for your reply.

On 01/11/2018 08:24 PM, Robin Murphy wrote:
> Hi Jeffy,
>
> On 11/01/18 11:14, JeffyChen wrote:
>> Hi Marek,
>>
>> Thanks for your reply.
>>
>> On 01/11/2018 05:40 PM, Marek Szyprowski wrote:
>>> Hi Jeffy,
>>>
>>> On 2018-01-11 09:22, Jeffy Chen wrote:
>>>> With the probe-deferral mechanism, early initialisation hooks are no
>>>> longer needed.
>>>>
>>>> Suggested-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
>
> In fact, shortly after I said that I had a "how hard can it be?" moment
> and took a crack at it myself - sorry, I should probably have cc'd you
> on that series[1].

hmmm, i'll drop this patch in the next version.

and maybe rebase my patch[9] (iommu/rockchip: Use OF_IOMMU to attach 
devices automatically) on that series
>
>>>> Signed-off-by: Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
>>>> ---
>>>>
>>>>   drivers/iommu/arm-smmu-v3.c  |  2 +-
>>>>   drivers/iommu/arm-smmu.c     | 12 ++++++------
>>>>   drivers/iommu/exynos-iommu.c |  2 +-
>>>
>>> For Exynos IOMMU:
>>> Acked-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>>>
>>> IPMMU and MSM IOMMU are no longer multi-platform safe after this patch.
>>> It breaks them in the same way as my commit 928055a01b3f ("iommu/exynos:
>>> Remove custom platform device registration code") broke Exynos IOMMU.
>>>
>>> You need a similar fix for them:
>>> https://www.spinics.net/lists/arm-kernel/msg627648.html
>>
>> hmmm, right, i did saw this fix in the rockchip iommu driver too.
>>
>> and there're also some other iommu drivers put bus_set_iommu in their
>> probe() to avoid that.
>>
>> maybe we can do it in the iommu framework?
>>
>> for example:
>> 1/ add a bus type member to struct iommu_device
>> 2/ and a iommu_device_set_bus()
>> 3/ do the bus_set_iommu stuff in iommu_device_register()
>> 4/ undo bus_set_iommu in iommu_device_unregister()
>
> Ultimately we'd like to get rid of the bus relationship altogether, so I
> don't think it's really worth adding more infrastructure around it.
> Having of-iommu-based drivers set bus ops at probe time, and others
> conditionally from an initcall, is pretty clean and simple, so I'd
> rather stick with that approach for now.
ok, make sense:)
>
> Robin.
>
> [1]
> https://lists.linuxfoundation.org/pipermail/iommu/2018-January/025395.html
>
>
>
