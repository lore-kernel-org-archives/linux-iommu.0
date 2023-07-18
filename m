Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979F2168BC;
	Tue, 18 Jul 2023 19:06:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nzNXpn7T4SC01csRa9Sb6KrwKoN+MGfHYU2TfwASHnvBSQr+idvhiMTfpKeKcsMzvTsLgRxckw1xwoh+dlPocw+ZZhr603G54onCtqdjoUSAkQVn+HKZivOvF6gBGHVayjYFSnBjklTPjZpvwlFgBfl4ysLsivcVUWS0TpFNoU57xPKzlzgs8c9BQIpogsL6ZBUPKouOKAOcxIYIHAgllIvK7Q6NYr2uTR9fFXOIj4YO7/dFYu2VAycOk3k3SJpM8Y6avMyDCqYV4x4vN9YIu3hw+4Q4SY5FUrKUzW45dy8LsEqqiMQP0Y4DDAqN55nRT/EW8Lt7tSDzhBbhjk/6sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RpEGIzqvs3VAFUuUc/h5wMVo8XU1MhIkM0Vqp4h6wrM=;
 b=Sr2dZY1wUAnMxjwC5JR5mAWDQy9j8rSW93/xSmENlNfJBEkUicl/R5DoZQyj7kBTR7H1k4SWfkFVpyBUohEQsXKwNoHlt5VSU6fJinZUZaBAdcJU19vtTDzehUgAPGRJe/b259G7VmfdNGf07u6iyzPe09YnW9E1HB0VXDyFENg3H/7K//7LN0R0mIIMJRy1hmJO4SOjTX0Ki9QhYwCon+qX14FKRmZWCdmA3Qty3qjECuSkewyBEZLAwE3bxrUMA6P6wFleS3CJL/aCJTpYaZ8OOl4XA3gIV0mNU2suttFsipFJAxOSN339f/bI59OSYcLwretRcOIqzkQOk7IUsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RpEGIzqvs3VAFUuUc/h5wMVo8XU1MhIkM0Vqp4h6wrM=;
 b=GsOdYd0+xTm3XBJTbRD/FkemOildGipAYL7xwrc35i7tPjs1n0L0GGzpIyBQOySGfrVldyIUpliDsxKt0cwwlbY0QIHOXAm4uggxxil0JX+cdsWkp+DKlIgX3XDmO5aUN56swOxhQO3r/yrKY7nuwEJt+GOYO/V2O+COMdiUAukFEa8XmtKJLuo7nCJ279jnrnicoEeqZTeaHfc31ufJoD5pJeH30ZQrtnAVoLf9spd6DMyIM21v5zCU3Zj3XJBWDhO9y2XbCjE2YqByMPFC2j1JIbisHMRH+uIW3Np6K3iyCcY5WGviJifHArC45AQjGXa4ptTtPEAWTim6S82Mxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by LV3PR12MB9329.namprd12.prod.outlook.com (2603:10b6:408:21c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Tue, 18 Jul
 2023 19:06:02 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 19:06:02 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Heiko Stuebner <heiko@sntech.de>,
	iommu@lists.linux.dev,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	Orson Zhai <orsonzhai@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Samuel Holland <samuel@sholland.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Will Deacon <will@kernel.org>,
	Chunyan Zhang <zhang.lyra@gmail.com>
Cc: Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH 00/10] Refine the locking for dev->iommu_group
Date: Tue, 18 Jul 2023 16:05:48 -0300
Message-ID: <0-v1-3c8177327a47+256-iommu_group_locking_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0091.namprd03.prod.outlook.com
 (2603:10b6:610:cd::6) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|LV3PR12MB9329:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fe39883-eebb-4bde-dfa7-08db87c20726
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SwW9g2O76fSP+hDGoBMsXeFe5ofid7ma/OAxF0y+AvdgHE3wrBbg0AoGiInqiAf/bwpPdO0jU9wSvkNZgw+9P2HwIKWhE16XNaAqC8sVefyw5Y0i+7WosZruupkYeTOeGr68Yhp+deBmu/inzJ7hnzJomLxMrY4gzm1LzJ2+wKt3bg1ueWPyjIAyR2ysWv8yE9nT26L7QS3fzybFGwDsXHEECRWUy2Fp3HVrFX8pYcz1tbGruKQ0oe8i12t6s+XCpBJ+9JAI8g/uUFZ3imXtBnmY7TQKN/GZSyexWgz91tZDv3SsdT6T032HYAUgyEsd0cxt9Q9XllAdj2R73TxWZnVZG2dg94MkF/1a1VILPtZeS/LCJHiixZVnCW688LMdOZnHmkmi7LCLhoY4igZ5HdqrvoDvHCKq1pqn7rMGiF5UiSW5r+9Km5EoDlZjX0elFR1e4x8JuwznoSLDvpJKGFi7uKVt1XNj+G4BVo1HAgfb6WcZJouVtQRkrv1yDmLUeNnbFvgPGszNe5uA9KNS2AmIqsrU48lsT2BVKBEqfNh0C3L7Is1lRskuQoY0DS49i8zGqOVIeLnGDBmCjX3SlVpSuXnfvRopNMrrjsnkIdyDN05Q48/c4w6mNzV7QDGMwLmr1zTrPMb2k8IMlPXt4byHZubLqIJWeiU9Bsec53s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(451199021)(2906002)(110136005)(6512007)(38100700002)(921005)(966005)(2616005)(83380400001)(186003)(6506007)(26005)(5660300002)(86362001)(36756003)(8676002)(7416002)(4326008)(478600001)(6666004)(6486002)(316002)(66946007)(8936002)(66476007)(41300700001)(66556008)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NxBTIbEQz9L3EtqE6hIuohqzG4OwA0VlilIShD9I51eWotrv0mBMBLc01r9a?=
 =?us-ascii?Q?upJ4n20eQJmV2hVeN9SlAxTG8bdy2wFno+9rV6BxYa7mCyRHpTYxyvZfMBba?=
 =?us-ascii?Q?MSKBNVDEAv4lFDynciK6XHAtQJQgNKNMea83xMv/7uHm5uJuhe+Bjev5HfMo?=
 =?us-ascii?Q?fvsbArZ5yPBC4PhCnqS+5Oxg2PlB1H8cyJlDF4TXLPjQ9WK/1SosltdLM19W?=
 =?us-ascii?Q?wSkRbja95lb1ZQQo0OC850yI2aIUjIU3csZQ1QUYPadGgJ6fCUmJgy+6YpPC?=
 =?us-ascii?Q?+oxvPkPdbx9xbKngf2KjIWamF5IHYC+UgV5wqSL7S8/oDq1LDiDYPo7HQJ3s?=
 =?us-ascii?Q?B9Gk208Atnl3R6+6vjeWeRCCaaSRtMakDNo3XJYrtAGkNdwJEB6ruaE4bEXP?=
 =?us-ascii?Q?a92woATG2zsnxZ/hRtfCeOX9zDqoF6sM+7dOXWMbC/tTrsqT9jt7SFJcCA0w?=
 =?us-ascii?Q?VVkAgmuRojjt5V3H4QJrMD7+pUJU7qdW+RqEuGVD5t5Ew5K/OZ7+5VX8pvyv?=
 =?us-ascii?Q?SpvBZCy2/Vc0X3Wn5l0mSXfgP+jeupi0r1nMmwmJcvK8vdvjQYp+L4boc/Kz?=
 =?us-ascii?Q?2fghoz6I3lEMIvN9wdHEQCYmsMNGOXsj5Q48GGgewdGB9uONwKOVL4MKZee6?=
 =?us-ascii?Q?1JrR+mU5ixjx9xWLrzqkhJNPNZkGhi9T0C9aYEtWIUwEqbacrz3YGRyYdpG9?=
 =?us-ascii?Q?d3ZXaI0RTXlPQbqognhSqedxyt6DYVoaJuX77BeX7w6sgp1zViFf+4mNzQoN?=
 =?us-ascii?Q?AAeK+CQuYGZm/RVv3218RPgQh9e5ZNXfxA/mBQNcHJndaZqNQO9+wfivn1xF?=
 =?us-ascii?Q?isy5+5XX9t5hDSe6yBZy4LWVaWzW+HMg/0Nop5XJVtqRHpcf+SMCfuPY5qQj?=
 =?us-ascii?Q?kfGRQR/ISBp4vuS+/8oXz+dR2+W4yDgCDw9mCjGBuG15yP+P05nheYuGa5at?=
 =?us-ascii?Q?HfYnO1GqWtRFER1cfbGcP67Wt/HtJ5HzfVmuu3TXJ7YGpla1dJFpc2E2e4/x?=
 =?us-ascii?Q?t/0BBpR4hEp2taCs0IgDQeALYK5+44d2VwQ7chkz2tYuBxSjiwI4c4EBNHUm?=
 =?us-ascii?Q?V/fnIUScCjX6WyOGXmIXBfzt1APJoUHJufqJWbcaqefJUNUQ1Lr/1Ph8Gqiw?=
 =?us-ascii?Q?+cf3Y/yxAW9omiM+a5oUR5f+UIqKwV6N7yCHsvseSTUGwKw8uAuCBKNkDdT8?=
 =?us-ascii?Q?OwOoynxCcLqcOjcX2DblrvnVJWHp/DgRZVNp6Jr4aCGjF6T/qHTXayxgW8dy?=
 =?us-ascii?Q?8gH4Rfr3QKJbPpOe94YFsz4tGFBBBb3x5TQSkZ3kXz4EuGrVQ6DZpivKVdlM?=
 =?us-ascii?Q?DAYA0r4a10ID9bROHpApkcl2RXP+6tF3Vea0Ug1KzkncWIO3iAFwKQ63Ezac?=
 =?us-ascii?Q?L+fTkrz72NeUwMv2DssI5qe1JAZNJwqJPJevELCK2F+OF+pn3Mgqd/lIspAi?=
 =?us-ascii?Q?f9+9V1oBYIjXxrSCu4w2jkuiyydFQGP6mnG0KxKAbWlArsKmhllGafznQbYC?=
 =?us-ascii?Q?uoeyZeod4bXyoR/RCCKjNY/uIoZhIKQEx2/LxvqR825RfoXdZGvwMndrHMqj?=
 =?us-ascii?Q?Sg5D1BYiLx4xwYpjC8Y0I+rH1FJeAht9ulCAoFSL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fe39883-eebb-4bde-dfa7-08db87c20726
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 19:06:01.7171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ou79kTNu4vS0JLioF9BuWLU/IGXwvSF2zplVHg7z7Y3hDKko8xJzvDqP6iasPT+R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9329

