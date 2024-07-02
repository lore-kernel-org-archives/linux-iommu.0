Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59CE8155741
	for <iommu@lists.linux.dev>; Tue,  2 Jul 2024 11:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719920465; cv=none; b=rWRzm2MERs/pHH8qVOwmY2VOy3LFwDRHdjJ5c3NXpTkgo34W2/LmG1Msr7mMYP2dKhUuvYBp2ai6Pfg9C1BOlQWewtQP550Km0jx9NQs/z2mn8GdE/8eUXhdeDY7ysBOdi+O7aNTFM/jodB92OQBgpnpbLGaydQJDBlDLXQ4XSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719920465; c=relaxed/simple;
	bh=MazqkPQLGCdEENp3CH5TVyh893tKDOXYUhdGCU9mDSA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=frqE257Q2svs2W/rn7+WtlcWsMBdzDj3apEC/NDnBqtB0kRFVfa/Gqzo198FA4czQErTG2VgJpQ4LFiHFjlDc3j8iPpMWMJzQ7vkvQnQ/rhBPhy65ZUrrtDV8HgJf0MuYcinpGzFRMTLvuifAe/rTMvc1Gts1NbHXyS8KXxQFxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A2A88339;
	Tue,  2 Jul 2024 04:41:26 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1E7473F762;
	Tue,  2 Jul 2024 04:40:58 -0700 (PDT)
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
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Yong Wu <yong.wu@mediatek.com>
Subject: [PATCH v3 0/5] iommu: Remove iommu_fwspec ops
Date: Tue,  2 Jul 2024 12:40:46 +0100
Message-Id: <cover.1719919669.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2: https://lore.kernel.org/linux-iommu/cover.1718994350.git.robin.murphy@arm.com/

Hi all,

Just a quick update with an extra patch to avoid the mediatek-v1 driver
breaking (and I have now build-tested ARCH=arm to make sure, apologies
for being lazy before...)

Thanks,
Robin.


Robin Murphy (5):
  iommu/mediatek-v1: Clean up redundant fwspec checks
  iommu: Resolve fwspec ops automatically
  ACPI: Retire acpi_iommu_fwspec_ops()
  OF: Simplify of_iommu_configure()
  iommu: Remove iommu_fwspec ops

 drivers/acpi/arm64/iort.c             | 19 +++-------
 drivers/acpi/scan.c                   | 36 +++++--------------
 drivers/acpi/viot.c                   | 11 ++----
 drivers/iommu/arm/arm-smmu/arm-smmu.c |  3 +-
 drivers/iommu/iommu-priv.h            |  7 ++++
 drivers/iommu/iommu.c                 | 20 +++++------
 drivers/iommu/mtk_iommu_v1.c          | 12 ++-----
 drivers/iommu/of_iommu.c              | 50 ++++++++++-----------------
 drivers/iommu/tegra-smmu.c            |  2 +-
 drivers/of/device.c                   | 30 ++++++----------
 include/acpi/acpi_bus.h               |  3 +-
 include/linux/iommu.h                 | 15 ++------
 12 files changed, 67 insertions(+), 141 deletions(-)

-- 
2.39.2.101.g768bb238c484.dirty

