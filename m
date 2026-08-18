Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010048.outbound.protection.outlook.com [52.101.201.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DCD37AA94
	for <iommu@lists.linux.dev>; Tue, 18 Aug 2026 20:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787085370; cv=fail; b=ZGjuW+rdcmMJ4k//8H8leakxl8a+eia/3YEk+e5um1xyVeGMeUS+7/iLOVFRHf1x/GApHh5NU7x7v88cvpgyO24zPIxoUVjq8VJWcZx3uP/rDGC7GrWVotJf9Qo+EQoMGb2IPFthi7QzEs4FC6DRtc6QgPpkwKNkbOV9B2LOWI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787085370; c=relaxed/simple;
	bh=rtIkxXs0JVAcBBwfkY+zBPNQHuktcL+Oghbc2zFnQXM=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=A1IoAswV0CCKXF7zFCsyFsYx/VOYRPbJGB+zJp1mwP/TGQ/E4wrAJzzg+PDuFRpj52AZFnkZJWUlKKPi9ukH1/TTYEYXDbT6Nhf/tMXDZwW8Cvj6X5rpqbsK4U5dWROlA9GwuTFJ6shXzZaqVTct79/m66tAT8F7hzO24aUB6ME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C4hbh4MU; arc=fail smtp.client-ip=52.101.201.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C4hbh4MU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uj+2KGtZc9g3dzddGBJmBtqoah2arkgk++S1jc2Fqgvb8m4fEo//ahK2rsKTTtXOXs1AA/Xzo3EEroJ3M9hBuADQ9A/8UNHwNzeSLF2jyWl/Qe4gG87IFZHJnKTHymk5aMtGOg+VZpcsL88t8XRr/tRkWfyg1+qqRw9e96Fw6lLRBLZ5WMqPxj3etPqjBsyvZEQQznYhlSzBt5PqgthfOwBgkW4b+plJcPvHor85L4jTXM+o8C03eUC5BGJcXN2NWmj8awdLbVE+CGvX9gmiAaQMPcEELydRNVMas+GVhuDMvc3LZbhjA3IUwWPw+6Ln9noHAnlH68W4bbzG1OER9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7xdoeYMLRG2SMZg7tXo76MV7gXE3u/YI+2oCs7HVqPY=;
 b=PrwnNa92xOy1SateL/7WnAKesmlIbpjrxHT0xslQdEVg1d2rOT3a02WKi1l1uqWxQkLVK1a5edJnnWxngLt1WqnaAD02ydS5GTmeXUd2EO5J/0qJQN9EkM3/sL5msYIKRWYcqJEOfrzAWomQ8RTUbAJtkxkl1nYF1oZzkt8W8DhfCRuSMRFIi1n8vfokCfWTVq3mPXm4LfDtGzvB6gPsC2Bh8Pvw0A/4SBCzQvgxgSPziqKZgArwpGvOUWM4BkY48IvD4EpZyHT/01Kuw7uuzsgccT4Ghg09WUEXP5BJTKrizCmA+aG+4NjZcbYnfmLf8U1qZfFjjqOhubjaJo4L2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7xdoeYMLRG2SMZg7tXo76MV7gXE3u/YI+2oCs7HVqPY=;
 b=C4hbh4MU0w/f5mMi7pNrK2mRjeKkB9rRsj9ZMki7uKBRWr8FflS4Pq7JRkb1F7BmJEYr5X4GPDxka0ucVRAxqy7griqf67+JEp2bWKzbHRjN/qeq6zGoKoro1zcEgZRy6SgFP49MznGr138pGCy2syqWsb9tZBDARzy0xVr9Z69bYp1VcWy7Fuies57wI9odkVd3H5zuAk59DsmDxzqeARDtUNa/Eock65+Xsym1/T4KBlE/df9/P0DIXSd54X+EXjRwfh5fd2MVj41BJLI7Fq35L7RIsYt4nW8mchDxLlzGsPD3jw5spkwvDEuKk3vywNE3ayklKmLeILnLx4oQLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by BN3PR12MB9572.namprd12.prod.outlook.com (2603:10b6:408:2ca::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 20:36:04 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0339.007; Tue, 18 Aug 2026
 20:36:04 +0000
Date: Tue, 18 Aug 2026 17:36:03 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: iommu@lists.linux.dev, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kevin Tian <kevin.tian@intel.com>
Subject: [GIT PULL] Please pull IOMMUFD subsystem changes
Message-ID: <20260818203603.GA96412@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="d7er3UIJkRe1Glzn"
Content-Disposition: inline
X-ClientProxiedBy: YT4PR01CA0364.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fd::28) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|BN3PR12MB9572:EE_
X-MS-Office365-Filtering-Correlation-Id: 95e1e0ee-1985-46a4-3867-08defd685311
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|56012099006|10067099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	6e+0V/shCPS+VYK7Cx8PhKODNg/t/3r7BK+ZefLAb+RlkZJ3pGnLBFW6N1wEG14tafD1TON4ZqOxUEcZgkC4bCGmBj+pLFr0/y1uoLjBK403pjiux1dTwqpg3WmGKjLrn6+WdsTZ0DJEhw0zVq23NWdOkqubr44oH3lQZu4XuVJ3hGzRtfQAI4M9PwEuyew4MMvDvAWIJV7wsInKTxQwQu8EPdmot6MxU3S1ylrKAannsa0xmwkfrh+QuEJVa5ZQjSwWFOqY6dPI/tz/7YgTOTRx7lgN+vW2Pl9T+/QPQvN7pm0tVEYBzgLO7wW+KNmNve9cIVPnF6NFeJ28kVVg4b7P0weq+VI+DDvGlPrLhPG2k9iXxQ8trXg9zmFNlFq/rTl21vhkA3SSjJg+JBUXX+TMte3ZogZQdipoaezulbD4oelo5ovhgqwR0WgzYLgQUN1J1DLx6KDq2XJcgF+mcIH5Z6mu/JoYF7vc3jHz9pOvibW7Bho0aYGYNUpXRKbSYHOVlGE3E8gW5yCkbSkQwg06yMOZ85qqXwBTAs0BQgLLsatvYUKqiN9v5/9nzYylzLXTgOKifYxl37A/QV+iiWNPqEcL28bvfVL+b1CBD/h07ecBy4ehFrvadMoa8WHJsEEW9Fx/fnvmWbk9I+BMbUR0JqXcnMBVyUS3mU4bEcI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(56012099006)(10067099003)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YIdnLrhFHWrQFCpbuHm+Ofilcb0RHOWhpTfb4fn2miy5VNFf++Qsxu0bjap8?=
 =?us-ascii?Q?LHAQ3dZJ68KyElSjKOzb/d2mG0gOwT5QD9quUYkqwvkKq9LOYv/UVBjoaJiZ?=
 =?us-ascii?Q?vxwNTpVq2ljwEZz7SrvmPsuYOHx9/sFJNVh6ho0/yGFmM9pJDpD0VItVTxaL?=
 =?us-ascii?Q?YZdnKSMOvotFpuWhNZ/HmYsfHrbPoQqclaSgp+2+GT5lRNVcBitjaGGacx07?=
 =?us-ascii?Q?EnVdTFLEImT49Z0EzN/RmgTYRFKzrp02lMlSTqX50tjfCEbyQTUwcfX6+OGV?=
 =?us-ascii?Q?Y3ylj83CJy5y5iX5WvIGM7EI6AIjTqlU2pN+s6ZNCSnU0oBp7CoQ3Azt2cUF?=
 =?us-ascii?Q?hZ3myeXyFoAlNrF+EYDnMqcOWb5VyjEkgmiqVarrpZhhWuTFQVZOHxU6zmJ9?=
 =?us-ascii?Q?xWsDgIVen6t6w4RQ1vAd+7abxOisE9eLoEDGryBi4MHzmdHgCZsIvHBU1+3+?=
 =?us-ascii?Q?UW2SzhoXx2+KBTfs6IbEMacKSfg/a3VrfQXeulQOSQAnh7vaBPUCtW3d2Dbm?=
 =?us-ascii?Q?Ra7X89HFhCNoXp5E1gCYyMPsGopeMSXHvGvaggTSuGtME2LNEc3JY88Dq4j6?=
 =?us-ascii?Q?lRYUj9tD/8YQk+1ceBZj8CxcMdflUiXTR/cOTBkvAwy57dQzgMAC4rquhCN4?=
 =?us-ascii?Q?EcXot4396B7+HkOfLgh9s7ZEO+6dH1tsDfdEhkYuzKR6u/YfMDKXjTDftcDj?=
 =?us-ascii?Q?TTPmuNvxEvhuVFrGuBAdePtVmARxdpk2H09/oBw2wnHl8GetaMYmlzd0V+id?=
 =?us-ascii?Q?SD923Le3+ki3hZ3bt4iX1v+qEaYv6dtdgTgqWk5vyVNGpTyAf0YCb5Pp8v3c?=
 =?us-ascii?Q?C4R+VEzUYtd8fu2Nm+euI3fZd8cKdbf81zguhSOcIlRKKoWIPjaTkOJRJ5cF?=
 =?us-ascii?Q?fXuLfb30yoXWJ4qlAgSXb5Uj8Rb9MUyCUBWoJPI4hAKJKlZnynTsRk//OCEi?=
 =?us-ascii?Q?hPyh03eJshd49JpAadpSzgJwAuWWkY0/NvafPWFsAw7iBX4p3Ri7wIgoqmiF?=
 =?us-ascii?Q?cZXy/pDITFyxNqHQ1VLrn+GgOovf4ipxzg4DTZwr51CUZTKwbEaMckjnEM3E?=
 =?us-ascii?Q?s0qlu5ldcJXdp20t6/28SQJEB9JOZNGnfJFhxnUIE3wyle6Wtw5lvgxbKyxd?=
 =?us-ascii?Q?OkScIEQAsiZsUYIKUXlDTn2Qtd14vFP2uoE3BW3IWOTHt0RqAI1bAJEq8mub?=
 =?us-ascii?Q?/VKEi5D3ntduHABLUQgJtP3qW4XSg9N8VVT9lgWLMYin7YSu28qC9pmcqHZj?=
 =?us-ascii?Q?bQIwqXMjaeuxN9UL94RBMEv75Y4vPZ95SlydJUyb9UBtCkVJeNVCZJ2hliwR?=
 =?us-ascii?Q?+ILEL8hdbShk6IolYbFXuC99G38wzbAVv3qHaLZu/3scxSDFzBk7LXByQB+o?=
 =?us-ascii?Q?kbr5/0MkFfRpdqza/PNxEIDJ9z9m42lqSwhWFGud+9z0Eln2Ty5qkmf9wy7/?=
 =?us-ascii?Q?fdOk/6q4jUJIh2LLYg65Pyqln3+Xe2oFcC0uCWsBRx49dIvs/6YD48PgZZFs?=
 =?us-ascii?Q?CF9AmhbO3r0HsleHuFuaBwzHBH04o8EeBZuWbr5M19BUJpm+EA9+mCrUvkuH?=
 =?us-ascii?Q?bXtW9vbGyjyGn0S6+8+Pg6BRSbIqUCxuBVNPg3hnU9vCA8ZpHj7n9c4WzXZx?=
 =?us-ascii?Q?rNRknmv6jqU1qzE5+IP70jzhCei26LR40lR265XpnQZXJILF4SfworlCq8Fg?=
 =?us-ascii?Q?HOWJNtu4O26YnnTb6wgiGcS9yZGL1jKOh936B1V/DULMY9v3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95e1e0ee-1985-46a4-3867-08defd685311
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 20:36:04.7708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sBaqDnQoiZdr4Dr6CwwhoMSFuCEuXXbm3CRCN5hE2tKffW3TtQFstNNcMYd2mJhf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR12MB9572

--d7er3UIJkRe1Glzn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

One small feature this cycle, the noiommu mode is useful in
single-purpose VMs running something like DPDK. It avoids the double
translation overhead and it seems to be commonly used with some hacks.

It looks like AMD will probably get their vIOMMU support merged in the
next cycle.

Thanks,
Jason

The following changes since commit a13c140cc289c0b7b3770bce5b3ad42ab35074aa:

  Linux 7.2-rc3 (2026-07-12 14:16:39 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git tags/for-li=
nus-iommufd

for you to fetch changes up to 8c07df7cdfcf52f1ff276c588612aabc6c6b8399:

  iommufd: Fix UAF in selftest IOPF reporting (2026-08-13 14:30:55 -0300)

----------------------------------------------------------------
iommufd v7.3 merge window pull request

Small update this cycle:

- Formal API for "no iommu" mode in VFIO. iommufd now works in this
  environment and provides page pinning and phyiscal address services to
  userspace. This avoids nasty fragile tricks with mprotect and pgmap

- Fix sykzaller crash racing change_process with map_pages

- Various skyzkaller/AI fixes for the selftests

----------------------------------------------------------------
Jacob Pan (3):
      iommufd: Add an ioctl to query PA from IOVA for noiommu mode
      vfio: Enable cdev noiommu mode under iommufd
      Documentation: Update VFIO NOIOMMU mode

Jason Gunthorpe (4):
      iommufd: Simplify iommufd_device_remove_vdev()
      iommufd: Support a HWPT without an iommu driver for noiommu
      iommufd: Move igroup allocation to a function
      iommufd: Allow binding to a noiommu device

Peiyang He (3):
      iommu: Fix dev_iommu memory leak when device_add fails in iommu_mock_=
device_add
      iommu/iommufd: Fix NULL pointer deref in iommufd_ioas_change_process =
when racing with iopt_map_file_pages
      iommufd: Fix UAF in selftest IOPF reporting

Samuel Moelius (1):
      iommufd/selftest: Avoid selftest dirty bitmap size wrap

xiongweimin (1):
      iommufd: Fix grammar and spelling in comments

yeeli (1):
      iommufd/selftest: Fix dmabuf leak in iommufd_test_dmabuf_get()

 Documentation/driver-api/vfio.rst       |  89 ++++++++++++-
 drivers/iommu/iommu.c                   |   2 +-
 drivers/iommu/iommufd/Kconfig           |  12 ++
 drivers/iommu/iommufd/Makefile          |   1 +
 drivers/iommu/iommufd/device.c          | 220 ++++++++++++++++++++++------=
----
 drivers/iommu/iommufd/hw_pagetable.c    |  19 ++-
 drivers/iommu/iommufd/hwpt_noiommu.c    | 105 +++++++++++++++
 drivers/iommu/iommufd/io_pagetable.c    |  80 +++++++++++-
 drivers/iommu/iommufd/ioas.c            |  40 ++++++
 drivers/iommu/iommufd/iommufd_private.h |  39 ++++--
 drivers/iommu/iommufd/main.c            |  24 ++++
 drivers/iommu/iommufd/selftest.c        |  43 ++++++-
 drivers/iommu/iommufd/viommu.c          |  14 +-
 drivers/vfio/Kconfig                    |   7 +-
 drivers/vfio/device_cdev.c              |   9 ++
 drivers/vfio/iommufd.c                  |  12 +-
 drivers/vfio/vfio.h                     |  23 ++--
 drivers/vfio/vfio_main.c                |  26 +++-
 include/linux/vfio.h                    |   1 +
 include/uapi/linux/iommufd.h            |  28 ++++
 20 files changed, 682 insertions(+), 112 deletions(-)
 create mode 100644 drivers/iommu/iommufd/hwpt_noiommu.c

--=20
Jason

--d7er3UIJkRe1Glzn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRRRCHOFoQz/8F5bUaFwuHvBreFYQUCaoTCMQAKCRCFwuHvBreF
YaCcAP0fJaoVQUsH06GmCFORc+DEGga/fX6NORj+9DSpgCERDAD8CInJYgQDLivc
Gb4aNyXK26NXQUdfbXGmB1U+jEptmwQ=
=D5bh
-----END PGP SIGNATURE-----

--d7er3UIJkRe1Glzn--
