From: Yong Wu <yong.wu@mediatek.com>
Subject: Re: [PATCH v2] iommu/mediatek: Move attach_device after iommu-group
 is ready for M4Uv1
Date: Thu, 25 Jan 2018 19:06:56 +0800
Message-ID: <1516878416.22553.24.camel@mhfsdcap03>
References: <1516696788-8668-1-git-send-email-yong.wu@mediatek.com>
         <78721402-989d-d06a-18cc-dd6efd358dfd@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <78721402-989d-d06a-18cc-dd6efd358dfd@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>, Matthias Brugger <matthias.bgg@gmail.com>, Will Deacon <will.deacon@arm.com>, Alex Williamson <alex.williamson@redhat.com>, Tomasz Figa <tfiga@google.com>, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, arnd@arndb.de, honghui.zhang@mediatek.com, Bibby Hsieh <bibby.hsieh@mediatek.com>, youlin.pei@mediatek.com
List-Id: iommu@lists.linux-foundation.org

On Wed, 2018-01-24 at 14:55 +0000, Robin Murphy wrote:
> On 23/01/18 08:39, Yong Wu wrote:
> > In the commit 05f80300dc8b ("iommu: Finish making iommu_group support
> > mandatory"), the iommu framework has supposed all the iommu drivers have
> > their owner iommu-group, it get rid of the FIXME workarounds while the
> > group is NULL. But the flow of Mediatek M4U gen1 looks a bit trick that
> > it will hang at this case:
> > 
> > ==========================================
> > Unable to handle kernel NULL pointer dereference at virtual address 00000030
> > PC is at mutex_lock+0x28/0x54
> > LR is at iommu_attach_device+0xa4/0xd4
> > pc : [<c07632e8>]    lr : [<c04736fc>]    psr: 60000013
> > sp : df0edbb8  ip : df0edbc8  fp : df0edbc4
> > r10: c114da14  r9 : df2a3e40  r8 : 00000003
> > r7 : df27a210  r6 : df2a90c4  r5 : 00000030  r4 : 00000000
> > r3 : df0f8000  r2 : fffff000  r1 : df29c610  r0 : 00000030
> > Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> > xxx
> > (mutex_lock) from [<c04736fc>] (iommu_attach_device+0xa4/0xd4)
> > (iommu_attach_device) from [<c011b9dc>] (__arm_iommu_attach_device+0x28/0x90)
> > (__arm_iommu_attach_device) from [<c011ba60>] (arm_iommu_attach_device+0x1c/0x30)
> > (arm_iommu_attach_device) from [<c04759ac>] (mtk_iommu_add_device+0xfc/0x214)
> > (mtk_iommu_add_device) from [<c0472aa4>] (add_iommu_group+0x3c/0x68)
> > (add_iommu_group) from [<c047d044>] (bus_for_each_dev+0x78/0xac)
> > (bus_for_each_dev) from [<c04734a4>] (bus_set_iommu+0xb0/0xec)
> > (bus_set_iommu) from [<c0476310>] (mtk_iommu_probe+0x328/0x368)
> > (mtk_iommu_probe) from [<c048189c>] (platform_drv_probe+0x5c/0xc0)
> > (platform_drv_probe) from [<c047f510>] (driver_probe_device+0x2f4/0x4d8)
> > (driver_probe_device) from [<c047f800>] (__driver_attach+0x10c/0x128)
> > (__driver_attach) from [<c047d044>] (bus_for_each_dev+0x78/0xac)
> > (bus_for_each_dev) from [<c047ec78>] (driver_attach+0x2c/0x30)
> > (driver_attach) from [<c047e640>] (bus_add_driver+0x1e0/0x278)
> > (bus_add_driver) from [<c048052c>] (driver_register+0x88/0x108)
> > (driver_register) from [<c04817ec>] (__platform_driver_register+0x50/0x58)
> > (__platform_driver_register) from [<c0b31380>] (m4u_init+0x24/0x28)
> > (m4u_init) from [<c0101c38>] (do_one_initcall+0xf0/0x17c)
> > =========================
> > 
> > The root cause is that "arm_iommu_attach_device" is called before
> > "iommu_group_get_for_dev" in the interface "mtk_iommu_add_device". Thus,
> > We adjust the sequence of this two functions.
> > 
> > Unfortunately, there is another issue after the solution above, From the
> > function "iommu_attach_device", Only one device in each a iommu group is
> > allowed. In Mediatek case, there is only one m4u group, all the devices
> > are in one group. thus it get fail at this step.
> > 
> > In order to satisfy this requirement, a new iommu group is allocated for
> > each a iommu consumer device. But meanwhile, we still have to use the
> > same domain for all the iommu group. Use a global variable "mtk_domain_v1"
> > to save the global domain.
> 
> Argh, sorry for breaking it! Seems I managed to forget just how horrible 
> and fiddly all the arm_iommu_* stuff is :(
> 
> > CC: Robin Murphy <robin.murphy@arm.com>
> > CC: Honghui Zhang <honghui.zhang@mediatek.com>
> > Fixes: 05f80300dc8b ("iommu: Finish making iommu_group support mandatory")
> > Reported-by: Ryder Lee <ryder.lee@mediatek.com>
> > Tested-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> > changes since v1:
> >     Add mtk_domain_v1=NULL in domain_free for symmetry.
> > 
> > v1: https://patchwork.kernel.org/patch/10176255/
> > ---
> >   drivers/iommu/mtk_iommu_v1.c | 42 +++++++++++++++++++-----------------------
> >   1 file changed, 19 insertions(+), 23 deletions(-)
> > 
> > diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
> > index 542930c..86106bf 100644
> > --- a/drivers/iommu/mtk_iommu_v1.c
> > +++ b/drivers/iommu/mtk_iommu_v1.c
> > @@ -103,6 +103,9 @@ struct mtk_iommu_domain {
> >   	struct mtk_iommu_data		*data;
> >   };
> >   
> > +/* There is only a iommu domain in M4U gen1. */
> > +static struct mtk_iommu_domain *mtk_domain_v1;
> > +
> >   static struct mtk_iommu_domain *to_mtk_domain(struct iommu_domain *dom)
> >   {
> >   	return container_of(dom, struct mtk_iommu_domain, domain);
> > @@ -251,10 +254,15 @@ static struct iommu_domain *mtk_iommu_domain_alloc(unsigned type)
> >   	if (type != IOMMU_DOMAIN_UNMANAGED)
> >   		return NULL;
> >   
> > +	/* Always return the same domain. */
> > +	if (mtk_domain_v1)
> > +		return &mtk_domain_v1->domain;
> 
> This seems a bit too fragile (and I vaguely recall we may have discussed 
> and rejected this approach for the original driver), since any code doing:

Yes. We discussed it long before. Using a global variable is simpler
sometimes, so I didn't dig further. sorry.

> 
> 	unused = iommu_domain_alloc(bus);
> 	iommu_domain_free(unused);
> 
> will pull the rug out from under everyone's feet in a very nasty and 
> unexpected manner. Given that mtk_iommu_create_mapping() is already a 
> giant workaround for the ARM DMA code not understanding groups and 
> default domains, I'd prefer not to have to regress "correct" driver 
> behaviour for the sake of that; how about something like the below diff, 
> is that enough to make things work?

Thanks very much for this approach. I have tested it and it works fine.

I change a little:
1. Move the diff below into mtk_iommu_add_device. This is because
mtk_iommu_create_mapping is called in a of_for_each_xx, it may enter
several times. so I move it out from mtk_iommu_create_mapping to make
the flow more meet your expectation.
2. "return NULL" in device_group. Currently the device_group callback
looks not needed. I am not sure which one is better, delete whole this
callback or return NULL. in next version I use "return NULL", let
the framework report warning if it enter this device_group.

Thanks again.

> 
> Robin.
> 
> ----->8-----
> diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
> index 542930cd183d..8b90b7a72238 100644
> --- a/drivers/iommu/mtk_iommu_v1.c
> +++ b/drivers/iommu/mtk_iommu_v1.c
> @@ -376,6 +376,7 @@ static int mtk_iommu_create_mapping(struct device *dev,
>   	struct platform_device *m4updev;
>   	struct dma_iommu_mapping *mtk_mapping;
>   	struct device *m4udev;
> +	struct iommu_group *group;
>   	int ret;
> 
>   	if (args->args_count != 1) {
> @@ -418,6 +419,22 @@ static int mtk_iommu_create_mapping(struct device *dev,
>   		m4udev->archdata.iommu = mtk_mapping;
>   	}
> 
> +	/*
> +	 * This is a short-term bodge because the ARM DMA code doesn't
> +	 * understand multi-device groups, but we have to call into it
> +	 * successfully (and not just rely on a normal IOMMU API attach
> +	 * here) in order to set the correct DMA API ops on @dev.
> +	 */
> +	group = iommu_group_alloc();
> +	if (IS_ERR(group)) {
> +		ret = ERR_PTR(group);
> +		goto err_release_mapping;
> +	}
> +	ret = iommu_group_add_device(group,  dev);
> +	iommu_group_put(group);
> +	if (ret)
> +		goto err_release_mapping;
> +
>   	ret = arm_iommu_attach_device(dev, mtk_mapping);
>   	if (ret)
>   		goto err_release_mapping;
