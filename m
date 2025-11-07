Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258F31A9F96
	for <iommu@lists.linux.dev>; Fri,  7 Nov 2025 10:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762512435; cv=none; b=uHs71chLQG4tfE2c9GewvRvt4+T0sPN5WJDAa6y3r9Q4rGfPHniloC5Z3HInGaiBQMj/WCmvYjCcTpJCKsFJWb8M/fFfVM+OmCgXMlY8+2V5u+J63iMjDcTJTxNimICm/wBjI7ZvhC0T97hIlrPtf090M/xBGf6bSHX0WaFbkyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762512435; c=relaxed/simple;
	bh=VgVMadMFagLBq0AEYJS0vuHVw/vbdQVZdPfcW/G0XbY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CnoEMWsuavtvVEKjL8+7FMMYr5X8KSbJk7bWhcwBNgB0e0/Ef4jWBUK8WeNnOacaTocDM7BVDhEU0aFlaLi8gKE48BQ2QKJdBHAhJ3iLiPXnbQoCfCBBt2WC8ZrJN/7SJwfmdpsNJ+hbtmp1diO/N8x4Cu+QrOAYBjEvBBJRQZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=YGXLpCKK; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="YGXLpCKK"
Received: from io.home.8bytes.org (p549214ac.dip0.t-ipconnect.de [84.146.20.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id AFCE95ABAF;
	Fri,  7 Nov 2025 11:47:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1762512430;
	bh=VgVMadMFagLBq0AEYJS0vuHVw/vbdQVZdPfcW/G0XbY=;
	h=From:To:Cc:Subject:Date:From;
	b=YGXLpCKKiYBP3U4A/8OFYvuQoR3pL3oT3/9L30FbsnloyRM4nS1P5xFqTkYIavZQQ
	 O//7/Vs6wYcrAe6hZzSbi4GkWPek/KKO0RN+66WvJ9Y2cRd6aYqg1DvyUjuKbKbyjs
	 ei7VWZX9Xvokgo20tBESGE1jQaYxQjZ/8StZVB0jfiqK5UEiduWbS6Hs7kI1GPD8qV
	 g6UdxyTttR4HJf2PC30gYPUi+Ay5seGfXU4UEAkkd5HRuTV2BE6nlho1Ojfs8ObZaS
	 SCXJM0IpoEdfTcxievR8U/k6ZyI3/6uIDIHEvSFclATWTP4TIsYYJ9hpCAPC8PM8Mw
	 sE/+qARei7zCw==
From: Joerg Roedel <joro@8bytes.org>
To: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Joerg Roedel <joerg.roedel@amd.com>,
	Thorsten Leemhuis <linux@leemhuis.info>
Subject: [PATCH] iommu/iommupt: Fix build error in genericpt unit-tests
Date: Fri,  7 Nov 2025 11:47:01 +0100
Message-ID: <20251107104701.237041-1-joro@8bytes.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joerg Roedel <joerg.roedel@amd.com>

Fix the include of iommu-pages.h in the KUnit tests for the IOMMU
generic page-table code to make the tests compile again.

Reported-by: Thorsten Leemhuis <linux@leemhuis.info>
Closes: https://lore.kernel.org/all/9844d4cb-f517-478b-9911-b6dc1a963b8e@leemhuis.info/
Fixes: 1dd4187f53c3 ("iommupt: Add a kunit test for Generic Page Table")
Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
---
 drivers/iommu/generic_pt/kunit_iommu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/generic_pt/kunit_iommu.h b/drivers/iommu/generic_pt/kunit_iommu.h
index 5d4f269627d5..22c9e4c4dd97 100644
--- a/drivers/iommu/generic_pt/kunit_iommu.h
+++ b/drivers/iommu/generic_pt/kunit_iommu.h
@@ -8,7 +8,7 @@
 #define GENERIC_PT_KUNIT 1
 #include <kunit/device.h>
 #include <kunit/test.h>
-#include <../../iommu-pages.h>
+#include "../iommu-pages.h"
 #include "pt_iter.h"
 
 #define pt_iommu_table_cfg CONCATENATE(pt_iommu_table, _cfg)
-- 
2.51.0

