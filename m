Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44034363C62
	for <iommu@lists.linux.dev>; Tue, 20 Jan 2026 06:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768890050; cv=none; b=K0o8P0QVdcKI3oJDBy4o7is7Z1kDOmyxopjrodNanGTrZKNDJEfVlfKutpG225DXT18KWH92fLB1X8YCZ0Vi5bR8V355YoWGR98Jk21KCLGDf+PgnLvTac/ARr7i4cMcV02Jx9tXPFbwTQ41MSW06GBdI5UQUrSo+3nOKDXLUgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768890050; c=relaxed/simple;
	bh=3HqSIkGpdbsew7FJQJJWSWdKteMZT3vFc5ruCuNLH0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iWe+3ws0w6CQaEf/YowNEbbhwnbWIe3eZn8Vcla1LFyxKHYw2S1cOYCOMWAxksbKdajXDGIgn+TJAAiTJgF64aUq176P6YjplIGod1IKlFGEl7XR4Dg2r6CTjA8Xx8xKxyOhBufQZDwVWVMqSZQ6CyFtcY0tdvcUrodrYSxceKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lnXe7rzP; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lnXe7rzP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768890048; x=1800426048;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3HqSIkGpdbsew7FJQJJWSWdKteMZT3vFc5ruCuNLH0Y=;
  b=lnXe7rzP/p+8ZjcCTFyRj2au9GlQ2PP+4Cgy5FK5uB93HrIWkEctnDBB
   Y6bLGqAN7Ron5fR8hAiFInvj7+Wj7YtVvKhz0/62n9DUYsuP5V3eD8wKC
   Jt+6AuGRs3BpbDGe0kz2pWWCwZmkKckpsypTvBn/frfGDwfWH0hargZWg
   hLDs50rky8QBV5wL/jKqw4fJmwCsGEEeWRPF/uM0z6HvTLtbGG7S4vz4B
   TN1nbTiDFNXF3WXP09p2R+nwhqkIlFBLvXwGLBdFmwRq9ftZXHirFqN9W
   pqI7HUQIkR1Khwl82svIA3FktNtblDFsafbT62aw0ht9+Nea/WCDfFRZg
   w==;
X-CSE-ConnectionGUID: PqzM+1caRY6NqIMu0aIDtQ==
X-CSE-MsgGUID: 507Wa2M7SlOb+efhqGyQAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="69991300"
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="69991300"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 22:20:47 -0800
X-CSE-ConnectionGUID: J0pQduAdQl6BVs3bGmrRLg==
X-CSE-MsgGUID: 8VKi1w7aTOeTyavqAD4ygA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="206464263"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa009.fm.intel.com with ESMTP; 19 Jan 2026 22:20:45 -0800
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
Subject: [PATCH v2 0/3] iommu/vt-d: Ensure atomicity in context and PASID entry updates
Date: Tue, 20 Jan 2026 14:18:11 +0800
Message-ID: <20260120061816.2132558-1-baolu.lu@linux.intel.com>
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

This addresses these atomicity issues by following the translation table
entry ownership handshake protocal recommended by the VT-d specification.

[1] https://lore.kernel.org/linux-iommu/20251227175728.4358-1-dmaluka@chromium.org/
[2] https://lore.kernel.org/linux-iommu/20260107201800.2486137-1-skhawaja@google.com/

Change log:

v2:
 - Considering that these fixes should be backported deep into old
   versions, and the previous solution relies heavily on the x86_64
   cmpxchg16b instruction, which is not friendly to backport as it might
   cause regressions on early hardware or configurations, we use the
   simple dma_wmb() approach in this version.
 - Jason proposed the entry-sync framework
   (https://lore.kernel.org/linux-iommu/20260113150542.GF812923@nvidia.com/)
   which consolidates the details of how to update a translation table
   entry in common code shared by the individual drivers, so that the
   IOMMU driver could be designed without considering the hitless or
   non-hitless replace.
 - To make life easier, I decided to split all the work into multiple
   series. The first, as it is, covers fixing the real problems in a
   backport-friendly way, and the next series covers entry-sync for
   PASID table entry updates.

v1: https://lore.kernel.org/linux-iommu/20260113030052.977366-1-baolu.lu@linux.intel.com/

Lu Baolu (3):
  iommu/vt-d: Clear Present bit before tearing down PASID entry
  iommu/vt-d: Clear Present bit before tearing down context entry
  iommu/vt-d: Fix race condition during PASID entry replacement

 drivers/iommu/intel/iommu.h  |  21 +++-
 drivers/iommu/intel/pasid.h  |  28 +++---
 drivers/iommu/intel/iommu.c  |  33 +++---
 drivers/iommu/intel/nested.c |   9 +-
 drivers/iommu/intel/pasid.c  | 190 +----------------------------------
 5 files changed, 58 insertions(+), 223 deletions(-)

-- 
2.43.0

