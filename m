Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8806F8F48
	for <iommu@lists.linux.dev>; Mon, 21 Aug 2023 18:22:58 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 92C972F4;
	Mon, 21 Aug 2023 11:23:38 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 617D83F762;
	Mon, 21 Aug 2023 11:22:56 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org
Cc: will@kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zhangzekun11@huawei.com,
	john.g.garry@oracle.com,
	dheerajkumar.srivastava@amd.com,
	jsnitsel@redhat.com
Subject: [PATCH v2 0/2] iommu/iova: Make the rcache depot properly flexible
Date: Mon, 21 Aug 2023 19:22:50 +0100
Message-Id: <cover.1692641204.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v1: https://lore.kernel.org/linux-iommu/cover.1692033783.git.robin.murphy@arm.com/

Hi all,

Here's a quick update, cleaning up the silly bugs from v1 and taking
John's suggestion to improve the comments.

Cheers,
Robin.


Robin Murphy (2):
  iommu/iova: Make the rcache depot scale better
  iommu/iova: Manage the depot list size

 drivers/iommu/iova.c | 94 ++++++++++++++++++++++++++++++--------------
 1 file changed, 64 insertions(+), 30 deletions(-)

-- 
2.39.2.101.g768bb238c484.dirty

