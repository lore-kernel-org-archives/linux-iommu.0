Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97D2947B
	for <iommu@lists.linux.dev>; Fri,  4 Aug 2023 10:47:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D3F2C433C8;
	Fri,  4 Aug 2023 10:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1691146043;
	bh=wTRn+XASvZzerx+O8tTSIB3hjez59zSCakl9ihPlRLE=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=HIAesCCIb+AOvpv2cdl6kkkXgDMhm2CDWTou2SYwDIqIV0IyCj/j4k/9QjeVGovzP
	 IVWj3arq6KVBzmaJVRzSl0Kc2WGM3aPm52lZSZFFTUQaq3lB935h6F1bUF4wgwJlYu
	 s9jXbCrQ0VCHIONTu3IoVVfzpORkimMvAjmNVbvA=
Subject: Patch "iommu/arm-smmu-v3: Document MMU-700 erratum 2812531" has been added to the 6.4-stable tree
To: baolu.lu@linux.intel.com,catalin.marinas@arm.com,corbet@lwn.net,eahariha@linux.microsoft.com,easwar.hariharan@microsoft.com,gregkh@linuxfoundation.org,iommu@lists.linux.dev,jean-philippe@linaro.org,jgg@ziepe.ca,joro@8bytes.org,kirill.shutemov@linux.intel.com,krckatom@amazon.de,linux-arm-kernel@lists.infradead.org,nicolinc@nvidia.com,robin.murphy@arm.com,u.kleine-koenig@pengutronix.de,will@kernel.org,yangyicong@hisilicon.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 04 Aug 2023 12:47:13 +0200
In-Reply-To: <20230802172620.1628017-3-eahariha@linux.microsoft.com>
Message-ID: <2023080413-mandolin-hedge-b404@gregkh>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-stable: commit
X-Patchwork-Hint: ignore 


This is a note to let you know that I've just added the patch titled

    iommu/arm-smmu-v3: Document MMU-700 erratum 2812531

to the 6.4-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     iommu-arm-smmu-v3-document-mmu-700-erratum-2812531.patch
and it can be found in the queue-6.4 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable-owner@vger.kernel.org Wed Aug  2 19:26:56 2023
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Wed,  2 Aug 2023 17:26:18 +0000
Subject: iommu/arm-smmu-v3: Document MMU-700 erratum 2812531
To: stable@vger.kernel.org
Cc: easwar.hariharan@microsoft.com, "Robin Murphy" <robin.murphy@arm.com>, "Nicolin Chen" <nicolinc@nvidia.com>, "Will Deacon" <will@kernel.org>, "Catalin Marinas" <catalin.marinas@arm.com>, "Jonathan Corbet" <corbet@lwn.net>, "Joerg Roedel" <joro@8bytes.org>, "Lu Baolu" <baolu.lu@linux.intel.com>, "Jason Gunthorpe" <jgg@ziepe.ca>, "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>, "Jean-Philippe Brucker" <jean-philippe@linaro.org>, "Yicong Yang" <yangyicong@hisilicon.com>, "Tomas Krcka" <krckatom@amazon.de>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, linux-arm-kernel@lists.infradead.org (moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)), linux-doc@vger.kernel.org (open list:DOCUMENTATION), linux-kernel@vger.kernel.org (open list), iommu@lists.linux.dev (open list:IOMMU SUBSYSTEM)
Message-ID: <20230802172620.1628017-3-eahariha@linux.microsoft.com>

From: Robin Murphy <robin.murphy@arm.com>

commit 309a15cb16bb075da1c99d46fb457db6a1a2669e upstream

To work around MMU-700 erratum 2812531 we need to ensure that certain
sequences of commands cannot be issued without an intervening sync. In
practice this falls out of our current command-batching machinery
anyway - each batch only contains a single type of invalidation command,
and ends with a sync. The only exception is when a batch is sufficiently
large to need issuing across multiple command queue slots, wherein the
earlier slots will not contain a sync and thus may in theory interleave
with another batch being issued in parallel to create an affected
sequence across the slot boundary.

