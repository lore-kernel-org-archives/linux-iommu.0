From: Randy Li <randy.li-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [PATCH v4 08/13] iommu/rockchip: Control clocks needed to access
 the IOMMU
Date: Thu, 25 Jan 2018 17:42:17 +0800
Message-ID: <c05d4794-b76d-cfaa-d7ed-c44108117ee2@rock-chips.com>
References: <20180118115251.5542-1-jeffy.chen@rock-chips.com>
 <20180118115251.5542-9-jeffy.chen@rock-chips.com>
 <c188e6a9-744c-d984-545c-408607f35cc9@arm.com>
 <5A60AE41.2050101@rock-chips.com>
 <1f4b3c0d-1414-0012-a072-f4a11f432c21@rock-chips.com>
 <5A654925.9020203@rock-chips.com> <5A6563FA.8080602@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5A6563FA.8080602-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: JeffyChen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org
Cc: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, xxm-TNX95d0MmH7DzftRWevZcw@public.gmane.org, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, jcliang-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



On 01/22/2018 12:09 PM, JeffyChen wrote:
> Hi Randy,
> 
> On 01/22/2018 10:15 AM, JeffyChen wrote:
>> Hi Randy,
>>
>> On 01/22/2018 09:18 AM, Randy Li wrote:
>>>>
>>> Also the power domain driver could manage the clocks as well, I would
>>> suggest to use pm_runtime_*.
>>
>> actually the clocks required by pm domain may not be the same as what we
>> want to control here, there might be some clocks only be needed when
>> accessing mmu registers.
>>
>> but i'm not very sure about that, will confirm it with Simon Xue.
> 
> confirmed with Simon, there might be some iommus don't have a pd, and 
We use the pd to control the NIU node(not on upstream), without a pd or 
fake pd, none of the platform would work.
> the CONFIG_PM could be disabled.I am hard to believe a modern platform can work without that.
> 
> so it might be better to control clocks in iommu driver itself.I won't insist how the version of the iommu patch on the upstream, I 
just post an idea here.
The version for kernel 4.4 is under internal review, the implementation 
has been modified many times.

I would suggest the managing clocks in pd is a more easy way and don't 
need to spare those thing in two places.
> 
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
> 

-- 
Randy Li

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
