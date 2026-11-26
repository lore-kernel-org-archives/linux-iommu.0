Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795668731;
	b=b01BB6hOqui3FdRknfzJmEOLKVDnfK75sLLgQDVk+Jqec9+kJ+lQWTZmKJTspe4vY0I7
	 vjcMYNU+he9d3LCQ7xmUoEWwr8HZ2He9iE2ji7CHmDKO7ofhRPdHvRLmwF4NfcuJ1L4Yk
	 Dts+yf5uaz9qbOfN7/TWcgugiPJn6J55SLqRl2lBhSAhcbRnjX65KPWhUqpZvcUJ9o5/+
	 MohBoN1CQmFjfHeSxUUKWGsx8P4FPN3MOmdrsOXu3q7Rj2Y4PIvsvBZjzuFpSPNdghgKI
	 qP3uZKtPaGUb9GiE/e6BxG2GQ+WXo4BAzNfkB0x9HNKgh4NKKsdu/HFF6+aerbC7ksg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795668731;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=S3q8xfPDIBkp3Q9114uqxEU+8XToiBPIWTZl/xj0hLw=;
	b=ut8WRWzdfdvY8dtsNjf4ibKczdOD1fgLCPJKVz4mx7ZrGz0VG5yRghPWMscD/QPbrvW8
	 yq3dN9cy6WODW82hVz4iOYQsJRUhkXXP87ko2aCOcFU8w9hn+wikmZfi8UfS06pXYHa+s
	 PUtP8ahmQPoTGMiicupoSMQk4+hANlmf8i3gveSk2AlVHjTB8w7ecEMGWvMSGHKvLpUzQ
	 bCbkto4cTwY6hlsvWHYDGrCKzTBzUiE3orfs9hzRdgoWxFrpVnmeo4xIg8283aQn060u9
	 hWWozgvuy4GVTOEGltDVc/e1nJLSTeWwXVJS6yZdtn8eLpn+3o1AXVAN2LHCcQiTCUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fyZQ+wH9;
	arc=none smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E232606A31E
	for <iommu@lists.linux.dev>; Thu, 26 Nov 2026 04:52:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E232606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fyZQ+wH9
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2f04e3bf46dso48784645ad.2
        for <iommu@lists.linux.dev>; Wed, 25 Nov 2026 20:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795668731; x=1796273531; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=S3q8xfPDIBkp3Q9114uqxEU+8XToiBPIWTZl/xj0hLw=;
        b=fyZQ+wH9C2x3Cwms0xC8Cu+9uue+IzbH3P/lJvgPEIfaKsiDRs1kw6Qm3IcGvCLRkr
         7MJ8lvWalhc09ZtNggvLEshln5qjTGR2pNiphTUpfo+P1CGHAze06GnTx8grdty6YYBQ
         4NszBy9CKO5M1K5pJmJxfF392d9KbwqS/zkQOWHhmlRKIsXlJSO0Lp+1A6HvP6v05mtk
         kI+SO7a3+pwxiPYEefxONdCkahFwF6zKjgoeH0ZOuKnw6sVHQYpdt6Fqr8xAX4Wh6h9B
         OiOiI3XRkgDtEPIYaToQTSkHPug2n85nu9rpxgdlToup8PgqqGTnbMLKzdIZcyR4ICCF
         RQzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795668731; x=1796273531;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S3q8xfPDIBkp3Q9114uqxEU+8XToiBPIWTZl/xj0hLw=;
        b=eF1cZO2J6yk3PCmPdUwUhKyEWyRJxlMWpEjGd4yAF6/aBY7TEXG7Zq+zRlhgv94FEz
         cxzTzO+OAfqNCiY5fwuzFbLMXohTVC7K2hBoar0K1WCkXsd6VaVWzASxGapCpZyux2nN
         SDB45ecXfdOeqesd3sYvK7qryCoetEEsyBnQoy2ZEPivLayZwfwlqqxQB6BvPLGhAMMq
         9oEwz3/bw+PHHscalaznzuKhyKG2k1uvXr2VR48IfaxlcFSkY9iHR3m37nyKTLnVxWve
         /8IrnmLASgn3Tw9WA820BkjY9VaFxKGQgcUvxIItdb4sIedjcjThqGlpnQWag87UZIhB
         optQ==
X-Forwarded-Encrypted: i=1; AL+hErGmbwLyHR7gpYAggbXUAtIgb0DGst4iZaKXMqAEPpxdaQ8bz8McLv4XhzVgxa47lfeE/29dLg==@lists.linux.dev
X-Gm-Message-State: APuU4Z+XUf87RH/+iabcJ+2t8RtRJEn2GA8Gza/LEh12Zod/jUl+6KPd
	1h1LcwnqGxjiiVyiAK43Ojm2yQ8RORICsyMH+4eIGfK4EbG/aPpk9dxl
