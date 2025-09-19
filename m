Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE36314B94
	for <iommu@lists.linux.dev>; Fri, 19 Sep 2025 14:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758292187; cv=none; b=g0PzOGugwuMSP/YugCesedYzbgO2b0fb/xVBW18WHAGUxK51A8en8b7eegtLk1tlESIkrV2Z4F9pqY2X6VtArcL8gVZDF3DOLFRbIkBSdn790j2veY/hZihO0Ag7XsAu1nD/ZOIfGJEA9cnoBfcU6dpQBVrQArugb6YboJEfhx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758292187; c=relaxed/simple;
	bh=Mi3gExMBQ4XIiy+5g2vDcpOA1Dh/Ja0y9xBP5zorlBs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qfbNG68XodGzxGZko1HhcuXjpJglkUQqv+lCX8QOZo1Q3n9ZDjMUW6UFZd/q7zZnPCWf+KpCVm9RfwCzEzvxT/mwCsz6TAKUYgtiLyw+3GCUjEj9QkjrxGjivfjvHIsDQCFmKqOzwppHBkvEtqBM5VznOgCOUZ68GQdZajf4ZIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=gHCgimh+; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="gHCgimh+"
Received: from 8bytes.org (p54921b16.dip0.t-ipconnect.de [84.146.27.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 6C41F557BC;
	Fri, 19 Sep 2025 16:29:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1758292182;
	bh=Mi3gExMBQ4XIiy+5g2vDcpOA1Dh/Ja0y9xBP5zorlBs=;
	h=Date:From:To:Cc:Subject:From;
	b=gHCgimh+6Kd6ZfA56wZG7lTruRYZiFo9jdCCgLi57xC+oh33myskXF8wW9FI3lYOk
	 ef4+81tj3OHs4qx+DQjWZWCvj8pLqC94ezX+QeHvbw5eKeSW9oTuW7T6q6INnV+qG5
	 q4ljxbphMORMIYAzfmH6mSdJe3VRcEjuGNC76tq8IDnePuIAaCf+jTfoYwzqoSp/SB
	 eeBQY90PQjGWgIGdx0sB70/Y9Frg26Lp8ZOjnOHpwS2T7T9/qIsVn533v9oCh4uNb/
	 tJ9PNagzdAnDAkDTJpSiAnG7xg4ftHZaR3zIMYI5v84LH0L/KEHJWliF6DYaHGDx31
	 P+E96ELNyqcXA==
Date: Fri, 19 Sep 2025 16:29:40 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev
Subject: [git pull] IOMMU Fixes for Linux v6.17-rc6
Message-ID: <kx4extvxjpt5z6gwvqdl5a7aqvscnjtrphyok3iiswgcm3dptg@n2tmevnllyx7>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit b320789d6883cc00ac78ce83bccbfe7ed58afcf0:

  Linux 6.17-rc4 (2025-08-31 15:33:07 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fixes-v6.17-rc6

for you to fetch changes up to 1e56310b40fd2e7e0b9493da9ff488af145bdd0c:

  iommu/amd/pgtbl: Fix possible race while increase page table level (2025-09-19 09:39:40 +0200)

----------------------------------------------------------------
IOMMU Fixes for Linux v6.17-rc6

Including:

	- Fixes for memory leak and memory corruption bugs on S390 and AMD-Vi.

	- Race condition fix in AMD-Vi page table code and S390 device attach
	  code.

	- Intel VT-d: Fix alignment checks in __domain_mapping().

	- AMD-Vi: Fix potentially incorrect DTE settings when device has
	  aliases.

----------------------------------------------------------------
Eugene Koira (1):
      iommu/vt-d: Fix __domain_mapping()'s usage of switch_to_super_page()

Matthew Rosato (1):
      iommu/s390: Fix memory corruption when using identity domain

Niklas Schnelle (1):
      iommu/s390: Make attach succeed when the device was surprise removed

Vasant Hegde (2):
      iommu/amd: Fix alias device DTE setting
      iommu/amd/pgtbl: Fix possible race while increase page table level

Zhen Ni (1):
      iommu/amd: Fix ivrs_base memleak in early_amd_iommu_init()

 arch/s390/include/asm/pci_insn.h    | 10 +++++-----
 drivers/iommu/amd/amd_iommu_types.h |  1 +
 drivers/iommu/amd/init.c            |  9 +++++----
 drivers/iommu/amd/io_pgtable.c      | 25 +++++++++++++++++++++----
 drivers/iommu/intel/iommu.c         |  7 ++++++-
 drivers/iommu/s390-iommu.c          | 29 +++++++++++++++++++++--------
 6 files changed, 59 insertions(+), 22 deletions(-)

Please pull.

Thanks,

	Joerg
