Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152471E4A6
	for <iommu@lists.linux.dev>; Fri, 28 Jun 2024 12:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719577902; cv=none; b=kM1Qb31SZRePh/ZflvTQAUCZYDru8UQ8bcBVtT0RfRdi560sdhhg9DRM29HYAWrSGU6oh8lGotjUJNxl9GQHH3eAi50x0zZHiVTE/ouTMhxb0LeXkhCkPr4wtSWcvVjzdO7cYUftfpDVPM15DqnG3GOqsfy/culA8dyoL7bBLN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719577902; c=relaxed/simple;
	bh=LG8h8VwKnvz8MwrQEAmCy40PQMKbdLig8ollMOmC6GY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xfjihh+rBPb0NfVvDW+4MYjqBLzDySiB9DFe/ykZjxMdqeCy8xMrF4WF78pn8/2/l9q8jayRMOxSumysqJfHOGAPRIxE1c+ZTKh1tBkceIjqkxhoxxnEwVx+ftF6mv4/NEPcz/GDA5oqfABTLgyzyaCMXLX8/XhQgkb36Dzqeps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=xI4n+zDd; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="xI4n+zDd"
Received: from lemmy.home.8bytes.org (pd9fe9dd8.dip0.t-ipconnect.de [217.254.157.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id A8E821C8929;
	Fri, 28 Jun 2024 14:31:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1719577893;
	bh=LG8h8VwKnvz8MwrQEAmCy40PQMKbdLig8ollMOmC6GY=;
	h=From:To:Cc:Subject:Date:From;
	b=xI4n+zDdWx3blGyZCoPlvVYufhWTMZE9K/GEOiVUwBotXaHl/qDyfrM9cDf7b1mqg
	 y0yzWPdBOYcyjASUVYExqxzdQ+Nyk9Nc7ELIitYHj2X1TUu8oQTQHgMGf/orVV7KP6
	 7DLvJF+pNJHTc9uAjfoDuyymNBGASPlFnB4Gqlk4O09/pPFDyDlHZWAmqz63DHxiQU
	 4EHEffKzK2BSY6d0ctnWAkpHyzG2sH0dEEqLP2xVFfDfOJs/yI62e+mXF1Jzstared
	 Sq4CK0fToP8vJXmCEqIbaGixVwTxnVmkVU4Jst0isFm1s9WynwEU17sCbNkE9AdY0u
	 8oUVyLr14ntXQ==
From: Joerg Roedel <joro@8bytes.org>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	Joerg Roedel <jroedel@suse.de>
Subject: [PATCH] MAINTAINERS: Update IOMMU tree location
Date: Fri, 28 Jun 2024 14:31:32 +0200
Message-ID: <20240628123132.8690-1-joro@8bytes.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joerg Roedel <jroedel@suse.de>

Update the maintainers entries to the new location of the
IOMMU tree.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 MAINTAINERS | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index aacccb376c28..c48c9e772517 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1044,7 +1044,7 @@ M:	Joerg Roedel <joro@8bytes.org>
 R:	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
 L:	iommu@lists.linux.dev
 S:	Maintained
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git
 F:	drivers/iommu/amd/
 F:	include/linux/amd-iommu.h
 
@@ -11156,7 +11156,7 @@ M:	David Woodhouse <dwmw2@infradead.org>
 M:	Lu Baolu <baolu.lu@linux.intel.com>
 L:	iommu@lists.linux.dev
 S:	Supported
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git
 F:	drivers/iommu/intel/
 
 INTEL IPU3 CSI-2 CIO2 DRIVER
@@ -11529,7 +11529,7 @@ IOMMU DMA-API LAYER
 M:	Robin Murphy <robin.murphy@arm.com>
 L:	iommu@lists.linux.dev
 S:	Maintained
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git
 F:	drivers/iommu/dma-iommu.c
 F:	drivers/iommu/dma-iommu.h
 F:	drivers/iommu/iova.c
@@ -11541,7 +11541,7 @@ M:	Will Deacon <will@kernel.org>
 R:	Robin Murphy <robin.murphy@arm.com>
 L:	iommu@lists.linux.dev
 S:	Maintained
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git
 F:	Documentation/devicetree/bindings/iommu/
 F:	Documentation/userspace-api/iommu.rst
 F:	drivers/iommu/
-- 
2.45.2

