From: Michael Kelley <mikelley@microsoft.com>
Subject: RE: [PATCH V5 0/3] x86/Hyper-V/IOMMU: Add Hyper-V IOMMU driver to
 support x2apic mode
Date: Mon, 25 Feb 2019 20:51:22 +0000
Message-ID: <DM5PR2101MB0918EF12A3B75142EC54D754D77A0@DM5PR2101MB0918.namprd21.prod.outlook.com>
References: <1550837545-10760-1-git-send-email-Tianyu.Lan@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1550837545-10760-1-git-send-email-Tianyu.Lan@microsoft.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "joro@8bytes.org" <joro@8bytes.org>
Cc: Tianyu Lan <Tianyu.Lan@microsoft.com>, "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de" <bp@alien8.de>, "davem@davemloft.net" <davem@davemloft.net>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, Haiyang Zhang <haiyangz@microsoft.com>, "hpa@zytor.com" <hpa@zytor.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, KY Srinivasan <kys@microsoft.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>, "sashal@kernel.org" <sashal@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>, tglx@linutronix.de
List-Id: iommu@lists.linux-foundation.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com> Sent: Friday, February 22, 2019=
 4:12 AM
>=20
> On the bare metal, enabling X2APIC mode requires interrupt remapping
> function which helps to deliver irq to cpu with 32-bit APIC ID.
> Hyper-V doesn't provide interrupt remapping function so far and Hyper-V
> MSI protocol already supports to deliver interrupt to the CPU whose
> virtual processor index is more than 255. IO-APIC interrupt still has
> 8-bit APIC ID limitation.
>=20
> This patchset is to add Hyper-V stub IOMMU driver in order to enable
> X2APIC mode successfully in Hyper-V Linux guest. The driver returns X2API=
C
> interrupt remapping capability when X2APIC mode is available. X2APIC
> destination mode is set to physical by PATCH 1 when X2APIC is available.
> Hyper-V IOMMU driver will scan cpu 0~255 and set cpu into IO-APIC MAX cpu
> affinity cpumask if its APIC ID is 8-bit. Driver creates a Hyper-V irq do=
main
> to limit IO-APIC interrupts' affinity and make sure cpus assigned with IO=
-APIC
> interrupt are in the scope of IO-APIC MAX cpu affinity.
>=20
> Lan Tianyu (3):
>   x86/Hyper-V: Set x2apic destination mode to physical when x2apic is
>      available
>   HYPERV/IOMMU: Add Hyper-V stub IOMMU driver
>   MAINTAINERS: Add Hyper-V IOMMU driver into Hyper-V CORE AND DRIVERS
>     scope
>=20

Joerg -- What's your take on this patch set now that it has settled down?  =
If
you are good with it, from the Microsoft standpoint we're hoping that it
can get into linux-next this week (given the extra week due to 5.0-rc8).

Thanks,

Michael Kelley
