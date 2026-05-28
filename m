Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B0134D382
	for <iommu@lists.linux.dev>; Thu, 28 May 2026 07:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779954814; cv=none; b=UP//tFlJzpVLiLb+4Uqch4uEEpFyTjmcvpTzXW5/dRphPR9tLdx0Tod2g+KnXFMFHaBo2KBdDDXKifcNp7uO4RHwTH3Mux8erf5sXHd0Q/3crVVDpMESkDqLmgEjeQLvbVQtYT927zQ+aBKD+H93e6DbY3+QRz0q9d1lhnGLXf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779954814; c=relaxed/simple;
	bh=swXm1zU7go58DO/YuRY2+Rw7lh2bq65VFL+rPnIaOvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L2+d1fgq3xkxXRmn3CtxxcS6mpxT9mMpEdJrJCx5KiCqmRPSCywfizkA518uAJVFETgby7XlK05jEcziEPuRGYTKUxOPIwVEmSDScdM9Tth0uVPCSshFD81ipw8uk3TlbwuRoLYXUmUXuhqMNNdjt8Kx+uHInA+7nLwrXrTCzDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from io.fritz.box (p200300f6af4fc5001a5b4667a2accba1.dip0.t-ipconnect.de [IPv6:2003:f6:af4f:c500:1a5b:4667:a2ac:cba1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id F09391C5FD5;
	Thu, 28 May 2026 09:53:30 +0200 (CEST)
From: =?UTF-8?q?J=C3=B6rg=20R=C3=B6del?= <joro@8bytes.org>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Cc: Vasant Hegde <vasant.hegde@amd.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joerg.roedel@amd.com>
Subject: [PATCH 1/2] MAINTAINERS: Add Vasant Hegde to reviewers of AMD IOMMU
Date: Thu, 28 May 2026 09:53:17 +0200
Message-ID: <20260528075318.607955-2-joro@8bytes.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260528075318.607955-1-joro@8bytes.org>
References: <20260528075318.607955-1-joro@8bytes.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joerg Roedel <joerg.roedel@amd.com>

Vasant has a long history of providing valuable feedback and testing
results for the AMD IOMMU code. Still, too often he gets not Cc'ed on
code changes, so make his reviewer status official.

Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b2040011a386..7fab8903c858 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1146,6 +1146,7 @@ F:	drivers/platform/x86/amd/hfi/
 AMD IOMMU (AMD-VI)
 M:	Joerg Roedel <joro@8bytes.org>
 R:	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
+R:	Vasant Hegde <vasant.hegde@amd.com>
 L:	iommu@lists.linux.dev
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git
-- 
2.53.0