X-Gm-Gg: AZFdTZd5+ex3JaA3mU5e0pBUDTeXvQl+SSiPpCJCMegEl2hRP0yCUnH9pZCcAy6RE2k
	h0o2/Jar7HmgYiwKMf60DgVKZEb4cWBYI1aqvEi4IJguCw1zeLlK3aYK6nGTk0Db9xupBEjNXYn
	AEDV29KjopEAZmVT1A/NUkyNI2ikdBQXeFJ6XBvwM6O9RWezgzgVH6UOwv5AzXJnzPQ0BEQhuVV
	AQHtRLlLPxo54fNakhJuL7neKHiHABlbPdcWLoZbQ6LjxZgaQGO3Ygb1HiV9BFLorYI8E8DQxUX
	S+lf8tL7RPYdwQaqjccqEbV63UuNrmSmXPwxtw1S/PJogjL6meE9Swm+0hMk0ViWi1rPUWeThib
	KLGtrzj+P84UlCJ3IMQ+Df9F0l+dj9T0kVOkPWA1zmx33cTSAQrmRXeVyKyA2RbgHfCfSpsnIws
	qDXwF23jDBQ5jLv4jMM1tdeFzasK1WFrIDmqLqhdwcGMermGevFi+79ICIMzwOmFr6GKGRuSkSU
	fqa/IPsRXGxMM2TkVfZjVIiisAZV30+68OLgEBvK7ZyfCWEi7M+JUn5VuyB92Dk19lNQ4m61S3T
	SizrCLMhQAGP+facUP2PS4trRtH3GlOmzv4pYpqwDNNvXExIAnSV17DJF8+kT2PsbsACLyOf/TJ
	kajRTlSWJ8DZRl0OBzLlfqRISKdUQO3Z26WapS0FTPQ==
X-Received: by 2002:a17:902:ce85:b0:2f0:3e44:4761 with SMTP id d9443c01a7336-2f03f25e801mr210179985ad.54.1795668730721;
        Wed, 25 Nov 2026 20:52:10 -0800 (PST)
Received: from LDYT9Q2G2M.pvgl.sap.corp ([2a09:bac5:cad0:1caa::2db:4c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f120830sm96700655ad.61.2026.11.25.20.52.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 Nov 2026 20:52:10 -0800 (PST)
From: Zhiqi Zhang <zhiqizhangg@gmail.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Sam Protsenko <semen.protsenko@linaro.org>,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	Zhiqi Zhang <zhiqizhangg@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] iommu/exynos: Disable runtime PM on registration failure
Date: Thu, 26 Nov 2026 12:52:03 +0800
Message-ID: <20261126045203.62181-1-zhiqizhangg@gmail.com>
X-Mailer: git-send-email 2.54.0
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

exynos_sysmmu_probe() enables runtime PM and then registers the SysMMU
with the IOMMU core. If iommu_device_register() fails, the error path
currently only removes the sysfs entry before returning.

That leaves runtime PM enabled for a device whose probe failed. The same
path can also leave dma_dev pointing at this SysMMU when it was the first
one to initialize the global DMA helper device, so later domain allocation
may use a device that never finished probing.

Add an unwind label for iommu_device_register() failures. Disable runtime
PM there, clear dma_dev if this probe set it, and then remove the sysfs
entry as before.

Found during static probe error-path review with help from OpenAI Codex.
The fix was build-tested with ARCH=arm exynos_defconfig and W=1 using an
arm-linux-gnueabihf GCC cross-compiler.

Fixes: bbc4d205d93f ("iommu/exynos: Fix driver initialization sequence")
Cc: stable@vger.kernel.org # 6.2+
Signed-off-by: Zhiqi Zhang <zhiqizhangg@gmail.com>
---
 drivers/iommu/exynos-iommu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 7c337ba96..18a536008 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -844,10 +844,14 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
 
 	ret = iommu_device_register(&data->iommu, &exynos_iommu_ops, dev);
 	if (ret)
-		goto err_dma_set_mask;
+		goto err_iommu_register;
 
 	return 0;
 
+err_iommu_register:
+	pm_runtime_disable(dev);
+	if (dma_dev == &pdev->dev)
+		dma_dev = NULL;
 err_dma_set_mask:
 	iommu_device_sysfs_remove(&data->iommu);
 	return ret;

base-commit: ebb7a8dc1e74c705daffe11c2faf38ec2628f838
-- 
2.54.0 (Apple Git-157)

