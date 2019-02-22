From: Michael Kelley <mikelley@microsoft.com>
Subject: RE: [PATCH V5 2/3] HYPERV/IOMMU: Add Hyper-V stub IOMMU driver
Date: Fri, 22 Feb 2019 15:58:44 +0000
Message-ID: <DM5PR2101MB0918926EDE4D256EC16637A7D77F0@DM5PR2101MB0918.namprd21.prod.outlook.com>
References: <1550837545-10760-1-git-send-email-Tianyu.Lan@microsoft.com>
 <1550837545-10760-3-git-send-email-Tianyu.Lan@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1550837545-10760-3-git-send-email-Tianyu.Lan@microsoft.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Cc: Tianyu Lan <Tianyu.Lan@microsoft.com>, "joro@8bytes.org" <joro@8bytes.org>, "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>, "arnd@arndb.de" <arnd@arndb.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, KY Srinivasan <kys@microsoft.com>, vkuznets <vkuznets@redhat.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "sashal@kernel.org" <sashal@kernel.org>, "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

From: Tianyu.Lan@microsoft.com <Tianyu.Lan@microsoft.com> Sent: Friday, Feb=
ruary 22, 2019 4:12 AM
>=20
> On the bare metal, enabling X2APIC mode requires interrupt remapping
> function which helps to deliver irq to cpu with 32-bit APIC ID.
> Hyper-V doesn't provide interrupt remapping function so far and Hyper-V
> MSI protocol already supports to deliver interrupt to the CPU whose
> virtual processor index is more than 255. IO-APIC interrupt still has
> 8-bit APIC ID limitation.
>=20
> This patch is to add Hyper-V stub IOMMU driver in order to enable
> X2APIC mode successfully in Hyper-V Linux guest. The driver returns X2API=
C
> interrupt remapping capability when X2APIC mode is available. Otherwise,
> it creates a Hyper-V irq domain to limit IO-APIC interrupts' affinity
> and make sure cpus assigned with IO-APIC interrupt have 8-bit APIC ID.
>=20
> Define 24 IO-APIC remapping entries because Hyper-V only expose one
> single IO-APIC and one IO-APIC has 24 pins according IO-APIC spec(
> https://pdos.csail.mit.edu/6.828/2016/readings/ia32/ioapic.pdf).
>=20
> Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
> ---
> Change since v4:
>        - Fix the loop of scan cpu's APIC id
>=20
> Change since v3:
>        - Make Hyper-V IOMMU as Hyper-V default driver
>        - Fix hypervisor_is_type() input parameter
>        - Check possible cpu numbers during scan 0~255 cpu's apic id.
>=20
> Change since v2:
>        - Improve comment about why save IO-APIC entry in the irq chip dat=
a.
>        - Some code improvement.
>        - Improve statement in the IOMMU Kconfig.
>=20
> Change since v1:
>       - Remove unused pr_fmt
>       - Make ioapic_ir_domain as static variable
>       - Remove unused variables cfg and entry in the hyperv_irq_remapping=
_alloc()
>       - Fix comments

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
