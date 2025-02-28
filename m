Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A1125DCFA
	for <iommu@lists.linux.dev>; Fri, 28 Feb 2025 10:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740738433; cv=none; b=koXTdrTj4DMvG7Frynkjjsa0oM6h0Wl7QWnlcvGME3Mp3aICTgH5+MUJuIHfJnlPSMhlY6hVuBwlhfF34r1HGjTcE6qyDtlLICKKWSsOM4pqFFZ2crK4lcuC1EzNM/maKOmQy8WhwPNmDgx3fb6/CLghlqsstar8CTnRFCw57fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740738433; c=relaxed/simple;
	bh=EtN8+m/yPW8ipTzXPpVgB/ewpbmAWfAJIZE/0KgtnmU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ST4n2n+hbPLcsWlzPJJFaZr2xP5TCDrFUljf0+T/PKNDNH3SJ4w/32U1qIFMXhIRhX7a2JfIH7OpUTWDLXVaQTwvvlBPnaATaSc7zY8z49pF4z2JOAvUs2sf5jKniy2RLesthAUTbOG7nL51yFP7DnvXVK74DhbLCDG/q3ggcRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a0UdtqpB; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a0UdtqpB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740738432; x=1772274432;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EtN8+m/yPW8ipTzXPpVgB/ewpbmAWfAJIZE/0KgtnmU=;
  b=a0UdtqpBZJGALtGywlG450Z1k0BXDnbPWLd9gIxyw6Yvvw+wU2lphlUA
   6eyBe3vDnNzW7gnEihbX5zJwzobeOsrIXn1lRwxYgqL1CsRn8nnqAnKqO
   XkegyU5VVypMcPnZzU0vX/CSAx7FpyWvKYQphCJFXkDGaALSwXqnnfavq
   kARwRrhJoS4/KEMgHoi2i815cNO4/WleQLqBSLeZH/lxtCNZ5kVAFdZNz
   6xqKmF/7JHv+etRFcLKLih937mz0ppfT2cfRHX5AUGvvRBib6u8Qj79k2
   xMug5qjQeylpZlFxAChHhj+dgLka0gI3XUuZVwpZ5qHsSmZJwSp7SKa8+
   w==;
X-CSE-ConnectionGUID: Xja+mMnuQ9ekv7vXu/fETw==
X-CSE-MsgGUID: i5HfXpPVSuqKEhp5rDzLlA==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="45313077"
X-IronPort-AV: E=Sophos;i="6.13,322,1732608000"; 
   d="scan'208";a="45313077"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 02:27:11 -0800
X-CSE-ConnectionGUID: jVvTGlFfQ7Wm0zU3+dyRpw==
X-CSE-MsgGUID: C72strVIT2mwAdAFt1YtTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,322,1732608000"; 
   d="scan'208";a="121909445"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa005.fm.intel.com with ESMTP; 28 Feb 2025 02:27:10 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Jerry Snitselaar <jsnitsel@redhat.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] [PULL REQUEST] iommu/vt-d: Fixes for v6.14-rc5
Date: Fri, 28 Feb 2025 18:27:24 +0800
Message-ID: <20250228102726.3429268-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Joerg,

The following fixes have been queued for v6.14-rc:

- Fix suspicious RCU usage splat
- Fix passthrough for devices under PCIe-PCI bridge

They have been reviewed and tested. Can you please take them?

Best regards,
baolu

Jerry Snitselaar (1):
  iommu/vt-d: Remove device comparison in context_setup_pass_through_cb

Lu Baolu (1):
  iommu/vt-d: Fix suspicious RCU usage

 drivers/iommu/intel/dmar.c  |  1 +
 drivers/iommu/intel/iommu.c | 10 +++++++---
 2 files changed, 8 insertions(+), 3 deletions(-)

-- 
2.43.0

