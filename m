From: Shaohua Li <shli-b10kYP2dOMg@public.gmane.org>
Subject: [PATCH] intel-iommu: respect iommu=pt
Date: Tue, 24 Nov 2015 13:53:24 -0800
Message-ID: <58e2344c50053de58ceed658272ecc0f349c2f2f.1448401068.git.shli@fb.com>
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
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Kernel-team-b10kYP2dOMg@public.gmane.org, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, David Woodhouse <David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Currently if a device has rmrr or the device is a pci device,
passthrough is disabled even with iommu=pt. The worry is moving such
devices between domains don't work. But some users don't do the domain
reassignment at all, disabling passthough punish everybody. And iommu=pt
is a boot option, user knows the risk. So intead of failing the
passthough, just print a warning and continue the passthough.

Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Cc: David Woodhouse <David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Shaohua Li <shli-b10kYP2dOMg@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index f1042da..24aa0b3 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2798,8 +2798,12 @@ static int __init dev_prepare_static_identity_mapping(struct device *dev, int hw
 {
 	int ret;
 
-	if (!iommu_should_identity_map(dev, 1))
-		return 0;
+	if (!iommu_should_identity_map(dev, 1)) {
+		if (!(iommu_identity_mapping & IDENTMAP_ALL))
+			return 0;
+		WARN_ONCE(true, "IOMMU passthough is forced on, some devices "
+			"might not work because of device/platform limitations\n");
+	}
 
 	ret = domain_add_dev_info(si_domain, dev);
 	if (!ret)
-- 
2.4.6
