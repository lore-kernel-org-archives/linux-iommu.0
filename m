From: JeffyChen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [PATCH v3 01/12] iommu/rockchip: Prohibiat unbind and remove
Date: Thu, 18 Jan 2018 16:28:58 +0800
Message-ID: <5A605ACA.7030207@rock-chips.com>
References: <20180117152542.26429-1-jeffy.chen@rock-chips.com>
	<20180117152542.26429-2-jeffy.chen@rock-chips.com>
	<CAAFQd5B24j6OSStpYWiO-xfhH131mwNRk3=cEBakMpvsEkQ7wg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAAFQd5B24j6OSStpYWiO-xfhH131mwNRk3=cEBakMpvsEkQ7wg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ricky Liang <jcliang-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "list-Y9sIeH5OGRo@public.gmane.org:IOMMU DRIVERS" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Tomasz,

Thanks for your reply.

and just found i forgot to add iommu clocks for other rockchip 
platforms(rk3399 already has that)...will also do that in the next version.

On 01/18/2018 12:17 PM, Tomasz Figa wrote:
> On Thu, Jan 18, 2018 at 12:25 AM, Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org> wrote:
>> Removal the IOMMUs cannot be done reliably.
>
> nit: Perhaps "Removal of IOMMUs"?
>
ok
>>
>> This is similar to exynos iommu driver.
>>
>> Signed-off-by: Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
>> ---
>>
>> Changes in v3:
>> Also remove remove() and module_exit() as Tomasz suggested.
>>
>> Changes in v2: None
>>
>>   drivers/iommu/rockchip-iommu.c | 21 +--------------------
>>   1 file changed, 1 insertion(+), 20 deletions(-)
>
> nit: Typo in subject: s/Prohibiat/Prohibit/
>
ok, will do that.
> Otherwise,
>
> Reviewed-by: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
>
> Best regards,
> Tomasz
>
>
>
