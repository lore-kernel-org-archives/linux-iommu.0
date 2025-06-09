Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC9821FF41
	for <iommu@lists.linux.dev>; Mon,  9 Jun 2025 19:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749499120; cv=fail; b=WVIYQ6cC8/mG5QGYPSNUg37WhYDCnN70MNTwnBnzneOtYIwgeWzZhuBfzgmY1mJLsgjOTE500vFDFTClHCqaU4SmDTwFLlYr6Ghj6oFFt9cpQ3pDtvT79HQw7WArDJunqy1HGpaCWH+fllGSxcGxXVATn/M2du49ygDEP43iWy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749499120; c=relaxed/simple;
	bh=LbzU+8Dp+uF749sWyrWR6MzYsN+o7PPjC3jEkdIXOfU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=EVC4QU/Z22V/WKU1OZ6KoVG+fm+Mybbvj/aNNO0WHHrHysJjvZQkEG3JARrLB5i1avdMbpn21AIHUNMRd6kz9e4+feJ8PiPJO6wI40boWpWKikxVmBzTaGYpTpHE6NspiR7/a06H9Sid1tG5k8/fzRV2NNSRawbL8xCkv3WSu9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=agm3Ydjk; arc=fail smtp.client-ip=40.107.220.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="agm3Ydjk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u9rziZOxW0oijx/3pmdTsjgkoslywzRK3z+xsr9PZ7JabJkzm7iQpLRnD3Cz6HvBHTXoltTg+zy9+m5cANETyU2hUwgCoewMraQvu1CGTrnWF4fjCqCKjTHvboPgvhWOglhIsY9EM9pRSwqu+uyPmk8iKk12cVXflV+zlVK2eKWPdy7oksml0r2abdtzHz22GyQ+5ViqL/cXcjkedr4P7ZoYLkc2tzGgiY8PxC6tYsyeG4rMshx2yPALz3j0/kx7Oe8L0XsPSpotZrl7tLneBwtxEvDD7b7RkPzqWUMhYl+xhs4IPGFN+6petSFjUY2b0T1qWeZriUYhfrNSMl3Oeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aiwb/zXBJwqF3FxhT3w6sTuK30qLXVWIepw7LG4mrDk=;
 b=vvNYgqm5I0c90Tazzfa4w3UYY/0o+BZuXrr8sSKMR3TZNvIsB9GddqK2wVmfx1pgTHzOp9++sfBF/PXCY7X35DAX8vKEQXKtRbv+bC1b9ga6qcTzGvhGGy6YvUIgGfVCXj0TfzY21Y+px4SxXdsIpFrTsX/XuWOUtl1VSyALGIAutUT9XY3cSQNHJ+G8Vc9rC0gp+fVhCLYTVizGVBRbl5r5FJJTnUVfhNlCK+asdPXi+aox5CW9xnkwuvsvMEA3tLCqntURV5iK9YjqE3BuV2mFOheM5g46jcTIuip4y6Nrr8nI18Y228AJHE2awbWpF65JgnRehLXw3/YPQQ60iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aiwb/zXBJwqF3FxhT3w6sTuK30qLXVWIepw7LG4mrDk=;
 b=agm3YdjkO1g5gNoNy3+OKb+kvcRa3TLER50ydz1D9jHAykyZTQhyuRCAgPT2XZ4ZK5XHjz4Q14QCHLi4PdRTq7rABGzgv1mP5WarxigK+KVDq6k2ratmxX9RKxBqBiTM1MjoMLjQt2i9g4sOfSmKvB5aL/1pF0zQzeZ1RdjyVV0gJolA7hUK0tndIKJua88twQuhIT7yTEGV0m+PhFbmkkc65i3GeAJEaETKG6tDqlzFbBSD2VvnQxjgsZAiBfph5UYh1uMxU18AJUwRgcbMy63C1IJrm+n/Ws+70MUZ6MHkuYwpjHfH58bFTP3YSO/slIph5NhsvJVwjyFCNiMEfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS0PR12MB6414.namprd12.prod.outlook.com (2603:10b6:8:cd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Mon, 9 Jun
 2025 19:58:33 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8792.038; Mon, 9 Jun 2025
 19:58:33 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Lu Baolu <baolu.lu@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: patches@lists.linux.dev,
	Wei Wang <wei.w.wang@intel.com>
Subject: [PATCH 0/7] Reorganize Intel VT-D to be ready for iommupt
Date: Mon,  9 Jun 2025 16:58:19 -0300
Message-ID: <0-v1-20c73f153f4c+1895-vtd_prep_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1PR01CA0052.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::21) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS0PR12MB6414:EE_
X-MS-Office365-Filtering-Correlation-Id: 923ef67e-61f2-4874-a71b-08dda7900143
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wVzKWk0Q412BHk3UB5sypWJabMvgDZPEiPOpIjkcSDoZTrTSGah7ammXE/jA?=
 =?us-ascii?Q?Jpyr/pI845DDTtq+ZYQ9RypZgqcAOOAmlmDuFqYMS88TE85/0izMN3/a7WyG?=
 =?us-ascii?Q?5M3eRGY6Ton8vTWA0sazLqpWSPBHGrg2ap2lfWaVeBn0kSah2Tw9C1TxeYKA?=
 =?us-ascii?Q?BkkEUz1UN4es8zwOVnEaun9O+CsUkCkryVF0kuDWJEJbzyc23rcX6UjHCbNb?=
 =?us-ascii?Q?sJ6LEXy9FPlgiwJ2DWqI0J89TvTq2VZ5JDggfcOOYcf7dIWzm/sEsktlhntq?=
 =?us-ascii?Q?n64+y2tjXOF7BtRFIy5VugE0n0RCqe23dNvfyWJhTxHnV/vp9pSxIVfNIiz8?=
 =?us-ascii?Q?neddMCCr+QL0x+K9Py9KLo9w4QCTVXfZUeXLlkP8cbFLkZAzvLVxwGPkITwI?=
 =?us-ascii?Q?aN+glKGsbD3Yyqr3519gpNu8QNiXb+b4FLHyeKL09OkIKU2iNO1rAAdCDzlw?=
 =?us-ascii?Q?Ilp+ixu4og/ORLPqwkenKbmRXKVvUnnSCf4pjGWTE7JjSPd8i5L6otv/Jafh?=
 =?us-ascii?Q?dPF9YKovCQ44m8JIifJoVl6ao8hsqpragmKOxylL6wQh7TdijIL5Bhb0toNV?=
 =?us-ascii?Q?cyGR105yq/3v/xpHjisIDIEURIdVuM0K+iAp4pZgz1ASQDpal1/MSZShaKCz?=
 =?us-ascii?Q?Z81vaxT7nNSnkw5NOQD48fedgL3BASkjgm1X790HkOdLH2gSyi7CEa6Lq9k8?=
 =?us-ascii?Q?6mqzA0FQYMCqoLpeo0QKNRqct9hXN6CTiXWMsULBeUblt6SwpJDLqI6GLlPk?=
 =?us-ascii?Q?Js4ZU2FJxuRO8skFMTgdIbQ9vjM0uRRHpKpCZzzsuOt5EZ2yvmubxpel48in?=
 =?us-ascii?Q?3U2Rg/VZCIaSWkfYPqK8iPzJOdDI8mO9+V2gAQ6ZvZEjgx9nstTSW8WjzcLj?=
 =?us-ascii?Q?NatRvRJ3b66AvgPgtkc8u8MDtSK9UEXW7ewcyNoXleQDYUgWCJDkdWru7xjq?=
 =?us-ascii?Q?4Jht4UncEyDyeoRzpnA71LKiFftlaEasGQV0QMJwiQ/UUIdxGbZhOAf9l0wP?=
 =?us-ascii?Q?UaO4gfIrWMGm+jcY7R21mLE3Bq/iheyJomqW1hYhYPEuBD+huLjk2nsvZs/H?=
 =?us-ascii?Q?tFMcBZ0oRuNlHHVIdrRGA7HQtq0ZdBD0u7l5r9W+bbIFEySkKnXD75J71KTK?=
 =?us-ascii?Q?gRkFNiEFxa2F2h8AtnjBQ0VflLPulCDtPWgvqti6/FIgXa9us5j4DdMvxQtU?=
 =?us-ascii?Q?8//ONR1xlGD8Q88Azwy5p0TZIaSY/0Y+3r/d9/UVHkTQx4FHr4W47/gxlj4p?=
 =?us-ascii?Q?rTxhbaftiaKH/iFtPvNpl2ABQd/9Xa4Z195TZ1xl4Row703jxQPNmOVNp5Is?=
 =?us-ascii?Q?bjCBHx+A3T0/Vaj2FIuqyeWTNJuapV+ozPIyaHqE+8zV3CA/JNJ3ZLQIMvUn?=
 =?us-ascii?Q?dhI+dp8/29bri4HKkTQNZDAVLdeOE8eFVOtHlisGA3wIkDfrXFT6Fh4tA6p0?=
 =?us-ascii?Q?QG6kvhK7PFY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vYvR7Tn1RxpgD9gumOauY5HClSGOGuotIBanEN561BMTtJHp4KmVC/rqDRsV?=
 =?us-ascii?Q?SFBwfdEVAu10gCMxZRLHAHNCGctb9XUICf0V6IlUAa8OJxKYKi5dn7lH0/7u?=
 =?us-ascii?Q?6PjKZGtNB5F1W7hE+0b8fFZCEiz+1mwhdoWmKTv/1xc6pcAd6onAkKRH8N58?=
 =?us-ascii?Q?LQ/rR/9yNNVc0O57kwji/gfGUh30483Lwq3qIX+h/GvV4z4fCaD9h3ThnIR3?=
 =?us-ascii?Q?ggONto9NnuR2ouf4uno+JBPXY+SUZBvN+alkr0XtoRPvxmJNXKCqkxMVd/TH?=
 =?us-ascii?Q?FZUKJ4gNJzHUwWklZSSyvTBW79tawxbbdiSXDhEEnKhxenD+HBGeYicbWBP6?=
 =?us-ascii?Q?0ISp0Th3V71xvMvt+HVC5glbl1ixddA+WwCSIFkBi2AtpwGSJzGIHdYpGMlZ?=
 =?us-ascii?Q?qZUnfKLqOdjHN6ty6ETCtIjY05gXrgjQ4unQUhuGj/HClVmibAGEL5+ez1lv?=
 =?us-ascii?Q?JcexaL1z0VBZeUlWIH0TdNo8aa/OdcSTIm8xN3LTDxJT4moTiOcAP2LlnTih?=
 =?us-ascii?Q?fI0eXyc7cZbzQi+nLx7Vdp5FXMo8oo/l3lJeZ41H9OqQb9Q01hA6dmoZrQ6f?=
 =?us-ascii?Q?f/yH2iQqK2AcYxsnWgMmJOmCDS7Jm6WR5lHhdEMBLTw1zJ5ESe32LfWtsqKm?=
 =?us-ascii?Q?9uphpuhvdUoMuvDMhYwmOwgujkk4lqd7ncfRjB/BnVUK5wf7FW3iRT0wRlLC?=
 =?us-ascii?Q?T6TFaBwkmjGG00UmRpqwmYWPkdpI5hJTq00MF1tgHDmCKXS6MaxWPNncb89U?=
 =?us-ascii?Q?zjPQl6RnK/eirIntUdjUAx4e3KIGT4ZhhwR8b+xv08oDtggYnHv/cMzXHXyx?=
 =?us-ascii?Q?FinWxuiH4oX6H0MYkon/ehytOLWxl3RQfmy94v+DA66R5uhwnwgsXjlQ+G0R?=
 =?us-ascii?Q?ogCejHDnTaNyYZn5V13JlJw2fdZkjz8iP+XS9SUNHxMj81z6umIEc5wNScSv?=
 =?us-ascii?Q?SZBFoBJVmw6dLZpRUvQv10VKfOnthYlnhgl4mqvc8wQSgX4TPamyrKIAIdAf?=
 =?us-ascii?Q?AbRfTn59hIGhO4GVwVbHGXIzikCKEDZutgFR/HpnzlDZclD264HuJpC0b4eo?=
 =?us-ascii?Q?xQRPaNIk/doNQIuMK0be4XsCRwanAYJ3OTNtaQFwFDYStQwLkg0Tn5faY5Bs?=
 =?us-ascii?Q?IMLHT9k/Dp5dq4LbpLq3KJeDujU/rCxvnoV7MbvvNcB1e4d7B+IGLvcnFo4P?=
 =?us-ascii?Q?5lo+LQqeW/E27/g2ojiZJU0lnneSvQDSiKZu2AtR8Rvi7pf42kFiHYFmS3N4?=
 =?us-ascii?Q?PxKU3Lpmzv9jiIkIjdpBSqReesN4t9DUcfztq+l34+RQg8ZP1qi7NQEblTQ+?=
 =?us-ascii?Q?ZcHmHk97SStMuBQsbGQArWLMFuEMtiD4dQ93dCvmZzvT0vaqynq77fy/nMFl?=
 =?us-ascii?Q?gsuoFIcKTn8kBkkn6VgmxtAnyWW9UwC5+vzsxF5LxWsReG+/lxINyMwpNQk/?=
 =?us-ascii?Q?kytFdUbCSl0f1Xt6aGfSKiQN0KP4sMOJRMeevALmwBLuGnwu0CuALhA/BaEZ?=
 =?us-ascii?Q?2JaRQDLgpbP4Zul7TWuB/E6bpKKy7Krm1Nux+0XUTBrOPdtx6a/1nAjmnjQN?=
 =?us-ascii?Q?PLRxxM9HsEMcNE6XxHLmjknyXdlg7sKaNfdfxl9x?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 923ef67e-61f2-4874-a71b-08dda7900143
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 19:58:29.6420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GbuKkbSlp7eNmYp062azHx80f7QjV20xgPNgW9LYj7ospkg+fduj89yi7pE0BzRf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6414

