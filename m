Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794346662;
	b=Tj+I1V2peXmOpI4rZW2LZgtPzO/+2VH2pcdL9qtpo75YV4zvAE0F+GdvwZJy40k8OBa5
	 L9NqSzbVmdJL+neFTsJFQGWjiXxfTOO2V3vDdgpEVCn/VXeQA51UPaPYqIgGy0GnhBnC9
	 qW9TRkZzWQNVqgF1QJbzPHqfsQT8GQX8jotpoBOmgM8/yPl0fPWO4oBrbMWJVMq2RUnrx
	 lEnsY+NhiQOu6HuAZesvFhtFpV9eLjExaC+PrE/BRhqtarIAO1zT4NIRu6y3005s2+cfW
	 smCIMafFsOnDz176PxTrnZ3XX8JB62Haej+q8k17ySsgZ+2rv+z9Hs1k3kYp9GyFRtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794346662;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=pQPeTacN/BYl2gLmAN7uuVOyVLhnQcGIVBITEszOTd8=;
	b=aA2iCHuu+mhkqrSYmCb4Gz58ivr0sQwfJelVhn6aLXBY+zUh9RBJD10oFoHAYqqC9A7/
	 1I2gj4Bo6yGS5Y04YMiHDpzh+SaS834ryKrILQiVcd//omtPEO5Mj4PP8xcg5t5scKnxT
	 v3RTAEO+i7r1khyDmcpsXEK13Y+7IbkLHfqmmkpVU5UHiaq5KAa9zzae9aAQ9Rs40FUuM
	 iT1TtU2ITw4jbHT8mW3WHbhxwErhK5jZjQxfR6kt+J4CT6bBJiAjNh1rEOK/0JFiGdJuT
	 1z71dq1lCQ/lh7mYWUALGFS/OqGFA+bScU5Xj0MXrBGn5QWDMStZzM+gI/kqYSB6suQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fastmail.com;
	spf=pass smtp.mailfrom=fastmail.com;
	dkim=pass header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm3 header.b=gfwTy7+c;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=z8DX97bd;
	arc=none smtp.remote-ip=202.12.124.149
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3897A606A331
	for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 21:37:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3897A606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm3 header.b=gfwTy7+c;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=z8DX97bd
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id B87581D0027C
	for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 16:37:41 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 10 Nov 2026 16:37:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1794346659;
	 x=1794433059; bh=pQPeTacN/BYl2gLmAN7uuVOyVLhnQcGIVBITEszOTd8=; b=
	gfwTy7+cif1e1LVct/UzO93FySeF/L6rOHFYPigDO4WR6oti4A6SsYIb4FoBfHko
	smrXwqe/XfsQvuRAQQZwvfRoX7/wfrwRuQWoGJQcZsbzoCc0JGB67TgSZT6DCs3X
	BTEgfOmFp0uj/oDfn50THCpFKFnygLcMXQQhQ4m4gxX2ROeQoNmpkfv087Kc7RlD
	+J+8Okz0YQ+4j7ZsDuxqv9xhn+RPidHFiegAOyv540OEMC4/mQZgfug+ef6RAK3J
	+MMzaEuDB7Ndx4Vm/wdwJ0RWtC9fbXRUtemNsRe03eRRwjh/XoMlFAi3AAvGvxvv
	2Wt1fCX6hQfEswmFUw/8hA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794346659; x=
	1794433059; bh=pQPeTacN/BYl2gLmAN7uuVOyVLhnQcGIVBITEszOTd8=; b=z
	8DX97bdVTiHKspQTFx5mViskJPWEI3RT+8mVC/gZLIyRhqUqi2X9MZlNdo/OzYT9
	GbtRnGjP6gLAO6kObwoEzGOOrPfkZ2Ukod73dwDBIQKF9Ffb0ruv4yACYlYuZkGp
	yxzlG1BopWQvQJrJLum5vYTfx/RxHh22sOlzneU0ABs5tFv3H4t6zXHjIr9w91gx
	Ctrburv16t05CrUV3P3xuryJagtayithjlYz0gb4nHNHNzPLRtrVpxHcBIBBBsJI
	lswFRoE/a5mp8zYibJYpMkR4iofYz25oKdLh0KjslLFb8OOUOWMByBUJYg2ndjcw
	QVPD9CDFYiPbuksDN6yow==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794346659; d=fastmail.com;
	mf=PGp1YW5sdUBmYXN0bWFpbC5jb20+;
	rt=PGlvbW11QGxpc3RzLmxpbnV4LmRldj4=;
	s=fm3:rsa-sha256:aZWYT6pHqeLuYHA6tPvPSW0UgyqrWGF3S4xJ+unyTCZ7+21
	e1La+Cx2LClwHhBqx2W7irdzLx18t23ymc6K1TcsTc7jt7IZnCgl+kS/+vnS4uBE
	MDyxcYAxX6jE1aLjIy4M6w+gSa3WTxDOJVdB+AMJkINbbm/11j5aZywH8pycyYcD
	IimkNTTrnlAATK1xMQFCvuA4ri/Q7iOHpJaQKbl5v4Ipk447+OEyOQbMJ6l+moZK
	XtMwgS23v/9UyzfUUvGWGQ04p4MSUPhk0m2zY32WplqxwpU+A9oVJygI+H7XqOOs
	Yt5+pa3k73OLHzJXvfL3omi+1mBnHsB9+KAuARQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:eh/dKN/2QxMOjoEXNb5UK5C+r/WzrS1VQOk6m+ogYmA=:rIbkHgOQYUfQ1osRjj/4kXU7nTmkv5misKZNmcmqScE=;
