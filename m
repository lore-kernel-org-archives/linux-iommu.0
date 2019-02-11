From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 01/12] mfd/sm501: depend on HAS_DMA
Date: Mon, 11 Feb 2019 14:35:43 +0100
Message-ID: <20190211133554.30055-2-hch@lst.de>
References: <20190211133554.30055-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190211133554.30055-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lee Jones <lee.jones@linaro.org>, x86@kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Currently the sm501 mfd driver can be compiled without any dependencies,
but through the use of dma_declare_coherent it really depends on
having DMA and iomem support.  Normally we don't explicitly require DMA
support as we have stubs for it if on UML, but in this case the driver
selects support for dma_declare_coherent and thus also requires
memmap support.  Guard this by an explicit dependency.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/mfd/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index f461460a2aeb..f15f6489803d 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1066,6 +1066,7 @@ config MFD_SI476X_CORE
 
 config MFD_SM501
 	tristate "Silicon Motion SM501"
+	depends on HAS_DMA
 	 ---help---
 	  This is the core driver for the Silicon Motion SM501 multimedia
 	  companion chip. This device is a multifunction device which may
-- 
2.20.1
