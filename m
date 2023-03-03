Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6C78F7B
	for <iommu@lists.linux.dev>; Fri,  3 Mar 2023 21:43:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16CAEC433A7;
	Fri,  3 Mar 2023 21:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1677879799;
	bh=rzW9X9ipoEhCccEc6DGVUzm0CbhKj6YR3rzIakLS3Uw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B3y0ntXmgpKGa2gj/BJrgLkEsR6JMFf/H5CRXT9mKi7La/epJTuSXtnbu9JSTNoPU
	 x5e4xdZECZHtx7GTW6l51/Lep86UAkXTdZxTbEHypSs9kKeOBWw1BnVbrQO/gTzUzl
	 U/zDgsCVHimrNrZDrue1N1kUhcDqNrluz6/O9ffTAz6INZTfdeSfLG9w87VeAA0LlT
	 zHK7wGDYGChQoUXyw5mggO/svT2htlV+65QcFpep5DQHMBbOy+qhPSYG9+bsuwaLe5
	 caE6gYB/bYNzstU+IpIyw5EsQtTXimVyXh7ReVMT/axd6mF9uqHgNqZk6LpXvlGmks
	 Tpx43Ghircr4w==
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
Subject: [PATCH AUTOSEL 6.1 02/60] iommu/amd: Fix error handling for pdev_pri_ats_enable()
Date: Fri,  3 Mar 2023 16:42:16 -0500
Message-Id: <20230303214315.1447666-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230303214315.1447666-1-sashal@kernel.org>
References: <20230303214315.1447666-1-sashal@kernel.org>
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
 drivers/iommu/amd/iommu.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index d3b39d0416fa3..7f15e9c658412 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1703,27 +1703,29 @@ static int pdev_pri_ats_enable(struct pci_dev *pdev)
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
 	/* FIXME: Hardcode number of outstanding requests for now */
 	ret = pci_enable_pri(pdev, 32);
 	if (ret)
-		goto out_err;
+		goto out_err_pasid;
 
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

