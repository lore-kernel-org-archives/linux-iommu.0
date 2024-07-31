Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D62616131A;
	Wed, 31 Jul 2024 19:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722453223; cv=none; b=T5oWlNurM7fVChcPrzAbR0LzULbYzcxNfWOL2MXsH2lQj3+5nQ8WxoTmL7+4f4JZHYn1amsQ+EZ/2oPdWRhNskOKP99X9tzy//jy88YD6j3zdIXczwvdlr4BHItudUMSQIlW+byRGE24RX0VpJ2pbI2YdtNlt60M5mmEjkOq964=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722453223; c=relaxed/simple;
	bh=pmzVBfErfDZLVuCinmTqkl6HqSh7UgeK/z6ulWyG5QE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W4Bh6CS+11i4MWiR0rfkMM1Vij271QEKo33eSNKHDpG8o1SWpMmfL4OInrJqsI0m8F4Bnx44JKtvjoU3E/nJD6P36RBfwu3ONi/tfMZQBmK0Xf0QcbYR0EDlLqX2qdWKUyb3qsJWj9rZIBA/lzkERMbFFjld+r4RuHd8xWpKnC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rNSgZ8ro; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rNSgZ8ro"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A982C4AF0B;
	Wed, 31 Jul 2024 19:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722453223;
	bh=pmzVBfErfDZLVuCinmTqkl6HqSh7UgeK/z6ulWyG5QE=;
	h=From:To:Cc:Subject:Date:From;
	b=rNSgZ8ro7ch7uk0D4ymyJ5ZD1OJT3xcQc8yIxxXzq22MtNsKn+xkSeSzbKPJ8yGHw
	 ZsE3Xh478MQUaFU46/NgHjymE/afsLg5wguORGrzIHznx368ywc9AcxS87nGAXjiBT
	 QK+8gYtV6CmeMcIM/j6jk7sSiwOCZ1qPuarrvzMQjPq3AYtLSlV+SZZ3uUQHhsbhvU
	 R2x+VHFOFivOT8i5/tCAT7IbCdjBg2r/jm/5+dPgwT9tC5F5o2p90cIsI5T7HvzTqU
	 oNOtQL/ukqNWU/TrOHCMfELmwv5C2218LSxOXpMDmletyv8WPYoOmgX+2AppXbyi2J
	 Vj3pbNlUVJyCw==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iommu: Use of_property_present()
Date: Wed, 31 Jul 2024 13:12:44 -0600
Message-ID: <20240731191312.1710417-6-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use of_property_present() to test for property presence rather than
of_(find|get)_property(). This is part of a larger effort to remove
callers of of_find_property() and similar functions. of_find_property()
leaks the DT struct property and data pointers which is a problem for
dynamically allocated nodes which may be freed.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/iommu/fsl_pamu_domain.c | 4 +---
 drivers/iommu/of_iommu.c        | 2 +-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
index e9d2bff4659b..30be786bff11 100644
--- a/drivers/iommu/fsl_pamu_domain.c
+++ b/drivers/iommu/fsl_pamu_domain.c
@@ -416,14 +416,12 @@ static struct iommu_group *fsl_pamu_device_group(struct device *dev)
 
 static struct iommu_device *fsl_pamu_probe_device(struct device *dev)
 {
-	int len;
-
 	/*
 	 * uboot must fill the fsl,liodn for platform devices to be supported by
 	 * the iommu.
 	 */
 	if (!dev_is_pci(dev) &&
-	    !of_get_property(dev->of_node, "fsl,liodn", &len))
+	    !of_property_present(dev->of_node, "fsl,liodn"))
 		return ERR_PTR(-ENODEV);
 
 	return &pamu_iommu;
diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 78d61da75257..e7a6a1611d19 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -214,7 +214,7 @@ void of_iommu_get_resv_regions(struct device *dev, struct list_head *list)
 		 * that represent reservations in the IOVA space, which are regions that should
 		 * not be mapped.
 		 */
-		if (of_find_property(it.node, "reg", NULL)) {
+		if (of_property_present(it.node, "reg")) {
 			err = of_address_to_resource(it.node, 0, &phys);
 			if (err < 0) {
 				dev_err(dev, "failed to parse memory region %pOF: %d\n",
-- 
2.43.0

