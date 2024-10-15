Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68C61FBF41;
	Tue, 15 Oct 2024 21:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729026509; cv=none; b=FTlehOe2S+9BptVZlojbiTEe/SbfOyShIafvefb9AQfvUXPnC4MrArjRN3pprFH4V0tNV5OHm/DPNjFMlX0T7E2JFTtkJQGEdmht8QkEpfSSl31icFfshyO+T61odC+tYbU65mag+d5SXzFZTnDEjhmTTn+Xnq6bSDOHL/MDwss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729026509; c=relaxed/simple;
	bh=2Eaiy4QCkjWZY4GuW+pKOnCGB1W4epa8LRYF3JllTWE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L9oQPU8L5mg/BNf5iu4qpAaA6uru8U/os54XmDcQsfXOsErcloCEfz4brwRPd8Ohfm317+XZV4UnMSz9y543F05Rjs8/Q8ov6Zn0hvwKuzMr9Nx7njKekRbc/fJq4QO5pMxZBElTltpUlT2WOFpT+ixlTQSDDnYbLt5nJVVyhPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tHYjrk1K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tHYjrk1K"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4324AC4CED1;
	Tue, 15 Oct 2024 21:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729026509;
	bh=2Eaiy4QCkjWZY4GuW+pKOnCGB1W4epa8LRYF3JllTWE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tHYjrk1K1ZutoiJPvOJRGroDq0ZSYoj13yft+6HyfgDqphrB6z0YXq19E5RXMT37c
	 IdEvp8YjlwUN/+2nidc47/rikHiNgCQO+Puw/b0kJaEaxvtM4e1foYFYO0grzmVhLp
	 vFoMfx8hCEWKYzW9MGU7sCBLhlsazLCVGuRn1iURYv+QGRKYuHAid36lPMcFUOXJ+K
	 wpKUw0iv4ksjFQNDwWsX/4cFjZ4ygGY/YBpeVHk/CA4bRTmhoce/ZNNnJg38WvPIts
	 H73I7Y7ypgBb3tpyJ1CLWd0h0powU66tk0jUOSpk1sJUJgHcQCP55OUZ9GnyRctENN
	 xNShqpdFsPPPw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D27D1F9DA;
	Tue, 15 Oct 2024 21:08:29 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Tue, 15 Oct 2024 23:08:14 +0200
Subject: [PATCH v4 4/5] iommufd: Enable PRI when doing the
 iommufd_hwpt_alloc
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241015-jag-iopfv8-v4-4-b696ca89ba29@kernel.org>
References: <20241015-jag-iopfv8-v4-0-b696ca89ba29@kernel.org>
In-Reply-To: <20241015-jag-iopfv8-v4-0-b696ca89ba29@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>, 
 Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
 Klaus Jensen <its@irrelevant.dk>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
 Joel Granados <joel.granados@kernel.org>, 
 Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.15-dev-00a43
X-Developer-Signature: v=1; a=openpgp-sha256; l=1744;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=2Eaiy4QCkjWZY4GuW+pKOnCGB1W4epa8LRYF3JllTWE=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGcO2crQU+6G18bpdBSQ3b2okV5b1pnNy79N2
 GBUEOtjJWhlGYkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJnDtnKAAoJELqXzVK3
 lkFPSVAL/3rHF6ukiaXmkrOcXi5XsOXxKxc+dgVZpvgqNqmS96KCaUlqgm3b8Z/55GNDDtL8Owh
 BAQZGtjn23xsG84Dvdwxn23GB1Wn/UTUDDpgQZd4emeeYdz2HZ2TEBtSbxdQThWRYZNmHFcNRRp
 f5P1m53+tgK+RWNkWsY8uEr4QlWXiB5xCFCyoN/pt/tdLoYG0UdEulrguVtBsvMvK07XhhrIPmK
 OcW4a+NQkE02DJt417GFzTOT0qnfKluNb0WaOonpWQmacvWKsN8KIHckjfHCEvwWWt+s9SAFzu9
 t6qvDmAuiAdgHJcD8kbz4nRRwHp3NrgMvUHgpljZ6gOnMFKSx5Gm7odAg1Ce/xRROq9fcuakjRS
 kZNOGAgrUC/AibV67khE6HXC4lo1wWVFUijH5Jj9tbgHVRrz1A8ZNSiOC0qTOUcx8CQvxeih81P
 KGPdaVWKTGbQCsYlox2HFbuyxdVSEtqqkhHBxdk8sM9mXCaz9Dkarg9hVMt9x7Sd2bXZaMBKXo5
 ys=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

Add IOMMU_HWPT_FAULT_ID_VALID as part of the valid flags when doing an
iommufd_hwpt_alloc allowing the use of an iommu fault allocation
(iommu_fault_alloc) with the IOMMU_HWPT_ALLOC ioctl.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 drivers/iommu/intel/iommu.c          | 3 ++-
 drivers/iommu/iommufd/hw_pagetable.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 5d9c3333c92d..dd399ca09859 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3535,7 +3535,8 @@ intel_iommu_domain_alloc_user(struct device *dev, u32 flags,
 	}
 
 	if (flags &
-	    (~(IOMMU_HWPT_ALLOC_NEST_PARENT | IOMMU_HWPT_ALLOC_DIRTY_TRACKING)))
+	    (~(IOMMU_HWPT_ALLOC_NEST_PARENT | IOMMU_HWPT_ALLOC_DIRTY_TRACKING
+	       | IOMMU_HWPT_FAULT_ID_VALID)))
 		return ERR_PTR(-EOPNOTSUPP);
 	if (nested_parent && !nested_supported(iommu))
 		return ERR_PTR(-EOPNOTSUPP);
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index d06bf6e6c19f..8f020bc0815f 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -107,7 +107,8 @@ iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 			  const struct iommu_user_data *user_data)
 {
 	const u32 valid_flags = IOMMU_HWPT_ALLOC_NEST_PARENT |
-				IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
+				IOMMU_HWPT_ALLOC_DIRTY_TRACKING |
+				IOMMU_HWPT_FAULT_ID_VALID;
 	const struct iommu_ops *ops = dev_iommu_ops(idev->dev);
 	struct iommufd_hwpt_paging *hwpt_paging;
 	struct iommufd_hw_pagetable *hwpt;

-- 
2.43.0


