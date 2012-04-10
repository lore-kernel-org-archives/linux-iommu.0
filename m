From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: Reparenting a platform device
Date: Tue, 10 Apr 2012 10:25:38 +0200
Message-ID: <20120410.112538.2163279650078921901.hdoyu@nvidia.com>
References: <20120406072014.GA14250@avionic-0098.mockup.avionic-design.de><4F7F1BCB.7070608@wwwdotorg.org><20120408142141.GA25303@avionic-0098.adnet.avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20120408142141.GA25303-RM9K5IK7kjIyiCvfTdI0JKcOhU4Rzj621B7CTYaBSLdn68oJJulU0Q@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org" <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Cc: "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org" <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

From: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Subject: Re: Reparenting a platform device
Date: Sun, 8 Apr 2012 16:21:41 +0200
Message-ID: <20120408142141.GA25303-RM9K5IK7kjIyiCvfTdI0JKcOhU4Rzj621B7CTYaBSLdn68oJJulU0Q@public.gmane.org>

> * PGP Signed by an unknown key
> 
> * Stephen Warren wrote:
> > On 04/06/2012 01:20 AM, Thierry Reding wrote:
> > > * Stephen Warren wrote:
> > >> I must admit I'm not at all familiar with the IOMMU APIs, but isn't the
> > >> IOMMU driver/subsystem itself what is managing all the allocations and
> > >> handing them out to clients? And client drivers do things like asking
> > >> for N pages of memory mapped into their aperture? If that is true, I'm
> > >> not sure what the purpose is of the intermediate device you propose.
> > >> Sorry for being somewhat clueless.
> > > 
> > > That was my impression too at first. But it seems like all the IOMMU
> > > subsystem does is map individual pages. So you pass it a physical address of
> > > a page along with the IO virtual address to map it to. That's at least the
> > > way it is handled for Tegra 2 GART (and from a quick look also by the Tegra 3
> > > SMMU). For the SMMU the situation may be different because it may not have a
> > > fixed aperture that needs to contain the IO virtual addresses, though I must
> > > admit I haven't looked at Tegra 3 in enough detail to judge this.
> > > 
> > > So this intermediate device would be purely an allocator for the GART
> > > aperture and handle the actual mapping via the IOMMU. This would probably be
> > > really simple and is in fact now done in the DRM driver. The nice thing if
> > > this would be a separate device is that it would be easy to make it a child
> > > of the IOMMU and wouldn't be as counter-intuitive as making the DRM device
> > > the IOMMU's child.
> > 
> > OK, I see.
> > 
> > I'll defer to Hiroshi here; he's far more familiar with all this than I am.
> > 
> > My only comment is that I'd be surprised to see any kind of memory
> > allocator represented as a driver (as opposed to a utility module) since
> > it's not really representing an actual hardware block.
> 
> I agree. In that case I don't see any other solution than to remove the
> requirement of the parent/child relationship from the GART driver. It seems
> like the SMMU driver doesn't have such a requirement so it should be fine.

Right. I missed one patch to send out. Probably we need the following
patch for the above.

>From f7a56c85a5dfe41d23746d28b2ecbfb66ef034b5 Mon Sep 17 00:00:00 2001
From: Vandana Salve <vsalve-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Date: Wed, 14 Mar 2012 18:17:53 +0530
Subject: [PATCH 1/1] iommu: tegra/gart: use correct gart_device

Pass the correct gart device pointer.

Reviewed-by: Vandana Salve <vsalve-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Tested-by: Vandana Salve <vsalve-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Reviewed-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Reviewed-by: Bharat Nihalani <bnihalani-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Hiroshi DOYU <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/tegra-gart.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index e8d50a2..c33557c 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -158,7 +158,7 @@ static int gart_iommu_attach_dev(struct iommu_domain *domain,
 	struct gart_client *client, *c;
 	int err = 0;
 
-	gart = dev_get_drvdata(dev->parent);
+	gart = gart_handle;
 	if (!gart)
 		return -EINVAL;
 	domain->priv = gart;
-- 
1.7.5.4
