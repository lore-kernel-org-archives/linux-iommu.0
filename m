Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5062563
	for <iommu@lists.linux.dev>; Thu,  7 Jul 2022 17:30:49 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B94261063;
	Thu,  7 Jul 2022 10:30:49 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8EF243F792;
	Thu,  7 Jul 2022 10:30:48 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: thierry.reding@gmail.com,
	mperttunen@nvidia.com
Cc: iommu@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH] gpu: host1x: Register context bus unconditionally
Date: Thu,  7 Jul 2022 18:30:44 +0100
Message-Id: <503bffe670b24aac0dfb03c8fc16437b8f0cca58.1657215044.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.36.1.dirty
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Conditional registration is a problem for other subsystems which may
unwittingly try to interact with host1x_context_device_bus_type in an
uninitialised state on non-Tegra platforms. A look under /sys/bus on a
typical system already reveals plenty of entries from enabled but
otherwise irrelevant configs, so lets keep things simple and register
our context bus unconditionally too.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/gpu/host1x/context_bus.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/host1x/context_bus.c b/drivers/gpu/host1x/context_bus.c
index b0d35b2bbe89..d9421179d7b4 100644
--- a/drivers/gpu/host1x/context_bus.c
+++ b/drivers/gpu/host1x/context_bus.c
@@ -15,11 +15,6 @@ static int __init host1x_context_device_bus_init(void)
 {
 	int err;
 
-	if (!of_machine_is_compatible("nvidia,tegra186") &&
-	    !of_machine_is_compatible("nvidia,tegra194") &&
-	    !of_machine_is_compatible("nvidia,tegra234"))
-		return 0;
-
 	err = bus_register(&host1x_context_device_bus_type);
 	if (err < 0) {
 		pr_err("bus type registration failed: %d\n", err);
-- 
2.36.1.dirty

