Received: from mail-m49219.qiye.163.com (mail-m49219.qiye.163.com [45.254.49.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB4FBA33
	for <iommu@lists.linux.dev>; Mon, 23 Jun 2025 06:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750660591; cv=none; b=l1tQOiB8dKJECj63p66mQ6YbJl+LQ3/S0TSL/SCsdelgC8xjJyjd6z/SEDGjsXFtSbwpHyvdl9mmyCSoCTjnzY6ULpRe44twof2kfLtbSfmRshGlza/vSRYEym+Udry/JbuHwBhQZYh9zRLZ1bbjqQfJrE8oo12+85YWN5VC0Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750660591; c=relaxed/simple;
	bh=VwxSivKjwjgOA47M6Wx0M5ZKoTQcPBr4YKOf2YuUhDo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MoD1q+sYPS7aXwTHRwq6GPlYe71AMzhN9R2Sy8k35e6WDLpCJ4jTjc/+eTbqKpbar+tHzb2ClEMKHGMCyUYCKp40GsL+L9NUP4Q/S/AQ9o55v5PGSKFkGyHlelcaxsbIsjYDfYXtuszmtyNN2apPd9QdfT0APPNsjdEtmRwSB7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=MAHilJEr; arc=none smtp.client-ip=45.254.49.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="MAHilJEr"
Received: from xxm-vm.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 198a76e7e;
	Mon, 23 Jun 2025 10:00:24 +0800 (GMT+08:00)
From: Simon Xue <xxm@rock-chips.com>
To: joro@8bytes.org,
	will@kernel.org,
	heiko@sntech.de
Cc: robin.murphy@arm.com,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Simon Xue <xxm@rock-chips.com>
Subject: [PATCH v3] iommu/rockchip: prevent iommus dead loop when two masters share one IOMMU
Date: Mon, 23 Jun 2025 10:00:18 +0800
Message-Id: <20250623020018.584802-1-xxm@rock-chips.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250623010532.584409-1-xxm@rock-chips.com>
References: <20250623010532.584409-1-xxm@rock-chips.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0tMHVZMSkxNS01DSBgYSBlWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a979a83e4cd03ackunm95adb0ad1ba41a5
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6K1E6SSo*FjE9Hi0jOBIhATkI
	PQ9PCz9VSlVKTE5LTU9PS0lOQkxOVTMWGhIXVQMDFjsJFBgQVhgTEgsIVRgUFkVZV1kSC1lBWU5D
	VUlJVUxVSkpPWVdZCAFZQUlJTEw3Bg++
DKIM-Signature:a=rsa-sha256;
	b=MAHilJErUTQVecZJVotp/gw1fDA3axTx5qvIuwytoEuMZgBrHlkowpBfFodv0JzuAfkP/sqEvjMHB4pJArwoPlpg8uzZz8xWGdOpPdCklp1vfV0UKwdMuFEz6SjmH5glGyfGlY5BUcBmuo4pm2Ou+2SWAm3+T/J6EHZZoLpYV5E=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=NmfePvVvj/IGwECh3d25BxV8sGg50mGiW3x9goEC7jY=;
	h=date:mime-version:subject:message-id:from;

When two masters share an IOMMU, calling ops->of_xlate during
the second master's driver init may overwrite iommu->domain set
by the first. This causes the check if (iommu->domain == domain)
in rk_iommu_attach_device() to fail, resulting in the same
iommu->node being added twice to &rk_domain->iommus, which can
lead to an infinite loop in subsequent &rk_domain->iommus operations.

Cc: <stable@vger.kernel.org>
Fixes: 25c2325575cc ("iommu/rockchip: Add missing set_platform_dma_ops callback")
Signed-off-by: Simon Xue <xxm@rock-chips.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>

v3:
   Add missing `Cc: stable@vger.kernel.org` in commit message.
   No functional changes.
v2:
   No functional changes.
---
 drivers/iommu/rockchip-iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 22f74ba33a0e..e6bb3c784017 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -1157,7 +1157,6 @@ static int rk_iommu_of_xlate(struct device *dev,
 		return -ENOMEM;
 
 	data->iommu = platform_get_drvdata(iommu_dev);
-	data->iommu->domain = &rk_identity_domain;
 	dev_iommu_priv_set(dev, data);
 
 	platform_device_put(iommu_dev);
@@ -1195,6 +1194,8 @@ static int rk_iommu_probe(struct platform_device *pdev)
 	if (!iommu)
 		return -ENOMEM;
 
+	iommu->domain = &rk_identity_domain;
+
 	platform_set_drvdata(pdev, iommu);
 	iommu->dev = dev;
 	iommu->num_mmu = 0;
-- 
2.34.1

