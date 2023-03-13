Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0AB1FAE
	for <iommu@lists.linux.dev>; Mon, 13 Mar 2023 07:52:07 +0000 (UTC)
Received: from SHSend.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by SHSQR01.spreadtrum.com with ESMTP id 32D7pAWI066429;
	Mon, 13 Mar 2023 15:51:10 +0800 (+08)
	(envelope-from Chunyan.Zhang@unisoc.com)
Received: from ubt.spreadtrum.com (10.0.74.87) by BJMBX02.spreadtrum.com
 (10.0.64.8) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Mon, 13 Mar
 2023 15:51:05 +0800
From: Chunyan Zhang <chunyan.zhang@unisoc.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        "Robin
 Murphy" <robin.murphy@arm.com>
CC: <iommu@lists.linux.dev>, Baolu Lu <baolu.lu@linux.intel.com>,
        Baolin Wang
	<baolin.wang@linux.alibaba.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        "Chunyan
 Zhang" <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML
	<linux-kernel@vger.kernel.org>
Subject: [PATCH V3 0/2] Add reattaching support and fix memory leak issue
Date: Mon, 13 Mar 2023 15:50:15 +0800
Message-ID: <20230313075017.668204-1-chunyan.zhang@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.74.87]
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL:SHSQR01.spreadtrum.com 32D7pAWI066429

V3:
* Split into two patches;
* Added support reattching an existing domain;
* Release DMA buffer only when domain freed.

V2: https://lkml.org/lkml/2023/3/7/1717
* Added some comment in sprd_iommu_attach_device() for the reason
  of calling sprd_iommu_cleanup().

V1: https://lkml.org/lkml/2023/2/10/198

Chunyan Zhang (2):
  iommu: sprd: release dma buffer to avoid memory leak
  iommu: sprd: Add support for reattaching an existing domain

 drivers/iommu/sprd-iommu.c | 54 +++++++++++++++++++++++++++++---------
 1 file changed, 41 insertions(+), 13 deletions(-)

-- 
2.25.1

