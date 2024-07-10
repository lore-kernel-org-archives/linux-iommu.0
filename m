Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457E480C15
	for <iommu@lists.linux.dev>; Wed, 10 Jul 2024 08:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720600604; cv=none; b=nBKkSXZ02t41xl46wz6AwmHmn7gIWXk9iYwupb/KXxfmpV2gFvVSaKYbgVkOg2Uzg9pEaPFqUAiNhA6QT+Na/1hyU+1QLv4eKx20RHiOVv0code9E8ZE2iV9HRLoF4dBwvRDKRRqDlorgvBemJJ1mWXwoxPAeRN/1fqknq0MEck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720600604; c=relaxed/simple;
	bh=UhCCWJEn6oVsJ1nUvHZvdUm6DfrrEniO2iSlSPYCVNI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pg96DfAXE4JeDs8MI//Gku2xlTxy9u49CuLjFZa4H6x0sjEMS2FQPm2g3t6yOYvHb6tFFPxiQONsDqtIwyv9WOKG8HPn0eLa7hcDFVZdbLVmuUA0m7/t4qC/lcAiy9dhLNP9ld7ENGdecBRmrZgiTJK7IFWe0Jw6fIODz3hAgSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RvIg5U5g; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RvIg5U5g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720600603; x=1752136603;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UhCCWJEn6oVsJ1nUvHZvdUm6DfrrEniO2iSlSPYCVNI=;
  b=RvIg5U5gIjAiyhx7L1hYVxpJTlIAg/apg/VZDlXFXEwdMbi2qFCLWGE3
   aYmSDsgXHiBx91fGmZo5GghA9Hbjarso5DSlNqvULCfpU4VDEFk5r3mcB
   3SWsrscz/0WO/N0BSKyIYTg3I/1W1QI+lic1yLEV7Z2VPpNGXPmnB2QV4
   dX5aD+/GvLn0pso/JjNfol1crcSzLKlB7GcqkiQd/coimfGBVrir8sRKc
   U6S2V9+eADPaAK2nQwZ7pKkFc8t4jB8S51G7Ncn2kAeyhHg0QVoAuMAKs
   NJ+k0DBhWtjqqLx3P2f5dL8FrPkhYwvn1Ln6aQMIFYB2B3FDMtN9niHd6
   Q==;
X-CSE-ConnectionGUID: 9hMuBClxTrS8cbdGjTumIg==
X-CSE-MsgGUID: SIAFQLf6SYCXey6GknZDZg==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="17770985"
X-IronPort-AV: E=Sophos;i="6.09,197,1716274800"; 
   d="scan'208";a="17770985"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 01:36:43 -0700
X-CSE-ConnectionGUID: k01LmxDkRDiwdjUjuq2NIQ==
X-CSE-MsgGUID: j777sBxlT1KXmEU35Rok6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,197,1716274800"; 
   d="scan'208";a="48236177"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa010.fm.intel.com with ESMTP; 10 Jul 2024 01:36:40 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 3/3] iommu: Convert response code from failure to invalid
Date: Wed, 10 Jul 2024 16:33:41 +0800
Message-Id: <20240710083341.44617-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240710083341.44617-1-baolu.lu@linux.intel.com>
References: <20240710083341.44617-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the iopf deliver path, iommu_report_device_fault() currently responds
a code of "Response Failure" to the hardware if it can't find a suitable
iopf-capable domain where the page faults should be handled. The Response
Failure is defined in PCI spec (section 10.4.2.1) as a catastrophic error,
and the device will disable PRI for the function.

Failing to dispatch a set of fault messages is not a catastrophic error
and the iommu core has no code to recover the PRI once it is disabled.

Replace it with a response code of "Invalid Response".

Fixes: b554e396e51c ("iommu: Make iopf_group_response() return void")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/io-pgfault.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
index cd679c13752e..b8270ee5dcdb 100644
--- a/drivers/iommu/io-pgfault.c
+++ b/drivers/iommu/io-pgfault.c
@@ -229,7 +229,7 @@ void iommu_report_device_fault(struct device *dev, struct iopf_fault *evt)
 err_abort:
 	dev_warn_ratelimited(dev, "iopf with pasid %d aborted\n",
 			     fault->prm.pasid);
-	iopf_group_response(group, IOMMU_PAGE_RESP_FAILURE);
+	iopf_group_response(group, IOMMU_PAGE_RESP_INVALID);
 	if (group == &abort_group)
 		__iopf_free_group(group);
 	else
-- 
2.34.1

