From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH v8 2/2] iommu/exynos: Add iommu driver for Exynos Platforms
Date: Fri, 27 Jan 2012 11:13:32 +0900
Message-ID: <017b01ccdc99$44a12420$cde36c60$%kim@samsung.com>
References: <001001ccc625$0afa7ee0$20ef7ca0$%cho@samsung.com>
 <20120123142706.GA6269@8bytes.org>
 <CAHQjnOMyoOH2cFjjGSzMvefZTQGROmQgaA8S0MmxnKGHWyQhyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <CAHQjnOMyoOH2cFjjGSzMvefZTQGROmQgaA8S0MmxnKGHWyQhyA@mail.gmail.com>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'KyongHo Cho' <pullip.cho@samsung.com>, 'Joerg Roedel' <joro@8bytes.org>
Cc: 'Subash Patel' <subash.ramaswamy@linaro.org>, linux-kernel@vger.kernel.org, 'Younglak Kim' <younglak1004.kim@samsung.com>, iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, 'Kyungmin Park' <kyungmin.park@samsung.com>, 'Sanghyun Lee' <sanghyun75.lee@samsung.com>, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

KyongHo Cho wrote:
>=20
> Hi,
> On Mon, Jan 23, 2012 at 11:27 PM, Joerg Roedel <joro@8bytes.org> wrot=
e:
> > Hi,
> >
> > please also get and inclue Acks from the Exynos maintainer for the =
next
> > post.
> > Since I have a compiling config for exynos now I will merge the pat=
ches
> > when you have the Acks and addressed or explained the issues I poin=
ted
> > out below.
> >
> Thanks for review!
> I will include the Acks in the next patchset.

If his updated patch is ok to me, let me reply then.

As a note, I'm preparing for new EXYNOS SoC and so some exynos stuff su=
ch as
clock can be modified. So would be better if KyongHo could update regar=
ding
arch/arm/ part based on that. Maybe in the beginning of Feb.?

Joerg, as I said, I need a topic branch for this to avoid conflict and =
I
think, now you can provide it for samsung tree.

If any problems, please let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

> I will post the next patchset with corrections by the day after tomor=
row.
>=20
> And sorry for late reply.
> I had holidays for the new year's day based on Lunar system.
>=20
> > On Thu, Dec 29, 2011 at 09:26:08PM +0900, KyongHo Cho wrote:
> >> +static void exynos_iommu_domain_destroy(struct iommu_domain *doma=
in)
> >> +{
> >> + =A0 =A0 struct exynos_iommu_domain *priv =3D domain->priv;
> >> + =A0 =A0 struct list_head *pos, *n;
> >> + =A0 =A0 unsigned long flags;
> >> + =A0 =A0 int i;
> >> +
> >> + =A0 =A0 WARN_ON(!list_empty(&priv->clients));
> >
> > This isn't really a problem. We allow destroying a domain with devi=
ces
> > attached. So this WARN_ON is not necessary.
> >
> OK.
> BTW, Isn't it a problem when a device driver does not know that its
> iommu domain is destroyed?
> Can we regards that it is the faulty use of iommu API?
>=20
> >> +static int exynos_iommu_map(struct iommu_domain *domain, unsigned=
 long
> iova,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0phys_addr_t paddr, si=
ze_t size, int prot)
> >> +{
> >> + =A0 =A0 struct exynos_iommu_domain *priv =3D domain->priv;
> >> + =A0 =A0 unsigned long *entry;
> >> + =A0 =A0 unsigned long flags;
> >> + =A0 =A0 int ret =3D -ENOMEM;
> >> +
> >> + =A0 =A0 BUG_ON(priv->pgtable =3D=3D NULL);
> >> +
> >> + =A0 =A0 spin_lock_irqsave(&priv->pgtablelock, flags);
> >> +
> >> + =A0 =A0 entry =3D section_entry(priv->pgtable, iova);
> >> +
> >> + =A0 =A0 if (size >=3D SECT_SIZE) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D lv1set_section(entry, paddr, siz=
e >> SECT_ORDER,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 &priv-
> >lv2entcnt[lv1ent_offset(iova)]);
> >
> > This looks like you are partially re-implementing behavior of gener=
ic
> > code because you are mapping multiple sections at once. The generic=
 map
> > code already splits up the address range correctly, so no need to d=
o
> > this in the driver (unless there is some benefit in the hardware, l=
ike
> > an IOTLB entry that can cover multiple sections or something simila=
r).
> >
> Yes, I wanted to avoid repeated function call by iommu_map().
> s5p_iommu_map() maps once for the same page size since it is efficien=
t
> and simple.
> That's why this driver initializes domain->pgsize_bitmap with 0xFFFFF=
000
> even though our IOMMU driver just supports 3 different page sizes
> including 4KB, 64KB and 1MB.
>=20
> Do you think it is better for s5p_iommu_map() to map just one page at
once?
>=20
> >> +static size_t exynos_iommu_unmap(struct iommu_domain *domain,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0unsigned long iova, size_t
size)
> >> +{
> >> + =A0 =A0 struct exynos_iommu_domain *priv =3D domain->priv;
> >> + =A0 =A0 struct iommu_client *client;
> >> + =A0 =A0 unsigned long flags;
> >> +
> >> + =A0 =A0 BUG_ON(priv->pgtable =3D=3D NULL);
> >> +
> >> + =A0 =A0 spin_lock_irqsave(&priv->pgtablelock, flags);
> >> +
> >> + =A0 =A0 while (size !=3D 0) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 int i, nent, order;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 unsigned long *pent, *sent;
> >
> > Same with this while-loop. This looks like it re-implements behavio=
r
> > from the generic code.
> >
> If a region to unmap consists of tens of pages
> there is no way to avoid flushing IOTLB repeatedly.
>=20
> Out iommu driver doesn't need to flush IOTLB more than once for a
> region to unmap.
>=20
> Do you think the driver is better to unmaps just one page at once
> though flushing IOTLB repeatedly?
>=20
>=20
> Thank you.
>=20
>   KyongHo
