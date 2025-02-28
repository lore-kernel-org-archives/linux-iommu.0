Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2049.outbound.protection.outlook.com [40.107.96.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB571C4A0E
	for <iommu@lists.linux.dev>; Fri, 28 Feb 2025 19:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740771593; cv=fail; b=uVR3b+tjuAvei7eD9vdvo8rq3RgUXBuwXcIEjltNACEMJilJSlQHkDtOjPYnNq9j1DfS47botEdzW+kuY6x2X9eAd9+LHjvdYCqi+UkCGIBP12WLrBhvwVCL6oJ3KsVjcJnpMH0umTBUmkemxTFstI/bj0mAEzGw/2RpdPtrayg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740771593; c=relaxed/simple;
	bh=BOaHybyaYXAqymX5acVqQcwiKt/fvEoFWROEtCs2QT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=K5rH2GjABlxda6CRQ2JRDJQuDp1mCrucVSrz15c8qZ0L2w9xRk5w9Pv1N5BNuQFWAax0VoWfEA3c8sft4aGcf5QlxKPtvSdcD5l3FUN6fx3mahvzKrRwDvsCSZd9Oq4L5hK2OfhEJ6VnNhxGAIdgoSSKDT8KOzchPvYyfsfGECs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Go4UE0Xm; arc=fail smtp.client-ip=40.107.96.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Go4UE0Xm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o6EoPS4MYGL0drJvvQ1sT+FRAljpgMgUZSpIIwWY/RfETrG5scCRmMa4v4l0FVtLRMpUkMeTBPLM7NhtNRwm34n4SmR5rWbCCEUzcekHsiUVAiRO4TpHmQbR2h4qjvjQ8VfTs0emZk4y5flkdimQ1TO6+901eY7JpRrNknNVUTYOP1Zst0qvQ19na4PhsyTLGKmGd0Sa7/J8x9/9Zplvh1E1HFkQGkas/XjXW9iTXjqGuDGyodwj125+phGqkuPIznS5hCebcpprYkYQG3Bx5M9qMS0PrmeO7nuUAHfD0myZViK1Cn7w7FQvLfuTn2B/sAA9QQ2VULkgv/R383vYqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lCoyUd2MNEUPmZqMKo38GCWIr6JsREH48MAGeOVuefo=;
 b=aG+r9/xr2dBKUeceusuf9uWmttG7MnXGkbxW5z5ThRTE9amuPVDyODKUY4QDSJxEKvGA86u/zh1BCN0ELZH/a+u7G/SjE25uN0OjHwLOvcAa32RwOnPUArEYQxaf0rHX8k1XrNR+PqP87hGIYDfSOkzoPMCY4QeiGXAKfXhnvzca1qkwgaOyDsG1D/WqBY8pSpry5Tb/P6ohlNgfE0XzefwtOMVcCL406oI7EhfUkWUNz4DGI+pFqJRF9XoDpXdrxUBik+wDStP7ahOUNeeiOyPsaFpXTOlkyAmcl/68dQnCtjJQHRjQhrbfPG6qLdya8gnxa4tad+8c3vR2GQ2RrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lCoyUd2MNEUPmZqMKo38GCWIr6JsREH48MAGeOVuefo=;
 b=Go4UE0XmW0dz8H5Kl3FHjRAZM8NtAtRoCuD51IKBZoRGYhFrIBObaS8sSjExdfAsMRi4Ur82g+wm6vXQFfUQaqwAgsooI0QQd5iPaVai5kRHYA9JsuFNKiUTIqGACH1b5LHaaG6sJFdY8rl0v0ds+SEmJKIcIJgFdcZzyuOlD0fV7X3ybGjZSTtbFXXnK3IrpoqIGyBT83NMXMpd/6FbEogybH2a+yCT0rjkhbzUMmK7VO/wKbT81Zus+SDlo01QIWhgWcuZMfdKC6Pj5pZOH1NQeLThDvwebiVXkwg1Q3cvXg3Uh2/LlHkGDkhTJf9ejV3APOVlJss66gLuvUNBRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CH3PR12MB7594.namprd12.prod.outlook.com (2603:10b6:610:140::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 19:39:49 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 19:39:49 +0000
Date: Fri, 28 Feb 2025 15:39:47 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: kevin.tian@intel.com, joro@8bytes.org, baolu.lu@linux.intel.com,
	iommu@lists.linux.dev, nicolinc@nvidia.com
Subject: Re: [PATCH v8 08/12] iommu/vt-d: Add IOMMU_HWPT_ALLOC_PASID support
Message-ID: <20250228193947.GJ39591@nvidia.com>
References: <20250226114032.4591-1-yi.l.liu@intel.com>
 <20250226114032.4591-9-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226114032.4591-9-yi.l.liu@intel.com>
X-ClientProxiedBy: BN0PR10CA0007.namprd10.prod.outlook.com
 (2603:10b6:408:143::25) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CH3PR12MB7594:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d182375-e207-486a-999c-08dd582fa99f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0y/TDe7c+FfqP0oal9JNRhTtKYQcYrngU8jFiorWq1gDJ63B4/mRGpBk/RpF?=
 =?us-ascii?Q?e62Xlmsh4JUxTrOM40LeK7V/MNNc79mDyMfKLrd7cXA4FS7eDcpdy03HMwAv?=
 =?us-ascii?Q?XaO1rj5sKhw//Fc19ToaeiR8Cl3i6tNSdkl5QvOqaCXi7zUufYt4idL92m+v?=
 =?us-ascii?Q?jfysQgrOTBpfTjv5WSsb+M8D8Y8yTWirBnDjBfuMTeRbTZYRSVzpf0MxdLkx?=
 =?us-ascii?Q?Vw6Zyr4OWFImcJDEoYgQpK8iu8/I/SHIbALZoLeqtOIP/U4YDZZEbVvfLPs5?=
 =?us-ascii?Q?OYycJNPE8ekBRD+vNUUQizOH8nzC3VLA3U5K2eYIGT2UHGu6XYelA/rTlJfN?=
 =?us-ascii?Q?r3qftrn11RYGeUrY8aSsBidhWJJfbgu2JcwUZvfBirGQPfWks2k1vXk33Iln?=
 =?us-ascii?Q?k/H3TWaSWatKqVIT8zQrDFP0noHqjgVrMM3u9+FkPPAq3e7WbJnGbtSZ0R5T?=
 =?us-ascii?Q?ZiAvM74/hMdEtW/aa0etwyI89ldOYUVztTRQrkHDQSCQQd1JPNSfyeV9LFhG?=
 =?us-ascii?Q?WFr72R3xZUIKzEkmBjhv7KEFVHaNMCaUJURQrQbD+XhGhItgUf61r3zapd4D?=
 =?us-ascii?Q?8VL2MWIecV7hH2qHfDEc1lCR5dgF4CBDxKY1aiFyZ8GmjV2PO/q5PzOrpV+b?=
 =?us-ascii?Q?APKh8AiaadqiLvzzEiluS9Hk71+RkxWKlYN4Qs32HpsN6azj/V6pbu1n+1O7?=
 =?us-ascii?Q?4wFaNIt8s6bCeVGGG6diDSyg/WvS3IKSlbFZ2t+veaogD+lagRmTaaWTfK/P?=
 =?us-ascii?Q?xVWCtSknMMw7O27+Fycw5WeO0wl/Jo4B7BLYi5OTYasdFXqgTgIl3hHetPq/?=
 =?us-ascii?Q?nALHn0KvzEt6dy9mLQn5i72029UhsMtV+DW1B2LfQ3ek+L1BdrISm7mwGtwA?=
 =?us-ascii?Q?K+VNfT/+1wiweqOvqY8+OimZklKUvk4f/At3LeCd6xwJxRzNGL/esYUs/pe0?=
 =?us-ascii?Q?EnYBeHPzOop3ddg6h26SMPdRegckav+EmVP55dOjP2Ix2zrHw7APMnVFiDlW?=
 =?us-ascii?Q?cLlVyDimnkAhcHw0hDtYlaHXO4I7t8iashskuL6P9gP+X9tlNzwU6m2dV44Y?=
 =?us-ascii?Q?yeWtlwMO0QNqo3G4jJweUu7/edvIwDFpWxcKyTzv0hdyweZkysq/ZaWry/hb?=
 =?us-ascii?Q?19OsP99jsndJNfNCIwo5P1aJMGb/dHL5egJBGQAso9ZC2uBl3yBoN5k+yA0y?=
 =?us-ascii?Q?TKx4I9H5c0hhahsYE67GxOMnedsUSTsnxKT2ZBqgfVrPKxjqv96jA1V52K/V?=
 =?us-ascii?Q?FObqrZtC7Lz0wkapjLgtuH6GD1OktYpgIzIuWXNcDX35WzepCtyRLWEchOcs?=
 =?us-ascii?Q?EoBbX53hAOsIrLAqll6GsetsGiI0gO966AwFTWiV9a5AI40a0vLvt35Nu6w3?=
 =?us-ascii?Q?orabvJOAMBdLKEQOcY88AIuaBtLx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uVGAxtZ4WFYGJR6KFH2MhgKKma/4PAhMHOZC6BjIgfEk7bawoKAq8MUHBgAu?=
 =?us-ascii?Q?YYQOpqQj0h8+Wm1AqLHvFF1MRWedN3LKWceAEElR/6AtO9Z0bq9xiQtm/pTY?=
 =?us-ascii?Q?BndabJ1b/VqV1jYgNXXOUdVpLhEPPpAPBP4PcVRFOOWBm+hUF82QTbbGJWIO?=
 =?us-ascii?Q?bnk/3cnTbbIEV1t2+KiuaEZyECwqvcZwYp6AbbIGahGgDWOCVc8vt0hI9eLX?=
 =?us-ascii?Q?Z6ppj1VGNnkabYWzJS6QJn/Yt+4N3zbEpExvCCS83mrnKCpzUP5cBjWyJp+X?=
 =?us-ascii?Q?7cznemKcqVgG/oCuWj5p//IO3KqnBODYq1S/JwhEeVkbWmJLS6JZtBPkB44d?=
 =?us-ascii?Q?5IroZCNaKYj4Tgk3UvnsAmZoJtIDAQWSZwoy4YAwip3wwLOMxdzWCr3XpDAs?=
 =?us-ascii?Q?nGvwPua9Yv3/eoFJfQ9ZhRO1wupPETCgnenY0ExEK/TAROwmC4zV/YdQDJK1?=
 =?us-ascii?Q?icNMKaopJmvnUpnTN78JiZ8Zb+M35BFxRRvMdf4ZR8lJ6/fTgFst8oMMKjZW?=
 =?us-ascii?Q?OCy/BnLOCF/BO8S1rM+Qx192sckRdSsX3UCmypKQrqOLAqUZiOoaGCysMHrB?=
 =?us-ascii?Q?oy8rEm+BNLW2zo3JIIvP3qCXDfLorSf3sQdhC44B+AsoLcCx2A/pl4iQf4Hc?=
 =?us-ascii?Q?hToTvzhNlU8mgWNQ01l8h9py0qJ3v8pRUt/LCB98h+DCQI3lH2u+OkbuCy+B?=
 =?us-ascii?Q?kPtiD0aA7XVr0Fu1/Ndzu8z0pWUvUQ5fBl00f0VJYO60kXs8AjZ8hhfQdqkf?=
 =?us-ascii?Q?Yx14fXdYMUoOwBI8e35om+bT2oeUIgdaLkzSNAwuyRbZWMNSf8/RcN/GXqzk?=
 =?us-ascii?Q?86stzUaiss7gs9dl8awgcvRSZj7gsmzY1x+fftXe+ySh7TSFyo2YIK0jRkdB?=
 =?us-ascii?Q?yJG0fScC7lNMbud8xy2USgal7H5X9EKoEQ7Jt4pLP+A3jHcxt9duY7yW61uK?=
 =?us-ascii?Q?nvEw4IE4Xk57xEEMCuMrUaEQivSrxfzCrS2j9N3iavPlAg10CdmteiHiaOmy?=
 =?us-ascii?Q?uaQDBH+Ol1yYh1GuA9OlpJkXJagzpeY9U9uVHiTRDaUDle7BF4Kqn2IHOIMG?=
 =?us-ascii?Q?wt3HDE5C2ed0gTOD9jm2Aq2BbPNSXyY4sfwprSPYuA+aldHFe8ohjXAIjChQ?=
 =?us-ascii?Q?1qtJbP9dJn8ssn/NHVW+vAUy1oE7NYRxl08tdyXhkSMVLnRMoxVK7oqXZjXk?=
 =?us-ascii?Q?7sdMnq4ttCY/5Fd5jyhGW3roNdJ27dfYLHPAMNNFb9VAvRTVNMQ36BY8J84M?=
 =?us-ascii?Q?4KAmzQ+u5l0tn1htf7vq7ZCh10CfXKAhtqMMXrdj+KfE/yBJQ9lfnv/clgAW?=
 =?us-ascii?Q?8sp7WlMh39r3Nx7Q5YmW4e6GA7tK1C3d8ukblegAUhOkRVRVss+lZ/1eQAwx?=
 =?us-ascii?Q?MuYjCq+nY+c8tDrN4uSZ7sOJwPaZUVBkpIWtvHzimrOrfOrDX2uVSR92xuDg?=
 =?us-ascii?Q?XHFC5UWyojczI7zGgSqP8z7zb0ry9hDWEbvuRhfSdMvdvRkDyzo8VmEJ9Ncw?=
 =?us-ascii?Q?nHw0RNzPFF5/+a8TvwxvTNvM4TxrFzc734QDfIuJgVNQ/0TYsF8vgGwjsOkG?=
 =?us-ascii?Q?fbpg2K2J+l34G5/8OMIRl8LTZswvWG4onOqey8yT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d182375-e207-486a-999c-08dd582fa99f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 19:39:49.0613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Urm5OyAQrgFPI8V0fsyWm67TLhQSA9rROJMExHpOi/t7tSPAyLPyWGx27Ydih3SM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7594

On Wed, Feb 26, 2025 at 03:40:28AM -0800, Yi Liu wrote:
> Intel iommu driver just treats it as a nop since Intel VT-d does not have
> special requirement on domains attached to either the PASID or RID of a
> PASID-capable device.
> 
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>  drivers/iommu/intel/iommu.c  | 3 ++-
>  drivers/iommu/intel/nested.c | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
