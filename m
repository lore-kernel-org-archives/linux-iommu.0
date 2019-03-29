From: laurentiu.tudor@nxp.com
Subject: [PATCH 01/13] soc/fsl/qman: fixup liodns only on ppc targets
Date: Fri, 29 Mar 2019 16:00:02 +0200
Message-ID: <20190329140014.8126-2-laurentiu.tudor@nxp.com>
References: <20190329140014.8126-1-laurentiu.tudor@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190329140014.8126-1-laurentiu.tudor@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: netdev@vger.kernel.org, madalin.bucur@nxp.com, roy.pledge@nxp.com, camelia.groza@nxp.com, leoyang.li@nxp.com
Cc: davem@davemloft.net, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Laurentiu Tudor <laurentiu.tudor@nxp.com>
List-Id: iommu@lists.linux-foundation.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

ARM SoCs use SMMU so the liodn fixup done in the qman driver is no
longer making sense and it also breaks the ICID settings inherited
from u-boot. Do the fixups only for PPC targets.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/soc/fsl/qbman/qman_ccsr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soc/fsl/qbman/qman_ccsr.c b/drivers/soc/fsl/qbman/qman_ccsr.c
index 109b38de3176..12e414ca3b03 100644
--- a/drivers/soc/fsl/qbman/qman_ccsr.c
+++ b/drivers/soc/fsl/qbman/qman_ccsr.c
@@ -598,6 +598,7 @@ static int qman_init_ccsr(struct device *dev)
 #define LIO_CFG_LIODN_MASK 0x0fff0000
 void qman_liodn_fixup(u16 channel)
 {
+#ifdef CONFIG_PPC
 	static int done;
 	static u32 liodn_offset;
 	u32 before, after;
@@ -617,6 +618,7 @@ void qman_liodn_fixup(u16 channel)
 		qm_ccsr_out(REG_REV3_QCSP_LIO_CFG(idx), after);
 	else
 		qm_ccsr_out(REG_QCSP_LIO_CFG(idx), after);
+#endif
 }
 
 #define IO_CFG_SDEST_MASK 0x00ff0000
-- 
2.17.1
