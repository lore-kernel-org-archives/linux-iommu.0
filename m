Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC3C24BBEE;
	Fri, 11 Sep 2026 14:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789138521; cv=none; b=qokn9dk6jOxCL7GXCi9q6Z/7JDurAPi171iALQ4+l/uqWy2gsju9tJ/eo0sudjTLtteZGqVXsIhn9MEB9vV6ZkwiIJQMwRlSH7y1AKbKlqabIdEnX6kIH+JRTZDMprzHsrZMXkR/TY/PakPv9YQWDkAZv4K/5L8FzuN4iQCgJA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789138521; c=relaxed/simple;
	bh=4f9XazJ84/Q81ykJOH80nzaLk4jPrDtKBF63TT3P4jY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d6MijleJfplqkGnjc49RFFnDzOQKnMtpX3rBQDDjFqLmqBqc20sgdZezdHdAYYHl4+QnOpMmLzjf0Exr10ITdElh3JSAuZg4vzoPg3Thz4++LFFGxoSvumlVIeAu2j30e1r44G1aaqqzyQzl8lyrQ5fSkdnPl5WUWzFKsJCfFrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=gbWOvfil; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="gbWOvfil"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=YL+f1x0LzF/9hCPrGz4VLEXthddv2gmGiJP9etZAd7I=; b=gbWOvfilTsBAXpD+yIHPasur+h
	xS45Z21xRqaBBAC5S2etbYyjgVzc5PCp4lDDcXaVat74Cy6CH6W8wqJaynxKW2ibP7gNjHULYR83b
	eLtoEL6bNftfKCpIrvvN7oHDAaG0LLpKhbtLf5Z3X5u2O6ODjCDbszWfToEwDUHQeUFWXxQ/2vbEe
	2e0ZRhHCgM7KtdzcWPTFU5Z4ykgub7XvVS/VbJD27ui0yGZqXp2eFSpynDJRkeHEMq1nBAbbJRa3r
	nSL4wKoGAju6LFueRQZUPckkzOSu6pOpniRTzyPy4MxLF69cgA8MtFpF7YGECrmaQty3EO+VwnEc7
	UV24km8A==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1x52em-001Mpi-0Z;
	Fri, 11 Sep 2026 14:55:12 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 11 Sep 2026 07:54:45 -0700
Subject: [PATCH 2/2] iommu/arm-smmu-v3: defer attach in kdump so inherited
 entries survive probe
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-smmu_fix_aws-v1-2-75870bf9655b@debian.org>
References: <20260911-smmu_fix_aws-v1-0-75870bf9655b@debian.org>
In-Reply-To: <20260911-smmu_fix_aws-v1-0-75870bf9655b@debian.org>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, catalin.marinas@arm.com, 
 mark.rutland@arm.com
Cc: puranjay@kernel.org, linux-arm-kernel@lists.infradead.org, 
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, rmikey@meta.com, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.16-dev-f8e9d
X-Developer-Signature: v=1; a=openpgp-sha256; l=1858; i=leitao@debian.org;
 h=from:subject:message-id; bh=4f9XazJ84/Q81ykJOH80nzaLk4jPrDtKBF63TT3P4jY=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqpBZDpszgURqDACr8/r9f69rhRqZmjzYWYzzOT
 Fe4CkbpleiJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaqQWQwAKCRA1o5Of/Hh3
 baf5D/98WYBU0cIJK2ZDbZhLhvc4inI4uQcsvLz0PI7wkGZdp4+2zbfpYOyUG/BETjNVWr+HiYU
 nyQEzhqHB07H8U71ZHwR6fLp9qDu7alAtKG8I+X3BknobqHcPuEQfwLgeWstQldBjvd1zCVMgI2
 Q539lXSgM92fbElZELEoKAKFqRecu5ZMtnm88eeedpdLTEkgDI/AzdF4xoJ3YcLIZ58gneWWEcA
 XVseN/lR7JW464C49MIdKbu3T+BtYFBQKCpOluHA0xJoNy3ZrtJOXYowOqe3GxlhjnZhZ7UfCoi
 3OEXwA8HD4ouHSnUkGE+5Mn6v9+AOpcf4T3bgwttxZobq9BlwjNpCOmLh3O5u2sd9PgxsOv+rc3
 okwXG89jOYpDkqpmuqQHjFxEIRSgi2pyU2voQG9sFzOCLzv2ZG7HYiN7/SdEohwgvXgGkXiW38g
 xVvW0SEYiyLVLFUXEGJm85d41ATSNOBmMEnx3KQ+QUbWz979/VNG9vbmjjvq/HOrLl+WxrXXAst
 KoJSgZ6rrqTu+Xhj9YwJy1RJ/RQA9VeXskALGWFRyJiJd7oxT4D9Zkq6hn8Smt8BAFQqpqBxFP1
 zlvgxtLtGcYo+3228mfdV38AoxX59F53Jq7YqeHBJGGPi1niyRKsgtzVV7oRoOe18IM6CoBlpOS
 X1+ibV1VOSgqwBQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

An inherited stream table keeps the crashed kernel's devices translating
only until the core probes them. iommu_setup_default_domain() then attaches
a default domain, replacing the inherited entry with one that maps nothing,
and the fault returns as F_TRANSLATION:

  [   37.824064] pci 0003:2d:00.0: Adding to iommu group 62
  [   38.035698] arm-smmu-v3 arm-smmu-v3.0.auto: event: F_TRANSLATION client: 0003:2d:00.0 iova: 0xfffe2965

The core already avoids this. iommu_dma_init() enables deferred attach in a
capture kernel, but only honours it for drivers implementing
.is_attach_deferred, which so far means amd and intel.

Implement it for SMMU, so we keep the inherited table until the next
DMA.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 51a809400d56a..9c8b344c75ab8 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4400,6 +4400,11 @@ static int arm_smmu_def_domain_type(struct device *dev)
 	return 0;
 }
 
+static bool arm_smmu_is_attach_deferred(struct device *dev)
+{
+	return is_kdump_kernel();
+}
+
 static const struct iommu_ops arm_smmu_ops = {
 	.identity_domain	= &arm_smmu_identity_domain,
 	.blocked_domain		= &arm_smmu_blocked_domain,
@@ -4415,6 +4420,7 @@ static const struct iommu_ops arm_smmu_ops = {
 	.get_resv_regions	= arm_smmu_get_resv_regions,
 	.page_response		= arm_smmu_page_response,
 	.def_domain_type	= arm_smmu_def_domain_type,
+	.is_attach_deferred	= arm_smmu_is_attach_deferred,
 	.get_viommu_size	= arm_smmu_get_viommu_size,
 	.viommu_init		= arm_vsmmu_init,
 	.user_pasid_table	= 1,

-- 
2.53.0-Meta

