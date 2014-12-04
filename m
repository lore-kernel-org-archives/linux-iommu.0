From: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v6 1/8] iommu: provide early initialisation hook for IOMMU
	drivers
Date: Thu, 4 Dec 2014 17:58:51 +0000
Message-ID: <CACxGe6tpFHdP1-5NWiNVAqzXx-diN1xfRbu0AQDyVJ6AU_4RXg@mail.gmail.com>
References: <1417453034-21379-1-git-send-email-will.deacon@arm.com>
	<CAL_JsqKHvh9KSTYrrs1Pts5Kg=8dA1V6NiW57_2vdDH173qQGg@mail.gmail.com>
	<CACxGe6vyMkyE9ZRj_FQzi19ESEo7OV_RQoVV65xBYpdQV8cRGQ@mail.gmail.com>
	<2579924.PPXuLn3o19@wuerfel> <54805312.6000402@arm.com>
	<CACxGe6uR5J4Cjdh_xYhBPoQRgeYwHPv5=AnuRmQKSD3yZrMK9Q@mail.gmail.com>
	<54806504.20507@arm.com> <20141204144925.GB31464@ulmo.nvidia.com>
	<54809D09.2050406@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <54809D09.2050406-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: "jroedel-l3A5Bk7waGM@public.gmane.org" <jroedel-l3A5Bk7waGM@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Dec 4, 2014 at 5:42 PM, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org> wrote:
> Hi Thierry,
>
>
> On 04/12/14 14:49, Thierry Reding wrote:
>>
>> On Thu, Dec 04, 2014 at 01:43:32PM +0000, Robin Murphy wrote:
>>>
>>> Hi Grant, thanks for the advice - silly micro-optimisations removed, and
>>> I'll make a note to do so from my in-development code, too ;)
>>>
>>> I didn't much like the casting either, so rather than push it elsewhere
>>> or
>>> out to the caller I've just changed the prototype to obviate it
>>> completely.
>>> Since we're also expecting to churn this again to use something more
>>> suitable than iommu_ops as the private data, I think keeping things
>>> simple
>>> wins over const-correctness for now.
>>>
>>> Thanks,
>>> Robin
>>>
>>> --->8---
>>>  From b2e8c91ac49bef4008661e4628cd6b7249d84af5 Mon Sep 17 00:00:00 2001
>>> Message-Id:
>>> <b2e8c91ac49bef4008661e4628cd6b7249d84af5.1417698001.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
>>> From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
>>> Date: Thu, 4 Dec 2014 11:53:13 +0000
>>> Subject: [PATCH v2] iommu: store DT-probed IOMMU data privately
>>>
>>> Since the data pointer in the DT node is public and may be overwritten
>>> by conflicting code, move the DT-probed IOMMU ops to a private list
>>> where they will be safe.
>>>
>>> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
>>> ---
>>>   drivers/iommu/of_iommu.c | 40 ++++++++++++++++++++++++++++++++++++++++
>>>   include/linux/of_iommu.h | 12 ++----------
>>>   2 files changed, 42 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
>>> index 73236d3..c7078f6 100644
>>> --- a/drivers/iommu/of_iommu.c
>>> +++ b/drivers/iommu/of_iommu.c
>>> @@ -94,6 +94,46 @@ int of_get_dma_window(struct device_node *dn, const
>>> char
>>> *prefix, int index,
>>>   }
>>>   EXPORT_SYMBOL_GPL(of_get_dma_window);
>>>
>>> +struct of_iommu_node {
>>> +       struct list_head list;
>>> +       struct device_node *np;
>>> +       struct iommu_ops *ops;
>>
>>
>> Why can't this be const? Why would anyone ever need to modify it? Also
>> drivers do define their iommu_ops structures const these days, so you'll
>> either still have to cast away at some point or the compiler will
>> complain once you start calling this from drivers.
>>
>
> ...whereas if we make everything const then the drivers that _do_ want to
> use the private data introduced by this series and thus pass mutable
> per-instance iommu_ops will be the ones having to cast. We have no users
> either way until this series is merged, and the need to stash the
> per-instance data somewhere other than np->data is in the way of getting it
> merged - this is just a quick hack to address that. I think we've already
> agreed that mutable per-instance iommu_ops holding private data aren't
> particularly pleasant and will (hopefully) go away in the next iteration[1],
> at which point this all changes anyway.

Do you expect drivers to modify that *priv pointer after the ops
structure is registered? I'd be very surprised if that was the use
case. It's fine for the driver to register a non-const version, but
once it is registered, the infrastructure can treat it as const from
then on.

g.
