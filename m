Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34B75250
	for <iommu@lists.linux.dev>; Fri,  4 Aug 2023 11:19:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D503DC433C7;
	Fri,  4 Aug 2023 11:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1691147999;
	bh=6snG1mMLHRQU1RYPLAOCFENIxbm+eJUIObMEqpjHlAQ=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=LzlgjOsBXC+Lt4CNt3v3sLpn9LEbXRd9PE8QT/gZvk3ufo2If/0yb0Zc6u6NazJBS
	 qljkTfwcwBGkfJD/XjFOZXdrXhPacylk3KiR0DPNFKx4v/RUm+r2+VAxIu3r0SKuUE
	 xX8mSECGKWlkz/hQMv+ilm+ZNQm9DXf/cEEvjBuA=
Subject: Patch "iommu/arm-smmu-v3: Add explicit feature for nesting" has been added to the 5.15-stable tree
To: eahariha@linux.microsoft.com,easwar.hariharan@microsoft.com,gregkh@linuxfoundation.org,iommu@lists.linux-foundation.org,iommu@lists.linux.dev,joro@8bytes.org,krckatom@amazon.de,linux-arm-kernel@lists.infradead.org,nicolinc@nvidia.com,robin.murphy@arm.com,sashal@kernel.org,will@kernel.org,yangyicong@hisilicon.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 04 Aug 2023 13:19:45 +0200
In-Reply-To: <20230802170227.1590187-6-eahariha@linux.microsoft.com>
Message-ID: <2023080445-ferret-lubricant-1917@gregkh>
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

    iommu/arm-smmu-v3: Add explicit feature for nesting

to the 5.15-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     iommu-arm-smmu-v3-add-explicit-feature-for-nesting.patch
and it can be found in the queue-5.15 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable-owner@vger.kernel.org Wed Aug  2 19:02:51 2023
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Wed,  2 Aug 2023 17:02:26 +0000
Subject: iommu/arm-smmu-v3: Add explicit feature for nesting
To: stable@vger.kernel.org
Cc: easwar.hariharan@microsoft.com, Robin Murphy <robin.murphy@arm.com>, Nicolin Chen <nicolinc@nvidia.com>, Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, Sasha Levin <sashal@kernel.org>, Tomas Krcka <krckatom@amazon.de>, Yicong Yang <yangyicong@hisilicon.com>, linux-arm-kernel@lists.infradead.org (moderated list:ARM SMMU DRIVERS), iommu@lists.linux-foundation.org (open list:IOMMU DRIVERS), iommu@lists.linux.dev (open list:IOMMU DRIVERS), linux-kernel@vger.kernel.org (open list)
Message-ID: <20230802170227.1590187-6-eahariha@linux.microsoft.com>

From: Robin Murphy <robin.murphy@arm.com>

commit 1d9777b9f3d55b4b6faf186ba4f1d6fb560c0523 upstream

In certain cases we may want to refuse to allow nested translation even
when both stages are implemented, so let's add an explicit feature for
nesting support which we can control in its own right. For now this
merely serves as documentation, but it means a nice convenient check
will be ready and waiting for the future nesting code.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Link: https://lore.kernel.org/r/136c3f4a3a84cc14a5a1978ace57dfd3ed67b688.1683731256.git.robin.murphy@arm.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |    4 ++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |    1 +
 2 files changed, 5 insertions(+)

--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3703,6 +3703,10 @@ static int arm_smmu_device_hw_probe(stru
 
 	smmu->ias = max(smmu->ias, smmu->oas);
 
+	if ((smmu->features & ARM_SMMU_FEAT_TRANS_S1) &&
+	    (smmu->features & ARM_SMMU_FEAT_TRANS_S2))
+		smmu->features |= ARM_SMMU_FEAT_NESTING;
+
 	arm_smmu_device_iidr_probe(smmu);
 
 	if (arm_smmu_sva_supported(smmu))
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -646,6 +646,7 @@ struct arm_smmu_device {
 #define ARM_SMMU_FEAT_BTM		(1 << 16)
 #define ARM_SMMU_FEAT_SVA		(1 << 17)
 #define ARM_SMMU_FEAT_E2H		(1 << 18)
+#define ARM_SMMU_FEAT_NESTING		(1 << 19)
 	u32				features;
 
 #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)


Patches currently in stable-queue which might be from stable-owner@vger.kernel.org are

queue-5.15/arm64-errata-add-workaround-for-tsb-flush-failures.patch
queue-5.15/iommu-arm-smmu-v3-document-nesting-related-errata.patch
queue-5.15/iommu-arm-smmu-v3-add-explicit-feature-for-nesting.patch
queue-5.15/arm64-errata-add-detection-for-trbe-write-to-out-of-range.patch
queue-5.15/iommu-arm-smmu-v3-document-mmu-700-erratum-2812531.patch
queue-5.15/iommu-arm-smmu-v3-work-around-mmu-600-erratum-1076982.patch
