From: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4] devicetree: Add generic IOMMU device tree bindings
Date: Wed, 30 Jul 2014 13:08:23 -0500
Message-ID: <CAL_JsqLXKer_PAaYNakB9LDNuyQUZLOCHWry4FbybK3KpDZSDg@mail.gmail.com>
References: <1404487757-18829-1-git-send-email-thierry.reding@gmail.com>
 <20140730110425.GI12239@arm.com> <20140730132348.GM29590@ulmo> <20140730143037.GD8989@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140730143037.GD8989-5wv7dgnIgG8@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <Pawel.Moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Dave P Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>, Marc Zyngier <Marc.Zyngier-5wv7dgnIgG8@public.gmane.org>, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Olav Haugan <ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Varun Sethi <varun.sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-ker
List-Id: iommu@lists.linux-foundation.org

On Wed, Jul 30, 2014 at 9:30 AM, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
> On Wed, Jul 30, 2014 at 02:23:50PM +0100, Thierry Reding wrote:
>> On Wed, Jul 30, 2014 at 12:04:25PM +0100, Will Deacon wrote:
>> > On Fri, Jul 04, 2014 at 04:29:17PM +0100, Thierry Reding wrote:
>> > > From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>> > >
>> > > This commit introduces a generic device tree binding for IOMMU devices.
>> > > Only a very minimal subset is described here, but it is enough to cover
>> > > the requirements of both the Exynos System MMU and Tegra SMMU as
>> > > discussed here:
>> > >
>> > >     https://lkml.org/lkml/2014/4/27/346
>> > >
>> > > Signed-off-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>> > > ---
>> > > Changes in v4:
>> > > - clarify that disabling an IOMMU DT node may not disable translation
>> > > - be more explicit that examples are only examples
>> > > - add multi-ID master example
>> > >
>> > > Changes in v3:
>> > > - use #iommu-cells instead of #address-cells/#size-cells
>> > > - drop optional iommu-names property
>> > >
>> > > Changes in v2:
>> > > - add notes about "dma-ranges" property (drop note from commit message)
>> > > - document priorities of "iommus" property vs. "dma-ranges" property
>> > > - drop #iommu-cells in favour of #address-cells and #size-cells
>> > > - remove multiple-master device example
>> > >
>> > >  Documentation/devicetree/bindings/iommu/iommu.txt | 172 ++++++++++++++++++++++
>> > >  1 file changed, 172 insertions(+)
>> > >  create mode 100644 Documentation/devicetree/bindings/iommu/iommu.txt
>> >
>> > I'm concerned that this patch hasn't been picked up for 3.17 (I can't see it
>> > in -next). If we want to move the ARM SMMU driver over to this new binding,
>> > we can't keep dragging our feet for much longer as I *really* don't plan to
>> > support two bindings in parallel (one is complicated enough already).
>> >
>> > Any chance we can see this merged, please?
>>
>> I think there weren't any comments left for me to address and I've
>> mostly been waiting for Joerg to pick it up.
>>
>> Joerg, can you take this through the iommu tree for 3.17? Will acked
>> this, but perhaps you were waiting for an ACK from the device tree
>> bindings maintainers?
>
> Rob, Mark: can one or both of you take a look at this please?

I've been quiet on this round, but I think prior input I've had has
been addressed. If we believe this will work for ARM SMMU and MSM
IOMMU and some of the crazy chaining scenarios, then I'm fine with the
binding.

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

Rob

P.S. Thankfully, there are no Calxeda systems with the SMMU enabled,
so a binding change should not cause much pain.
