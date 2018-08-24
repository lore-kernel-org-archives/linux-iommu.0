From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: [RFC PATCH 05/11] powerpc/svm: Don't release SWIOTLB buffers on secure guests
Date: Thu, 23 Aug 2018 23:59:27 -0300
Message-ID: <20180824025933.24319-6-bauerman@linux.ibm.com>
References: <20180824025933.24319-1-bauerman@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180824025933.24319-1-bauerman@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linuxppc-dev@lists.ozlabs.org
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>, Anshuman Khandual <anshuman.linux@gmail.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Christoph Hellwig <hch@lst.de>, Michael Ellerman <mpe@ellerman.id.au>, Mike Anderson <andmike@linux.ibm.com>, Paul Mackerras <paulus@samba.org>, Ram Pai <linuxram@us.ibm.com>, Anshuman Khandual <khandual@linux.vnet.ibm.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>
List-Id: iommu@lists.linux-foundation.org

From: Anshuman Khandual <khandual@linux.vnet.ibm.com>

Even though SWIOTLB slab gets allocated and initialized on each powerpc
platform with swiotlb_init(), it gets released away again on all server
platforms because ppc_swiotlb_enable variable never gets set. Secure
guests would require SWIOTLB DMA API support for virtio bounce buffering
purpose. Hence retain the allocated buffer by setting ppc_swiotlb_enable
variable for secure guests on Ultravisor platforms.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 arch/powerpc/kernel/svm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kernel/svm.c b/arch/powerpc/kernel/svm.c
index eab2a64d8643..891db2de8c04 100644
--- a/arch/powerpc/kernel/svm.c
+++ b/arch/powerpc/kernel/svm.c
@@ -16,6 +16,7 @@ static int __init init_svm(void)
 	if (!is_svm_platform())
 		return 0;
 
+	ppc_swiotlb_enable = 1;
 	swiotlb_update_mem_attributes();
 
 	return 0;
