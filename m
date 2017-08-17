From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH] iommu: Avoid NULL group dereference
Date: Thu, 17 Aug 2017 11:40:08 +0100
Message-ID: <59a6c4f0a790eea40e2b2f2be840b63317dd44e4.1502966326.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: marc.zyngier-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

The recently-removed FIXME in iommu_get_domain_for_dev() turns out to
have been a little misleading, since that check is still worthwhile even
when groups *are* universal. We have a few IOMMU-aware drivers which
only care whether their device is already attached to an existing domain
or not, for which the previous behaviour of iommu_get_domain_for_dev()
was ideal, and who now crash if their device does not have an IOMMU.

With IOMMU groups now serving as a reliable indicator of whether a
device has an IOMMU or not (barring false-positives from VFIO no-IOMMU
mode), drivers could arguably do this:

	group = iommu_group_get(dev);
	if (group) {
		domain = iommu_get_domain_for_dev(dev);
		iommu_group_put(group);
	}

However, rather than duplicate that code across multiple callsites,
particularly when it's still only the domain they care about, let's skip
straight to the next step and factor out the check into the common place
it applies - in iommu_get_domain_for_dev() itself. Sure, it ends up
looking rather familiar, but now it's backed by the reasoning of having
a robust API able to do the expected thing for all devices regardless.

Fixes: 05f80300dc8b ("iommu: Finish making iommu_group support mandatory")
Reported-by: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---

As well as dma-iommu, there are at least the Cavium ThunderX and
Freescale DPAA2 ethernet drivers expecting this to work too.

 drivers/iommu/iommu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index af69bf7e035a..5499a0387349 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1352,6 +1352,8 @@ struct iommu_domain *iommu_get_domain_for_dev(struct device *dev)
 	struct iommu_group *group;
 
 	group = iommu_group_get(dev);
+	if (!group)
+		return NULL;
 
 	domain = group->domain;
 
-- 
2.13.4.dirty
