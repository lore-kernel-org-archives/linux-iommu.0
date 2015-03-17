From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 2/5] iommu/mediatek: Add mt8173 IOMMU driver
Date: Tue, 17 Mar 2015 15:14:24 +0000
Message-ID: <20150317151424.GQ8399@arm.com>
References: <1425638900-24989-1-git-send-email-yong.wu@mediatek.com>
 <1425638900-24989-3-git-send-email-yong.wu@mediatek.com>
 <20150306105821.GE22377@arm.com>
 <1425903103.13300.29.camel@mhfsdcap03>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1425903103.13300.29.camel@mhfsdcap03>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Robin Murphy <Robin.Murphy-5wv7dgnIgG8@public.gmane.org>, Daniel Kurtz <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, Catalin Marinas <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, "linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Sasha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org" <srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Mar 09, 2015 at 12:11:43PM +0000, Yong Wu wrote:
> On Fri, 2015-03-06 at 10:58 +0000, Will Deacon wrote:
> > On Fri, Mar 06, 2015 at 10:48:17AM +0000, yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org wrote:
> > > From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> > > 
> > > This patch adds support for mediatek m4u (MultiMedia Memory Management Unit).
> > > Currently this only supports m4u gen 2 with 2 levels of page table on mt8173.
> > 
> > [...]
> > 
> > > +/* 2 level pagetable: pgd -> pte */
> > > +#define F_PTE_TYPE_GET(regval)  (regval & 0x3)
> > > +#define F_PTE_TYPE_LARGE         BIT(0)
> > > +#define F_PTE_TYPE_SMALL         BIT(1)
> > > +#define F_PTE_B_BIT              BIT(2)
> > > +#define F_PTE_C_BIT              BIT(3)
> > > +#define F_PTE_BIT32_BIT          BIT(9)
> > > +#define F_PTE_S_BIT              BIT(10)
> > > +#define F_PTE_NG_BIT             BIT(11)
> > > +#define F_PTE_PA_LARGE_MSK            (~0UL << 16)
> > > +#define F_PTE_PA_LARGE_GET(regval)    ((regval >> 16) & 0xffff)
> > > +#define F_PTE_PA_SMALL_MSK            (~0UL << 12)
> > > +#define F_PTE_PA_SMALL_GET(regval)    ((regval >> 12) & (~0))
> > > +#define F_PTE_TYPE_IS_LARGE_PAGE(pte) ((imu_pte_val(pte) & 0x3) == \
> > > +                                       F_PTE_TYPE_LARGE)
> > > +#define F_PTE_TYPE_IS_SMALL_PAGE(pte) ((imu_pte_val(pte) & 0x3) == \
> > > +                                       F_PTE_TYPE_SMALL)
> > 
> > This looks like the ARM short-descriptor format to me. Could you please
> > add a new page table format to the io-pgtable code, so that other IOMMU
> > drivers can make use of this? I know there was some interest in using
> > short descriptor for the ARM SMMU, for example.
>     Currently I not familiar with the io-pgtable,I may need some time
> for it and the ARM short-descriptor. 

Well, you can read the LPAE version I wrote in io-pgtable-arm.c for some
inspiration (it's used by arm-smmu.c and ipmmu-vmsa.c).

>     And there are some difference between mediatek's pagetable with the
> standard short-descriptor, like bit 9. we use it for the dram over 4GB.
> Then how should we do if there are some difference. 

That can easily be handled using a quirk (see, for example,
IO_PGTABLE_QUIRK_ARM_NS).

Will
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
