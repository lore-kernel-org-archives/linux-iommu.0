Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1A5480961
	for <iommu@lists.linux.dev>; Thu,  4 Jun 2026 13:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780581186; cv=none; b=cB9w8MU/Hn3vzvGmvU+gHqvBhX7Or7fqYy1u5tJnoYY9FiOD7mH0ZWKxAgpfvcx7fjpbQS9FXHcCQdVNuRX7uS3xkqMtU4gSyyh8AX2BFpasggQ2cAxp6hFhhsxUZLhVuaz7jdpbBuekq4V1T0uGoSH3mQ35BN8PllsdWJ1+TKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780581186; c=relaxed/simple;
	bh=H84PCi6rqd7ZXKUPzqtrIa81wxH9NJ5ajArN4ifw6yE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uCtzVayWugKjxppbwM2AS37H2secdTx89emBewHI/kDxVk2LIRd043UsLsp08SXzdDpPQcFbjOCs9RzgmTggudGi+3Howe8LfdU0W/V9zJaVlhvoFixXZAQJhYmy9awc8DzxlAjCzppPN8Uo8Dqz3O9+lit6R0XIGYjTOaOn67w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aAtjzS+b; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aAtjzS+b"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-46013161068so387204f8f.2
        for <iommu@lists.linux.dev>; Thu, 04 Jun 2026 06:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780581182; x=1781185982; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7zTkYHigKQy3WkeWXyJsWd48o8A6LM0P0gm1ZhPIld0=;
        b=aAtjzS+bfTW+pNymfCM2HSpNUOG525fxAmRykJVsxcaLxwJ+aHcCZKOZf8E+kt6HFH
         +/Kv9UZ2iu57BAJ2AD48AjgEeWpSJ0LSqaoLx3FIti29XyRZIPEUh4XgDLUXpUkb6Ozt
         H0dOaTnr8nBYYhNPjpA6yP2HQNWU4bzi0zePhwV/kEyPplcQEIkiPwv6Spku60Qq6KbD
         5qmj1BeVE8/XpvR0916t/ErVLKSYqba27KVAdYD1m3BkWQZPzXQ5EigJZDr/u47/xGlz
         kM1zSzLrTgVzm6c4Z3m402TbKSFR83BdSNHStONJbcascOYxLSLo8s48fBFlRQYIQxuU
         75ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780581182; x=1781185982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7zTkYHigKQy3WkeWXyJsWd48o8A6LM0P0gm1ZhPIld0=;
        b=Td0OwM6siXXtNt+YW78QNnxI2p8HLUw6eplCgyYnXF354TCXrsY8b1ltk8pfbiRv2M
         w+Whs2tkYeAQGaRPoYTZmJx9wk/uwGgPmj5g3j0AoewuqT6XsDewMW/hmtmwfAykOj1o
         /J/rCy8KadZJM5gPZCxTbf8ers4TARlh/EeGbRj/J4buNMBKXdY3JBim3yqGw+LuNVX0
         zotKNCKLv+Kk+6xY+VZqFyGsVlb1kw1gm3qG4JIoBnTUSETDo/g9KCA9/wQkUXcTAynG
         a+wml8Q9Lf3xJr080FdIR0CVJ3GqWjKnu54GotdZkkWuOf9gPWihZuZJcaRu5s/by+Tm
         xa5w==
X-Forwarded-Encrypted: i=1; AFNElJ+U/bKfZvegJqQ07UXGoCDl0eGoLzDGGwycwK4rrnLTdTPowpkh3xsn1LDOnPpFtg5jV13Upw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzQhil9UY8fnDT9mP079q4OZpIllHocXPlPkZn8mpmITTCbAbq1
	AMAQ/fPqfZVxobMHW9INcMQN9dc1DJgvzUia5mbnGlNZk0X4XdRQtLO6
