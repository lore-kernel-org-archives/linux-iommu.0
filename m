Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F63D22A817
	for <iommu@lists.linux.dev>; Tue, 22 Apr 2025 06:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745303856; cv=none; b=SWrA0S5xdfL4FwNPdPND57kmvdTOx8ZYrW/z7Ru7j11EZTzqokkCLeMJRNnYs7kbXM6GrJmf4ke6Ch5lmPw8vg2t+I5E/Ej1baVoRpSr/Od1JS94SH09FKN2uZH7U6KVIP6q/06RwQ30auv9FfTvCYv0yT43gM3AdieCmWuAlS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745303856; c=relaxed/simple;
	bh=1Dze2mWwX5wn3v2Me7rjICk5mPOglxfk0QtVnqVl0Pk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SXg3z03iHONHA/9G6n33V6VZzpPAITwuimhybiYNcc3e/KmaJmp/TwKRQl4pdXYg8296XUEPZmZoK2bCyTv4yNCnjk93d5gWkZV57TvvWPZd/ulSop3nTmhzR88g6txw1adRA+YZIjmh12kaQTeHtn8zWV9TtTCiapa1LJzBPBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=huaqian.li@siemens.com header.b=Jpu1iAHG; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=huaqian.li@siemens.com header.b="Jpu1iAHG"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20250422063729145f64a3d5f063c9a1
        for <iommu@lists.linux.dev>;
        Tue, 22 Apr 2025 08:37:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=huaqian.li@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=aFSjlLQwl2oifeZVuQZsGwXc+8QiEfk7kYMn6R7NvFY=;
 b=Jpu1iAHGnH/rq3mYH6InqwH+zyTKVREpn9/WBp3tyUJ7pinGckW9bDK3Oq/etQbu2OifHQ
 w4qTa2PMF2daQX4z1IZbVs+2MgqwTTTBqV06S2OM4TdHn7RDdPLO/ZyncCGMMJwnguntucb2
 17Hof90jrbaddLeFsS3o7lfTLvF1MxXjFE+Q6Pt0Ii/hTcU8e4zHQAEU9Pf1CMcppyMKfhEo
 1z4oaYGTuQ/CRFj6fyAijuHzWtzWMoYuKI/nxfvWvoTif6ELoCQopxRdKBm1ji7NZsMu0vEQ
 R9TNa0nD1Iwwbp0Pifot331A1E/keI+SXnsNg/uzNpVf0ALChWlHcYOA==;
From: huaqian.li@siemens.com
To: m.szyprowski@samsung.com,
	robin.murphy@arm.com
Cc: baocheng.su@siemens.com,
	huaqian.li@siemens.com,
	jan.kiszka@siemens.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] swiotlb: Make IO_TLB_SEGSIZE Configurable
Date: Tue, 22 Apr 2025 14:37:18 +0800
Message-Id: <20250422063719.121636-1-huaqian.li@siemens.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-959203:519-21489:flowmailer

From: Li Hua Qian <huaqian.li@siemens.com>

This patchset introduces a change to make the IO_TLB_SEGSIZE parameter
configurable via a new kernel configuration option (CONFIG_SWIOTLB_SEGSIZE).

In certain applications, the default value of IO_TLB_SEGSIZE (128) may
not be sufficient for memory allocation, leading to runtime errors. By
making this parameter configurable, users can adjust the segment size to
better suit their specific use cases, improving flexibility and system
stability.

Li Hua Qian (1):
  swiotlb: Make IO_TLB_SEGSIZE configurable

 include/linux/swiotlb.h | 2 +-
 kernel/dma/Kconfig      | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

-- 
2.34.1

