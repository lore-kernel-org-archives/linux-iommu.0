Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC841D61A6
	for <iommu@lists.linux.dev>; Tue,  3 Sep 2024 07:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725348365; cv=none; b=l6C0Fxzjo0X4K7FbYVuZu2tgovhY81m/LPzOg4kxtmGKWFx9POF/uOuewTa/p4CfofzqFGkP49U3VVFrzqkwkDFwvANlGTk3ZZLGcwRtNBoIPfj12g+NcH+ph8wLUwKs1m5BCI424ZpM5DCceT0jxc/cJxRdr63sIszssVZ8Yoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725348365; c=relaxed/simple;
	bh=12GmkGOMibEQ+eJlqJfLkuRReRvjDI5Yl1/I9s0ocvA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=C/x0VOYefbuJxVdoNGu+Nng+n5Qhdn3I2B6srLpyExDNSiCMX+BeTxMdgXnHNXZXLF/PNL1QR5RYU4RLOz1xbDszsOOaHMhn4ZAA9y42zaErz78rRlmR92+d8YqrYPms9jewo4A7RVTRD/HBtd0INSdygWLTxST7Dfp4GsYhCKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-03 (Coremail) with SMTP id rQCowABXX38AutZmTaq_AA--.45023S2;
	Tue, 03 Sep 2024 15:25:52 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: joro@8bytes.org,
	suravee.suthikulpanit@amd.com,
	will@kernel.org,
	robin.murphy@arm.com
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] iommu/amd: Convert comma to semicolon
Date: Tue,  3 Sep 2024 15:25:18 +0800
Message-Id: <20240903072518.780705-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowABXX38AutZmTaq_AA--.45023S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Jw4UZF15Zr47GrWUXF4UXFb_yoWfKrb_uF
	4UXFZ3Ja4DCrsIka4Utwna9rW2gas2qan2gr4vvr93Ar1kZF48Zay8ZFykAw4UXr43KF17
	Grn8Cr13WFWqqjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbV8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r126r1DMxkIecxEwVAFwVW8CwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
	W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
	1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
	IIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
	x4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
	DU0xZFpf9x0JUDuciUUUUU=
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Replace a comma between expression statements by a semicolon.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/iommu/amd/io_pgtable_v2.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/io_pgtable_v2.c b/drivers/iommu/amd/io_pgtable_v2.c
index 664e91c88748..67f1fd8fab07 100644
--- a/drivers/iommu/amd/io_pgtable_v2.c
+++ b/drivers/iommu/amd/io_pgtable_v2.c
@@ -373,9 +373,9 @@ static struct io_pgtable *v2_alloc_pgtable(struct io_pgtable_cfg *cfg, void *coo
 	pgtable->iop.ops.unmap_pages  = iommu_v2_unmap_pages;
 	pgtable->iop.ops.iova_to_phys = iommu_v2_iova_to_phys;
 
-	cfg->pgsize_bitmap = AMD_IOMMU_PGSIZES_V2,
-	cfg->ias           = ias,
-	cfg->oas           = IOMMU_OUT_ADDR_BIT_SIZE,
+	cfg->pgsize_bitmap = AMD_IOMMU_PGSIZES_V2;
+	cfg->ias           = ias;
+	cfg->oas           = IOMMU_OUT_ADDR_BIT_SIZE;
 	cfg->tlb           = &v2_flush_ops;
 
 	return &pgtable->iop;
-- 
2.25.1

