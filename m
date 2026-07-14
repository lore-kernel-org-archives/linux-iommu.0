Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE823366055
	for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 02:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783997143; cv=none; b=SuJywxlWTd6nH+cviG3rz/iKGrEUGSf7/XCaQPtHw9GXcOpa6dgiLNv6OR+6LLaD4CIy+mxFfBOUnn1yw1zH5F77DeH6wrcpKu3szyh795PBrT5RzZRwKF/zos0f005s7kkJ7QAY9G8D0rKh7Xnp3DUonAjcBq1Ph43MABJElYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783997143; c=relaxed/simple;
	bh=teSQeY7e13GNeSWCUJYDqXAQ/FHgrw513a9vA5tFYfk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MMjqePNqGKhPotxOiMCCv4AYaPP6gPgikDA/oncCDHt+LwAvrg7cofu11ZCg4pS9qqRFXU7NlhtSbHB8Qa5EU0q8d2EtyJTgHM5W7OQj/uZagCq/neD92mvYqZ9/rA6mVMFFegmlNb2EQkNB/WEc+yCCT5wk4yn6K4rrkZFcKTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=bxlJM0Ai; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="bxlJM0Ai"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=QS
	crsAz8sWe3EMFQjRHgboQtjCxsFrOrjMwAkQQbjuM=; b=bxlJM0AiW476bldOlk
	W0XmnKmcNFx21IWPP8+Ayd1+Yev3YczAtxsnDPaBmjHCuRYiJH7if/YTLKGAojXo
	SYw9JfF/26uuYyD2hkfSR/CIt6/D++jpYTmRz3OXRsilCzznmQZ9qGncPYnZ5vZY
	7vwNsf/hKDeHGnTkEa8Ce3QRM=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wC3cwa0olVqnreUJQ--.6535S2;
	Tue, 14 Jul 2026 10:45:08 +0800 (CST)
From: weimin xiong <15927021679@163.com>
To: iommu@lists.linux.dev
Cc: will@kernel.org,
	robin.murphy@arm.com,
	joro@8bytes.org,
	linux-arm-kernel@lists.infradead.org,
	xiongweimin <xiongweimin@kylinos.cn>
Subject: [PATCH] iommu/arm-smmu-v3: fix grammar in comment
Date: Tue, 14 Jul 2026 10:45:08 +0800
Message-ID: <20260714024508.188540-1-15927021679@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC3cwa0olVqnreUJQ--.6535S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtr1kZF4fAFy5Cr45tr13Arb_yoWkWFgEgw
	1rA3s3Jw1FkFy2v3Wj9a4fZ34vvrW7Zr1kurn5W3sxJw18Jr40gFWkJ395Wa1xGrWjkFy3
	Jan0gry8JrW3WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8vPfPUUUUU==
X-CM-SenderInfo: jprvmjixqsilmxzbiqqrwthudrp/xtbC8xTFTmpVorTAyQAA3M

From: xiongweimin <xiongweimin@kylinos.cn>

Correct "possibly failure" to "possibly fail".

Signed-off-by: xiongweimin <xiongweimin@kylinos.cn>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index a10affb48..023cb138a 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3252,7 +3252,7 @@ static void arm_smmu_remove_master_domain(struct arm_smmu_master *master,
  *  5. old domain updates its invs array, unreferencing master->build_invs
  *
  * For 1 and 5, prepare the two updated arrays in advance, handling any changes
- * that can possibly failure. So the actual update of either 1 or 5 won't fail.
+ * that can possibly fail. So the actual update of either 1 or 5 won't fail.
  * arm_smmu_asid_lock ensures that the old invs in the domains are intact while
  * we are sequencing to update them.
  */
-- 
2.43.0


No virus found
		Checked by Hillstone Network AntiVirus

