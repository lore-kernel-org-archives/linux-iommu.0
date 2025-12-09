Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FD623D7DD
	for <iommu@lists.linux.dev>; Tue,  9 Dec 2025 11:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765280061; cv=none; b=R+L/fTdJzJF8+1ZK5DtGHWNQnAAEIPHWHNlxYz9Mq6xtsrdjnbXXSImMKlVN+ITQWxmAo3flyIcszYfj9MQ5cwcxpSpMV2UQzfCK0ugQBbXBgN3i8yl3RCGXIYsIm2u+NkKNxKikJRkMbZBMflqPRvrOrOJTT9Jh7I/7Rl1bHpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765280061; c=relaxed/simple;
	bh=1SWQ0MzRC5/B4gA/2HaYbZzX4Dkr/GDJ3cpr7aFnYHI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kpbMa4w6nER/sDuCSMNcx4AAcwWHCZoqCAT/wt6+eOKS1ADTEsTJen1XW1bLUOHlds27VoOs2DdDvKUrHmvZsEdlmsqEwNbhXxgNwdMz217JVrHHgCY4Jams4RJIG3Zjoy5STgLCTiq4j0dUvJJiCZdHjXMkbs1b11k+s5fdveE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from DESKTOP-L0HPE2S (unknown [124.16.141.245])
	by APP-01 (Coremail) with SMTP id qwCowAAn0m0kCThpIsQYAA--.10785S2;
	Tue, 09 Dec 2025 19:33:58 +0800 (CST)
From: Haotian Zhang <vulab@iscas.ac.cn>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Haotian Zhang <vulab@iscas.ac.cn>
Subject: [PATCH] iommu/rockchip: Check of_find_device_by_node() return value
Date: Tue,  9 Dec 2025 19:33:32 +0800
Message-ID: <20251209113333.1086-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAAn0m0kCThpIsQYAA--.10785S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZw47tw4xWF1xXr45JFW5KFg_yoWDGrXEgw
	18ZrnxXr40yFsYkw1qq3429r90kwnFvF13XFWxKw1rtr4DWr4xuryF9rn8XrWUWa12kFy7
	tFy29a1fCa4UWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbcAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
	1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
	cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8Jw
	ACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_Jw0_
	GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
	42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwoLA2k35vdwGgAAsg

rk_iommu_of_xlate() calls of_find_device_by_node() without
verifying it is non-NULL, which can lead to a NULL pointer
dereference and crash.

Add a check for a NULL return from of_find_device_by_node()
and return -ENODEV upon failure.

Fixes: 5fd577c3eac3 ("iommu/rockchip: Use OF_IOMMU to attach devices automatically")
Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
---
 drivers/iommu/rockchip-iommu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 0861dd469bd8..e59d0617574b 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -1153,6 +1153,8 @@ static int rk_iommu_of_xlate(struct device *dev,
 	struct rk_iommudata *data;
 
 	iommu_dev = of_find_device_by_node(args->np);
+	if (!iommu_dev)
+		return -ENODEV;
 
 	data = devm_kzalloc(&iommu_dev->dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
-- 
2.50.1.windows.1

