Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5060125C6FE;
	Mon, 10 Feb 2025 19:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739216427; cv=none; b=t28nn1ES4zmGu7uW/eelKA2zc8kWw+O+ZFRx964GeGKITbYoipVleKKIf3cwQOg1BaqLaoM7hAPwzbPm6026Vr9P6KRpNan1DILju5KRZVxnEj7tMC3Mmk/4tuewSVK1xUSamydEyr1aaNWHxeg2fMU9M4A2JP0SnJzilnsVTag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739216427; c=relaxed/simple;
	bh=aaTDpX6ibfDGaC/RfCGv1TxYljIk7EiF/i2ba6hh4K4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k1ufKZ6V8zKY60ktYH9xO+EmgEEc0lfuMTmgY9ANwZiJ9nvQ+DmV98eICK+MoXmSnYwlt/3RxQWhhBbkJN940ySTvsjM5cQd6Eg+RI7h7Yw82fx6Sz0tUr6deRw0SKKrWvAIPVGOKf4Y2HShU10yrgM/7jO7L8LMWpuiKtFGhKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io; spf=pass smtp.mailfrom=rosenzweig.io; dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b=Yrdlg6Us; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosenzweig.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b="Yrdlg6Us"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosenzweig.io;
	s=key1; t=1739216423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kz0nyJ7WvRmnQlm0RtDzsCt8ytIfHB7c5nD03lfkpQo=;
	b=Yrdlg6Ustd49sldQRowOZXLEs3setf3ln0voRaH2wpyzcHRMKugrZJJR6cG/nvo7YfRo82
	F2SNQJsefmje6IDldZouEfGy/ZFbQcNfmintFJKrfTWdFWeQEkgprAHvIaawXX3R08LX0d
	myH2eEG2yOT0PdpYfdRP3uMeBRxTdFw7whaQJSTJZw7AisxI/PNMYD/Iv79/Uy3Db7BnHb
	lSh2GprWdYqrFj/+ib4R2B4TEFkQh8uDGYOIl7pAkdNZ6CDIG8VMAij9UeoIeidRQG+I1M
	jCcj+EIblzby3we1eq2bs58/ML1A5CKEdIttLYa+t9mwmIrgzXRWPlkujijycw==
From: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Date: Mon, 10 Feb 2025 14:39:54 -0500
Subject: [PATCH 2/5] iommu/dart: Skip reset for locked DARTs
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250210-locked-dart-v1-2-5d97fe247f35@rosenzweig.io>
References: <20250210-locked-dart-v1-0-5d97fe247f35@rosenzweig.io>
In-Reply-To: <20250210-locked-dart-v1-0-5d97fe247f35@rosenzweig.io>
To: Sven Peter <sven@svenpeter.dev>, Janne Grunau <j@jannau.net>, 
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Hector Martin <marcan@marcan.st>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2327; i=alyssa@rosenzweig.io;
 h=from:subject:message-id; bh=aaTDpX6ibfDGaC/RfCGv1TxYljIk7EiF/i2ba6hh4K4=;
 b=owEBbQKS/ZANAwAIAf7+UFoK9VgNAcsmYgBnqlYZ4XpVKED3AuP44JWAGY5N9sUenu+SB6n/R
 MuO7oEpJq6JAjMEAAEIAB0WIQRDXuCbsK8A0B2q9jj+/lBaCvVYDQUCZ6pWGQAKCRD+/lBaCvVY
 DVZtEACF0ixVnQrS6o/8V7HVns7hmOv7asVpK1AKZstPf+b99/Ojt6HaJkBlZfR5mQXZVpPwF+8
 Cq9lJpfykH/tBMISpG2Uhr6qkBDcDe8AQALK/179b3VCOydowJ2njiRYTUqe7jTaUFs6GrEuI4M
 3/kee6DR+rA7s0SqTE9huwjyAo/tIFQKuQUf2ha1o5LeBQ7Hmkjt0OjW9qCiaTdrk/xawtzCjtp
 K9Ee2y4/Ev90qmvm/0cpj4QcuCvSKehKn930a7biQu83n0mDSdWBXqeigbHDzRxPwhsee+fw8aa
 /LxMi5bw/CmyUf1orROoFQG3NfPQT+5lnO7hu/gPfDXRvbNGlR+tNY3qWosjT10wssd+2sq9lp/
 qCIP2+XYnOA0M5bFNwDKkcTvjm2Uy+AV1MheCb+LXXX35BCKlMPHc7BeeMNhtIBUW0u1UeWpbo7
 6opowGblNJW0OdQY8TidlegtFq5uSyDlXuWYYWYdBElBvpte0CqinXEVwgiGvHDTHXf61aYrXm6
 pTdSCj3YS8/IcDNVRqsEZYUqKhMaBmcrLLBWSKK7RX01BeMdT3rTD7AzkErkiv5pxM1CSyRLcLQ
 qar7Wl3CUPorSW2uVQMzGfSqGKQGjtcHRMkjYIgJaz8vk3jb7oy6Sku6S/awoFpvhLYU4xV+UBt
 2eAYA9IwaIuqDBQ==
