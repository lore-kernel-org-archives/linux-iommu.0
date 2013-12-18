From: Rashika Kheria <rashika.kheria@gmail.com>
Subject: [PATCH 2/3] drivers: iommu: Mark functions as static in
 intel_irq_remapping.c
Date: Wed, 18 Dec 2013 12:04:27 +0530
Message-ID: <ac2232eb56e74f3b891ad53f1a6a542494f04c1e.1387265905.git.rashika.kheria@gmail.com>
References: <6d0cb39e3d1128669e7740943efce3996ab0d8ab.1387265904.git.rashika.kheria@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6d0cb39e3d1128669e7740943efce3996ab0d8ab.1387265904.git.rashika.kheria@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org, josh@joshtriplett.org
List-Id: iommu@lists.linux-foundation.org

Mark functions int get_irte() and ir_dev_scope_init() as static in
intel_irq_remapping.c because they are not used outside this file.

This eliminates the following warnings in intel_irq_remapping.c:
drivers/iommu/intel_irq_remapping.c:49:5: warning: no previous prototyp=
e for =E2=80=98get_irte=E2=80=99 [-Wmissing-prototypes]
drivers/iommu/intel_irq_remapping.c:810:12: warning: no previous protot=
ype for =E2=80=98ir_dev_scope_init=E2=80=99 [-Wmissing-prototypes]

Signed-off-by: Rashika Kheria <rashika.kheria@gmail.com>
Reviewed-by: Josh Triplett <josh@joshtriplett.org>
---
 drivers/iommu/intel_irq_remapping.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_=
irq_remapping.c
index bab10b1..c988b8d 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -46,7 +46,7 @@ static struct irq_2_iommu *irq_2_iommu(unsigned int i=
rq)
 	return cfg ? &cfg->irq_2_iommu : NULL;
 }
=20
-int get_irte(int irq, struct irte *entry)
+static int get_irte(int irq, struct irte *entry)
 {
 	struct irq_2_iommu *irq_iommu =3D irq_2_iommu(irq);
 	unsigned long flags;
@@ -807,7 +807,7 @@ int __init parse_ioapics_under_ir(void)
 	return 1;
 }
=20
-int __init ir_dev_scope_init(void)
+static int __init ir_dev_scope_init(void)
 {
 	if (!irq_remapping_enabled)
 		return 0;
--=20
1.7.9.5