Since MMU-700 supports range invalidate commands and thus we will prefer
to use them (which also happens to avoid conditions for other errata),
I'm not entirely sure it's even possible for a single high-level
invalidate call to generate a batch of more than 63 commands, but for
the sake of robustness and documentation, wire up an option to enforce
that a sync is always inserted for every slot issued.

The other aspect is that the relative order of DVM commands cannot be
controlled, so DVM cannot be used. Again that is already the status quo,
but since we have at least defined ARM_SMMU_FEAT_BTM, we can explicitly
disable it for documentation purposes even if it's not wired up anywhere
yet.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Link: https://lore.kernel.org/r/330221cdfd0003cd51b6c04e7ff3566741ad8374.1683731256.git.robin.murphy@arm.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/arm64/silicon-errata.rst      |    2 ++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |   12 ++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |    1 +
 3 files changed, 15 insertions(+)

--- a/Documentation/arm64/silicon-errata.rst
+++ b/Documentation/arm64/silicon-errata.rst
@@ -145,6 +145,8 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | MMU-600         | #1076982        | N/A                         |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | MMU-700         | #2812531        | N/A                         |
++----------------+-----------------+-----------------+-----------------------------+
 +----------------+-----------------+-----------------+-----------------------------+
 | Broadcom       | Brahma-B53      | N/A             | ARM64_ERRATUM_845719        |
 +----------------+-----------------+-----------------+-----------------------------+
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -894,6 +894,12 @@ static void arm_smmu_cmdq_batch_add(stru
 {
 	int index;
 
+	if (cmds->num == CMDQ_BATCH_ENTRIES - 1 &&
+	    (smmu->options & ARM_SMMU_OPT_CMDQ_FORCE_SYNC)) {
+		arm_smmu_cmdq_issue_cmdlist(smmu, cmds->cmds, cmds->num, true);
+		cmds->num = 0;
+	}
+
 	if (cmds->num == CMDQ_BATCH_ENTRIES) {
 		arm_smmu_cmdq_issue_cmdlist(smmu, cmds->cmds, cmds->num, false);
 		cmds->num = 0;
@@ -3431,6 +3437,7 @@ static int arm_smmu_device_reset(struct
 
 #define IIDR_IMPLEMENTER_ARM		0x43b
 #define IIDR_PRODUCTID_ARM_MMU_600	0x483
+#define IIDR_PRODUCTID_ARM_MMU_700	0x487
 
 static void arm_smmu_device_iidr_probe(struct arm_smmu_device *smmu)
 {
@@ -3451,6 +3458,11 @@ static void arm_smmu_device_iidr_probe(s
 			if (variant == 0 && revision <= 2)
 				smmu->features &= ~ARM_SMMU_FEAT_SEV;
 			break;
+		case IIDR_PRODUCTID_ARM_MMU_700:
+			/* Arm erratum 2812531 */
+			smmu->features &= ~ARM_SMMU_FEAT_BTM;
+			smmu->options |= ARM_SMMU_OPT_CMDQ_FORCE_SYNC;
+			break;
 		}
 		break;
 	}
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -650,6 +650,7 @@ struct arm_smmu_device {
 #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
 #define ARM_SMMU_OPT_PAGE0_REGS_ONLY	(1 << 1)
 #define ARM_SMMU_OPT_MSIPOLL		(1 << 2)
+#define ARM_SMMU_OPT_CMDQ_FORCE_SYNC	(1 << 3)
 	u32				options;
 
 	struct arm_smmu_cmdq		cmdq;


Patches currently in stable-queue which might be from stable-owner@vger.kernel.org are

queue-6.4/iommu-arm-smmu-v3-document-nesting-related-errata.patch
queue-6.4/iommu-arm-smmu-v3-add-explicit-feature-for-nesting.patch
queue-6.4/iommu-arm-smmu-v3-document-mmu-700-erratum-2812531.patch
queue-6.4/iommu-arm-smmu-v3-work-around-mmu-600-erratum-1076982.patch
