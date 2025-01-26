Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D221F8EE9;
	Sun, 26 Jan 2025 15:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737904073; cv=none; b=WT2dxm6H0H1mKrcjhlGtEZpKVveUFi7/7h8FK60ToH+PFTKb+YOII300GaEqtzY3N2j9QF29YelhEMl9D5+tZYXyYSetCxwP6GDF4BM2MF7qk+0/JsHXcR3+R8O+V2/1KVz/soUwXPkSu3OLbjzabsz7qkCf2JKOXIJKicSE+4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737904073; c=relaxed/simple;
	bh=+cYr+yDB4KdKLf+B1LGrp82PwqiBAnl8xKrFvWVtEE4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eFzIieIoM4AaC2OgS+UshyTy5Lj2T08CQVuTHxj6rTxOyURFXoYGsu/9lZGj4p9M45iQrU3aKJDIs2C7QBUWDwdgBjYhRdgUj2BroKiafTcutn3kIsLX2pvE+T53bn8bXW0yQqhfSsp1mwyQPRaSbYxCrWB6ab92Qh2lg3vdbnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TrbP2g7J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TrbP2g7J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5A9BC4CEE3;
	Sun, 26 Jan 2025 15:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737904073;
	bh=+cYr+yDB4KdKLf+B1LGrp82PwqiBAnl8xKrFvWVtEE4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TrbP2g7JOTYzOZ805TQcaiRKo3BMW/Tx1xM9oMS4Q/CHQAzql6DLEnGhb4F9CWAiG
	 INosoYaCQqvLq+HSTfbjcEEgPQhIuTPBQIfpuhdi+Km+5N0kyY7Sz59cx49fIiM98Z
	 N17EjljgCEnwHK8rJhsoRDxqMFl1U9xDMGJa5t93j2UkP/eJ/QmjHx99yFNNCjTQBo
	 /u6OifPqPsu7PCJmxGDf+mVjKj3GEypFSENgnqTiTSegBGBIYShss5hNL6atT+wPui
	 IAoi/dqwow8SmDQx2gUYAGOY2apSYJmqdmfKn35GrYiKJouGZeXN45PDyDSCbl8uqL
	 NSNteRGRWONFw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kees Bakker <kees@ijzerbout.nl>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <jroedel@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	dwmw2@infradead.org,
	joro@8bytes.org,
	will@kernel.org,
	iommu@lists.linux.dev
Subject: [PATCH AUTOSEL 6.13 11/16] iommu/vt-d: Avoid use of NULL after WARN_ON_ONCE
Date: Sun, 26 Jan 2025 10:07:13 -0500
Message-Id: <20250126150720.961959-11-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126150720.961959-1-sashal@kernel.org>
References: <20250126150720.961959-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13
Content-Transfer-Encoding: 8bit

From: Kees Bakker <kees@ijzerbout.nl>

[ Upstream commit 60f030f7418d3f1d94f2fb207fe3080e1844630b ]

There is a WARN_ON_ONCE to catch an unlikely situation when
domain_remove_dev_pasid can't find the `pasid`. In case it nevertheless
happens we must avoid using a NULL pointer.

Signed-off-by: Kees Bakker <kees@ijzerbout.nl>
Link: https://lore.kernel.org/r/20241218201048.E544818E57E@bout3.ijzerbout.nl
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/intel/iommu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 79e0da9eb626c..8f75c11a3ec48 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4090,13 +4090,14 @@ void domain_remove_dev_pasid(struct iommu_domain *domain,
 			break;
 		}
 	}
-	WARN_ON_ONCE(!dev_pasid);
 	spin_unlock_irqrestore(&dmar_domain->lock, flags);
 
 	cache_tag_unassign_domain(dmar_domain, dev, pasid);
 	domain_detach_iommu(dmar_domain, iommu);
-	intel_iommu_debugfs_remove_dev_pasid(dev_pasid);
-	kfree(dev_pasid);
+	if (!WARN_ON_ONCE(!dev_pasid)) {
+		intel_iommu_debugfs_remove_dev_pasid(dev_pasid);
+		kfree(dev_pasid);
+	}
 }
 
 static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
-- 
2.39.5

