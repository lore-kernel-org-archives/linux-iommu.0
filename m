From: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v10 4/8] vfio/type1: handle unmap/unpin and replay for
 VFIO_IOVA_RESERVED slots
Date: Tue, 7 Jun 2016 18:41:57 +0200
Message-ID: <5d5b1dd9-5116-f8ea-101b-bb47f1e17980@redhat.com>
References: <201606080053.GBblobZp%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201606080053.GBblobZp%fengguang.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, eric.auger.pro@gmail.com, robin.murphy@arm.com, alex.williamson@redhat.com, will.deacon@arm.com, joro@8bytes.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, christoffer.dall@linaro.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Bharat.Bhushan@freescale.com, pranav.sawargaonkar@gmail.com, p.fedin@samsung.com, iommu@lists.linux-foundation.org, Jean-Philippe.Brucker@arm.com, julien.grall@arm.com, yehuday@marvell.com
List-Id: iommu@lists.linux-foundation.org

Hello,
Le 07/06/2016 =E0 18:44, kbuild test robot a =E9crit :
> Hi,
>=20
> [auto build test ERROR on vfio/next]
> [also build test ERROR on v4.7-rc2 next-20160607]
> [if your patch is applied to the wrong git tree, please drop us a not=
e to help improve the system]
>=20
> url:    https://github.com/0day-ci/linux/commits/Eric-Auger/KVM-PCIe-=
MSI-passthrough-on-ARM-ARM64-kernel-part-3-3-vfio-changes/20160608-0011=
48
> base:   https://github.com/awilliam/linux-vfio.git next
> config: x86_64-rhel (attached as .config)
> compiler: gcc-4.9 (Debian 4.9.3-14) 4.9.3
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=3Dx86_64=20
>=20
> All errors (new ones prefixed by >>):
>=20
>>> drivers/vfio/vfio_iommu_type1.c:39:29: fatal error: linux/msi-iommu=
=2Eh: No such file or directory
>     #include <linux/msi-iommu.h>
this is due to the dependency on part2 (MSI layer changes).

Best Regards

Eric
>                                 ^
>    compilation terminated.
>=20
> vim +39 drivers/vfio/vfio_iommu_type1.c
>=20
>     33	#include <linux/rbtree.h>
>     34	#include <linux/sched.h>
>     35	#include <linux/slab.h>
>     36	#include <linux/uaccess.h>
>     37	#include <linux/vfio.h>
>     38	#include <linux/workqueue.h>
>   > 39	#include <linux/msi-iommu.h>
>     40=09
>     41	#define DRIVER_VERSION  "0.2"
>     42	#define DRIVER_AUTHOR   "Alex Williamson <alex.williamson@redh=
at.com>"
>=20
> ---
> 0-DAY kernel test infrastructure                Open Source Technolog=
y Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Cor=
poration
>=20
