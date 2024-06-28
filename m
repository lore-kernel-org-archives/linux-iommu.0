Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC72158A1C;
	Fri, 28 Jun 2024 12:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719577668; cv=none; b=tECFXTrLuZTbWoiQpfwzwPcwFwT4C75VqTdqWTbAqlE+cr8x9ptshUE4p5MpCz49Qvply7IOV9qREBgQV+8xB5tfwJy67IHm7e0c4/pPJEw1D6DgavNUpbWHMGpffcxBfvp0PBOkQ4WDzTs3hasO0GX+hMGdk89b9n1r/Jck8Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719577668; c=relaxed/simple;
	bh=z6oyl79I8NC5of/6nM0UNbEIpkWqKcp2re1J+nHNR5k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dgiAZnuWP6Ht4uTTUD/ZS6aNRti89ehNAW4FOsAKGToSl1CP2FoHDE27LpDeqh0X9l6HQSh8fCvzDF6BfnSNYQ07oMt7aV9EWp5IczSJzXazT9JIVoi2o8xxqTAUGP7E/ra42naCCWFdy11KSp4QcCMCFWQDJ/EuqybhQsOyfHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bHnwe2Kx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bHnwe2Kx"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 840C2C4AF0D;
	Fri, 28 Jun 2024 12:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719577668;
	bh=z6oyl79I8NC5of/6nM0UNbEIpkWqKcp2re1J+nHNR5k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=bHnwe2KxwVlR1KJzzEwY7jK1EwbEG1JsXlU1GZNUG7GViU8EsKQs02lEBLZZpSlSl
	 sPNN2P2oiH9LkqhIcBwH7Ehl8+9qSTEPm7yCr5j7MkNhzj4BWiIEZz2TohPS37cCSo
	 I6k2ggwEVPBEifjk65NX5Ojw8bQfaxG+M1TZLJNw618yf10LzQCH94G/5Cd560bqoa
	 kJMyrvV94lg/tDBjZ3+8R296Gl5SRsR4hi5Nwf4rHCoP1z7qEzkzWrMxWxFwCUHx3n
	 C0ON8KombicJ28G+5al8lgwSwsDj46bFB07l89hwuPP5d8xN8icjJlnRduwTudLBZv
	 HWbbe0ZBspGcg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7610EC3065B;
	Fri, 28 Jun 2024 12:27:48 +0000 (UTC)
From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Date: Fri, 28 Jun 2024 14:27:43 +0200
Subject: [PATCH RFC 5/5] iommu/vt-d: Remove dev_iommu_priv_get call from
 domain_get_id_for_dev
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240628-jag-revisit_cache_tag_assign-v1-5-a0c19063c983@samsung.com>
References: <20240628-jag-revisit_cache_tag_assign-v1-0-a0c19063c983@samsung.com>
In-Reply-To: <20240628-jag-revisit_cache_tag_assign-v1-0-a0c19063c983@samsung.com>
To: David Woodhouse <dwmw2@infradead.org>, 
 Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Joel Granados <j.granados@samsung.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1737;
 i=j.granados@samsung.com; h=from:subject:message-id;
 bh=bSKT5KATPjuI2PxohgEgtnVEXQsN8h24B4pOY9NhzjU=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGZ+rEF2V7Oo9xvBBkRnBcyi7uYIJn2E2BmRL
 zd6A97flRB21YkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJmfqxBAAoJELqXzVK3
 lkFPc4sL/RP2u/N7pZpUkjwF9ibuOdDKPQq0mcziIN7z5zfCccwR8R5f28tiBqm36muQHDl3qVE
 b827WJyDMCL/DX2xxrJTBpjp5dK0mHykkG3RJ4RCV8FawkmJf7dZus7Knc80cToJNl+7baUGdFP
 0iOflA4jFxAIOQRS03F4+gj6NLIwkskCHNi/WQFz+pbkia1uBdd3swWzbqIAygVmswB0blfRN6U
 rkOc0E3WRWU6dGBigInYECE2YF1z14kJwzScXiptlXUP/5jSi2f65k0iwlK1CV4pBVVNN/USNO5
 vemGoTl1yPL8RCHMoLShNtc4Z1unj6CK7zCn6QsanxX49UT0Gp2/yOxZDb0ZrDHLNzB0K1G9TBO
 YhntrSay+2lqRYzp2s+QIAkhKLkLWGdvCrxpnvMN4cx+E05EKMo5oug1tfRQ4ISCwz9Yh0R+Kkr
 epg/Nod559pIr+Um5Yx6eWnjR6msc473VzqHPXAilzwSkwnxds3QegrN+CospmIlMhmle9VBof4
 8I=
X-Developer-Key: i=j.granados@samsung.com; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for j.granados@samsung.com/default with
 auth_id=70
X-Original-From: Joel Granados <j.granados@samsung.com>
Reply-To: j.granados@samsung.com

From: Joel Granados <j.granados@samsung.com>

We don't need to run dev_iommu_priv_get as we already have the struct
intel_iommu. Pass the intel_iommu instead of the device and rename the
function to domain_id_for_iommu to express what it is really doing.

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 drivers/iommu/intel/cache.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/intel/cache.c b/drivers/iommu/intel/cache.c
index c630f4485a06..e55d700fcd29 100644
--- a/drivers/iommu/intel/cache.c
+++ b/drivers/iommu/intel/cache.c
@@ -147,11 +147,9 @@ static void __cache_tag_unassign_parent_domain(struct dmar_domain *domain,
 		cache_tag_unassign_type(domain, tag_id, CACHE_TAG_NESTING_DEVTLB);
 }
 
-static u16 domain_get_id_for_dev(struct dmar_domain *domain, struct device *dev)
+static u16 domain_id_for_iommu(struct dmar_domain *domain,
+			       struct intel_iommu *iommu)
 {
-	struct device_domain_info *info = dev_iommu_priv_get(dev);
-	struct intel_iommu *iommu = info->iommu;
-
 	/*
 	 * The driver assigns different domain IDs for all domains except
 	 * the SVA type.
@@ -178,7 +176,7 @@ int cache_tag_assign_domain(struct dmar_domain *domain,
 		.pasid = pasid,
 		.iommu = info->iommu,
 		.dev = dev,
-		.domain_id = domain_get_id_for_dev(domain, dev),
+		.domain_id = domain_id_for_iommu(domain, info->iommu),
 	};
 	int ret;
 
@@ -209,7 +207,7 @@ void cache_tag_unassign_domain(struct dmar_domain *domain,
 		.pasid = pasid,
 		.iommu = info->iommu,
 		.dev = dev,
-		.domain_id = domain_get_id_for_dev(domain, dev)
+		.domain_id = domain_id_for_iommu(domain, info->iommu)
 	};
 
 	__cache_tag_unassign_domain(domain, &tag_id, info->ats_enabled);

-- 
2.43.0


