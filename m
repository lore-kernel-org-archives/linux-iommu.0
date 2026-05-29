Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F66633067C
	for <iommu@lists.linux.dev>; Fri, 29 May 2026 11:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780053134; cv=none; b=M7+8DrCdv1nW6f9tl41eD0JPi3WAVtUIpu1ZKU9PcHxYYSnO7ga4GuUU2aa7Q+VOS0F1QtzzDBttNOKju9W/gupKd1NK1/fVQxsZkvWBBXM4KIVxIr48nZNazDPWgFt+u/O+mgfWR7A2lTyiNyJWFLEjwQrOL7lLPOJaPQ1AH3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780053134; c=relaxed/simple;
	bh=dq0oljOFtm1ElFVmTZftrBl4pcZTfwkLjJ33K9hHtII=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=c7kr7BuPP51MJN07Ao/dosna8RLtPda1xZIvM67Kew4CFlBev04DSPH7h/BRbCoMb7jWgxTA1o3Oy9/m4Em7r4UZwhm4IFyznX8FooUArwDTQlUEv6vfpxu2fU61QxIT2I2KEUT/VcciX3VrJEqPL4u492kAVsct7wH7nJAehYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p200300f6af4fc50083a7dee7dcb1317d.dip0.t-ipconnect.de [IPv6:2003:f6:af4f:c500:83a7:dee7:dcb1:317d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id ECCF31C017D;
	Fri, 29 May 2026 13:12:03 +0200 (CEST)
Date: Fri, 29 May 2026 13:12:02 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev
Subject: [git pull] IOMMU Fixes for Linux v7.1-rc5
Message-ID: <ahl0UR5Z-mkv5wFB@8bytes.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 5200f5f493f79f14bbdc349e402a40dfb32f23c8:

  Linux 7.1-rc4 (2026-05-17 13:59:58 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fixes-v7.1-rc5

for you to fetch changes up to 00c257948900fae69dae2a055b378edf09aacf6e:

  MAINTAINERS: Add my employer to my entries (2026-05-28 13:52:54 +0200)

----------------------------------------------------------------
IOMMU Fixes for Linux v7.1-rc5

Including:

	- Fix compile warning with gcc-16.1

	- Intel VT-d: Simplify calculate_psi_aligned_address()

	- MAINTAINERS updates

----------------------------------------------------------------
Arnd Bergmann (1):
      iommu, debugobjects: avoid gcc-16.1 section mismatch warnings

Jason Gunthorpe (1):
      iommu/vt-d: Simplify calculate_psi_aligned_address()

Joerg Roedel (2):
      MAINTAINERS: Add Vasant Hegde to reviewers of AMD IOMMU
      MAINTAINERS: Add my employer to my entries

 MAINTAINERS                         |  5 ++--
 drivers/iommu/intel/cache.c         | 51 ++++++++++++++-----------------------
 drivers/iommu/io-pgtable-arm-v7s.c  | 18 ++++++++-----
 include/linux/compiler_attributes.h | 11 ++++++++
 lib/debugobjects.c                  |  2 +-
 5 files changed, 46 insertions(+), 41 deletions(-)

Please pull.

Thanks,

	Joerg
