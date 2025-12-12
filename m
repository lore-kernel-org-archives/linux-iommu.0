Received: from sonic304-23.consmr.mail.ir2.yahoo.com (sonic304-23.consmr.mail.ir2.yahoo.com [77.238.179.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719A53112B0
	for <iommu@lists.linux.dev>; Fri, 12 Dec 2025 21:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.238.179.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765573206; cv=none; b=tMpZTclr/Q3NfTD2a/wkA5pIBt4AlxHaGKIiLf12TpjQwCmaeAVX2k1C1uLhskoBhQUo9YZdlCCQHEP8gSLUMIR66aX0RlmDpjnBNwBNywB+/f5s7W8rBbxz+Ib1H6LUNjjqpLfmR0+EaWx1xXE1PeeB+GoCmT1pEuguuqdLXcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765573206; c=relaxed/simple;
	bh=HHoicpDz7pJPkp1D9BgAJ+MHBTZWBDgEhD5cg75NYoU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=UrsxFrE9XuaSctDvO0BJuwcmbrrZF8ORua6dob2hAOqj3y3f4BdhfRP8A27RFdZ7cK9w7OS6d/eRCecWPzENgArztcw6FWca7SWY1lHZLlTRsfSxX6IR2P0jb4Pkxm793tSneyLXsRLIfeFztii7MHKTYO4YXIvXyT6EcRnaPIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=ZTZIgPH7; arc=none smtp.client-ip=77.238.179.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ZTZIgPH7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1765573202; bh=J0hgXFcYhgrXpNF/L0/YWU6WNGc6k3tuXk7c+8hCEOo=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=ZTZIgPH7h9Xrq8yzpeBlHHNfOLABw9tF4Q0pUIOEqIt7OnCtPolSgsOpDLE5pUjnQjTj8wqjpiJjlVVN59idIIQutokp1v5X/Nct72q3ZbWL8NnJT9uMPu0x/eoCDFrTvp6YRrDS/ZTPa+RJjKRvDlbVfxpDKTSjb/mlbZ4v/sNsd0KzUToEmr0pC4GSxofI8McU5egVMprztOdesBTL85dialk7dsrOnyLQPoHxts5BD6WKBb2UbQ4wPujlkNCQfHVAVMoj4U5DN81FHz0u3boPQDRbtVJZvXpSUbf40s6m00RkujvVEPCZcRQBOuyJw3KlNJsSSvmE+tcZ5XmGLg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1765573202; bh=BRSFJI+31WxeFpSWlIFpwAyhRr0te9RlOKnZKz3CLM3=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=dQzonpjk0qo8doIndLC+g+phRjTYjtzLS37E3UfxHZF5zEOtLLtb1d47kkcI+oRAuvWDaVhkDl1GfSV6G3cDRbgm1qSX0CAOrEkSlGfcM5IQNyMa9esq0GaPFG2AEJoDam9ldjkwVGyfWZ9bWhqZ87ANVpXBxe9d7X5lBib36HtusLgXE3y2YtHUNczJ96Y0Pr+LkVECOLpZzqrgR6cgCD4g1bf9pGsqiMikvB3at3aFnRIJvrpcj5tH9D+NIJ4G6iiwH+Syy4de9DrCrgSYZPCIHeHhuTFepVvVg2cqe518MRur31aQ9/anD17m9EcpjEVoMWuBlAe7IglibtYZig==
X-YMail-OSG: wzgP0D8VM1mn.hmMHJTIJhmytef8eyCn2lIm2U1uhliGKVTcZQ2qaV.GzKNMsRY
 Wq3GvApRBwtpl2Bd06NuxJDkm7IWVifPrM31ptUeo00H14r263LadQ846ZCg8TJd65wipRKgQcwg
 GleIJxBfOE9.afElBnK_xXbXz3bS2W2liyzHB9j5JQMWXd.PSaG2foZ43s5p8kQijbU41dMG.FWh
 BLY5ums5n3Uq67.GRP3Re3LkYAeQTzMhuhK9lYFr42w_OecChlN5KY8O3Ci3rIPffaj06X7RVxw_
 4baj_6MFm8wWfcf3tvGTJp1QwJvb7hJGpn9maSHV6bGLqQAPYuHxGmcprAr1XV1C3kpTzAbrQv7x
 jqGoj38Lck5XLA7zhsYNSdUyp3vJdVk0HKygDb1QJn7FADhsdzH_CvAQ_9jkdNn0psvU2Jgruk0h
 XCo0WwjYsSZgl4GO9Dg5v7EYrL1eOE.EqLA.8VdsUPRSl5NyK_.7uK1NbMvcqk73Hh3gFSPrd9Ir
 l5kXqWE9rg2Yv6myXEJ_sxAp2d_FDrrAkINiztL2dE2RG4MmzRvwB38uDqKXCL0UO.9byQ2_h6sF
 6SYZGD_8LCNNTyOt2X8Rj_IQc1vc67mn0WzjzSSEi9dXzkwALXZ_mP4cqwxZB8eUfgnidyfKn8L6
 m0Vjl51H94ui1ZGXqeeCvnUHpmFyFo6GZsg8AO8y.ppfDZhY_aD4gwrpmqv0tZTmppUnUl2I9P1d
 _rjcwU31ROb3NKsZlBiEKsyDf0DRcgFgvQ0U6pMcFsAtgKYm6p2IDjv_A4tKwMsq_d4tdJzOIhHi
 3k.rQVtBYfzXrryO5mEk9gxsbgKrWABT.Y8I8_N2NlJ9Ho0Z24jLPB6nvnu60UdQyxA3jEnlh9bg
 mqOMIR8jqN.vJn2s5dSyRN8ez9jMSrkXDzmn69aOivVj8aT5Wb3_U3Wo3MBBYNsOOZg6uEfojk04
 dGcRMgn24S3Khb2CylImPdHtyl4aMsQZcN65dE5iu.x7lfCsJkLCZN1Zme8Gq10yUS4brCwsASP7
 kt10vNdqFaLtG1AynMiHr1HYKmDdrJ96fisC6uoCCn2.JAQy6BvuY6ln7Or5DJPxiiaAS3fek.Z.
 wektOO875jBGh8NPPuJ3Xr5_j7hn1l_J4SMuVHAbnxHDhWx5c7UH1PavC5L74I3RcBdShXHCu.SI
 DuHJuSde4wsG1k1G0AqUO.ZkxFzneefgxPpNFZuSRCS2itidmrUmP2u1nNIbD6QP.r7nzff7iyWB
 6jAGqzgAqRbiaCjx4xDqFhzpjJcsDQLKW4LUkx6RnDkvWbw46sKztqrRaSjcRXgAS0CtldaXX3K_
 uMU3mlf0cERvmtULrmTLd3sug2pJn.__gSX6PypvCcW7VY4v4puWrKSFTv0AMwaWcr2r6Jo00zAG
 km5RgAy4b9dvMkhGxJ6X1m2BCcISSMOUKkrtdNV8BSFk65xX1Jx7POH3eGdzt77RcW9FaQ.WsOO2
 qCW.EK1YOhLGgtBl7TmnVMxJOFYqwWJcS0VcGpM3Pc47.LUXryeRIqI7ayNLpssIpcbDWzM94nqn
 z42Y3P3rw7lBGqInnQER3.vw53n9HqPkwayrd4A2zXi2DO8qQB9LVzxQ8f.hRKDdhgeIVIBmf0dI
 vWTmxQfscGt5p5Y8svTr.F_JsvJd15smQbonHLDnzmnzAmk6wapviuCauRDQJHMO.BMCEjmyY1wO
 LbJHFpqQGdDKw_StI8oMlJxg4nim.1HbRe5_eHY7cLp4hcDkyGK5LVdyrZxSnuOQ6WFbGxwdYM7Y
 M7JpLbD5Sch4C4Kr1ccii4_m5HYdk8o.Wh3z1M432B0inP.O4kl8vcbg5k2Wy5toq1xCjysz6EVP
 4u4EhqFP0a_c7fJe5g1x7WN3flg.w.VWF0wao8m7Xc5fFIb6AM1j9_ZDBLiPQsuyjlUcXTgvKJKc
 nGs8fKRosk2kv7sjeGBP7_LrqCKSKxtjT3ZA9Oa4sC.lmkBaO.IklwQVBEq_GRvqwdXT6AX4e8Dc
 h_FkBz7m4.NbS3pmofiUqXCYjkNOimlSAaRyvPURXSdc7PAiGiZw8QhCYejxLT4HYx8m4OTrJeKM
 LxzJEiBfcvx1ixt1LPxZfM_iAAsE3VIuVB_MwpQKCwfVyz5e1jvlkLcbF8gUz105zTPK6RvfyfMX
 gjlb6CzKgE0X5nCvqV_eCeWz5dW1T_ANEA90EGBDN0061x5Z62ZdOricDgqcNTBdkQmD7OE7K2DG
 vzbucUjGa3QqP1_h2W4C5EgfPulCFlc2TExSdZY8LAVurd5PkcMvL09U-
X-Sonic-MF: <andrei.popa105@yahoo.com>
X-Sonic-ID: 59ce40de-c7ac-486c-b88b-5c33e18021dc
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ir2.yahoo.com with HTTP; Fri, 12 Dec 2025 21:00:02 +0000
Received: by hermes--production-ir2-7679c5bc-fqlcc (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 4c780e16497051511c639d5ee05cc218;
          Fri, 12 Dec 2025 20:09:21 +0000 (UTC)
From: Andrei-Edward Popa <andrei.popa105@yahoo.com>
To: m.szyprowski@samsung.com
Cc: robin.murphy@arm.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Andrei-Edward Popa <andrei.popa105@yahoo.com>
Subject: [PATCH] dma-remap: fix dma_common_find_pages() page lookup for offsets
Date: Fri, 12 Dec 2025 22:09:14 +0200
Message-ID: <20251212200914.138310-1-andrei.popa105@yahoo.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20251212200914.138310-1-andrei.popa105.ref@yahoo.com>

dma_common_find_pages() previously assumed that the CPU virtual address
always pointed to the start of a DMA-coherent allocation. This fails when
memory is allocated via dma_alloc_attrs() without DMA_ATTR_FORCE_CONTIGUOUS
and then subdivided into smaller blocks using a gen_pool, relevant only
when an IOMMU is enabled.

In such cases, userspace may request a mapping via dma_mmap_attrs()
for a CPU address that is offset inside the original allocation. The
previous code could return the wrong struct page pointer.

Example scenario:

  - Allocate a large DMA buffer with dma_alloc_attrs() (non-contiguous)
  - Create a gen_pool using this buffer
  - Take sub-allocations from the gen_pool
  - Map the sub-allocations to userspace via dma_mmap_attrs()
  - dma_common_find_pages() must return the correct struct page for the offset

This patch computes the page index relative to the vm_struct backing
the DMA allocation:

    page_index = (vaddr - area->addr) >> PAGE_SHIFT

Bounds checks ensure the CPU address is within the vm_struct and
page_index < area->nr_pages.

This ensures correct behavior for sub-allocated regions from gen_pool,
without affecting allocations starting at the base address or allocations
with DMA_ATTR_FORCE_CONTIGUOUS.

Signed-off-by: Andrei-Edward Popa <andrei.popa105@yahoo.com>
---
 kernel/dma/remap.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/remap.c b/kernel/dma/remap.c
index b7c1c0c92d0c..d27477e32ed8 100644
--- a/kernel/dma/remap.c
+++ b/kernel/dma/remap.c
@@ -9,12 +9,25 @@
 struct page **dma_common_find_pages(void *cpu_addr)
 {
 	struct vm_struct *area = find_vm_area(cpu_addr);
+	unsigned long vaddr, area_vaddr;
+	size_t page_index;
 
 	if (!area || !(area->flags & VM_DMA_COHERENT))
 		return NULL;
 	WARN(area->flags != VM_DMA_COHERENT,
 	     "unexpected flags in area: %p\n", cpu_addr);
-	return area->pages;
+
+	vaddr = (unsigned long)cpu_addr;
+	area_vaddr = (unsigned long)area->addr;
+	if (unlikely(vaddr < area_vaddr ||
+		     vaddr >= area_vaddr + area->size))
+		return NULL;
+
+	page_index = (vaddr - area_vaddr) >> PAGE_SHIFT;
+	if (unlikely(page_index >= area->nr_pages))
+		return NULL;
+
+	return &area->pages[page_index];
 }
 
 /*
-- 
2.52.0

