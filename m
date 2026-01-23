Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5FE2773CB
	for <iommu@lists.linux.dev>; Fri, 23 Jan 2026 09:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769159592; cv=none; b=fApX7wz4dOm4CFXmUGT81lRwwMcprrCVnRCqXIDZMPQvcHDj15dd2YhDu5sgaMlLaP9vxB/rA/EbWADqEpdtaEcPQ5ScZBWFJDHUwkg7JJYIMI5Srd5kjVmqoBhKYrUap/8fkFeYB/A0EBSw196rf9K0PU7miVYJFNXZd8h3u+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769159592; c=relaxed/simple;
	bh=UyRY6B7E2+Mb+aYc6YVEKoa/2xxKfoMXrn9Dletxu0k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KYOY7X7KBc+PMOebIb+gcWsR4BvS7Jun1Y8n9ctYIdhoxqjtnhuzQLDoXP23qsEK8uizm+n8HQpuTiBjZHY6QnpjKZ7zzYvYh5BEv2ww9hYyNxJaPpbTzdEIqmjhpaAMp362IX7iuHKUPYgrxOD7Q/hDrxA238wGLUgdolCqmBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=tKv77qXX; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="tKv77qXX"
Received: from 8bytes.org (p200300f6af1d9600545df990813616b7.dip0.t-ipconnect.de [IPv6:2003:f6:af1d:9600:545d:f990:8136:16b7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id E59DC1C0029;
	Fri, 23 Jan 2026 10:13:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1769159582;
	bh=UyRY6B7E2+Mb+aYc6YVEKoa/2xxKfoMXrn9Dletxu0k=;
	h=Date:From:To:Cc:Subject:From;
	b=tKv77qXXYj1X/NGOomWhMvONJPjzGUSyVQd24+RJSMdREVnM8M8DIAxu38WepyU6L
	 yOEbJSY9khGj2PYzU0WVzCIYUIw8sIUy0nVBwqYTrIV8oBdAUGIPyJO5zQkZ6SoDbO
	 5PgBTmkUTTAOPJyiVngqemqF9DctWsufDDgl5cWyRAQPY1x1YcFqndhAmA57bW9Pn2
	 EqM+7zykC/khvt2cpzt2cXoaKne0AEMLYOJdiZzFHjQXfXZhOFEiZtr+lkO+Buf/Kl
	 qeYZ40zjjzh/DqOgSDxPhKn/eB40nGvl2vEgKfzCFx3Mnk0FDdnAkYxxXpcnVk28tR
	 l6fu22H1h6Qcw==
Date: Fri, 23 Jan 2026 10:13:01 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev
Subject: [git pull] IOMMU Fixes for Linux v6.19-rc6
Message-ID: <6ikdjv5m3mq7m7fpvccuvnnqm2xwmho4ukpd5vxiwu5fk7klqs@2wtgllvskkxt>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 0f61b1860cc3f52aef9036d7235ed1f017632193:

  Linux 6.19-rc5 (2026-01-11 17:03:14 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fixes-v6.19-rc6

for you to fetch changes up to 374e7af67d9d9d6103c2cfc8eb32abfecf3a2fd8:

  iommu/io-pgtable-arm: fix size_t signedness bug in unmap path (2026-01-20 18:07:35 +0100)

----------------------------------------------------------------
IOMMU Fixes for Linux v6.19-rc6

Including:

	- AMD IOMMU: Fix potential NULL-ptr dereference in error path of
	  amd_iommu_probe_device().

	- Generic IOMMUPT: Fix another compiler issue seen with older compiler
	  versions.

	- Fix signedness issue in ARM IO-PageTable code.

----------------------------------------------------------------
Chaitanya Kulkarni (1):
      iommu/io-pgtable-arm: fix size_t signedness bug in unmap path

Jason Gunthorpe (1):
      iommupt: Make it clearer to the compiler that pts.level == 0 for single page

Vasant Hegde (1):
      iommu/amd: Fix error path in amd_iommu_probe_device()

 drivers/iommu/amd/iommu.c           | 3 +--
 drivers/iommu/generic_pt/iommu_pt.h | 2 +-
 drivers/iommu/io-pgtable-arm.c      | 2 +-
 3 files changed, 3 insertions(+), 4 deletions(-)

Please pull.

Thanks,

	Joerg
