Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011033.outbound.protection.outlook.com [40.93.194.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3E83A9850
	for <iommu@lists.linux.dev>; Mon,  1 Jun 2026 13:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780320647; cv=fail; b=G2q0cQdvKzzgigqFgsIs/8p3f2G7WHSzvi3Mw/2sL15WLfUr3roGpYGNCsC76KMZFem6GvPBYpsZsW6nBUf3auxMrOUxKGa+0Yf7lwsxzkABIpWxRImpawTezzRsl/QxoieCpGrYYCq5AQ8dML5iSadfQTxgWxiA6FcxvLYApno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780320647; c=relaxed/simple;
	bh=Qvlzo0APtBrflihPvlIhU2UFnygIXpwnhCDvcPBclqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S9qQjMswVfAG4EYPrR7OJw5nCCM7Rreis5EshJ0cf5admqDN3UP6cP6fF3VC2iMvoSXB6pXzYnPo+NlNi82P6BWeelDU7aFOdXN4631vpIy0VxL8RgjU80/wfzZv3vqKwsCYYROdyrMwsRlBzE4VNzXK9cDRiWUnbOfEcka1Flw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c1Y7kHOz; arc=fail smtp.client-ip=40.93.194.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c1Y7kHOz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mKo9PWKfAeVs9oJnqrsqvIuCLKFAeKRVPsGD/GdU5AYQu2bCxFbT/xWtjPShDwqaQe5bprnsCH30wtQTNjjOlB78XYVwk6IUaKfyAGdp8jwM5Tq8K33duHGjNC9FYx9SzmcdJr2psJm9DT/6yIXMGTSG1tF6g0sX5mRDq/o0h/6V6z/YcnXW1RU8JqzbVt/VIAUKxaNO4htRBPMsUnSdJuCvmFz3HLQkNvRqpToXGmLMyaViSndaN9A/tw4X5xCKkr3fdY2FIIhtAYx2hZe8NbTqFKf8TRj3ubeSiu8AXLDGVRcbdy4v2Dg7jbDg3hyuBX5KAEOzztUcJq2N3ZPVzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qvlzo0APtBrflihPvlIhU2UFnygIXpwnhCDvcPBclqQ=;
 b=uS8lSww66CYV8Cq2oUHTo4Rw1Pj45jNGRR9W7LWGVS1AyA/XGbHj0MzZDYHKbrjnGW1S4ykyXEBFDSYqNer+IZ7nY+SDgwcbEMM8SRSPgEUkQM8NtN1IEkE/MuAgKBXH+W7hqHsPWbB5ExvpeMXY9OYvcQ3MMslD6mIvruFMH16JpgffBY1OiaNov+kEDpsrk46SpiXV2SeOQ+sHMm2SEzRr96w+mocEKZYmpc3wGcjaJ79BLTuSatlXyu/aFcRQAXPuOxa1oSFNdhknDXhUJFYW7X/aD9yuWLE5xqrmrcPOInXpkqgXS8ed+HiiDdgegiaDS04fEtVTbsMcEqwzYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qvlzo0APtBrflihPvlIhU2UFnygIXpwnhCDvcPBclqQ=;
 b=c1Y7kHOzqgXEYljbGbjwD9Lqys+KYRDQ/NjX2Cx1WJUaDa6e1bZI57ZJgmCvcyNW4wBhKtny6m7E381rijKSJc2pZazaY9BTV6ZSPM57yn6ZwkpqHxsad3Hv6CxJ+e4NT9tMP6Fa6sEc8+cvXYv7VSUAnp4TTRygdYRV6bksW+Rnoo2m99skg+zCQkrpJ5L0WPUfVzu1HxnOeItNg05dnnanGAA+0m+5p8fXyAETlUG3YH8/I4pcidPveqifKgLOip2iGnlH6hk0yu12SRb0dLQLThpx5ch8zdage9rpy9elgBJMLZqj2bxqQLhChLr+lAlE8xChWU9o9DN0puqghw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN0PR12MB5930.namprd12.prod.outlook.com (2603:10b6:208:37d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 13:30:33 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0071.011; Mon, 1 Jun 2026
 13:30:32 +0000
Date: Mon, 1 Jun 2026 10:30:31 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
	yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
	vasant.hegde@amd.com, jon.grimm@amd.com, santosh.shukla@amd.com,
	sairaj.arunkodilkar@amd.com, jay.chen@amd.com, wvw@google.com,
	wnliu@google.com, dantuluris@google.com, chriscli@google.com,
	kpsingh@google.com
Subject: Re: [PATCH v2 00/26] iommu/amd: Introduce AMD Hardware-accelerated
 Virtualized IOMMU (vIOMMU) Support
Message-ID: <20260601133031.GA403363@nvidia.com>
References: <20260528051738.596013-1-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528051738.596013-1-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: BL0PR05CA0005.namprd05.prod.outlook.com
 (2603:10b6:208:91::15) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN0PR12MB5930:EE_
X-MS-Office365-Filtering-Correlation-Id: ee4ca0b3-69f3-400f-79c1-08debfe1f495
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	++M746y8Bd4KOGJ37163vNQKOHH7Pq3aakgqfY30TRz7GmERCPy8sOmu/2pRj+WsZrKOYvrkxn4TaHHwGV7sRGzLkjMzpKKo+pmd0Leog9GN6oRW7L3W8gWQ/4VaYcTFH+dt4pHP4toy5MkhdL6qagJV7tGn4nAvmMfXmrmS/5+YNaHUEfrtnS0HgMJwqgSIguLmshSfkvOoAWfOaZrOvMhKO6Kj1TFyYoNqqcQBsjJn2lNXQ+i8DOcy/ByoVl0zRpIVxesav9KlMdEjL/iK1IwGBzANLKkgRvd3VnojwHfINPvGcTaIlKQ6viSocu4gIVo+6RoVYQL8O966eGgEhVpwC3LSrARlMzbAhbgFLoAB0lmomhjHYAfCXTaGvhgRDHO2eJGa0TPdZueLgrIi+5Of0kXjuVlFs06K8NADa/SjDPzpAjqXy8fmUES0PPFvaUsJVP07jhfjgU423dQ3PzxeysP+bMX2laciMEYZgfdh/EjNdSN88oMMlsTZ3lx4wmPNs2DJdKQ0dcmHsxVEHWDbY3rFDgeJ8Mj64up2CIttKqTRouw7E71DWgxmeoKJ1rUoxUIriuTKmur5Olw0ZiUnvQ/JT29JtqH1psjiOfFythBoc8LU87+5qf3kDjE44v6lnB8pFiYdgyB8S48IaYEeegAXW9tBw7ZseX78U37KubFSHDTiiNprjMIbBk2rrvWhP6kiRe+d6Yf/NPmHZQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TvX2Q5f/q2XcPpzcGH/v74jWHzJPjcOvj0E0JmAVNsBR13v0Aqf6bxc1T0dp?=
 =?us-ascii?Q?3Xsdon6mY78HJzTF6qVMP4bi+nttHdJJYgZoj9Nmi69fuQ3dFmacWeM2tY42?=
 =?us-ascii?Q?PoT4jn8OpSNtb82JRC7UNTOGkDuFqdXUAvwc8Y89tohFzpGwu8zmhUurfk/X?=
 =?us-ascii?Q?lFeyz3+TIdQRxm/aW07umNk4B1apULBc7gK6Q2gODj5ZAKqd78t6PAoGOW35?=
 =?us-ascii?Q?zk65/PIRB1h6GG7UlMnTZeVcjLCCc946kBHp4y4DN0PhBS15hkk/dFpUChOJ?=
 =?us-ascii?Q?ixtAo0KOkdu/WQ5VDhEZuT3mhTkMD24Rbg/Pvy8DbNPgTLDR81k/hFF8mHFX?=
 =?us-ascii?Q?9FtcRHgd+fyfMwAL02nihClVtHnfpRwsuxF208BDrbqhnhTPWpr3/VFWkxpV?=
 =?us-ascii?Q?i2Md6A/U92rpBy4aWP8DYpfEKbo7im1/f/wEXUBL37fQrmxTzPML40ioF39R?=
 =?us-ascii?Q?JrdHPISs1gnkZU1EooQrStT5dMkq8fPe8qP+zTGc6IM//QmIIzigcQEnS5A0?=
 =?us-ascii?Q?rCjiitoJkDqT6Uy4UaQSQeia8LsBi6feeopXWPVk5QgThZ3qsfpoCMym1jIP?=
 =?us-ascii?Q?KEXsXyvXAuyFN48LnPvd+PKaWCXH3XSnHJMLJ5nVymqgDg7nDnDZgoYvqVmp?=
 =?us-ascii?Q?BmGSFORcKN+F3/bdOqxDlQ9cPnFVFE85jNG4AHKZYL9JEKs1ViUOvoqeR2u7?=
 =?us-ascii?Q?m5ejsM+dJBinzvOJDw799eE3WttwGj86V1xqiVu0VaK4ZjuRuXi76N9OquKE?=
 =?us-ascii?Q?Or/tNr7BKNAKUHrzuc3aCTZWvtsJpai6qkIasTrQKwCRXSQE+mpHuk+AmCC+?=
 =?us-ascii?Q?wJkx7V+uGwwjYLVeNI0WlGtEnEeIMF/ZVWoGzZNijB1W5oc3SH8cAY67Liwa?=
 =?us-ascii?Q?C6p/XZsq96PQSYrC+YnD0hvWeHWvv9lzqXqjXmmLyirpWlkoNh9qTyh1MdRC?=
 =?us-ascii?Q?VIHHv0UzXKQHn3S9zoYJVttckP9f6k0xLeeAUHtiOHbIy/HVSMspr7e4ZcgR?=
 =?us-ascii?Q?JL4gqMenVNbmiQTBqQtCAIDDxoGP7nlSCaIfbjRJvSKpRJXhG+7pXUH3YOBp?=
 =?us-ascii?Q?REj3Ic/PDJWThvr9zSs3ogUPjL3YV6T7wr3aQfLHTe56pyA26GOxTifV1Mge?=
 =?us-ascii?Q?cL7Sef+siyUcEvK4Pmc5Nx79FsPP6vQNVgyrnbb4ParmDVvHacbMaGLd5NaG?=
 =?us-ascii?Q?w4tGowYd7KrTvY+XgUw57pB3oo1bzWoHfvbau9pRPoiDTauqnScVDjP4vgX/?=
 =?us-ascii?Q?XKmnT3GgRkw+6SSw5MljkU7gl7ACo4g2jtE7QKzHWIBrCf4On//ajTq6Ilr/?=
 =?us-ascii?Q?FfOaEqrJEXzP9KeiySpiuam8p6FSLsH/OP5/eyVTzzHDrB96eFg/uEIvz7zp?=
 =?us-ascii?Q?VFDsRazNDLdoZWIDB/iJyZVtsNIzFQnFC+dLp9Epd6M1NGSZ3tTbr8+dIwx/?=
 =?us-ascii?Q?rV9amWaLSo4+drX3ywBcguxj5juhZ+fD/ErnjnQ5zrc6tEB2vZBIT5gdzzBo?=
 =?us-ascii?Q?X7/h1HgV3rTbUL3lmRVyYt6azCErGG76JGK89fNPP3gIr8zVO5j8qVtx70OZ?=
 =?us-ascii?Q?m6h/Z/teLZqAUFg5Bvoumu7A4eunBGAnORklKbGLLiQOSSgLTfCeZ5lFq5bD?=
 =?us-ascii?Q?lU9ApVFjdZX9PPiKCqlzPxqTEoyT4zsCPL7/U1aMOZF0zROsKhuCUyA/uQjd?=
 =?us-ascii?Q?8HzsC8Ypo247k0CbfEJOrpb6Rq5wdUm4t747Vdlx0dGE5ooN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee4ca0b3-69f3-400f-79c1-08debfe1f495
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 13:30:32.8240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J29lrrqkwVmmRm/kKoiXPb89ixlvbWnrlFzQ/WI4HzFi7siNO+HxXnmOXBM0g5E/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5930

On Thu, May 28, 2026 at 05:17:12AM +0000, Suravee Suthikulpanit wrote:

> [1] IOMMU Specification: https://docs.amd.com/v/u/en-US/48882_3.10_PUB

This link doesn't work

And I'm not sure the older PDF has everything, I haven't figure out
where in the spec this TransDevID stuff comes from

> [2] Linux git tree: https://github.com/AMDESE/linux-iommu/tree/linux-7.1.0-rc4-amd-viommu_upstream_v2

Build test all the kconfig combinations, I noticed problems.

Jason
