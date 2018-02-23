From: JeffyChen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [PATCH v4 08/13] iommu/rockchip: Control clocks needed to access
	the IOMMU
Date: Fri, 23 Feb 2018 18:36:49 +0800
Message-ID: <5A8FEEC1.5040303@rock-chips.com>
References: <20180118115251.5542-1-jeffy.chen@rock-chips.com>
	<20180118115251.5542-9-jeffy.chen@rock-chips.com>
	<c188e6a9-744c-d984-545c-408607f35cc9@arm.com>
	<5A60AE41.2050101@rock-chips.com>
	<1f4b3c0d-1414-0012-a072-f4a11f432c21@rock-chips.com>
	<5A654925.9020203@rock-chips.com> <5A6563FA.8080602@rock-chips.com>
	<c05d4794-b76d-cfaa-d7ed-c44108117ee2@rock-chips.com>
	<5A69B065.30501@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <5A69B065.30501-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Randy Li <randy.li-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jcliang-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi guys,

On 01/25/2018 06:24 PM, JeffyChen wrote:
> On 01/25/2018 05:42 PM, Randy Li wrote:
>>>>
>>>
>>> confirmed with Simon, there might be some iommus don't have a pd, and
>> We use the pd to control the NIU node(not on upstream), without a pd or
>> fake pd, none of the platform would work.
> after talked offline, it's possible to have iommu without pd in upstream
> kernel(and chromeos kernel), but on our internal kernel, the drivers
> would require pd(or fake pd) to reset modules when error happens.
>
> anyway, i think that means we do need clock control here.

found another reason to not depend on pd to control clocks.

currently we are using pd's pm_clk to keep clocks enabled during power 
on. but in our pd binding doc, that is not needed:
- clocks (optional): phandles to clocks which need to be enabled while 
power domain
         switches state.

confirmed with Caesar, the pm_clk only required for some old 
chips(rk3288 for example) due to hardware issue.

and i tested my chromebook kevin(rk3399), it works well after remove the 
pm_clk:

+++ b/drivers/soc/rockchip/pm_domains.c
@@ -478,7 +478,6 @@ static int rockchip_pm_add_one_domain(struct 
rockchip_pmu *pmu,
         pd->genpd.power_on = rockchip_pd_power_on;
         pd->genpd.attach_dev = rockchip_pd_attach_dev;
         pd->genpd.detach_dev = rockchip_pd_detach_dev;
-       pd->genpd.flags = GENPD_FLAG_PM_CLK;

will do more tests and send patch tomorrow.

>
>>> the CONFIG_PM could be disabled.I am hard to believe a modern platform
>>> can work without that.
>>>
>>> so it might be better to control clocks in iommu driver itself.
>> I won't
>> insist how the version of the iommu patch on the upstream, I
>> just post an idea here.
>> The version for kernel 4.4 is under internal review, the implementation
>> has been modified many times.
>>
>> I would suggest the managing clocks in pd is a more easy way and don't
>> need to spare those thing in two places.
