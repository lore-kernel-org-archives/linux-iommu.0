Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35152E92C0
	for <iommu@lists.linux.dev>; Tue, 15 Jul 2025 13:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752586694; cv=fail; b=SLj+hbU1f+TYEbdblwwQZcu1a3DXnARhCFbEObREdH3rPcHBFqSUhP5U2z3lIi5eLIfATnbBI7Q5yU4WMTsn20d2JkI9cksk7i8z0lRRqhq+YTQo6Kv90lX/e2NpLg/qUfSxH/QOYnkrEtEb3OFnFUQGEzyuBGfHr8SNDy4Mn88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752586694; c=relaxed/simple;
	bh=YxnQaN7cehkRMZXynfNghCXKgOWbeY6nP3Nz8gjqvAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FUeiUreYtgbySl8ajFgu9miDUiiDJ2xxmqkL0wqk+nnX9SlH2WRddeoxC8U3/JSGocjx0GIpGJVQMP1XMtZz+DSih/aBKmXApvztK0RkgL8ir1/iBi4NsawXIsimfKQRdXSQN/43YLqFWAlAqpsxFtLAKQooa8KAvN4a7d3gkPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ESvhnISy; arc=fail smtp.client-ip=40.107.223.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ESvhnISy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=agjE97SgIz+A4z2eMMAg+VnKezXJMZ2RWFY915x15LTD8yUiEUbRmGszsOWpTUk60GnKJNkjE2ETIYVC+EelCxtb+l3mDE/jnh0hexhIUB5JwbCNmbuNhvb7SdW+NZxAnFRAkoR4fEniOoYPH31g1DVupKEdcbIMyZvJz5W2D4tX+gQrr2HP0lw0sBoGyohjYLJF+5XtJQOHAeY+A0SFubovar4em3U67bBJ8Wyn20b+Uu43cTJU5tFEDbMmCg5D82hujMJsL7g1rPAbMhrG2/BEP4PDIgfCTHT0/QMWzxBeiYyYnG+pjcMlmdNPs4zwqLLOj9WEMxOlBtdNglknxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kCbwNOAsMJ0iTGiTz5aXbswve/K461iRBrfdn+VZsx8=;
 b=pPMAfRCPP3gePHBw56f2dBfGUVHMukPXe+/7m9ToLin+fOJSlS7gvzcitq3Jx5ocLu3pjrfINFr3ZWEpw/2kfjBrC4H7GsMmfy5Y6cPPC5SYY3LVdoAdnw/83OutYrhtbWAQls9OdMgnAy0vEF/0hW+D1u52WzaNhzxcVqCp9Lgzf5MgWm8spvackxDVUlyZEcIyEpN2P7av2Ezfb3dVa8FFfVyB9BTVcfDXICdoysWRrA8fj5sa3RpT40r6aHUrQ7ygWTVMprgGJNueaT+JoyGQrPn0UdzIdwfmpF7/u4ePkvehSw1eFUFFskCUc3Jhk/tSorM1diLjchd2hcb7SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kCbwNOAsMJ0iTGiTz5aXbswve/K461iRBrfdn+VZsx8=;
 b=ESvhnISyC0BlOLAOtAc6QlMDLVzfKWHTvKdV/D0p6Y7rMNGCqMHwuz6lrVQaAgdwPEXUC9tNvSVQG+CTVhD8QXVEunSgoacFu9RlyB8/emvAgpfGMkQwv2jftgvmRi8WF9Ws5tHFxV51kQaokmN/qMu2DO0KndSEzw/wTigMQgB4QQ6hQxG3pVZsguK2Di+GEsX7aSeDkaa44eKv7Cj7OuVNn2P2JKt6FlGUDQAHgaJOu5Q4gEymRCVPoysLGF3As80HTsRCStvJjZMkSr5UrFWWWZ8lU3kZZijPvTMBzMAxn89wM71s+esO6eCoZHRcWDMb+hrN2L2Jp8CbX4yS4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by BL3PR12MB6451.namprd12.prod.outlook.com (2603:10b6:208:3ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 13:38:07 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8901.033; Tue, 15 Jul 2025
 13:38:07 +0000
Date: Tue, 15 Jul 2025 10:38:06 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: kevin.tian@intel.com, will@kernel.org, aneesh.kumar@kernel.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	joro@8bytes.org, robin.murphy@arm.com, shuah@kernel.org,
	nicolinc@nvidia.com, aik@amd.com, dan.j.williams@intel.com,
	baolu.lu@linux.intel.com, yilun.xu@intel.com
Subject: Re: [PATCH v5 5/8] iommufd/vdevice: Remove struct device reference
 from struct vdevice
Message-ID: <20250715133806.GP2067380@nvidia.com>
References: <20250715063245.1799534-1-yilun.xu@linux.intel.com>
 <20250715063245.1799534-6-yilun.xu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715063245.1799534-6-yilun.xu@linux.intel.com>
X-ClientProxiedBy: BL1P223CA0032.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:5b6::15) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|BL3PR12MB6451:EE_
X-MS-Office365-Filtering-Correlation-Id: 55fb73a2-7e77-436f-0467-08ddc3a4d50f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?E0785xqrWxjdLNQnKClPVCwUG3raVOVWB+UjyYk9+WQZ3K65W8TEwgHErrMZ?=
 =?us-ascii?Q?gRvpB5tQ2Qu5nuWkTmh6bA8xs5OrptaGq0H1+OBurMbMFTU23PYOZxy+BPJ2?=
 =?us-ascii?Q?1THxvqNouIhL/NpsJFgekEQe5roGWMA34WFmx98WhSH0iAjL5eHc2ExQIYK/?=
 =?us-ascii?Q?YTCdyZ7AVT2A9aSeEZVs3pH3xqfcZcy6CdFkvueymtjSTmRoK7cZKNcsGOeg?=
 =?us-ascii?Q?2aN72A2lEp5N55vSqQv8e3VOaGpTvn75aVHFDVnz+8EvQmHPeaxBpiDxCHbl?=
 =?us-ascii?Q?fBgArjCJMi0S3ia4tgU2VbHUoLdTC6cQ7wYzE0ArPLVLBXMd6n/pmxr3QCeg?=
 =?us-ascii?Q?ym7bVt/V5emHOpxe1Mi6J7HwzWQJ0eRu2URHYoSYZ81ggX2ZQaBnbvnh8OOj?=
 =?us-ascii?Q?2s5k1+vttO8mDfDjMxSMizNjtqTFYAye06Wg23kRrpVPYlHp3LOqbl/4ClZm?=
 =?us-ascii?Q?vwvMGluwuAi4PPhm7KTnsIeDm/BFUO4o3LhYciCpJyXqJ3olJY4g9BZlgPti?=
 =?us-ascii?Q?gCogrxs05EsKNLLINscwuSEkMYb0ceCGeQDS6KCpu/RmWPSZz/ywKnMQRaL8?=
 =?us-ascii?Q?W5yR8oazxvM+YlfF3IWIle71r0pntOO0uRopXpry2fgngdVAilbS7Pgqhbc7?=
 =?us-ascii?Q?aaIYsXoo78dbGwGhfCCQH30jBBdtfRxJC87CxCA0naz7/ZQOjhrXxijrjxSK?=
 =?us-ascii?Q?xz3hYn8HSToKuFuSVNB1FU+hT60tO+pdsAlBiwssic87O/p7o+m/FfoOPmCG?=
 =?us-ascii?Q?Ci1Iw/Hnm5V72kseKF3VXMTkKYgVS+DyeSpsF3sMvJ5i9Jm4PmCvkDXUm7/O?=
 =?us-ascii?Q?0dKxDj4ovlKSK2+AhTvIsQj1g+LYCEmVNs61iSz5lVN3jFXVDwgGE8N9H92D?=
 =?us-ascii?Q?9aNhj5h81Var/IeTL5Hh54CJK4TEtydm8L3K9nw18D6bYw3PLBUN6zzeM/fX?=
 =?us-ascii?Q?WnxGKvwlqjJT1l6M2vfi/iqQutV5vG7VmqiWVo2gOqE6GakWXSh6f4i6/k6J?=
 =?us-ascii?Q?VhUvS7ndTf1l3209Br8S+CT1ocPK06BH6FGx59hbBg20logL61eJ/EGKiPBb?=
 =?us-ascii?Q?cOadsEb+z3s/id241Y6gg+YWzuWiUGisAaH3Kjx6U0zyd4OrbZ5bp6unaPQW?=
 =?us-ascii?Q?1iJNJBEVAMEw8lPqEoZF4nwziwFs0xyUu8LprnjWnsWerSZbxNrPRA1aQ0eB?=
 =?us-ascii?Q?1+v+hoEWqDj7D9wghCBfL/LJmJTCCdcUOH6aEAc9Czpawkh+mQjoNd0aSTJP?=
 =?us-ascii?Q?kmSq1mdehhhGQAG8GLWcKVhcECOCFruoi6xHkttqL5fA9E+ynJWVJ4mPE3w2?=
 =?us-ascii?Q?h43mFl1MbcuSCfw/MRCAhQtXtXFBAO2mBXeu6qIgain6B2kBKi45w/XekN4c?=
 =?us-ascii?Q?bUSd6OiivYA/FJgyWlXRJ1F5PbhYnYe4SX6QZqear1bAPtddVqHXPkQoouNV?=
 =?us-ascii?Q?WEp4+B6IUhY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?evQszJ2WzN5Mh1ikMTE+Qwy17+m6nc0PPJR8g5HvU055ZiHH6xD+k0atOkrB?=
 =?us-ascii?Q?OKvQ69tXyAlvhswURN0tw7BymfkxFEURdlUQLvDy2yeFN8J+HULHdtR6LG8q?=
 =?us-ascii?Q?V1HMJO/VTT5P5Y02wfiE9oI7Gm3Sl5zjBGTi60HNCws/V8R9OwEmzkkxRg7f?=
 =?us-ascii?Q?9/gbZP/zVzuVp+P1rNOBKHTSlBUVNHJLJhXFEjWuonNL/jWqo/zKVt0/vspg?=
 =?us-ascii?Q?9Irr42TLIJlhZYiKxHadiLuKu838VsJyGz+i7cJcukx27lZAAy+hr5TAamiu?=
 =?us-ascii?Q?eXD7hvrjRfEJjDFQiMqDCBlqUkoJl4OWI4ycQCjg4es2EGDbV83Ibr79sk80?=
 =?us-ascii?Q?k7NI0oAtV2aGrVAT2Wwv92waZYPs+94E7lx/EWF5RvxKGuK4yuM+WDzK8zy9?=
 =?us-ascii?Q?w7JiLZ3jnbXaSaTbKs7dw9fz+2sLILcycP0HF6EhlDoFF12kwlyj+HRcJG66?=
 =?us-ascii?Q?1A4d/MC5t09nID37MYdQ1KN0CMDi95NZSeR8HRrJl5CDoNqUPE2If8+V5FtQ?=
 =?us-ascii?Q?uC7i0XbT63M0syQ2qedhXObd2+WOcfaz8iaHd4h/HBdTrraV7bUY3aJkfiG0?=
 =?us-ascii?Q?cOQUmTYih0N7Ep2m0jfiM4WU1NOvpNNY5IdfDKf23KuoTbIK9+OamRJqLJgH?=
 =?us-ascii?Q?j0ZrXmDfAFapXlUsSh4gKKc6pY5zbqKWUxP1Xzr1lPqKJDsqrgk1xYl3awJU?=
 =?us-ascii?Q?zpxa7Ir64ofL4WnE6VifxxpDXfpjgNAzgqb6rbmGvmejkRlDQy9xU2l+cvrI?=
 =?us-ascii?Q?VY1su8tEM5fijRe0AuErfjH2HeaeLm2axnhfxG0Oi5bbevLYTVuPXOKQWIna?=
 =?us-ascii?Q?sFQBeD2JO5WLbwEjSGwHwcWyTxF1VQ87y1xpNAZ0sIrLt3C+Ch9V7CEOcN6X?=
 =?us-ascii?Q?4qnLq3uva+NigWh3HPJs7fPCc82Pm+Rh6zP1xJKskM1kpwN8wRzZbUX3gMvr?=
 =?us-ascii?Q?JERbstGi+OPKnxKgcpMHRdWlAuPoShl6E9KXuwrOJHmUcqHl/JyBOVKGDXOg?=
 =?us-ascii?Q?M3YhTBNZQCsc5cG7mnlhbWtwaoKKXDw3E+aYaZatJQI3A6wApi6m13NIcRyi?=
 =?us-ascii?Q?9qEtnNLFwfSuJa5/Bbp6N4avx+aPIJZ3Ps+1rZO7FrjS6QgApQ6MAzYjYXFm?=
 =?us-ascii?Q?70Q7+4dDkpto+9jHVFD5dhzX2ByKbNFlz/J8lEAoJwdPDPM9c3aL7187CvXS?=
 =?us-ascii?Q?i/K3vU7lFGwL0R6uYe3EKAMA2VzAqPYWW9qG5xYVC+rFVWPk1vt0lCI0HQt+?=
 =?us-ascii?Q?lVrHZj5dvIx6p3Kf/DLhsYO24LscKn9WI4V0sLpq4jJVvvWw/94FVPgK2UJQ?=
 =?us-ascii?Q?v4DOpEatpuMFjt+W88U0DzuOXQv2KekA2nA8T1aIwPkUQDOq2Jy+dRP+QK1T?=
 =?us-ascii?Q?FHuENCGB2pO9p5tj0uPwr8qTwnaIYOFdKq4cbVbtXhpxjNmpf59EaDhjpE97?=
 =?us-ascii?Q?oFg7rktcPT/w4La4s2Ew31TtJTVolG9LWVMKzJYyrjYlyL5ZjiUguuDH0pDQ?=
 =?us-ascii?Q?XDUaaCjUDKui1mqlkf2p1ih/xqRxOQx1rF4IyOK0HoN5BhHQP2j5Zk0gWTOm?=
 =?us-ascii?Q?dKSvlDBDX6hv38/AtTtmcTid/7qfuWZb/gxvb2RJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55fb73a2-7e77-436f-0467-08ddc3a4d50f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 13:38:07.4983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8eQCFrKStqjBKDGYy+YaNLcrUsvFXlIQKnH9LXVQuwu8MeggAskfqWcV+DbZJeLU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6451

On Tue, Jul 15, 2025 at 02:32:42PM +0800, Xu Yilun wrote:
> Remove struct device *dev from struct vdevice.
> 
> The dev pointer is the Plan B for vdevice to reference the physical
> device. As now vdev->idev is added without refcounting concern, just
> use vdev->idev->dev when needed.
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c | 2 +-
>  drivers/iommu/iommufd/driver.c                 | 4 ++--
>  drivers/iommu/iommufd/viommu.c                 | 3 ---
>  include/linux/iommufd.h                        | 1 -
>  4 files changed, 3 insertions(+), 7 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
