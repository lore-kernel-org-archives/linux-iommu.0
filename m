Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95D736212E
	for <iommu@lists.linux.dev>; Thu,  5 Feb 2026 08:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770281524; cv=none; b=fkGSWvDOMiV/ebnUnmtgspO1IGx9ShZDgfBKZwxia4J4vktaeHDmzOyj6kq97AUm/ivymz5dG9cnxi0ozdhCd+anaMz2YTGfshb5RWMlhrWlSM2YiuG5ShJSm+ifPQlla1mKIsxqm5/dXJc5PrIjndUTcExl3r9Kptt9zuDxkrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770281524; c=relaxed/simple;
	bh=2nSYtxB9A5jZCoKyO18xfcwvs0z5CVwXWzdOnXCrQTk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=USPML0TeKMYZoEXyzTai6qLk44Ik512Zu7YH8sThI6WO5qUT0nmbwpUX9kCyyONVPz02/Z7RXhx7M3AHlmvYlx20H7rww69YwuQpFJqF8Sv6BpI41evBD2GBdvWo5Bgah6AHozXqZZ39Ssgh15M7Sa4du5ZwcS0mzdXHids+Tz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lJ+0Hnht; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lJ+0Hnht"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770281524; x=1801817524;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2nSYtxB9A5jZCoKyO18xfcwvs0z5CVwXWzdOnXCrQTk=;
  b=lJ+0HnhtnLGVt+TVnw46KPZ0yFKX4xAjLQuwjW9VPEM10ZLd1GmnVnrd
   BRotPVS3mYUAJfv7si8Crg/dNyvvc9i/SfOCWXhFZu/FsVFsCuwQJIoO1
   qMT133yFU2TzczTH3QoofhA+BRNuV29DF59KT2EvqQc5v3fFPX2tOQMv2
   ChXUn0NSbD4dK5vhSxMxzVj2m1Yqn3pK8Fm6m8bcPamR6o3mth/VnvFSq
   uE/m5B5BXfJohVgm+S9tC2HCQNcFjbHC0m0mehuuwzMT1sOWHVy3+ZUHk
   22IVmGpW5jGehphR1WAp8q8sZdboZS6Mn2gnHeU7dHYPwcm6eU3vlG6e6
   w==;
X-CSE-ConnectionGUID: V1k14RkqRwuGKBSBLVycPg==
X-CSE-MsgGUID: aIvvImP8RLyXMojZzfZSsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="71372068"
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; 
   d="scan'208";a="71372068"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 00:52:03 -0800
X-CSE-ConnectionGUID: sKV19m5bSlqF8X5KPDmA1w==
X-CSE-MsgGUID: +SaEz6jVQemshrBGCAPFiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; 
   d="scan'208";a="210391629"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa010.fm.intel.com with ESMTP; 05 Feb 2026 00:52:02 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Viktor Kleen <viktor@kleen.org>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] [PULL REQUEST] Intel IOMMU fix for 6.19-rc
Date: Thu,  5 Feb 2026 16:49:40 +0800
Message-ID: <20260205084941.3982847-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Joerg,

Please pull this single fix for the Intel IOMMU driver for v6.19-rc
cycle.

 - iommu/vt-d: Treat PAGE_SNOOP and PWSNP separately

Given that the 6.19-rc merge window is nearly closed, I am also okay
deferring this to the v6.20 cycle if you prefer.

Best regards,
baolu

Viktor Kleen (1):
  iommu/vt-d: Treat PAGE_SNOOP and PWSNP separately

 drivers/iommu/intel/pasid.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.43.0

