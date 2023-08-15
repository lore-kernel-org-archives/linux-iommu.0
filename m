Received: from riemann.telenet-ops.be (riemann.telenet-ops.be [195.130.137.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAE111CB7
	for <iommu@lists.linux.dev>; Tue, 15 Aug 2023 15:46:40 +0000 (UTC)
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
	by riemann.telenet-ops.be (Postfix) with ESMTPS id 4RQFkN3Cjqz4wxSl
	for <iommu@lists.linux.dev>; Tue, 15 Aug 2023 17:37:00 +0200 (CEST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:5d0c:f209:12a7:4ce5])
	by andre.telenet-ops.be with bizsmtp
	id Zrcs2A00345ualL01rcstv; Tue, 15 Aug 2023 17:36:53 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1qVw69-000j8S-IT;
	Tue, 15 Aug 2023 17:36:52 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1qVw6F-005cq2-RQ;
	Tue, 15 Aug 2023 17:36:51 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Robin Murphy <robin.murphy@arm.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Vincent Whitchurch <vincent.whitchurch@axis.com>,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] perf: ARM_SMMU_V3_PMU should depend on ARM_SMMU_V3
Date: Tue, 15 Aug 2023 17:36:50 +0200
Message-Id: <0f8ac07472f4161c71247742acb2303f9cf91396.1692113438.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no point in monitoring transactions passing through the SMMU
when ARM Ltd. System MMU Version 3 (SMMUv3) Support is disabled.
Hence replace the dependency on ARM64 by a dependency on ARM_SMMU_V3
(which implies the former).

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
This caught my eye after commit 7c3f204e544dfa37 ("perf/smmuv3: Remove
build dependency on ACPI") in arm64/for-next/core.

Perhaps my understanding is wrong? Is there anything to monitor when
ARM_SMMU_V3=n?

 drivers/perf/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index 273d67ecf6d2530f..c33324692fbf0141 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -92,7 +92,7 @@ config ARM_PMU_ACPI
 
 config ARM_SMMU_V3_PMU
 	 tristate "ARM SMMUv3 Performance Monitors Extension"
-	 depends on ARM64 || (COMPILE_TEST && 64BIT)
+	 depends on ARM_SMMU_V3 || (COMPILE_TEST && 64BIT)
 	 depends on GENERIC_MSI_IRQ
 	   help
 	   Provides support for the ARM SMMUv3 Performance Monitor Counter
-- 
2.34.1

