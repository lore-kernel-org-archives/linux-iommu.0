From: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@laposte.net>
Subject: [PATCH linux-next] iommu: Enable LPAE pagetable on ARM only
Date: Sun, 22 Feb 2015 17:09:06 +0100
Message-ID: <1424621346-7822-1-git-send-email-vincent.stehle@laposte.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-next-owner@vger.kernel.org>
Sender: linux-next-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, linux-next@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@laposte.net>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Will Deacon <will.deacon@arm.com>
List-Id: iommu@lists.linux-foundation.org

LPAE iommu page table makes sense only for ARM architecture. Add the
corresponding dependency in Kconfig.

This fixes the following runtime warnings on PA-RISC architecture:

  WARNING: at drivers/iommu/io-pgtable-arm.c:413
  Modules linked in:
  CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.19.0-next-20150222-00002-=
gc420256 #2
  task: 17ca0000 ti: 17ca8000 task.ti: 17ca8000
 =20
       YZrvWESTHLNXBCVMcbcbcbcbOGFRQPDI
  PSW: 00000000000001001111111100001111 Not tainted
  r00-03  0004ff0f 0000001b 104871b0 17ca83c0
  r04-07  00001000 00000000 00000000 00000000
  r08-11  00000000 40001000 1013b36c 17ca8248
  r12-15  00000080 17e712c0 00000000 17c5e100
  r16-19  0000000c 105d8eb0 40001000 ffffffff
  r20-23  00000000 00800020 1048717c 00000000
  r24-27  00001000 00000000 00000009 10774ce0
  r28-31  00000000 00000027 17ca8480 10486d44
  sr00-03  00000000 00000000 00000000 00000000
  sr04-07  00000000 00000000 00000000 00000000
 =20
  IASQ: 00000000 00000000 IAOQ: 10486df4 10486df8
   IIR: 03ffe01f    ISR: 00000000  IOR: 17c86e54
   CPU:        0   CR30: 17ca8000 CR31: 00000002
   ORIG_R28: 00000001
   IAOQ[0]: __arm_lpae_unmap+0x144/0x4cc
   IAOQ[1]: __arm_lpae_unmap+0x148/0x4cc
   RP(r2): arm_lpae_unmap+0x34/0x6c
  Backtrace:
   [<104871b0>] arm_lpae_unmap+0x34/0x6c
   [<10127944>] 0x10127944
   [<10168ee0>] do_one_initcall+0x128/0x1dc
   [<101028fc>] 0x101028fc
   [<10161b48>] kernel_init+0x1c/0x118
   [<1015d01c>] end_fault_vector+0x1c/0x24
   [<101762ec>] save_stack_trace+0x28/0x60

Signed-off-by: Vincent Stehl=C3=A9 <vincent.stehle@laposte.net>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Will Deacon <will.deacon@arm.com>
---


Hi,

This can be seen with e.g. Linux next-20150222 on parisc with allmodcon=
fig.

Best regards,

V.


 drivers/iommu/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index baa0d97..c73fd72 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -22,6 +22,7 @@ config IOMMU_IO_PGTABLE
=20
 config IOMMU_IO_PGTABLE_LPAE
 	bool "ARMv7/v8 Long Descriptor Format"
+	depends on ARM
 	select IOMMU_IO_PGTABLE
 	help
 	  Enable support for the ARM long descriptor pagetable format.
--=20
2.1.4
