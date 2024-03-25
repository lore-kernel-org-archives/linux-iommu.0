Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9C3153511
	for <iommu@lists.linux.dev>; Mon, 25 Mar 2024 08:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711355497; cv=none; b=bnCElpxHnfCdPhDkSDpEa4uZnBtEp0YBJSexQmJ1sqD9zR4OFQEO55voTgoVObOb76vnvD8+1ehL7LS3c4AEPGoAHhjJ4D1cEJ730Fde5huKKYdzSjeaA+A4k5l3k7Qio34D/lvNQN9BkUjb5AUwwMIJgnJhk2gnp2x+QBWRwb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711355497; c=relaxed/simple;
	bh=RQiAwdtoaFczmBg2nAsQJmkj8xlavEoNGQxwoKrZbwc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R40HhACsAheJhvZekd/SmoyjMkT5ec5Xme1E/3flhFheABy9YI0P6399RR9RVfLPz5+n24Xe4MWhSHoTp5tJrAzSux0FonB9ky/4siqJ9mo8sWwx3BD8pzGjXGCr4BOlAkXr33INkOnfQcGWIwQE1xVTvLxt+1agxAywYsJZQ6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4V35Mw3smzz9v7Yh
	for <iommu@lists.linux.dev>; Mon, 25 Mar 2024 16:15:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id E19F6140417
	for <iommu@lists.linux.dev>; Mon, 25 Mar 2024 16:31:20 +0800 (CST)
Received: from huaweicloud.com (unknown [10.81.223.214])
	by APP2 (Coremail) with SMTP id GxC2BwB3sCRPNgFmUPztBA--.12038S2;
	Mon, 25 Mar 2024 09:31:20 +0100 (CET)
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
Subject: [PATCH v4 0/2] swiotlb: allocate padding slots if necessary
Date: Mon, 25 Mar 2024 09:31:03 +0100
Message-Id: <20240325083105.658-1-petrtesarik@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwB3sCRPNgFmUPztBA--.12038S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw1DWF1Duw1kKr4UZw17GFg_yoW8Xw1DpF
	1fGrn3JF18tFyxW3ZIk3y0kF1rJw18Ca1UCFsIgryrZr15ZF1kZFyqyr4rGryUJrWIqF42
	k3W5urWUCF4UJw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBa14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8JV
	W8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wrylc7CjxVAKzI0EY4vE52x082I5MxAIw28Icx
	kI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
	xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42
	IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAI
	cVCF04k26cxKx2IYs7xG6r4j6FyUMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2js
	IEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRrOzxUUUUU=
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/

From: Petr Tesarik <petr.tesarik1@huawei-partners.com>

If the allocation alignment is bigger than IO_TLB_SIZE and min_align_mask
covers some bits in the original address between IO_TLB_SIZE and
alloc_align_mask, preserve these bits by allocating additional padding
slots before the actual swiotlb buffer.

Changes from v3
---------------
* Add a parameter to swiotlb_align_offset(), so it is not open-coded in
  swiotlb_tbl_map_single().
* Extend the description of swiotlb_align_offset() and convert it to the
  kernel-doc format.
* Use bit operations to calculate number of padding slots and the padding
  inside a slot. This matches all other such calculations in swiotlb.c.

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

 include/linux/build_bug.h | 10 +++++++
 kernel/dma/swiotlb.c      | 61 ++++++++++++++++++++++++++++++---------
 2 files changed, 58 insertions(+), 13 deletions(-)

-- 
2.34.1

