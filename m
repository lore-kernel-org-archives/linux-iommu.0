Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC95483807
	for <iommu@lists.linux.dev>; Tue,  1 Sep 2026 17:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788282543; cv=none; b=a75cSnKlB59qRGKSrSTNQCluprrB7DwMbz4wAYueBZ2T4HJ+FTX6uQ37+KQ+vmkX7S1WT1e75W7h+ErGhWElCE8t7QEv0LYWgy5hCHyYYSqpwCOCslCJuytTMlS58DmDE5JRTC65fd+jqh9rORsTli0K95laFCk2UiWaGs4JY24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788282543; c=relaxed/simple;
	bh=Q0EerqSgGvmAb1C2z/3u7uYu/BE74lyAF6uYjKyCP+A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dTJT5Af7+hkunIj74Cu8u0WwKo7Mq68ClhOYuYJtYb5irq0i/AczbdB8roCrzEtGAjkWxjdghoQY3QnHOYrqY18hutqByeDnAmO5beGZRmqucBjSnXF6d6V1thG2oybbYfXFiFSq9lV7thgL/3ToMrSzeQK8F6GwV3uKp//95dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=x6u.co; spf=pass smtp.mailfrom=x6u.co; dkim=pass (2048-bit key) header.d=x6u.co header.i=@x6u.co header.b=k8/hJphJ; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=x6u.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=x6u.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=x6u.co header.i=@x6u.co header.b="k8/hJphJ"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-86b03b75fecso3805697b3.0
        for <iommu@lists.linux.dev>; Tue, 01 Sep 2026 10:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=x6u.co; s=google; t=1788282541; x=1788887341; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=b1WtM+yGxMA6nGtYPUfHvkwWZoT/FUK2b2ZzSHby/Yo=;
        b=k8/hJphJfqu1Zuvq8NhJvd8838X16qj7iYMwC6JkT05GO/EN1LyNs5NmtVf6fzoR8K
         Yl/+/DK/9NgKxBM2dktXB2fh8J4fjniSF8GEagu3qduVAR2mBxDMxktJg9gSb6572sIA
         opvKG5z4Q3Th00ih0hDktZAb8rnHdMkxOUxEh9mevh/eabmvUGUPNEqFSM6iuUQdx8rk
         nV8fBRPjy9pB6/Ed5YDJ11dMjHRVKu/gdiwPTAr4X8ZgmxRcLNhzIyy3UoPG92lGh1Vl
         RTAefuiUHwLOd/+GcxApskqfjaJlaUrK7bDR2Lp+A2fjgiPy34/R54ddGJgLTi1xP3Tt
         ZSQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788282541; x=1788887341;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b1WtM+yGxMA6nGtYPUfHvkwWZoT/FUK2b2ZzSHby/Yo=;
        b=nlyTLcrXKDziLV/vVy/c5a0tS+mSsyD2SxZcJxwGJ37E9cCblIhQ7wkuaY+RPqnNYt
         jsO8lRPUDm3lmG/eIPjvWB9VgupW/31Eh3Eoz6uy0rye4j9wg/iZ1ZoVVgz0hTkTGWdn
         OuTeKyUcekyT2/MCBhx87/r3OVgYv2IFWmOqEkdYxsujjbZyuqPQvaPzSC13LAriFyO9
         NSNKr7RwLBdyzYCIOBFLLhWgirPYOjiVYlB0kAhz6Wx1w2lnCeyWCwGguPpxtm5mWJHS
         FkXm9FxhPTJwUuQu5zrsttWi+kPg9uh2yrS7i8G570rVNWd6v882hvlfFA1GZ0IRg6x0
         k5fg==
X-Forwarded-Encrypted: i=1; AKwUvBzEowBcF52Tc80UipIx36YyVnBQZI3qw2ADbbO7R3DXpTt8kFXH4CEixPrBao0/uvcFha9BBQ==@lists.linux.dev
X-Gm-Message-State: AFuF++kgpBFvA0TybQpe+yCJ6gzfJtMAPOSnSxptj9yrpvZ9nVleMfgs
	RC00BVKitBHF9XMp7KDV2JL86plBDI8VnBXDwq8E+6CgsJJSjX46V6wmyq9n0WsHW5OO
