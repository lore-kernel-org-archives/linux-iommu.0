From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v5 08/13] iommu/rockchip: Control clocks needed to access
	the IOMMU
Date: Wed, 28 Feb 2018 15:06:19 +0000
Message-ID: <34a60ab2-a3af-3302-6612-740cba5460db@arm.com>
References: <20180124103516.2571-1-jeffy.chen@rock-chips.com>
	<20180124103516.2571-9-jeffy.chen@rock-chips.com>
	<20180130170515.3g6wtadqgmehxh5b@rob-hp-laptop>
	<CAAFQd5A383Ey3Ntg_hcsvzHj2DsSuW6RMQ+kP=LPAZ1YmqjHOg@mail.gmail.com>
	<CAL_JsqKFW0USD_TgGCO-s4wMBw9O2psToMObjeSEwCNReq-3=w@mail.gmail.com>
	<5A72F7D2.1050201@rock-chips.com> <5A8FEBC6.4000408@rock-chips.com>
	<33d1d6bd-3455-5cad-6990-a9ca94063f3a@arm.com>
	<5A96A809.2020509@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <5A96A809.2020509-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
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
To: JeffyChen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ricky Liang <jcliang-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "list-Y9sIeH5OGRo@public.gmane.org:IOMMU DRIVERS" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 28/02/18 13:00, JeffyChen wrote:
> Hi Robin,
> 
> Thanks for your reply.
> 
> On 02/28/2018 12:59 AM, Robin Murphy wrote:
>>>> the rockchip IOMMU is part of the master block in hardware, so it needs
>>>> to control the master's power domain and some of the master's clocks
>>>> when access it's registers.
>>>>
>>>> and the number of clocks needed here, might be different between each
>>>> IOMMUs(according to which master block it belongs), it's a little like
>>>> our power domain:
>>>> https://elixir.free-electrons.com/linux/latest/source/arch/arm64/boot/dts/rockchip/rk3399.dtsi#L935 
>>>>
>>>>
>>>>
>>>>
>>>> i'm not sure how to describe this correctly, is it ok use something 
>>>> like
>>>> "the same as it's master block"?
>>>
>>> would it make sense to add a property to specify the master who owns
>>> the iommu, and we can get all clocks(only some of those clocks are
>>> actually needed) from it in the of_xlate()? and we can also reuse the
>>> clock-names of that master to build clk_bulk_data and log errors in
>>> clk_bulk_get.
>>
>> I'm inclined to agree with Rob here - if we're to add anything to the
>> binding, it should only be whatever clock inputs are defined for the
>> IOMMU IP block itself. If Linux doesn't properly handle the interconnect
>> clock hierarchy external to a particular integration, that's a separate
>> issue and it's not the binding's problem.
>>
>> I actually quite like the hack of "borrowing" the clocks from
>> dev->of_node in of_xlate() - you shouldn't need any DT changes for that,
>> because you already know that each IOMMU instance only has the one
>> master device anyway.
> 
> Thanks:) but actually we are going to support sharing IOMMU between 
> multiple masters(one of them is the main master i think) in the newer 
> chips(not yet supported on upstream kernel)...

Ha! OK, fair enough, back to the first point then...

> So we might have to get all clocks from all masters, or find a way to 
> specify the main master...and for the multiple masters case, do it in 
> of_xlate() turns out to be a little racy...maybe we can add a property 
> to specify main master, and get it's clocks in probe()?

I notice that the 4.4 BSP kernel consistently specifies "aclk" and 
"hclk" for the IOMMU instances - it feels unusual to say "why don't we 
follow the downstream binding?", but it does look a lot like what I 
would expect (I'd guess at one for the register slave interface and one 
for the master interface/general operation?)

If we can implement conceptually-correct clock handling based on an 
accurate binding, which should cover most cases, and *then* look at 
hacking around those where it doesn't quite work in practice due to 
shortcomings elsewhere, that would be ideal, and of course a lot nicer 
than just jumping straight into piles of hacks.

Robin.
