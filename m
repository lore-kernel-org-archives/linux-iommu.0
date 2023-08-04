Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA65F5250
	for <iommu@lists.linux.dev>; Fri,  4 Aug 2023 11:20:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A217C433C8;
	Fri,  4 Aug 2023 11:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1691148018;
	bh=bU/0wI2b4JzSJqAo/SoT6/cWX+1Zwqrz13LVs8KnQco=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=kZ+3GC9W1R91bJficwXcpPZ7TH15tmnitWqFeLV+7fwuddokOdhyUmY+MAdlJiblF
	 rlvlbPMpdkjFWwzpT9DLT6mwksAg3826fVU1sHV40s6DpSHG3lu7OVaxjL4gAE1WUl
	 i7boEFTI/S1CObqpIB24ZTF4phoedKG4Mg2x24t0=
Subject: Patch "iommu/arm-smmu-v3: Document nesting-related errata" has been added to the 6.1-stable tree
To: baolu.lu@linux.intel.com,catalin.marinas@arm.com,corbet@lwn.net,eahariha@linux.microsoft.com,easwar.hariharan@microsoft.com,gregkh@linuxfoundation.org,iommu@lists.linux.dev,joro@8bytes.org,linux-arm-kernel@lists.infradead.org,nicolinc@nvidia.com,robin.murphy@arm.com,vladimir.oltean@nxp.com,will@kernel.org,yangyicong@hisilicon.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 04 Aug 2023 13:19:59 +0200
In-Reply-To: <20230802172100.1599164-5-eahariha@linux.microsoft.com>
Message-ID: <2023080459-doozy-ounce-3ad8@gregkh>
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

    iommu/arm-smmu-v3: Document nesting-related errata

to the 6.1-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     iommu-arm-smmu-v3-document-nesting-related-errata.patch
and it can be found in the queue-6.1 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable-owner@vger.kernel.org Wed Aug  2 19:21:29 2023
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Wed,  2 Aug 2023 17:21:00 +0000
Subject: iommu/arm-smmu-v3: Document nesting-related errata
To: stable@vger.kernel.org
Cc: easwar.hariharan@microsoft.com, Robin Murphy <robin.murphy@arm.com>, Nicolin Chen <nicolinc@nvidia.com>, Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Jonathan Corbet <corbet@lwn.net>, Joerg Roedel <joro@8bytes.org>, Vladimir Oltean <vladimir.oltean@nxp.com>, Yicong Yang <yangyicong@hisilicon.com>, Lu Baolu <baolu.lu@linux.intel.com>, linux-arm-kernel@lists.infradead.org (moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)), linux-doc@vger.kernel.org (open list:DOCUMENTATION), linux-kernel@vger.kernel.org (open list), iommu@lists.linux.dev (open list:IOMMU SUBSYSTEM)
Message-ID: <20230802172100.1599164-5-eahariha@linux.microsoft.com>

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/arm64/silicon-errata.rst      |    4 ++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |    5 +++++
 2 files changed, 7 insertions(+), 2 deletions(-)

--- a/Documentation/arm64/silicon-errata.rst
+++ b/Documentation/arm64/silicon-errata.rst
@@ -141,9 +141,9 @@ stable kernels.
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
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3438,11 +3438,16 @@ static void arm_smmu_device_iidr_probe(s
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


Patches currently in stable-queue which might be from stable-owner@vger.kernel.org are

queue-6.1/iommu-arm-smmu-v3-document-nesting-related-errata.patch
queue-6.1/iommu-arm-smmu-v3-add-explicit-feature-for-nesting.patch
queue-6.1/iommu-arm-smmu-v3-document-mmu-700-erratum-2812531.patch
queue-6.1/iommu-arm-smmu-v3-work-around-mmu-600-erratum-1076982.patch
