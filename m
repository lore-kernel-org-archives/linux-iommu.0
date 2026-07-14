Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9450F3D6CA6
	for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 06:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784009430; cv=none; b=DGO6nT0E/sO4aeN6DZOaokWasIU2ra2VC4aSzRbcaOg4gzsS9K5zQuz7yDhj056OH5FGfwdkTNhmAacSUcrNZKtNVQnWnjKekkTp93wrbTVEC2Ew7hHVPk3zlr8IxW22PGea5zkHg1i6MMqk4/AJ1cBJuLXvl19nN0Dk+YhA6hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784009430; c=relaxed/simple;
	bh=CbzYCqfUOj4SifOJuD5PCQjjfoR5mDCOVqJzrEwDTU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sLv+atKj/jpYhipP4SSYDXf+LPzTnl0WZ9VMEwVCBMgZRAmgiXf7ebQE7Pl4pVfgEXUcHdTs0O+/PxHBMiaV5uQrx1N2SBFxO4Ho4vSrPQP6rTSSvRT3rCE7uVRubanwUM2yiWrylDi4/0eoee6elMXGKu0fIAoZDMhcAd6/bjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=eAVwSu2R; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="eAVwSu2R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Qg
	KBOpsQ6v0plaOyS+PBWO+c7M1uIEDREuFLY6J4zik=; b=eAVwSu2R1PeW98TO1z
	HbKR78s3Gp2nH32r/6OXX2wxmQXBkkFuPfbaEg8n8+L7WLyA18yG3ZhgvNPSRkC0
	P5lN1Lxdfp8vwGxv2Ziz6R/yuEMAwwdFeqkwnnXiwSOBh8opXdsDuXJwc9VfTDUm
	7rk8iTcMKZWoHYD870tzUMsxw=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgAnwyab0lVqrG_HHA--.5129S6;
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
Subject: [PATCH v1 4/4] iommu/msm: Clean up probe state on registration failure
Date: Tue, 14 Jul 2026 14:09:30 +0800
Message-ID: <20260714060930.220277-5-xiongwm2026@163.com>
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
X-CM-TRANSID:PygvCgAnwyab0lVqrG_HHA--.5129S6
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ww48JFy3tF4kCFW5ZFW7CFg_yoW8XrWxpF
	47W3909r1kK3WfKF47AF18uFn0krZFya45uF4fWa9F9r15ArWUXFZ3KFW5tr45GrWkGa17
	Aay3Jr4S9F15Cr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UVlk3UUUUU=
X-CM-SenderInfo: x0lr0wdzpsijqw6rljoofrz/xtbCzgzPX2pV0qyd1wAA3Z

msm_iommu_probe() adds the IOMMU to qcom_iommu_devices before creating
the IOMMU sysfs device and registering the IOMMU. If either of those
later steps fails, the function returns without undoing the list
insertion. The iommu_device_register() failure path also leaves the
sysfs device behind.

Add shared error labels so the list entry and sysfs device are unwound
in the reverse order of setup.

Signed-off-by: weimin xiong <xiongwm2026@163.com>
---
 drivers/iommu/msm_iommu.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index 0ad5ff431..d0d926be7 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -784,19 +784,25 @@ static int msm_iommu_probe(struct platform_device *pdev)
 				     "msm-smmu.%pa", &ioaddr);
 	if (ret) {
 		pr_err("Could not add msm-smmu at %pa to sysfs\n", &ioaddr);
-		return ret;
+		goto err_remove_list;
 	}
 
 	ret = iommu_device_register(&iommu->iommu, &msm_iommu_ops, &pdev->dev);
 	if (ret) {
 		pr_err("Could not register msm-smmu at %pa\n", &ioaddr);
-		return ret;
+		goto err_remove_sysfs;
 	}
 
 	pr_info("device mapped at %p, irq %d with %d ctx banks\n",
 		iommu->base, iommu->irq, iommu->ncb);
 
 	return ret;
+
+err_remove_sysfs:
+	iommu_device_sysfs_remove(&iommu->iommu);
+err_remove_list:
+	list_del(&iommu->dev_node);
+	return ret;
 }
 
 static const struct of_device_id msm_iommu_dt_match[] = {
-- 
2.43.0

