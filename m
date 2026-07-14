Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E7D37B01E
	for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 02:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783997149; cv=none; b=fBWofHCv2akN8oKwRNHySsVTkubB9s7HVkknJIraz/FB4DE53u3Y/1dsAHTVi/Elj5rUex3eg/8KJlYp4mm2IxDgXD7ov3U3GB9TQe9PMK5RhKdlImjWW5Fbsk3yMgX5Stl7yyYUIw9SZywEQxhkhSMBzZcpFT7TU4QUIZAGLdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783997149; c=relaxed/simple;
	bh=jCMm561HNLnOFtnsHYTO5HdoLb55iO4+8ip324scojs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ne5OGTDpOrJIOnKWUTK/yUo40+3WRCeTsi7McVv961PROoKvgZzeURwW2lVQEsbU6H7ft2/VG9SBkLvN1nVkzY1X6dHarUkNPQdvicxChBafxd9V2Hp4drGfh2h74ZR8TkaesHXG3V2WzyBDo402molzDgWw+fweMh8aK6Ov0UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=kPycrThS; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="kPycrThS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=RM
	QXnFeO5BMpwcl0jMYZT6qAkgOxYonmNUcoDCtOyA8=; b=kPycrThSJcoDXjRPEa
	LedGeX52oznxE6nB5ExRoHdLkLkA/0b0FlgovVaxwMIfGtIVjDme3SLoqqILkZFs
	EnLZ/iF8/p+hFF2JSw+KOrx9n28AASJamEPGgQKPhrp0DrBbqM7wodi12DynmYLX
	XhJKtRe5mE5N5ZPB6qVxWOqNU=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wCnI12_olVqESc_IQ--.47824S2;
	Tue, 14 Jul 2026 10:45:22 +0800 (CST)
From: weimin xiong <15927021679@163.com>
To: iommu@lists.linux.dev
Cc: yong.wu@mediatek.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	linux-mediatek@lists.infradead.org,
	xiongweimin <xiongweimin@kylinos.cn>
Subject: [PATCH] iommu/mtk: fix spelling of correspondence in comment
Date: Tue, 14 Jul 2026 10:45:19 +0800
Message-ID: <20260714024519.188603-1-15927021679@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCnI12_olVqESc_IQ--.47824S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtrWkJF4xGr1fJw1DJr4fKrg_yoWfGFc_Gw
	18X34kJr1jyF4akFn7KF1S9rWYkw1q9Fs3Cr95Kr45XwsrXr1UWFWvvrWUAa1DuF47AF98
	tr1Fk3W3ArW3KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8NAw3UUUUU==
X-CM-SenderInfo: jprvmjixqsilmxzbiqqrwthudrp/xtbC8wLIUWpVosLCVAAA3h

From: xiongweimin <xiongweimin@kylinos.cn>

Correct "correspondance" to "correspondence".

Signed-off-by: xiongweimin <xiongweimin@kylinos.cn>
---
 drivers/iommu/mtk_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 2be990c10..b52e16b06 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -220,7 +220,7 @@ struct mtk_iommu_plat_data {
 		unsigned int	iova_region_nr;
 		const struct mtk_iommu_iova_region	*iova_region;
 		/*
-		 * Indicate the correspondance between larbs, ports and regions.
+		 * Indicate the correspondence between larbs, ports and regions.
 		 *
 		 * The index is the same as iova_region and larb port numbers are
 		 * described as bit positions.
-- 
2.43.0


No virus found
		Checked by Hillstone Network AntiVirus

