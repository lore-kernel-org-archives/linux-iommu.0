Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794744341;
	b=lhMd6wlqF/V6fz54IuWRPAj93TYF+K16ciCIARj4dxRiiCl36S1+3q6yjQWLbCUDnbKY
	 bFALUjOmtc/Oe5AFtj6tJJXmW8FvG81PDQ2rMOQBMV4Wkg1riIvsgOVU/O6AtksrVQVV7
	 d5uCKvk4CvYnBDfJQdoYbteyqrzIRk3VnooLKBWA/MdW1b6rc+hXjeaDarnyzq7oKvn7g
	 Es9TtOfbgLLLwqUGYs6wYe8yu2kw8MilRhL63PfMfSh13wxZn/FaCTpOAtCi2M7owkySz
	 ygC83g3P6OGtu44zHJxq3Gh9mP4kKqoTMKPTFRI1lds0cj+7jdhPN09pqsoQxY/IVAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794744341;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=iw87GGpgaygCtKpkHMjCxhTw+ezQn2b21tLr5BV9P8U=;
	b=g+JLDonj8LWI5UZZsY62bGfof+ScecPr7t8DR4qrppaNcjUONtL0RmX8e6Rl7N1Q376P
	 sUtCgg3GGlsLPxIZhFd6DHAkWe4GyZX7JX8qqyzfqwoDc6S2E91DUkEilPfdU36ZAANqU
	 KS5QVhaxMlPGUBVDgIMJUPADRzoxlT0zuzX9OZq1sT/SgtgouERWO75ufYG6pygnEMAKf
	 I8MhV4I5Xr7eWY/G9NaUVos8H7qNKLKOa2FCSXik0eKjDsQP7J79Uf3N+NJG31a0OZQWW
	 NCXsMOsCg44raV5oAe85+LX/GOiQH833Uigcav3uID2pHSWehsVKmTYT6ckk+UCrOAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eH+4pvnd;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3849606A31D
	for <iommu@lists.linux.dev>; Sun, 15 Nov 2026 12:05:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3849606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eH+4pvnd
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-498f5fa5103so998443f8f.2
        for <iommu@lists.linux.dev>; Sun, 15 Nov 2026 04:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794744339; x=1795349139; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iw87GGpgaygCtKpkHMjCxhTw+ezQn2b21tLr5BV9P8U=;
        b=eH+4pvnd7ht2h99jCAIBjOR4CRGrBbI2M/Qa1CmCuBV766MSL1NNb0DKeTFRY1ihjg
         mul8JdKtX99Kny4aJndYBHZwFJFOY0W4A+Tiz8z5unFVHM3Xsp9722LQRMSifWlgNMP7
         ktnnn0ssj3beCLucOgNFelqTMJIdtZvuTRQGOIJrVYOrs0QmXaq/01tMIppJJmVamAaj
         n1rYBSW+z5ylj5aLUv7bP1ZGlI5w8p6J+WcbMtOvMRd0DdEwzQlHh66a+ZKtQRixY7s2
         bkf/wByLXLH5avmi552cTNZ0ygLE+/lQjtctI8+sIKaXkGuBVk1yfKaQJQAofDBjUKRJ
         SfrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794744339; x=1795349139;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iw87GGpgaygCtKpkHMjCxhTw+ezQn2b21tLr5BV9P8U=;
        b=URs0F7aOBG7XNJ4QdsTjOIxXj63McE3IAmkfh+0bWvlLcmHGrZoSPOhn2q8WIQW0ek
         +GF4gi2RxgBbeppe/Y4x3bPnHprpYYBYCCFgL+4LTpQHpM4gIanMFi1bgnPt5dgjC70E
         WkqQ2LEsYjyB7FUejRA29avEJkUIzUYg/Ro14W+LloI2ImZi2vQG8Z163wbGIvzfNEXR
         9CX8yHMbPngg5HKv/uVfuEpypFX1TeZTAqHfrVESivBrsG8yvOz3iz7KLmiyz+Ye9P27
         XYq8MCB4v32dceZM9YimZSnxsSj88oz7zbN4JC6tWtlBGFcRuVIpexh2kR4IxK9yHAWg
         N5yg==