This is similar to a series I sent for AMD.

Lightly reorganize some of the page table related code so there is greater
isolation between the first and second stage logic. iommupt will introduce
distinct types and code flows for first and second stages, having them all
combined together is difficult.

Splitting actually makes things generally more understandable anyhow as
they do share only a little code. Most of the registers and logic are in
fact different. That was being obscured by small helper functions that
combine the first and second stage information.

This would replace some of the patches recently sent by Wei.

The full branch including the iommput conversion is here:

    https://github.com/jgunthorpe/linux/commits/iommu_pt_vtd

Jason Gunthorpe (7):
  iommu/vtd: Lift the __pa to
    domain_setup_first_level/intel_svm_set_dev_pasid()
  iommu/vtd: Fold domain_exit() into intel_iommu_domain_free()
  iommu/vtd: Do not wipe out the page table NID when devices detach
  iommu/vtd: Split intel_iommu_domain_alloc_paging_flags()
  iommu/vtd: Create unique domain ops for each stage
  iommu/vtd: Split intel_iommu_enforce_cache_coherency()
  iommu/vtd: Split paging_domain_compatible()

 drivers/iommu/intel/cache.c  |   5 +-
 drivers/iommu/intel/iommu.c  | 321 +++++++++++++++++++++--------------
 drivers/iommu/intel/iommu.h  |   9 +-
 drivers/iommu/intel/nested.c |   3 +-
 drivers/iommu/intel/pasid.c  |  17 +-
 drivers/iommu/intel/pasid.h  |  11 +-
 drivers/iommu/intel/svm.c    |   3 +-
 7 files changed, 221 insertions(+), 148 deletions(-)


base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
-- 
2.43.0

