From: Hongbo Zhang <hongbo.zhang@linaro.org>
Subject: Re: [PATCH v9 03/19] vfio: platform: add the VFIO PLATFORM module to Kconfig
Date: Thu, 13 Nov 2014 16:05:12 +0800
Message-ID: <CAOhR-w3pB9AfXODFfzv0VthnkPwW0d5DPoW26u1xGVCR1_W6RQ@mail.gmail.com>
References: <1414433284-31719-1-git-send-email-a.motakis@virtualopensystems.com>
	<1414433284-31719-4-git-send-email-a.motakis@virtualopensystems.com>
	<CAOhR-w1nARQqtUX3nLBZYNg3PufDJMkOYeiJmpaz4fzPSZAmaQ@mail.gmail.com>
	<CAG8rG2y8T0i__-8JAnsscT3LRZOSsdSK5qJ5sPFaCirrmZZMqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAG8rG2y8T0i__-8JAnsscT3LRZOSsdSK5qJ5sPFaCirrmZZMqw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Antonios Motakis <a.motakis@virtualopensystems.com>
Cc: kvm-arm <kvmarm@lists.cs.columbia.edu>, Linux IOMMU <iommu@lists.linux-foundation.org>, Alex Williamson <alex.williamson@redhat.com>, Will Deacon <will.deacon@arm.com>, VirtualOpenSystems Technical Team <tech@virtualopensystems.com>, Christoffer Dall <christoffer.dall@linaro.org>, Eric Auger <eric.auger@linaro.org>, Kim Phillips <kim.phillips@freescale.com>, Marc Zyngier <marc.zyngier@arm.com>, open list <linux-kernel@vger.kernel.org>, "open list:VFIO DRIVER" <kvm@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On 12 November 2014 17:57, Antonios Motakis
<a.motakis@virtualopensystems.com> wrote:
> Hello Hongbo,
>
> On Wed, Nov 12, 2014 at 10:52 AM, Hongbo Zhang <hongbo.zhang@linaro.org> wrote:
>> On 28 October 2014 02:07, Antonios Motakis
>> <a.motakis@virtualopensystems.com> wrote:
>>>
>>> Enable building the VFIO PLATFORM driver that allows to use Linux platform
>>> devices with VFIO.
>>>
>>> Signed-off-by: Antonios Motakis <a.motakis@virtualopensystems.com>
>>> ---
>>>  drivers/vfio/Kconfig           | 1 +
>>>  drivers/vfio/Makefile          | 1 +
>>>  drivers/vfio/platform/Kconfig  | 9 +++++++++
>>>  drivers/vfio/platform/Makefile | 4 ++++
>>>  4 files changed, 15 insertions(+)
>>>  create mode 100644 drivers/vfio/platform/Kconfig
>>>  create mode 100644 drivers/vfio/platform/Makefile
>>>
>>> diff --git a/drivers/vfio/Kconfig b/drivers/vfio/Kconfig
>>> index a0abe04..962fb80 100644
>>> --- a/drivers/vfio/Kconfig
>>> +++ b/drivers/vfio/Kconfig
>>> @@ -27,3 +27,4 @@ menuconfig VFIO
>>>           If you don't know what to do here, say N.
>>>
>>>  source "drivers/vfio/pci/Kconfig"
>>> +source "drivers/vfio/platform/Kconfig"
>>> diff --git a/drivers/vfio/Makefile b/drivers/vfio/Makefile
>>> index 0b035b1..dadf0ca 100644
>>> --- a/drivers/vfio/Makefile
>>> +++ b/drivers/vfio/Makefile
>>> @@ -3,3 +3,4 @@ obj-$(CONFIG_VFIO_IOMMU_TYPE1) += vfio_iommu_type1.o
>>>  obj-$(CONFIG_VFIO_IOMMU_SPAPR_TCE) += vfio_iommu_spapr_tce.o
>>>  obj-$(CONFIG_VFIO_SPAPR_EEH) += vfio_spapr_eeh.o
>>>  obj-$(CONFIG_VFIO_PCI) += pci/
>>> +obj-$(CONFIG_VFIO_PLATFORM) += platform/
>>> diff --git a/drivers/vfio/platform/Kconfig b/drivers/vfio/platform/Kconfig
>>> new file mode 100644
>>> index 0000000..c51af17
>>> --- /dev/null
>>> +++ b/drivers/vfio/platform/Kconfig
>>> @@ -0,0 +1,9 @@
>>> +config VFIO_PLATFORM
>>> +       tristate "VFIO support for platform devices"
>>> +       depends on VFIO && EVENTFD && ARM
>>
>> Hi Antonios,
>> Is this only for ARM? how about X86 and PowerPC?
>> On Freescale's PowerPC platform, the IOMMU is called PAMU (Peripheral
>> Access Management Unit), and I am trying to use this VFIO framework on
>> it.
>>
>
> In principle it should be working on any platform with such devices;
> as long as you have a VFIO IOMMU driver for the PAMU (on ARM we use
> VFIO PLATFORM for the device, with VFIO IOMMU TYPE1 for the IOMMU).
>

Antonios,
As far as you know, on which ARM platform can I apply your patches directly?
My purpose is to apply you patches[1], and then implement a user space
driver to evaluate the performance.

[1]  It is better without manually merging conflicts/dependencies etc,
I am vfio-platform user, not a iommu expert.

> So if you have a suitable IOMMU driver for your target, feel free to
> test it, and let us know of the results.
>
>>>
>>> +       help
>>> +         Support for platform devices with VFIO. This is required to make
>>> +         use of platform devices present on the system using the VFIO
>>> +         framework.
>>> +
>>> +         If you don't know what to do here, say N.
>>> diff --git a/drivers/vfio/platform/Makefile b/drivers/vfio/platform/Makefile
>>> new file mode 100644
>>> index 0000000..279862b
>>> --- /dev/null
>>> +++ b/drivers/vfio/platform/Makefile
>>> @@ -0,0 +1,4 @@
>>> +
>>> +vfio-platform-y := vfio_platform.o vfio_platform_common.o
>>> +
>>> +obj-$(CONFIG_VFIO_PLATFORM) += vfio-platform.o
>>> --
>>> 2.1.1
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>> Please read the FAQ at  http://www.tux.org/lkml/
