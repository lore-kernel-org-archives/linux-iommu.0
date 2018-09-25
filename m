From: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v4 11/20] memory: tegra: Use of_device_get_match_data()
Date: Tue, 25 Sep 2018 16:53:26 +0300
Message-ID: <f12b82d6-0fc9-443e-f68b-be63265c8354@gmail.com>
References: <20180924004153.8232-1-digetx@gmail.com>
 <20180924004153.8232-12-digetx@gmail.com> <20180924101354.GH21032@ulmo>
 <dcf439a0-249c-ff9f-292d-c807a736672a@gmail.com> <20180925100046.GD7097@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180925100046.GD7097@ulmo>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>, Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>, Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 9/25/18 1:00 PM, Thierry Reding wrote:
> On Mon, Sep 24, 2018 at 09:39:43PM +0300, Dmitry Osipenko wrote:
>> On 9/24/18 1:13 PM, Thierry Reding wrote:
>>> On Mon, Sep 24, 2018 at 03:41:44AM +0300, Dmitry Osipenko wrote:
>>>> There is no need to match device with the DT node since it was already
>>>> matched, use of_device_get_match_data() helper to get the match-data.
>>>>
>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>> ---
>>>>  drivers/memory/tegra/mc.c | 10 ++--------
>>>>  1 file changed, 2 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
>>>> index 5454ffe5b2e0..cdc33f93cf7c 100644
>>>> --- a/drivers/memory/tegra/mc.c
>>>> +++ b/drivers/memory/tegra/mc.c
>>>> @@ -11,8 +11,7 @@
>>>>  #include <linux/interrupt.h>
>>>>  #include <linux/kernel.h>
>>>>  #include <linux/module.h>
>>>> -#include <linux/of.h>
>>>> -#include <linux/platform_device.h>
>>>
>>> It's better not to remove these two because the code still uses
>>> functions declared in them. If ever we were going to remove code using
>>> linux/of_device.h and then remove the linux/of_device.h include, we'd
>>> break the build and have to reintroduce the includes.
>>
>> That doesn't sound like a good argument. You're way too picky here ;)
>>
>>> The same would happen if linux/of_device.h were ever to stop including
>>> linux/platform_device.h or linux/of.h. That may sound unlikely, but it
>>> has happened in the past with other includes. It can also happen that
>>> some restructuring takes place in some headers that is not so obvious
>>> and then things can still start falling apart miles away.
>>
>> Restructuring will be somebody else problem. Not sure that we really
>> should care about it, I think it is unnecessary. But since you're
>> insisting..
> 
> It's actually a very common argument and I've seen patches in the past
> that add includes just for the purpose of making sure the right
> definitions get pulled in. This happens quite frequently as a preamble
> to some major rework of some header files that would otherwise cause a
> lot of breakage.
> 
> So I think it's best to be proactive about this and make sure we
> explicitly pull in all the necessary headers in the first place,
> irrespective of whether or not they may already get pulled in indirectly
> by some other headers.

Ok
