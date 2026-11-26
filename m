Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795683615;
	b=WfhFFZL9vMsgS6xBNrL+u2QOD2VoKaNoEd4s59NSg3O9DhKm/XNl7uoEUAZYgmpm7cQm
	 F0rT5d4ODcsYsvex1gBeCzD6heKnitQYw432TYbliY5HjSPE6FWG2jjm46O33fXjxwMLc
	 YHPdHpXPcyfF7yxDST2MZtL7qgI4OS1Q86pQXgpZTys79NJl8R2LPGOPQDJy9ACx8ClYi
	 55IFhTyJuf0AqhdOuyGjNaDFrWW6sHnH7owHylbDP3Zy9XnDpJRJbjIJ+hN93Mlgac4qT
	 H8fkjRR2Ll8FUwfCfAGUwsj/2CLhPDS5PNeA7ggecgo13gFZCi4xx1DoybCEZ+FWtlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795683615;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=j5/GxEw4LXMr1EMT5DbhuBZ+aenBqcq5GjMNGTPNTOA=;
	b=hRQrgOtdEP88KqPkX+d99XuBwbM3Q4o1VvJx2zo/XLauio6KJU85HEeo7+08wgn7ojj4
	 cpufMUfCnK2YBOBuUnPWKR63ze78j4lzABbVxljEn7FGubVeAfIzNIq9OYibVz8i6U8Z5
	 nmtQzzFiQm60co1VIgvYlfgqy4OiaFS6WF+Cijv+9QRyZTHmnRFBRFSSZnajTHYlQzzkD
	 j/ppc8NjtgH6Q5NEhTBdnrcNlabXWexX+Mj2MFw81jPafboEzz2+fFaH+7atpYdDP6raR
	 +DrCM8CNFoC+9ocNf37FHJQxmWG8gezbGl1f8OciAllSWAteEh8aNAYMM7yDxiO5HDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=E1f3Frpw;
	arc=none smtp.remote-ip=220.197.31.5
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B17606A326
	for <iommu@lists.linux.dev>; Thu, 26 Nov 2026 09:00:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63B17606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=E1f3Frpw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=j5
	/GxEw4LXMr1EMT5DbhuBZ+aenBqcq5GjMNGTPNTOA=; b=E1f3FrpweoYO0WESdt
	97fDA2CWHjo0lT4PXEpeQxLiZPpgHFvnfkFD7bub7MjjfLhPtpWKyOxjPyWktojx
	7If4V87Sub4scGzeM0xzB05uxaSPV4HSKqgyNS7bRmGTXMyxayaaa3LQqTjozjb7
	7jsK+dHSdkkBqTRSRpXd5bTxo=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgD3v5739AdrPPYgIQ--.2967S2;
	Thu, 26 Nov 2026 16:59:36 +0800 (CST)
From: Wanhui Fu <fuwh1120@163.com>
To: joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	jroedel@suse.de
Cc: iommu@lists.linux.dev,
	Wanhui Fu <fuwh1120@163.com>
Subject: [PATCH] iommu/pamu: Free slab caches in pamu_domain_init()
Date: Thu, 26 Nov 2026 16:59:26 +0800
Message-Id: <20261126085926.3866382-1-fuwh1120@163.com>
X-Mailer: git-send-email 2.25.1
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgD3v5739AdrPPYgIQ--.2967S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XF1xXF48JFWkKw48AF1kZrb_yoWkAFgE9F
	y09ryfXrW5tFW7Cry2kFs3XrWq9ws0yFna9ry8KanxtF1fXwn7Ar4UZ39aqw1fWw1xCF12
	yFy8JFyfAry8ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUb4CGUUUUUU==
X-CM-SenderInfo: xixzxiqrsqqiywtou0bp/xtbC7RgYt2sH9Pg4UwAA3R

iommu_init_mempool() allocates two slab caches. Destroy both
caches on later error paths to avoid leaking resources when
initialization fails.

Fixes: 3ff2dcc05894 ("iommu/pamu: Fix PAMU boot crash")
Signed-off-by: Wanhui Fu <fuwh1120@163.com>
---
 drivers/iommu/fsl_pamu_domain.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
index 9664ef9840d2..683bf005a3a2 100644
--- a/drivers/iommu/fsl_pamu_domain.c
+++ b/drivers/iommu/fsl_pamu_domain.c
@@ -449,12 +449,17 @@ int __init pamu_domain_init(void)
 		return ret;
 
 	ret = iommu_device_sysfs_add(&pamu_iommu, NULL, NULL, "iommu0");
-	if (ret)
+	if (ret) {
+		kmem_cache_destroy(iommu_devinfo_cache);
+		kmem_cache_destroy(fsl_pamu_domain_cache);
 		return ret;
+	}
 
 	ret = iommu_device_register(&pamu_iommu, &fsl_pamu_ops, NULL);
 	if (ret) {
 		iommu_device_sysfs_remove(&pamu_iommu);
+		kmem_cache_destroy(iommu_devinfo_cache);
+		kmem_cache_destroy(fsl_pamu_domain_cache);
 		pr_err("Can't register iommu device\n");
 	}
 
-- 
2.25.1

