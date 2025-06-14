Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED934282E1
	for <iommu@lists.linux.dev>; Sat, 14 Jun 2025 14:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749909824; cv=none; b=f+HbenIWhnKmJh5ZU24B3nWOgSPUGYqTGRBGcYgGgU6+PEBrrJQXLbLKyC7Msik/JZ/NppPPjDay8ueqXPuQ3vV3rnJmSxWVTRVNu9YqRyG3q83r7QEZHqwUqeLh4DCUsXk53yfEVJE5Zkqry7m4LDPk2nLymymVx67y/Xz8S0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749909824; c=relaxed/simple;
	bh=1ciXpSXfAcIrYvrm15RgzAAXrJPQV9bgDhj5Mb4BVXk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HRXsyFn3HjgtBOhVIBZDfSPzlATKtKaW2lDeVexebsqsZ7xw9bPVr9GPKlj+wXx5F8VwsVLpRrOZxVK/qaZeNUwySOjwBsB5MtwFYD8VBEYqm3p19zR39x9kY7ee51ttMgiGj6EgoaHGPen/UFGw66ajkhHNp9zzyRv1hfR9yXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=M6oaN/Dv; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="M6oaN/Dv"
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 538EC4DE74;
	Sat, 14 Jun 2025 16:03:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1749909814;
	bh=1ciXpSXfAcIrYvrm15RgzAAXrJPQV9bgDhj5Mb4BVXk=;
	h=Date:From:To:Cc:Subject:From;
	b=M6oaN/DvaghN9IORbo1pK2oFmTaMLBL7EhrblcNuK3hyZ++ObWngPQOWppDbpCvaY
	 uSfDkA3JfGEOZwVSdCHOf/dS74KwupubrhYfwm6c6XpNmKpBzQF0MYkvyft0edPhKs
	 5ywiSO2iAO7bjIHOgD7Z4G9HGmfsHWvZLXFXGCYK7fZH05pPR+SchXhIbQenkQZBZs
	 aom26V4jAiDMOY67lKDlW0jMzDkIxWo3IYdNbiYuJLLpzPFnOl2qhwkFDP9hqlJEJw
	 lDSI42nhj+0m4N+wdQysZxpksHTStgfsRKH9EILtRzs1kVf4cnqQ22qONKZ/i5r48V
	 jUtSL7mz0qfQw==
Date: Sat, 14 Jun 2025 16:03:33 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: [git pull] IOMMU Fix for Linux v6.16-rc1
Message-ID: <aE2BNXtOVC2ss0us@8bytes.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fixes-v6.16-rc1

for you to fetch changes up to f9705d66fa7107fcd619083f7aae2afb0554a593:

  iommu/tegra: Fix incorrect size calculation (2025-06-13 17:02:31 +0200)

----------------------------------------------------------------
IOMMU Fix for Linux v6.16-rc1:

Including:

	- NVidia Tegra: Fix PTE size calculation.

----------------------------------------------------------------
Jason Gunthorpe (1):
      iommu/tegra: Fix incorrect size calculation

 drivers/iommu/tegra-smmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Please pull.

Thanks,

	Joerg
