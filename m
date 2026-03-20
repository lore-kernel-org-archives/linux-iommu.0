Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6154D346AF0
	for <iommu@lists.linux.dev>; Fri, 20 Mar 2026 08:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773996976; cv=none; b=BuC2pHYPLPUTfoRJ8nFFc/FApid7IvP3RFNDTc/1/2fRwDiSGdbfdCS0MWKj7lGKtlVPDBc6v5cFZVl9/UVmXEH3p9G3Qpxjild0eIv39KSZr2h4fvnmwKKJY90ynonPlgeUwJQcs+zovhfAqf7qcN5XQyo4xY6OcSuOpatxoDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773996976; c=relaxed/simple;
	bh=TAVBhsDzbu8o89KxuEjShSBnY9XhKFT2HA4XUwj4E7k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fcao/C1bH104nfluktaPUfkPHN50Ofklyj+goBzv9fkcInZveXsChmoOgh6VaKhINThqPChE+WIku+el2vUCJLXK0hvBiBdIrNNUiEtQlLbEY2k0GUBS4W+jeaGsIMvScRllygPcjH6aNBrkzDkhs6iUiENUqedrUyXIubuD9Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=pX59g890; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="pX59g890"
Received: from 8bytes.org (p4ffe051a.dip0.t-ipconnect.de [79.254.5.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 685D91A5E8C;
	Fri, 20 Mar 2026 09:56:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1773996973;
	bh=TAVBhsDzbu8o89KxuEjShSBnY9XhKFT2HA4XUwj4E7k=;
	h=Date:From:To:Cc:Subject:From;
	b=pX59g890elJ92QU8xtvowdbeWFXe5Qsq4zGxP61ajQ8NEXckRRGEExfuNer3/2g0w
	 XzpPFogc156dOoyi9Np+us0sxjA0z6vp5MeMUCw2ygIQRFeqLNxlmrrnoiVIGy6dbx
	 +MnCJWok7MW0XCyh32Zqi+CBqHIGtUSnkqFVtuD7IeXDvu9u75pqNVPHXXW1rl9YXp
	 AeOPVMC4emAftXdpeiPr/NIPzVZlXRwAprgU+9V1YIFXDbAt9kBsfoOwnHwQyRkXVT
	 DqcHagVh5vE+9hO6O8txVBXXJ1qdfLHyREMX8ex1LmPmbiPv3NZaA46iibOg4Qps3e
	 ma8z5OWTiHJGg==
Date: Fri, 20 Mar 2026 09:56:12 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev
Subject: [git pull] IOMMU Fixes for Linux v7.0-rc4
Message-ID: <3slk6ukvf622iau2g6ukmmdyfjgw6rqrj2w4maph6ldkixtod7@wddilgwketrj>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit f338e77383789c0cae23ca3d48adcc5e9e137e3c:

  Linux 7.0-rc4 (2026-03-15 13:52:05 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fixes-v7.0-rc4

for you to fetch changes up to ba17de98545d07285d15ce4fe2afe98283338fb0:

  iommu/amd: Block identity domain when SNP enabled (2026-03-17 14:02:02 +0100)

----------------------------------------------------------------
IOMMU Fixes for Linux v7.0-rc4

Including:

	- Intel VT-d:
	  - Abort all pending requests on dev_tlb_inv timeout to avoid
	    hardlockup
	  - Limit IOPF handling to PRI-capable device to avoid SVA attach
	    failure

	- AMD-Vi: Make sure identity domain is not used when SNP is active

	- Core fixes:
	  - Handle mapping IOVA 0x0 correctly
	  - Fix crash in SVA code
	  - Kernel-doc fix in IO-PGTable code

----------------------------------------------------------------
Antheas Kapenekakis (1):
      iommu: Fix mapping check for 0x0 to avoid re-mapping it

Guanghui Feng (1):
      iommu/vt-d: Fix intel iommu iotlb sync hardlockup and retry

Joe Damato (1):
      iommu/amd: Block identity domain when SNP enabled

Lizhi Hou (1):
      iommu/sva: Fix crash in iommu_sva_unbind_device()

Lu Baolu (1):
      iommu/vt-d: Only handle IOPF for SVA when PRI is supported

Randy Dunlap (1):
      iommu/io-pgtable: fix all kernel-doc warnings in io-pgtable.h

 drivers/iommu/amd/iommu.c  | 15 ++++++++++++++-
 drivers/iommu/intel/dmar.c |  3 +--
 drivers/iommu/intel/svm.c  | 12 ++++++++----
 drivers/iommu/iommu-sva.c  | 12 ++++++------
 drivers/iommu/iommu.c      |  6 +++++-
 include/linux/io-pgtable.h | 10 ++++++++--
 6 files changed, 42 insertions(+), 16 deletions(-)

Please pull.

Thanks,

	Joerg
