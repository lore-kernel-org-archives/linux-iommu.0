Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5B42DFF1D
	for <iommu@lists.linux.dev>; Fri, 19 Dec 2025 13:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766150689; cv=none; b=rrYxssL1al6fDFKV8rFSJsUl4XN2hAXSL6KeWS7kunb2IKvcvLJvG/9hwFkqYfEndoWl8JkvsaBrjYAUmQqhuwlisPZRjp1n5/99O+RbpXyrh7J7lFd7ROBkPz5BA6xr0vbAoOs1JaBkdHM88KysMnJVNmk6PjGDfHo79nFfVLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766150689; c=relaxed/simple;
	bh=Bd2Cs+kwwebJEW98xzHYe3sGX+fXctNb3v5sO2tF+gI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mDjjXqhd0oAGeYa8nm1mZJCjzqclDlN/xm9J8Ku78sb1pqfP+z2njwxT50YKj6xVBSl49dNb7itgLbiP9v5hzdlU6JO+1drChArEP4RjkHgZqRCEWHr1ZtxkdHpO7G269IB6ZAekTZ6gLsy1Pg46uYTCm3l4IeXS2okq81bs5ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=d1iF29md; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="d1iF29md"
Received: from 8bytes.org (p4ffe00f4.dip0.t-ipconnect.de [79.254.0.244])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 594245DC80;
	Fri, 19 Dec 2025 14:24:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1766150684;
	bh=Bd2Cs+kwwebJEW98xzHYe3sGX+fXctNb3v5sO2tF+gI=;
	h=Date:From:To:Cc:Subject:From;
	b=d1iF29mdiXcxMWgQ7CEKaDDECkREGnuJDhbIieUAvgawVSGtH85B72Rf15DrZFgEx
	 0u0UAx3cR8iCldLFNdzmJjqCTMOMsDihjdUflSvGnWGzPjfCKfHRQ28kBC7XVsT7QN
	 KMMmGVDcn+U/fIfFLah0GSYF9uDeUFADW3FEtuxRORur5WSewHyfnXleORSpQHkg8p
	 qS5WvkkJqI0TkfubB4PaI8a/cGFWwcjBEoXpbBW2Y9OJzzg+Y8K46hTyFJzzW/X0G7
	 W0yEqgu1Ff9oalY2sjNl96gnHa/MgiW0PAqWAWH4P3ugno+YfomzqqVHl6BxP3R7LS
	 JwjsnVNhNa9pg==
Date: Fri, 19 Dec 2025 14:24:43 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev
Subject: [git pull] IOMMU Fixes for Linux v6.19-rc1
Message-ID: <grcmmaikbzo6dn2b6j43l2beyuci7naqdtukc3lots5dtffo3q@ecsf76as7mm2>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 8f0b4cce4481fb22653697cced8d0d04027cb1e8:

  Linux 6.19-rc1 (2025-12-14 16:05:07 +1200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fixes-v6.19-rc1

for you to fetch changes up to c7fe9384c85d31e35bb61574d7a742ba59fb27c3:

  amd/iommu: Make protection domain ID functions non-static (2025-12-19 11:23:49 +0100)

----------------------------------------------------------------
IOMMU Fixes for Linux v6.19-rc1

Including:

	- iommupt: Fix an oops found by syzcaller in the new generic IO-page-table code.

	- AMD-Vi: Fix IO_PAGE_FAULTs in kdump kernels triggered by re-using
	  domain-ids from previous kernel.

----------------------------------------------------------------
Jason Gunthorpe (1):
      iommupt: Return ERR_PTR from _table_alloc()

Sairaj Kodilkar (2):
      amd/iommu: Preserve domain ids inside the kdump kernel
      amd/iommu: Make protection domain ID functions non-static

 drivers/iommu/amd/amd_iommu.h       |  5 +++++
 drivers/iommu/amd/init.c            | 24 +++++++++++++++++++++---
 drivers/iommu/amd/iommu.c           | 27 ++++++++++++++++++---------
 drivers/iommu/generic_pt/iommu_pt.h |  3 +++
 4 files changed, 47 insertions(+), 12 deletions(-)

Please pull.

Thanks,

	Joerg
