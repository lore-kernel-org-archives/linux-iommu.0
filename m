Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0951E2D7DD7
	for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 06:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784009425; cv=none; b=ESpI12LfbZ/MzAdg0exdh/HVx9WMj1DDQw31lClM9TeFxzyy1IGM9rm0eaYLg2LTPQuevYz3Wa4cdGqB/sTmoKsd1wSpEg91c3+Dws09pSqpiEMcP7aYGNOEOBbD3ngR8cH6/Fy32RTUm1opGMoJSJURUB9pBrgSDtTAywD8+vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784009425; c=relaxed/simple;
	bh=OK6F+QADPy1VWZWq5kaE5EqHcErchmyJYXKrGpnsvXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jr77gaV92argocOf1xjq3AxLe2FzuXH3SrZOa2iaw46vDRqOSS2dkXr79mnrEQmeg7syk/AsOZLweOxR8Doe6ktXzCam5f6FlNfhlhwE7G8fmMLn8Jn3A4ryGucqsk5mkycc18ZsVrbR2Z2PkEza9EDrq2KCbdLuWJsrxPwajv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=DdqhWYc6; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="DdqhWYc6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=dS
	Md5BPF4fYsYrSjBZEUKbIw8wpxukNBKTZpcMK3Duo=; b=DdqhWYc66UcFUgEnhy
	cf1r+XH3UNq0EIYmW8zU6iHHiZf1TLAWcUBEyJQ221DA601xIR1WzSQzIU3abw4Q
	8DBC1TkBft4NfF7z0vtaHEMl3B2MhtPkj1zWtttsII1AyGQ5hZdxbvDz91Xtkfnd
	d8OJBbnJgKXcALciSuMVeZOs8=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgAnwyab0lVqrG_HHA--.5129S3;
	Tue, 14 Jul 2026 14:09:47 +0800 (CST)
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
Subject: [PATCH v1 1/4] iommu/arm-smmu: Fix fwnode lookup lifetime handling
Date: Tue, 14 Jul 2026 14:09:27 +0800
Message-ID: <20260714060930.220277-2-xiongwm2026@163.com>
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
X-CM-TRANSID:PygvCgAnwyab0lVqrG_HHA--.5129S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7CryDZr43Ar15GF1ruw1fCrg_yoW8Xw15pF
	WUCFyYvrWUWF1jkr4DJw1rAF1Y9a10yas5CrW8C3s09w13ta45tFy8KFyagwn5CrZ5J3W3
	tr9Fq3yrCF98ArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UH6wtUUUUU=
X-CM-SenderInfo: x0lr0wdzpsijqw6rljoofrz/xtbC7wvOXmpV0qsbnwAA32

bus_find_device_by_fwnode() returns a device with its reference count
incremented. arm_smmu_get_by_fwnode() drops that reference before
reading the driver data, which leaves the returned pointer derived from
a device after its reference has been released.

Read the driver data before put_device(). Also handle a failed lookup in
arm_smmu_probe_device() before dereferencing the returned SMMU pointer.

Signed-off-by: weimin xiong <xiongwm2026@163.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 0bd21d206..b70c307b8 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -1426,9 +1426,15 @@ static
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
 
 static struct iommu_device *arm_smmu_probe_device(struct device *dev)
@@ -1451,6 +1457,10 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 			goto out_free;
 	} else {
 		smmu = arm_smmu_get_by_fwnode(fwspec->iommu_fwnode);
+		if (!smmu) {
+			ret = -ENODEV;
+			goto out_free;
+		}
 	}
 
 	ret = -EINVAL;
-- 
2.43.0

