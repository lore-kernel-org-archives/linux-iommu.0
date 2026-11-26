Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795686684;
	b=J2Ll/MpX1eefuDkQtjw+lhyZ5dzPwW6IN415chqWAp+/aiK9vyz5Fui/CiA8vppshxI9
	 jPfOAzr3cuBBH+UV1Q/U842MRZky9PPF0MZG86jsbedRSFJX4VjHabfyjqb3d6dKmJMtM
	 I35DDBvkeYmdylK7IzeTxJjlLAdJhTSS++VRH3+e7d1Nl3IoWAdwIThZDC5+cvk8DlJ23
	 bxlEBqCdGJl0ZZdggoJm3yMovUzIJWnEfgIHILFga5cQpgaAwuqdqqa9/4ud0/nQyhf29
	 uw1bfFexLL/EfpwUuralYAEDC18x4MKqZqt595+AIHy9yZpc8bGvFUZXezBeb1k6+FA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795686684;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=loGdG7k3HsVWjiFfNEbmH1Wo9zdgrVJOqvhHQZ2Sffw=;
	b=cY34KfH6cUr579x1flLRqtDZXLzCUiU1myj0KqweZPKrxHZoP0mQV3YaSB8AU+bFpHSG
	 0wqEy9jW++yMtz8lSAvPkkKnRgx4oTRaQnJQN4HaVvSI+HkK1Nx2ZXHTxI6qBZ+xbVia6
	 ZpskXi0ahfU5yKuqJUh4o4sp3X96Ogq6x/8rZka3vmcfe1c9S8SOPijSDTPcqK5EoGeEH
	 744ql6/IAIyfXFJIED1AzhB9V6R52dJzT8nDQQhaEOpCTdf1K5ScjoJb8KkKGmV02wrWM
	 fOUg0cFGQS0VWmc1aww7SZk49wB5k+cLQ3sRz9s24NltzmSuuWfh2mGTCPdKj3qyodg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=jrpGiXmL;
	arc=none smtp.remote-ip=220.197.31.5
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E692606A31C
	for <iommu@lists.linux.dev>; Thu, 26 Nov 2026 09:51:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E692606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=jrpGiXmL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=lo
	GdG7k3HsVWjiFfNEbmH1Wo9zdgrVJOqvhHQZ2Sffw=; b=jrpGiXmLYiPa/nQDVV
	o7CaMjfSHXHMkly+1Fh/OaimHjrzXwEP1W+qtvnaobw1vRwBNUkcZoFeSSbVea0k
	aNsyxc2T56U8bVYJnJCWIJg0k54irPmROtDEmxOBEzsawnzbKtck8ndzB/4XODeb
	lruGkJOkqUE23v6WQ4k+kNlYQ=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3t0yzAAhrwTy3LA--.34638S2;
	Thu, 26 Nov 2026 17:49:41 +0800 (CST)
From: Wanhui Fu <fuwh1120@163.com>
To: joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	timur@tabi.org,
	alex@shazbot.org,
	Varun.Sethi@freescale.com
Cc: iommu@lists.linux.dev,
	Wanhui Fu <fuwh1120@163.com>
Subject: [PATCH] iommu/fsl: Unwind pamu_domain_init if registration fails
Date: Thu, 26 Nov 2026 17:49:38 +0800
Message-Id: <20261126094938.3900503-1-fuwh1120@163.com>
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
X-CM-TRANSID:_____wD3t0yzAAhrwTy3LA--.34638S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tFWrGr4fur4kJw4UXr1kXwb_yoW8uF1kpF
	W7JF9IkrWUJ3WFyF45A3yDZFyrK3yqva4Ikay5Gwsa9rnFvryDKr1rXFyruw1kurWDAF43
	A3Z3Xr129F15KFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UbiSdUUUUU=
X-CM-SenderInfo: xixzxiqrsqqiywtou0bp/xtbC7RUKqWsIALWVegAA3i

In fsl_pamu_init(), if platform_device_add() fails, the resources
allocated by pamu_domain_init() are not released. Add a helper
pamu_domain_exit() to do the cleanup and call it if platform_device_add()
fails.

Fixes: 695093e38c3e ("iommu/fsl: Freescale PAMU driver and iommu implementation.")
Signed-off-by: Wanhui Fu <fuwh1120@163.com>
---
 drivers/iommu/fsl_pamu.c        | 5 ++++-
 drivers/iommu/fsl_pamu.h        | 1 +
 drivers/iommu/fsl_pamu_domain.c | 8 ++++++++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/fsl_pamu.c b/drivers/iommu/fsl_pamu.c
index c83bbc3faad5..55c666efe8ff 100644
--- a/drivers/iommu/fsl_pamu.c
+++ b/drivers/iommu/fsl_pamu.c
@@ -979,7 +979,7 @@ static __init int fsl_pamu_init(void)
 
 	ret = pamu_domain_init();
 	if (ret)
-		goto error_device_add;
+		goto error_domain_init;
 
 	ret = platform_device_add(pdev);
 	if (ret) {
@@ -990,6 +990,9 @@ static __init int fsl_pamu_init(void)
 	return 0;
 
 error_device_add:
+	pamu_domain_exit();
+
+error_domain_init:
 	platform_device_put(pdev);
 
 error_device_alloc:
diff --git a/drivers/iommu/fsl_pamu.h b/drivers/iommu/fsl_pamu.h
index 36df7975ff64..5c430d33e955 100644
--- a/drivers/iommu/fsl_pamu.h
+++ b/drivers/iommu/fsl_pamu.h
@@ -381,6 +381,7 @@ struct ome {
 
 /* Function prototypes */
 int pamu_domain_init(void);
+void pamu_domain_exit(void);
 int pamu_enable_liodn(int liodn);
 int pamu_disable_liodn(int liodn);
 int pamu_config_ppaace(int liodn, u32 omi, uint32_t stashid, int prot);
diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
index 9664ef9840d2..498c29a255a0 100644
--- a/drivers/iommu/fsl_pamu_domain.c
+++ b/drivers/iommu/fsl_pamu_domain.c
@@ -460,3 +460,11 @@ int __init pamu_domain_init(void)
 
 	return ret;
 }
+
+void pamu_domain_exit(void)
+{
+	iommu_device_unregister(&pamu_iommu);
+	iommu_device_sysfs_remove(&pamu_iommu);
+	kmem_cache_destroy(iommu_devinfo_cache);
+	kmem_cache_destroy(fsl_pamu_domain_cache);
+}
-- 
2.25.1

