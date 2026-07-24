Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FD9448B88;
	Fri, 24 Jul 2026 16:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784910350; cv=none; b=N3g2UQgItrUSHsELcB6lRpFHjCOeFmyO4wH89tMd6UZ72SPTbFQnas5VBIfJpyyCpumMY8An/fLy7CskmjzguwWYidJFi4qmkB/q5qSfE5xrUu/kSIwlZBCiT09QFLyutArtJEA/MpXSuEw7NYGQ70CyeZYSxQOfFErYILs1CTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784910350; c=relaxed/simple;
	bh=FtzfiRO/VYG3z5T4hJjhgITwKLPiuSaxepprLBlTKew=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tzkj9aCDLdm/TLDiqo0pLDI3N9pebdCYK2ViFtHTkbUoRrw2GR4WBMZhAT2K0tpEprFE9KHtxC22Ck0TGyNfCG9x2/uL79G5YjedCkrs3o9FsdnIv4mmzPc7VZJY+c4vkVbes2Q/WPjP7nhq1fY+KABmnj2OTs8hQ85nypMwXSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LoqFHaVq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LoqFHaVq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F7EA1F000E9;
	Fri, 24 Jul 2026 16:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784910349;
	bh=Nsh3J7UmAD7PZtvxxi0Nkd97tRZuuQ0MJgzkidOe7RQ=;
	h=Date:From:To:Cc:Subject;
	b=LoqFHaVqsqUqzZUdPnKWtSgomRa6IGALtOeMrCKwHmSzbnuBXnToyPKG0fsNo1lz/
	 /UZU0a9c+JytGwaypF7QsFZ32JpBQImb1xR6cJxktkNj6iouPNwhmjhG0iypEtzGsC
	 w9Q28FJDm+uh3fSoI9YrOC3PO+HNCfrEjSGMJO8b7Snkb/yDQG0VDeQaRqGlJuBECq
	 +MqcTSzvFbdEmj8D28u6bbUALAkrY0A2naqWUNBcZV9spniY3N+vap7L0rxANk0wA5
	 WOIVtX2RoINQu5zaIvvnBNEH4yWhv9ZtRkRLoOYjvNhgT0OJZHqam0cXx6hdXnFpmK
	 IiJm/o7oG1d9A==
Date: Fri, 24 Jul 2026 17:25:44 +0100
From: Will Deacon <will@kernel.org>
To: torvalds@linux-foundation.org
Cc: joro@8bytes.org, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: [GIT PULL] IOMMU Fixes for Linux v7.2-rc5
Message-ID: <amOSCGEa5N4lEUFM@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Joerg's away at the moment so I've been looking after the IOMMU tree in
his absence. In the process of doing that, I've hoovered up a handful
of fixes for the AMD and Intel drivers which address a combination of
the usual out-of-bounds/locking/leak bugs as well as some logical issues
around SVA and command completion.

Summary in the tag; please pull.

Cheers,

Will

--->8

The following changes since commit 8cdeaa50eae8dad34885515f62559ee83e7e8dda:

  Linux 7.2-rc2 (2026-07-05 14:44:06 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fixes-v7.2-rc5

for you to fetch changes up to 754f8efe45f87e3a9c6871b645b2f9d46d1b407b:

  iommu/intel: Fix out-of-bounds memset in dmar_latency_disable() (2026-07-21 11:34:51 +0000)

----------------------------------------------------------------
IOMMU Fixes for Linux v7.2-rc5

- AMD:
  * Fix lockdep splat from nested domain allocation

  * Fix nested domain leak

  * Fix broken synchronisation of command completion

  * Fix OOB write in "ivrs_acpihid" command-line parsing

- VT-d:
  * Prevent SVA for IOMMUs with non-coherent page-table walker

  * Fix OOB write in PMU driver.

----------------------------------------------------------------
Guanghui Feng (1):
      iommu/amd: Wait for completion instead of returning early in iommu_completion_wait()

Li RongQing (1):
      iommu/intel: Fix out-of-bounds memset in dmar_latency_disable()

Lu Baolu (1):
      iommu/vt-d: Disallow SVA if page walk is not coherent

Pengpeng Hou (1):
      iommu/amd: Bound the early ACPI HID map

Tycho Andersen (AMD) (2):
      iommu/amd: Fix IRQ unsafe locking in gdom allocation
      iommu/amd: Fix nested domain leak

 drivers/iommu/amd/init.c   |  6 ++++++
 drivers/iommu/amd/iommu.c  | 22 ++++++++++++++++------
 drivers/iommu/amd/nested.c | 34 +++++++++++++++++++---------------
 drivers/iommu/intel/perf.c |  2 +-
 drivers/iommu/intel/svm.c  |  2 +-
 5 files changed, 43 insertions(+), 23 deletions(-)
