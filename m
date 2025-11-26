Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6B9307AC6
	for <iommu@lists.linux.dev>; Wed, 26 Nov 2025 08:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764146097; cv=none; b=ioKZT/tIQYV4jhJbqundiXBTzzuicfH0QzJMnrTsCaAknvW1GtQSx7XHAIdyj8Z8kDCUMG60xApKUXmmaeY5lnKGKDjjEoYnumkivKgK+M7Ea2ToMJJtMhAJiPp0FCWIvgwO+X0HyCmBolxiZ5C9UDqhDMW6/uQ7u+zzagf/7t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764146097; c=relaxed/simple;
	bh=aTRfWTyi12QLcpVmaAc3UC+SdMqOwRCTQlt0tHus5LQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=rLFzafKmi8GNBCle/u7bqSnq8+smoE7O/9vqtly+63yZb5Jdba941B5ObdiTktxDtpnB8mDcaQyMg8WMOdMHrgHGgTwsfsAXgOHp4Gm9BBOcLqioLkOm751f6FWNwaTbVRrusRwQQRMBwIvh/rLPFnVU+4HO0LrF4LcH0qfD6dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com; spf=pass smtp.mailfrom=airkyi.com; dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b=E2/h1++Y; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airkyi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b="E2/h1++Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
	s=altu2504; t=1764146044;
	bh=qROQ1d/rJ3p9sDL8V6Cw/YwOWZVH09EJvhZr2XOPZ2A=;
	h=From:To:Subject:Date:Message-Id;
	b=E2/h1++YULHdjY5YOKGyk/EPOVmE6TzCc4f9fcIQ7TU6U0q52/eUlDPozwrjLjcQv
	 pvdJt3T/izXbtLi48r8/6meB6SDzr+TOu8AFFWNYDUtmj08i8BjTeA9eDED0WRp3Zn
	 rCCZpHYb2PlnAwd23yeqNC+VnGDPwSogUfsvaTbI=
X-QQ-mid: zesmtpgz4t1764146035tf6f1de73
X-QQ-Originating-IP: hZmGDUB5pWL4vwPmhqVG5XW5MaCy4rmE9lT7izAS3qE=
Received: from DESKTOP-8BT1A2O.localdomain ( [58.22.7.114])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 26 Nov 2025 16:33:54 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10528656724047944160
From: Chaoyi Chen <kernel@airkyi.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Chaoyi Chen <chaoyi.chen@rock-chips.com>
Subject: [PATCH 2/2] iommu/rockchip: Use devm_clk_bulk_get_all() to get multiple iface clock
Date: Wed, 26 Nov 2025 16:33:45 +0800
Message-Id: <20251126083345.88-3-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251126083345.88-1-kernel@airkyi.com>
References: <20251126083345.88-1-kernel@airkyi.com>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:airkyi.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: OK8k06hE7wrVfPkY59X0+/pI54ixdz8xGGg68ftZJ02MKwNzDqLg4MgZ
	UOvu1NYTsoBhJBUxZN9D6BquILYX+KFTD7gRi+Bra9lYkuabeVF2BaNbFosc8pXeY5Gfo7Y
	6zD2YYGMJlz4e2b86XgKVtlacH5chUk+2IKA9uLgtTtO81jLvF7DcAw1oLzjfgOvMVJx7FQ
	6LWh8i3s3ET9OXCqyD4fBwIHGvWZy/ewtwMwI9JsUn7wRVa/oU0QgRQeyVx5+WlhMcIAUCh
	m+VAgeRBPj1USwFd9Dc/xFIpLxuU1q/LXsejEFekCITdY+zUgAbFtO20kgHJUwrU428Ebjg
	jC9QQQNPSQVbwFpGW67jAqzxWFfaPAhlIx/79Wo1ihbO36tePNPYQrbi8taG5LtXR4r+eZM
	nVEVzK3xvVN8cYDfdOnD2enmneuIM39aV8HZMSkJ0IMqjIbMsgyiT1QTy+lQUvGQu4VHWVc
	6IdSKBdJ7Z6icULJFAnDBvAKxY8aD1JXcxN4fBf3x/Ijw9Gl2Y6xRuAeojIqi0BfSIxOphk
	VrA+j/VnFEsUOPpIbh/O9MkBh8Uh3czS7I90jrkxSFdpagpI+p8+XAmSKcw0ANnC73lH6yZ
	Go6wuEZ6ZnJUhkXLuBCsZKjOXgsxlTIOyiGUJusP69hqXekrHIghCYAEhbITALGv1QfaE5E
	SGWHBZ6VUi3kO7wU2OS4FveX4OUwfCeJEA01DKSYA9uJY9L/GzFr+a9CNnbmwaS+qU6TAdL
	jSRDqF+TQnbQXpMglND4gZb0As3QaeFWG8nycNyOXTWkS78TD1dVBmOBLgyMIgyb+H1P0bQ
	xQiLtBDolWxZP7uGc6Ca8IHRJUrIK5foNkTfFWQq8RbpFni0fjmGU+I30UniUDCDjcD3JiA
	DjpWgDL2qIWUWGTgRc7HwgBbzHrPzVD01vGvSCmpaEWIwP5+Cwi0gk5jhnrRyuGcL3X0MKm
	LVlYw/d+efzAMbOHOAMRfT7bg7hZ2Z8Gs9cE=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

From: Chaoyi Chen <chaoyi.chen@rock-chips.com>

The iommu found on RK3576 NPU/RKVDEC may contains more than one
interface clock.

Just use devm_clk_bulk_get_all() to get all the clocks and use them.

Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
---
 drivers/iommu/rockchip-iommu.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 0861dd469bd8..76f71fb679f8 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -93,11 +93,6 @@ struct rk_iommu_domain {
 	struct iommu_domain domain;
 };
 
-/* list of clocks required by IOMMU */
-static const char * const rk_iommu_clocks[] = {
-	"aclk", "iface",
-};
-
 struct rk_iommu_ops {
 	phys_addr_t (*pt_address)(u32 dte);
 	u32 (*mk_dtentries)(dma_addr_t pt_dma);
@@ -1236,25 +1231,18 @@ static int rk_iommu_probe(struct platform_device *pdev)
 	iommu->reset_disabled = device_property_read_bool(dev,
 					"rockchip,disable-mmu-reset");
 
-	iommu->num_clocks = ARRAY_SIZE(rk_iommu_clocks);
-	iommu->clocks = devm_kcalloc(iommu->dev, iommu->num_clocks,
-				     sizeof(*iommu->clocks), GFP_KERNEL);
-	if (!iommu->clocks)
-		return -ENOMEM;
-
-	for (i = 0; i < iommu->num_clocks; ++i)
-		iommu->clocks[i].id = rk_iommu_clocks[i];
-
 	/*
 	 * iommu clocks should be present for all new devices and devicetrees
 	 * but there are older devicetrees without clocks out in the wild.
 	 * So clocks as optional for the time being.
 	 */
-	err = devm_clk_bulk_get(iommu->dev, iommu->num_clocks, iommu->clocks);
+	err = devm_clk_bulk_get_all(dev, &iommu->clocks);
 	if (err == -ENOENT)
 		iommu->num_clocks = 0;
-	else if (err)
+	else if (err < 0)
 		return err;
+	else
+		iommu->num_clocks = err;
 
 	err = clk_bulk_prepare(iommu->num_clocks, iommu->clocks);
 	if (err)
-- 
2.51.1

