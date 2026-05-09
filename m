Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9E4372673
	for <iommu@lists.linux.dev>; Sat,  9 May 2026 02:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778294777; cv=none; b=t5NpuDhz24FG/k6lnwrywf4+zdjZH2eaDABbrxiWRtXmjJUujoAFMLxzrPGfAvoeoOLM/loGdZRSyRMB8eYajqISGpAx3cv/0Tp9gDKM0/MwSyDIY848LR3VSpbD8n92R7uEn7pp33maX07pnWoaBKaniQGERSa1VdbZGM90LvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778294777; c=relaxed/simple;
	bh=hiXOJAH3kOKC+UzumuhtrUJjVAXCKeJ2HyCBjRfnENo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=coUH8r/A2vXeCGqN1ZzAzW2mk8oU4aKtjStjGwm1SJR91gskgUK+lT6+DihBVnXq43CAdkd6uPzzWtcSIBAoUC9o8eHDtsWkbpWg8qJU/cp/DureLjwNNAebq6HATb5nns97LYanG/qvOEvKX6i1I8wBjvEg73dVSQoa71MGwgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K35x/TJr; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K35x/TJr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778294776; x=1809830776;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hiXOJAH3kOKC+UzumuhtrUJjVAXCKeJ2HyCBjRfnENo=;
  b=K35x/TJrkRpxnFYVLYqYsxX8if690/FY775v3hIz9iblQIHtwMrqoxnA
   vN8kR/5yMQv/xiukc89plEMGQP0DNBlYI/AEEWwQL+6QrgmRsZcqnKWv7
   Mf+UmDcD0plwUTOarMMccbhgmf7C0a3m2fGrPgC7siVjjO6ZPLCQMLZQ8
   KenR167HuS4i9xKltMSWXxOf3AnAE/sgRBIMEFGypxT/yTFSEhCRIMx9N
   bs5/bFwkAVhhvweBGZaHI2jrz6spcqdXPr86039QOjwHCkbQdrvpvCR3a
   +Z7VAuvZAXwQanAqClGjIs4GgiHgTAG/KWZwNwo1s+4OQc6zJosLOTo/C
   g==;
X-CSE-ConnectionGUID: psKMVnlOTDCM2MK3+vSRBg==
X-CSE-MsgGUID: pqFw7eqcTzyULH1p5SE4qA==
X-IronPort-AV: E=McAfee;i="6800,10657,11780"; a="83142488"
X-IronPort-AV: E=Sophos;i="6.23,224,1770624000"; 
   d="scan'208";a="83142488"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 19:46:15 -0700
X-CSE-ConnectionGUID: dbZKkeTHQSu51BZwS/xmyQ==
X-CSE-MsgGUID: cRPqfYtcT4KjJywK8+bLkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,224,1770624000"; 
   d="scan'208";a="236103466"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa010.jf.intel.com with ESMTP; 08 May 2026 19:46:13 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>,
	=?UTF-8?q?Naval=20Alcal=C3=A1?= <ari@naval.cat>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] [PULL REQUEST] iommu/vt-d: Fixes for v7.1-rc
Date: Sat,  9 May 2026 10:43:43 +0800
Message-ID: <20260509024348.3516523-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Joerg,

The following fixes have been queued for v7.1-rc. They aim to fix the
following issues.

- Apply an existing quirk for Q35 graphic device.
- Skip dev_pasid teardown for the blocked domain to avoid out-of-bounds
  access.
- Return early if dev_pasid is missing to prevent NULL dereference or
  UAF.

These patches have been reviewed and tested and are ready for merge.
Please consider them for iommu/fix branch.

Best regards,
baolu

Naval Alcalá (1):
  iommu/vt-d: Disable DMAR for Intel Q35 IGFX

Zhenzhong Duan (2):
  iommu/vt-d: Fix oops due to out of scope access
  iommu/vt-d: Avoid NULL pointer dereference or refcount corruption

 drivers/iommu/intel/iommu.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

-- 
2.43.0