X-Gm-Gg: Acq92OE4gyE3rlBBYT0dDuCWCYWxGe7OrjJVqrMYj2ruQlUucnPwhwj3DVDJrQ1vGv2
	eXkANKbrh/Z1AERW4/FXIuGchBVNT2CTAmmvCEyHLMAFO7u/laUbw5zcevwNx2ism2hMR+RsfmP
	ySEX8bob29hu3b45IRtXVzA0SQAcYs2r2EbnxrRZudZ6ptvUzE5XuxGDYy6Qyt1QK5NN6JT222r
	yKbzUeJZXhQFtLVbCJoXSUUgv/L/34n0xb5uAcaNNBjx6lS30Ht9P6FIwBDor1IsOFaGT+un2WI
	MTBV49YS2ELQKWn7EciRwjVnoEEtVD9do/WhWGbH9arrkhKQvGa4/E1E1c/BlNTZ6FLQLsZEJbd
	wtrUR29rErDf9FOwd/R9Sa6S4SflIl4pBU9zwgPe+QzNr2afRfKR8/DpHIWvHI5XaHqyz9v0ZQQ
	VIacdId4z15FHNjTAApbHK1+wr8OosXaVdgeYD123xcoDdYigBwtSu6enrGrvTYOs=
X-Received: by 2002:adf:e00c:0:10b0:45e:f381:cd7f with SMTP id ffacd0b85a97d-460217831bamr9227520f8f.5.1780581182173;
        Thu, 04 Jun 2026 06:53:02 -0700 (PDT)
Received: from compiler-rock3b.tailb81abf.ts.net ([2a01:e0a:104a:4d80:be24:11ff:fe12:2776])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f0a43e9sm16661068f8f.0.2026.06.04.06.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 06:53:01 -0700 (PDT)
From: Midgy BALON <midgy971@gmail.com>
To: tomeu@tomeuvizoso.net,
	ogabbay@kernel.org,
	heiko@sntech.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	joro@8bytes.org,
	will@kernel.org
Cc: robin.murphy@arm.com,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v3 6/9] iommu/rockchip: Clear AUTO_GATING bit 1 on the RK356x v1 IOMMU
Date: Thu,  4 Jun 2026 13:52:52 +0000
Message-Id: <20260604135255.62682-7-midgy971@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260604135255.62682-1-midgy971@gmail.com>
References: <20260604135255.62682-1-midgy971@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On the RK356x v1 IOMMU, RK_MMU_AUTO_GATING resets to 0x3. Bit 1 enables
auto clock-gating of the page-table walker, so the walker's AXI master
loses its clock between transactions; a TLB-miss page walk then never
completes and the IOMMU is left stuck (PAGING_ENABLED, never IDLE).

Clear bit 1 (keeping bit 0, the slave-port gate) once paging is enabled
so the walker keeps its clock. This is required for the RK3568 NPU MMU.

Signed-off-by: Midgy BALON <midgy971@gmail.com>
---
 drivers/iommu/rockchip-iommu.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 4da80136933c4..e3d8b6e9ca12b 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -953,6 +953,18 @@ static int rk_iommu_enable(struct rk_iommu *iommu)
 
 	ret = rk_iommu_enable_paging(iommu);
 
+	if (!ret) {
+		/*
+		 * RK356x v1 IOMMU: RK_MMU_AUTO_GATING bit 1 enables page-walker
+		 * auto clock-gating; the walker's AXI master then loses its clock
+		 * between transactions and a TLB-miss page walk never completes,
+		 * leaving the IOMMU stuck (PAGING_ENABLED, never IDLE).  Clear
+		 * bit 1 (keep bit 0, the slave-port gate) once paging is enabled.
+		 */
+		for (i = 0; i < iommu->num_mmu; i++)
+			rk_iommu_write(iommu->bases[i], RK_MMU_AUTO_GATING, 0x2);
+	}
+
 out_disable_stall:
 	rk_iommu_disable_stall(iommu);
 out_disable_clocks:
-- 
2.39.5

