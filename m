Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10691192B62;
	Fri,  3 Jan 2025 02:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735872411; cv=none; b=h7eK7DGfkcedqsWp2iVeI7VTZ0pn1LKp5rh8waWErMBNetO2qnvgTjQ3h+eEvS1/xmwiNcdSx1eGyCQqXV3SmfwTY/i4eAYw5Ue3ZaeUW3PYqQZKQgm0x0QbKtW9QTzo6OHeZAUbhWxubWopITCwU+R6X/PO+UOxvgDHbSdE3mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735872411; c=relaxed/simple;
	bh=HNbF+5O8p3vFxk/5XDByidOa1qlDFCI6xUWBJXVcxzA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nLQ3ITiqg9CRrbhnk0H1Wist1CiSYFoxGyk2BxASUISlv8809Q37qxZqMwmeOhUQIUWxsmBlVLLItY7RnVdVK/12Kp3Qg+LolsbxL0nKu/mTixmwai70ZOrV9MapYabAOadFQWUCkEIu1ag68hhdeSn0/B/iHSLSuvgcS+8InI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SI6LGoTl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SI6LGoTl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C4F2C4CED0;
	Fri,  3 Jan 2025 02:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735872410;
	bh=HNbF+5O8p3vFxk/5XDByidOa1qlDFCI6xUWBJXVcxzA=;
	h=From:To:Cc:Subject:Date:From;
	b=SI6LGoTllTrTeMyXS4bpCG7Yb/HzxshsEz1Q7zVq+FumuTTblw7P057FAOYrSkl+E
	 7VbikWGwD+HsVCeH1Q5WkcrGl714QCQUnGf6UifahF/fRWsPuGYvL5ux7m4O/ptday
	 MlVmmbWjvyDaRH1eX4CebugmLKQ6dEtvs5wl9w+xhlS8qaJ+dILw97ld+SGWeHtIOz
	 nYn24iK8ap0+rr+SblbjHlcuB1e94HVoaVHpBsvBzvWEXH2DwOGZ0mt8JyAUZ0oJ8/
	 MLNI5bk51as4C1r5Cug/AG6go1z9lRRChaMA3V5sHmOP9Nq6VqcyoWNVUk57CWlII1
	 QR+bFI3I0Pkag==
From: guoren@kernel.org
To: tjeznach@rivosinc.com
Cc: joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	baolu.lu@linux.intel.com,
	zong.li@sifive.com,
	iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Guo Ren <guoren@linux.alibaba.com>,
	Guo Ren <guoren@kernel.org>
Subject: [PATCH] iommu/riscv: Fixup compile warning
Date: Thu,  2 Jan 2025 21:46:16 -0500
Message-Id: <20250103024616.3359159-1-guoren@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guo Ren <guoren@linux.alibaba.com>

When __BITS_PER_LONG == 32, size_t is defined as unsigned int rather
than unsigned long. Therefore, we should use size_t to avoid
type-checking errors.

Fixes: 488ffbf18171 ("iommu/riscv: Paging domain support")
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Cc: Tomasz Jeznach <tjeznach@rivosinc.com>
---
 drivers/iommu/riscv/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 8a05def774bd..38d381164385 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -1270,7 +1270,7 @@ static phys_addr_t riscv_iommu_iova_to_phys(struct iommu_domain *iommu_domain,
 					    dma_addr_t iova)
 {
 	struct riscv_iommu_domain *domain = iommu_domain_to_riscv(iommu_domain);
-	unsigned long pte_size;
+	size_t pte_size;
 	unsigned long *ptr;
 
 	ptr = riscv_iommu_pte_fetch(domain, iova, &pte_size);
-- 
2.40.1

