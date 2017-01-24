From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH/RFC 2/2] iommu/ipmmu-vmsa: Opt-in slave devices based on
 ES version
Date: Tue, 24 Jan 2017 11:32:40 +0100
Message-ID: <CAMuHMdULA66ZQrBQC6Fp9LGfDxh3AboBL_ZA+EThqAaRa5iM+Q@mail.gmail.com>
References: <148517349585.18128.10696161017872202809.sendpatchset@little-apple>
 <148517354599.18128.1970642879780864733.sendpatchset@little-apple>
 <CAMuHMdWyV4DWN5pKsp+Z6C0MhZF5fKch4T1g1_Hbk3oxrR6_zw@mail.gmail.com> <CANqRtoQayo4_nBuTN--6kt4JRGW7VM-6vMvb8AX22bO=MG8-9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <CANqRtoQayo4_nBuTN--6kt4JRGW7VM-6vMvb8AX22bO=MG8-9g@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: iommu@lists.linux-foundation.org, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Joerg Roedel <joro@8bytes.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Simon Horman <horms+renesas@verge.net.au>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: iommu@lists.linux-foundation.org

Hi Magnus,

On Tue, Jan 24, 2017 at 10:38 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> On Mon, Jan 23, 2017 at 9:50 PM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> On Mon, Jan 23, 2017 at 1:12 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
>>> From: Magnus Damm <damm+renesas@opensource.se>
>>>
>>> Match on r8a7795 ES2 and enable a certain DMA controller.
>>> In other cases the IPMMU driver remains disabled.
>>>
>>> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
>>> ---
>>>
>>>  drivers/iommu/ipmmu-vmsa.c |   24 ++++++++++++++++++++++++
>>>  1 file changed, 24 insertions(+)
>>>
>>> --- 0001/drivers/iommu/ipmmu-vmsa.c
>>> +++ work/drivers/iommu/ipmmu-vmsa.c     2017-01-23 20:57:02.620607110 +0900
>>> @@ -23,6 +23,7 @@
>>>  #include <linux/platform_device.h>
>>>  #include <linux/sizes.h>
>>>  #include <linux/slab.h>
>>> +#include <linux/sys_soc.h>
>>>
>>>  #if defined(CONFIG_ARM) && !defined(CONFIG_IOMMU_DMA)
>>>  #include <asm/dma-iommu.h>
>>> @@ -1002,16 +1003,39 @@ static void ipmmu_domain_free_dma(struct
>>>         }
>>>  }
>>>
>>> +static const struct soc_device_attribute r8a7795es2[] = {
>>> +       { .soc_id = "r8a7795", .revision = "ES2.*" },
>>> +       { /* sentinel */ }
>>> +};
>>> +
>>> +static int ipmmu_slave_whitelist(struct device *dev)
>>> +{
>>> +       /* Opt-in slave devices based on SoC and ES version */
>>> +       if (soc_device_match(r8a7795es2)) {
>>> +               if (!strcmp(dev_name(dev), "e7310000.dma-controller"))
>>> +                       return 0;
>>> +       }
>>
>> I have two comments about the construct above:
>>   1. IPMMU will be disabled on all non-r8a7795 SoCs.
>>      Is that what you want?
>
> Sort of. This patch is just an example to stir up some discussion
> about this topic. I realize this code as-is changes R-Car Gen2
> behavior (that is merged upstream) so perhaps we should keep devices
> enabled for those SoCs.

Indeed.
Note that we don't have any "iommus" in upstream R-Car Gen2 DTSes.

>>   2. Usually we match on the old broken versions instead (e.g. against
>>      "ES1.*"), as (1) it marks more clearly support for old SoCs, and
>>                 (2) it makes it easier to remove the check later when these
>>                     old SoCs are deemed extinct later.
>
> Right, if I understand correctly then you're saying opt-out might be
> better instead of opt-in. In case of IPMMU and R-Car Gen3 I believe it
> might be less work to use opt-in rather than excluding not-yet-working
> stuff. =)

Unfortunately that may be true :-(

> With this series I would like to propose to disconnect the DT
> integration timing from the enablement of IPMMU support for slave
> devices. If we can enable the IPMMU in DT early on we can reduce
> potential out-of-tree IPMMU enablement DT patches. So with the DT
> bindings fixed and accurate data sheet we can merge DT bits ahead of
> enablement time. And then use run time logic to determine what to
> enable based on test results.
>
> As you are aware, currently we have used the presence of "iommus" in
> DT to determine if a device is going to be enabled or not. So if the
> IPMMU Kconfig bits enable the IPMMU driver and the "iommus" DT
> property tie a certain slave device to the IPMMU then we will make use
> of IPMMU for a certain device. Currently we assume it will work on all
> ES versions that use that particular DTB.
>
> However ES specific hardware errata together with a wide range of ES
> versions for r8a7795 and r8a7796 (and whatever SoCs and ES versions
> that comes next) makes it difficult to use DT like above to enable
> stuff seemingly on one ES version without potentially breaking other
> ES versions. I would like to share DT files between the ES versions as
> much as possible but still only enable IPMMU support for devices that
> are known to work.
>
> Let me know if you think it makes sense to enable DT in a different
> way than my proposal.

That makes perfect sense to me: DT describes (ideal production) hardware,
and errata are handled in C code and tables.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
