From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: [RFC PATCH 02/11] powerpc/svm: Select CONFIG_DMA_DIRECT_OPS and CONFIG_SWIOTLB
Date: Thu, 23 Aug 2018 23:59:24 -0300
Message-ID: <20180824025933.24319-3-bauerman@linux.ibm.com>
References: <20180824025933.24319-1-bauerman@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180824025933.24319-1-bauerman@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linuxppc-dev@lists.ozlabs.org
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>, Anshuman Khandual <anshuman.linux@gmail.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Christoph Hellwig <hch@lst.de>, Michael Ellerman <mpe@ellerman.id.au>, Mike Anderson <andmike@linux.ibm.com>, Paul Mackerras <paulus@samba.org>, Ram Pai <linuxram@us.ibm.com>, Anshuman Khandual <khandual@linux.vnet.ibm.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>
List-Id: iommu@lists.linux-foundation.org

From: Anshuman Khandual <khandual@linux.vnet.ibm.com>

Ultravisor based secure guest platforms will use generic SWIOTLB DMA API
(i.e swiotlb_dma_ops structure) available under the CONFIG_DMA_DIRECT_OPS
config. Also base CONFIG_SWIOTLB needs to be explicitly selected as well.
Select both these config options on powerpc server platforms with secure
guest support.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 arch/powerpc/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index f786c962edf0..90f73d15f58a 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -444,6 +444,8 @@ config PPC_SVM
        bool "Secure virtual machine (SVM) support for POWERPC"
        default n
        depends on PPC_PSERIES
+       select DMA_DIRECT_OPS
+       select SWIOTLB
        help
          Support secure guests on POWERPC. There are certain POWER platforms
 	 which support secure guests with the help of an Ultravisor executing
