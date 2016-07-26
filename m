From: Yong Wu <yong.wu@mediatek.com>
Subject: Re: [PATCH 1/3] memory: mediatek: Add a new interface
 mtk_smi_larb_is_ready
Date: Tue, 26 Jul 2016 09:31:48 +0800
Message-ID: <1469496708.3072.4.camel@mhfsdcap03>
References: <1468983721-3627-1-git-send-email-yong.wu@mediatek.com>
	 <cd01b829-f869-606b-5c1a-8077fbddb085@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cd01b829-f869-606b-5c1a-8077fbddb085@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Brugger <matthias.bgg@gmail.com>
Cc: David Airlie <airlied@linux.ie>, Philipp Zabel <p.zabel@pengutronix.de>, Hans Verkuil <hans.verkuil@cisco.com>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Tiffany Lin <tiffany.lin@mediatek.com>, Honghui Zhang <honghui.zhang@mediatek.com>, Bibby Hsieh <bibby.hsieh@mediatek.com>, YT Shen <yt.shen@mediatek.com>, CK Hu <ck.hu@mediatek.com>, Daniel Kurtz <djkurtz@google.com>, Tomasz Figa <tfiga@google.com>, Arnd Bergmann <arnd@arndb.de>, Lucas Stach <l.stach@pengutronix.de>, youlin.pei@mediatek.com, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, 2016-07-25 at 10:39 +0200, Matthias Brugger wrote:
> 
> On 20/07/16 05:01, Yong Wu wrote:
> > Currently the iommu consumer always call iommu_present to get whether
> > the iommu is ready. But in MTK IOMMU, this function can't indicate
> > this. The IOMMU call bus_set_iommu->mtk_iommu_add_device->
> > mtk_iommu_attach_device to parse the iommu data, then it's able to
> > transfer "struct mtk_smi_iommu" to SMI-LARB, and the iommu uses the
> > larbs as compoents, the iommu will finish its probe until all the larbs
> > probe done.
> >
> > If the iommu consumer(like DRM) begin to probe after the time of
> > calling bus_set_iommu and before the time of SMI probe finish, it
> > will hang like this:
> >
> > [    7.832359] Call trace:
> > [    7.834778] [<ffffffc000764424>] mtk_smi_larb_get+0x24/0xa8
> > [    7.840300] [<ffffffc0005a1390>] mtk_drm_crtc_enable+0x6c/0x450
> >
> > Because the larb->mmu is NULL at that time.
> >
> > In order to avoid this issue, we add a new interface
> > (mtk_smi_larb_is_ready) for checking whether the IOMMU and SMI have
> > finished their probe. If it return false, the iommu consumer should
> > probe-defer for the IOMMU and SMI.
> >
> 
> Can't we just skip the functions in the probe and call bus_set_iommu 
> only if we were able to bind all components?
> Something like this:
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index c3043d8..0bef49b 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -649,10 +649,14 @@ static int mtk_iommu_probe(struct platform_device 
> *pdev)
>          if (ret)
>                  return ret;
> 
> +       ret = component_master_add_with_match(dev, &mtk_iommu_com_ops, 
> match);
> +       if (ret)
> +               return ret;
> +
>          if (!iommu_present(&platform_bus_type))
>                  bus_set_iommu(&platform_bus_type, &mtk_iommu_ops);
> 
> -       return component_master_add_with_match(dev, &mtk_iommu_com_ops, 
> match);
> +       return ret;
>   } 

Thanks very much for your suggestion, I have tried and this seems don't
work.

I don't know much about component, so add some logs.
                                                                
 component_master_add_with_match only add the ops into a list, it won't
wait for the smi-larb probe done. Below is the log, it will return
quickly. 

[    0.095073] mtk-iommu 10205000.iommu: begin to probe 
[    0.095922] mtk-iommu 10205000.iommu: probe hw init
[    0.095948] mtk-iommu 10205000.iommu: trying to bring up master
[    0.095967] mtk-iommu 10205000.iommu: master has incomplete
components

The binder callback(mtk_iommu_bind) is called in this backtrace:

[    0.555718] [<ffff00000849e6ec>] mtk_iommu_bind+0x14/0x48
[    0.556405] [<ffff00000850a860>] try_to_bring_up_master.part.6
+0x38/0x88
[    0.557255] [<ffff00000850b014>] component_add+0x158/0x208
[    0.557954] [<ffff0000087352a4>] mtk_smi_larb_probe+0xf8/0x134
[    0.558696] [<ffff000008511838>] platform_drv_probe+0x50/0xc8
[    0.559427] [<ffff00000850fcfc>] driver_probe_device+0x224/0x2c4
[    0.560191] [<ffff00000850ff08>] __device_attach_driver+0x98/0xc8
[    0.560966] [<ffff00000850dea0>] bus_for_each_drv+0x58/0x98
[    0.561676] [<ffff00000850fa3c>] __device_attach+0xbc/0x124
[    0.562385] [<ffff0000085100a4>] device_initial_probe+0x10/0x18
[    0.563138] [<ffff00000850ef48>] bus_probe_device+0x90/0x98
[    0.563848] [<ffff00000850f3e4>] deferred_probe_work_func+0x7c/0xb0

Thus, It looks like mtk_iommu_bind is called in mtk_smi_larb_probe which
will be delayed by power-domain.
then iommu_present is true even though M4U and SMI-larb have not
finished their component binding.

> 
>  
> 
>   static int mtk_iommu_remove(struct platform_device *pdev)
> 
> Regards,
> Matthias