X-Gm-Gg: AYBFou16XIYcCkYv+yhmLgeUCAklXDljCb21ot44suQ+P5bEQveWsNgdpQ5BVCFuFtt
	ENeyWnOzTIxzZi9M94VqLlL4ASmL6VAg2OLYs2RcEk7h50s1rpqL5y8migVeIbdKbSwQC1tinJ9
	ejJQPwnEVzWwnapU5vRLiCLi+L0oywz/zcUXAj3Yk10S8LeRG/x7PeqUMphDGX5n4atLBZ+MY5k
	tqwfGUd4EUEDe+Ll6Gi3+TEZHiu3aJ5bVNmr013/IdBdmXAZZJnZO9/K/3DQKDhkmGxbDuorsMR
	QJk2oK68Ny4EJIQcO/BaEo774mNCg+FS4eb8xiSQe/L8lz2hM7mF8Fk4X1D6f/IYZLtZ3u1456f
	H8RxCea8609cWJqBX7pc7mKt9vvuIAfDgip0+ghoXmHSxOUNhrjka9Mj/cx09FOX//y7A2inlP8
	Tm8a0bTzL156fSQDKEkP4A/TVWGFyenkwOxe7vzJXs3JzSPqnnlaGUFbJKsgohbNgntloDxjDsF
	XHosaZKofIkMIC7TJ5WYOjIxdWLXc6W6Jw4BYWo/ygDk2I9mqvdb/AfmBcwYNMwHQLFlaWJFbwv
	bw==
X-Received: by 2002:a05:690c:c3f1:b0:81e:98d3:cac7 with SMTP id 00721157ae682-8686f52fe19mr38821267b3.12.1788282539975;
        Tue, 01 Sep 2026 10:08:59 -0700 (PDT)
Received: from worldpeace10.c.googlers.com.com (109.243.150.34.bc.googleusercontent.com. [34.150.243.109])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-85e65f146edsm79761867b3.32.2026.09.01.10.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 10:08:59 -0700 (PDT)
From: David Hu <dhu@x6u.co>
To: sumit.semwal@linaro.org,
	christian.koenig@amd.com
Cc: alex@shazbot.org,
	ankita@nvidia.com,
	chriscli@google.com,
	david.laight.linux@gmail.com,
	dri-devel@lists.freedesktop.org,
	iommu@lists.linux.dev,
	jgg@ziepe.ca,
	jmoroni@google.com,
	kevin.tian@intel.com,
	kpberry@google.com,
	leon@kernel.org,
	linaro-mm-sig@lists.linaro.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	nicolinc@nvidia.com,
	praan@google.com,
	sashiko-bot@kernel.org,
	stable@vger.kernel.org,
	viursachi@google.com,
	xuehaohu@google.com
Subject: [PATCH v8 0/2] dma-buf: Fix silent overflow and alignment
Date: Tue,  1 Sep 2026 17:08:47 +0000
Message-ID: <20260901170849.4052816-1-dhu@x6u.co>
X-Mailer: git-send-email 2.55.0.966.g6673acef38-goog
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Hu <xuehaohu@google.com>

This series address two related issues in scatter-gather mapping,
specifically for the MMIO based dma-buf mapping. The fixes ensure
sgt mapping is correct, and proper for large MMIO regions.

Patch 1 fixes a silent integer overflow for mapping length exceeding 4G
(Previously submitted as [PATCH v7] dma-buf: Fix silent overflow for
phys vec to sgt)
https://lore.kernel.org/all/20260609164047.486227-1-xuehaohu@google.com/

Patch 2 Splits sgl by largest page aligned chunk
(Previously submitted as [PATCH v3] dma-buf: Split sgl by largest page-aligned chunk)
https://lore.kernel.org/all/20260722233806.3922093-1-dhu@x6u.co/

Changes in v8:
 - Combined the two patches into one unified series to avoid merge
   conflicts.
 - Collected Reviewed-by tag from Leon Romanovsky for Patch 2.

David Hu (2):
  dma-buf: Fix silent overflow for phys vec to sgt
  dma-buf: Split sgl by largest page-aligned chunk

 drivers/dma-buf/dma-buf-mapping.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

-- 
2.55.0.897.gb25b4bd76c-goog

