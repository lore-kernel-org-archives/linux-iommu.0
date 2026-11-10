Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794294664;
	b=i7884rdSyluJv5lTMrzHHxfGO8ElxHHIpEekh3VIkV485gGe4IGJysz/rsNBNZ51OXB1
	 7DpIVRvALliqFclCUmfPMEbbJld3Yv4aUI3aPgYhij68CIkKIEyE22ub1wz4EyYTshIUv
	 csGGRz/NOgLMmTpoCu8RkWu3hR9L2bmsulW8+4iOQz+R/cttJeYJVhaOn2cT2oKP/ovJh
	 GiVv77UMPYm6QaktX1bJbdzTMBHr7lo+jtFW3sWr7zYiNElS4tCd2slZhtWMGiK3SBdNf
	 dtpw8CMGPkD28+/rkHSHq75sIiq817G+MGn35RQP3XlnvWr81UJKU17hwHCvihEUGVg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794294664;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=xQ4jMpFd0ALOYGpQB9FG46MLH0S7oU+ejuWtGKhW7Jk=;
	b=Qcr5pwjOsGg9JuyC9ujmccX4aGLozMDVRdyz+Kxf8THSY4H/JLAg+KYnoKSVdH1vjUOg
	 nnY6nBDeryoRcRaIhAIoJWIgcQ8l91v2X80QOx13FzUJ9NnQoaDo2QAueFAJuWFnWfD3A
	 qX3Xb5XiM3MoaBURwRQfuRCTjOQFrZQmF0gAkUspHdvaCkUMNiluBLoX4oXJUVhHN1Qjl
	 KiLnOmz0Bw24c0Y5muQG1oZKsUO/P7lqNTQhBuVYzLiraTZeaYiX2jnSEcJlsgXHEOJR0
	 yirDUnqrrskkDdbyuY+RuPQxkpgIHaxLuSjUnMowfuC0RMSFqAvta7aOETBQHxFRcnA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WXKgqdVE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C41606A326;
	Tue, 10 Nov 2026 07:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WXKgqdVE
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794294663;
	b=SX6INuHZBHNSpwJJ+VfaG2KvZIHxyqnmknY8ldwvTW1DiJDBQIR7Sr3pXL5FMkAy52kQ
	 aUm6KIvQ4rYGM20LJ1Z8/LcupCS/pLnyZFS9n8suT4eBnLL0yFiRBS2rzobr5xQbQI1x0
	 X4ByuUOfz9jLk9NOcZ5jXaGQ7faKhpn6UcqFWys+O2s8NYnRJjLaPtIQC1XdMQVAtzwFr
	 2npBeHJ0jqkoJhAK3o7bI9A7+Frys4AVUXY0D6u0VeCUO4wNGlfKjYqCy0PkJ7mo2eRrO
	 SFlLzLPJdl5lFA9XUEH9S+wjLzT9kPOmdMRlDX0aj82HeTixP8iHFeR6SUQxxiPd6qw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794294663;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=xQ4jMpFd0ALOYGpQB9FG46MLH0S7oU+ejuWtGKhW7Jk=;
	b=thkeD0VVL8jPE84hjmEEqj07ZmvxGQ+OY0qWPNBsmZ1pMxOEKAg7JLtmU7FE/OXblkOk
	 Hxfx075kk2aZ3s9G+Ev/DYr2uq32a4VH/tRsTMDBsY3JSaRdNWy2qZUHvlHoDAM/Y7jdN
	 WoXpqTK/e5RR9pgQCME9l4YwrDECITBPKkU0EecNICRzia2udign573dagGVDU4QdMR68
	 l1Eh3BA51N42qV7cNrycQuOYqtvVhYEyeNTj9TVCDYCCgIZ+/tpBcEXpFUL5dzf/43vxo
	 bTD0reJpCQzh9gdhoAJ5tu9Nl/YnELwI02Gm0k8vFQscjPXdP8fUnY5CA2WDxlIQBCg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id CA3061F0089F;
	Tue, 10 Nov 2026 07:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794294663;
	bh=xQ4jMpFd0ALOYGpQB9FG46MLH0S7oU+ejuWtGKhW7Jk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=WXKgqdVEkC65IBksa+cC+H9ZtfNbYQE2nFyPRzEPZRe79GJJGUV3i64XhS+xb09XN
	 GbnoSW2Gr/QW4Xwiis/sDh96ZNkfDej9D5ea6MzG1j8g6XKBf3rw+KN1DDLODvXxzh
	 8dine03TaaP3zcVC2DqPBdUxH7lNJCWHBl7/NX1lT5PvrRoc/h4A69O5jMGlcXJ3su
	 AqUAKCjYaAejbvz6AnDv++VYfs0TEh60XkcbD2Z33K4qy2YagU/0b+CFOk3ax4aHQe
	 Kkr8HI/bxfou1c0Q+joos7ZxB4xrqluPy48tCoKmjT+FuYGvCkvwlXSrG/wp0qheDq
	 kIztTn+iom8pQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 510B548926;
	Tue, 10 Nov 2026 07:11:02 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Tue, 10 Nov 2026 07:11:02 +0000