This series puts the core code usage of dev->iommu_group under a
consistent set of locking rules. Currently a lot of places in the code
access this value without any locking or READ_ONCE/etc techniques and it
is not clear how or why this is safe.

Make it so the following locking rules are used:

 - It is readable by a probe'd device driver. So long as a device driver
   is probed the dev->iommu_group will be guaranteed stable without further
   locking. The reader should provide some kind of locking that ensure's
   its remove() struct device_driver op cannot progress.

 - Read/Write under the device_lock(), this primarily protects against
   parallel probe of the same device, and parallel probe/remove. This is
   useful for places that don't naturally have a device driver probed, and
   should be rare.

 - Read/Write under the global dev_iommu_group_lock. This is used during
   probe time discovery of groups. Device drivers will scan unlocked
   portions of the device tree to locate an already existing group. These
   scans can access the dev->iommu_group under the global lock to single
   thread determining and installing the group. This ensures that groups
   are reliably formed.

Add locking assertions to enforce this.

Along the way remove a bunch of opencoded group touching in drivers trying
to implement a 'single group per driver' approach by providing a core helper
that does this common algorithm.

Overall this significantly reduces the number of places within
drivers/iommu calling iommu_group_get or touching groups at all.

This goes on top of Joerg's next tree, it needs the prior series
"Consolidate the probe_device path".

