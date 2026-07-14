Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B093D6CA6
	for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 06:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784009426; cv=none; b=ltCOSMZnk0PdccT1DjsUL+5gVd/gmab3JmQChjL3BxxPBTdimw+wkCMf4v7mukRXqeURJb80vCG291igTj0JhA1BiPi2HK2DWKTz0Zi0tZ/wYBJHiUMQtgH36JnW2xT74jBtVgkStcndDHYdsM4bp+Zg94VonDwV9hECeXc1AM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784009426; c=relaxed/simple;
	bh=/zk7nGNl3dB++t62aMOiEHIuhmWOXP6KRdHJMEJHOjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ReMCwfzKuvjD/RurrHCdziSk0Xyuu97V4qZ5KZfilpezOjcgp5XY0V16R0kWyip9UhqhKdBlB9ZWG2R5mxqoHchszQfjidfPHt4OZXFI0lxFZxWAw6iqXXVE5BmPpFsh1t0s2AkUovfGjRL4EC0Py7p86vqeIF/M1tfgKTp6g00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=U+wYA/Ea; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="U+wYA/Ea"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=ZW
	71BHzQut9m5+gFs8IhfBSqnJb/qt1PIQnhKAHYDfM=; b=U+wYA/EaIbmtWiu60G
	8is+Hhskr2gPlrIcjjkeNGnGs5PSEgmQMc478N+VTetIwYyid9BRnMGeVULMHOov
	zgW1A2/dO3Dx8kMXl44k20dcnexHpGYagNm0rlfr6HPWpFZgtVfw/aU7zW3Mm8K+
	4Ix1BbjdwX7qaVp0Z8XFBktMY=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgAnwyab0lVqrG_HHA--.5129S4;
	Tue, 14 Jul 2026 14:09:48 +0800 (CST)
From: weimin xiong <xiongwm2026@163.com>
To: Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>
Cc: Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	weimin xiong <xiongwm2026@163.com>
Subject: [PATCH v1 2/4] iommu/arm-smmu-v3: Fix fwnode lookup lifetime handling
Date: Tue, 14 Jul 2026 14:09:28 +0800
Message-ID: <20260714060930.220277-3-xiongwm2026@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260714060930.220277-1-xiongwm2026@163.com>
References: <20260714060930.220277-1-xiongwm2026@163.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgAnwyab0lVqrG_HHA--.5129S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7Gr1DWr48urWrJF47JF18Zrb_yoW8JF45pa
	yUuF90kryDW3W2k3srXF1ayFy5ua1Fya4rtrW8u3s09wn5tryfGryxtF9Fgrn5CrWrJF13
	trn2q3yrCFn8ArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Ul4iUUUUUU=
X-CM-SenderInfo: x0lr0wdzpsijqw6rljoofrz/xtbCzQzPX2pV0qz4CQAA3h

bus_find_device_by_fwnode() returns a device with its reference count
incremented. arm_smmu_get_by_fwnode() drops that reference before
reading the driver data, which leaves the returned pointer derived from
a device after its reference has been released.

Read the driver data before put_device() and return NULL directly when
the lookup fails.

Signed-off-by: weimin xiong <xiongwm2026@163.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index a10affb48..ef53dd703 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3980,9 +3980,15 @@ static
 struct arm_smmu_device *arm_smmu_get_by_fwnode(struct fwnode_handle *fwnode)
 {
 	struct device *dev = bus_find_device_by_fwnode(&platform_bus_type, fwnode);
+	struct arm_smmu_device *smmu;
+
+	if (!dev)
+		return NULL;
 
+	smmu = dev_get_drvdata(dev);
 	put_device(dev);
-	return dev ? dev_get_drvdata(dev) : NULL;
+
+	return smmu;
 }
 
 static bool arm_smmu_sid_in_range(struct arm_smmu_device *smmu, u32 sid)
-- 
2.43.0

