Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DE536A34D
	for <iommu@lists.linux.dev>; Thu, 17 Sep 2026 05:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789623067; cv=none; b=GidCpwbX2560a8yQK/x2bsPq+r/RvQH8j5eLg+YE0rQYPCU+zR9nbrOsSDWU7nNtASjSWypRB4kBu4ntTkDgt+n2r+zQs9TGItOYkLcq58V84xe1J/a+cHhFP5jemfJELemNH8HsfrNW9qh9AaYpT9wnBbMXeQ4Y5uM96jMU4N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789623067; c=relaxed/simple;
	bh=KS2bchW86fmUgRGNdiT4TDUB0HuDXAJFFNlI1MDsanM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DIkFbp7A3Ox3becjUtRQeQ5fp4fEt3ZBboxLPeFn+n2MWBW1pVAo1sAqoZLXDwASv++u5+1WyQ5+H2gR33My/pJdPigfC3PUxJ3DLShqCJS+wuUcwkMQTJ6fs2EQ1JoPJpo/KG3r3EWjsotrFEmFhKKdJNJmEhU+ccnBBga39DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=oJkj6VtL; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="oJkj6VtL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=FT
	Pqg6M8Ko+eWA1x4uzY034xIoexgUFIOYMQiyIO0Kc=; b=oJkj6VtL70kUeVhAOm
	QvilvnZErYcMQWnXdEHBjpgHlsk3BYXadAVxmUJCKHflqo4V5WE3xqPGVDhU0VbE
	uu5RYAfzmUSgzlAGMhs2R3C6DwwriGOuqUkFWsQi/gJeSoEUPYajWJd64uN66rW6
	mmzRw1cWg5pvWwgJa+XCuUnEk=
Received: from dfae2b116770.home.arpa (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgDHr5rqeqtqolkDPg--.25683S2;
	Thu, 17 Sep 2026 13:30:20 +0800 (CST)
From: Wentao Liang <wentao_liang_g@163.com>
To: heiko@sntech.de
Cc: iommu@lists.linux.dev,
	jeffy.chen@rock-chips.com,
	joro@8bytes.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	robin.murphy@arm.com,
	will@kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] iommu/rockchip: Fix platform device reference leak in rk_iommu_of_xlate()
Date: Thu, 17 Sep 2026 05:30:15 +0000
Message-Id: <20260917053015.2133503-1-wentao_liang_g@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgDHr5rqeqtqolkDPg--.25683S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtFWkXrWrZF43JryDXFWfuFg_yoWktFb_W3
	W09rnrWr40yFs0kr1jq34I9rZ7K3ZI9r4xXayUK3Wftr98Wr1I9r1rXrs8Ja9rWw4j9F9r
	trykCr4fG347WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8OBMtUUUUU==
X-CM-SenderInfo: xzhq3t5rboxtpqjbwqqrwthudrp/xtbC7A1fjmqreu0tPQAA32

From: Wentao Liang <vulab@iscas.ac.cn>

of_find_device_by_node() returns the platform device with an elevated
reference count, which is dropped on the success path only.  If the
devm_kzalloc() for the per-device data fails, the error return leaks
that reference.

Put the device reference on the error path too.

Fixes: 5fd577c3eac3 ("iommu/rockchip: Use OF_IOMMU to attach devices automatically")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/iommu/rockchip-iommu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 0013cf196c57..05a4fa227847 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -1165,8 +1165,10 @@ static int rk_iommu_of_xlate(struct device *dev,
 	iommu_dev = of_find_device_by_node(args->np);
 
 	data = devm_kzalloc(&iommu_dev->dev, sizeof(*data), GFP_KERNEL);
-	if (!data)
+	if (!data) {
+		platform_device_put(iommu_dev);
 		return -ENOMEM;
+	}
 
 	data->iommu = platform_get_drvdata(iommu_dev);
 	dev_iommu_priv_set(dev, data);
-- 
2.34.1

