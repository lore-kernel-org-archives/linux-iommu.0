Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1BE2749CF
	for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 23:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771888598; cv=none; b=PcVnxlrE87312tdAtRnHUHlALefsarlDXtIQ0kkAvTlB9hWYOC6cdiqydwsTjDQuhNUTkJ4SORmHxGHgWOFMBmNibkwuY57S9VQdDrEcU9VgbXUYXmTA7E/neigVSi6tjTfXBpzA3+WG8WmYdSBhafT62b64GrbzqQNgPI27VgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771888598; c=relaxed/simple;
	bh=UUCHpGU8rj7ZCDbb/KvQ81bVmqfcjl1rDIbWLGX8J+U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RhMvbeiMNw2kGwuIBDPbVQiGldg8iAeWi962vwHgcKlXf2hopsxSiiKmqlxmvVsO07k66+CTV1lmgl8jKVsAAxmQok+FD18hbwL6Df52yv2PSZMwo/01Jt+4RX9zdZy2vUTRaAuTiPJMCx80QISnz1mDwfXUb0EjMsoz5G18dOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gk4UiEKD; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gk4UiEKD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771888597; x=1803424597;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UUCHpGU8rj7ZCDbb/KvQ81bVmqfcjl1rDIbWLGX8J+U=;
  b=Gk4UiEKDrVUh0+Ff6xA8y0pvIwllRB9c2s07oeM6zodH1oT7LUzqHVH2
   Y0FSqbonu0NUSZcJx5jS/AKOWPcjEXsxcN2B4Z5h1kp/XPBVvpSI6Ehn2
   02Nax3wNkYAYabwZepCTVCxN/YV1D0Ovj7l6ClTGJbGb3lvyfxbYw8418
   dB8vbeEj4t3z7lKlt6yiOMGxcjzDpgFYs6S9MQ/x6Dh82VLtBxrDA6ekL
   MOtstj4puKfg0s3hfID4g0MINJqtg+RzXxba5x1ktHUj7d+5787WFzKPU
   6nV9Wgk6A9xFH3basc30DOGaTcRAjBBLAM2hgETYmJjWSZcttpaUcZwPH
   A==;
X-CSE-ConnectionGUID: HK5HnfCPQSK2tUm4i5EpZQ==
X-CSE-MsgGUID: c9AKrpcmT9atSEvJ5gfGDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="71925185"
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="71925185"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 15:16:37 -0800
X-CSE-ConnectionGUID: JtC5Z+36S0m1IjPgesHPkg==
X-CSE-MsgGUID: 670nfBiQQbqlQYJajlTi0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="214944972"
Received: from jkrzyszt-mobl2.ger.corp.intel.com ([10.245.246.253])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 15:16:35 -0800
From: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To: iommu@lists.linux.dev
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, David Woodhouse <dwmw2@infradead.org>,
 Lu Baolu <baolu.lu@linux.intel.com>
Subject: UBSAN: shift-out-of-bounds in drivers/iommu/intel/iommu.h:1101:17
Date: Tue, 24 Feb 2026 00:16:32 +0100
Message-ID: <11145826.aFP6jjVeTY@jkrzyszt-mobl2.ger.corp.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173,
 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Hello,

Please have a look at 
https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/15478

For me it looks like an IOMMU issue.  I've added there a comment that 
summarizes my findings.

Thanks,
Janusz


