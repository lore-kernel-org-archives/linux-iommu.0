Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177758F7B
	for <iommu@lists.linux.dev>; Fri,  3 Mar 2023 21:43:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1A73C433A7;
	Fri,  3 Mar 2023 21:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1677879790;
	bh=GdIekXKTgJ/2knGO1EfBSkJFGT7Ks5ynxAYuXSzW8As=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rMZpws2Y6pofmW9n6yU1ZXPInBP+/FwoWKBRDcWhMyWK84saC30diIsOsbsWwi6GR
	 kWK7sbMgZfWCvZ5333ShCOxqjW9Vhf+IeBHC4eIaITY/zkyZ46Jmt6NCrTNuHmdacl
	 uNml7BzJM34dxCfxZokoQLuRtmE5sUm2Otu2oW5fPMdEC6l6pv6PUuRVUDZx1aCdOb
	 wwqKuC+UpOq/8synMLxj8Wglbn2leoK4HuR3dM6kk2hnaut9E2OWoYw5lSjC/oDyYf
	 F8H4NG9XR81Xl1jt028OmrF9Fef34VB6SJlyrBgaT4Dv4vun1+exiAP+Knu7scAgym
	 zcsO3TEbXECDw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Vasant Hegde <vasant.hegde@amd.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Matt Fagnani <matt.fagnani@bell.net>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Joerg Roedel <jroedel@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	joro@8bytes.org,
	will@kernel.org,
	iommu@lists.linux.dev
Subject: [PATCH AUTOSEL 6.2 62/64] iommu: Attach device group to old domain in error path
Date: Fri,  3 Mar 2023 16:41:04 -0500
Message-Id: <20230303214106.1446460-62-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230303214106.1446460-1-sashal@kernel.org>
References: <20230303214106.1446460-1-sashal@kernel.org>
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

[ Upstream commit 2cc73c5712f97de98c38c2fafc1f288354a9f3c3 ]

iommu_attach_group() attaches all devices in a group to domain and then
sets group domain (group->domain). Current code (__iommu_attach_group())
does not handle error path. This creates problem as devices to domain
attachment is in inconsistent state.

Flow:
  - During boot iommu attach devices to default domain
  - Later some device driver (like amd/iommu_v2 or vfio) tries to attach
    device to new domain.
  - In iommu_attach_group() path we detach device from current domain.
    Then it tries to attach devices to new domain.
  - If it fails to attach device to new domain then device to domain link
    is broken.
  - iommu_attach_group() returns error.
  - At this stage iommu_attach_group() caller thinks, attaching device to
    new domain failed and devices are still attached to old domain.
  - But in reality device to old domain link is broken. It will result
    in all sort of failures (like IO page fault) later.

To recover from this situation, we need to attach all devices back to the
old domain. Also log warning if it fails attach device back to old domain.

Suggested-by: Lu Baolu <baolu.lu@linux.intel.com>
Reported-by: Matt Fagnani <matt.fagnani@bell.net>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Tested-by: Matt Fagnani <matt.fagnani@bell.net>
Link: https://lore.kernel.org/r/20230215052642.6016-1-vasant.hegde@amd.com
Link: https://bugzilla.kernel.org/show_bug.cgi?id=216865
Link: https://lore.kernel.org/lkml/15d0f9ff-2a56-b3e9-5b45-e6b23300ae3b@leemhuis.info/
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/iommu.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 54e1306a99a47..f91b5b1a39e3b 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2126,8 +2126,22 @@ static int __iommu_attach_group(struct iommu_domain *domain,
 
 	ret = __iommu_group_for_each_dev(group, domain,
 					 iommu_group_do_attach_device);
-	if (ret == 0)
+	if (ret == 0) {
 		group->domain = domain;
+	} else {
+		/*
+		 * To recover from the case when certain device within the
+		 * group fails to attach to the new domain, we need force
+		 * attaching all devices back to the old domain. The old
+		 * domain is compatible for all devices in the group,
+		 * hence the iommu driver should always return success.
+		 */
+		struct iommu_domain *old_domain = group->domain;
+
+		group->domain = NULL;
+		WARN(__iommu_group_set_domain(group, old_domain),
+		     "iommu driver failed to attach a compatible domain");
+	}
 
 	return ret;
 }
-- 
2.39.2

