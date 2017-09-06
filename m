From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v2 0/8] MT2712 IOMMU SUPPORT
Date: Wed, 6 Sep 2017 13:40:44 +0800
Message-ID: <1504676444.20565.3.camel@mhfsdcap03>
References: <1503313221-26453-1-git-send-email-yong.wu@mediatek.com>
         <20170822143836.ac3faa7wcwfjtvjc@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170822143836.ac3faa7wcwfjtvjc-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Daniel Kurtz <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, "linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, srv_heupstream <srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, Honghui Zhang =?UTF-8?Q?=28=E5=BC=A0=E6=B4=AA=E8=BE=89=29?= <Honghui.Zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, 2017-08-22 at 22:38 +0800, Joerg Roedel wrote:
> On Mon, Aug 21, 2017 at 07:00:13PM +0800, Yong Wu wrote:
> > Yong Wu (8):
> >   dt-bindings: mediatek: Add binding for mt2712 IOMMU and SMI
> >   iommu/mediatek: Move MTK_M4U_TO_LARB/PORT into mtk_iommu.c
> >   iommu/mediatek: Add mt2712 IOMMU support
> >   iommu/mediatek: Merge 2 M4U HWs into one iommu domain
> >   iommu/mediatek: Move pgtable allocation into domain_alloc
> >   iommu/mediatek: Disable iommu clock when system suspend
> >   iommu/mediatek: Enlarge the validate PA range for 4GB mode
> >   memory: mtk-smi: Degrade SMI init to module_init
> 
> Applied patches 2-7. Patch 1 is something for Matthias.

Hi Matthias,

   Could you help review the patch[1/8]? If it's ok for you too,Could
you help apply that one via your tree.
   Thanks.


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
