From: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/3] memory: mediatek: Add a new interface
	mtk_smi_larb_is_ready
Date: Mon, 25 Jul 2016 10:39:52 +0200
Message-ID: <cd01b829-f869-606b-5c1a-8077fbddb085@gmail.com>
References: <1468983721-3627-1-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1468983721-3627-1-git-send-email-yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Hans Verkuil <hans.verkuil-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>
Cc: youlin.pei-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Mauro Carvalho Chehab <mchehab-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, CK Hu <ck.hu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Daniel Kurtz <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Bibby Hsieh <bibby.hsieh-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, YT Shen <yt.shen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Tiffany Lin <tiffany.lin-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



On 20/07/16 05:01, Yong Wu wrote:
> Currently the iommu consumer always call iommu_present to get whether
> the iommu is ready. But in MTK IOMMU, this function can't indicate
> this. The IOMMU call bus_set_iommu->mtk_iommu_add_device->
> mtk_iommu_attach_device to parse the iommu data, then it's able to
> transfer "struct mtk_smi_iommu" to SMI-LARB, and the iommu uses the
> larbs as compoents, the iommu will finish its probe until all the larbs
> probe done.
>
> If the iommu consumer(like DRM) begin to probe after the time of
> calling bus_set_iommu and before the time of SMI probe finish, it
> will hang like this:
>
> [    7.832359] Call trace:
> [    7.834778] [<ffffffc000764424>] mtk_smi_larb_get+0x24/0xa8
> [    7.840300] [<ffffffc0005a1390>] mtk_drm_crtc_enable+0x6c/0x450
>
> Because the larb->mmu is NULL at that time.
>
> In order to avoid this issue, we add a new interface
> (mtk_smi_larb_is_ready) for checking whether the IOMMU and SMI have
> finished their probe. If it return false, the iommu consumer should
> probe-defer for the IOMMU and SMI.
>

Can't we just skip the functions in the probe and call bus_set_iommu 
only if we were able to bind all components?
Something like this:

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index c3043d8..0bef49b 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -649,10 +649,14 @@ static int mtk_iommu_probe(struct platform_device 
*pdev)
         if (ret)
                 return ret;

+       ret = component_master_add_with_match(dev, &mtk_iommu_com_ops, 
match);
+       if (ret)
+               return ret;
+
         if (!iommu_present(&platform_bus_type))
                 bus_set_iommu(&platform_bus_type, &mtk_iommu_ops);

-       return component_master_add_with_match(dev, &mtk_iommu_com_ops, 
match);
+       return ret;
  } 

 

  static int mtk_iommu_remove(struct platform_device *pdev)

Regards,
Matthias
