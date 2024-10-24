Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC46E1B21AB
	for <iommu@lists.linux.dev>; Thu, 24 Oct 2024 09:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729761898; cv=none; b=m0oGTsOFezzB6GbSsW2uo68du43NxIme+mVBZQbOuB/Ns7CDdU1eGljeJ6lRfrKAp/gbA8mThoKNAqhcRh20qBAx1r0yHQFzYHu5W61UJuVG8FdKQVAHrE4EkR2vqfKauGYATvE54v3foQ1PEjdDlyTuqAmliuQ4gdueHPZKZ+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729761898; c=relaxed/simple;
	bh=Yy0+R3nQ5ZTLp7mJ07qu9riQztocucCCQTh/qkOpXeE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cgHqwNkCPreKHiGgLs2hCWhj7x1RO2FRRbykvb3W75TpGzNc7M5mEsaE/SqAVPTTmcWHWE4Bw2Lfp4h+jhYLl54Lxn084USslXqCaG0tw1zyFkxD6AvMTjcA9B5UowCmN4uL/K2Ta3PhhDAqWq0gdd4wjAZfG67ZHWzUCdvqhEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EDBdkMpN; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EDBdkMpN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729761896; x=1761297896;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Yy0+R3nQ5ZTLp7mJ07qu9riQztocucCCQTh/qkOpXeE=;
  b=EDBdkMpNKwxBGN8Pz3V2XMzPIpC6X3kCg8lnSBisLH/L4HbllOQJ4etj
   QRwWutsoQPkzx0jaLytP215ebf9HUJfukHKha7JwWfJkhjOs0LY81zdde
   T2EWZAuoA1OIk2dIyqfpW4CFZs8RymmVUCXJjaVsrneIdKdgnMJK81gqX
   p86aW8T6ShUfpy7Jbz6AkMZcAiU7UR1nLE8wzjszMVbnhPIB5qMQU7S8o
   OlLwvG2H7d4LKB5qCihJPFdtEt0Rh6nhkFC1OzrXO7evgdsG5hNsOq8AQ
   0w1V/ls+o/T1CpmbFJfoZSXTZgdQ3SfhL6/PUxLsx6lFhK9TakpFeCU0X
   w==;
X-CSE-ConnectionGUID: KSo429yTSFSCuC6VZqYL2Q==
X-CSE-MsgGUID: QCO0AH3TR0WbgTphfRpDcQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="40501233"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="40501233"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 02:24:56 -0700
X-CSE-ConnectionGUID: O2kx0rG+SK6WUC8eM1s/GQ==
X-CSE-MsgGUID: /3ggvvb0SZCxu/ZOmPff5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,228,1725346800"; 
   d="scan'208";a="80705034"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 02:24:54 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: dwmw2@infradead.org,
	baolu.lu@linux.intel.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	chao.p.peng@intel.com,
	Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v3 0/2] vtd: Minor cleanup
Date: Thu, 24 Oct 2024 17:21:44 +0800
Message-Id: <20241024092146.715063-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This cleanup the vtd dump code to dump lower entry after check current
level entry's present bit. Also fix the print to avoid confusing.

See patch log for details.

Thanks
Zhenzhong

Changelog:
v3:
- Fix a missed check
- Refine commit log further

v2:
- Add Fixes tag in patch1 (Baolu)
- Refine commit log in patch2 (Baolu)


Zhenzhong Duan (2):
  iommu/vt-d: Fix checks and print in dmar_fault_dump_ptes()
  iommu/vt-d: Fix checks and print in pgtable_walk()

 drivers/iommu/intel/iommu.c | 40 ++++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 14 deletions(-)

-- 
2.34.1

