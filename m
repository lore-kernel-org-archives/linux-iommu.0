Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59F044F54C
	for <iommu@lists.linux.dev>; Thu, 15 Oct 2026 18:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792089524; cv=none; b=si7nCuaR/cU0OKoyvvWco/SAT+/BL7nbkpquxNqB7vcIYpvhrEMHqVbD62IWm9PjCB6N/K2h4khdH/rA6eUI7SNP4SfdfCqqA3OrNfo2H90Ka+IQf9N3Hr9LnYyY7qgZmM+07qUhkB0NMSABdDYGBDoNyusQQd/gyGfwOQezqFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792089524; c=relaxed/simple;
	bh=9mJPYcRfkPIlrawmpqw/VbRGhIx8I/Gsp9LW4/LAr5E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AxlNvPAWIO8kjYA5heUrAt/Lcg7g0gSKY08HpzpKPXoHq2Ka/4a/hwyjBGz0H/hZO72t2VEY053NMkPcPw4qAGXXgwr6bMKlWxqsYd8tJwCQ+lSY1fOvq6huf4Cv1L+CG7Xo6VT4o3kqIUqjhBqA2F/FEMg83RxFSQN+gwoiHiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p200300f6af404a00bcc634c34b045ea0.dip0.t-ipconnect.de [IPv6:2003:f6:af40:4a00:bcc6:34c3:4b04:5ea0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 3E82D1C7802;
	Thu, 15 Oct 2026 20:38:38 +0200 (CEST)
Date: Thu, 15 Oct 2026 20:38:36 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev
Subject: [git pull] IOMMU Fixes for Linux v7.3-rc7
Message-ID: <atEdnsNTxq-gWf78@8bytes.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907:

  Linux 7.3-rc7 (2026-10-11 20:04:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fixes-v7.3-rc7

for you to fetch changes up to 4bcfe29021993cb167fd9bbdb849f7d7247a166f:

  iommupt/kunit: Use if_changed_rule for the kunit (2026-10-14 15:42:12 +0200)

----------------------------------------------------------------
IOMMU Fixes for Linux v7.3-rc7:

Including:

  - AMD IOMMU:
    - Revert an interrupt remapping check removal that caused GPU
      regressions on some platforms.

  - Generic page tables:
    - Fix KUnit builds with distributed Clang ThinLTO by preserving
      compiler flags, preventing x86-64 code generation from arm64
      bitcode.

----------------------------------------------------------------
Jason Gunthorpe (1):
      iommupt/kunit: Use if_changed_rule for the kunit

Joerg Roedel (1):
      Revert "iommu/amd: Remove redundant check in irq_remapping_select()"

 drivers/iommu/amd/amd_iommu_types.h   | 3 +++
 drivers/iommu/amd/init.c              | 2 +-
 drivers/iommu/amd/iommu.c             | 3 +++
 drivers/iommu/generic_pt/fmt/Makefile | 2 +-
 4 files changed, 8 insertions(+), 2 deletions(-)

Please pull.

Thanks,

	Joerg