X-Forwarded-Encrypted: i=1; AL+hErEkMyp6152vzawZOkHuVM/UUDrikucxWF2sVbVJBsigZkWOsggC0ijMfM2vlzguPkiSfRS5DA==@lists.linux.dev
X-Gm-Message-State: APuU4Z+6BBiyVQ72gmpfrMGZu0+cb0vYCZkCv2ROab8SdLNhhptaJF4N
	Aj1vGQGf5aIeFFI7D7KJcCUhxIecrFRNQpNbQub6Kcbx+iVTHos0HGot
X-Gm-Gg: AYBFou2r7muKGqDib4grdR9APN9QEgLyHTpyr1RpTEE50ut8eESuXMQ/hVxZC2vjJJM
	3smqiLgFPUxt9tWqVmjgbo1E3vQzFCe7vz8nEKQ7nHf6PT3796Kx+/wJBWFvlwV0rRtc1Q27tsQ
	MVZG7jpw0gi+H+vvgIK1yxN4uNX3zBkU/nBrSzQIy2P5WBbU9cHQEv9eJXiIAhZ4kQGGLL9QRXb
	ZnZNAOFO9liNAQDzCItX4a4rhYv+VmXO3I50N3aPAh5fUfW0RTLiybRp2RxDn4hrrhZxVTcTVmi
	05PrBfnagQsUxCFnVRH1iRx8nMAQYxijsUSf/sLBNPTXdpCX6l24r54gIn/Mxg2LKT4ikXCuqYB
	wkOlwwpil9BBF3spxrRwxQEqCx65YGQY83ssQixBFgzLX0jSHfIjTWldiAvsrw43TDEZycMRoC3
	rw3GiJ0gK55DwbWU+yaBdCs1rhFYad82CclYoxC3erdidzSFPWck7TXtjsVCwOFXhip5ozLV6Si
	I+K39s0armt1RZshbi2KbvHUrfzsS7xyy3MyWr1QMyZLIIV3XwYPf+UJzKCHDUXYBWVDySKN/ye
	JbQ7m1o0suYtFSMXvtyNJNKnRC/k1esnawNBZ00z+CIb0s4ylqcDaWzgdFORpYLEeEY=
X-Received: by 2002:a05:6000:3c6:b0:491:ef47:72d7 with SMTP id ffacd0b85a97d-49c712ac8e1mr15120353f8f.12.1794744339076;
        Sun, 15 Nov 2026 04:05:39 -0800 (PST)
Received: from localhost.localdomain ([2a06:c701:474b:1700:da41:1869:5f63:edb1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c603f4e2esm16258788f8f.36.2026.11.15.04.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 04:05:38 -0800 (PST)
From: Avi Weiss <thnkslprpt@gmail.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Avi Weiss <thnkslprpt@gmail.com>
Subject: [PATCH] dma-contiguous: reserve NUMA CMA areas after default reservation failure
Date: Sun, 15 Nov 2026 14:05:35 +0200
Message-ID: <20261115120534.2331911-2-thnkslprpt@gmail.com>
X-Mailer: git-send-email 2.43.0
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

dma_contiguous_reserve() returns when reserving the default CMA area
fails, skipping independently configured NUMA CMA areas that might
still be reservable.

Register the default area only when its reservation succeeds, then
continue with NUMA CMA reservation even if the default area fails.

Fixes: 7e6ace2535d0 ("dma-contiguous: add kconfig option to setup numa cma area if not configured explicitly")
Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
---
 kernel/dma/contiguous.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 90937dc7c627..0b6500bb6cd9 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -287,8 +287,6 @@ void __init dma_contiguous_reserve(phys_addr_t limit)
 						  selected_limit,
 						  &dma_contiguous_default_area,
 						  fixed);
-		if (ret)
-			return;
 
 		/*
 		 * We need to insert the new area in our list to avoid
@@ -305,9 +303,11 @@ void __init dma_contiguous_reserve(phys_addr_t limit)
 		 * but we also need to insert it in our list to avoid
 		 * having a default area but an empty list.
 		 */
-		ret = dma_contiguous_insert_area(dma_contiguous_default_area);
-		if (ret)
-			pr_warn("Couldn't queue default CMA region for heap creation.");
+		if (!ret) {
+			ret = dma_contiguous_insert_area(dma_contiguous_default_area);
+			if (ret)
+				pr_warn("Couldn't queue default CMA region for heap creation.");
+		}
 	}
 
 	dma_numa_cma_reserve();

base-commit: 97d73c8251226cf27cc6656b4c542869bb8c69fa
-- 
2.43.0

