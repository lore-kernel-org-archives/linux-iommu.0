Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0D6339863
	for <iommu@lists.linux.dev>; Sat, 31 Jan 2026 16:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769877100; cv=none; b=kf+ooIeMWU3WNvxUxo75ZNZDjOVyZeNdcJUK7LcRF2rbOaaURwN+teYigS0lIm5s2HybRk8utOpBsMLQxJexJaqsndxLdmisNNFTXIYWic1GPGsLG7Gg22ntH26beMNekOgn73aSamys3BD/ISHDMNTd978mV6vwqM0QoGrrWEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769877100; c=relaxed/simple;
	bh=WgFTFnEM+h7V2Tu+LuvwhkrwNKtty+C021Negjpczf0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Q3V0jH+SSHL5C9mAURi6VfGgXdOmDiqKFQm25NdlSj76lJoUqwpgrj/29hl7nLYWa9vVsUaxrTDjG6i7tjh4xi9oJnNzZx1AevCHUPRHi3LKhGTX+3y4XeuT8U8bJDDhVY/RSue/jJJB6jkbs3X8PkkZQpfAVFOJ4nwAzb7Ky+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=cndw0dCI; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="cndw0dCI"
Received: from 8bytes.org (unknown [IPv6:2001:67c:1810:f051:8b28:81fc:df36:e17d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id AF6471A174C;
	Sat, 31 Jan 2026 17:31:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1769877097;
	bh=WgFTFnEM+h7V2Tu+LuvwhkrwNKtty+C021Negjpczf0=;
	h=Date:From:To:Cc:Subject:From;
	b=cndw0dCI2a1hvi6ZVftD60ipcsw/RZFTzD6eJdqvVEJ9mCks3ii0Typ1M43wgX7CC
	 jpWKnMNVP430QLbZwobU4uUcdiIfDOabK2I+xnFktydF5FrORufUHxMwepb96rorfm
	 T/SagoqFmNxKfZjEK2baXNLCNVvMc7Cl+QivX3hol+3rmsD/gnkAifQbVJS0hbuFXw
	 Fwzs4kO20Z+psnzB2VPfXn/tZDKEtVygqAIayEabvlQwuPz0Uqeleyn3Q6f5SuPM0Q
	 pXw+w31bt9dlwhGM0DxfK0eVG8LHyAjYGPgd3KsvZIVx/JibJNgXFIAvStQ6k8B/ai
	 s6oWh8HKouBrQ==
Date: Sat, 31 Jan 2026 17:31:33 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev
Subject: [git pull] IOMMU Fixes for Linux v6.19-rc7
Message-ID: <ue7jcc4xnwaif3yjubemtfyavmebqu7n6jmlhwlvkqhyah3r3j@pytdvipbgjqr>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 63804fed149a6750ffd28610c5c1c98cce6bd377:

  Linux 6.19-rc7 (2026-01-25 14:11:24 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fixes-v6.19-rc7

for you to fetch changes up to 80f1a2c2332fee0edccd006fe87fc8a6db94bab3:

  iommu/tegra241-cmdqv: Reset VCMDQ in tegra241_vcmdq_hw_init_user() (2026-01-31 10:22:08 +0100)

----------------------------------------------------------------
IOMMU Fixes for Linux v6.19-rc7

Including:

	- Fix a performance regression cause by new Generic
	  IO-Page-Table code detected in Intel VT-d driver.

	- Command queue flushing fix for NVidia version of the
	  ARM-SMMU-v3

----------------------------------------------------------------
Jason Gunthorpe (1):
      iommupt: Only cache flush memory changed by unmap

Nicolin Chen (1):
      iommu/tegra241-cmdqv: Reset VCMDQ in tegra241_vcmdq_hw_init_user()

 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c |  3 +++
 drivers/iommu/generic_pt/iommu_pt.h            | 11 ++++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

Please pull.

Thanks,

	Joerg
