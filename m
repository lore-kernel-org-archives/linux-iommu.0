Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.250.239
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795794438;
	b=WiZdstUtQZ9ks6BnI2dtGK6XiieuldT+zwb87w/pQrA4BudfTr7AVfgy0WzK1LeCRSDm
	 H/hoY5hgrQ89U889bSB7lsO5M1x06CQjRvqOGvJ3Fr1b1iGhlyfzKqrXFpOsNTxHhLv9n
	 RPsY6w7Kc97+8BEH2JR9HyDVV/RjiWfmEpdwiXj5tWxdYOB+fvoy32bsvrrcysJlKfuwi
	 JUNOr4HM6vxFcQNFesF8Mlkp1usSE8cuaBLEbo73H4NP95Ik17p7OZ1ffzKPl8QVYEnKn
	 2enZrR+RodhvIm+lfAAoQrhZ2WNLydoRwC9fuZNmdG+j1NXDdrhBWkstEmyWoKD606g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795794438;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition;
	bh=xT45iqmn7XkfzEnsB+ayMAuJFThUwN/c5yJ57J+EwXI=;
	b=DFhECqsYrH8/8WX794yZ3GYPvJZbv872u5ITDu9rQldNUw8enbaAdccsNyhl6qhWTvzb
	 DALLhDziRb/1K96RIBQZtiypmBs1nefwSpy5dEwU4VRA4bvbiqF3OP8RKpM7tEF4jqC0a
	 IlF54xjILvIU8KGDfSlik+rAiKEo8COZcR5yAXRuTSCdzx9eeHIVkdim+jf/hSvaYVQ2u
	 CHQ5Gn3BigaSFfSSK5TNKB5TXw3SFtiHva33lFPdr45iSuvu12lXaf0S7p+52KVtldRsx
	 knL4oRbeiK7KpaUqMjZUnpee4mmUUCAMNE1yWZpCzNW4CzIslvJgkd9a+JE/xKUPWDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=8bytes.org;
	spf=pass smtp.mailfrom=8bytes.org;
	arc=none smtp.remote-ip=85.214.250.239
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84B4606A31E
	for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 15:47:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B84B4606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p549216fa.dip0.t-ipconnect.de [84.146.22.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 14BA724545C;
	Fri, 27 Nov 2026 16:47:16 +0100 (CET)
Date: Fri, 27 Nov 2026 16:47:14 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev
Subject: [git pull] IOMMU Fixes for Linux v7.4-rc4
Message-ID: <awml8VcCjRQKHVXi@8bytes.org>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit b6a9fa34ce4187cb69d3c588a4bbffc31ce5db8f:

  Linux 7.4-rc4 (2026-11-22 14:57:40 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fixes-v7.4-rc4

for you to fetch changes up to 10bcc637f7a657725dd8bbcc2b30d027acee6f2d:

  iommu/amd: Mark v2 page tables incoherent on Cezanne (2026-11-27 12:18:30 +0100)

----------------------------------------------------------------
IOMMU Fixes for Linux 7.4-rc4:

Including:

  - AMD IOMMU:
    - Fix DMA failures on AMD Cezanne by flushing CPU cache lines for IOMMU v2
      page tables.

  - VeriSilicon IOMMU:
    - Keep runtime PM callbacks available without CONFIG_PM_SLEEP, fixing an
      SError on the RK3588 AV1 decoder. Avoid sleeping in hard IRQ context,
      balance runtime PM references during TLB invalidation, and flush the TLB
      on resume.
    - Fix domain-switch locking and out-of-bounds access when attaching or
      resuming an identity domain. Drop the unsupported disable write on
      suspend and unprepare clocks if IRQ lookup fails during probe.

  - Hyper-V IOMMU:
    - Keep paging domains, their IDs, and their page tables allocated if the
      hypervisor fails to delete the domain, including during cleanup after a
      configuration failure.

----------------------------------------------------------------
Arun Iyengar (6):
      iommu/vsi: Don't leak a runtime PM reference in the TLB flush
      iommu/vsi: Don't resume the IOMMU in its interrupt handler
      iommu/vsi: Don't write the enable register on suspend
      iommu/vsi: Don't use the identity domain as a paging domain
      iommu/vsi: Unlink the IOMMU from its old domain under that domain's lock
      iommu/vsi: Unprepare the clocks when getting the IRQ fails

Daniel Golle (1):
      iommu/vsi: keep the runtime PM callbacks without PM_SLEEP

Vasant Hegde (1):
      iommu/amd: Mark v2 page tables incoherent on Cezanne

Yuho Choi (2):
      iommu/hyperv: Don't free a paging domain the hypervisor did not delete
      iommu/hyperv: Keep a new domain's page tables if it cannot be deleted

 drivers/iommu/amd/iommu.c             | 16 +++++++++
 drivers/iommu/hyperv/hv-iommu-guest.c | 34 ++++++++++++++----
 drivers/iommu/vsi-iommu.c             | 67 ++++++++++++++++++++---------------
 3 files changed, 83 insertions(+), 34 deletions(-)

Please pull.

Thanks,

	Joerg
