Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42748A938
	for <iommu@lists.linux.dev>; Fri,  3 Mar 2023 21:48:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9421C433D2;
	Fri,  3 Mar 2023 21:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1677880133;
	bh=Y+8kg1gWeVirmj5afG56+SuBaNBHH+lDOxMZMdgZtgE=;
	h=From:To:Cc:Subject:Date:From;
	b=eMaR+C5GVMK4M8NVBrLR54CIsbxUYO2H7iLa9jzFl2woYeybbIlwPpau6i9PxUvHT
	 4rfQZ1c0QQP9tqSnBdZrsJKJ0id8mEbD1IW129JJlEIy/fLdMoyxHEAY9PEulJjwVx
	 Q1+XBexUtH6iKSmQEObVtOfD2y03Mkt0VFRnLfr9zvIS27HYNaWYsFuropeGtHkhv/
	 Mdb9ktPhlSqIhL8WSYh6WX2nlXUusC3oS4kgKeSaHz9kUY4eeOL3ZgVc2tNVEHZqOq
	 Kf3IrtaUQjOaOhs7uREWmsq67ySpUgaKedBhzvbcX6uw9/bKM0f5lUJBxqgCmHEVHW
	 4jQQNsKDmgS+g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Vasant Hegde <vasant.hegde@amd.com>,
	Matt Fagnani <matt.fagnani@bell.net>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Joerg Roedel <jroedel@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	joro@8bytes.org,
	will@kernel.org,
	iommu@lists.linux.dev
Subject: [PATCH AUTOSEL 4.19 01/16] iommu/amd: Fix error handling for pdev_pri_ats_enable()
Date: Fri,  3 Mar 2023 16:48:34 -0500
Message-Id: <20230303214849.1454002-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Vasant Hegde <vasant.hegde@amd.com>

[ Upstream commit 080920e52148b4fbbf9360d5345fdcd7846e4841 ]

Current code throws kernel warning if it fails to enable pasid/pri [1].
Do not call pci_disable_[pasid/pri] if pci_enable_[pasid/pri] failed.

[1] https://lore.kernel.org/linux-iommu/15d0f9ff-2a56-b3e9-5b45-e6b23300ae3b@leemhuis.info/

Reported-by: Matt Fagnani <matt.fagnani@bell.net>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Link: https://lore.kernel.org/r/20230111121503.5931-1-vasant.hegde@amd.com
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/amd_iommu.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 5d5941aca16ad..75c5932d0133a 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2059,17 +2059,17 @@ static int pdev_iommuv2_enable(struct pci_dev *pdev)
 	/* Only allow access to user-accessible pages */
 	ret = pci_enable_pasid(pdev, 0);
 	if (ret)
-		goto out_err;
+		return ret;
 
 	/* First reset the PRI state of the device */
 	ret = pci_reset_pri(pdev);
 	if (ret)
-		goto out_err;
+		goto out_err_pasid;
 
 	/* Enable PRI */
 	ret = pci_enable_pri(pdev, reqs);
 	if (ret)
-		goto out_err;
+		goto out_err_pasid;
 
 	if (reset_enable) {
 		ret = pri_reset_while_enabled(pdev);
@@ -2079,12 +2079,14 @@ static int pdev_iommuv2_enable(struct pci_dev *pdev)
 
 	ret = pci_enable_ats(pdev, PAGE_SHIFT);
 	if (ret)
-		goto out_err;
+		goto out_err_pri;
 
 	return 0;
 
-out_err:
+out_err_pri:
 	pci_disable_pri(pdev);
+
+out_err_pasid:
 	pci_disable_pasid(pdev);
 
 	return ret;
-- 
2.39.2

