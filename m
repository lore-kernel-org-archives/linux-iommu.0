Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804A517C91;
	Wed, 25 Sep 2024 12:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266515; cv=none; b=G3S7Pu6j4ZN2TD3Y486OMSOrGUwlXtmBA4oQAKlNnPUKL6OiA+2WN160vN3PSBYRQ4rL3w4xLvQ4smNCvTLhaZBWwO2m7i/UpwCgyne9odXepbk7hEDl2NQwt/L+cs1cM8/OiZCpR6zJK45Sl8YpU5MtL7csHA7G0UToDVC46VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266515; c=relaxed/simple;
	bh=zaIMR5p/6yoDj+uLWzpZX6KorKT9tAuu//VRUaFcnTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SANZlujnK2HH+NddXBILhBZzANcVW6GMoB88rUkMy7R9RLza2rppmmQkEqZi0s1SmzTv/Jv3jMeCXGSz1JH0NKbkH4cmJzf+rkOrmv+tmFcFlnef65e4MwPeqiyA3BibLjx26hcf0wLAI4Qir9pYXtUjdCjHaGKTKPuMrNiP6I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B5xTPAuQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B5xTPAuQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AD4BC4CECF;
	Wed, 25 Sep 2024 12:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266515;
	bh=zaIMR5p/6yoDj+uLWzpZX6KorKT9tAuu//VRUaFcnTg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B5xTPAuQHqZvpL8wocBmUvl4LqtBzC/GkaI00aF/9DwntNKuEEF02+sRY2hyT5wh/
	 8LwN9DojAtJ4g97n0VMnz5FdYgWCk//saGswfIvBEHRn+/e11w50AXIZ8DXtyOEdmR
	 fMLrFwdQ0Z1mWRFKqg8YNFrUpl8zjHDNbDFxNri6bSN9oA4R4Uvv3bxm4UR5cTig4K
	 Jbv4poaOkpN76TgFSqApV0JfACwfonppEWXOWdonDLOLsSHmWwlBBiqGkoryffr6CR
	 lom/yU3HGRgdSqVFbOOPhAfAS1XeJmWm8JTGwz+wsM56+cobnfdZ8Qg+OCB/zmVrSW
	 sE/VRH8269O3A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jerry Snitselaar <jsnitsel@redhat.com>,
	Joerg Roedel <jroedel@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	dwmw2@infradead.org,
	joro@8bytes.org,
	will@kernel.org,
	iommu@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 081/139] iommu/vt-d: Always reserve a domain ID for identity setup
Date: Wed, 25 Sep 2024 08:08:21 -0400
Message-ID: <20240925121137.1307574-81-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925121137.1307574-1-sashal@kernel.org>
References: <20240925121137.1307574-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.52
Content-Transfer-Encoding: 8bit

From: Lu Baolu <baolu.lu@linux.intel.com>

[ Upstream commit 2c13012e09190174614fd6901857a1b8c199e17d ]

We will use a global static identity domain. Reserve a static domain ID
for it.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
Link: https://lore.kernel.org/r/20240809055431.36513-4-baolu.lu@linux.intel.com
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/intel/iommu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 9918af222c516..b7317016834cf 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1692,10 +1692,10 @@ static int iommu_init_domains(struct intel_iommu *iommu)
 	 * entry for first-level or pass-through translation modes should
 	 * be programmed with a domain id different from those used for
 	 * second-level or nested translation. We reserve a domain id for
-	 * this purpose.
+	 * this purpose. This domain id is also used for identity domain
+	 * in legacy mode.
 	 */
-	if (sm_supported(iommu))
-		set_bit(FLPT_DEFAULT_DID, iommu->domain_ids);
+	set_bit(FLPT_DEFAULT_DID, iommu->domain_ids);
 
 	return 0;
 }
-- 
2.43.0

