From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH] drm/rockchip: vop: fix irq disabled after vop driver probed
Date: Fri, 25 May 2018 00:06:39 +0200
Message-ID: <25470133.K8n9sLBzRS@diego>
References: <b8eb41e576c4007d40223699eb951db32916b86a.camel@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <b8eb41e576c4007d40223699eb951db32916b86a.camel-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Ezequiel Garcia <ezequiel-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Cc: Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>, jcliang-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Enric =?ISO-8859-1?Q?Balletb=F2?= <enric.balletbo-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Sandy Huang <hjc-TNX95d0MmH7DzftRWevZcw@public.gmane.org>

The vop irq is shared between vop and iommu and irq probing in the
iommu driver moved to the probe function recently. This can in some
cases lead to a stall if the irq is triggered while the vop driver
still has it disabled.

But there is no real need to disable the irq, as the vop can simply
also track its enabled state and ignore irqs in that case.

So remove the enable/disable handling and add appropriate condition
to the irq handler.

Signed-off-by: Sandy Huang <hjc-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
[added an actual commit message]
Signed-off-by: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
---
Hi Ezequiel,

this patch came from a discussion I had with Rockchip people over the
iommu changes and resulting issues back in april, but somehow was
forgotten and not posted to the lists. Correcting that now.

So removing the enable/disable voodoo on the shared interrupt is
the preferred way.

 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 13 ++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 510cdf0..61493d4 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -549,8 +549,6 @@ static int vop_enable(struct drm_crtc *crtc)
 
 	spin_unlock(&vop->reg_lock);
 
-	enable_irq(vop->irq);
-
 	drm_crtc_vblank_on(crtc);
 
 	return 0;
@@ -596,8 +594,6 @@ static void vop_crtc_atomic_disable(struct drm_crtc *crtc,
 
 	vop_dsp_hold_valid_irq_disable(vop);
 
-	disable_irq(vop->irq);
-
 	vop->is_enabled = false;
 
 	/*
@@ -1168,6 +1164,13 @@ static irqreturn_t vop_isr(int irq, void *data)
 	int ret = IRQ_NONE;
 
 	/*
+	 * since the irq is shared with iommu, iommu irq is enabled before vop
+	 * enable, so before vop enable we do nothing.
+	 */
+	if (!vop->is_enabled)
+		return IRQ_NONE;
+
+	/*
 	 * interrupt register has interrupt status, enable and clear bits, we
 	 * must hold irq_lock to avoid a race with enable/disable_vblank().
 	*/
@@ -1586,9 +1588,6 @@ static int vop_bind(struct device *dev, struct device *master, void *data)
 	if (ret)
 		goto err_disable_pm_runtime;
 
-	/* IRQ is initially disabled; it gets enabled in power_on */
-	disable_irq(vop->irq);
-
 	return 0;
 
 err_disable_pm_runtime:
-- 
2.7.4
