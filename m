Received: from ustc.edu.cn (smtp2.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700C41C29
	for <iommu@lists.linux.dev>; Sat, 26 Aug 2023 09:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=7RvoeyXeXC
	Oi4+UG2k+CAb5XozdjZDVYVoNklTU6WVg=; b=audV+xeg7phbMOb58zdzTQQUHg
	P2MeHduKtAHx/iqwizblNz7lhEkYY33s6+wlTwcZA9IBuesRbPnlAcQOLvgxZZEd
	RFdQ0g0q71F8ZOtQC/mpdwVv42cfiB8h92LctRFMgGzIisxTUUk7vRaegdGogbUK
	sqLNOk/SlNu0RIiLE=
Received: from localhost.localdomain (unknown [101.88.124.132])
	by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygBn6_ikvelkAscYAQ--.8734S2;
	Sat, 26 Aug 2023 16:54:01 +0800 (CST)
From: Chunhui He <hchunhui@mail.ustc.edu.cn>
To: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Chunhui He <hchunhui@mail.ustc.edu.cn>
Subject: [PATCH 1/2] dma/pool: trivial: add semicolon after label attributes
Date: Sat, 26 Aug 2023 08:53:17 +0000
Message-Id: <20230826085317.69713-1-hchunhui@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LkAmygBn6_ikvelkAscYAQ--.8734S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZF43AFy5uF1UWr13Aw1DWrg_yoWfXFc_Gw
	1UWwnFgrs8uFZF9w1UA395tw1vq3s5WF48ua1IyFWqka1Dtan8XF1qg395Wr9rCw48Wa4j
	kas8XrWDKrW3WjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbz8FF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJV
	W0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxG
	rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
	xKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfU5WlkUUUUU
X-CM-SenderInfo: pkfk30xkxlqzxdloh3xvwfhvlgxou0/

The gcc document says label attributes are ambiguous if they are
not immediately followed by a semicolon. Although the ambiguity
does not arise in C90/99, it would be better to add it.

Link: https://gcc.gnu.org/onlinedocs/gcc/Attribute-Syntax.html#Label-Attributes-2
Signed-off-by: Chunhui He <hchunhui@mail.ustc.edu.cn>
---
 kernel/dma/pool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index 1acec2e22827..f99f02b88c40 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -136,7 +136,7 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
 #ifdef CONFIG_DMA_DIRECT_REMAP
 	dma_common_free_remap(addr, pool_size);
 #endif
-free_page: __maybe_unused
+free_page: __maybe_unused;
 	__free_pages(page, order);
 out:
 	return ret;
-- 
2.39.2


