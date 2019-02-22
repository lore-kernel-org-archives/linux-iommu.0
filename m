From: Jis Ben <jisben@google.com>
Subject: Re: [PATCH] iommu/vt-d: Handle hotplug devices' default identity
 mapping setting
Date: Fri, 22 Feb 2019 10:10:58 -0800
Message-ID: <CADChb=mw2YUTJXZnFbeXhVThuuQgFofQybzmh=foC71UT=b1Qw@mail.gmail.com>
References: <21c17b44-af9b-2f18-f109-ba4bb0635e61@linux.intel.com> <20190222082829.75567-1-xmdong@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190222082829.75567-1-xmdong@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: James Dong <xmdong@google.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

An NVMe device configured in static identity mapping should also cause
this error when removed and rescanned. Essentially, a device that does
a DMA when its driver inits, or one that you can force a DMA from.

-Jis


On Fri, Feb 22, 2019 at 12:28 AM James Dong <xmdong@google.com> wrote:
>
> Baolu:
>
> The reproduction depends on devices. HW passthrough PCIe devices with default
> identity map could have the issue. Make sure that messages like following came
> out in dmesg and their mapping does not change after booting:
>   [   10.167809] DMAR: Hardware identity mapping for device 0000:30:00.0
>   [   10.167823] DMAR: Hardware identity mapping for device 0000:30:00.1
>
> Devices which make following true could also be used for the experiment:
>   > static int iommu_should_identity_map(struct device *dev, int startup)
>   > {
>   >             if ((iommu_identity_mapping & IDENTMAP_AZALIA) && IS_AZALIA(pdev))
>   >                     return 1;
>   >             if ((iommu_identity_mapping & IDENTMAP_GFX) && IS_GFX_DEVICE(pdev))
>   >                     return 1;
>
> Once they are up, remove them first by following command:
>   echo 1 > /sys/bus/pci/devices/0000\:03\:00.1/remove
>
> Then trigger the hotplug device rescanning:
>   echo 1 > /sys/bus/pci/rescan
>
> To provide an example of specific devices on the market, I need to try out.
> Or, if it is fine with you, forcing a PCIe NIC card to be default hardware
> passthrough by changing the intel-iommu.c is another easy way to reproduce
> this issue.
>
> Best Regards,
> James
