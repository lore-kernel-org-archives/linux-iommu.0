Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60432040AF
	for <iommu@lists.linux.dev>; Mon,  2 Dec 2024 14:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733148391; cv=none; b=lBpAx+n6yq6wQ6uTUpnsO3dYTDRd9TAdrF3+9U37aRFWaSTZ+ULHtFgDpFq3TvIpFJ1gpD7qrdi76sn/OFPaL713ka+c1oBBlDlg0Puro35VVZzI33cd5HbVtKRZt3asWtoOxPG0CfVqH5Fmpj1FoAY/9x7Ei7ERXzWFViJum6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733148391; c=relaxed/simple;
	bh=H6HuRlIoB3My5PVxP/KBNeg71dHg7w+qkVYr6BSpMHA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=h8BYeY2D0cGFWuQNKLkci7bOEMS4yzIyC8arrY+VEEm9gGhS7ZZlPcOAhX/p9fY1epK99UWm4uddDcGOH323CcMyvxtZA7pGBUT/+nZe4S6+glPlE6L25Ye14ib7nOk/1+/apfMFEmOGHt8kYEQgqcFAZX10bFjY6+yJ9GmGfw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l+7zvIOl; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l+7zvIOl"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4349f32c9a6so35072525e9.3
        for <iommu@lists.linux.dev>; Mon, 02 Dec 2024 06:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733148388; x=1733753188; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jKxSUej1+l/0VRK8dY/i8qKE5HDYtkSoqmdKS10eGJE=;
        b=l+7zvIOlPJmKuEZDfcUlA5d0FKQ5KvPhujTFkxw0YBKib8N2TNodbhBQCrWUw8kNqG
         aT5GIUB+9UlsJ60EuwSw3twGBCDYX7jIRaM9WC5L3ucf29M8tP9YHFJed3oN9ksBMqgx
         snEm2Be1iFWdqgLjdt3T4n5cfqte8UAEGKVOsJsPL5k5hxaA9Ty93sTR2Ro6+OiVBDvb
         DC80Em3DqP9DVr5H7NL7woKdYy7g8ZgVEdXxHqySm7dA5220Bvw7r1P2hA7ZoCqL2rZe
         WndK64eS7H6mbjzURabBThZJoSZtCb6UCEvyBreoPU8YSpeRQ1kYwN3YaWIPkDvYdY+e
         0CoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733148388; x=1733753188;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jKxSUej1+l/0VRK8dY/i8qKE5HDYtkSoqmdKS10eGJE=;
        b=s/70gVBMeV8UCpEBLn9NPz2mxrj1oQFsLCVmh8FO1zquN+gp75cUs5Emgu4g3jjj3B
         yNPEsihF1DvBdPOwuj7J3dxDFXvprdL1lqTCZ/AY9M+bzhNXQAhaepUntqJimNvEC5Nf
         UEJXYXc0b4l9qSqo6mmHQhL3MlsZW8eytFTUuiCNl23yb/rrjQ2tT8xwxDtV3cMXNKTT
         OKsdu1VoRU+b3sU6t/iMTcGK3Uow0T050pNUNHxHjBWOy+8rNFXX3cFtSjjtMc4+Z5UL
         br0u/1sDNOGDC1TrpVW6Elzc8gL10xDUNfFPB9dMp/cbq2n/405LnlOmG2oxHe15eYrM
         fbcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCKXcr3hgA8O/f8rO2c88JJHgUwtwpFqjwk8BefEgMdNRXJrKA87kh1BZbSDxtOjXzDgP/bQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw4jPdQo8Dl5vIWTUtxzMRRljdq/TDQo3mYxB/KkD5OwwcSVxfA
	L43ljerNkyFjNwz97diUs8F5OvIxxw7YxdUzwU+zgAjSNN092G3JK7QFiUlMRc8FKURrH6AfQuZ
	C1HbVbJsySg==
X-Google-Smtp-Source: AGHT+IGb9GFF+XeRLxQAr2q/gzezFVIRuu1iuJqUMG9tGhoRGftP6XM2BbzyeGE4do1mNb0+j1Ui/wgaLGW65g==
X-Received: from wmqg12.prod.google.com ([2002:a05:600c:4ecc:b0:434:a172:6127])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4f56:b0:434:a90b:94fe with SMTP id 5b1f17b1804b1-434a9dc1401mr242319915e9.10.1733148388003;
 Mon, 02 Dec 2024 06:06:28 -0800 (PST)
Date: Mon,  2 Dec 2024 14:06:04 +0000
In-Reply-To: <20241202140604.422235-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20241202140604.422235-1-smostafa@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241202140604.422235-3-smostafa@google.com>
Subject: [PATCH v2 2/2] iommu/io-pgtable-arm: Add coverage for different OAS
 in selftest
From: Mostafa Saleh <smostafa@google.com>
To: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, 
	Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

Run selftests with different OAS values intead of hardcoding it to 48
bits.

We always keep OAS >= IAS to make the config valid for stage-2.

This can be further improved, if we split IAS/OAS configuration for
stage-1 and stage-2 (to use input sizes compatible with VA_BITS as
SMMUv3 does, or IAS > OAS which is valid for stage-1).

However, that adds more complexity, and the current change improves
coverage and makes it possible to test all concatenation cases.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 drivers/iommu/io-pgtable-arm.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 0055876b3527..62015fdd6c6a 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -1385,15 +1385,14 @@ static int __init arm_lpae_do_selftests(void)
 		SZ_64K | SZ_512M,
 	};
 
-	static const unsigned int ias[] __initconst = {
+	static const unsigned int address_size[] __initconst = {
 		32, 36, 40, 42, 44, 48,
 	};
 
-	int i, j, pass = 0, fail = 0;
+	int i, j, k, pass = 0, fail = 0;
 	struct device dev;
 	struct io_pgtable_cfg cfg = {
 		.tlb = &dummy_tlb_ops,
-		.oas = 48,
 		.coherent_walk = true,
 		.iommu_dev = &dev,
 	};
@@ -1402,15 +1401,19 @@ static int __init arm_lpae_do_selftests(void)
 	set_dev_node(&dev, NUMA_NO_NODE);
 
 	for (i = 0; i < ARRAY_SIZE(pgsize); ++i) {
-		for (j = 0; j < ARRAY_SIZE(ias); ++j) {
-			cfg.pgsize_bitmap = pgsize[i];
-			cfg.ias = ias[j];
-			pr_info("selftest: pgsize_bitmap 0x%08lx, IAS %u\n",
-				pgsize[i], ias[j]);
-			if (arm_lpae_run_tests(&cfg))
-				fail++;
-			else
-				pass++;
+		for (j = 0; j < ARRAY_SIZE(address_size); ++j) {
+			/* Don't use ias > oas as it is not valid for stage-2. */
+			for (k = 0; k <= j; ++k) {
+				cfg.pgsize_bitmap = pgsize[i];
+				cfg.ias = address_size[k];
+				cfg.oas = address_size[j];
+				pr_info("selftest: pgsize_bitmap 0x%08lx, IAS %u OAS %u\n",
+					pgsize[i], cfg.ias, cfg.oas);
+				if (arm_lpae_run_tests(&cfg))
+					fail++;
+				else
+					pass++;
+			}
 		}
 	}
 
-- 
2.47.0.338.g60cca15819-goog

