From: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
Subject: Re: Tegra-DRM: Tegra30: DMA mapping API
Date: Wed, 11 Jul 2012 12:58:27 +0200
Message-ID: <20120711105827.GE25282@amd.com>
References: <23B010BBA481A74B98487467C29BA57BF2366A1010@HKMAIL01.nvidia.com>
 <20120706.092417.916278591811517036.hdoyu@nvidia.com>
 <23B010BBA481A74B98487467C29BA57BF2366A1012@HKMAIL01.nvidia.com>
 <20120709.182828.1247752887335819184.hdoyu@nvidia.com>
 <1341908041.9360.6.camel@markz-desktop>
 <20120710132417.b52fbc05847cabec7e16cebd@nvidia.com>
 <20120710132639.a65ce779fcfabe74435dd6bc@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120710132639.a65ce779fcfabe74435dd6bc-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Mark Zhang <markz-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Peer Chen <pchen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Emily Jiang <ejiang-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Alex Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org" <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, Ken Adams <KAdams-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi,

On Tue, Jul 10, 2012 at 01:26:39PM +0300, Hiroshi Doyu wrote:
> > http://lists.linuxfoundation.org/pipermail/iommu/2012-January/003531.html
> 
> Do you have any plan to merge the above "IOMMU: Make IOMMU-API ready
> for GART-like hardware"?
> 
> Tegra DRM seems to need that feature eventually.

I just rebased and updated the patch-set. A new version is sent out. If
no major objections come up I queue it for the next merge window.

Regards,

	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
