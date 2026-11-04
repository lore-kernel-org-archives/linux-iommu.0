Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793769833;
	b=D864Beidr/xC2RMqLaq9hI+ppfJadYy0ZqTu7U9vASrd5SM2md9LKNR3/mMNBU4ddsT9
	 SIcuOglYfL+dPDTkObZ/yq5YHgkABBNJQON3IlXfL9yb6hAGcdi5GPBG1qydJ1N1FSpBJ
	 oyfpKPk/Iu3s5XRiYZ4EniZ38CKmLkfKQnV/Y31R0pv4E6frZa7vXR723EPXu1Bp0OCEy
	 D0CXfcVVcizWrrW6xPohDi5lo1SIR95XtMr7nRJ2UulNQuAAGPmxZENJiqzt+n624i5K/
	 uwvA3HTcFXUs9DK6yl24JWNzpVnWL95oJEGqgx5B1HPEQ1JsivhhnCGhrE3jz5rq4ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793769833;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=GJ6oL+YulF4OVUAu/fWMcRhWnVaYgkq2HDmfs1oRGkM=;
	b=HxEBw2ZPZRbhX7ApbJ9EiRYlqrgNhZ2xcWPPZu98OQ9LTQNvCUIdEOydVXr/3ufDvycI
	 7kJuNFXbxQLAHiOf9xgr1aRm4b7H7mSSVNWFszMaHhvXdjzPpc48YTEsMsp24Fdc/sjYf
	 ojEtivpC0AlAkUssgzP1ts1kMpB5dxh3fYYCFzQWKnmpuAaPee6JfvxNYpkhcVsN2vurh
	 Ou56KTkGx7fvAu2ssPbhObHS1oX+CzW8CoH9s4yoSJtG3xfIxnQ0rRLnuevd45uj17OQM
	 fQ/MNEs68/zfl6zAZBNZ4bifh58igtk1Y071qYA68oWDI0w4qstlHJl5LxfDVC2u05w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RZQM3j65;
	arc=none smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8EE606A326
	for <iommu@lists.linux.dev>; Wed,  4 Nov 2026 05:23:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E8EE606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RZQM3j65
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793769833; x=1825305833;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WFflTUijk7JC0dp7gEcVSMz/kNt7ENb3CP45Xu5kXuk=;
  b=RZQM3j65vKX1FJdX79q4mJtJ3BvZ4pdt76OH0UJ6TLbkiTQm7Rs4mdvi
   lYb03oPMBQ9r8Go7/MXJ768e5TaWzE/4Kb9siHLhmT+aVZW8w+8+I+qUX
   CSiHQi54rCkwutHu+t/0KBDzs8x0sixcHJ1b5LVOM0kj9oZpDcoGAvD4E
   EbSPqwiX+CZ/xI7rxxzWMI6ueALaEpiZrS3wFtrsMqSF2P9OBnWuUJuJR
   o11LvA8dW4PQhVxBGbIucQZWt/GYXHOhjSCwLtzesf5DcaqlnRNbnR/6w
   hUH2uz5cGC51jsuRms+c1bW4nB6d4d9yIMLNfaXHLHbbziVBxmc6aPVeb
   A==;
X-CSE-ConnectionGUID: FqrMrTp+QESpLEzEddyGRQ==
X-CSE-MsgGUID: OeXiuUMSTtqLjtdW93kupA==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2414129"
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="2414129"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 21:23:52 -0800
X-CSE-ConnectionGUID: G+zuNfXxQzuKPcXmxu3SyQ==
X-CSE-MsgGUID: 5QDwmkjsQJC3sdrXQ5EGig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="6777201"
Received: from allen-box.sh.intel.com ([10.239.48.101])
  by fmviesa002.fm.intel.com with ESMTP; 03 Nov 2026 21:23:49 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 0/2] iommu/vt-d: Fix SVA teardown races with process exit
Date: Wed,  4 Nov 2026 13:10:56 +0800
Message-ID: <20261104051059.1345010-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a process using SVA exits while a device still has DMA and page
requests in flight for its PASID, the Intel IOMMU driver can mishandle
the teardown of that PASID. This series aims to fix two such issues.

The first is a use-after-free in the iopf handling path. After the
process exits, the later SVA unbind no longer drains the page request
queue for the PASID before the SVA attach handle is freed. Page
requests queued before the exit are then handled by
iommu_sva_handle_iopf() on the freed handle.

The second is a race between process exit and an SVA unbind of the
PASID. The mm release callback can return before the unbind completes
invalidating the PASID cache, IOTLB and device TLB. The exiting process
may then free its page tables while the IOMMU and the device still hold
translations that reference them.

Please review and comments.

Lu Baolu (2):
  iommu/vt-d: Set FPD when tearing down a PASID entry with fault_ignore
  iommu/vt-d: Serialize SVA unbind teardown with intel_mm_release()

 drivers/iommu/intel/pasid.h | 11 +++++++++++
 drivers/iommu/intel/iommu.c | 10 ++++++++++
 drivers/iommu/intel/pasid.c | 30 +++++++++++-------------------
 3 files changed, 32 insertions(+), 19 deletions(-)

-- 
2.43.0

