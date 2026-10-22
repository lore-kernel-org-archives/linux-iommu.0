Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792686836;
	b=K9jQ+8T1vey1o1USN7oEcXrxVRsGVXAZWjfnAm059WyG1QAax9epcCFB/JmSOTcAH6QJ
	 JgHa2cdWWrTiaCDyDdlR1L8jlbhqkwxdn764UxCcHSYcEi3nztNHt/oskgYd13zd7nG/b
	 CAxkZqO+17XawVDpiRfz/KCK3uYS4NGJSnkIiWiQXIWEmXhYgviwyBE/ptSE4VaDLe9go
	 JOM6Z5TRhGYGN6YPLKpFIhohPiI76QY0gbMEW51uAZAIMG853VtlqkRXfDQA0gnTE4n1M
	 oQAY98hwB8qKcwHjjnyLEFmb/2ILAiHU+cAlDGLZIczIc3+YFFSg+WHwK8wrXvUB4Lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792686836;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=68+IeagKgDrW1nl1tCiiDqs5Zxn2UgVcp46ojvUcCbA=;
	b=WHBD+DJwAl5s4Z8sJHKilo+g77m8DpE2ps8UmiuI65j5FPoIu/m2fIj8mtcCV68PjiXa
	 wbewhsaHFT1W3tYkiWFLrC+EoU/KJ54T1Q7oSqp1RqGMkiJHZVy5lxUWZWmfJSsTPylRR
	 MDtgBDuqeOWV/65V9JOxVSmg+JI1S9Jo+DJTMr3lKnECLnee4kR8Q3D+/QBsgF3y1y1Op
	 IXzDO3SUFBFe2IQo8vU34e9ZyAZ6uonor8tnbFkKmPgVuuZhtOK7nhMRLh2oCbCAHbz9d
	 53rn56cOwNkQRw5COoiT4vk8aRLBBapQDjk84EYLTplgSxvpyJYsTYFOPMBubhs556Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qaiM1DEa;
	arc=none smtp.remote-ip=209.85.219.42
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4EC606A31E
	for <iommu@lists.linux.dev>; Thu, 22 Oct 2026 16:33:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D4EC606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qaiM1DEa
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-91b834592afso937816d6.0
        for <iommu@lists.linux.dev>; Thu, 22 Oct 2026 09:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792686835; x=1793291635; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=68+IeagKgDrW1nl1tCiiDqs5Zxn2UgVcp46ojvUcCbA=;
        b=qaiM1DEaOhw0u3fobOoWvg8EPzfHlUGr51vRoJEPQaw0UUPDIHEtiEtPwjnj22GGox
         Sn2vBwzlYP934LnUVZ+BJmui967tZ9Cuuj7VoWkKeGcXp13Qw+UEywTmOtNPLNeYDvSN
         AHGiIXllQu9D7p2g02P3FPb0WDE9+er7p8oAukHQzEHvBsTwnkvwV0dCgdUpXDUKtDKJ
         1vT7iEp7dsuENhQQiR81dwNUElgaFMarArRbIFIKZ79G6wsKdU5NtWmd3Lo8mdK/GPUL
         TSKelGQrag+7Twqan5p4FQPl8Kj4rsUWzk4co77BWK5gM421uZ3HCcnLSr++D/3pbdpW
         ckNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792686835; x=1793291635;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=68+IeagKgDrW1nl1tCiiDqs5Zxn2UgVcp46ojvUcCbA=;
        b=fr1nicSI6y2EGGU2rFTPF+iS8afqMxKyPvJ/yLlm8owX4R039/O2mIQwUVz3O1WXcW
         P43rGaBJPLmvz+TVuJ4kXLtZYJeMO+c6oKWLfWMAasoCaguqtym/m9kdv/UKVxbj0Vj4
         QK5I7lWYHEaLw7RhzKbcb8HipVo57JpQtOaV5Kbc0Wum5bdXYlusOlX/s85x8fbWN8Pc
         SX+x3gqnFaH/eHfOF//fxsiSTh8CaoVK6fvIWeTKtqMklsJpN/dlfy10pKs3rLftmnTF
         jtJL7coqqC3HO/uI0vVPzp0okd8EWPXxJGybUp7STOL+8YS5iPivqTCujzku4QZJKKp9
         Xn/A==
X-Forwarded-Encrypted: i=1; AKwUvBySFfG78C5sGAiYh9Vcl+tybjB/AQ9ffuNuHcV5r3a3q1/RLMJnsuN5GOiTUDcIWbGkd1xv2A==@lists.linux.dev
X-Gm-Message-State: AFq9FYJFYJ/KN8bCkc6QYiqi81Oh4GpLhaAckvkkUe2cnfBKCyZAKJMU
	DfCMZRdoHOrtL/54BMGGHu7GcMclrmy5hBj9mYAhPbrZS59Z47CGiwaf
