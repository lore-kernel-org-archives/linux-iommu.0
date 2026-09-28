Received: from pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.162.73.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734DB4E73C0
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 15:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.162.73.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790609013; cv=none; b=gHun5raYacaynBsDO/IRZYtaHUNXn5dz9psYshdePulcHq2qKqMrCQFfZ+8AqXKPOHhFeJ+2feEAJfjFvh1hJ9wPz0QeUY6aKXgvggFZdWTiD+drjnbeMb6K+OuTbpQDmuejFZjhUkHBUzLqdFIU5C9B/NXHGuzBQyb7zxnl9zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790609013; c=relaxed/simple;
	bh=prL4mY5T7qdCLFQzKZtWBj5xenekzjprM/SYPDvtZrA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uVuH9k2UhEd3FD7oKfHmHdz6LzidwYbU0xoN1Q1rvScTMSneKAyUrDO8BBpVJo2ysbXNLHcsqnqiCI/9FYsKFtWSXMRmtEu6krC0I8UQK2P+jCu0hYSCg6dABrBqHIZaurmom92FH7IL5gA6YBT4bVSgC9CIkGHBo1cIBffIUBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=N/7he2Fm; arc=none smtp.client-ip=35.162.73.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="N/7he2Fm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1790609010; x=1822145010;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ssc2XGYXxWt7KSvkGE64VLhm/JYqo0izQ0v9suh6vGk=;
  b=N/7he2Fm5SIlbha/tmYZs/oZHwH8l0eBQzIkeTzSQ3xdVb9x4qQi31I6
   tNiJ6NiNNgK7LB24dfnzlLeeXIMG6WZ+3tbpbVfcewK5iUeb0gUse4Ob+
   QWqvNSVILnzE4k9HY95x3B4UBM0YUKhOfPes5vdTBZ2sBEAa5E7kinMzw
   dkUFEwl9yx5VSaaxv/3Ex5l8EuvYHsUMVJjgiulLzwRZrLaD0QnROxSaL
   bUTBQPah1WNNHPb6CTfJsoFMXHhJL89yScViAfWMiYoEbRQ/GgWKtNBqu
   pjIlFh4gbA08s+Rv5gdqNeqs1OYDRjWTlJ4h1aV//FNjenk9ri34aQtP1
   Q==;
X-CSE-ConnectionGUID: jnJ9/YN1TZSLsI2f6lzYSw==
X-CSE-MsgGUID: 9bwnKBOuR0yNrVpk5p4H0w==
X-IronPort-AV: E=Sophos;i="6.27,128,1787011200"; 
   d="scan'208";a="29644157"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 15:23:24 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.48:12407]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.13.104:2525] with esmtp (Farcaster)
 id ea5ba36c-33b9-4f1a-b9d1-70d08488d952; Mon, 28 Sep 2026 15:23:24 +0000 (UTC)
X-Farcaster-Flow-ID: ea5ba36c-33b9-4f1a-b9d1-70d08488d952
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Mon, 28 Sep 2026 15:23:23 +0000
Received: from 7cf34dda9133.amazon.com (10.106.178.42) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Mon, 28 Sep 2026 15:23:21 +0000
From: Cristian Prundeanu <cpru@amazon.com>
To: <nicolinc@nvidia.com>
CC: <iommu@lists.linux.dev>, <jamien@nvidia.com>, <jgg@nvidia.com>,
	<joro@8bytes.org>, <kas@kernel.org>, <kevin.tian@intel.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<praan@google.com>, <robin.murphy@arm.com>, <smostafa@google.com>,
	<will@kernel.org>, <leitao@debian.org>, Cristian Prundeanu <cpru@amazon.com>
Subject: Re: [PATCH v10 00/13] iommu/arm-smmu-v3: Adopt the crashed kernel's stream table for kdump
Date: Mon, 28 Sep 2026 10:23:02 -0500
Message-ID: <20260928152302.58271-1-cpru@amazon.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1788130528.git.nicolinc@nvidia.com>
References: <aqfPKIeO4lWCHlQ3@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA001.ant.amazon.com (10.13.139.88) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On Sun, Aug 30, 2026 at 04:18:01PM -0700, Nicolin Chen wrote:
> To safely absorb in-flight DMA, the kdump kernel must leave SMMUEN=1 intact
> and avoid modifying STRTAB_BASE. This allows HW to continue translating in-
> flight DMA using the crashed kernel's page tables until the endpoint device
> drivers probe and quiesce their respective hardware.

Tested v10 on AWS Graviton4 bare metal (m8g.metal-24xl: Neoverse V2, single
SMMUv3 with a 2-level stream table). On this platform, if the SMMU aborts a
NIC DMA read, firmware resets the host. An unpatched kernel fails kdump when
the NIC is still fetching from memory as the SMMU probe installs a fresh
stream table.

Reproducer: sysrq-c while the NIC receives ~100 kpps of UDP over 64 flows,
spread across most RX queues. The kdump initramfs omits the NIC driver, so
nothing quiesces the device.

Results using Amazon Linux 2023 with kdump kernel 6.18.39:

- Unpatched: 2/2 failures. The SMMU logs read and write translation aborts 
  ~2.5 s after the panic, and the host resets before the vmcore is written.

- v7.3-rc1 + this series: 3/3 complete vmcores, no translation aborts.
  The kdump kernel logs "kdump: adopting crashed kernel's stream table"
  and "kdump: retaining SMMUEN for in-flight DMA". In one run the NIC
  driver was present, so the device was also re-probed and reset.

Tested-by: Cristian Prundeanu <cpru@amazon.com>
