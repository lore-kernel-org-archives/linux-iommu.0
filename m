Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F29636E49B
	for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 02:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783997126; cv=none; b=F2LvbTv9CTYLqJu0Yrwonm6n8I4z1zOqKOXHb4LvjywXITtVnvbAqEIZgGFgGZ08hY+SAhJdJ2zbU81a4dGQWfSynIDs07wJQCx7xg/fcSjKojcx0qy+hARzCuoKlq+HKoFTl4bQteIzJBxztLE0vPYtqPVxyNQox0Esu7SXgqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783997126; c=relaxed/simple;
	bh=/4i2l1lXVw5VkEcguojuN5N6oiIjkOfZvOGsZLbEZ/k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kxrcQhN1px2LJ2h9Vc6C/qPTpnmn/+DBzSbjsIeTG81DJ98jH8MICw4zSd8DQs9vH0KvCOPr4Osz1RshyZCELQErUIJxySngqM0wLyfACHePJrRqDKD+rzq8YfdSWitL2k2BeigRvsqP66uKy9YKmRVUIwLT24A8jaHkW/Qs9f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=MJPF4eeb; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="MJPF4eeb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=/I
	r4wa3fOW590vWNV6UQpLA8ksS2/FrT9UEgnojaBtM=; b=MJPF4eebJvZG715H2d
	ijE/enmL19ph7PyDYWcaHBiGZo1qGP0XGPSscy4dGhuYpHdNhrHSgDHWOfdseudk
	9RFiPIMRMlexRifgyeib/bYpt8sdH1Ri0KgYHC1tRHzxjcQchPX7Y+LVT1gJ4wSM
	Mbk0FSAc6Yuf8B+HyUyT92j4M=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgDHComuolVq6bOmGA--.22466S2;
	Tue, 14 Jul 2026 10:45:02 +0800 (CST)
From: weimin xiong <15927021679@163.com>
To: iommu@lists.linux.dev
Cc: robin.murphy@arm.com,
	joro@8bytes.org,
	will@kernel.org,
	xiongweimin <xiongweimin@kylinos.cn>
Subject: [PATCH] iommu/dma: fix grammar in comments
Date: Tue, 14 Jul 2026 10:45:02 +0800
Message-ID: <20260714024502.188501-1-15927021679@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgDHComuolVq6bOmGA--.22466S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AF48KryfCFyDZw18tFyDtrb_yoW8Gry7pF
	sxWFn0kF4UGF4xta17Ja1UZFyFg3Z3ta4j9FyrGw1v9r15JFykArsYga4Fvr1UAFWkJF4a
	vF4kta4UCr1fJ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jY38nUUUUU=
X-CM-SenderInfo: jprvmjixqsilmxzbiqqrwthudrp/xtbC0g-DTGpVoq+PAQAA3u

From: xiongweimin <xiongweimin@kylinos.cn>

Clarify two slightly mangled DMA-IOMMU mapping comments.

Signed-off-by: xiongweimin <xiongweimin@kylinos.cn>
---
 drivers/iommu/dma-iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 9abaec070..2c28b951f 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1489,7 +1489,7 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
 		 *   based purely on segment lengths without needing to know
 		 *   the actual addresses beforehand.
 		 * - The mask must be a power of 2, so pad_len == 0 if
-		 *   iova_len == 0, thus we cannot dereference prev the first
+		 *   iova_len == 0, thus we cannot dereference prev, the first
 		 *   time through here (i.e. before it has a meaningful value).
 		 */
 		if (pad_len && pad_len < s_length - 1) {
@@ -1593,7 +1593,7 @@ static void __iommu_dma_free(struct device *dev, size_t size, void *cpu_addr)
 
 	if (is_vmalloc_addr(cpu_addr)) {
 		/*
-		 * If it the address is remapped, then it's either non-coherent
+		 * If the address is remapped, then it is either non-coherent
 		 * or highmem CMA, or an iommu_dma_alloc_remap() construction.
 		 */
 		pages = dma_common_find_pages(cpu_addr);
-- 
2.43.0


No virus found
		Checked by Hillstone Network AntiVirus

