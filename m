Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5481275864
	for <iommu@lists.linux.dev>; Sat, 10 Jan 2026 17:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768065204; cv=none; b=mr/KuxxYda/46IGwh6XaZUOvFePNm+E5hxWmwbfa4MVBRhhxj9ePT2qmkrRdGpjlrk9Osjiof+bMH3a2o0utQrMFZogVQvDTPSZuf9jPYLx/Ad37OGM0bd1vT41V/7B6xjXw5DsDphxORGrZazkg5M9s1OsCXdrjfoxxC43Da5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768065204; c=relaxed/simple;
	bh=k8rSMeQtPRn60spX5u+ri+dDDlSy8rbLB8IeqDDAn9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mHkBjbJKorYGgG4Q05LoyR0GRA7cNQK82lLOZrlL8axoFOwJ+8X+r0qkCGJEfPLR6le4PP9d0Nda0fpT0VAEiagPRfsT18ihNkRxIaDY4Mcc2p/nggVyLT+jWGsbukiHwPjoDXQTFczM6SlVkmHILYzMSS7empZrLT11T1DXfk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=S2ZvYe++; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="S2ZvYe++"
Received: from 8bytes.org (p200300f6af1d9600c386349e42572051.dip0.t-ipconnect.de [IPv6:2003:f6:af1d:9600:c386:349e:4257:2051])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 8BA995E660;
	Sat, 10 Jan 2026 18:13:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1768065201;
	bh=k8rSMeQtPRn60spX5u+ri+dDDlSy8rbLB8IeqDDAn9Y=;
	h=Date:From:To:Cc:Subject:From;
	b=S2ZvYe++h8ajnjz2eZ6XE414FJv8d1M4I/ZccImJOPPnyiGySwuisQU/mwoqBdCyS
	 BRJubWDX0vCiaYH31sW+w4WAcl6e5s+Ke54bq8ncRw0iPiRl8L0/qpD/dtIpdNGEQ+
	 QulmqZ3jHZMhWYBtF7YW2/rgETNkHqhl5u93q10/qm1BWlgshF/TiT4F7Oj4CSiksK
	 ZjFTdR3XtfQX8YyPmuVWQumprSfrl+R13WyzcQUO6Yn0XCfcbpHrRMZHSjJIPrf9kz
	 wc6wZrXmRI1tryeygF/vavi21uzOYMxHgR5/9yR+/LSZ5+DvDz38xAVlZFzNqOvOKs
	 vLHiU5gYfiJIQ==
Date: Sat, 10 Jan 2026 18:13:20 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev
Subject: [git pull] IOMMU Fixes for Linux v6.19-rc4
Message-ID: <2zpyoiwaldo2tywqq6kiigojntryoe6hbh5pu7cjesedip7csf@e6utyv33jpmo>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 9ace4753a5202b02191d54e9fdf7f9e3d02b85eb:

  Linux 6.19-rc4 (2026-01-04 14:41:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fixes-v6.19-rc4

for you to fetch changes up to 6a3d5fda2ce464a80a9af9e358dfbab6a989ab5d:

  iommupt: Make pt_feature() always_inline (2026-01-10 10:50:45 +0100)

----------------------------------------------------------------
IOMU Fixes for Linux v6.19-rc4

Including:

	- Generic IO-Page-Table code:
	  - Several Kconfig-related build fixes
	  - Fix for when gcc 8.5 on PPC refuses to inline a function from a
	    header file.

----------------------------------------------------------------
Jason Gunthorpe (4):
      iommupt: Fix the kunit building
      iommufd/selftest: Add missing kconfig for DMA_SHARED_BUFFER
      iommufd/selftest: Prevent module/builtin conflicts in kconfig
      iommupt: Make pt_feature() always_inline

 drivers/iommu/generic_pt/.kunitconfig | 2 +-
 drivers/iommu/generic_pt/pt_defs.h    | 4 ++--
 drivers/iommu/iommufd/Kconfig         | 3 ++-
 3 files changed, 5 insertions(+), 4 deletions(-)

Please pull.

Thanks,

	Joerg
