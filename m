Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F47372EFF
	for <iommu@lists.linux.dev>; Sat,  9 May 2026 07:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778310546; cv=none; b=SRocvtleo3WgSiWH0zTX6LDose6vZEl1bxlB5qOUV0FAQ+1axB7moxxeDtyXfu+uofW1j/vi+dixBLvSTm21jbcXdlCnsmRykuexm1LIfOpR1q0Dd4prqhEjDmlynOELt5BI/JmEOOKQOvJ3lnJ2TNRpS2JGpwtP6SO0RvV4x9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778310546; c=relaxed/simple;
	bh=m1nxLMf3vRQh4xIKe9AL2rkbiMSL9Xe+yNhzLqXADiA=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=diE+KFNcWsUc6be6TikXLL94h8zrU1ea1Ho4izD6ck26k0F9zmA0+q1enPQdesvxkZnb6J48/KUhadRjDAREQZfggYolGAmg0O7jVV5hOvV2u8SZBHkE/tH7BYllHztXSHx9ZmJinYo4F/4CBTwFLFhXgg3GvbmuM23a0yEeUO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=HUbdBG25; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="HUbdBG25"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1778310533;
	bh=lK7ohFdEAMIwgPt7gLEpD5YoicRl00ld7oZBGaVtP6I=;
	h=From:To:Cc:Subject:Date;
	b=HUbdBG258VY1gpzAo5pIpYthhbL4vEM3NjEpwJrNk1qwhumKnExAjmtpON3LapWIR
	 1H6deuM3iKiO4z3nuF7vdxnfY8MtF1lonTtRWJlFWQlkgSWZrvBeYDmQzIi+40ri2u
	 v1sLRnPPY/dNL5/ZVLZ1boNQ8pmvZ2wHKiknPAFg=
Received: from LAPTOP-LEO.yizhu.local ([61.169.175.90])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id 1E528A4D; Sat, 09 May 2026 15:07:37 +0800
X-QQ-mid: xmsmtpt1778310457togr8xore
Message-ID: <tencent_F13723B53F68DC857410D3DBE4F6C895C106@qq.com>
X-QQ-XMAILINFO: MJf32pulH481fEIAojPZ1aL2Obd/WH1jnkB3OnJ8p9BS4LEZKHvj8ckfFRQGTE
	 DhUpEQqnkOUC1uqR/falbX4f12fellpoyAFtAudqK/AVzyDUccZFeBhO20qtvsrDYaX7F4dyaSv4
	 CN5bdC9rykHSjjAAR4/pqW2B0BC//wGHg+cg+Z3hEsvDR2ZPX3aUNcJ/00EsLgSRc1Y5ub4wWCY+
	 2pbiV/GDNOEPOBFrGLXr3wNhA7ZT+6gmbyOqjfgXExHxAmp1QPAk5Gyc9TLauLvL3/NfctzgKwBF
	 D71PNegdAZamz9cmaHhxt44iY/P09fjZ36k5Tc02ERxWyurBdKhRDgiHrhuyVY06amtAZ+C1r/Pa
	 p0XUN5AcT8LwoYApg5TR2lEdgMGBUJk9JvqL7UOMLGxP0C08ECLVEGqgy7mZ/F3NQ/puITug38tz
	 y/6uEOmWb+/JxY8tpZvHs12GUatTrbH/hZiSA1KXZQRCRr7Vmu0V16oqz+IVBz+WOedcN+EK5tml
	 9VcK1KUoMtTTL0Bn9IzFibHAoD9uygtY4yyp52LwhQddqAOt828s5tz26QfYpgMzN4kLR7MWzBhX
	 yL4h/dCCjtw9dmakxbVmPUKzuBJmcminocNzROhKxOBNzx1AOnPC27fAJoV69fcsrD+7UVKp9j8D
	 v4qyFV5yRaGZ3XyCdRYWrrlIcV2FxpfVxZ7RUYWsQNFUCm876tq5zJ9mfdAJhCJc/W4/J9DpC7zd
	 KW8atni+Zrusy19Blq5QNbEn0xvSPcpJoxq6YSkMpMcBoHCWhMUYEIJ97AJe6afy+OtQbaPbqVVu
	 XPplw85WGw8kHnukoSSdpQ3JGIkoukhe94my9wXZMcekmb+nD2gjBZZ9NeNC8jl76fprR7S5wJy+
	 5wnVOXmLm9yvn6RPA3PWJA/3t2xA31ZpCQjoXWWSfL5hpNvPEhat82awO+bixvQq6H5H0ikyOK05
	 kcBIgo/igBSu4aR6Wniewd8u+OxGaWZgM60OJY9vU9IWLLuc5i4VFQcWZEmm8xeMC3myYi0kP9KL
	 IjyqJW9ay3yWZGtlkuSPPCvqHEoyY9PBQ7O6E+S9SeN+S8P3eV8+/w6C3+1wZb5rZFXFZHXm53an
	 3PLwNA8oac2yQDOdk4xytsvaAfXw==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: Leo Jiang <leo.jiang1224@foxmail.com>
To: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Pranjal Shrivastava <praan@google.com>,
	Joerg Roedel <joro@8bytes.org>,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Leo Jiang <leo.jiang1224@foxmail.com>
Subject: [PATCH v2] iommu/arm-smmu-v3: Limit queue allocation retry boundary to PAGE_SIZE
Date: Sat,  9 May 2026 15:07:33 +0800
X-OQ-MSGID: <20260509070733.950260-1-leo.jiang1224@foxmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Stop retrying queue allocation when qsz reaches PAGE_SIZE.

Signed-off-by: Leo Jiang <leo.jiang1224@foxmail.com>
---
Changes in v2:
- Use real name "Leo Jiang".
- Remove code comments as suggested by Will.
- Limit the queue allocation retry boundary to PAGE_SIZE, per the feedback from the maintainer.
- Link to v1: https://lore.kernel.org/linux-iommu/tencent_F6E384A40D990A279B460A0CDE1927FDF509@qq.com
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index e8d7dbe495f0..4a0b15b1d4d2 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4418,7 +4418,7 @@ int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
 		qsz = ((1 << q->llq.max_n_shift) * dwords) << 3;
 		q->base = dmam_alloc_coherent(smmu->dev, qsz, &q->base_dma,
 					      GFP_KERNEL);
-		if (q->base || qsz < PAGE_SIZE)
+		if (q->base || qsz <= PAGE_SIZE)
 			break;
 
 		q->llq.max_n_shift--;
-- 
2.34.1

