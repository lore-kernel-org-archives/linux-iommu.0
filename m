Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC2F41A50A
	for <iommu@lists.linux.dev>; Wed,  7 Oct 2026 22:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791410746; cv=pass; b=odpzBsLHnijmx9pSo589C8QhXPxMU5v4oS7y9wnO+irG3bVfmRUIvG4KbYpaXgMgaIt5chEsjEqCFjUkIofh2AwuEB0noJqIKGy5IrShuHE+86o/nodtzM/DGzSUmWmsgUcrnVWSQmBxlxB5i5i0HjfiNG+Plv0H/d3TKC9MQzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791410746; c=relaxed/simple;
	bh=ivvlwYiwqsgw81opjHi8KclWqJnCdJinGW9odcbzfWA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Q1JeSBlH9e97KrFwQa7UUG/RPxfUSoglocPbo4KPXJL/4ultfEFXmBibdaknqbPIZe7FVF5MX9XSmPfVzUMumhAWW1QXIcao2UIz/c3IQKTmabkpzhFg+z2fSME4QaXFjGL5M+7yFnrahUXuQY7OaN2YmpYmqWeA3Nc+gKBMx9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b=RV35jyKg; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=VUrXJ8Qc; arc=pass smtp.client-ip=185.56.87.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="RV35jyKg";
	dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b="VUrXJ8Qc"
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-1b4f.prod.antispam.mailspamprotection.com; s=arckey; t=1791410745;
	 b=bOangDFRaEBsbLUo/srh7VbGSdR9ulN1RR1R8v6PGSPUmQEboYoWynvuObaZcmFGHUz1n6g4k4
	  HcxfQrCT/sAN1SIF64A/lErNTe8Dje3B7P7H5Ux/mRROZxTqCk7d3saRGcC0vb1fEb+lYdk9O9
	  NwkPL/wSX7x4PQM/GjngZY4Vxqgj2NFO0hH8YJ4xE1bhTdiO/Tgfh72Fm7hSHCPFUvAgY4OjFq
	  mz3ORnCtzU74k0Uv8vmAxEjaOsgN9FNltJhvnFTaMmY8i9pnnTXH2O6eMhWpx35CkBMzN2qo3a
	  qLUJjYwaD8NTrQWwShUOs6CadLKcypF25U7aYnlMlqPclg==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-1b4f.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-1b4f.prod.antispam.mailspamprotection.com; s=arckey; t=1791410745;
	bh=ivvlwYiwqsgw81opjHi8KclWqJnCdJinGW9odcbzfWA=;
	h=Cc:To:Message-ID:Content-Transfer-Encoding:Content-Type:MIME-Version:
	  Subject:Date:From:DKIM-Signature:DKIM-Signature;
	b=LQFu3mHKJ6KkoW9L7uo71x09EyIwCwVMyEXt3DX+l2PGfwNFHrl6UISdtM0GaUFZH/Ne7HHNbf
	  AvbbrA0k1gCXXbTf7D3M/fjXIQLQqOS0eRSeHWNrz8c7HTd/qewz/Z+bLDzS5J2vCjJp3Sq6Ar
	  Om6vevGZbHb4EJhnvZTQedPTaabJqiKSshn1qFVlMprK2lgSoz6OfmLr1XU0EMVSgeL/SkolQP
	  uV/3v7hxulVR5B7YI1dgv8frNHTkjVjTutdHQfF5VcRG1kDQQABn4sB+ojo+nS5HaUqcM+cH2G
	  5bynGq6DEOXHlPsMKgn70Cy4ryYEOWCJUMSRy5GXPTdUZw==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject
	:Date:From:Reply-To:List-Unsubscribe;
	bh=niAbfulvDzFUUmEPDa0SfhyEtOhhh3DXu9LRtOKqylI=; b=RV35jyKghlYWo057NE24C1aUif
	VVomzmdRbchvDOCgJCnHc/KSm8C0kPt47tCtsCIzQbgaulhYFwjKpXaEGilaLXpmO865DKwE8rQSI
	xIH/vCDscphiTBuxPf4jVnnzU7bjhCQQF+KVPaCv/bKODuwc1uaiQ2lBZB2m2ggQ8Rg4=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-1b4f.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <francesco@valla.it>)
	id 1xEZlZ-0000000BqiG-1GXH
	for iommu@lists.linux.dev;
	Wed, 07 Oct 2026 22:05:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Cc:To:Subject:Date:From:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=niAbfulvDzFUUmEPDa0SfhyEtOhhh3DXu9LRtOKqylI=; b=VUrXJ8QcYHmaMTXenFVcSPsuaV
	barGD2EupIp6iZ4RBW7WnsP9Wkeu4pRFRRCmQ6lCJEkt0akqdJ0Wk0rAqI2ktLt7af/0XukcZNy7+
	SAreIgYkDB9oe6QegDH4PVT61NI3pzA2DBWsD9B2T7jCPefHmcDDsAzHtgs2eomxtW1U=;
