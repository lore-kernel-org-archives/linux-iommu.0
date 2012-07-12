From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: Tegra-DRM: Tegra30: DMA mapping API
Date: Thu, 12 Jul 2012 06:33:22 +0300
Message-ID: <20120712063322.df310d0b459d7d7d74511d8e@nvidia.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1342062273.4559.5.camel@markz-desktop>
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

On Thu, 12 Jul 2012 05:04:33 +0200
markz <markz-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:

> On Wed, 2012-07-11 at 19:42 +0800, Hiroshi Doyu wrote:
> > Hi Joerg,
> > 
> > On Wed, 11 Jul 2012 12:58:27 +0200
> > Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org> wrote:
> > 
> > > Hi,
> > > 
> > > On Tue, Jul 10, 2012 at 01:26:39PM +0300, Hiroshi Doyu wrote:
> > > > > http://lists.linuxfoundation.org/pipermail/iommu/2012-January/003531.html
> > > > 
> > > > Do you have any plan to merge the above "IOMMU: Make IOMMU-API ready
> > > > for GART-like hardware"?
> > > > 
> > > > Tegra DRM seems to need that feature eventually.
> > > 
> > > I just rebased and updated the patch-set. A new version is sent out. If
> > > no major objections come up I queue it for the next merge window.
> > 
> > Thank you for your prompt action. This would help us a lot.
> 
> That's great. So Hiroshi-san, about your patch: 
> http://lists.linuxfoundation.org/pipermail/iommu/2012-January/003531.html
> , what is your plan to merge this?

That's also under review along with the framework as below:

[PATCH 6/7] iommu/tegra: Implement DOMAIN_ATTR_GEOMETRY attribute  
http://lists.linuxfoundation.org/pipermail/iommu/2012-July/004432.html

> After Joerg's patch and yours are merged into linux-next, I can submit
> my drm patch into review process.

You can also send them now for early review with some note mentioning
that your patches depend on the above "[PATCH 6/7] iommu/tegra:
Implement DOMAIN_ATTR_GEOMETRY attribute" in the commit log.
