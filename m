Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE074185949;
	Wed,  9 Oct 2024 07:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728458898; cv=none; b=nPrdy15tPhA/i+RgcwlU+64gXndCFO5T9aFRlFop3snH9tqKeChXCiAwvEQotNt/XB5nVd6h02Am2d4RYRYWqAGHmrmuz+4e5N1pcIhbK5vCVP7u8X5Bmcofggerrnm1q4dpGWooIi+ObFaUrhQ7HeTQNd6VGWT3wi92TQuDMFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728458898; c=relaxed/simple;
	bh=E94g5wpadMHGkXggL9XnZfhEyOFQdxIfz8CYin7zreA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wp2YtUJbrCUogw2CsIXwWR+Q2gtG0bU83EhL7vsQHE28TjDwJ6nXFiUeaQvpNT5hhemnsXZl+Q1Sxf1j+WrahVwy2BBaywHz8yXAQZPVFxypqQYZKkZWmWoXyg3l+mmkvI19W+CAZoMrl0UL8JDLvO4WS93syKbFXkQoS8aExkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cGlHPSpk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cGlHPSpk"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 693A4C4AF0D;
	Wed,  9 Oct 2024 07:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728458896;
	bh=E94g5wpadMHGkXggL9XnZfhEyOFQdxIfz8CYin7zreA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cGlHPSpk3FA7iSQ8x0NC2WqSC4lycY85ahWU/kAdogSTELJurMHDbXAafK5h7QJ0m
	 T0Z7PxBPUauVS58Bu4/R+HcFyou5Np1ofLd/hB5wmwt3Nrd/F+EFCoJ2GMEecHXpFf
	 yjUaC/f7uQvM1D/eIS7xDSnXng8GZ2F2+6NjrDvajqtztDnNP2/TioXxg61+cLWfWJ
	 /Yn34WfglFPYAHEe38nbJpeR4yrRljO8DgsgiEtEQ3Q7J21oO+u6rRLREhpLS15blO
	 eBT3Xwypy/WULesi0zCxwtYZY7kaWbaOkNs70SoFBrgca6FBL4zkbz9jI6ANnXvihJ
	 mYUuDdracE1hA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F4EACED61C;
	Wed,  9 Oct 2024 07:28:16 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Wed, 09 Oct 2024 09:28:13 +0200
Subject: [PATCH v3 5/5] iommu/vt-d: drop pasid requirement for prq
 initialization
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241009-jag-iopfv8-v3-5-bd4271df5b2b@kernel.org>
References: <20241009-jag-iopfv8-v3-0-bd4271df5b2b@kernel.org>
In-Reply-To: <20241009-jag-iopfv8-v3-0-bd4271df5b2b@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>, 
 Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
 Klaus Jensen <its@irrelevant.dk>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
 Joel Granados <joel.granados@kernel.org>, 
 Klaus Jensen <k.jensen@samsung.com>, 
 Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.15-dev-00a43
X-Developer-Signature: v=1; a=openpgp-sha256; l=1474;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=7oRVYwfeS7mQ4a0yNBlw9DIcabzyWBJwpPFV6ErALFY=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGcGMI5CsxzhuZdlUI1iS7KJbFuss47HsqL1Z
 Byn1cDzioYS1IkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJnBjCOAAoJELqXzVK3
 lkFPhk4L/i5NrRHqOct+GsRdBFQ8KjLQF91pXZKhGGv/1kIzDS1oPA9ys2fvM42EAn4cMo8HJHj
 PH+E9OEciYf0ti63BrcsGkh5aKO828gj6f1tVPn5ZZCbAkR3YBzPyB/yeyMegWbi9pG8YahQZjJ
 g9Xwq4XVnQSUuqVQZ7Pj8f6Gvi8zwQ5pW7w4F4/v9UB85YxqOGYCN+BPD2oO4n/HfqfRSQqnYC5
 l9hIPymoUdlGp/3+Crajflght84wkFK7MUmKdZriI+3VAp5295M8AbV53EJgfowIV9aqM2Rrb54
 oocaxV7hSukZZxzlmRD+jt14Yp2D5uYkbv2Tuwn265mXnUZA9kIvBsAfnzFpU4YbtUzRepYqUE0
 8+YaK1/Dc9c1I3WYtiSVtzWuQNJZYivjL4GUvJeIFO8q0WuH4vpLwqAavKD+6hPwc1A1PwvQqfD
 KsyCdHPIXfH3J1jwsn6LugPBSiFVW6GKiBg5Yv6IwNDU/iu+4srwUgpq0ruovsDH+HnQbECXGY5
 u8=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

From: Klaus Jensen <k.jensen@samsung.com>

PASID support within the IOMMU is not required to enable the Page
Request Queue, only the PRS capability.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 drivers/iommu/intel/iommu.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index dd399ca09859..53bbaba847d3 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1428,10 +1428,8 @@ static void free_dmar_iommu(struct intel_iommu *iommu)
 	/* free context mapping */
 	free_context_table(iommu);
 
-	if (pasid_supported(iommu)) {
-		if (ecap_prs(iommu->ecap))
-			intel_iommu_finish_prq(iommu);
-	}
+	if (ecap_prs(iommu->ecap))
+		intel_iommu_finish_prq(iommu);
 }
 
 /*
@@ -2352,7 +2350,7 @@ static int __init init_dmars(void)
 
 		iommu_flush_write_buffer(iommu);
 
-		if (pasid_supported(iommu) && ecap_prs(iommu->ecap)) {
+		if (ecap_prs(iommu->ecap)) {
 			/*
 			 * Call dmar_alloc_hwirq() with dmar_global_lock held,
 			 * could cause possible lock race condition.
@@ -2783,7 +2781,7 @@ static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
 	intel_iommu_init_qi(iommu);
 	iommu_flush_write_buffer(iommu);
 
-	if (pasid_supported(iommu) && ecap_prs(iommu->ecap)) {
+	if (ecap_prs(iommu->ecap)) {
 		ret = intel_iommu_enable_prq(iommu);
 		if (ret)
 			goto disable_iommu;

-- 
2.43.0