This is on github: https://github.com/jgunthorpe/linux/commits/iommu_group_locking

Cc: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Jason Gunthorpe (10):
  iommu: Remove useless group refcounting
  iommu: Add a lockdep assertion for remaining dev->iommu_group reads
  iommu: Add generic_single_device_group()
  iommu/sun50i: Convert to generic_single_device_group()
  iommu/sprd: Convert to generic_single_device_group()
  iommu/rockchip: Convert to generic_single_device_group()
  iommu/ipmmu-vmsa: Convert to generic_single_device_group()
  iommu/omap: Convert to generic_single_device_group()
  iommu: Complete the locking for dev->iommu_group
  iommu/intel: Fix missing locking for show_device_domain_translation()

 drivers/iommu/intel/debugfs.c  |  34 ++++----
 drivers/iommu/iommu.c          | 153 ++++++++++++++++++++-------------
 drivers/iommu/ipmmu-vmsa.c     |  22 ++---
 drivers/iommu/omap-iommu.c     |  30 +------
 drivers/iommu/omap-iommu.h     |   2 +-
 drivers/iommu/rockchip-iommu.c |  22 +----
 drivers/iommu/sprd-iommu.c     |  24 +-----
 drivers/iommu/sun50i-iommu.c   |  29 ++-----
 include/linux/iommu.h          |   3 +
 9 files changed, 136 insertions(+), 183 deletions(-)


base-commit: a5003e75a1714857c01317d04982eef81331fe2f
-- 
2.41.0

