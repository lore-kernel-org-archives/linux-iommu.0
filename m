Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793880777;
	b=drDnIjIhnBjmu5JxgZ0hUzgE2ewQDTw8S/YMDGOX9LatFW9zuUuhekpMZ7vQzNOgNH4z
	 LmT62FjDD3QkCfpXeDX5iNK/LYjDaA7BUzv4t6gRo+ifxrD3U39tu7jgMgbu9MvC9Zq3d
	 Cr/2FJT31l5uUU9iKXM53nHvGrWPBh/JSRoCxJ19SA6dktYk/HywOGEhHcRIh5GYrGs0l
	 03GhBIm9CxcGfemUXA63dk5bpcdE29odSk9BSHvIX057MWXRKdSPQbjoWvYghs9W1wmXl
	 Zx5VoROwHSpo//TQmtW+DW/yxHrncR1C7cjrIUP2vVe9MVkBDzLYEKkfIQHUFGkB1Jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793880777;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=q1/unUnFUI+RMJoEtRyXiSsukSzB8ZtOlFEjmFIV99Y=;
	b=XO/9BLwhi0tbkwzrcayubTzScuZCeJjRhRyhAwGmYL8Jd3KPrbUd9r0f2RCkHVkGSbPe
	 BssgioGxdY57IKEGh6KfaVXvxFVbR28k+E8kT+A2KpR3mdYyYVwgJ2Ix9KQNhKxKH+8vn
	 0Saxd8Qb3T/OxAUobsgmK+PVmn5e9S//ypdH1a/CM6ejIdL5wpA+pppK7zD6LjGb1Ysfv
	 ++kvPelxDQGBgFG3Cq/FkUx94H6kOxmGK3SrlAfHt9gvMQlH384PBjHHYJJcIBW+38M5I
	 t+rgmv9TgBPjgNvgYcpuSqhG70YaqMZ7ejVF4T4E5HVXgqYa0QfXEOp9MnO29HskzJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IvCWBvJQ;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85ACB606D806
	for <iommu@lists.linux.dev>; Thu,  5 Nov 2026 12:12:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85ACB606D806
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IvCWBvJQ
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-36a1947498bso5045872eec.1
        for <iommu@lists.linux.dev>; Thu, 05 Nov 2026 04:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793880777; x=1794485577; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q1/unUnFUI+RMJoEtRyXiSsukSzB8ZtOlFEjmFIV99Y=;
        b=IvCWBvJQ4rRMCDperL6HeM1wtVAJWcVNJmkT9E3PCTunCuHRqOtfsNNvoVCW7U8fdk
         ZWvbbqaXFNKBPDW/7nTriMtSaRlx5uDGz/5YzqRj5PZ9CF9il7Gj0yq4z3Ka1JcxNZiz
         q+rI0wpZBG/HiU9/OHwZ2Be1oNbPkIC3y+Sq/CyFdSHiKqlXxUAT+n845iUB1OlYQG/d
         +mPoylBkSxml5JbZS71ShTZWzpKkzX/anD5xZ9rebR1DTw9fFUwrzN0wiP5F0fbxzmRl
         4upSb6nAdOwNltM8/CnubNnFaLq5aistM0e78CkqSMUPzPmdFhd4F7GotL2YF2IwkdUg
         dotA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793880777; x=1794485577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=q1/unUnFUI+RMJoEtRyXiSsukSzB8ZtOlFEjmFIV99Y=;
        b=OT3R4SNiF7fC/Q/PbVpIS6UMcGL82su6zRlqPdYaUd1BSL+Lj1bCqHa1eG9STHC8rx
         efnVXrkhnYyzOTnZBBjb6kQHOrGg9Idho5QivTzIV1jYaZIyDEFbMPRshjEpq6B89KOE
         TxYECO6ss3gZwuqaqDI0zquBqpL/lKxRSqKs6TrPSvVUlRhjK/89bPgA38mafPvjihn5
         WcaAZFFIbA+ro6gyNReU6mnkb6kcjdYfLsjz4xvtQtqw8O0m7OowN4U9YnY8cQ3qpB+9
         x7eKynSpvPS/DpSZ0jhGp3bIYg7e5Q6l0oFR9lw7TTqP4T9zAtpNIpOymaMNW4wLP7++
         XgPA==
X-Forwarded-Encrypted: i=1; AKwUvBxKkAL/KPcUv3fTzOr3woPE1HrEv3Hh6NqMOMFRVKjCW43K5VWePFdISNtsOZcql8ZqOH2VWQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z9BmTOV4reQ8mGLrYQxxHtDGTcx5uRVzgHs734V7Y9LzuMRmq4l
	sOFjzR4Sj4Q113D/s+mE/0gXWwWRzrr/td2a1DR2ib4n5NRtOQWXkrdZ
