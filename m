Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF8B3C73EF
	for <iommu@lists.linux.dev>; Thu,  2 Apr 2026 12:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775131543; cv=none; b=PV06p53OTbqCi4l7csKpfv1YcCPR0+sYb5T55n75iHr9AnliyWlswYN7zbqDgGppp0Kp9QiNIurg3LAWFQVDw76kuKlulkrZDs8zsKm5C4NqsB6bk1KfK/V6MPaXWybsVGJTC9U/k+/rWBQ/ukJMND5AWRMxpHRyr3Rk7wdyTWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775131543; c=relaxed/simple;
	bh=oUZfmfsM1PhovHisJzs5+4cnDQ8ov+9EMwE7ASaI650=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=a1hB+mYnwrOn5Tx2V8Rs7CL+2okrm2kDoVkWXFwBMlR3Q8kvG5fdElpMwE7I5BQ2HkoJXNQPD9kOtaRIm1WgQy/feZRXmPai22VClpK5qsMk53uSxCflpCi7l5F4Ps+wCGhSRDJk9yAr5Y+8R1dt3Q9nBwCkn4Xnqs1LqhMLtO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=yQ29Rd0e; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="yQ29Rd0e"
Received: from 8bytes.org (p4ffe051a.dip0.t-ipconnect.de [79.254.5.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 1EE6D1A70EB;
	Thu,  2 Apr 2026 14:05:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1775131539;
	bh=oUZfmfsM1PhovHisJzs5+4cnDQ8ov+9EMwE7ASaI650=;
	h=Date:From:To:Cc:Subject:From;
	b=yQ29Rd0eCKTJNGXISqqJU1fLMXtw6qZ5mZN3Jtb2JmSxNreAWUJU0QrxqLv9tmj1w
	 X9xMRGbsu6HkJ0RQcZ039yJ06tFTVNipZl447F+cVYc3vofQlhIvK262BRD7GKcTUp
	 sgI3W7vlYykvQnlCDW8a0E4v2NymFSEMZTzYXQJfcC+DGLmgbAeM9GyVciYIVIWFQu
	 TSvoj/kuaUKkUh2MK0fLKOL7pNxB5M4b6/0UJw2MITTqk5seCvHIhs85Q/rni3KYVE
	 jsROZ0fa3Sj5tDr3fsmD93ICZRLwN/ts9wzh5SHyjSUvAWv1e7zszek/046MwPFOaO
	 N3hj32wVhWdMw==
Date: Thu, 2 Apr 2026 14:05:38 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev
Subject: [git pull] IOMMU Fixes for Linux v7.0-rc6
Message-ID: <5bfq4uev4ljcwc7ntw4zphscwmbazuh3jrebsbcohcmnriisa2@zonteyjx2cua>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit c369299895a591d96745d6492d4888259b004a9e:

  Linux 7.0-rc5 (2026-03-22 14:42:17 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fixes-v7.0-rc6

for you to fetch changes up to 8b72aa5704c77380742346d4ac755b074b7f9eaa:

  iommupt/amdv1: mark amdv1pt_install_leaf_entry as __always_inline (2026-03-27 09:41:48 +0100)

----------------------------------------------------------------
IOMMU Fixes for Linux v7.0-rc6

Including:

	- IOMMU-PT related compile breakage in for AMD driver.

	- IOTLB flushing behavior when unmapped region is larger than requested
	  due to page-sizes.

	- Fix IOTLB flush behavior with empty gathers.

----------------------------------------------------------------
Jason Gunthorpe (2):
      iommu: Do not call drivers for empty gathers
      iommupt: Fix short gather if the unmap goes into a large mapping

Sherry Yang (1):
      iommupt/amdv1: mark amdv1pt_install_leaf_entry as __always_inline

 drivers/iommu/generic_pt/fmt/amdv1.h | 2 +-
 drivers/iommu/generic_pt/iommu_pt.h  | 2 +-
 include/linux/iommu.h                | 3 ++-
 3 files changed, 4 insertions(+), 3 deletions(-)

Please pull.

Thanks,

	Joerg
