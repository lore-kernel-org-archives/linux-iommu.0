Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C22D21D589
	for <iommu@lists.linux.dev>; Thu,  5 Dec 2024 16:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733416460; cv=none; b=Z5AeiCKvon8y7KA9Aniu3o/kQ6cwDri35JjSIsfge7SrrCgBd3c2cVYajMGXKSxSdk85SFexMxjS8OErvGgRDknl7msFBrFkLK703HTxpNnWa76X/BjZwzF0GvfSyODbLdmhYKT/HHp+GnuvQRsg45tGuTDcgfl6JBLEyHo8hrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733416460; c=relaxed/simple;
	bh=3U7lAM0rMmpGrB6Jqv9n/6KMoH5VYDtV8K59QdpuITc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mUfb55nPaSgypsEhEyffoWjyAE3Csxn9NVSu4I/ZBxoF9B4I8rHSLyZg+6jETA3A+gYANXprAfmavkKAgS5pHWaq8Czy0D+zjlf1j3vAAgKRrlN5zh6jL2uoYkpb0sqGBRjwcIUXrPQkkfwacGyVDkRyii2VW8MYQVa9kcgNX3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DE6F01758;
	Thu,  5 Dec 2024 08:34:45 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 017423F5A1;
	Thu,  5 Dec 2024 08:34:16 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org,
	joro@8bytes.org
Cc: iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	quic_pbrahma@quicinc.com
Subject: [PATCH v2 4/4] iommu: Manage driver probe deferral better
Date: Thu,  5 Dec 2024 16:33:58 +0000
Message-Id: <41fa59f156ef8d196d08fa75c4901e6d4b12e6c4.1733406914.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
In-Reply-To: <cover.1733406914.git.robin.murphy@arm.com>
References: <cover.1733406914.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since iommu_fwspec_init() absorbed the basic driver probe deferral
check to wait for an IOMMU to register, we may as well handle the probe
deferral timeout there as well. The current inconsistency of callers
results in client devices deferring forever on an arm64 ACPI system
where an SMMU has failed its own driver probe.

Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v2: No change

 drivers/iommu/iommu.c    | 2 +-
 drivers/iommu/of_iommu.c | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 9bc0c74cca3c..7cd433803bd6 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2819,7 +2819,7 @@ int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode)
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 
 	if (!ops)
-		return -EPROBE_DEFER;
+		return driver_deferred_probe_check_state(dev);
 
 	if (fwspec)
 		return ops == iommu_fwspec_ops(fwspec) ? 0 : -EINVAL;
diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index e7a6a1611d19..97987cd78da9 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -29,8 +29,6 @@ static int of_iommu_xlate(struct device *dev,
 		return -ENODEV;
 
 	ret = iommu_fwspec_init(dev, of_fwnode_handle(iommu_spec->np));
-	if (ret == -EPROBE_DEFER)
-		return driver_deferred_probe_check_state(dev);
 	if (ret)
 		return ret;
 
-- 
2.39.2.101.g768bb238c484.dirty

