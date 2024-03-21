Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D710256B76
	for <iommu@lists.linux.dev>; Thu, 21 Mar 2024 17:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711041577; cv=none; b=u+g6b8AFr2gj/+Y2a+uJN1P5mryV8bHiB/MjiB8p3p0E/n+4zSZ8LtZoa0i6uwiywdxMWJ25mqX30+rYSXl9JfiUZTED5rYfP3i7gBdHhZZEKSqTx/3qfYI6aqhzLgdlIV/JycRqLnhaGNljNxuDqATdeAmKSQC9EfYua9beQBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711041577; c=relaxed/simple;
	bh=tT7Pu2AbBqZlCMFsrLV5KGeueELYK6ealvMjWZht8/I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gtu4XzgfHzVH6gwWlCtg+ud6jUgnn4QtIiHotFDmOdQhPeu2t2rMKCTKvv02wd7twJhVXZ1knrfFvp+J7cXvSiZxZHaXSKVuxl3U0rF2lLWad5KQsAsVy8/hADmaBNXNM7svBaRFpfgRqpNYOFSUYCjL4RrFqG47xGB6SKkGrkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4V0sH40nlVz9xHvC
	for <iommu@lists.linux.dev>; Fri, 22 Mar 2024 01:03:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 298B814037D
	for <iommu@lists.linux.dev>; Fri, 22 Mar 2024 01:19:20 +0800 (CST)
Received: from huaweicloud.com (unknown [10.81.213.73])
	by APP1 (Coremail) with SMTP id LxC2BwAH_BQNbPxlII6+BA--.51964S2;
	Thu, 21 Mar 2024 18:19:19 +0100 (CET)
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
Subject: [PATCH v3 0/2] swiotlb: allocate padding slots if necessary
Date: Thu, 21 Mar 2024 18:19:00 +0100
Message-Id: <20240321171902.85-1-petrtesarik@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwAH_BQNbPxlII6+BA--.51964S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xr45JFWkJr4DZr18GrW7Jwb_yoWkuFg_AF
	W8Ja45Ar4DZF1vyas2gFsrArWUtr42yr1xAa98Xr43JF13Aw13Z3ZrtFW8Xr1UWan8CFn2
	yr93WryxCr17KjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUba8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
	1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxkF7I0Ew4C26cxK6c8Ij28IcwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E
	3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7VUj0JPtUUUUU==
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/

From: Petr Tesarik <petr.tesarik1@huawei-partners.com>

If the allocation alignment is bigger than IO_TLB_SIZE and min_align_mask
covers some bits in the original address between IO_TLB_SIZE and
alloc_align_mask, preserve these bits by allocating additional padding
slots before the actual swiotlb buffer.

Changes from v2
---------------
* Fix assignment of an uninitialized variable to pad_slots.
* Improve commit message wrt INVALID_PHYS_ADDR.

Changes from v1
---------------
* Rename padding to pad_slots.
* Set pad_slots only for the first allocated non-padding slot.
* Do not bother initializing orig_addr to INVALID_PHYS_ADDR.
* Change list and pad_slots to unsigned short to avoid growing
  struct io_tlb_slot on 32-bit targets.
* Add build-time check that list and pad_slots can hold the maximum
  allowed value of IO_TLB_SEGSIZE.

Petr Tesarik (2):
  swiotlb: extend buffer pre-padding to alloc_align_mask if necessary
  bug: introduce ASSERT_VAR_CAN_HOLD()

 include/linux/build_bug.h | 10 ++++++++++
 kernel/dma/swiotlb.c      | 37 +++++++++++++++++++++++++++++++------
 2 files changed, 41 insertions(+), 6 deletions(-)

-- 
2.34.1