X-Developer-Key: i=alyssa@rosenzweig.io; a=openpgp;
 fpr=435EE09BB0AF00D01DAAF638FEFE505A0AF5580D
X-Migadu-Flow: FLOW_OUT

Locked DARTs cannot be reconfigured, therefore the reset/restore
procedure can't work and should not be needed. Skip it, allowing locked
DARTs to probe.

Co-developed-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
---
 drivers/iommu/apple-dart.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index 460cf96bc8001e051916f356d5d175b35e36c608..9c74a95eb7e819e94ab2fb47ed0d411a1eba8bf7 100644
--- a/drivers/iommu/apple-dart.c
+++ b/drivers/iommu/apple-dart.c
@@ -452,17 +452,9 @@ apple_dart_t8110_hw_invalidate_tlb(struct apple_dart_stream_map *stream_map)
 
 static int apple_dart_hw_reset(struct apple_dart *dart)
 {
-	u32 config;
 	struct apple_dart_stream_map stream_map;
 	int i;
 
-	config = readl(dart->regs + dart->hw->lock);
-	if (config & dart->hw->lock_bit) {
-		dev_err(dart->dev, "DART is locked down until reboot: %08x\n",
-			config);
-		return -EINVAL;
-	}
-
 	stream_map.dart = dart;
 	bitmap_zero(stream_map.sidmap, DART_MAX_STREAMS);
 	bitmap_set(stream_map.sidmap, 0, dart->num_streams);
@@ -1151,9 +1143,11 @@ static int apple_dart_probe(struct platform_device *pdev)
 	}
 
 	dart->locked = apple_dart_is_locked(dart);
-	ret = apple_dart_hw_reset(dart);
-	if (ret)
-		goto err_clk_disable;
+	if (!dart->locked) {
+		ret = apple_dart_hw_reset(dart);
+		if (ret)
+			goto err_clk_disable;
+	}
 
 	ret = request_irq(dart->irq, dart->hw->irq_handler, IRQF_SHARED,
 			  "apple-dart fault handler", dart);
@@ -1192,7 +1186,9 @@ static void apple_dart_remove(struct platform_device *pdev)
 {
 	struct apple_dart *dart = platform_get_drvdata(pdev);
 
-	apple_dart_hw_reset(dart);
+	if (!dart->locked)
+		apple_dart_hw_reset(dart);
+
 	free_irq(dart->irq, dart);
 
 	iommu_device_unregister(&dart->iommu);
@@ -1325,6 +1321,10 @@ static __maybe_unused int apple_dart_resume(struct device *dev)
 	unsigned int sid, idx;
 	int ret;
 
+	/* Locked DARTs can't be restored, and they should not need it */
+	if (dart->locked)
+		return 0;
+
 	ret = apple_dart_hw_reset(dart);
 	if (ret) {
 		dev_err(dev, "Failed to reset DART on resume\n");

-- 
2.48.1

