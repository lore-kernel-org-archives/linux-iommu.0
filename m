Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8952E4C72
	for <iommu@lists.linux.dev>; Wed, 19 Oct 2022 17:23:20 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7707A1424;
	Wed, 19 Oct 2022 10:23:20 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 54BFB3F7D8;
	Wed, 19 Oct 2022 10:23:13 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: thierry.reding@gmail.com
Cc: dri-devel@lists.freedesktop.org,
	linux-tegra@vger.kernel.or,
	iommu@lists.linux.dev,
	Jon Hunter <jonathanh@nvidia.com>,
	Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH] gpu: host1x: Avoid trying to use GART on Tegra20
Date: Wed, 19 Oct 2022 18:23:07 +0100
Message-Id: <ee0278cae0443d4ff407d6db38f4d9b33d477e8f.1666200021.git.robin.murphy@arm.com>
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
 drivers/gpu/host1x/dev.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/host1x/dev.c b/drivers/gpu/host1x/dev.c
index a13fd9441edc..1cae8eea92cf 100644
--- a/drivers/gpu/host1x/dev.c
+++ b/drivers/gpu/host1x/dev.c
@@ -352,6 +352,10 @@ static struct iommu_domain *host1x_iommu_attach(struct host1x *host)
 	if (!host1x_wants_iommu(host) || domain)
 		return domain;
 
+	/* Our IOMMU usage policy doesn't currently play well with GART */
+	if (of_machine_is_compatible("nvidia,tegra20"))
+		return NULL;
+
 	host->group = iommu_group_get(host->dev);
 	if (host->group) {
 		struct iommu_domain_geometry *geometry;
-- 
2.36.1.dirty

