Received: from frasgout12.his.huawei.com (unknown [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC71D1548D
	for <iommu@lists.linux.dev>; Thu,  3 Aug 2023 12:00:16 +0000 (UTC)
Received: from mail02.huawei.com (unknown [172.18.147.229])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4RGnB54KGyz9xGWT
	for <iommu@lists.linux.dev>; Thu,  3 Aug 2023 19:46:37 +0800 (CST)
Received: from A2101119013HW2.china.huawei.com (unknown [10.81.221.240])
	by APP2 (Coremail) with SMTP id GxC2BwB3d++6lstkfcs3AA--.61178S2;
	Thu, 03 Aug 2023 13:00:01 +0100 (CET)
From: Petr Tesarik <petrtesarik@huaweicloud.com>
To: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev (open list:DMA MAPPING HELPERS),
	linux-kernel@vger.kernel.org (open list)
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>,
	petr@tesarici.cz
Subject: [PATCH v1] swiotlb: optimize get_max_slots()
Date: Thu,  3 Aug 2023 13:59:41 +0200
Message-Id: <20230803115941.497-1-petrtesarik@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwB3d++6lstkfcs3AA--.61178S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tw47WFWkCF4ktw45Zw1kKrg_yoW8Jw4Upa
	1xJr1rGayvqF1xAa4IyFs3KFyS93srJa9xXFZ0kryfu3W5tF4FqrWxK3yqq34FqrWvkF1a
	va4aqw4vyr43JrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j
	6r4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0264kExVAvwVAq
	07x20xyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU2fO
	wUUUUU=
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected

From: Petr Tesarik <petr.tesarik.ext@huawei.com>

Use a simple logical shift and increment to calculate the number of slots
taken by the DMA segment boundary.

At least GCC-13 is not able to optimize the expression, producing this
horrible assembly code on x86:

	cmpq	$-1, %rcx
	je	.L364
	addq	$2048, %rcx
	shrq	$11, %rcx
	movq	%rcx, %r13
.L331:
	// rest of the function here...

	// after function epilogue and return:
.L364:
	movabsq $9007199254740992, %r13
	jmp	.L331

After the optimization, the code looks more reasonable:

	shrq	$11, %r11
	leaq	1(%r11), %rbx

Signed-off-by: Petr Tesarik <petr.tesarik.ext@huawei.com>
---
 kernel/dma/swiotlb.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 2b83e3ad9dca..a95d2ea2ae18 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -577,9 +577,7 @@ static inline phys_addr_t slot_addr(phys_addr_t start, phys_addr_t idx)
  */
 static inline unsigned long get_max_slots(unsigned long boundary_mask)
 {
-	if (boundary_mask == ~0UL)
-		return 1UL << (BITS_PER_LONG - IO_TLB_SHIFT);
-	return nr_slots(boundary_mask + 1);
+	return (boundary_mask >> IO_TLB_SHIFT) + 1;
 }
 
 static unsigned int wrap_area_index(struct io_tlb_mem *mem, unsigned int index)
-- 
2.25.1