X-ME-Sender: <xms:o47zasAb6tti-vRIvRSQAI-J1iM1mXY0YGQhZn9gz5zFRioZGVhzGg>
    <xme:o47zaiNEYqoBuBFRqJ0dzfYmm0VYNKN0RS-Z8Wa0OLRGRRreBzibecbbk0iFvOG0M
    HIJjll9RmYuxH0wsrIAPKnIMMUOLIvmMpudTvk4ZO_fNOfdHLdfILRG>
X-ME-Received: <xmr:o47zaoPCycbrKAKzHxOZW3oGQSESUZ-ZSdHBaA0sM1pV-M6YO9w2IvpN4SC0g3ySniYtvPdESWBOkakoJA>
X-ME-Proxy-Cause: dmFkZTGNVXlGWE+7P2XXaL26F5AMGtpK2TycDVlf+xOjA+PYERZl6/BW+lbT0+wzTsbcnL
    kBAhJvg1txFwRjOcd7bw7X+tErVQLKyqfU9/T4BbMHT193EbxKvHyY8bAQ6ww6NmZWX2Gj
    S4oVvhJFMJ2BxkJuVf9ujSPSfv16nLGp7k9bwFNTR8UP/etY4ewbE2QpklWLWUkhZbd3tk
    i2NFMM50EyvyBj3i7bkefkHzaAGSTWPc9b/2WlAEfIPv9QAFyLDidETcJqU8/KdZSLuzWm
    YnikjaxRN8sYTqzmqmhrte8FXDDjJZwMnUc/kh6WLuGF7iefMNEW49vFlHrDG5ZIu0qxnb
    vWHBHYmbVanc4mvFNBURK2LzrAF3B/Yo6DDs89K6yoDVQCqt4kOgmvGZEFc98pdMoX3UA+
    ERVPXJV297cKHqg82Cmm4yWgRmP4ieHipAGa9mDa5wRUZP53ieM8gzbFuAxkR9awZXOr8t
    kDNYvRgoAyPxlvwXs4pWirk7COdYvJ9s3rOrX1A/oF1hZTc2Y2fuSHjTuAw/3DEp6uUPxb
    oA+82RihXNdAJtbxu/D1GwO8wsJ8VAKx9n2GBPr39VhzGtE382DS5nDm+JCa9hFGjJksMi
    j1xABSJ7nsX21FNkUt6zJm+UumP7zctU530ecXwopTpDeaycXzd8/MZ688NQ
X-ME-Proxy: <xmx:o47zakLL7QO78ILQizAgIMVkJ1B5GwKOlT3aVhNudLICMPiZpD4vGg>
    <xmx:o47zaipfHw0lAq1mkKFM2WA2Kenhed-d6EhYInxm5KpefJT5UFepWQ>
    <xmx:o47zagOAsYpXDOWckS1XKAsyMwJESmc5QxFgBxusffb6m6ZRXkfNOw>
    <xmx:o47zarjG1QVeI8lDdNtLJdSik9ZTJemwFccGbEIM0ruYwmP7V22Gow>
    <xmx:o47zal9_Ky0U15rZE_SEAgDZtkK19wkrP2KYdvqoLZECpYRqgYUsa_Jk>
Feedback-ID: i80b64ba7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Nov 2026 16:37:39 -0500 (EST)
From: Juanlu Herrero <juanlu@fastmail.com>
Date: Tue, 10 Nov 2026 13:36:49 -0800
Subject: [PATCH 3/3] dma-debug: add bucket bound lifetime coverage
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-zcrx-dma-debug-registration-v1-3-48743ea61631@fastmail.com>
References: <20261110-zcrx-dma-debug-registration-v1-0-48743ea61631@fastmail.com>
In-Reply-To: <20261110-zcrx-dma-debug-registration-v1-0-48743ea61631@fastmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Robin Murphy <robin.murphy@arm.com>, Eric Dumazet <edumazet@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
 Juanlu Herrero <juanlu@fastmail.com>
