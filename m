Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9871321D585
	for <iommu@lists.linux.dev>; Tue, 13 Jan 2026 03:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768273409; cv=none; b=ZJf1af5o09tbghOmHMdNM2geV0BOJDdneAqJMDuPm/+QsOjCwzuGfd1DPFgM4xexLtumYLK7RsPIzajTr4iuSWl72IbhskI/s/vC02K4+VH9v55KCsrqrMHcGOOXtxL7bd2NHKopGGggCRTtBfM7zIlu3Chkp7I7uXJ46PNkwvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768273409; c=relaxed/simple;
	bh=g5yUDL3k+4UQGZtgK+YQ71KOtUGbF4VEuXLBs1cYCkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Vd0KH0NAeDVts2UmpcMdH+e0cZQYrNkEuiuFsBlrZ8FylTye3p6LPdQESNpsAAp1fprtY5BpkUVeWdfJJ1Y4NRKSXvy/jKw/MqFhtfRj+csERGytRsfsl+EjUeEKmn4Qkl1my4LIC1G/5xYXWVysMD6V9OKAnl8oynEJzfA7+ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CnQzokip; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CnQzokip"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768273409; x=1799809409;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=g5yUDL3k+4UQGZtgK+YQ71KOtUGbF4VEuXLBs1cYCkQ=;
  b=CnQzokipDXCUnvde6fDnf5C501I0XjngSN8ecpsAfChXMpLF6UafKYAA
   a5Dzo1r9Wnvd87PEMxy7tDwNW8IkXrsRQTdrxRt4mR8wpJJKndOij+4BH
   wDLcCjxw/KlHG6p+TAv1vz9krvaBSux9EVtxpobiZ6KLbDNS8A/LAHtRk
   ZRzymrtXVC0POt4fXfrnMPbRvl8jlDe7dXe4MPaPT3BPgCAisqXVDoQgz
   7gcXpFO9NC1wKOTIeavriHAikawVHU7M9n9TItPOutUGERGpi9DElIwK8
   GHB1oFVHsD5LGO9y9UwpWxavuo60hfI/4Q1Yuq3j1kh/Yy7OCRAK2y4pY
   A==;
X-CSE-ConnectionGUID: KYzHpdFESFebjc9TZnMelQ==
X-CSE-MsgGUID: UqS/RlUZQcS827c0Zjl8kA==
X-IronPort-AV: E=McAfee;i="6800,10657,11669"; a="69607478"
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="69607478"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 19:03:28 -0800
X-CSE-ConnectionGUID: pqVdpqsmTC2U4wJf2CForw==
X-CSE-MsgGUID: +l1TPV/tTbKYsHXY1KSyCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="203466942"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa010.jf.intel.com with ESMTP; 12 Jan 2026 19:03:25 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Cc: Dmytro Maluka <dmaluka@chromium.org>,
	Samiullah Khawaja <skhawaja@google.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 0/3] iommu/vt-d: Ensure atomicity in context and PASID entry updates
Date: Tue, 13 Jan 2026 11:00:45 +0800
Message-ID: <20260113030052.977366-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is a follow-up from recent discussions in the iommu community
mailing list [1] [2] regarding potential race conditions in table 
entry updates.

The Intel VT-d hardware fetches translation table entries (context
entries and PASID entries) in 128-bit (16-byte) chunks. Currently, the
Linux driver often updates these entries using multiple 64-bit writes.
This creates a race condition where the IOMMU hardware may fetch a
"torn" entry — a mixture of old and new data — during a CPU update. This
can lead to unpredictable hardware behavior, spurious faults, or system
instability.

This addresses these atomicity issues by implementing 128-bit atomic
updates where possible and following the VT-d specification's ownership
handshake protocol for larger structures.

[1] https://lore.kernel.org/linux-iommu/20251227175728.4358-1-dmaluka@chromium.org/
[2] https://lore.kernel.org/linux-iommu/20260107201800.2486137-1-skhawaja@google.com/

Lu Baolu (3):
  iommu/vt-d: Use 128-bit atomic updates for context entries
  iommu/vt-d: Clear Present bit before tearing down PASID entry
  iommu/vt-d: Rework hitless PASID entry replacement

 drivers/iommu/intel/Kconfig |  2 +-
 drivers/iommu/intel/iommu.h | 22 ++++++++--
 drivers/iommu/intel/pasid.h | 38 ++++++++++++++++-
 drivers/iommu/intel/iommu.c | 30 ++++++-------
 drivers/iommu/intel/pasid.c | 84 ++++++++++++++++++++++++++++++-------
 5 files changed, 140 insertions(+), 36 deletions(-)

-- 
2.43.0

