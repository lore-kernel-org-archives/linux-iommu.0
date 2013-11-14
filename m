From: Haiying Wang <Haiying.Wang@freescale.com>
Subject: [PATCH] iommu/fsl_pamu: use physical cpu index to find the matched
 cpu nodes
Date: Thu, 14 Nov 2013 14:30:40 -0500
Message-ID: <1384457440.2144.15.camel@haiying-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: joro@8bytes.org, iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org
Cc: Varun Sethi <Varun.Sethi@freescale.com>
List-Id: iommu@lists.linux-foundation.org

In the case we miss to bring up some cpus, we need to make sure we can
find the correct cpu nodes in the device tree based on the given logical
cpu index from the caller.

Signed-off-by: Haiying Wang <Haiying.Wang@freescale.com>
---
 drivers/iommu/fsl_pamu.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/iommu/fsl_pamu.c b/drivers/iommu/fsl_pamu.c
index cba0498..a9ab57b 100644
--- a/drivers/iommu/fsl_pamu.c
+++ b/drivers/iommu/fsl_pamu.c
@@ -539,6 +539,7 @@ u32 get_stash_id(u32 stash_dest_hint, u32 vcpu)
 	u32 cache_level;
 	int len, found = 0;
 	int i;
+	u32 cpuid = get_hard_smp_processor_id(vcpu);
 
 	/* Fastpath, exit early if L3/CPC cache is target for stashing */
 	if (stash_dest_hint == PAMU_ATTR_CACHE_L3) {
@@ -559,7 +560,7 @@ u32 get_stash_id(u32 stash_dest_hint, u32 vcpu)
 	for_each_node_by_type(node, "cpu") {
 		prop = of_get_property(node, "reg", &len);
 		for (i = 0; i < len / sizeof(u32); i++) {
-			if (be32_to_cpup(&prop[i]) == vcpu) {
+			if (be32_to_cpup(&prop[i]) == cpuid) {
 				found = 1;
 				goto found_cpu_node;
 			}
-- 
1.7.3.1.50.g1e633
