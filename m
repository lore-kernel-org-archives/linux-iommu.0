From: Joerg Roedel <joerg.roedel@amd.com>
Subject: Re: [PATCH v8 2/2] iommu/exynos: Add iommu driver for Exynos
 Platforms
Date: Wed, 25 Jan 2012 12:44:17 +0100
Message-ID: <20120125114417.GE19255@amd.com>
References: <001001ccc625$0afa7ee0$20ef7ca0$%cho@samsung.com>
 <20120123142706.GA6269@8bytes.org>
 <CAHQjnOMyoOH2cFjjGSzMvefZTQGROmQgaA8S0MmxnKGHWyQhyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHQjnOMyoOH2cFjjGSzMvefZTQGROmQgaA8S0MmxnKGHWyQhyA@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: KyongHo Cho <pullip.cho@samsung.com>
Cc: Joerg Roedel <joro@8bytes.org>, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Younglak Kim <younglak1004.kim@samsung.com>, Subash Patel <subash.ramaswamy@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Sanghyun Lee <sanghyun75.lee@samsung.com>, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Jan 25, 2012 at 03:51:58PM +0900, KyongHo Cho wrote:
> > This isn't really a problem. We allow destroying a domain with devi=
ces
> > attached. So this WARN_ON is not necessary.
> >
> BTW, Isn't it a problem when a device driver does not know that its
> iommu domain is destroyed?
> Can we regards that it is the faulty use of iommu API?

Yes we could, but we don't ;) The domain_destroy path has to take care
of this anyway to be robust, so we can also take away the need to unatt=
ach
everything from a domain from the iommu-api user.

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

Repeated function calls are not a real performance problem in the
iommu-code in my experience. The overhead is usualle somewhere else.

> Do you think it is better for s5p_iommu_map() to map just one page at=
 once?

In general I think we should not duplicate code. This logic was moved t=
o
the generic part for a reason and iommu drivers should use it unless
there is a very good reason not to do so.

>=20
> >> +static size_t exynos_iommu_unmap(struct iommu_domain *domain,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0unsigned long iova, size_t size)
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

Is I/O-TLB flushing an expensive operation?


	Joerg

--=20
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr.=
 43632
