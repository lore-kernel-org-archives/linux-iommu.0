Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0191132ED3A
	for <iommu@lists.linux.dev>; Thu, 28 May 2026 07:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779954814; cv=none; b=tC2DgxX2waa6PrDGiZ+vJ/M/EGlCD3Hc1pzc9iPjsS5e0shI4cz6tr++xChu8f0LUBj6odZBilwwl9F4ueL4dj1vx9Ti+7CEMMn5OU2+yWJKeEXMSDGRi3VaDhPF98cKFqyTq3jp541hOdAZw0NtUUS7Bs48TeUyCHyqBwCrNmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779954814; c=relaxed/simple;
	bh=3GInUAJQv4SgUcMGo9nK5jw82046aG+0jJ8z/cfPe3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OBYqrDtNNySMKLijzoBqp39VWccDDjFr+xUlk99DtE5pxqKkHrnO1PQxARWGVfR1lhWrqxKd9fTOR7gt22CJmGpR9qluM9Yg5lRE88uY9NAKwLLtSKnEk6G7YvTUvmDfTeLTgfnfoyJgfy1Z1r0oadgomd5PDasOLe307JULWH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from io.fritz.box (p200300f6af4fc5001a5b4667a2accba1.dip0.t-ipconnect.de [IPv6:2003:f6:af4f:c500:1a5b:4667:a2ac:cba1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 35A521C6014;
	Thu, 28 May 2026 09:53:31 +0200 (CEST)
From: =?UTF-8?q?J=C3=B6rg=20R=C3=B6del?= <joro@8bytes.org>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Cc: Vasant Hegde <vasant.hegde@amd.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joerg.roedel@amd.com>
Subject: [PATCH 2/2] MAINTAINERS: Add my employer to my entries
Date: Thu, 28 May 2026 09:53:18 +0200
Message-ID: <20260528075318.607955-3-joro@8bytes.org>
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

AMD pays for my IOMMU maintainer work, so mention that in the
MAINTAINERS file as well.

Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7fab8903c858..5d5b89cba095 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1144,7 +1144,7 @@ F:	Documentation/arch/x86/amd-hfi.rst
 F:	drivers/platform/x86/amd/hfi/
 
 AMD IOMMU (AMD-VI)
-M:	Joerg Roedel <joro@8bytes.org>
+M:	Joerg Roedel (AMD) <joro@8bytes.org>
 R:	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
 R:	Vasant Hegde <vasant.hegde@amd.com>
 L:	iommu@lists.linux.dev
@@ -13476,7 +13476,7 @@ F:	include/linux/iommu-dma.h
 F:	include/linux/iova.h
 
 IOMMU SUBSYSTEM
-M:	Joerg Roedel <joro@8bytes.org>
+M:	Joerg Roedel (AMD) <joro@8bytes.org>
 M:	Will Deacon <will@kernel.org>
 R:	Robin Murphy <robin.murphy@arm.com>
 L:	iommu@lists.linux.dev
-- 
2.53.0