Received: from [79.14.200.104] (port=62117 helo=[192.168.1.3])
	by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <francesco@valla.it>)
	id 1xEZlV-000000006zt-1pYZ;
	Wed, 07 Oct 2026 22:05:33 +0000
From: Francesco Valla <francesco@valla.it>
Date: Thu, 08 Oct 2026 00:05:21 +0200
Subject: [PATCH] dma: swiotlb: use KiB in restricted pool allocation log
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-swiotlb-size-print-v1-1-374493b5c5a6@valla.it>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQqDMBBA4avIrB2IA1r0KtKFiWM7pUTJxB8U7
 25sl9/ivQOUg7BCkx0QeBGV0ScUeQbu3fkXo/TJQIaqwpgH6ipj/FpU2RmnID5iXfdkaShL6wh
 SOAUeZPtN2+ffOtsPu3if4DwvVNYnuXYAAAA=
X-Change-ID: 20261007-swiotlb-size-print-99d2b2f55bc2
To: Marek Szyprowski <m.szyprowski@samsung.com>, 
 Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Francesco Valla <francesco@valla.it>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1339; i=francesco@valla.it;
 h=from:subject:message-id; bh=ivvlwYiwqsgw81opjHi8KclWqJnCdJinGW9odcbzfWA=;
 b=owGbwMvMwCX2aH1OUIzHTgbG02pJDFnHDqmvTo4o6mvaojHxfYHcFSftZOEgoRPSM5jURPn3f
 Vvgo+LVUcrCIMbFICumyBKy7sa9PXPNv6VtYHwEM4eVCWQIAxenAEykYSojQ2P9arb++t5zKa+W
 6pXmPXhtaa+Y1qTRwCUYO0tq+te1DYwMj6c5WTkwPyid/eOg8e035VpMx6+sfCrWbKWXIxKl4Vj
 NCQA=
X-Developer-Key: i=francesco@valla.it; a=openpgp;
 fpr=CC70CBC9AA13257C6CCED8669601767CA07CA0EA
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - lists.linux.dev
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: c6116fd659cc7012036515a69c1bb921
X-AntiAbuse: ID - c6116fd659cc7012036515a69c1bb921
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1xEZlZ-0000000BqiG-1GXH-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-1b4f.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

Update the allocation logs for restricted memory pools to use KiBs
instead of MiBs, to avoid truncation when the size of the memory area is
not a multiple of a MiB.

Without this modification, pools smaller than 1MiB are logged as 0MiB.

The same modification has already been performed for coherent memory
pools [1].

Link: https://lore.kernel.org/all/20260629223759.2637162-1-sharaienko@google.com/ [1]
Signed-off-by: Francesco Valla <francesco@valla.it>
---
 kernel/dma/swiotlb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index aa2f1c4588b9..3bfab8142f5b 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -2083,8 +2083,8 @@ static int __init rmem_swiotlb_setup(unsigned long node,
 	    of_get_flat_dt_prop(node, "no-map", NULL))
 		return -EINVAL;
 
-	pr_info("Reserved memory: created restricted DMA pool at %pa, size %ld MiB\n",
-		&rmem->base, (unsigned long)rmem->size / SZ_1M);
+	pr_info("Reserved memory: created restricted DMA pool at %pa, size %llu KiB\n",
+		&rmem->base, (unsigned long long)(rmem->size / SZ_1K));
 	return 0;
 }
 

---
base-commit: 7b63ef2d55f24519e7e9e5f4d15dbea03f126e40
change-id: 20261007-swiotlb-size-print-99d2b2f55bc2

Best regards,
--  
Francesco Valla <francesco@valla.it>

