Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2E838839F
	for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 02:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783997121; cv=none; b=byPhQC8WL+VVAAMs2OfPX9KkHwHqEpNmytGKglH1q4GPWw9Z4fPnPaOj+h6Y0GcaRevyNpandF5VYn2nonMtW+ZnluqX9zfPojD0tHkWOTOikeVTRjCS250qJ2XmdpgI6dMaEujtnTS0moXcofVkgQ2L8VYo9gHQYBHBnZqCUT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783997121; c=relaxed/simple;
	bh=kNfpHNgDdLsVAKI2G171THdkygX7Ggj7nl3ICPcY/FY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FUkekX/rYfbiWluCjjYLBmhz0yoqrEL6F0JaiV9ouA9lpHI9lJPhJW4FIVMawie42EKNkQVtCYvDcJA4fifzxOtwi09fsnODSmIDRUnFozOTFEtJCG3a19h7yiL7K4JVyblkOiD7kJU/ha9FtB9LNaK5Y9yY55XgbhE8rr65jiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=CeQ8gIYe; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="CeQ8gIYe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=FF
	vbzYcgT7IoWAHDYjfEMPVs39LWnzaD4nevpSW3s40=; b=CeQ8gIYe0u7+ZADZIM
	nLykGfzwd3UJmni7ztuk9NPyNjsePDjFlfBufLKbrozAR2Z3XC8Fe1+5DAj9EY9T
	a1uyI6g1TFaiGfaBwNV1HekMg7vlDfrKAXrKoXfHDCDuVJ/qFSecU967ZWCP3yFm
	QakxitCbqcKYTPLBq4I9zE5Bc=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wCn1bKpolVqwVzpIw--.26757S2;
	Tue, 14 Jul 2026 10:44:57 +0800 (CST)
From: weimin xiong <15927021679@163.com>
To: iommu@lists.linux.dev
Cc: robin.murphy@arm.com,
	joro@8bytes.org,
	will@kernel.org,
	xiongweimin <xiongweimin@kylinos.cn>
Subject: [PATCH] iova: fix spelling of reserved in comment
Date: Tue, 14 Jul 2026 10:44:56 +0800
Message-ID: <20260714024457.188474-1-15927021679@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCn1bKpolVqwVzpIw--.26757S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZr1xXrWrWr4xGr15ZrWxCrg_yoW3XFc_Gr
	yvqr1kKr15ur1jvF10qry3ZryY9FZI9rWkXr4rKa1fX348Xws8Ga97ur18Aa47Gr4xGF9I
	yr4Yqr43A3yrJjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8vD73UUUUU==
X-CM-SenderInfo: jprvmjixqsilmxzbiqqrwthudrp/xtbC9AnCS2pVoqnQogAA3y

From: xiongweimin <xiongweimin@kylinos.cn>

Correct "reserver" to "reserved".

Signed-off-by: xiongweimin <xiongweimin@kylinos.cn>
---
 drivers/iommu/iova.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 021daf652..aa5a3f405 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -538,7 +538,7 @@ reserve_iova(struct iova_domain *iovad,
 				break;
 	}
 
-	/* We are here either because this is the first reserver node
+	/* We are here either because this is the first reserved node
 	 * or need to insert remaining non overlap addr range
 	 */
 	iova = __insert_new_range(iovad, pfn_lo, pfn_hi);
-- 
2.43.0


No virus found
		Checked by Hillstone Network AntiVirus

