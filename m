From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: RE: [PATCH v8 0/2] ommu/exynos: Add IOMMU/System MMU driver for
 Samsung Exynos
Date: Mon, 27 Feb 2012 16:51:53 +0100
Message-ID: <000701ccf567$b9dee150$2d9ca3f0$%szyprowski@samsung.com>
References: <000e01ccc624$c9349310$5b9db930$%cho@samsung.com>
 <014601ccf2fa$a25c8560$e7159020$%szyprowski@samsung.com>
 <CAHQjnOPE5X=dn+8D348OruLqoYNGZwZk3eLtLRSERce-eTzXDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <CAHQjnOPE5X=dn+8D348OruLqoYNGZwZk3eLtLRSERce-eTzXDg@mail.gmail.com>
Content-language: pl
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'KyongHo Cho' <pullip.cho@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 'Kukjin Kim' <kgene.kim@samsung.com>, 'Subash Patel' <subash.ramaswamy@linaro.org>, 'Younglak Kim' <younglak1004.kim@samsung.com>, 'Kyungmin Park' <kyungmin.park@samsung.com>, 'Sanghyun Lee' <sanghyun75.lee@samsung.com>
List-Id: iommu@lists.linux-foundation.org

Hello,

On Friday, February 24, 2012 5:09 PM KyongHo Cho wrote:

> On Fri, Feb 24, 2012 at 10:45 PM, Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
> > Hi,
> >
> > On Thursday, December 29, 2011 1:24 PM KyongHo Cho wrote:
> >
> >> Changes since v7:
> >> - Rebased with the recent commits of the following git branches
> >> =A0 * git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git/next
> >> =A0 * git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.=
git/for-next
> >> - Changed magic numbers into macros
> >> - Setting owner of a System MMU in 'iommu' field of dev_archdata
> >> - Verbose message in the default fault handler
> >> - Some bug fixes.
> >
> > (snipped)
> >
> > The time is flying away and v3.4 merge windows will open soon. Do y=
ou plan to
> > send an updated version of the SYSMMU driver anytime soon? It will =
be really
> > nice to have it finally merged to v3.4.
> >
>=20
> Thank you for asking.
>=20
> I prepared a new patchset and it is ready for submitting.
> It includes several bugfixes and Exynos5 support.
>=20
> The last patche submitted has a bug when the following situation:
>    1. Allocating a 2nd level page table to map 4KB or 64KB on a virtu=
al region
>    2. Unmapped all entries in the 2nd level page table.
>    3. Mapping to the same region with 1MB page.
>    Then iommu_map() will return -EADDRINUSE due to incorrect counting
>    free entries in 2nd level page table.
>=20
> The next patch will be submitted by 2/28.

Ok, I will check it soon then.

> BTW Marek, I want to know why MFC driver defines separate platform de=
vices
> for left and right buses.

This is required for S5PV210 which has no iommu and requires contiguous=
 memory=20
from 2 separate physical memory banks. It use dma_declare_coherent to d=
efine
memory for each bus separately. One platform device can have only one c=
oherent
memory range defined, that's why there are two devices created.

> The next IOMMU driver defines just one platform device for a H/W devi=
ce.
> Thus, it defines just one SYSMMU_MFC platform device, for example.
> (the previous one defines 2 platform devices for SYSMMU_MFC)

Exynos4210 has 2 iommu controllers for MFC device - one for each memory=
 bus.=20
Each MFC bus can address 128MiB of IO address space. Do you mean that t=
he new driver
will merge these 2 controllers into one? This way we will lose half of =
address space
for MFC device.

> However, it is easy to separate the single platform device to multipl=
e
> platform devices.

Best regards
--=20
Marek Szyprowski
Samsung Poland R&D Center
