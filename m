From: laurentiu.tudor@nxp.com
Subject: [PATCH v2 1/9] soc/fsl/qman: fixup liodns only on ppc targets
Date: Sat, 27 Apr 2019 10:10:23 +0300
Message-ID: <20190427071031.6563-2-laurentiu.tudor@nxp.com>
References: <20190427071031.6563-1-laurentiu.tudor@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190427071031.6563-1-laurentiu.tudor@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: netdev@vger.kernel.org, madalin.bucur@nxp.com, roy.pledge@nxp.com, camelia.groza@nxp.com, leoyang.li@nxp.com
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net, linux-arm-kernel@lists.infradead.org, Laurentiu Tudor <laurentiu.tudor@nxp.com>
List-Id: iommu@lists.linux-foundation.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

ARM SoCs use SMMU so the liodn fixup done in the qman driver is no
longer making sense and it also breaks the ICID settings inherited
from u-boot. Do the fixups only for PPC targets.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/soc/fsl/qbman/qman_ccsr.c | 2 +-
 drivers/soc/fsl/qbman/qman_priv.h | 9 ++++++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/fsl/qbman/qman_ccsr.c b/drivers/soc/fsl/qbman/qman_ccsr.c
index 109b38de3176..a6bb43007d03 100644
--- a/drivers/soc/fsl/qbman/qman_ccsr.c
+++ b/drivers/soc/fsl/qbman/qman_ccsr.c
@@ -596,7 +596,7 @@ static int qman_init_ccsr(struct device *dev)
 }
 
 #define LIO_CFG_LIODN_MASK 0x0fff0000
-void qman_liodn_fixup(u16 channel)
+void __qman_liodn_fixup(u16 channel)
 {
 	static int done;
 	static u32 liodn_offset;
diff --git a/drivers/soc/fsl/qbman/qman_priv.h b/drivers/soc/fsl/qbman/qman_priv.h
index 75a8f905f8f7..04515718cfd9 100644
--- a/drivers/soc/fsl/qbman/qman_priv.h
+++ b/drivers/soc/fsl/qbman/qman_priv.h
@@ -193,7 +193,14 @@ extern struct gen_pool *qm_cgralloc; /* CGR ID allocator */
 u32 qm_get_pools_sdqcr(void);
 
 int qman_wq_alloc(void);
-void qman_liodn_fixup(u16 channel);
+#ifdef CONFIG_FSL_PAMU
+#define qman_liodn_fixup __qman_liodn_fixup
+#else
+static inline void qman_liodn_fixup(u16 channel)
+{
+}
+#endif
+void __qman_liodn_fixup(u16 channel);
 void qman_set_sdest(u16 channel, unsigned int cpu_idx);
 
 struct qman_portal *qman_create_affine_portal(
-- 
2.17.1