X-Gm-Gg: AYBFou1G21XnzrEbhTGJltrwImcbSPaZN6dWutl+WwV3my7HZZCjz6Kk0/knicE4SEF
	5g8WW3yoYuHmsLtxar72sgcPPf7jNSHw1BefzB/eW5LjpUWvrffFJ54q6JpSYDxvABTJ/lI2E7O
	ZZNNAvwXwjlVdRgUhyo5wOwWpP1u5CPeCs/ru0oAnRP6MGOTUiH688I3ASKjY3Fn/kV/I+UH7MJ
	5WM6NnzkjW9zHlMYaSc/5FxjTLD5eZubP6Jmb1IvZdFi2I10jqBaAuqR0hI+FYT+DUJQlohfR1j
	wLdvB94yyNAPIrrNWs2zRX4z21XZNxCjD+gly2/uoAwEhTgL14q68ZsNcKhtzN3JlccDWAsQqn0
	q0Zzh4zK0B/+UI+M7JqJJL4DdkkE0zicSsuC2rPcKtAaOOB3RNXwrK2LMGPYLt08vHNd+4ipREp
	nptzfVnzuOxDoIDhDfElgI6jMP7BwjNHAScLPLzoVwvIKyFSxiIBDBQDN1rup8QwLchvV3xB8mb
	uiN95L7jSbxKB2W5jAsn7yZBkijwuFfUlaI7xXi8iQt8rOHT0z1itKFEAe8ICZzCSWGSFddz2a7
	/Dp84gvo3OEcLWplVfI52rBIokPGscZxvAhcd2zPbqYB/7WGCScxzg==
X-Received: by 2002:a05:701b:2082:b0:143:271a:3df2 with SMTP id a92af1059eb24-1ac5eea21f1mr26280362c88.44.1793880776417;
        Thu, 05 Nov 2026 04:12:56 -0800 (PST)
Received: from Yee-680G4.lan ([46.16.129.105])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36db94376b1sm10519159eec.10.2026.11.05.04.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 04:12:56 -0800 (PST)
From: YeeLi <seven.yi.lee@gmail.com>
To: joro@8bytes.org,
	will@kernel.org
Cc: robin.murphy@arm.com,
	jgg@ziepe.ca,
	iommu@lists.linux.dev
Subject: [PATCH 2/2] iommupt: add a KUnit test for unmapping an empty range
Date: Thu,  5 Nov 2026 20:12:27 +0800
Message-Id: <20261105121227.622631-3-seven.yi.lee@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261105121227.622631-1-seven.yi.lee@gmail.com>
References: <20261105121227.622631-1-seven.yi.lee@gmail.com>
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

From: yeeli <seven.yi.lee@gmail.com>

Unmapping a range that holds no mappings must not record anything in
the IOTLB gather. Otherwise iova + len - 1 underflows and the flush
covers the whole domain, or widens a range that was already gathered.

Check that the gather stays empty for a hole at IOVA 0 and at a
non-zero IOVA. Without the previous fix the first case turns the gather
into [0, ULONG_MAX] and the second one flips it to [iova, iova - 1].

Signed-off-by: yeeli <seven.yi.lee@gmail.com>
---
 drivers/iommu/generic_pt/kunit_iommu_pt.h | 31 +++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/iommu/generic_pt/kunit_iommu_pt.h b/drivers/iommu/generic_pt/kunit_iommu_pt.h
index 9fc71db74234..59a9386f1474 100644
--- a/drivers/iommu/generic_pt/kunit_iommu_pt.h
+++ b/drivers/iommu/generic_pt/kunit_iommu_pt.h
@@ -427,6 +427,36 @@ static void test_mixed(struct kunit *test)
 	check_iova(test, start, oa, len);
 }
 
+/*
+ * Unmapping a range that holds no mappings must not record anything in
+ * the IOTLB gather. Otherwise iova + len - 1 underflows and the flush
+ * covers the whole domain, or widens a range that was already gathered.
+ */
+static void test_unmap_hole(struct kunit *test)
+{
+	struct kunit_iommu_priv *priv = test->priv;
+	struct iommu_iotlb_gather gather;
+
+	/* A hole at IOVA 0 must not turn the gather into [0, ULONG_MAX]. */
+	iommu_iotlb_gather_init(&gather);
+	KUNIT_ASSERT_EQ(
+		test,
+		iommu_unmap_fast(&priv->domain, 0, priv->smallest_pgsz, &gather),
+		0);
+	KUNIT_EXPECT_EQ(test, gather.start, ULONG_MAX);
+	KUNIT_EXPECT_EQ(test, gather.end, 0);
+
+	/* Neither may a hole at a non-zero IOVA widen the gather. */
+	iommu_iotlb_gather_init(&gather);
+	KUNIT_ASSERT_EQ(
+		test,
+		iommu_unmap_fast(&priv->domain, priv->smallest_pgsz,
+				 priv->smallest_pgsz, &gather),
+		0);
+	KUNIT_EXPECT_EQ(test, gather.start, ULONG_MAX);
+	KUNIT_EXPECT_EQ(test, gather.end, 0);
+}
+
 static struct kunit_case iommu_test_cases[] = {
 	KUNIT_CASE_FMT(test_increase_level),
 	KUNIT_CASE_FMT(test_map_simple),
@@ -435,6 +465,7 @@ static struct kunit_case iommu_test_cases[] = {
 	KUNIT_CASE_FMT(test_random_map),
 	KUNIT_CASE_FMT(test_pgsize_boundary),
 	KUNIT_CASE_FMT(test_mixed),
+	KUNIT_CASE_FMT(test_unmap_hole),
 	{},
 };
 
-- 
2.34.1

