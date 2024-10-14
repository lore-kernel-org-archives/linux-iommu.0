Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7DB33C9
	for <iommu@lists.linux.dev>; Mon, 14 Oct 2024 01:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728870149; cv=none; b=SZHdu5iFJ9rVB5mabYTpRF1LxUEerNXYAR1I4llw6OVbNXppPLq6a3KUlFHkjbUcYYVTQbPfoB44u51DKZSFaibOKjcxZuPfO2OiSwsnBpWhORKgtMmp7EoiHU6QzXZQmsjIeOtWFwJKVllBigUxF9VsB7orPwAhju/unw3f7Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728870149; c=relaxed/simple;
	bh=lwHQc1vh94XFawcnVg4iOJEGxATVVe/SeDaqWrj2Jmo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ozU20L67VoHMA03zDPm5USEYV71lMpMsuBhDrWgr6/vpnNpPyEV9Rlt40jT/opZO5v7DXOVF2ShBS9bdVkBovFI+s3JkvfbIJ9TiPcQUCcs9OJIWMMfgptOu6GwXw57oqdoEk+CtQ58yMo5HrFN82L6tpak9TRrBh6nE9ao3Nm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GGTNo9f0; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GGTNo9f0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728870148; x=1760406148;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lwHQc1vh94XFawcnVg4iOJEGxATVVe/SeDaqWrj2Jmo=;
  b=GGTNo9f0N/OTZSGghnFDZVuIL8m9xi4AiUrCv+3TINhfpnKzv3eJ3mzW
   6zDzU7YMFZXc+POlm3aQkVI9AOv0JvKmWL5oP4VPZAZ3E/htPKRV1noXl
   sZ4AQoAzFnArswH0YTpPqs4TQXYwxv3imIQvZU2w5n9rwGJAVeBIXYyQR
   LZjjyKkDRzdBHxonHaJGAI1CPAmKAK8olZMsq3QALj961vd7H5SlPSPzW
   NKunILSqa+f4loI2bkeAjBDJIT6OICO8PmaupAZyCk8q46iSPY/2B0LXc
   F8bOpmzVvx5oGS838yC04cT6lqruGHm4bHa+4qR2a9s38Kf1cJiUtkLVV
   Q==;
X-CSE-ConnectionGUID: bT5uUQXLSTWVyG+CiYGpIA==
X-CSE-MsgGUID: xI00x28YR/O7V032C9RwXw==
X-IronPort-AV: E=McAfee;i="6700,10204,11224"; a="28389755"
X-IronPort-AV: E=Sophos;i="6.11,202,1725346800"; 
   d="scan'208";a="28389755"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2024 18:42:28 -0700
X-CSE-ConnectionGUID: dT1RchyFQImmVcX4Lci0yQ==
X-CSE-MsgGUID: d2idVKFlRzS1FrG+yBr3jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,202,1725346800"; 
   d="scan'208";a="77867581"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa007.jf.intel.com with ESMTP; 13 Oct 2024 18:42:26 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] [PULL REQUEST] iommu/vt-d: Fixes for v6.12-rc
Date: Mon, 14 Oct 2024 09:37:43 +0800
Message-ID: <20241014013744.102197-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Joerg,

The following fix has been queued for v6.12-rc:

 - Fix incorrect pci_for_each_dma_alias() for non-PCI devices

It fixes boot failure issues on some client platforms. Please consider
it for v6.12-rc.

Best regards,
baolu

Lu Baolu (1):
  iommu/vt-d: Fix incorrect pci_for_each_dma_alias() for non-PCI devices

 drivers/iommu/intel/iommu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

-- 
2.43.0

