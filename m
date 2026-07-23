Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA04B43B4BB
	for <iommu@lists.linux.dev>; Thu, 23 Jul 2026 13:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784813280; cv=none; b=AjXodEKnrNuusVW8nhKf6am/ZVoAfi3eGbBiVb45RXHwo7WBeq81GbCANde9ccppJhUikDZTlDNfSLU+p4CD4GXJRqn7WKL0vtIwb2UN6NSnJKDlNwX0EH5Hj3PWhDLKcGeEApMJgFGigK/JTQim8YDLmLzqbpBUMrdnxODWWVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784813280; c=relaxed/simple;
	bh=Nxk23UY1Kpjk1fXIJjdy4Bw070vePITbgY2X5cG2L6s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Md72/tdwLoJWIewOrNXcTo61+o+NOY1XPJ+OPQ1944fPco05QX1piAKg+lgWGvrYz2BjcsjKIuICGg+IR6foBVreylRakULMDSzlN7fS0hdK1PEm5ctMKebDT6fCPQtYuV1bXp12odRSy084OARxa5O/gC7aLYUYOXWVqQxinbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=kLVYbUv8; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="kLVYbUv8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1784813222;
	bh=lrToqYOLFhH+a37iAKtn2F1YCzMAXjDxk7/I/zejNW8=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=kLVYbUv8S31hEiEjkUjGqRJL7g2q6PIOawQpaEHNT0EoXhyyV34gQVnGL0Z+6Dc/u
	 tEbiCmcl79LS6CVpVvm3LGKPZZ+/JX9s5LhKbHJn7Cocm3NKbrfVU9ptdfGBqh6tBB
	 PQyJ9bZCTC5M0chhVZUGRXTh2h0zFvGkshKodfXk=
X-QQ-mid: esmtpgz13t1784813216t40ea92be
X-QQ-Originating-IP: lLHxSerqMQiIyDtaLEoMK+5mS6xI575gAoG/gj5UYic=
Received: from localhost.localdomain ( [1.202.39.170])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 23 Jul 2026 21:26:47 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 13695719421709608333
EX-QQ-RecipientCnt: 9
From: ZhaoJinming <zhaojinming@uniontech.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Heiko Stuebner <heiko@sntech.de>,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	ZhaoJinming <zhaojinming@uniontech.com>
Subject: [PATCH] iommu/rockchip: Fix silent probe success when all MMU resources fail
Date: Thu, 23 Jul 2026 21:26:43 +0800
Message-Id: <20260723132643.2853525-1-zhaojinming@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: M3ziZXKDk+iOfQ0hQvGGhHXfzZJ7D/54sqqKuhRYVGErTw0U0BNDLmt3
	AO3cxtQaQTbmR7ndocYm3xnx9BkKhL32SnCK29XkcGU3XaafDQH3POIi9bRPhonfFOxNWch
	HEFNnEL5hWU7d83jV3zUdSjHIqlEKEeWxaVVEkOjTA8O/Py1dqN8Nu52ws02YV1Cw9vsHjA
	ItxrhB+7CPw4Rwf43/BcAjZeV0nU95I8tFGpC+dj7W1Q5TZv10PIzKYHfqSrMyglUzejROa
	rmRjByBLDndfeN0V8VkLZyUA8QZG6CJ4u7SLT2sFGbHtrRIZbOMmOQ/d+utWQrMPqpR5EpI
	h31e6JReyo/Nmw1nh0c2I7oVWZvwul+zx33t7ZHAdm1vXyfFHP7RNLQ5RAFhEhBC1COmG6X
	IuMo4YvJNc1pW5+UWJ+e01g4RHZC1xUDcIOX1Qfo9rlpp/i4mcOwqNUKpxw0f7w3mgegv1Y
	EidcPCRS/0osBQuxrgXnauBz9Hwygt2VqHNo2LOKq/thjg/PBHEUiY8xn6MshYT2JogdAM9
	rlI/Ersv32th4sXxd6dStYfLFFVf7GP+wiFO1FN/mVM+8aCgP1DLmzqvTHhYQ0Ocycs0hZk
	fy5rJqti3ROKrG/43ZnD9F847lvSHJPeasmjerMacW5uBPDpbA003jQqvRSshar7JhVR6rW
	c2SSfdZq2wfR3YPSdMh8RSR4vME247c1aLAehP5/yA/q8+u+ShznMLHTQ7MX0J23Iv20IZZ
	DXe9QWqeevmGBLp8xwsNRSjmwXMHlk0ZHhRF5MbX9o2kh7IDRUvNuNh+RkAnPXeJlcoU7Yd
	lRWe8S54PAGC2m7GQ7dnjk3EiKjAKAihgjGqTf3r8xDD741I4HiA/GZ1nwW7kQxbg/tjoJX
	bU3z93mPQM0GLor1rwlMWYf1bHPOijKLsTRJDXD+xba14lpCfSm3qOzlkgojKfAO0y44lhd
	zPnBWkxoTCz4Zh0diqzMyx6G9lHMj3YLPM9N4bhch7uxTC593WhATyHwOA6yCm228XGnBsT
	0R/qG2hnx/2TKmtmkwjKZQQdOddBnRkgjY2/PL/BxVDTgpEKFzu5R9J9HUgCs=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

When all MMU register mappings fail in rk_iommu_probe(), the error
path returns PTR_ERR(iommu->bases[0]). However, bases[0] can be NULL
if the first platform_get_resource() also returned NULL, causing
PTR_ERR(NULL) to evaluate to 0 and the probe to succeed silently.

Return -ENODEV directly instead.

Signed-off-by: ZhaoJinming <zhaojinming@uniontech.com>
---
drivers/iommu/rockchip-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 87ae036d6414..32868ea5fa03 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -1245,7 +1245,7 @@ static int rk_iommu_probe(struct platform_device *pdev)
 		iommu->num_mmu++;
 	}
 	if (iommu->num_mmu == 0)
-		return PTR_ERR(iommu->bases[0]);
+		return -ENODEV;
 
 	iommu->num_irq = platform_irq_count(pdev);
 	if (iommu->num_irq < 0)
-- 
2.20.1