X-Mailer: b4 0.13.0

Add a KUnit test on a local bucket for conservative bounds, equal-sized
mapping removal, empty-bucket reset and reuse. Exercise the existing
insertion and removal helpers without DMA hardware.

Signed-off-by: Juanlu Herrero <juanlu@fastmail.com>
---
 kernel/dma/Kconfig             | 10 ++++++++
 kernel/dma/debug.c             |  4 +++
 kernel/dma/tests/debug_kunit.c | 57 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 71 insertions(+)

diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index 3830a63ae032d..3f295a1503597 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -291,6 +291,16 @@ config DMA_API_DEBUG
 
 	  If unsure, say N.
 
+config DMA_API_DEBUG_KUNIT_TEST
+	bool "Tests for DMA debug bucket bounds" if !KUNIT_ALL_TESTS
+	depends on KUNIT=y && DMA_API_DEBUG
+	default KUNIT_ALL_TESTS
+	help
+	  Enable KUnit (kernel unit test) coverage for DMA debug bucket bounds.
+	  Check that insertion and removal keep the bound conservative and
+	  reset it when a bucket becomes empty. Exercise reuse and equal-sized
+	  mappings on a local bucket. No physical DMA device is required.
+
 config DMA_MAP_BENCHMARK
 	bool "Enable benchmarking of streaming DMA mapping"
 	depends on DEBUG_FS
diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 8dad45d0a4360..1d0990e447516 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -1700,3 +1700,7 @@ static int __init dma_debug_driver_setup(char *str)
 	return 1;
 }
 __setup("dma_debug_driver=", dma_debug_driver_setup);
+
+#if IS_ENABLED(CONFIG_DMA_API_DEBUG_KUNIT_TEST)
+#include "tests/debug_kunit.c"
+#endif
diff --git a/kernel/dma/tests/debug_kunit.c b/kernel/dma/tests/debug_kunit.c
new file mode 100644
index 0000000000000..96cff02a6918d
--- /dev/null
+++ b/kernel/dma/tests/debug_kunit.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <kunit/test.h>
+#include <linux/sizes.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+
+static void dma_debug_bound_lifetime_test(struct kunit *test)
+{
+	struct dma_debug_entry *entries;
+	struct hash_bucket bucket = {};
+	unsigned long bounds[7];
+
+	entries = kunit_kcalloc(test, 3, sizeof(*entries), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, entries);
+	entries[0].size = SZ_4K;
+	entries[1].size = SZ_64K;
+	entries[2].size = SZ_64K;
+	INIT_LIST_HEAD(&bucket.list);
+	spin_lock_init(&bucket.lock);
+	spin_lock(&bucket.lock);
+	hash_bucket_add(&bucket, &entries[0]);
+	bounds[0] = bucket.max_entry_size;
+	hash_bucket_add(&bucket, &entries[1]);
+	hash_bucket_add(&bucket, &entries[2]);
+	bounds[1] = bucket.max_entry_size;
+	hash_bucket_del(&bucket, &entries[1]);
+	bounds[2] = bucket.max_entry_size;
+	hash_bucket_del(&bucket, &entries[2]);
+	bounds[3] = bucket.max_entry_size;
+	hash_bucket_del(&bucket, &entries[0]);
+	bounds[4] = bucket.max_entry_size;
+	hash_bucket_add(&bucket, &entries[0]);
+	bounds[5] = bucket.max_entry_size;
+	hash_bucket_del(&bucket, &entries[0]);
+	bounds[6] = bucket.max_entry_size;
+	spin_unlock(&bucket.lock);
+
+	KUNIT_EXPECT_GE(test, bounds[0], (unsigned long)SZ_4K);
+	KUNIT_EXPECT_GE(test, bounds[1], (unsigned long)SZ_64K);
+	KUNIT_EXPECT_GE(test, bounds[2], (unsigned long)SZ_64K);
+	KUNIT_EXPECT_GE(test, bounds[3], (unsigned long)SZ_4K);
+	KUNIT_EXPECT_EQ(test, bounds[4], 0UL);
+	KUNIT_EXPECT_GE(test, bounds[5], (unsigned long)SZ_4K);
+	KUNIT_EXPECT_EQ(test, bounds[6], 0UL);
+}
+
+static struct kunit_case dma_debug_bound_cases[] = {
+	KUNIT_CASE(dma_debug_bound_lifetime_test),
+	{}
+};
+
+static struct kunit_suite dma_debug_bound_suite = {
+	.name = "dma-debug-bound",
+	.test_cases = dma_debug_bound_cases,
+};
+
+kunit_test_suite(dma_debug_bound_suite);

-- 
2.53.0-Meta

