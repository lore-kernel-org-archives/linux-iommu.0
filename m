From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: Tegra-DRM: Tegra30: DMA mapping API
Date: Thu, 12 Jul 2012 10:11:25 +0300
Message-ID: <20120712101125.427c920559044d550f0c64b7@nvidia.com>
References: <23B010BBA481A74B98487467C29BA57BF2366A1010@HKMAIL01.nvidia.com>
	<20120706.092417.916278591811517036.hdoyu@nvidia.com>
	<23B010BBA481A74B98487467C29BA57BF2366A1012@HKMAIL01.nvidia.com>
	<20120709.182828.1247752887335819184.hdoyu@nvidia.com>
	<1341908041.9360.6.camel@markz-desktop>
	<20120710132417.b52fbc05847cabec7e16cebd@nvidia.com>
	<20120710132639.a65ce779fcfabe74435dd6bc@nvidia.com>
	<20120711105827.GE25282@amd.com>
	<20120711144254.8f119872445e95713b467448@nvidia.com>
	<1342062273.4559.5.camel@markz-desktop>
	<20120712063322.df310d0b459d7d7d74511d8e@nvidia.com>
	<1342075745.4559.26.camel@markz-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1342075745.4559.26.camel@markz-desktop>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Mark Zhang <markz-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Emily Jiang <ejiang-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Peer Chen <pchen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org" <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Alex Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ken Adams <KAdams-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, 12 Jul 2012 08:49:05 +0200
markz <markz-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
.....
> > > After Joerg's patch and yours are merged into linux-next, I can submit
> > > my drm patch into review process.
> > 
> > You can also send them now for early review with some note mentioning
> > that your patches depend on the above "[PATCH 6/7] iommu/tegra:
> > Implement DOMAIN_ATTR_GEOMETRY attribute" in the commit log.
> 
> Thank you. I merged this patch set locally but seems it has problems:
> The requirement of the drm driver is: It needs a parameter named "base"
> while calling function "arm_iommu_create_mapping" to reserve a block of
> iova from GART/SMMU.
> This patch set defines function "iommu_domain_get_attr" &
> "iommu_domain_set_attr", but drm driver can't use them:
> 1. These 2 functions need a iommu_domain param which means the
> iommu_domain should be created before calling them. But the iommu_domain
> is created in function "arm_iommu_create_mapping".
> 2. It's not a good practice to make drm driver calls iommu apis
> directly.
> 
> Actually, I'm curious that why function "arm_iommu_create_mapping" needs
> this "base" param. AIUI, drm driver just needs to tell IOMMU the size of
> the iova address to reserve, then the base address can be checked out in
> a lot of ways. For example: 
> 1. Via "dma_map_sg" interface -- dma_map_sg defines we can check out the
> mapped iova address from "dma_address" member in scatterlist structure.
> 2. Use this iommu get/set attr interface. Of course, we need some dma
> mapping api wrappers on them.

arm_iommu_attach_device() should be called independently from DRM
driver in advance. In DRM driver, "struct device" should be connected
to map. Usually this can be done in board files, but with DT, we need
new framework to deal with this at once. Especially in Tegra, we have
many IOMMU'able devices, and it's not good idea to do respectively.

For temporary solution, you can call arm_iommu_create_mapping() and
arm_iommu_attach_device() in advance before DRM uses DMA API.
