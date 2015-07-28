From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v3 3/6] iommu: add ARM short descriptor page table
	allocator.
Date: Tue, 28 Jul 2015 12:00:23 +0100
Message-ID: <20150728110023.GH29209@arm.com>
References: <1437037475-9065-1-git-send-email-yong.wu@mediatek.com>
	<1437037475-9065-4-git-send-email-yong.wu@mediatek.com>
	<20150721171101.GN31095@arm.com>
	<1437715466.23932.68.camel@mhfsdcap03>
	<20150724165325.GC21177@arm.com>
	<1437970868.25925.20.camel@mhfsdcap03> <55B63AB2.4050006@arm.com>
	<20150727141102.GJ3358@arm.com>
	<1438060094.25925.69.camel@mhfsdcap03>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1438060094.25925.69.camel@mhfsdcap03>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, Catalin Marinas <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, "cloud.chou-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org" <cloud.chou-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "frederic.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org" <frederic.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org" <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org" <srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Daniel Kurtz <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Sasha Hauer <kernel@pen>
List-Id: iommu@lists.linux-foundation.org

On Tue, Jul 28, 2015 at 06:08:14AM +0100, Yong Wu wrote:
> On Mon, 2015-07-27 at 15:11 +0100, Will Deacon wrote:
> > On Mon, Jul 27, 2015 at 03:05:38PM +0100, Robin Murphy wrote:
> > > On 27/07/15 05:21, Yong Wu wrote:
> > > >>>>> +       } else {        /* page or largepage */
> > > >>>>> +               if (quirk & IO_PGTABLE_QUIRK_SHORT_MTK) {
> > > >>>>> +                       if (large) { /* special Bit */
> > > >>>>
> > > >>>> This definitely needs a better comment! What exactly are you doing here
> > > >>>> and what is that quirk all about?
> > > >>>
> > > >>> I use this quirk is for MTK Special Bit as we don't have the XN bit in
> > > >>> pagetable.
> > > >>
> > > >> I'm still not really clear about what this is.
> > > >
> > > > There is some difference between the standard spec and MTK HW,
> > > > Our hw don't implement some bits, like XN and AP.
> > > > So I add a quirk for MTK special.
> > > 
> > > When you say it doesn't implement these bits, do you mean that having 
> > > them set will lead to Bad Things happening in the hardware, or that it 
> > > will simply ignore them and not enforce any of the protections they 
> > > imply? The former case would definitely want clearly documenting 
> > > somewhere, whereas for the latter case I'm not sure it's even worth the 
> > > complication of having a quirk - if the value doesn't matter there seems 
> > > little point in doing a special dance just for the sake of semantic 
> > > correctness of the in-memory PTEs, in my opinion.
> > 
> > Agreed. We should only use quirks if the current (architecturally
> > compliant) code causes real issues with the hardware. Then the quirk can
> > be used to either avoid the problematic routines or to take extra steps
> > to make things work as the architecture intended.
> > 
> > I've asked how this IOMMU differs from the architecture on a number of
> > occasions, but I'm still yet to receive a response other than "it's special".
> > 
> 
> After check further with DE, Our pagetable is refer to ARM-v7's
> short-descriptor which is a little different from ARM-v8. like bit0(PXN)
> in section and supersection, I didn't read ARM-v7 spec before, so I add
> a MTK quirk to disable PXN bit in section and supersection.(if the PXN
> bit is wrote in ARM-v7 spec, HW will page fault.)

I've been reviewing this using the ARMv7 ARM (Rev.C of DDI0406C) the whole
time. PXN is there as an optional field in non-LPAE implementations. That's
fine and doesn't require any quirks.

> Then I write this code according to ARM-v8 spec defaultly, and add a
> ARM-v7 quirk?

No, I don't think you need this, as the v8 and v7 short-descriptor formats
look compatible to me. You should only need a quirk if architecturally
compliant code cannot work on your hardware.

> And there is a little different between ARM-v7 spec and MTK pagetable.
> It's the XN(bit0) in small page. MTK don't implement XN bit. 
> The bit[1:0] in MTK's small page should be 2'b10, if it's 2'b11, HW will
> page fault.

Aha, thanks! *That* is worthy of a quirk. Something like:

  IO_PGTABLE_QUIRK_ARM_NO_XN

> (MTK don't implement AP bits too, but HW don't use them, it is ok even
> though AP bits is wrote)

Yeah, I think that's fine. The pgtable code will honour the request but
the h/w will ignore it.

> In the end, I will add two quirk like this, is it OK?

I think you only need the one I mentioned above. I don't see the need
for PXN at all (as I said in the last review).

Will