X-Gm-Gg: AYBFou16CRrLffkagwwqLXJY4++U7riv48BopLYZVMj80kryR8YD5xeazx3tpsAmBur
	Aot0s2+ZHpD2klvTMOiNMM/YUQ8Qt7K46DDkxWAKex5jflXBpiXhY1I6msDFzMDN6y+xQk+udGK
	zGVZYOmjz2PZPmnrwS7eCv1+LugTpASq67Hq16pioS379fiw4WXd7ewsa8FBZJcagVG9xaZALhR
	kxA8Af508TJ0qDFYUTM3/aHwL/f5GPBsv264OW1bDXsvmoB3NfGYpmTPP5VczZtWliNWLV1AJfx
	7CCQ3C+Z1Rh5sIQoqVpiM1zpjt1H7cIa4xreaSRde3nFRVe2OtobsMK7ziszeX32kejlnlA1Sy/
	lu+lRH4mWotXWni1s5fb+zho8g4uPqpVgMpjA/9gUUc3boOZ38guj5IyQY0Ttg7kN3MFTczrguF
	uBGuHzk+tXhEwO7j8IgqKDiqvLfEuMYLQ9huZGrxPNKJqCjfl2o6IDm9JlyXVfvOg9e3GTCdsbg
	e/+dNCPz8fa3v9dyJFkfRQPfhRJNin5XRLaW09EhWtfZYldqSJAu3Q9uip5PsPjih7LdKuc7IJO
	an8xEPQQFVY+gJ1J5Lhf2LrO
X-Received: by 2002:a05:6214:2026:b0:91b:5d3a:4fcc with SMTP id 6a1803df08f44-91c12f57cd8mr99901036d6.57.1792686834990;
        Thu, 22 Oct 2026 09:33:54 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c36f0abedsm1511396d6.3.2026.10.22.09.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 09:33:54 -0700 (PDT)
From: Yuho Choi <oss.patchbox@gmail.com>
To: Sven Peter <sven@kernel.org>,
	Janne Grunau <j@jannau.net>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Neal Gompa <neal@gompa.dev>,
	Robin Murphy <robin.murphy@arm.com>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Yuho Choi <oss.patchbox@gmail.com>
Subject: [PATCH v1] iommu/apple-dart: Report TLB flush failures from iotlb_sync_map
Date: Thu, 22 Oct 2026 12:33:40 -0400
Message-ID: <20261022163350.23743-2-oss.patchbox@gmail.com>
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

apple_dart_iotlb_sync_map() flushes the TLBs of every DART the domain
is attached to after a new mapping has been written. The
invalidate_tlb() callbacks return -ETIMEDOUT when the busy bit does not
clear in time, but apple_dart_domain_flush_tlb() drops the result and
the callback always returns 0, so iommu_map() reports success although
the flush did not complete.

Since commit fa4c4507099f ("iommu: Allow .iotlb_sync_map to fail and
handle s390's -ENOMEM return"), iommu_map() unmaps the range and fails
when .iotlb_sync_map() returns an error. Return the error from
apple_dart_domain_flush_tlb(), after still flushing every DART of the
domain.

Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
The unmap path is not changed, as .iotlb_sync() and
.flush_iotlb_all() cannot report a failure.

 drivers/iommu/apple-dart.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index b160fb464c5f..1119769f9f51 100644
--- a/drivers/iommu/apple-dart.c
+++ b/drivers/iommu/apple-dart.c
@@ -494,9 +494,9 @@ static int apple_dart_hw_reset(struct apple_dart *dart)
 	return dart->hw->invalidate_tlb(&stream_map);
 }
 
-static void apple_dart_domain_flush_tlb(struct apple_dart_domain *domain)
+static int apple_dart_domain_flush_tlb(struct apple_dart_domain *domain)
 {
-	int i, j;
+	int i, j, ret = 0;
 	struct apple_dart_atomic_stream_map *domain_stream_map;
 	struct apple_dart_stream_map stream_map;
 
@@ -506,8 +506,11 @@ static void apple_dart_domain_flush_tlb(struct apple_dart_domain *domain)
 		for (j = 0; j < BITS_TO_LONGS(stream_map.dart->num_streams); j++)
 			stream_map.sidmap[j] = atomic_long_read(&domain_stream_map->sidmap[j]);
 
-		stream_map.dart->hw->invalidate_tlb(&stream_map);
+		/* Flush every DART even if one of them fails. */
+		ret = stream_map.dart->hw->invalidate_tlb(&stream_map) ?: ret;
 	}
+
+	return ret;
 }
 
 static void apple_dart_flush_iotlb_all(struct iommu_domain *domain)
@@ -524,8 +527,7 @@ static void apple_dart_iotlb_sync(struct iommu_domain *domain,
 static int apple_dart_iotlb_sync_map(struct iommu_domain *domain,
 				     unsigned long iova, size_t size)
 {
-	apple_dart_domain_flush_tlb(to_dart_domain(domain));
-	return 0;
+	return apple_dart_domain_flush_tlb(to_dart_domain(domain));
 }
 
 static phys_addr_t apple_dart_iova_to_phys(struct iommu_domain *domain,

base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
-- 
2.43.0

