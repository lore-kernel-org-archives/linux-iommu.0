From: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v4 07/13] ARM: dts: rockchip: add clocks in vop iommu nodes
Date: Fri, 19 Jan 2018 14:12:39 +0900
Message-ID: <CAAFQd5D2FO4bXh7djKyyE0s_pq8N_9YxxmkDJizoem_fLxTk0g@mail.gmail.com>
References: <20180118115251.5542-1-jeffy.chen@rock-chips.com>
	<20180118115251.5542-8-jeffy.chen@rock-chips.com>
	<CAAFQd5ACbV6Q2Jwze=hoG=13jSJKkYyDDs2HzvvdSK-RGK+w2g@mail.gmail.com>
	<5A617A5E.6070606@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <5A617A5E.6070606-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: JeffyChen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Ricky Liang <jcliang-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "list-Y9sIeH5OGRo@public.gmane.org:IOMMU DRIVERS" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "list-Y9sIeH5OGRo@public.gmane.org:IOMMU DRIVERS <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>,
	Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, " <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Jan 19, 2018 at 1:55 PM, JeffyChen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org> wrote:
> Hi Tomasz,
>
> Thanks for your reply.
>
>
> On 01/19/2018 11:23 AM, Tomasz Figa wrote:
>>
>> On Thu, Jan 18, 2018 at 8:52 PM, Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
>> wrote:
>>>
>>> Add clocks in vop iommu nodes, since we are going to control clocks in
>>> rockchip iommu driver.
>>>
>>> Signed-off-by: Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
>>> ---
>>>
>>> Changes in v4: None
>>> Changes in v3: None
>>> Changes in v2: None
>>>
>>>   arch/arm/boot/dts/rk3036.dtsi | 2 ++
>>>   arch/arm/boot/dts/rk3288.dtsi | 4 ++++
>>>   2 files changed, 6 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/rk3036.dtsi
>>> b/arch/arm/boot/dts/rk3036.dtsi
>>> index 3b704cfed69a..95b0ebc7a40f 100644
>>> --- a/arch/arm/boot/dts/rk3036.dtsi
>>> +++ b/arch/arm/boot/dts/rk3036.dtsi
>>> @@ -197,6 +197,8 @@
>>>                  reg = <0x10118300 0x100>;
>>>                  interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
>>>                  interrupt-names = "vop_mmu";
>>> +               clocks = <&cru ACLK_LCDC>, <&cru SCLK_LCDC>, <&cru
>>> HCLK_LCDC>;
>>> +               clock-names = "aclk_vop", "dclk_vop", "hclk_vop";
>>
>>
>> We should remove clock-names from IOMMU nodes. The Rockchip IOMMU
>> bindings don't define clock names and only the clocks property should
>> be given.
>>
> hmmm, i'm trying to switch to clk_bulk APIs, the get and put are name based.
> or maybe i can use clk_get/put along with other clk_bulk APIs

I think it should be possible to just put the clock pointers to the
clk_bulk_data struct manually. Otherwise, I'm not sure what names we
could use for clock-names, since the clocks depend on master.
(Something like "clock0, clock1, clock2, ..., clockN" could work, but
it doesn't add any value IMHO...).
