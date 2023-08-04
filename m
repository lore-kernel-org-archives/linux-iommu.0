Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524395250
	for <iommu@lists.linux.dev>; Fri,  4 Aug 2023 11:20:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB71DC433CA;
	Fri,  4 Aug 2023 11:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1691148008;
	bh=Qx3yxlRctGTel5E6Dfnvp3y4dXKIJyn+YfuipJthk88=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=2GW2RBRjpIgkzo5ooIruEAGVeYGCBbVdebevqdt3/bEDEN8b8uqAFo5BLlr6yalct
	 ETYVLD55XCn/9ENPXRVfIT5jw3iZS6R+85jJOTrRrw3ZeQeDcXftUzdTz5LnBdVDY4
	 wwMv/dsQa17cg3cloMFf/TwUm3I4kwuN8Wq/Hs+I=
Subject: Patch "iommu/arm-smmu-v3: Work around MMU-600 erratum 1076982" has been added to the 5.15-stable tree
To: catalin.marinas@arm.com,corbet@lwn.net,eahariha@linux.microsoft.com,easwar.hariharan@microsoft.com,gregkh@linuxfoundation.org,iommu@lists.linux-foundation.org,iommu@lists.linux.dev,joro@8bytes.org,krckatom@amazon.de,linux-arm-kernel@lists.infradead.org,nicolinc@nvidia.com,robin.murphy@arm.com,sashal@kernel.org,will@kernel.org,yangyicong@hisilicon.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 04 Aug 2023 13:19:46 +0200
In-Reply-To: <20230802170227.1590187-4-eahariha@linux.microsoft.com>
Message-ID: <2023080446-selection-tidal-c501@gregkh>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
X-Patchwork-Hint: ignore 


This is a note to let you know that I've just added the patch titled

    iommu/arm-smmu-v3: Work around MMU-600 erratum 1076982

to the 5.15-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     iommu-arm-smmu-v3-work-around-mmu-600-erratum-1076982.patch
and it can be found in the queue-5.15 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable-owner@vger.kernel.org Wed Aug  2 19:02:51 2023
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Wed,  2 Aug 2023 17:02:24 +0000
Subject: iommu/arm-smmu-v3: Work around MMU-600 erratum 1076982
To: stable@vger.kernel.org
Cc: easwar.hariharan@microsoft.com, Robin Murphy <robin.murphy@arm.com>, Nicolin Chen <nicolinc@nvidia.com>, Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Jonathan Corbet <corbet@lwn.net>, Joerg Roedel <joro@8bytes.org>, Sasha Levin <sashal@kernel.org>, Tomas Krcka <krckatom@amazon.de>, Yicong Yang <yangyicong@hisilicon.com>, linux-arm-kernel@lists.infradead.org (moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)), linux-doc@vger.kernel.org (open list:DOCUMENTATION), linux-kernel@vger.kernel.org (open list), iommu@lists.linux-foundation.org (open list:IOMMU DRIVERS), iommu@lists.linux.dev (open list:IOMMU DRIVERS)
Message-ID: <20230802170227.1590187-4-eahariha@linux.microsoft.com>

From: Robin Murphy <robin.murphy@arm.com>

commit f322e8af35c7f23a8c08b595c38d6c855b2d836f upstream

MMU-600 versions prior to r1p0 fail to correctly generate a WFE wakeup
event when the command queue transitions fom full to non-full. We can
easily work around this by simply hiding the SEV capability such that we
fall back to polling for space in the queue - since MMU-600 implements
MSIs we wouldn't expect to need SEV for sync completion either, so this
should have little to no impact.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Link: https://lore.kernel.org/r/08adbe3d01024d8382a478325f73b56851f76e49.1683731256.git.robin.murphy@arm.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/arm64/silicon-errata.rst      |    2 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |   29 ++++++++++++++++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |    6 +++++
 3 files changed, 37 insertions(+)

--- a/Documentation/arm64/silicon-errata.rst
+++ b/Documentation/arm64/silicon-errata.rst
@@ -122,6 +122,8 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | MMU-500         | #841119,826419  | N/A                         |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | MMU-600         | #1076982        | N/A                         |
++----------------+-----------------+-----------------+-----------------------------+
 +----------------+-----------------+-----------------+-----------------------------+
 | Broadcom       | Brahma-B53      | N/A             | ARM64_ERRATUM_845719        |
 +----------------+-----------------+-----------------+-----------------------------+
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3459,6 +3459,33 @@ static int arm_smmu_device_reset(struct
 	return 0;
 }
 
+#define IIDR_IMPLEMENTER_ARM		0x43b
+#define IIDR_PRODUCTID_ARM_MMU_600	0x483
+
+static void arm_smmu_device_iidr_probe(struct arm_smmu_device *smmu)
+{
+	u32 reg;
+	unsigned int implementer, productid, variant, revision;
+
+	reg = readl_relaxed(smmu->base + ARM_SMMU_IIDR);
+	implementer = FIELD_GET(IIDR_IMPLEMENTER, reg);
+	productid = FIELD_GET(IIDR_PRODUCTID, reg);
+	variant = FIELD_GET(IIDR_VARIANT, reg);
+	revision = FIELD_GET(IIDR_REVISION, reg);
+
+	switch (implementer) {
+	case IIDR_IMPLEMENTER_ARM:
+		switch (productid) {
+		case IIDR_PRODUCTID_ARM_MMU_600:
+			/* Arm erratum 1076982 */
+			if (variant == 0 && revision <= 2)
+				smmu->features &= ~ARM_SMMU_FEAT_SEV;
+			break;
+		}
+		break;
+	}
+}
+
 static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 {
 	u32 reg;
@@ -3664,6 +3691,8 @@ static int arm_smmu_device_hw_probe(stru
 
 	smmu->ias = max(smmu->ias, smmu->oas);
 
+	arm_smmu_device_iidr_probe(smmu);
+
 	if (arm_smmu_sva_supported(smmu))
 		smmu->features |= ARM_SMMU_FEAT_SVA;
 
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -69,6 +69,12 @@
 #define IDR5_VAX			GENMASK(11, 10)
 #define IDR5_VAX_52_BIT			1
 
+#define ARM_SMMU_IIDR			0x18
+#define IIDR_PRODUCTID			GENMASK(31, 20)
+#define IIDR_VARIANT			GENMASK(19, 16)
+#define IIDR_REVISION			GENMASK(15, 12)
+#define IIDR_IMPLEMENTER		GENMASK(11, 0)
+
 #define ARM_SMMU_CR0			0x20
 #define CR0_ATSCHK			(1 << 4)
 #define CR0_CMDQEN			(1 << 3)


Patches currently in stable-queue which might be from stable-owner@vger.kernel.org are

queue-5.15/arm64-errata-add-workaround-for-tsb-flush-failures.patch
queue-5.15/iommu-arm-smmu-v3-document-nesting-related-errata.patch
queue-5.15/iommu-arm-smmu-v3-add-explicit-feature-for-nesting.patch
queue-5.15/arm64-errata-add-detection-for-trbe-write-to-out-of-range.patch
queue-5.15/iommu-arm-smmu-v3-document-mmu-700-erratum-2812531.patch
queue-5.15/iommu-arm-smmu-v3-work-around-mmu-600-erratum-1076982.patch
