Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794615266;
	b=ClyHvLvucqA9h3EK3LSTgOcxW9bwThTMNs/nOd6txHu7UoYrfOgFuD1k1jL7bmnn6Fqr
	 H1vFu4yPs1x1d44nvMA/fEw5F06WLPa0UOMnRr0iXr0ZcYB+0lSlTFofGQGf2l7soDlbH
	 P9x4FnE5MuaXpHtwwY0WfH2m5E1/fIKytRZ5EVn0EsUD7rqk5UD2Hp/oJR//H6HQq5u8i
	 WCLnxP38NJlq2z3qh+M//Nahyz7oxjFYlAu6EVvaccT4q0S0SbSl+QCrJUA3Bd7ThH5Pr
	 WHaMFzgE/sYyjoK6DwLh2bYsyVw6Zv5RAlizwuWlsn2SRHt56pyKzvR1J4KFfUAF45A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794615266;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=j5CYEosqkv2ch/UK8kdKVAgVTUdT2Sy6iQ4zy78O0xA=;
	b=yKWyBK4Jkre4kEvkSjsJquMOZMyM7E0O3XFYQZGMvrQDEdCYL840K2lpvxbgOIdvyEVy
	 8xpXHK0/t/PUCa0Kun2VOdALJBtd8oeJSg6x2YHBz8EfPY4Le8tDek94TMvbCM5WOLWPP
	 vbb25DUh7L0fPHFLjIRJclqe4mScJKzkODKb8aZBWTsFEEGf7Ribi6GKtXPlWBlxgYiMt
	 4DoP1gvA6OmbB+MwC1QGwl6CZYrJqEYs6qxxXaV7KCRH1k7k3z0k0uDOWbzavzcP/amrJ
	 ftBBCcL1e1SCa18Sv+3xswzZxpnNcT9uOCmNTHmmQDeH3O4FqvdhA47LHy3pwhNnkzA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="YPKgLLe/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBD4606A889;
	Sat, 14 Nov 2026 00:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YPKgLLe/
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794615266;
	b=amEPHFfKvYgfuleMziJcuwN9SdUrMJX4d6AKlKiD2bpTRyoqiSIF/DpzIDswNwuxTbRe
	 IpgjsHPJ8MlJO94/xgS6mD6YOSGbY2h6rl2af9VpUyUxMwqI0XIOliwYJSwhf4HBc7G1B
	 OjZOLbVpfMWJ5i0EclyKJ6XmuUWK1JC9iXEmWzuLPCcOlgCHdDrYgtxVKEpU3y96XflGF
	 3jzk3fem8bgX0OWLXBqgOgws4cHgkZ2HZx1qxUyMP8wJEMyealFu7gGSuOiFQ4AyoD1SF
	 nt40O5DYe4bSwc1AsTkPh3Jj8nDXXkg+L4taeQ6Iq1TifQJ3omJ70P0XkHHCoeVdjlg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794615266;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=j5CYEosqkv2ch/UK8kdKVAgVTUdT2Sy6iQ4zy78O0xA=;
	b=l4kQieR3JsUl+coDbMQ28/fzLXtBA5VJ8dlNy9FBgIBmRHu5q3+DlPnHhpDuVn68hD5f
	 rd3y/hdwWNdOk0D0o6Ezz39j3jlH5nRuMNFU/agf4loRn2shuQcsrI2IHCk8DQC5f5Y1Q
	 9rL7UjXBpvXje0uy+OS8mU45CSCn1RzceNRJQLeYXuVGlx4psfHXWoMuYtFzBIG6djgr6
	 U/B/tfM41hzh1Vbabw6i0rgm4UjNRHRwucXl+DyfkWpW37Sm7ci2ia1JFy5HeVQj5JjEe
	 Lx/rwsP80xk//IY6PkA1aLiiJEOv1rkA6UTmguadTapi+fQP/6YUazpUM0/tdS9WSqg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id EB6201F00926;
	Sat, 14 Nov 2026 00:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794615266;
	bh=j5CYEosqkv2ch/UK8kdKVAgVTUdT2Sy6iQ4zy78O0xA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=YPKgLLe/27nuO/bCG8kZklt+l4KdcIksNF8a20946A7gbV/EtdEwQqxM2GyThfJPE
	 UR3a7YJR3NrGx5c4+fncf6Hy/10mXriPIdOL0wAGMvrCte8iybs8xX4I9CCJ+EQUCl
	 y0MADu4wtx9AhjDF9N36jtxZ2UmqoH320yfn6nqMWwV3vhG5AKOJe0ixjUuY9z77Ao
	 u0ZQCSeacSQVHMAA1J5oJAWGb6ZntVY0C+jAaUUiswuSPanzeG93wv744iy88f427K
	 bKvY1UqHmgni4Dm2R4P2C4WzZ6znGQa6P0Ve9jRk7//jmGk8GcUv3UrBJ/xgoAwrwZ
	 J96zLWc1sJ44g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 7DC0449BD6;
	Sat, 14 Nov 2026 00:14:25 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Sat, 14 Nov 2026 00:14:27 +0000
Subject: [PATCH 3/3] iommu/vsi: Unprepare the clocks when getting the IRQ
 fails
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
Message-Id: <20261114-iommu-vsi-fixes-v1-3-1fc7728dfd35@gmail.com>
References: <20261114-iommu-vsi-fixes-v1-0-1fc7728dfd35@gmail.com>
In-Reply-To: <20261114-iommu-vsi-fixes-v1-0-1fc7728dfd35@gmail.com>
To: Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794615264; l=877;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=JBjjSQ7lBXTycTG2n7hcuVyoF1r2DyekbYpAYIdEgaQ=;
 b=3kpB/dvSubGhVQl4Bfk+/9p5oeKTAng3VYIHXpcHP7telMScnNimJtDwee2sxd01BWgdGZ624
 8O+0aeHa86ICQFMB5b3v7pi0iFbK2N91Bsb3WV/XHIHfeXkAsZqaEPJ
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

vsi_iommu_probe() returns without clk_bulk_unprepare() when
platform_get_irq() fails.

Fixes: 917ace84b770 ("iommu: Add verisilicon IOMMU driver")
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 drivers/iommu/vsi-iommu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/vsi-iommu.c b/drivers/iommu/vsi-iommu.c
index 8a0f253f2017..579eb1ab5683 100644
--- a/drivers/iommu/vsi-iommu.c
+++ b/drivers/iommu/vsi-iommu.c
@@ -707,8 +707,10 @@ static int vsi_iommu_probe(struct platform_device *pdev)
 		return err;
 
 	iommu->irq = platform_get_irq(pdev, 0);
-	if (iommu->irq < 0)
-		return iommu->irq;
+	if (iommu->irq < 0) {
+		err = iommu->irq;
+		goto err_unprepare_clocks;
+	}
 
 	err = devm_request_irq(iommu->dev, iommu->irq, vsi_iommu_irq,
 			       IRQF_SHARED, dev_name(dev), iommu);

-- 
2.55.0


