Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DEF630FC39
	for <iommu@lists.linux.dev>; Fri,  6 Feb 2026 10:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770373158; cv=none; b=LowtIe3XR09bOS8RUlmY6cU+WzFE4hW6rHgkvy8VE6BZ/7KbNbSbYu3qvPq8gMesCmoDiarKNnchbiv/qjL4rHQ1R/w84OvC3JJlfqx/ssXPzIcOxjPdlzGx7ljuiiZGT0gst1T2ECxDSuSOrGv1kTCnmsV054Ty6FMFDjp7VIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770373158; c=relaxed/simple;
	bh=m6cZevElzV6/mzqYh9tiAZ3TfsgxX0cm5c8HFaqtyAU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hiaKLXQ+EqIQnntTO7FBfL44KVEEs2KeQa3oM+i7gHYIz0aFNHFiZ5gK/Pbq8vuzALVZUSrKa5Au21p64SOKRB3y1PHkM7ZywFsEa1LANMUccQXRfrxBxjYBYhWHd5hR89ttq2/pFF1UfEVFyiDYQttt8nJHKB3usmW3cqgZjYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=UQ874ubO; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="UQ874ubO"
Received: from 8bytes.org (p200300f6af1d96001ee0b275ea67cb0a.dip0.t-ipconnect.de [IPv6:2003:f6:af1d:9600:1ee0:b275:ea67:cb0a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 196D21A1A96;
	Fri,  6 Feb 2026 11:19:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1770373157;
	bh=m6cZevElzV6/mzqYh9tiAZ3TfsgxX0cm5c8HFaqtyAU=;
	h=Date:From:To:Cc:Subject:From;
	b=UQ874ubOH0a790gbjiC2Vw+bKfPTgL174jh9HlkCHjo4v6ahyzREfN8m1ZNP7FFG3
	 C+JgRbDUzB9dvPp0kBJTxf0IhA/J0eK/zOC3Pvw9nQjCv1VKSUrpZq62InLn374bFW
	 9Ole9k1zYL8LTcoyA/2M8w7lOo7PvNDdile2OqJx398GkvX0YB4whWdCs9eoitzol8
	 VDv5eJzxCfLxKD+AWTwD1QCum9GLOIM87T/VSLB2eWRWuC0pZfynGYDsoIORR6N/a9
	 US0t355l41LWm3gCQBi6kiWiadOniUEhhkTMncAFXDQxtaF7RRb+8WHST/42cC/kvk
	 JQXgPLuKGXFNg==
Date: Fri, 6 Feb 2026 11:19:15 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev
Subject: [git pull] IOMMU Fixes for Linux v6.19-rc8
Message-ID: <6yetluqpicwgoocksffij2mc22gjw7xqmlfsliq2eipmmnw2zk@5ihrvupht7yw>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 18f7fcd5e69a04df57b563360b88be72471d6b62:

  Linux 6.19-rc8 (2026-02-01 14:01:13 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fix-v6.19-rc8

for you to fetch changes up to 02f9d76a76adb5ea16b4e3b403496c42033f8fd1:

  iommu/vt-d: Treat PAGE_SNOOP and PWSNP separately (2026-02-06 11:01:00 +0100)

----------------------------------------------------------------
IOMMU Fix for Linux v6.19-rc8:

	- Fix wrong definition of PASID_FLAG_PWSNP bit. This caused DMAR errors
	  on Arrow Lake platforms.

----------------------------------------------------------------
Viktor Kleen (1):
      iommu/vt-d: Treat PAGE_SNOOP and PWSNP separately

 drivers/iommu/intel/pasid.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Please pull.

Thanks,

	Joerg
