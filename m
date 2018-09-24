From: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 11/20] memory: tegra: Use of_device_get_match_data()
Date: Mon, 24 Sep 2018 21:39:43 +0300
Message-ID: <dcf439a0-249c-ff9f-292d-c807a736672a@gmail.com>
References: <20180924004153.8232-1-digetx@gmail.com>
	<20180924004153.8232-12-digetx@gmail.com> <20180924101354.GH21032@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180924101354.GH21032@ulmo>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 9/24/18 1:13 PM, Thierry Reding wrote:
> On Mon, Sep 24, 2018 at 03:41:44AM +0300, Dmitry Osipenko wrote:
>> There is no need to match device with the DT node since it was already
>> matched, use of_device_get_match_data() helper to get the match-data.
>>
>> Signed-off-by: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> ---
>>  drivers/memory/tegra/mc.c | 10 ++--------
>>  1 file changed, 2 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
>> index 5454ffe5b2e0..cdc33f93cf7c 100644
>> --- a/drivers/memory/tegra/mc.c
>> +++ b/drivers/memory/tegra/mc.c
>> @@ -11,8 +11,7 @@
>>  #include <linux/interrupt.h>
>>  #include <linux/kernel.h>
>>  #include <linux/module.h>
>> -#include <linux/of.h>
>> -#include <linux/platform_device.h>
> 
> It's better not to remove these two because the code still uses
> functions declared in them. If ever we were going to remove code using
> linux/of_device.h and then remove the linux/of_device.h include, we'd
> break the build and have to reintroduce the includes.

That doesn't sound like a good argument. You're way too picky here ;)

> The same would happen if linux/of_device.h were ever to stop including
> linux/platform_device.h or linux/of.h. That may sound unlikely, but it
> has happened in the past with other includes. It can also happen that
> some restructuring takes place in some headers that is not so obvious
> and then things can still start falling apart miles away.

Restructuring will be somebody else problem. Not sure that we really
should care about it, I think it is unnecessary. But since you're
insisting..
