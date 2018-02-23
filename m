From: JeffyChen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [PATCH v5 08/13] iommu/rockchip: Control clocks needed to access
	the IOMMU
Date: Fri, 23 Feb 2018 18:24:06 +0800
Message-ID: <5A8FEBC6.4000408@rock-chips.com>
References: <20180124103516.2571-1-jeffy.chen@rock-chips.com>
	<20180124103516.2571-9-jeffy.chen@rock-chips.com>
	<20180130170515.3g6wtadqgmehxh5b@rob-hp-laptop>
	<CAAFQd5A383Ey3Ntg_hcsvzHj2DsSuW6RMQ+kP=LPAZ1YmqjHOg@mail.gmail.com>
	<CAL_JsqKFW0USD_TgGCO-s4wMBw9O2psToMObjeSEwCNReq-3=w@mail.gmail.com>
	<5A72F7D2.1050201@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <5A72F7D2.1050201-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, list-Y9sIeH5OGRo@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ricky Liang <jcliang-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "list-Y9sIeH5OGRo@public.gmane.org:IOMMU DRIVERS" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, open-Y9sIeH5OGRo@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi guys,

On 02/01/2018 07:19 PM, JeffyChen wrote:
>>>>>
>>>>>
>>>>> diff --git
>>>>> a/Documentation/devicetree/bindings/iommu/rockchip,iommu.txt
>>>>> b/Documentation/devicetree/bindings/iommu/rockchip,iommu.txt
>>>>> index 2098f7732264..33dd853359fa 100644
>>>>> --- a/Documentation/devicetree/bindings/iommu/rockchip,iommu.txt
>>>>> +++ b/Documentation/devicetree/bindings/iommu/rockchip,iommu.txt
>>>>> @@ -14,6 +14,13 @@ Required properties:
>>>>>                       "single-master" device, and needs no
>>>>> additional information
>>>>>                       to associate with its master device.  See:
>>>>>
>>>>> Documentation/devicetree/bindings/iommu/iommu.txt
>>>>> +Optional properties:
>>>>> +- clocks : A list of master clocks requires for the IOMMU to be
>>>>> accessible
>>>>> +           by the host CPU. The number of clocks depends on the
>>>>> master
>>>>> +           block and might as well be zero. See [1] for generic clock
>>>>> +           bindings description.
>>>>
>>>> Hardware blocks don't have a variable number of clock connections.
>>>
>>> I think you underestimate the imagination of hardware designers. :)
>>
>> Learned long ago to never do that. If there are 2 ways to do
>> something, they will find a 3rd way.
>>
>>> For Rockchip IOMMU, there is a set of clocks, which all need to be
>>> enabled for IOMMU register access to succeed. The clocks are not
>>> directly fed to the IOMMU, but they are needed for the various buses
>>> and intermediate blocks on the way to the IOMMU to work.
>>
>> The binding should describe the clock connections, not what clocks a
>> driver needs (currently). It sounds like a lack of managing bus clocks
>> to me.
>>
>> In any case, the binding must be written so it can be verified. If you
>> can have any number of clocks with any names, there's no point in
>> documenting.
>
> the rockchip IOMMU is part of the master block in hardware, so it needs
> to control the master's power domain and some of the master's clocks
> when access it's registers.
>
> and the number of clocks needed here, might be different between each
> IOMMUs(according to which master block it belongs), it's a little like
> our power domain:
> https://elixir.free-electrons.com/linux/latest/source/arch/arm64/boot/dts/rockchip/rk3399.dtsi#L935
>
>
> i'm not sure how to describe this correctly, is it ok use something like
> "the same as it's master block"?

would it make sense to add a property to specify the master who owns the 
iommu, and we can get all clocks(only some of those clocks are actually 
needed) from it in the of_xlate()? and we can also reuse the clock-names 
of that master to build clk_bulk_data and log errors in clk_bulk_get.

>
>>
>> Rob
