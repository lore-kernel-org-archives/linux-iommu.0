Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011055.outbound.protection.outlook.com [40.107.208.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6390B31E823
	for <iommu@lists.linux.dev>; Wed, 17 Jun 2026 17:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781717464; cv=fail; b=MsmtXDGGPOLSm4lwZ7iuKoNUNJi3Z3oTaLWdk8N5f5dNjNRGrf6rFRmUausER8gv2YETAhQJAZIxejZ+qTJnkbJmoO4RhA4mzkDvFdFZBHS1yH5clnA+STzWypvErUdnlTXa4o+XhOPR0e/hqee913+LuwiwNgGAu4A5U6OmSyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781717464; c=relaxed/simple;
	bh=PqfPNIf7Jhah4RzrQBUuxaWPgXC9B9xY9dou8oGOdfk=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=tjeKvx5tziJtnhHBrxIWCBiiLSepCjGNQIS8on3ATBDQtJsVAqJHQFRuqLFtveLPQymDWLeI2wHT65gYSDZctYeDw4USoR4U/TxYgig3oFnyd9GYsijbo8h+wAKJLdEezDm9wwEeupzMrEm5HmE4vwc9yZggcrmAn9PZvdLzQns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZkuMdfpe; arc=fail smtp.client-ip=40.107.208.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZkuMdfpe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Id9p7JmcL2A6eI5LGd3swjXdADd+XxkTiNqR+8n3XtshNInGyGd7+d6y9qvPrVrkh1yKF53jhK/QJOaiAE6zexvoYdLdJpaMl8GlKb4nra5EagkSkqn7PBhbC/XawrVU4sQd46U8t3M8gg0M8ZDPAX/WSTgdk+1BQwRjzsY01C2rc971ri1drUpfYB2vYCxg2s4rECPTLLaFjjU5friL7wE2ezPkwBaZhEzoz0qY0AbltUT2ZrWXbytIbFTJz1vMpkDCKCV48Fq/qD9tXdGxJMB1Ch5xBV1gvSWrP2XqzHCbDQWNIhczOlO1Q57zPOM6QEP2gcgbtX12FZbcEFdG8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dZ8GiQg4q6ClyL7B1gc+Nyul3vAA2lQWak8agEc+QJ8=;
 b=yOFq1wnRjSgXfhdiOKpf+72We05rC45SZi3hY72dXQa6t0ZdfzSJ7/1r8Z8hPxGNsDZXR9KiRQmNpwqBKGC1FIKAMJE0zvxn/YUzjNKiSZw/LNr4noNf/r2/qYposjrL45dIl3uBIAU6SKR0VnwT8Rjdx/obSo8s63kcTZQMk+u1iKYgcWgpQYw/VGmXu3sKhiMK7fY3PFhgiqxYvgkfQtNGeFovKJq7OCu433xt/z/Bms48XNzh2d5UeLJj506k1hVwk1vU331cckVxEf97iAykTZh4kCW0ukXU2KZCfmxRrmfpdCUZSgM8QQk02xDL97EaTuVl9Hts03AoAyjFgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dZ8GiQg4q6ClyL7B1gc+Nyul3vAA2lQWak8agEc+QJ8=;
 b=ZkuMdfpeyIeDuElUVIVWGDony5MbrCzm+VQOnkdCr0uoc6bL1kUYDS88MwDQ3hsdzU+4dYlbyfDh863tAYI4ySFFwVx47SoeMT2FYRK5iQhK6GtVexOwWc6nmQ4X4IN6qNyx6kIyQ5GmFUZr35C/iTuPI37Ti37KLSkWN16lL9Nko3chxQuUCvLj20xVEXkeckxDIShoD2rhoMe09TKG+VRtoZPGgNDPrTw+F1zGdFWGJTv/G+D+YjtH3pmaPMu2wUW2v8z8nbXjOzrKecKrwlUzCk9lXXPxXD3AaYdAjoGR+YxbtqVkOxKaz7pmGAee1FQbhjyumKcFeqG+9HkAaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB6017.namprd12.prod.outlook.com (2603:10b6:208:3d7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 17:30:56 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0113.015; Wed, 17 Jun 2026
 17:30:56 +0000
Date: Wed, 17 Jun 2026 14:30:54 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: iommu@lists.linux.dev, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kevin Tian <kevin.tian@intel.com>
Subject: [GIT PULL] Please pull IOMMUFD subsystem changes
Message-ID: <20260617173054.GA235044@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="E+mLk7NhQjau+58f"
Content-Disposition: inline
X-ClientProxiedBy: MN2PR03CA0020.namprd03.prod.outlook.com
 (2603:10b6:208:23a::25) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB6017:EE_
X-MS-Office365-Filtering-Correlation-Id: ec0e2102-d48a-4075-5268-08decc96301e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|56012099006|11063799006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	yCg7sY/GgbDfKSakexV1+BvchGnUj0VVinghzFrjMdhJDXpCucvbhqwM8x8m2ZSLLAN07lqCAcm2EZ3BXNH0/WVe6oMlDRyua1tYAJsaxOb90+yW0dcPReOMHVGUVVj9qNqGLB7WXU/LTOl0XZdJHngRLvbKHBiUml2UgZa4KE18pdTZ/LXE64nSG9ZqdMuodwQpMt2tiMhuCTRQTB4ztjXzPd4A1nWNfHJX9hMn9ZBUPv9yAv02FHymCQxZAxELodx4erwsus9Iy24so99P7ysgvGh153Axt45zBkbYeFUMGE3b+l7CJbu8Dxw28RP1FnI0hXW2KwUutAd6ZmMzgE5L4AUX5VB0ZASJoEA87EBiWHQATQtX9yztWpofXMbbGz2LCIGNnWkJ/LVY+/XuI4tcVZjPjQJOGtutNIs3lEyx72Yzspez4Y6n1xdwe1eqs608jfutQdaUYFtBAVQo54Ulg1Gs4hatR/VsYRnTBlaJrExFMWEYQwV5AXPvTcGF6x4fkeP5v4Q1hh/8zKPwK7ZLJ1CHVCL0CHa7einf+uEXKKNKCplGNHfDnS14wVnZxvMxq4nFrZpcL5NTfarfMagHeHDB/8zfwlC6ZPe3CF/HuRI0KhM6dX+8cx4U7UTQuZCIa4D4UQha0PEkkGaWsWAoXe9FKmuhFcw28uHYAoGWuywPovkQ5eCHXJxelBFv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(56012099006)(11063799006)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yDDxe1XKkaPkm7/sRLNMIlRw7uX0cOkYCh0vpy66diz0zqL6YXODkYHKADW1?=
 =?us-ascii?Q?EWckZC7zZHlq5Zx8u1+04hEcqpRd07GIbT1cwnssfT9wkmP+y/K7TbjTBnQ6?=
 =?us-ascii?Q?NeNiE3YRLzebzgAJf7XLfmwjmz0ikFAeU7SxcGepUSXus9W4hL9YvTJHMqHQ?=
 =?us-ascii?Q?EyPlT7i0PIhZP2si74OA4Gn3cGS0AaK5TDY3rkARUIYziwbpZ8toXxEasrmM?=
 =?us-ascii?Q?XfTw2rdmbunupLeUk52cZzm77zqMa1LWpXZPU1hySczySsymyinvqi5gUUW0?=
 =?us-ascii?Q?Iwd14oxMCQNMJi7eH5ZKJPA5OpG/Mzmwtf18ShNelfmXaQMucIflSbADS14z?=
 =?us-ascii?Q?sN3PyYGRtP4A+7IHWqFp+2YX/CapcNDK9N2t1zELkuE4mJtLBmAj4xPJq3C5?=
 =?us-ascii?Q?EghFU454EHVg9AYttvUP26ecdbMHQlKOeAtkf6xkboTN+gQRfyROG6j4HJUG?=
 =?us-ascii?Q?8LF1kI9AuuiMT1nUfvIEWeq15449XAP25ZtMgv6BtHdlZ2npXbIDExc2TKLu?=
 =?us-ascii?Q?Zsjt8TJ6LRpgNJ1UCcZ6baVHrLbWtz5nXqSkHxch9348Y8GDZsvKFBF1vXPL?=
 =?us-ascii?Q?SLIwSRl/Ok7zfGM5BIP1u6lokon91ENGDV581/B0qWYtiVMyA8I2S/7w8Eb8?=
 =?us-ascii?Q?28AsY+YzYgzHSNKbb+i3RcpJCiTTyBXsLXJ6r4U38tl4Vs9CdwLcZW+jZl4Q?=
 =?us-ascii?Q?32djDzRd0yJw5Ypmvmc9mcU2JsCFnJQDwPCErpsUyVQEAPQGmeW6hVv28MgA?=
 =?us-ascii?Q?o9+ufoxnAgGgd6yeM5HwHQV7NsVLFagu1xN+Woq4r8Fdu1Wf2eSq5KElyLHy?=
 =?us-ascii?Q?6e4J+B9vSTRwJKbr6v7QhK/PvaiYhbft6igKzuo253SB5z6FrNNXvtiuPxUs?=
 =?us-ascii?Q?nYrZI1O4o2RnqiY2tSNbRNCEBeKHf9tbJ2mPW0eGYup8+EoCQ4ytKd0cPGjB?=
 =?us-ascii?Q?vk5NyUYYxSxCqwtNLiZJaSCIJHoBovA38gOO7oo4Iq0ClB+SprWTSTJQLune?=
 =?us-ascii?Q?D9oOXJ6atDDD5sTtsiJrciCrhGkZ72FPTP+ChB9iwq+txaS+ytW5Y+rSxHsm?=
 =?us-ascii?Q?7dpd4hiD2+9Tz9iOU08S9CPgFaeAd+75oGf8PFH5P/hiV0a2agtJblqaMBTx?=
 =?us-ascii?Q?TpsgujCcTUSZXIBcKHLX3x/BDyvIYJihgUYrSzwCnh6lp2uodmPYrPJLLdQE?=
 =?us-ascii?Q?b20ZmIqtrdrnnjiRr1pW7Yn9GLnLnjQuE2XJJAKDfDGDQ/wFVh0znLk8hgFy?=
 =?us-ascii?Q?h9UvqgaUHpYxcGkkHXfO90mTMCLXMS/SSv4Ib2UAYb7wq2iofXbf5COegVMf?=
 =?us-ascii?Q?z5d179M3EEuwxqx4nU4f6K0NqZcQ3RvORwBL2H8X9PBBKwJHQfc7sorTIvpf?=
 =?us-ascii?Q?mivl2bfJMyPICajiwBnbC6HjOFdWhaDVKoqPh2bY0FctyK++69UJIpZnIVia?=
 =?us-ascii?Q?TZLnesUBTWZ2FlArANyCaAeNimvnxEfGLjNeIN967oSGBLu1EXt8zJgzC9YP?=
 =?us-ascii?Q?A4dyc/jYmf3BA2FymRnADVt7bP1GeiGf0mRgG40tfiUOh29lQjJgkSy4FkKC?=
 =?us-ascii?Q?XkTs2Q61COErLExmZ0QZ60CdgEx7Btip/7fvkWM9sBk4RCOgX0QzwXIlbiH3?=
 =?us-ascii?Q?1ek19Ag868OSk8UiwosLqa6+eLvTJsaVEaQl+GFuodFOICV//On001QzCavz?=
 =?us-ascii?Q?xS8gqA2TU6+Y1SQCI7kwLG3ihuarMyO+j4BMczOThcqR94Vj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec0e2102-d48a-4075-5268-08decc96301e
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 17:30:56.0274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gKfDmPQImz5AEjBkOFDmVUwxPzR8r2nEl/ySp4BVH4WLj8Rh+73HQ0Uig8s2PdpK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6017

--E+mLk7NhQjau+58f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

A bunch of fixes for AI found bugs.

Thanks,
Jason

The following changes since commit 7fd2df204f342fc17d1a0bfcd474b24232fb0f32:

  Linux 7.1-rc2 (2026-05-03 14:21:25 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git tags/for-linus-iommufd

for you to fetch changes up to e28bee5b445178390d63f7a93a5a219063c6434e:

  iommu: Avoid copying the user array twice in the full-array copy helper (2026-06-12 10:44:44 -0300)

----------------------------------------------------------------
iommufd v7.2 merge window pull request

All various fixes:

- Typo breaking the veventq uAPI for 32 bit userspace

- Several Sashiko found errors in the veventq and fault fd paths

- Fix incorrect use of dmabuf locks, and possible races with iommufd
  destroy and dmabuf revoke

- Sashiko errors found in the uAPI validation for IOMMU_HWPT_INVALIDATE

----------------------------------------------------------------
Alex Mastro (1):
      iommufd: Clarify IOAS_MAP_FILE dma-buf support

Ankit Soni (1):
      iommufd: Take dma_resv lock before dma_buf_unpin() in release path

Jason Gunthorpe (1):
      iommufd: Destroy the pages content after detaching from dmabuf

Kai Aizen (1):
      iommufd: Use sizeof(*hdr) instead of sizeof(hdr) in veventq read

Nicolin Chen (14):
      iommufd: Fix data_len byte-count vs element-count mismatch
      iommufd: Move vevent memory allocation outside spinlock
      iommufd: Set veventq_depth upper bound
      iommufd/selftest: Add boundary tests for veventq_depth
      iommufd: Rewind header length in done if iommufd_veventq_fops_read() fails
      iommufd: Reject invalid read count in iommufd_veventq_fops_read()
      iommufd: Propagate allocation failure in iommufd_veventq_deliver_fetch()
      iommufd: Reject invalid read count in iommufd_fault_fops_read()
      iommufd: Break the loop on failure in iommufd_fault_fops_read()
      iommufd: Avoid partial fault group delivery in iommufd_fault_fops_read()
      iommufd/selftest: Cover invalid read counts on vEVENTQ FD
      iommufd: Set upper bounds on cache invalidation entry_num and entry_len
      iommufd/selftest: Add invalidation entry_num and entry_len boundary tests
      iommu: Avoid copying the user array twice in the full-array copy helper

 drivers/iommu/iommufd/driver.c                   | 13 +++---
 drivers/iommu/iommufd/eventq.c                   | 36 ++++++++++++++---
 drivers/iommu/iommufd/hw_pagetable.c             | 11 ++++-
 drivers/iommu/iommufd/iommufd_private.h          |  2 +-
 drivers/iommu/iommufd/pages.c                    | 10 +++--
 include/linux/iommu.h                            |  1 +
 include/uapi/linux/iommufd.h                     | 12 ++++--
 tools/testing/selftests/iommu/iommufd.c          | 51 +++++++++++++++++++++++-
 tools/testing/selftests/iommu/iommufd_fail_nth.c |  2 +-
 tools/testing/selftests/iommu/iommufd_utils.h    | 17 ++++----
 10 files changed, 124 insertions(+), 31 deletions(-)

--E+mLk7NhQjau+58f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRRRCHOFoQz/8F5bUaFwuHvBreFYQUCajLZygAKCRCFwuHvBreF
YbiAAQDkNukrx8BLvqF131f/FfYquUknxjTEJksSxRGN1K5gYAEA0uL2x9OonsSz
6df1Hx9qwYoQN/2EY9tTKXrulEelNAM=
=Kl5h
-----END PGP SIGNATURE-----

--E+mLk7NhQjau+58f--
