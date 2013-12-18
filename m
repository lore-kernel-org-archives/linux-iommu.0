From: Rashika Kheria <rashika.kheria@gmail.com>
Subject: [PATCH 3/3] drivers: iommu: Mark function eoi_ioapic_pin_remapped()
 as static in irq_remapping.c
Date: Wed, 18 Dec 2013 12:06:45 +0530
Message-ID: <9550af5889a779ff889d4a4371097daaf42cf4a3.1387265905.git.rashika.kheria@gmail.com>
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

Mark function eoi_ioapic_pin_remapped() as static in irq_remapping.c
because it is not used outside this file.

This eliminates the following warning in
irq_remapping.c:drivers/iommu/irq_remapping.c:153:6: warning: no
previous prototype for =E2=80=98eoi_ioapic_pin_remapped=E2=80=99 [-Wmis=
sing-prototypes]

Signed-off-by: Rashika Kheria <rashika.kheria@gmail.com>
Reviewed-by: Josh Triplett <josh@joshtriplett.org>
---
 drivers/iommu/irq_remapping.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/irq_remapping.c b/drivers/iommu/irq_remappin=
g.c
index 39f81ae..3b05d1b 100644
--- a/drivers/iommu/irq_remapping.c
+++ b/drivers/iommu/irq_remapping.c
@@ -150,7 +150,7 @@ static int irq_remapping_setup_msi_irqs(struct pci_=
dev *dev,
 		return do_setup_msix_irqs(dev, nvec);
 }
=20
-void eoi_ioapic_pin_remapped(int apic, int pin, int vector)
+static void eoi_ioapic_pin_remapped(int apic, int pin, int vector)
 {
 	/*
 	 * Intr-remapping uses pin number as the virtual vector
--=20
1.7.9.5
