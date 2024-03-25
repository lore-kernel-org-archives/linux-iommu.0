Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06305153568
	for <iommu@lists.linux.dev>; Mon, 25 Mar 2024 08:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711355505; cv=none; b=u6e/LyMPD1Hhy2aky+udxRSDiI5KkFVfLWr1KDCnDv8r4VkrQM2pBuXDvUq6sibtbSPMIVXori9M/qbAe8q+rDGoiPzUSU64ocj+/7ghkzjRb+bOODn19A+ZB7rPZgWJ0jgoR1BLbvQy02FSezYLpb2lcPFuNybJI0aN3PUom4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711355505; c=relaxed/simple;
	bh=QlaPSqdowMBdrujZOZu5SFX0h6wJ//n1ObBSKHR/fro=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DAl6rqLv9OMd7CY8ptL0PpprN53WWtlM1Vmby0jD0lR1ZxttJvDkmZ6JnGq7hVwPMkRcdr2FEv1+5T1cBUYMTamGY/Un+ucd9NuihqUPqtzMCLSwYYIUahccq2kzYvS6MalPdPEYEm2y6i9B4KNXqUa3i4VPp2+MTCG36jYadRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4V35HH6hXkz9xHMZ
	for <iommu@lists.linux.dev>; Mon, 25 Mar 2024 16:11:23 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 0D8AB140411
	for <iommu@lists.linux.dev>; Mon, 25 Mar 2024 16:31:35 +0800 (CST)
Received: from huaweicloud.com (unknown [10.81.223.214])
	by APP2 (Coremail) with SMTP id GxC2BwB3sCRPNgFmUPztBA--.12038S4;
	Mon, 25 Mar 2024 09:31:34 +0100 (CET)
From: Petr Tesarik <petrtesarik@huaweicloud.com>
To: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Petr Tesarik <petr.tesarik1@huawei-partners.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	iommu@lists.linux.dev (open list:DMA MAPPING HELPERS)
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>,
	Petr Tesarik <petr@tesarici.cz>
Subject: [PATCH v4 2/2] bug: introduce ASSERT_VAR_CAN_HOLD()
Date: Mon, 25 Mar 2024 09:31:05 +0100
Message-Id: <20240325083105.658-3-petrtesarik@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240325083105.658-1-petrtesarik@huaweicloud.com>
References: <20240325083105.658-1-petrtesarik@huaweicloud.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwB3sCRPNgFmUPztBA--.12038S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw1DWF1xKw4ktr45GrW8tFb_yoW8WFy7pF
	9xArn5KF4jqFyxZF12k3srCF1fK34vk347Cas0gryYvr12qF9aqayDKrW3WFyqqr4vgF4a
	kw1FgrWYyw1UArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
	8EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r4UJwAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVW8ZVWrXwCY1x0264kExVAvwVAq07x20xyl42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sR_yv3UUUUUU==
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/

From: Petr Tesarik <petr.tesarik1@huawei-partners.com>

Introduce an ASSERT_VAR_CAN_HOLD() macro to check at build time that a
variable can hold the given value.

Use this macro in swiotlb to make sure that the list and pad_slots fields
of struct io_tlb_slot are big enough to hold the maximum possible value of
IO_TLB_SEGSIZE.

Signed-off-by: Petr Tesarik <petr.tesarik1@huawei-partners.com>
---
 include/linux/build_bug.h | 10 ++++++++++
 kernel/dma/swiotlb.c      |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/include/linux/build_bug.h b/include/linux/build_bug.h
index 3aa3640f8c18..6e2486508af0 100644
--- a/include/linux/build_bug.h
+++ b/include/linux/build_bug.h
@@ -86,4 +86,14 @@
 		"Offset of " #field " in " #type " has changed.")
 
 
+/*
+ * Compile time check that a variable can hold the given value
+ */
+#define ASSERT_VAR_CAN_HOLD(var, value) ({		\
+	typeof(value) __val = (value);			\
+	typeof(var) __tmp = __val;			\
+	BUILD_BUG_ON_MSG(__tmp != __val,		\
+		#var " cannot hold " #value ".");	\
+})
+
 #endif	/* _LINUX_BUILD_BUG_H */
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index d7a8cb93ef2d..a34ea2c35446 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -285,6 +285,8 @@ static void swiotlb_init_io_tlb_pool(struct io_tlb_pool *mem, phys_addr_t start,
 		mem->areas[i].used = 0;
 	}
 
+	ASSERT_VAR_CAN_HOLD(mem->slots[0].list, IO_TLB_SEGSIZE);
+	ASSERT_VAR_CAN_HOLD(mem->slots[0].pad_slots, IO_TLB_SEGSIZE);
 	for (i = 0; i < mem->nslabs; i++) {
 		mem->slots[i].list = min(IO_TLB_SEGSIZE - io_tlb_offset(i),
 					 mem->nslabs - i);
-- 
2.34.1

