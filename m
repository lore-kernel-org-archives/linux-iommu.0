From: Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 05/12] memory: Add NVIDIA Tegra memory controller support
Date: Sat, 1 Nov 2014 14:38:26 +0900
Message-ID: <CAAVeFuKgMAF4LML5G=2k00No4AKDj7MTHB6ByXEvPzaSsAPUXg@mail.gmail.com>
References: <1413196434-5292-1-git-send-email-thierry.reding@gmail.com>
 <1413196434-5292-5-git-send-email-thierry.reding@gmail.com>
 <CAOesGMgDE_PZHrrEhntnce2AMsdtAb9+i5XuxP-Q7j--432zpw@mail.gmail.com>
 <20141030150839.GG20072@ulmo.nvidia.com> <20141031132740.GA9371@ulmo.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141031132740.GA9371-AwZRO8vwLAwmlAP/+Wk3EA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Oct 31, 2014 at 10:27 PM, Thierry Reding
<thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On Thu, Oct 30, 2014 at 04:08:41PM +0100, Thierry Reding wrote:
>> On Wed, Oct 15, 2014 at 03:09:30PM -0700, Olof Johansson wrote:
>> > Hi,
>> >
>> > Oh, a few more comments:
>> >
>> > On Mon, Oct 13, 2014 at 3:33 AM, Thierry Reding
>> > <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> >
>> > > diff --git a/drivers/memory/Makefile b/drivers/memory/Makefile
>> > > index c32d31981be3..1c932e7e7b8d 100644
>> > > --- a/drivers/memory/Makefile
>> > > +++ b/drivers/memory/Makefile
>> > > @@ -12,4 +12,5 @@ obj-$(CONFIG_FSL_CORENET_CF)  += fsl-corenet-cf.o
>> > >  obj-$(CONFIG_FSL_IFC)          += fsl_ifc.o
>> > >  obj-$(CONFIG_MVEBU_DEVBUS)     += mvebu-devbus.o
>> > >  obj-$(CONFIG_TEGRA20_MC)       += tegra20-mc.o
>> > > -obj-$(CONFIG_TEGRA30_MC)       += tegra30-mc.o
>> > > +
>> > > +obj-$(CONFIG_ARCH_TEGRA)       += tegra/
>> > > diff --git a/drivers/memory/tegra/Makefile b/drivers/memory/tegra/Makefile
>> > > new file mode 100644
>> > > index 000000000000..51b9e8fcde1b
>> > > --- /dev/null
>> > > +++ b/drivers/memory/tegra/Makefile
>> > > @@ -0,0 +1,5 @@
>> > > +obj-y                                   = tegra-mc.o
>> > > +obj-$(CONFIG_ARCH_TEGRA_3x_SOC)                += tegra30-mc.o
>> > > +obj-$(CONFIG_ARCH_TEGRA_114_SOC)       += tegra114-mc.o
>> > > +obj-$(CONFIG_ARCH_TEGRA_124_SOC)       += tegra124-mc.o
>> > > +obj-$(CONFIG_ARCH_TEGRA_132_SOC)       += tegra124-mc.o
>> >
>> > You'll need a Kconfig and not just a makefile -- there are definitely
>> > dependencies on this driver (IOMMU in particular).
>>
>> This is handled within the tegra-mc driver by only setting up the IOMMU
>> when TEGRA_IOMMU_SMMU is enabled. That config option remains in place.
>>
>> > Also, the problem of having a global enable bit that is only under
>> > control of TrustZone FW is a big problem -- if the bit is not set, the
>> > driver will not work (and the machine will crash).
>> >
>> > I think you'll need to come up with a way to detect that in the
>> > driver. I don't have a good idea of how it can be done though.
>>
>> I don't think I ever got back to you on this. We discussed this
>> internally and it seems like there's no way to detect this properly, so
>> the best suggestion so far was to make it a requirement on the secure
>> firmware to enable IOMMU or not. Since there's no way for the kernel to
>> detect whether IOMMU was enabled or not, I think the firmware would
>> equally have to adjust the SMMU's device tree node's status property
>> appropriately.
>
> The other option would be for the firmware not to touch the SMMU device
> tree node and the kernel simply assuming that if it's running in non-
> secure mode then there must be secure firmware and it has enabled the
> SMMU. Enabling the SMMU would become part of the contract between
> firmware and kernel, much like locking the VPR is required to get the
> GPU to work.
>
> Those are really the only two choices we have.

We got the exact same problem with GPU and VPR registers, and it seems
like the approach we will be taking here is to have the
firmware/bootloader do whatever is needed to get the GPU working and
enable the DT node once it did. IOW, the kernel will never touch
protected registers, and will not freeze if the hardware is not
properly set up.

It would be nice for consistency if the same approach can be taken
with the IOMMU. OTOH we will need to make sure that all these
initialization contracts are clearly documented somewhere. Maybe a
comment in the DTS to explain what is expected from the firmware to
enable such nodes would be a good idea, too.
