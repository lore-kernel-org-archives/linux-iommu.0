Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C78C1DA2F1;
	Wed,  4 Sep 2024 13:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725455893; cv=none; b=oNJgPG/wVgy5sDyXGlWPYkhyZ1MU5G/ZqMKCmxSaKTj+ouJh/JZTwDati6VnBgnhDC4Ix5LccdGS5TkF+UUkviq7mfutO4FVMkQthTB5YOJXM6M6KeRv+W0OjrDc/0I0nOZsQNw/1I/3oNKC9MEKGJyWqjP8OymAC8APiF9yDU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725455893; c=relaxed/simple;
	bh=yI/YdEzUxnbqQlsPHNM+E/+LIgmQwvyu/UUnjDxNwS8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JWTq+0J44oBV20/LwqNJwzwAcGmvEc1FfP0O3TykuQPmgsaMxKV/0UBxDp4Z/fdWRiqjYSPKd/RzwGVfiB0xJL/IT7xTv67kx6UokQelM+4ETxIntE10WoY0TSmTeqTYDyH8CPGaJvgPxt+mSgz9U9IAu9+8/xt23Rlylf3M8c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=spwhcUuS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="spwhcUuS"
Received: by smtp.kernel.org (Postfix) with ESMTPS id EE828C4CECB;
	Wed,  4 Sep 2024 13:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725455893;
	bh=yI/YdEzUxnbqQlsPHNM+E/+LIgmQwvyu/UUnjDxNwS8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=spwhcUuSm7L1C7L9DHgC5yryjkJG6KKMLMPRSK19MTijkUF6TVYHcPwGxHe+IsenI
	 lJ6C9BP694YPCQdWAD8IaBHmvts2wgHBhwzlEN1smBPZiRg2iunqh3JhmoWrMmHOzh
	 frM9+c0jdJ1EWmNOIoaFG63h/CrSqw4oAWKkq9sdk8gSFCKkw8U2Ow+bR7hKAeuXuL
	 kSBS+nyPZPtWzH1aH2aE6RPjdspCnK1yoPlbc6jNYDKk+wlK6ndEMFO4bvWyiiK+Wd
	 aMBcJLDA91ylKggYCexr/OWuzDdwm4CA4gQGBYUYIOyuJo8rl5jOXKN/i/z+OrfYuV
	 Q0+pV3rW3TxVQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E55AFCD484A;
	Wed,  4 Sep 2024 13:18:12 +0000 (UTC)
From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Date: Wed, 04 Sep 2024 15:17:15 +0200
Subject: [PATCH 4/6] iommufd: Enable PRI when doing the iommufd_hwpt_alloc
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240904-jag-iopfv8-v1-4-e3549920adf3@samsung.com>
References: <20240904-jag-iopfv8-v1-0-e3549920adf3@samsung.com>
In-Reply-To: <20240904-jag-iopfv8-v1-0-e3549920adf3@samsung.com>
To: David Woodhouse <dwmw2@infradead.org>, 
 Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
 Klaus Jensen <its@irrelevant.dk>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
 Joel Granados <j.granados@samsung.com>
X-Mailer: b4 0.15-dev-00a43
X-Developer-Signature: v=1; a=openpgp-sha256; l=1694;
 i=j.granados@samsung.com; h=from:subject:message-id;
 bh=DxEbBmnkeSWlQ/5MEXCH0l7yNP6fyq/9U3DrRBtODeQ=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGbYXhHUVwfr9e9QLrNk/WkXeQbulJ6RSgyT2
 TPZKG7vlQIWu4kBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJm2F4RAAoJELqXzVK3
 lkFPyWwL/AmecYUT1fby4BgodpsNYKnXazKHpsIXy7YsDjNlU3xf/fcPN3vtCegwhCJsA+lwZ04
 6tW13HMXpIYATphufyLRh9pT1Kjj8Pbo2TAbx98TBn1z3ZcJAxYjN9Tvw/SZ5iCuBzl46YaRbjl
 XcbwbRE118OhI4oRB/UlE0GPIpp0Svw/qLZybfzpz0vWr1i5kehIpMfii8p80+Uq/4cGnvxnRBh
 h4ATTe05nkRMIC7ERLuvHJ+7Rl9ZeyI1KyA4NlfUQVHuzDC64dvioyeBnqvDZYUbtDMvJTwBJZA
 883CD6c+DsOf1fD+7Sep8lnNStsK5uEyVvQ3Y+8MITzkCosC7pODJegRaRrgtGzDH1FpiqqwdNl
 I6sxFj3YastLrz/YpnF4E7rimieSWRskEWrkXNmG/PcyRAbWeR2N7/K6wcIZf8RFAJLg6E/UUz7
 Wck4ZyiwYZ3MOtRa6LznsKzQgUUBhZPE2hzLHz16dZoM3xHFJXTTctjVb773zTZ5nL3qZ41+OT7
 lc=
X-Developer-Key: i=j.granados@samsung.com; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for j.granados@samsung.com/default with
 auth_id=70
X-Original-From: Joel Granados <j.granados@samsung.com>
Reply-To: j.granados@samsung.com

From: Joel Granados <j.granados@samsung.com>

Add IOMMU_HWPT_FAULT_ID_VALID as part of the valid flags when doing an
iommufd_hwpt_alloc allowing the use of an iommu fault allocation
(iommu_fault_alloc) with the IOMMU_HWPT_ALLOC ioctl.

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 drivers/iommu/intel/iommu.c          | 3 ++-
 drivers/iommu/iommufd/hw_pagetable.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 5acc52c62e8c..3d1c971eb9e5 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3718,7 +3718,8 @@ intel_iommu_domain_alloc_user(struct device *dev, u32 flags,
 	}
 
 	if (flags &
-	    (~(IOMMU_HWPT_ALLOC_NEST_PARENT | IOMMU_HWPT_ALLOC_DIRTY_TRACKING)))
+	    (~(IOMMU_HWPT_ALLOC_NEST_PARENT | IOMMU_HWPT_ALLOC_DIRTY_TRACKING
+	       | IOMMU_HWPT_FAULT_ID_VALID)))
 		return ERR_PTR(-EOPNOTSUPP);
 	if (nested_parent && !nested_supported(iommu))
 		return ERR_PTR(-EOPNOTSUPP);
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index aefde4443671..88074e459995 100644
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


