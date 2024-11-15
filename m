Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19DE187561
	for <iommu@lists.linux.dev>; Fri, 15 Nov 2024 17:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731691369; cv=none; b=lW4pOQOYdRbCHx/G6PrkZu3emD1Tp7LdqyEgFE141aGmSUBt8TqctN/9ajG6LGMiDgUbWegMW4/526gCyfWUqyjkj8uWNR3qPpPfzkEEKFSi2DkP13F9sIg0abj8qq52vAiBUvbPw1+Ihezu8Pbx+ag7y7OPu5gHBmF3YTdiv7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731691369; c=relaxed/simple;
	bh=xv6EhGIjp0yNQhtdD5CT3ixx8ib+7RX5OoUHS2SRIGU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Zhy5+Y9LUdNjIVvfmzq08CsHITvKGe4Pf2CtFAM2X3P6SE9MiZ9hVb8YovGtLKt9YOFlTgxajhb6ixaXTzA5eCpVGhfRxlBvmw58ClzXSUddFvEv+qhpDjzMqbQXkE2A8NqfdER5tet/ufJUUWxhR59noATaKvz7Nbf9qHAf3cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a+iicwlK; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a+iicwlK"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e02b5792baaso2904194276.2
        for <iommu@lists.linux.dev>; Fri, 15 Nov 2024 09:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731691367; x=1732296167; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BsyG1LXRA/7W+KV3OjFnPglA0evpVqXbyPXRpQQ0nGw=;
        b=a+iicwlK0i/Z4mF58b+euTD6H65IGAfs2lfgfnNC5qNNyyxN+ZNZuQuizld+3AvF7T
         k3elBVxECaQYrLVTHwNH+Fr/euw7uAx/KvIkCwSC+hIfZ1cGTaBQzd0y2MrX8BoeYXBu
         vPxPoCFwqg3h/feAAj/D9LeRU5tvFtci4vbrescjBXiCH4lWnmReJXlWSnd0MAWovle2
         iWARxfKGcvGNFjQxM+KUb1W4gHxHp1BtXazMUdtWJtUJQwgWb1tSwRKpZ9SEOg3vRr+k
         1VVLUI0AjtLJvduONWHeMQHXrP+rXe3vmUlMtJdA2y8UOqyd+pBLjty8/8lJra6z7j/b
         JMVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731691367; x=1732296167;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BsyG1LXRA/7W+KV3OjFnPglA0evpVqXbyPXRpQQ0nGw=;
        b=JwGLR9jaMVaa5tgFKaGT02iIPowuzrTxZxhdi1eZSo3VLW0nRTzELgMqp64aM5VZUw
         iBKsasRXZLovL5jmiy5uQq7jNh1lk8DZuA8e2I5np27O+uNxHKyvr/4WMHllSJaoEPYh
         7n2iYRXtOsHMUDb1x4LWnwAUCn0J0nU+k5J/SIjcPKlMSch5kIm45oBuCHV3z+gTi+uw
         vbf3jga1DsANTZHhmfMuS/xSwzK3Wp/C5xmzjJTskWIRHiQBwC+nde/T7xZkBuXEVnKR
         uGFN/zPp1bj+I5BUo/D/vUQZi+7UQh9k9PkeoKlLu3+xgOKTuoE9/23YyKTD8nQY2H4o
         PTgg==
X-Forwarded-Encrypted: i=1; AJvYcCU4X97fyf3VGMzalooVKbAMbz2hnSJF12k0llKfldrOqwDqzZbzvSypUbDG2cwEUKKEgZiyFQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyk5gUSzgbuhHzRQCUz6pTnWf7lpqpzvokxsPVU+ARJmqdIKY0W
	Gtfco373up7bQDGUTGnPPQ2MVBbTH7ZydqZsmt+54H6zGcYG88QuJ+qlxswbrS5qqnYipCaDISp
	Nkp44wQ7MWg==
X-Google-Smtp-Source: AGHT+IGsNFjwDx3jzS5qgLurnITHUTNl+C7edx5Hcxb5uU5DHpf+5tuu5L5h4bcVjOQnEwH2ggCQphITmYa6kA==
X-Received: from mostafa.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a25:660d:0:b0:e2e:2cba:ac1f with SMTP id
 3f1490d57ef6-e3826395ad4mr76341276.6.1731691366807; Fri, 15 Nov 2024 09:22:46
 -0800 (PST)
Date: Fri, 15 Nov 2024 17:22:35 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241115172235.1493328-1-smostafa@google.com>
Subject: [PATCH] drivers/io-pgtable-arm: Fix stage concatenation with 16K
From: Mostafa Saleh <smostafa@google.com>
To: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, 
	Mostafa Saleh <smostafa@google.com>, Daniel Mentz <danielmentz@google.com>
Content-Type: text/plain; charset="UTF-8"

According to the Arm spec DDI0487 K.a, in:
"Table D8-9 Implications of the effective minimum T0SZ value on the
initial stage 2 lookup level"

Some combinations of granule and input size with stage-2 would
require to use initial lookup levels that can only be achieved
with concatenated PGDs.

There was one missing case in the current implementation for 16K,
which is 40-bits.

Cc: Daniel Mentz <danielmentz@google.com>

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 drivers/iommu/io-pgtable-arm.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 0e67f1721a3d..9a57874a5cb8 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -1044,10 +1044,18 @@ arm_64_lpae_alloc_pgtable_s2(struct io_pgtable_cfg *cfg, void *cookie)
 		return NULL;
 
 	/*
-	 * Concatenate PGDs at level 1 if possible in order to reduce
-	 * the depth of the stage-2 walk.
+	 * Some cases where concatenation is mandatory after de-ciphering RSRKBC
+	 * in the Arm DDI0487 (K.a):
+	 * - 40 bits with 4K: use 2 table at level 1 instead of level 0
+	 * - 40 bits with 16K: use 16 tables at level 2 instead of level 1
+	 * - 42 bits with 4K: use 8 tabels at level 1 instead of level 0
+	 * - 48 bits with 16K: use 2 tabels at level 1 instead of level 0
+	 * Looking at the possible valid input size, that concludes to always
+	 * use level 1 with concatentation if possible or at level 2 only
+	 * with 16K.
 	 */
-	if (data->start_level == 0) {
+	if ((data->start_level == 0) ||
+	    ((data->start_level == 1) && (ARM_LPAE_GRANULE(data) == SZ_16K))) {
 		unsigned long pgd_pages;
 
 		pgd_pages = ARM_LPAE_PGD_SIZE(data) / sizeof(arm_lpae_iopte);
-- 
2.47.0.338.g60cca15819-goog

