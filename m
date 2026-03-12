Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E0B39020B
	for <iommu@lists.linux.dev>; Thu, 12 Mar 2026 16:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773333710; cv=none; b=YdwmL4LQkqRl0Vn4/BhTE89AVzvTIL8pt8A9R/1LR1Ih5FtOBIVgGcNbuNJDwT6fkyqaCJkyiXPVqcL2cqdmN0jAsYxzXi7yXvyB60s1RQYOsUrE3ZPQ7rZkuhHcBOSjHez3T5SzNn3XIHE+N4y0fDKKrbYQJPhD0+j1OTJDgiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773333710; c=relaxed/simple;
	bh=/C4wmRQl6XjiMiSsTcduQj8gQYduUpZJfex6Dt/zbrk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YsW5IaJ55GA8NxC7DwlZnlePPUWBKmlaZqRg5EzNch+L+LXbLQzr39UMLIzPHQhxuL1vaUkqgISi/pW7115czIP/yxpREwLSEjKlJEfoaaiFP+71HPwovgY3fbPMIRQj1M3sVWsMTjEFNKoxMQarRRIOw0SEpCjOYP7DNj7kYo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ATViNsBd; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ATViNsBd"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773333706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GbLEtdP5TAWS4K6TedCo0ALhJ3gXxVC9418SvWWy6xs=;
	b=ATViNsBdQ23VLt6LgHkiUwHK35HvCi+t6zMHeq1tz5PZWPi/i6YLmPVOol8xHQ4f3QBt0N
	wNMnrpwmkPl9+B7pkX6+ayJ8jzpQj8hh/aZpyThA1FDOFJaX0Ob2o94K8fi6yoMbKT6S2U
	CJfEtgfGdngB1xlL287Fx1Y2qJXCE1U=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Pranjal Shrivastava <praan@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iommufd/selftest: Fix page leaks in mock_viommu_{init,destroy}
Date: Thu, 12 Mar 2026 17:40:42 +0100
Message-ID: <20260312164040.457293-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1423; i=thorsten.blum@linux.dev; h=from:subject; bh=/C4wmRQl6XjiMiSsTcduQj8gQYduUpZJfex6Dt/zbrk=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDJmb3nQ0LtU46v6yQnDjuUzBuN87poUd3MHCd4TH1jxiC 09Xybo1HaUsDGJcDLJiiiwPZv2Y4VtaU7nJJGInzBxWJpAhDFycAjAR5asMf4V67kemMvPrcKpt tjstXjl7Rvf/2huXsiRep6rKSmueX8rI8OPHdpF5/rxrZjyfKHb+1owJFYd/avfbX116MUNyQfu RKRwA
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

mock_viommu_init() allocates two pages using __get_free_pages(..., 1),
but its error path and mock_viommu_destroy() only release the first page
using free_page(), leaking the second page. Use free_pages() with the
matching order instead to avoid any page leaks.

Fixes: 80478a2b450e ("iommufd/selftest: Add coverage for the new mmap interface")
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/iommu/iommufd/selftest.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 7823142097d4..83e2215e7800 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -636,7 +636,7 @@ static void mock_viommu_destroy(struct iommufd_viommu *viommu)
 	if (mock_viommu->mmap_offset)
 		iommufd_viommu_destroy_mmap(&mock_viommu->core,
 					    mock_viommu->mmap_offset);
-	free_page((unsigned long)mock_viommu->page);
+	free_pages((unsigned long)mock_viommu->page, 1);
 	mutex_destroy(&mock_viommu->queue_mutex);
 
 	/* iommufd core frees mock_viommu and viommu */
@@ -870,7 +870,7 @@ static int mock_viommu_init(struct iommufd_viommu *viommu,
 	iommufd_viommu_destroy_mmap(&mock_viommu->core,
 				    mock_viommu->mmap_offset);
 err_free_page:
-	free_page((unsigned long)mock_viommu->page);
+	free_pages((unsigned long)mock_viommu->page, 1);
 	return rc;
 }
 