Subject: [PATCH 1/5] iommu/rockchip: Don't walk a page table that a reset
 took away
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261110-iommu-rockchip-faults-v1-1-b1dda574dbb8@gmail.com>
References: <20261110-iommu-rockchip-faults-v1-0-b1dda574dbb8@gmail.com>
In-Reply-To: <20261110-iommu-rockchip-faults-v1-0-b1dda574dbb8@gmail.com>
To: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Heiko Stuebner <heiko@sntech.de>, 
 Jeffy Chen <jeffy.chen@rock-chips.com>, Tomasz Figa <tfiga@chromium.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794294661; l=2142;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=ToGf1ObH2yGo1OMq0C57Okydv2han7Kmp00MrNYUTIY=;
 b=vqEYjTZrW9gc7C8emgS8qlnnnYJOcO/kFRASz5eG+NVNvNmDn9iyaZcTnYLO1wAW6NxEhyFRS
 44usyRyEK44ADSHnskRvuD6Y5MDdVSpbvtbO18Lq7pWquTbkZBnC2+D
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

When a page fault is reported, log_iova() reads the directory address
back from the MMU_DTE_ADDR register of the IOMMU and dereferences it
through phys_to_virt() to log the page table entries of the faulting
IOVA. The IOMMU of an RK3588 video decoder core is reset with the core:
by the core's own soft reset, which the hardware also does by itself
when a job times out, and by the core's AXI reset line. A fault taken
just before such a reset is handled with MMU_DTE_ADDR reading 0, and
log_iova() dereferences the physical address 4 * dte_index:

rk_iommu fdc38700.iommu: Page fault at 0x0000000013400200 of type read
Unable to handle kernel paging request at virtual address ffff600000000026
KASAN: probably wild-memory-access in range [...0130-...0137]
...
rk_iommu_irq+0x490/0x758

Only walk the directory if the register holds the address of memory, and
say that the page table was lost to a reset otherwise. The fault is
still acknowledged (zap, PAGE_FAULT_DONE, INT_CLEAR) as before.

Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 drivers/iommu/rockchip-iommu.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 21af2f621c76..d40e2a26b7be 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -564,6 +564,17 @@ static void log_iova(struct rk_iommu *iommu, int index, dma_addr_t iova)
 	mmu_dte_addr = rk_iommu_read(base, RK_MMU_DTE_ADDR);
 	mmu_dte_addr_phys = iommu->rk_ops->pt_address(mmu_dte_addr);
 
+	/*
+	 * A reset of the master can reset its IOMMU too, between the fault and
+	 * this handler: DTE_ADDR then reads 0. Don't walk a directory that
+	 * isn't in memory; the caller still acknowledges the fault.
+	 */
+	if (!mmu_dte_addr || !pfn_valid(PHYS_PFN(mmu_dte_addr_phys))) {
+		dev_err(iommu->dev, "iova = %pad: fault while page table lost to reset (MMU_DTE_ADDR %#08x)\n",
+			&iova, mmu_dte_addr);
+		return;
+	}
+
 	dte_addr_phys = mmu_dte_addr_phys + (4 * dte_index);
 	dte_addr = phys_to_virt(dte_addr_phys);
 	dte = *dte_addr;

-- 
2.55.0


