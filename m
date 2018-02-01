From: JeffyChen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [PATCH v5 08/13] iommu/rockchip: Control clocks needed to access
	the IOMMU
Date: Thu, 01 Feb 2018 19:19:46 +0800
Message-ID: <5A72F7D2.1050201@rock-chips.com>
References: <20180124103516.2571-1-jeffy.chen@rock-chips.com>
	<20180124103516.2571-9-jeffy.chen@rock-chips.com>
	<20180130170515.3g6wtadqgmehxh5b@rob-hp-laptop>
	<CAAFQd5A383Ey3Ntg_hcsvzHj2DsSuW6RMQ+kP=LPAZ1YmqjHOg@mail.gmail.com>
	<CAL_JsqKFW0USD_TgGCO-s4wMBw9O2psToMObjeSEwCNReq-3=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAL_JsqKFW0USD_TgGCO-s4wMBw9O2psToMObjeSEwCNReq-3=w@mail.gmail.com>
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

Hi Rob,

Thanks for your reply.

On 01/31/2018 09:50 PM, Rob Herring wrote:
> On Wed, Jan 31, 2018 at 1:52 AM, Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> wrote:
>> Hi Rob,
>>
>> On Wed, Jan 31, 2018 at 2:05 AM, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>>> On Wed, Jan 24, 2018 at 06:35:11PM +0800, Jeffy Chen wrote:
>>>> From: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
>>>>
>>>> Current code relies on master driver enabling necessary clocks before
>>>> IOMMU is accessed, however there are cases when the IOMMU should be
>>>> accessed while the master is not running yet, for example allocating
>>>> V4L2 videobuf2 buffers, which is done by the VB2 framework using DMA
>>>> mapping API and doesn't engage the master driver at all.
>>>>
>>>> This patch fixes the problem by letting clocks needed for IOMMU
>>>> operation to be listed in Device Tree and making the driver enable them
>>>> for the time of accessing the hardware.
>>>>
>>>> Signed-off-by: Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
>>>> Signed-off-by: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
>>>> ---
>>>>
>>>> Changes in v5:
>>>> Use clk_bulk APIs.
>>>>
>>>> Changes in v4: None
>>>> Changes in v3: None
>>>> Changes in v2: None
>>>>
>>>>   .../devicetree/bindings/iommu/rockchip,iommu.txt   |  8 +++
>>>
>>> Please split binding patches to a separate patch.
right, i'll do that in the next version.
>>>
>>>>   drivers/iommu/rockchip-iommu.c                     | 74 ++++++++++++++++++++--
>>>>   2 files changed, 76 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/iommu/rockchip,iommu.txt b/Documentation/devicetree/bindings/iommu/rockchip,iommu.txt
>>>> index 2098f7732264..33dd853359fa 100644
>>>> --- a/Documentation/devicetree/bindings/iommu/rockchip,iommu.txt
>>>> +++ b/Documentation/devicetree/bindings/iommu/rockchip,iommu.txt
>>>> @@ -14,6 +14,13 @@ Required properties:
>>>>                       "single-master" device, and needs no additional information
>>>>                       to associate with its master device.  See:
>>>>                       Documentation/devicetree/bindings/iommu/iommu.txt
>>>> +Optional properties:
>>>> +- clocks : A list of master clocks requires for the IOMMU to be accessible
>>>> +           by the host CPU. The number of clocks depends on the master
>>>> +           block and might as well be zero. See [1] for generic clock
>>>> +           bindings description.
>>>
>>> Hardware blocks don't have a variable number of clock connections.
>>
>> I think you underestimate the imagination of hardware designers. :)
>
> Learned long ago to never do that. If there are 2 ways to do
> something, they will find a 3rd way.
>
>> For Rockchip IOMMU, there is a set of clocks, which all need to be
>> enabled for IOMMU register access to succeed. The clocks are not
>> directly fed to the IOMMU, but they are needed for the various buses
>> and intermediate blocks on the way to the IOMMU to work.
>
> The binding should describe the clock connections, not what clocks a
> driver needs (currently). It sounds like a lack of managing bus clocks
> to me.
>
> In any case, the binding must be written so it can be verified. If you
> can have any number of clocks with any names, there's no point in
> documenting.

the rockchip IOMMU is part of the master block in hardware, so it needs 
to control the master's power domain and some of the master's clocks 
when access it's registers.

and the number of clocks needed here, might be different between each 
IOMMUs(according to which master block it belongs), it's a little like 
our power domain:
https://elixir.free-electrons.com/linux/latest/source/arch/arm64/boot/dts/rockchip/rk3399.dtsi#L935

i'm not sure how to describe this correctly, is it ok use something like 
"the same as it's master block"?

>
> Rob
>
>
>
