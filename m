Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66153A1BA
	for <iommu@lists.linux.dev>; Mon,  5 Feb 2024 15:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707147169; cv=none; b=HwsYEeUXOLirgrYFtQEEKpSmR7aTed0tyzOylcKH6w9RCwYWeN3wIc2A6Sx2rfGgKVRyjDIlWWxCehq39sEweLvnNQ/Z2hsdcVhsFe0cqsUcyKHYbLhH9vnuBJ6L8X52qGLkSudS2NrKgrKKxfKERj00geW/0+SkXuSu2Jde6g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707147169; c=relaxed/simple;
	bh=KmaKj/FrqhODuXe1TaDfgqvAe8TWKw+amUWGmKbLRCU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G7qfigvjHUegnc0uFOtaIOmIOhss0i7SbW2LwuGBVSufnLs380pxPSQgo/Y12Vk3IyHREEb4hQItdifKGFWlalbxeoFjdQzXJ7TafAS4IoNnOBQUbkjd01r3aM3RmO+ab9uz87TSscKwn9a/pedRZy+F68nE9BlkV8HZkiHD4Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF7771FB;
	Mon,  5 Feb 2024 07:33:28 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 05AD03F5A1;
	Mon,  5 Feb 2024 07:32:44 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org
Cc: will@kernel.org,
	pasha.tatashin@soleen.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	rientjes@google.com,
	yosryahmed@google.com,
	john.g.garry@oracle.com
Subject: [PATCH v3 0/3] iommu/iova: use named kmem_cache for iova magazines
Date: Mon,  5 Feb 2024 15:32:38 +0000
Message-Id: <cover.1707144953.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

I decided that Pasha's patch[1] was a good excuse to tackle a bit more
cleanup of the existing IOVA code, so it can fit in more neatly. Thus
to save time and effort I've taken the liberty of putting together this
mini-series as the version I'd like to merge.

Cheers,
Robin.

[1] https://lore.kernel.org/linux-iommu/20240202192820.536408-1-pasha.tatashin@soleen.com/


Pasha Tatashin (1):
  iommu/iova: use named kmem_cache for iova magazines

Robin Murphy (2):
  iommu/iova: Tidy up iova_cache_get() failure
  iommu/iova: Reorganise some code

 drivers/iommu/iova.c | 143 +++++++++++++++++++++++--------------------
 1 file changed, 76 insertions(+), 67 deletions(-)

-- 
2.39.2.101.g768bb238c484.dirty

