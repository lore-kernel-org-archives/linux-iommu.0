Received: from mail-pj2-f3.google.com (mail-pj2-f3.google.com [74.125.227.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702AE330D22
	for <iommu@lists.linux.dev>; Fri, 10 Jul 2026 06:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783663522; cv=none; b=qfGLNN/bf9TAh1rBDeY3aZUg6hUSi6g3qaYLtf4gZwguJjJqoigL86KlTOZ3aKV2fSWZBq03lAHjCypTW6R9eLmi+5e2bidzNe+enXEVuc4qGA+JUlEmXDiPY8CGB9DYLs0+U+XwYm1fqzwoMlbUfgu+8V9pei9ME3j21HjjkvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783663522; c=relaxed/simple;
	bh=+TSl9lWGvPOhVvtGbRmV7Zvub/yR8s6/knDkK3HGmbo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U2Ko3gwvJ0Jaz3R9Ex7iVSNnaRzwSB1J9+IjBFHi1H8e5UUvgEPuGHg3QyaC+n14NFnbywXWhzCyspwUJ3LwB9E4PtjaAAW2YgocP1TAVP94wLAvCcCgi0zC552HJNULtL02KdNA46SidAXvbHzzIu5SU9GIgVLmFEVoMXpaubc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AIakjcYr; arc=none smtp.client-ip=74.125.227.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AIakjcYr"
Received: by mail-pj2-f3.google.com with SMTP id d9443c01a7336-2cc8ed77bbcso8474495ad.0
        for <iommu@lists.linux.dev>; Thu, 09 Jul 2026 23:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783663521; x=1784268321; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pQgPhs+dZcfRNPuJReU9TiVxwha1e01HcHWKyyYl0NE=;
        b=AIakjcYrZh6AS8EuQwoqMv79PUoRF+/uIpyphUlOzlfaoyBVX4mPu7J/qUIHB12fim
         QmYRWzOzpPDN/HVA+LHQEFhK3FnSJgpa2i4OX02aWYo2EFl89f5o/fCOG0dTRFSYwSKG
         riMsXw0zNYgaAI//3kj06KNwhgEnKthsZkRCPPDWsy/3AlFg1SFQG84ne1bUXDn2mIfv
         XZHQrkhUpQOrhuHY/2VEJ++Ab5XEORcIN6TEz4pgw3duCEWhQGl3Mz3IByo0ef2p2Kbx
         O1Z+CHCWW7aGXKYAtQcwp3V8GR+RqeCA/pV5LUXhNqA2h7+79iE9b1KlPxgn/4SiSuRI
         2rAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783663521; x=1784268321;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pQgPhs+dZcfRNPuJReU9TiVxwha1e01HcHWKyyYl0NE=;
        b=KUh3hOPnD3b2D1D7pBI8wS7c1gOpIkYDKzKND0cryNDcq1/nZALNfWWOwEwj5xNN4T
         P4pKb+j4edCTADag+/ClGk27wiTcXUmwGOFyvZMAsJpdJQhNtXtKk4k5EzdLOZm5Z3SA
         3bOpH5c/mPJNvsrsXI8Fx1+7Z5PyyZAtr5sTXG2uqNkhGSoX0uPz3WtIFRkb0OOg3VjR
         XCP9HcLMpLuh4Hy+LuEFCDCncgBm0wqZ/4T6nB6Xj7ARSd/vVCyrfql8tm/ncWB/Rki8
         T13q3ScpOeDstQBHcdhy2R64wwi0IDeFXhuuvK0ct7Qg4O320Tr5eK5F3ow4yBvFPiaw
         GB1g==
X-Forwarded-Encrypted: i=1; AHgh+Ro4C7bn+TBbtkEcTTOypo2h7yL8IwpNDeQLHITgQjveuezX9ReK//HgUHP/vySv9ZrkTxaYzg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxr+W982Q5AwOB2MgDR1mDf2cnl/G4+IQ8XhrZQZe/unAgIQoGc
	n/VqppLRoQ1Kg8MlCY06b+sG15HFrJVd+EsS3vBLQjaOmVwnbbcX8hRL
X-Gm-Gg: AfdE7ckNCwcfnokU0mFFuYWNQh9CL7Vur2Wd7zDkmMv5Mbaorg6qfkb5vTZMlpw+Ra8
	rpTxpvLJ/YT2eGtvI6pEIdZASMCGSBFiULdNRoPZAQgq/NgycdUPs1sHNoedfwqr/LyBXX9xb+k
	mo9drPntWM1p1JwFQj6n9Dpv/R/ypbVsdBiopKxCsJBrjqyAWXJTWEF7sem3u9hIgx0rwHoZck8
	fOL/FBw44NJnIVFYE7ZO3frgWJfO1HI+IyHqaMXvzqZSdCplYqc5Y0hoPOLrqenqtXNWbuHOiGK
	7BKk1S4ap8upblsN9QW74GOkCq2UioZ+71LwswG2PC83WfnhV6lQg05ANkHNc9ffLCZtTDvrRv7
	DgTSgyxZ/KE2O0vyrZuPGnWuNbjQd0UIAJLGY8fagYe5PTxzAGLIfMR13YP8Czl0OCusrc3yx7E
	OP7jU7bIldLmyS460/IoJRFngYdTct/KDV5MNH20gabhC7sIcAY1albJy/RMWRBlK3aXrkK6M=
X-Received: by 2002:a17:903:1b0f:b0:2c9:c95e:5836 with SMTP id d9443c01a7336-2ccea2a5748mr105552515ad.5.1783663520722;
        Thu, 09 Jul 2026 23:05:20 -0700 (PDT)
Received: from ubuntu-gnu-linux-24-04-3.hub ([2407:7000:af23:3e00:61b7:bd9d:8d64:1bac])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bdb76asm56314635ad.12.2026.07.09.23.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 23:05:19 -0700 (PDT)
From: Jiaxing Hu <huhuvmb88@gmail.com>
To: Heiko Stuebner <heiko@sntech.de>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/rockchip: implement .flush_iotlb_all
Date: Fri, 10 Jul 2026 18:05:13 +1200
Message-ID: <20260710060513.863714-1-huhuvmb88@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rk_iommu invalidates the IOTLB synchronously in .unmap (via
rk_iommu_zap_iova), so it stays consistent without a deferred .iotlb_sync
and does not advertise IOMMU_CAP_DEFERRED_FLUSH.

It never implemented the optional .flush_iotlb_all op, though, and
iommu_flush_iotlb_all() is a no-op when that op is absent -- so on Rockchip
a driver that owns an rk_iommu domain and calls it to flush the whole
domain's TLB (e.g. before reusing a mapping, without unmapping it) gets
nothing, even though the hardware can do it: rk_iommu already issues
ZAP_CACHE for range shootdowns.

Implement it with that same primitive: ZAP_CACHE every bank of every IOMMU
on the domain, under the runtime-PM + clk guard already used by
rk_iommu_zap_iova().

Found while bringing up an out-of-tree RK3576 NPU (accel/rocket) driver
that flushes before each submit; on Rockchip that flush did nothing.

Signed-off-by: Jiaxing Hu <huhuvmb88@gmail.com>
---
diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -1202,6 +1202,30 @@
 	return 0;
 }
 
+/* shootdown the entire tlb on all iommus using this domain */
+static void rk_iommu_flush_iotlb_all(struct iommu_domain *domain)
+{
+	struct rk_iommu_domain *rk_domain = to_rk_domain(domain);
+	struct list_head *pos;
+	unsigned long flags;
+
+	spin_lock_irqsave(&rk_domain->iommus_lock, flags);
+	list_for_each(pos, &rk_domain->iommus) {
+		struct rk_iommu *iommu = list_entry(pos, struct rk_iommu, node);
+		int ret = pm_runtime_get_if_in_use(iommu->dev);
+
+		if (WARN_ON_ONCE(ret < 0))
+			continue;
+		if (ret) {
+			WARN_ON(clk_bulk_enable(iommu->num_clocks, iommu->clocks));
+			rk_iommu_command(iommu, RK_MMU_CMD_ZAP_CACHE);
+			clk_bulk_disable(iommu->num_clocks, iommu->clocks);
+			pm_runtime_put(iommu->dev);
+		}
+	}
+	spin_unlock_irqrestore(&rk_domain->iommus_lock, flags);
+}
+
 static const struct iommu_ops rk_iommu_ops = {
 	.identity_domain = &rk_identity_domain,
 	.domain_alloc_paging = rk_iommu_domain_alloc_paging,
@@ -1214,6 +1245,7 @@
 		.map_pages	= rk_iommu_map,
 		.unmap_pages	= rk_iommu_unmap,
 		.iova_to_phys	= rk_iommu_iova_to_phys,
+		.flush_iotlb_all = rk_iommu_flush_iotlb_all,
 		.free		= rk_iommu_domain_free,
 	}
 };
