Received: from mail-m155116.qiye.163.com (mail-m155116.qiye.163.com [101.71.155.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA6F230BFF
	for <iommu@lists.linux.dev>; Fri, 20 Jun 2025 07:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750406127; cv=none; b=cwSoZ1MVYLjYKoVSr/UTKVraTX7qTLGonHEllyqaASUF9z34U1axgiC5ZikuZBeT0J3hwPdFXwDDNoi1hyvNnO8JOu7D79DFFaHsHujH5rN+deedQ5Neb+fYNX8CZEKYWzHvhgBAEOdMYem1MY3wbcpWTZRaKIayDzMLJrLjRrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750406127; c=relaxed/simple;
	bh=w7rTv3sIl0EOEcVHEWBc/sq8wPWv37FKriyzxpLIL4U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PkVwpxYam9wJhLRtAnDI2ojO1Hrn79UgyLTpkddZa9M6xHl5SgIKwFTkp2/mFKAHajmi4p/yBZgHXj6hHtCoO/S0KlRuV0FWAc8kVKBVWS7pwp+mG5MVxBU3s7PcHcIj7nKyYTIeFnF/wYhotQlO4Gy8gT3VAtN8gnErrqMh8Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=gjphdfhh; arc=none smtp.client-ip=101.71.155.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="gjphdfhh"
Received: from xxm-vm.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 195b0d954;
	Fri, 20 Jun 2025 15:39:57 +0800 (GMT+08:00)
From: Simon Xue <xxm@rock-chips.com>
To: joro@8bytes.org,
	will@kernel.org,
	heiko@sntech.de
Cc: robin.murphy@arm.com,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Simon Xue <xxm@rock-chips.com>
Subject: [PATCH] iommu/rockchip: prevent iommus dead loop when two masters share one IOMMU
Date: Fri, 20 Jun 2025 15:39:45 +0800
Message-Id: <20250620073945.572523-1-xxm@rock-chips.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0gZTVZDTxkdTBlKGB5CT0NWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a978c47ae6e03ackunmcb7fa41f11474ac
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PRw6EAw*HjEzGisJIx4uTE5M
	KR8wCylVSlVKTE5LT0tOSkJDTUpCVTMWGhIXVQMDFjsJFBgQVhgTEgsIVRgUFkVZV1kSC1lBWU5D
	VUlJVUxVSkpPWVdZCAFZQUpDTU43Bg++
DKIM-Signature:a=rsa-sha256;
	b=gjphdfhh0nY/GJYzRcfVJLITkUA9LoiEU4bSerBb1bo+c9pCMFJkOkidlToWHQpYlOZquPRjwWiOZiqvTHhLVt12/bdOUFOMxw8xSvgaqshVn/lgJ/QqwG+b5YBpP5q+q8zub84WTJq+3wclsYsX/ij5L4BT7MMm8nv66xVyKGU=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=MIAoOLarClJnlNEVDtXTBGL5MPjZ94Xdyikr6suQV3Y=;
	h=date:mime-version:subject:message-id:from;

When two masters share an IOMMU, calling ops->of_xlate during
the second master's driver init may overwrite iommu->domain set
by the first. This causes the check if (iommu->domain == domain)
in rk_iommu_attach_device() to fail, resulting in the same
iommu->node being added twice to &rk_domain->iommus, which can
lead to an infinite loop in subsequent &rk_domain->iommus operations.

Signed-off-by: Simon Xue <xxm@rock-chips.com>
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

