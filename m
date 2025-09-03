Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5432C158F
	for <iommu@lists.linux.dev>; Wed,  3 Sep 2025 05:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756878934; cv=none; b=flHuR5VVPeXQo4F0xvDtNQp6Sm5F9OThPOEBFHc2wsbsGDaKvQ4Iu7VotbRdpIFHGFb8SvdvDK7HBJDpbbSJU18TNKGJPIyXpXjgYEuKuWZSRbX7X7DfA69t0pxou+muY+DAk4NIbk1ZqSclHtpEI9Tx+bni1g4v8qzDN4IhU0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756878934; c=relaxed/simple;
	bh=Rzx8kcsKCQcyISgopP7x+nV9DeCniSCzH6dTymUmjnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bOwp8wV3u4yxCcx+vTj7/Mgcn67sjNaI8ayN/+EBSrC1bixGA59pQMcGMyPAC7ibPlayHZ7Y1Y2LrmH9b7iQ0XFcq6a15GrvL3Uz10/jFnMSHejlWt1C6iWUubDbCDpyu3r9gP/0EAkG0dvMFiH9BNvven6hA4yoeuz7Zks+cv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nnn2++Jw; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nnn2++Jw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756878933; x=1788414933;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Rzx8kcsKCQcyISgopP7x+nV9DeCniSCzH6dTymUmjnQ=;
  b=nnn2++JwmPAypw8wiWfwJJKAId7veUG1ujWbqeO4un/AQbgpN35z8WFz
   kSHpH2XJ4AA95ETJaSDgLQC+79z98E0qas7FkvUVsEQWqQgmS6KC8EU+r
   5EU+12Kikre8cMCrUljhu5n6joYBvcT/3wtrYIPMFA+B3Rzt9qOjm4Nrq
   EEhk1ybJBMUFafeb8xSkX8H+Lk4bD8QaMQV95kixhoR9ZRdFsC+SDNyH3
   b95vM1EPj5XVQMEDs+0A4z2Lg5XNRdfe4N2BBCn/xS1Hij0hD30f9k9np
   poavNf+j3FtERnZSGzb07hc6Ei2m+5zvk3UXMwUGT+orXz/vngr2CBmdr
   g==;
X-CSE-ConnectionGUID: zv5SP42xSQyTU5PxZq23bQ==
X-CSE-MsgGUID: SPdnk75CRTuD29UZZR5WAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="59294867"
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="59294867"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 22:55:32 -0700
X-CSE-ConnectionGUID: 3xcyKPg5TQmouZK+Qnr2nA==
X-CSE-MsgGUID: psbdj9zUSRmhlEE3OuMSLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="171868210"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa008.fm.intel.com with ESMTP; 02 Sep 2025 22:55:31 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Eugene Koira <eugkoira@amazon.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] [PULL REQUEST] iommu/vt-d: Fixes for v6.17-rc
Date: Wed,  3 Sep 2025 13:53:28 +0800
Message-ID: <20250903055329.2876815-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Joerg,

The following fix has been queued for v6.17-rc:

- Fix __domain_mapping()'s usage of switch_to_super_page()

It fixes a bug in __domain_mapping() where valid PTEs that are beyond
the affected huge page range might be zeroed out. The patch has been
reviewed and tested and is ready for merge. Please consider it for
v6.17-rc.

Best regards,
baolu

Eugene Koira (1):
  iommu/vt-d: Fix __domain_mapping()'s usage of switch_to_super_page()

 drivers/iommu/intel/iommu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

-- 
2.43.0

