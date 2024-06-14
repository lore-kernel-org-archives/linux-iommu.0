Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A1E17BCB
	for <iommu@lists.linux.dev>; Fri, 14 Jun 2024 14:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718376906; cv=none; b=L4XBgd0DcLfbyxDau0VRP2sRB5Tfb/Exs2ZFAWVXQNf8r/1e86BpEKSn1poDdjbZVpHJfTD9GGs4tuSAB/HEi3ILRcOy66zfFMIa5P2rGkoYOduu2Nt4Mhkar0wb7B6gkmJjHwAZxXLSfkIwgtS7pPcOxpmyd/UK4h64bGBjMj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718376906; c=relaxed/simple;
	bh=f17+SUwo19p30IJ9Aeu41ZeelWnoAOsHYBEBfgI+G80=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=n8N/iDLWNqna+3qRkwlxk76OoCciDdFDz8dTvWLC9OO3PrLT8/Xm+DkNPi1rKl+2Br/y/ldyYVrEnd7nEwawB1j0cWzX94xaUqHHCRkBa2rg5yqCndUlRKoT9l5+W3MLfTVBdEJ5JlHqvUPER6eacmR1kDO1yWpXCIa5FIB06KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=ZKQKzyCq; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="ZKQKzyCq"
Received: from 8bytes.org (pd9fe9dd8.dip0.t-ipconnect.de [217.254.157.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 32DB31C0BD3;
	Fri, 14 Jun 2024 16:55:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1718376902;
	bh=f17+SUwo19p30IJ9Aeu41ZeelWnoAOsHYBEBfgI+G80=;
	h=Date:From:To:Cc:Subject:From;
	b=ZKQKzyCqCP2RP96i6wIfxautV6v++FgBLJU1uGOLOjUq4NN8Q09FKVGTOk4beLY9S
	 /45j7GJ8U01ffjovzuZe4lABbTIZ2Vfg8wqAnCBafxjaiKpInw3WID4OLnJWhHZL0b
	 VElRWhy+TLr0+fhqmlStH7kjCLJXjg2unuQCmf0EZCQPJ12mBbqL46MRo705Kitr+Z
	 9LQfEXmWSw2rzINRBKvBq3K2ATpw307N6uDJ2sv+FpsIADpKQG7p2uUsKITLVESVNO
	 X+hCA3bXPdVMQM+bAmlUx9CWU/EihEZV7I4w9fa22cSWtDBVhCDhUFFV08Cf7D6vip
	 Mmzr4NHM7tF4g==
Date: Fri, 14 Jun 2024 16:55:01 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: [git pull] IOMMU Fixes for Linux v6.10-rc3
Message-ID: <ZmxZxT-j1B71PHQp@8bytes.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Sorry for sending a single patch, I missed that one last week and it
fixes a regression which several people reported.

The following changes since commit 83a7eefedc9b56fe7bfeff13b6c7356688ffa670:

  Linux 6.10-rc3 (2024-06-09 14:19:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fix-v6.10-rc3

for you to fetch changes up to 12243a8115f8583a6bcada7717c01fb164e23c89:

  iommu/amd: Fix panic accessing amd_iommu_enable_faulting (2024-06-13 11:16:05 +0200)

----------------------------------------------------------------
IOMMU Fix for Linux v6.10-rc3

	AMD-Vi: Fix regression causing panics

----------------------------------------------------------------
Dimitri Sivanich (1):
      iommu/amd: Fix panic accessing amd_iommu_enable_faulting

 drivers/iommu/amd/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Please pull.

Thanks,

	Joerg
