Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E781632D6
	for <iommu@lists.linux.dev>; Mon,  4 Nov 2024 01:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730684504; cv=none; b=XFI1l2egvZUAJY8L2c25Yx3s9WaclMxEq+7XhFoTntNboqyiWzuXNve8Tf/0KuhY3HZ69h5yq2ZmuoiB8jcn1iz0VyFpQmpnykCSM36cBL1xqo3w3yVMKytJB7tSvKXrxDxua1TfNcPWkFR3mQ02Rcc0yF5soV8THVfM8LZ191Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730684504; c=relaxed/simple;
	bh=ac4eaQbKWc9lPmcDkGmWL4l9yucm8MFeYNiX3VwMwJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N8+nMwaP28/FA8g19gMdTSyDsGo6r/aSk1yCV01+/DadFMS42GbOWDSDfvt5IWd6w2vvldARbtyEVh0U6uEL2gSFYgR5XltIiVks5Q0b2w8jXOHJrP31sXoocJaDg2nEAFDl70iealY3Uz3mIYvlDJTZZeSuNkaHkjecnkDpTy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Eju212Iq; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Eju212Iq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730684503; x=1762220503;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ac4eaQbKWc9lPmcDkGmWL4l9yucm8MFeYNiX3VwMwJk=;
  b=Eju212Iq9/64FNTCyTW2rpmsKnuxjcmHpdIRKZjAEjwOnmTq60pmNF0p
   IkGrQIDJRUBR8MAp1O3PDU1FKrewU5lg6wgEkmfwegBcuF6E3ISfZUo96
   shvjPieX4GrMPoS9rygMoFg6T9FyTc+oTq49t7UyeY228eoI84poo4PZp
   DJMZoLt5OG4Dr+OuG8XnKfxq9LUq383tixtV0Cs1oMsvBGbQ1NS8G4tPG
   B7a7C0ksTLCWkwruvmyQw0XFiCgemE/WktfGh3qeE+LYMgT+LsufdyW8z
   +9Tt6I7E/Gqw8GcXHLIMlf6KMxroqdY6u7JlLAaApuSUDu/4IM2Ze1PUZ
   A==;
X-CSE-ConnectionGUID: oI1jx6WRTRyx3ftGUpzY/w==
X-CSE-MsgGUID: I5JSTjG9Tv2nAzb2qYI+1A==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30221957"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30221957"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2024 17:41:42 -0800
X-CSE-ConnectionGUID: x6X9JvjCQDGcPul1MprWwA==
X-CSE-MsgGUID: rYN8CeRdQRydEapcZlECVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="88020895"
Received: from allen-sbox.sh.intel.com ([10.239.159.30])
  by fmviesa005.fm.intel.com with ESMTP; 03 Nov 2024 17:41:42 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 15/19] iommu/vt-d: Remove the pasid present check in prq_event_thread
Date: Mon,  4 Nov 2024 09:40:35 +0800
Message-ID: <20241104014040.106100-16-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241104014040.106100-1-baolu.lu@linux.intel.com>
References: <20241104014040.106100-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Klaus Jensen <k.jensen@samsung.com>

PASID is not strictly needed when handling a PRQ event; remove the check
for the pasid present bit in the request. This change was not included
in the creation of prq.c to emphasize the change in capability checks
when handing PRQ events.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Joel Granados <joel.granados@kernel.org>
Link: https://lore.kernel.org/r/20241015-jag-iopfv8-v4-2-b696ca89ba29@kernel.org
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/prq.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/intel/prq.c b/drivers/iommu/intel/prq.c
index edda5da8ba15..621cd26504b3 100644
--- a/drivers/iommu/intel/prq.c
+++ b/drivers/iommu/intel/prq.c
@@ -222,18 +222,12 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 		req = &iommu->prq[head / sizeof(*req)];
 		address = (u64)req->addr << VTD_PAGE_SHIFT;
 
-		if (unlikely(!req->pasid_present)) {
-			pr_err("IOMMU: %s: Page request without PASID\n",
-			       iommu->name);
-bad_req:
-			handle_bad_prq_event(iommu, req, QI_RESP_INVALID);
-			goto prq_advance;
-		}
-
 		if (unlikely(!is_canonical_address(address))) {
 			pr_err("IOMMU: %s: Address is not canonical\n",
 			       iommu->name);
-			goto bad_req;
+bad_req:
+			handle_bad_prq_event(iommu, req, QI_RESP_INVALID);
+			goto prq_advance;
 		}
 
 		if (unlikely(req->pm_req && (req->rd_req | req->wr_req))) {
-- 
2.43.0

