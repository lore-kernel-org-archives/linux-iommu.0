Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162A32D5959
	for <iommu@lists.linux.dev>; Fri, 28 Nov 2025 07:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764314081; cv=none; b=eI1o4wimUQt5jqhuJj4tN7dP17gVV7VhzOqovSawzV7hq+T8CrW3HNwKasKL2ky8/iGVWaoCdfeFSXVNkD6OJQPepHRGHnN/BPNHjICExrji9rNKeiZudcYUuR+caP1m6MzE2m5bAhEGXpyQCAbA7ju9WMppx3MLoppO4lXz/Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764314081; c=relaxed/simple;
	bh=XqwFJKKGSF/A+veq+3NwtTC/uUIoZoJY8eUi10dvx7M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=XESVqCA4BGI/8mbga2KYOCwfi7SGSxweCPE6ZlnScOWoPr8soSq/y+atpuU54NMOVmSHrAhpkU/Il+foTh2YQaf43gPkd9CUE65wJjiCzidoF/YoEsIntAVlnwQB+MlqwSvLqkOLkD++6An9lQhu+nJXc42rk7oomeEI4DgQx94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com; spf=pass smtp.mailfrom=airkyi.com; dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b=Ze6jWRb9; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airkyi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b="Ze6jWRb9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
	s=altu2504; t=1764314020;
	bh=bU/9WUN/59AwNz4ANd+6SuKrCznrmNWalFyjyHF+iy4=;
	h=From:To:Subject:Date:Message-Id;
	b=Ze6jWRb93FJx/CiONmnRZj5punv5hEDHVO5mtuVQqidhqHFNYjUBJJUoA/l8HIWdZ
	 9wBstNeh//T3/vTXhI3eoZBbLU6qIXxB474zspQz1jEzYrFfJO58lyNUDOGRpL/CnA
	 xsVMk4hniN+55iw19mpDutaUmVuMsYGRux3oUnus=
X-QQ-mid: zesmtpsz7t1764314012t7986102a
X-QQ-Originating-IP: fQ38+bagafd/aNZJRKe4NdW9zDnds+/df0ZWXL1qErc=
Received: from DESKTOP-8BT1A2O.localdomain ( [58.22.7.114])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 28 Nov 2025 15:13:30 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5273393561638931469
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
Subject: [PATCH v2 2/2] iommu/rockchip: Use devm_clk_bulk_get_all() to get multiple iface clock
Date: Fri, 28 Nov 2025 15:13:22 +0800
Message-Id: <20251128071322.92-3-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251128071322.92-1-kernel@airkyi.com>
References: <20251128071322.92-1-kernel@airkyi.com>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:airkyi.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MN7J+qOXnZ1LC2rHDFipWslRZlxdd8Y5acEfgMQhrlyiOCItpDRyyWi0
	ixFo8cjPuh2K0fRQyvBQhHvGVECUSuOyaRRhYIkoqU1NBeHu3ACLUQFczaghjRnqrWdVFEc
	hR1g3Bvv02+fYsmpgKXRVjjEiflTm4bst92m9GD1ZcCuB8hcq2QEbPWZFM5Mt4OBcW+Hf1m
	Jnb60QZ+HW8x5eXrbb4wfkWM7uxoN1L3TjvszvQJmB/iXeWCIppWCNROciPuxlQ5EuM1QXX
	N5Ui5OzUHosndu5LwZG5ckjPF/D8m5GnxD8cDUkS1EUcZdVO+kUbGvZbncCKaNv5e4fo1Jd
	aFzE8Ttr9eKgUXBTTcvyE+Rp4oAzcrmpa0XwqjOI7Bmk2oiZKT+rsZtE525iMzGWFB3dDYL
	YSZTTmAU8+lu47hlj9ts4948dX51AaM5D3+kkLzexgdN4Cj4DGin24K/VGFDLa3WoegXGR2
	4x/SPeN2M/e/SQDGrmhGPYWM1tzfNIIfYcMCh43xM4vGNDai6ljaSfFV+drBsqeGfvxKgMA
	6aCBNpcF8cYvTKLo+q5ZxXj5Vsr6kOXvqEjhNN+Xnxxpgtd6AzKHSKi+ZF/WV34OeamtAFa
	SVhS40j10nahZCmofiquYRzmI57apVej5GTJowxz03LwDJyOFEwr1lRNkpeEsOOBYBeB2+d
	ALsoq2O6bFCPoNLEXmedx+jCPRukthv14bveAFYrHOZm5t5d2h0Ksd5dsbN0gKX8dtTQAaB
	7eYLJx/U2ZXJkWiFohwgQGX/m5E4cbY/eE4IlZK/Je2YaIjQux44PsQ9yoaNS9bhox9rvxe
	1i9iPQ1yxxrqIjPqhHCjC0H1G8bD3W3Os3suMevE/oQW0l20Gro8BlppeSCYBnb58PvxgRg
	4ycxh39sV/Wo3TvnUfzSsZxRqmefZQ0C9ZJmC7lutJ7z+DjvVmjJQ5iDTENSHtZgcUqDGC1
	Kp4wQl2pqDR9zk/luEDqcLpz+z4/Vwt6+XbxiVmWUQecWjAD9WiBfx+lBfAxQ/3UeHMo=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

From: Chaoyi Chen <chaoyi.chen@rock-chips.com>

The iommu found on RK3576 NPU and RK3576 RKVDEC contain 4 clock.

Just use devm_clk_bulk_get_all() to get all the clocks and use them.

Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
---

Changes in v2:
- Change comment.

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

