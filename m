Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6ECCDF66
	for <iommu@lists.linux.dev>; Wed,  2 Aug 2023 17:26:43 +0000 (UTC)
Received: from rrs24-12-35.corp.microsoft.com (unknown [131.107.147.181])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5E652238C435;
	Wed,  2 Aug 2023 10:26:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5E652238C435
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1690997203;
	bh=JxNu19adZsu3M0z/z3GFu4USKc1JYfzjTR+eXKUvlDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WP2U/xqOlg9dXus047uOQXiWeS1uOyD1f5yFXMPeDHHAErxOn36jTxi8wnAmpH02A
	 JU2Ni3Wy3G6AnIKF0bfXMiALAu7srGzIz9tPLmDvmiCjRyzShf36ejAObu/IEqszGv
	 /hdJjYPo0dyRR6HJSdMKGo8WpMTyuOmiLuPaqFKw=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
To: stable@vger.kernel.org
Cc: easwar.hariharan@microsoft.com,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Joerg Roedel <joro@8bytes.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Tomas Krcka <krckatom@amazon.de>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)),
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-kernel@vger.kernel.org (open list),
	iommu@lists.linux.dev (open list:IOMMU SUBSYSTEM)
Subject: [PATCH v2 6.4 4/4] iommu/arm-smmu-v3: Document nesting-related errata
Date: Wed,  2 Aug 2023 17:26:20 +0000
Message-Id: <20230802172620.1628017-5-eahariha@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230802172620.1628017-1-eahariha@linux.microsoft.com>
References: <20230802172620.1628017-1-eahariha@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Robin Murphy <robin.murphy@arm.com>

commit 0bfbfc526c70606bf0fad302e4821087cbecfaf4 upstream

Both MMU-600 and MMU-700 have similar errata around TLB invalidation
while both stages of translation are active, which will need some
consideration once nesting support is implemented. For now, though,
it's very easy to make our implicit lack of nesting support explicit
for those cases, so they're less likely to be missed in future.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Link: https://lore.kernel.org/r/696da78d32bb4491f898f11b0bb4d850a8aa7c6a.1683731256.git.robin.murphy@arm.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
 Documentation/arm64/silicon-errata.rst      | 4 ++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 5 +++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/arm64/silicon-errata.rst b/Documentation/arm64/silicon-errata.rst
index b0346968765d..3ce6e4aebdef 100644
--- a/Documentation/arm64/silicon-errata.rst
+++ b/Documentation/arm64/silicon-errata.rst
@@ -143,9 +143,9 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | MMU-500         | #841119,826419  | N/A                         |
 +----------------+-----------------+-----------------+-----------------------------+
-| ARM            | MMU-600         | #1076982        | N/A                         |
+| ARM            | MMU-600         | #1076982,1209401| N/A                         |
 +----------------+-----------------+-----------------+-----------------------------+
-| ARM            | MMU-700         | #2812531        | N/A                         |
+| ARM            | MMU-700         | #2268618,2812531| N/A                         |
 +----------------+-----------------+-----------------+-----------------------------+
 +----------------+-----------------+-----------------+-----------------------------+
 | Broadcom       | Brahma-B53      | N/A             | ARM64_ERRATUM_845719        |
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 7e08ec55df2a..bbad54aa6c8c 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3457,11 +3457,16 @@ static void arm_smmu_device_iidr_probe(struct arm_smmu_device *smmu)
 			/* Arm erratum 1076982 */
 			if (variant == 0 && revision <= 2)
 				smmu->features &= ~ARM_SMMU_FEAT_SEV;
+			/* Arm erratum 1209401 */
+			if (variant < 2)
+				smmu->features &= ~ARM_SMMU_FEAT_NESTING;
 			break;
 		case IIDR_PRODUCTID_ARM_MMU_700:
 			/* Arm erratum 2812531 */
 			smmu->features &= ~ARM_SMMU_FEAT_BTM;
 			smmu->options |= ARM_SMMU_OPT_CMDQ_FORCE_SYNC;
+			/* Arm errata 2268618, 2812531 */
+			smmu->features &= ~ARM_SMMU_FEAT_NESTING;
 			break;
 		}
 		break;
-- 
2.25.1

