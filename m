From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 04/29] drivers: base: add notifier for failed driver bind
Date: Tue, 26 Aug 2014 08:23:01 +0200
Message-ID: <53FC27C5.7030400@samsung.com>
References: <1407235677-26324-1-git-send-email-m.szyprowski@samsung.com>
	<1407235677-26324-5-git-send-email-m.szyprowski@samsung.com>
	<20140825200539.GA22076@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <20140825200539.GA22076-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Shaik Ameer Basha <shaik.ameer-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hello,

On 2014-08-25 22:05, Greg Kroah-Hartman wrote:
> On Tue, Aug 05, 2014 at 12:47:32PM +0200, Marek Szyprowski wrote:
>> This patch adds support for getting a notify for failed device driver
>> bind, so all the items done in BUS_NOTIFY_BIND_DRIVER event can be
>> cleaned if the driver fails to bind.
> But doesn't the bus know if the driver fails to bind, so why would a
> notifier be needed here?  Can't it unwind any problems then?

Some other subsystems (like IOMMU) might register its own notifiers on
the given bus. Such notifier is called before driver probe
(BUS_NOTIFY_BIND_DRIVER event), so one can allocate some resources there.
However there is no way to do the cleanup if the driver fails to bind,
because no notifier is called in such case.

>> Signed-off-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>> ---
>>   drivers/base/dd.c      | 10 +++++++---
>>   include/linux/device.h |  4 +++-
>>   2 files changed, 10 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
>> index e4ffbcf..541a41f 100644
>> --- a/drivers/base/dd.c
>> +++ b/drivers/base/dd.c
>> @@ -237,10 +237,14 @@ static int driver_sysfs_add(struct device *dev)
>>   	return ret;
>>   }
>>   
>> -static void driver_sysfs_remove(struct device *dev)
>> +static void driver_sysfs_remove(struct device *dev, int failed)
> I _hate_ having functions with a flag that does something different
> depending on it.  If you _really_ need this, just make the notifier call
> before calling this function, which should work just fine, right?

Ok, I will fix this. If I remember correctly I followed the 
driver_sysfs_add()
function pattern, which (surprisingly, especially when one considers only
the function name) also calls the bus notifiers.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
