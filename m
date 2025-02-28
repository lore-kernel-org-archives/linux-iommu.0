Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68691EF395
	for <iommu@lists.linux.dev>; Fri, 28 Feb 2025 15:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740758292; cv=none; b=E346eEwrTZmlToNrg7V6gIu6rvWinUQdWFIjaYk5pgAxrw6tqmcZS08n6Sg/aXblid4wsMsrU76am1NJ7O9hwXXAEMyXRPsX3Yxg4kmWkBx60jBQKSaPfeb8S5/3KkUU5CF6q3rjBLi8L6asMMcZu+kUluSmSKii09C/aWCy9Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740758292; c=relaxed/simple;
	bh=w7UwFFDfTzn/blFmQltq0BDs2swJG9iTW4bJSf2HOh4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=plEN0qac1rBhHwXnhYu5TO26tB1xAfKEwTLm4gJd5ddLk8Q9mPqjkgCs9NquWm8QYbF0DUZKNMUi6ai8qH28Z83aZluvWoYoWUr4Ir/wYgR4pPdUeGlFV796ceHyP++oplc7UON5nRNwjwvotMjXHuS03+Z4R0RHk810ZQThRm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=Z+R3T1B+; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="Z+R3T1B+"
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 75FA741861;
	Fri, 28 Feb 2025 16:58:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1740758288;
	bh=w7UwFFDfTzn/blFmQltq0BDs2swJG9iTW4bJSf2HOh4=;
	h=Date:From:To:Cc:Subject:From;
	b=Z+R3T1B+b1y7VOEIn/9Ik1CyvsARwovuLlCE9onxwNRT5WnZE7gR7ubS4ZynjFKk+
	 Eu3k4t8SHatp8qq/aV+EproFOsEKzxecbAWx/d4wWMqX20iyZUJh0UwoDOKUNCVzM+
	 KtF2dU/nVBOFcp8wTmskA7GaKWB6k/lHhLdDJe8F2vgcaSJABW4VdppfAHrUuyZYie
	 OxZhHcSNw9+NldsimQww0ZiAjd73GYMKEKI28u6HS4huBzLJtducQNzcKHdgm+H3Pw
	 bQIden6ANlGo9q/HtB499+rSX+SaTKtC77PyQ7237JXE5fwTCZKmFaW1Jk1V+5U2Zi
	 uGVMWVz7JIu7w==
Date: Fri, 28 Feb 2025 16:58:07 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: [git pull] IOMMU Fixes for Linux v6.14-rc4
Message-ID: <Z8HdD3MdUViUc0eo@8bytes.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit d082ecbc71e9e0bf49883ee4afd435a77a5101b6:

  Linux 6.14-rc4 (2025-02-23 12:32:57 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fixes-v6.14-rc4

for you to fetch changes up to b150654f74bf0df8e6a7936d5ec51400d9ec06d8:

  iommu/vt-d: Fix suspicious RCU usage (2025-02-28 12:19:01 +0100)

----------------------------------------------------------------
IOMMU Fixes for Linux v6.14-rc4:

Including:

	- Intel VT-d fixes:
	  - Fix suspicious RCU usage splat.
	  - Fix passthrough for devices under PCIe-PCI bridge.

	- AMD-Vi fix:
	  - Fix to preserve bits when updating device table entries.

----------------------------------------------------------------
Alejandro Jimenez (1):
      iommu/amd: Preserve default DTE fields when updating Host Page Table Root

Jerry Snitselaar (1):
      iommu/vt-d: Remove device comparison in context_setup_pass_through_cb

Lu Baolu (1):
      iommu/vt-d: Fix suspicious RCU usage

 drivers/iommu/amd/iommu.c   |  4 ++--
 drivers/iommu/intel/dmar.c  |  1 +
 drivers/iommu/intel/iommu.c | 10 +++++++---
 3 files changed, 10 insertions(+), 5 deletions(-)

Please pull.

Thanks,

	Joerg
