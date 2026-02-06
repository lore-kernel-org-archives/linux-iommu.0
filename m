Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280CA381AF
	for <iommu@lists.linux.dev>; Fri,  6 Feb 2026 08:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770365893; cv=none; b=euBluj1xiz84nBDQadHJ3YFBUhKq1W5xItSlXMPlc+qsxmrlOBocHxvfw3r51msMciO1oBeStFWW4GBCsHNKxfLiAr1NkqKDwvFWh0Z4M3JnQ1h6+VlasPFo4IaKNY3L6IcQ4H7PF/VrP4PvrDBR1C9H434Db4GL/EMCsOBRQbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770365893; c=relaxed/simple;
	bh=Ex4Ji1Zkbq1Lnk5f9Set2/Yh8dH5fqfBHOmXHOHtIDA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LGAu7WLXLeS3U5p4gLBEOnYFX5/3PBRIAXslQ53UhznWJLRJbcaVoD1xSqB8/MAr42GAtMDTVJvuckg7/n9O+4FIdDCl3/3/e4Yljr6z/47d7eABYYSTTddmCfwDswrzzq4uHHaKJ6CpEQh3HV1v9xt9asFZ3gDqn3j4doaKa+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwB3fJjBo4VpZnzWBg--.604S2;
	Fri, 06 Feb 2026 16:18:09 +0800 (CST)
Received: from [127.0.0.1] (unknown [219.142.137.151])
	by mail (Coremail) with SMTP id AQAAfwDXLeu9o4VpOmwZAA--.29724S3;
	Fri, 06 Feb 2026 16:18:05 +0800 (CST)
From: Zhiyuan Dai <daizhiyuan@phytium.com.cn>
Date: Fri, 06 Feb 2026 16:18:05 +0800
Subject: [PATCH v2] iommu/arm-smmu-v3: Restrict MMU-700 errata 2268618 and
 2812531 to affected
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260206-smmuv3-v2-1-f381a2125392@phytium.com.cn>
X-B4-Tracking: v=1; b=H4sIALyjhWkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDIzMDIwMz3eLc3NIyY91ECwtzcyNjc/NkIwMloOKCotS0zAqwQdGxtbUAqH5
 JqFgAAAA=
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Joerg Roedel <joro@8bytes.org>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Zhiyuan Dai <daizhiyuan@phytium.com.cn>
X-Mailer: b4 0.13.0
X-CM-TRANSID:AQAAfwDXLeu9o4VpOmwZAA--.29724S3
X-CM-SenderInfo: hgdl6xpl1xt0o6sk53xlxphulrpou0/
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=daizhiyuan
	@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7Kw1DCF17CFy7ZFy3KF1kGrg_yoW8Aryrpa
	n3Gwn5uw1UWF1fZa9Fv39rZF15Ga4kAFWFqF4UWa90gw1qkry3GryIgFWYgF4kCrWUZF1f
	ZF1vqrW5CF1UArJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU

According to SDEN-1786925, Arm errata 2268618 and 2812531 are present in
r0p0, r0p1, and r1p0, and fixed in r1p1.

Introduce this patch to avoid performance degradation caused by
restricting features on unaffected revisions.

Signed-off-by: Zhiyuan Dai <daizhiyuan@phytium.com.cn>
---
Changelog:
- Change the revision threshold from < 0 to < 1 to correctly.
- Link to v1: https://lore.kernel.org/linux-iommu/3f22f7b8-449c-40d9-b4c8-fff3e520d563@arm.com/raw
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index d16d35c78c06..d5c35be5c858 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4272,11 +4272,13 @@ static void arm_smmu_device_iidr_probe(struct arm_smmu_device *smmu)
 				smmu->features &= ~ARM_SMMU_FEAT_NESTING;
 			break;
 		case IIDR_PRODUCTID_ARM_MMU_700:
-			/* Arm erratum 2812531 */
-			smmu->features &= ~ARM_SMMU_FEAT_BTM;
-			smmu->options |= ARM_SMMU_OPT_CMDQ_FORCE_SYNC;
-			/* Arm errata 2268618, 2812531 */
-			smmu->features &= ~ARM_SMMU_FEAT_NESTING;
+			if (variant <= 1 && revision < 1) {
+				/* Arm erratum 2812531 */
+				smmu->features &= ~ARM_SMMU_FEAT_BTM;
+				smmu->options |= ARM_SMMU_OPT_CMDQ_FORCE_SYNC;
+				/* Arm errata 2268618, 2812531 */
+				smmu->features &= ~ARM_SMMU_FEAT_NESTING;
+			}
 			break;
 		}
 		break;

---
base-commit: b7ff7151e653aa296ab6c5495b2c1ab7c21eb250
change-id: 20260206-smmuv3-a88772377c20

Best regards,
-- 
Zhiyuan Dai <daizhiyuan@phytium.com.cn>

