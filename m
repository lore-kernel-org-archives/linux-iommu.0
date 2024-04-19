Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C9713B29D
	for <iommu@lists.linux.dev>; Fri, 19 Apr 2024 16:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713545787; cv=none; b=tOwYr3wA9Qrtx3hZH/7K+GHD4NLuoz8kBlVtEmachKUZI0b4uq/EY/68JQ9sNNqTNuFWDSgL9hQedN6w4SO8RZdh8/0zHsiZgCn6ixI2Ws0g0mzP35ADlUR34+PoLU57yxiDyoNU5RLwmnayANPiCWcFVIUWUKBqoUoXZpdQyzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713545787; c=relaxed/simple;
	bh=9vJmXub9OrgT6L5kb/8WNFjDJmz7ntnxuiLA629DI10=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dU8KSx7hrDi3xvnjMzsuPltYK20Mc/XxI/9LUqpt2KlFYZYDCURuRfek2WeKsDo0wkyHfnB9vg0Vj2CfYiDVfybML5E8ZjwEtHlfouYINLbV7A8MdBG8LVyy+PYEomdmqwjWbiX0hjbrG5+dOS2gH1f/4EO4kEn4XcqNNXNp3fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F185106F;
	Fri, 19 Apr 2024 09:56:54 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EE49D3F792;
	Fri, 19 Apr 2024 09:56:23 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>
Cc: linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH 2/4] ACPI: Retire acpi_iommu_fwspec_ops()
Date: Fri, 19 Apr 2024 17:56:00 +0100
Message-Id: <3ae004dfc581fa12fc9432c5008f1225882d5464.1713523251.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
In-Reply-To: <cover.1713523251.git.robin.murphy@arm.com>
References: <cover.1713523251.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that iommu_fwspec_init() can signal for probe deferral directly,
acpi_iommu_fwspec_ops() is unneeded and can be cleaned up.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/acpi/scan.c | 30 ++++++------------------------
 1 file changed, 6 insertions(+), 24 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 9d36fc3dc5ac..d6b64dcbf9a6 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1588,26 +1588,14 @@ int acpi_iommu_fwspec_init(struct device *dev, u32 id,
 	return ret;
 }
 
-static inline const struct iommu_ops *acpi_iommu_fwspec_ops(struct device *dev)
-{
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
-
-	return fwspec ? fwspec->ops : NULL;
-}
-
 static int acpi_iommu_configure_id(struct device *dev, const u32 *id_in)
 {
 	int err;
-	const struct iommu_ops *ops;
 
 	/* Serialise to make dev->iommu stable under our potential fwspec */
 	mutex_lock(&iommu_probe_device_lock);
-	/*
-	 * If we already translated the fwspec there is nothing left to do,
-	 * return the iommu_ops.
-	 */
-	ops = acpi_iommu_fwspec_ops(dev);
-	if (ops) {
+	/* If we already translated the fwspec there is nothing left to do */
+	if (dev_iommu_fwspec_get(dev)) {
 		mutex_unlock(&iommu_probe_device_lock);
 		return 0;
 	}
@@ -1624,16 +1612,7 @@ static int acpi_iommu_configure_id(struct device *dev, const u32 *id_in)
 	if (!err && dev->bus)
 		err = iommu_probe_device(dev);
 
-	/* Ignore all other errors apart from EPROBE_DEFER */
-	if (err == -EPROBE_DEFER) {
-		return err;
-	} else if (err) {
-		dev_dbg(dev, "Adding to IOMMU failed: %d\n", err);
-		return -ENODEV;
-	}
-	if (!acpi_iommu_fwspec_ops(dev))
-		return -ENODEV;
-	return 0;
+	return err;
 }
 
 #else /* !CONFIG_IOMMU_API */
@@ -1672,6 +1651,9 @@ int acpi_dma_configure_id(struct device *dev, enum dev_dma_attr attr,
 	ret = acpi_iommu_configure_id(dev, input_id);
 	if (ret == -EPROBE_DEFER)
 		return -EPROBE_DEFER;
+	/* Ignore all other errors apart from EPROBE_DEFER */
+	if (ret)
+		dev_dbg(dev, "Adding to IOMMU failed: %d\n", ret);
 
 	arch_setup_dma_ops(dev, attr == DEV_DMA_COHERENT);
 
-- 
2.39.2.101.g768bb238c484.dirty

