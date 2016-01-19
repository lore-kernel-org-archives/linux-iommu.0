From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v7 3/5] memory: mediatek: Add SMI driver
Date: Tue, 19 Jan 2016 17:43:29 +0800
Message-ID: <1453196609.17894.39.camel@mhfsdcap03>
References: <1450426183-1571-1-git-send-email-yong.wu@mediatek.com>
	 <1450426183-1571-4-git-send-email-yong.wu@mediatek.com>
	 <569CBA50.7000400@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <569CBA50.7000400-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Daniel Kurtz <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sasha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, youhua.li-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, k.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, kendrick.hsu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, 2016-01-18 at 11:11 +0100, Matthias Brugger wrote:
>=20
> On 18/12/15 09:09, Yong Wu wrote:
> > This patch add SMI(Smart Multimedia Interface) driver. This driver
> > is responsible to enable/disable iommu and control the power domain
> > and clocks of each local arbiter.
> >
> > Signed-off-by: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>

[...]

> > +int mtk_smi_larb_get(struct device *larbdev)
> > +{
> > +	struct mtk_smi_larb *larb =3D dev_get_drvdata(larbdev);
> > +	struct mtk_smi *common =3D dev_get_drvdata(larb->smi_common_dev);
> > +	int ret;
> > +
> > +	/* Enable the smi-common's power and clocks */
> > +	ret =3D mtk_smi_enable(common);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* Enable the larb's power and clocks */
> > +	ret =3D mtk_smi_enable(&larb->smi);
> > +	if (ret) {
> > +		mtk_smi_disable(common);
> > +		return ret;
> > +	}
> > +
> > +	/* Configure the iommu info */
> > +	if (larb->mmu)
> > +		writel(*larb->mmu, larb->base + SMI_LARB_MMU_EN);
>=20
> Can there be a larb that does not have a mmu id defined?
> Phandles for the iommu need always to have a mtk_m4u_id defined, so I=
=20
> don't see the case where this can happen?

  No. In current IC(mt8173), All the larbs have the mmu info register.

> Why did you changed this value to a pointer and added the if?

  I changed it to a pointer in order to support
iommu_attach_device/iommu_detach_device dynamically.

  In our v6, there is a interface called mtk_smi_config_port in which
the iommu(M4U) could tell SMI which ports should enable iommu.
  In this version, we use the additional data of component to finish
this job(the third parameter of the mtk_smi_larb_bind). then we could
delete that interface.

  larb->mmu is a pointer that point to the mmu in "struct mtk_smi_iommu
smi_imu" of "struct mtk_iommu_data". This "smi_imu" is used to record
that which ports has already enabled iommu for each larb and it will be
updated during the iommu_attach_device/iommu_detach_device.
=20
   Why add the if?
  -> This pointer may be null in the mtk_smi_larb_unbind.
  I'm also not sure when it will enter mtk_smi_larb_unbind, maybe while
the iommu device is removed, then it call component_master_del, or the
larb device itself is removed, or some other error case in component.
but there really is a path it will be null, so I add this *if*.
   If you think it is unnecessary, I can delete it.

>=20
> > +
> > +	return 0;
> > +}
> > +
> > +void mtk_smi_larb_put(struct device *larbdev)
> > +{
> > +	struct mtk_smi_larb *larb =3D dev_get_drvdata(larbdev);
> > +	struct mtk_smi *common =3D dev_get_drvdata(larb->smi_common_dev);
> > +
>=20
> Would it make sense to write SMI_LARB_MMU_EN here again to eventually=
=20
> turn off mmus?

I think no. As you know, there may be some modules in one larb, so we
cann't write 0 in SMI_LARB_MMU_EN here to turn off mmus for all modules=
=2E

mtk_smi_larb_get/mtk_smi_larb_put mainly enable/disable the power domai=
n
and clocks for this local arbiter. And the larb is a unit here, SMI
cann=E2=80=99t detect which module calls mtk_smi_larb_put and disable h=
is
special iommu bits. so do mtk_smi_larb_get.
=20
I know that the module=E2=80=99s special iommu bit wasn=E2=80=99t wrote=
 to 0 here, but
if this module would like to work again, he have to call
mtk_smi_larb_get again, and currently all the multimedia modules always
works via iommu, we don=E2=80=99t need to write 0 here.


> Other then this, the driver looks fine to me.

Thanks very much for your reply. I could send the new version if we get
a conclusion for the two issue above here, like you really don't like
that *if*.

>=20
> Regards,
> Matthias
>=20
> > +	mtk_smi_disable(&larb->smi);
> > +	mtk_smi_disable(common);
> > +}
> > +
> > +static int
> > +mtk_smi_larb_bind(struct device *dev, struct device *master, void =
*data)
> > +{
> > +	struct mtk_smi_larb *larb =3D dev_get_drvdata(dev);
> > +	struct mtk_smi_iommu *smi_iommu =3D data;
> > +	unsigned int         i;
> > +
> > +	for (i =3D 0; i < smi_iommu->larb_nr; i++) {
> > +		if (dev =3D=3D smi_iommu->larb_imu[i].dev) {
> > +			larb->mmu =3D &smi_iommu->larb_imu[i].mmu;
> > +			return 0;
> > +		}
> > +	}
> > +	return -ENODEV;
> > +}
> > +
> > +static void
> > +mtk_smi_larb_unbind(struct device *dev, struct device *master, voi=
d *data)
> > +{
> > +	struct mtk_smi_larb *larb =3D dev_get_drvdata(dev);
> > +
> > +	larb->mmu =3D NULL;
> > +}
> > +
> > +static const struct component_ops mtk_smi_larb_component_ops =3D {
> > +	.bind =3D mtk_smi_larb_bind,
> > +	.unbind =3D mtk_smi_larb_unbind,
> > +};

[...]


--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
