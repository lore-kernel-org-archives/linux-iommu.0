From: Krishna Reddy <vdumpa@nvidia.com>
Subject: RE: [PATCH v2 0/5] Add Tegra194 Dual ARM SMMU driver
Date: Tue, 27 Nov 2018 02:30:05 +0000
Message-ID: <BYAPR12MB27598D08E89D93CD8C171993B3D00@BYAPR12MB2759.namprd12.prod.outlook.com>
References: <1541029430-14150-1-git-send-email-vdumpa@nvidia.com>
 <20181126235856.vnseoe5lucfryc5p@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181126235856.vnseoe5lucfryc5p@localhost>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: "will.deacon@arm.com" <will.deacon@arm.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>, "joro@8bytes.org" <joro@8bytes.org>, Sachin Nikam <Snikam@nvidia.com>, Pritesh Raithatha <praithatha@nvidia.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Timo Alho <talho@nvidia.com>, Yu-Huan Hsu <YHsu@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Thierry Reding <treding@nvidia.com>, Alexander Van Brunt <avanbrunt@nvidia.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Juha Tukkinen <jtukkinen@nvidia.com>
List-Id: iommu@lists.linux-foundation.org

Hi Olof,
Thanks for the comments!

>>Based on what I can see, it seems that you're trying to describe two
pieces of hardware with only one device in the DT. That seems like an
odd choice.=20

T194 SOC HW is designed to use Two ARM SMMU's together like one SMMU.
The IOVA accesses from the HW controllers clients is interleaved across the=
se Two
SMMU's by Memory controller HW.
Even though,  there are two ARM SMMU's,  HW design requires SW programming
these two ARM SMMU instances identically.

>>Also, it seems like all three SMMUs share the same interrupt
line? That's somewhat suboptimal IMHO, but harder to change.

This is by HW design.  SMMU interrupts are only expected if there is an ill=
egal IOVA
access, which shouldn't happen in practical. The SMMU interrupts are only u=
sed
to log the faults and for debug purpose on T194.


>>Why not instantiate both of them and create a reference between then
such that the TLB and sync ops are done on both of them in the native
driver? I.e. two arm_smmu structs and a pointer between then (i.e. add a
"next shared smmu" pointer in the struct arm_smmu).

DMA framework supports only one SMMU driver instance per device.
SMMU driver setup iommu_ops pointer in the device struct during the boot wh=
en
the platform device is added to the bus.
There is no support to allow a platform device register with two different =
SMMU
devices.
Two different  SMMU instances is 2x page table memory and 2x map/unmap over=
head.
With SMMU driver knowing about two smmu instances, page table memory usage,=
 map/unmap
Overhead would be efficient.

>>As long as devices only references one of them, locking only that one sho=
uld
provide suitable protection as well.

Earlier proposal on creating one Master SMMU node and slave SMMU nodes with=
in isn't liked.=20
Will has proposed creating a library and reusing the code. I have made the =
patches
to share the code.
https://www.spinics.net/lists/linux-tegra/msg35539.html
https://www.spinics.net/lists/linux-tegra/msg35494.html


>>Seems like a simpler approach than adding a new layer to the driver, but =
maybe
>>I am missing some complexity here?

Programming both SMMU instances identically with existing ARM SMMU driver i=
s not
possible with multiple DT nodes.=20
In the following patch, by writel* macro override, both ARM SMMU instances =
are
programmed identically in  Tegra194 SMMU driver transparently. Only tlb syn=
c and
interrupt handling need to know about specific instance.

https://lkml.org/lkml/2018/11/1/573
+#define writel_relaxed writel_relaxed_all
+#define writeq_relaxed writeq_relaxed_all
+#define writel writel_all

-KR
