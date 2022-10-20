Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E763C20
	for <iommu@lists.linux.dev>; Thu, 20 Oct 2022 14:23:46 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8ADCFD6E;
	Thu, 20 Oct 2022 07:23:52 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6A8213F67D;
	Thu, 20 Oct 2022 07:23:45 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: thierry.reding@gmail.com
Cc: dri-devel@lists.freedesktop.org,
	iommu@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	Jon Hunter <jonathanh@nvidia.com>,
	Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH v2] gpu: host1x: Avoid trying to use GART on Tegra20
Date: Thu, 20 Oct 2022 15:23:40 +0100
Message-Id: <39c44dce203112a8dfe279e8e2c4ad164e3cf5e5.1666275461.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.36.1.dirty
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit c7e3ca515e78 ("iommu/tegra: gart: Do not register with
bus") quite some time ago, the GART driver has effectively disabled
itself to avoid issues with the GPU driver expecting it to work in ways
that it doesn't. As of commit 57365a04c921 ("iommu: Move bus setup to
IOMMU device registration") that bodge no longer works, but really the
GPU driver should be responsible for its own behaviour anyway. Make the
workaround explicit.

Reported-by: Jon Hunter <jonathanh@nvidia.com>
Suggested-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v2: Cover DRM instance too, move into *_wants_iommu() for consistency

 drivers/gpu/drm/tegra/drm.c | 4 ++++
 drivers/gpu/host1x/dev.c    | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/tegra/drm.c b/drivers/gpu/drm/tegra/drm.c
index 6748ec1e0005..a1f909dac89a 100644
--- a/drivers/gpu/drm/tegra/drm.c
+++ b/drivers/gpu/drm/tegra/drm.c
@@ -1093,6 +1093,10 @@ static bool host1x_drm_wants_iommu(struct host1x_device *dev)
 	struct host1x *host1x = dev_get_drvdata(dev->dev.parent);
 	struct iommu_domain *domain;
 
+	/* Our IOMMU usage policy doesn't currently play well with GART */
+	if (of_machine_is_compatible("nvidia,tegra20"))
+		return false;
+
 	/*
 	 * If the Tegra DRM clients are backed by an IOMMU, push buffers are
 	 * likely to be allocated beyond the 32-bit boundary if sufficient
diff --git a/drivers/gpu/host1x/dev.c b/drivers/gpu/host1x/dev.c
index 0cd3f97e7e49..f60ea24db0ec 100644
--- a/drivers/gpu/host1x/dev.c
+++ b/drivers/gpu/host1x/dev.c
@@ -292,6 +292,10 @@ static void host1x_setup_virtualization_tables(struct host1x *host)
 
 static bool host1x_wants_iommu(struct host1x *host1x)
 {
+	/* Our IOMMU usage policy doesn't currently play well with GART */
+	if (of_machine_is_compatible("nvidia,tegra20"))
+		return false;
+
 	/*
 	 * If we support addressing a maximum of 32 bits of physical memory
 	 * and if the host1x firewall is enabled, there's no need to enable
-- 
2.36.1.dirty

