From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: Tegra-DRM: Tegra30: DMA mapping API
Date: Tue, 10 Jul 2012 13:26:39 +0300
Message-ID: <20120710132639.a65ce779fcfabe74435dd6bc@nvidia.com>
References: <23B010BBA481A74B98487467C29BA57BF2366A1010@HKMAIL01.nvidia.com>
	<20120706.092417.916278591811517036.hdoyu@nvidia.com>
	<23B010BBA481A74B98487467C29BA57BF2366A1012@HKMAIL01.nvidia.com>
	<20120709.182828.1247752887335819184.hdoyu@nvidia.com>
	<1341908041.9360.6.camel@markz-desktop>
	<20120710132417.b52fbc05847cabec7e16cebd@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120710132417.b52fbc05847cabec7e16cebd-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: joerg.roedel-5C7GfCeVMHo@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Mark Zhang <markz-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Peer Chen <pchen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Emily Jiang <ejiang-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Alex Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org" <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, Ken Adams <KAdams-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

On Tue, 10 Jul 2012 12:24:17 +0200
Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:

> On Tue, 10 Jul 2012 10:14:01 +0200
> markz <markz-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
> 
> > On Mon, 2012-07-09 at 23:28 +0800, Hiroshi Doyu wrote:
> > > Hi Mark, adding linux-tegra on Cc:.... 
> > > 
> > > Mark Zhang <markz-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote @ Mon, 9 Jul 2012 14:13:13 +0200:
> > > 
> > > > > Hi Mark, Cc: Thierry & Ken,
> > > > >
> > > > > Can GEM allow DRM to use contigious memory? That could be easier.
> > > > >
> > > > > Otherwise, I think that you need to make drv->dev iommu'able before
> > > > > calling DMA API if you want to use IOMMU. To make drv->dev iommu'able,
> > > > > you need to call arm_iommu_create_mapping() and arm_iommu_attach_device().
> > > > 
> > > > Thank you. Yes, we need to call these functions otherwise iommu will not be enabled at all.
> > > > So my question is:
> > > > 1. in arm_iommu_create_mapping, we need to specify the base address
> > > > of the iova. Is these an API which can get this base address? I
> > > > mean, SMMU serves a lot of clients and maybe every client will
> > > > specify a range of iova which it needs. So as the center point of
> > > > these clients, does SMMU module has a function which can be used by
> > > > client to get this base address?
> > > 
> > > The SMMU patch was sent but it depends on the following framework.
> > > 
> > >   [PATCH 0/5] IOMMU: Make IOMMU-API ready for GART-like hardware
> > >     https://lkml.org/lkml/2012/1/19/170
> > > 
> > 
> > Got it. Seems this patch hasn't been integrated yet. Besides, SMMU
> > module should do some implementations for this set/get attribute
> > functions as well, right?
> 
> Yes, that's below:
> http://lists.linuxfoundation.org/pipermail/iommu/2012-January/003531.html

Do you have any plan to merge the above "IOMMU: Make IOMMU-API ready
for GART-like hardware"?

Tegra DRM seems to need that feature eventually.
