Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010057.outbound.protection.outlook.com [52.101.61.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C67A3D566B
	for <iommu@lists.linux.dev>; Tue, 24 Mar 2026 12:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774356831; cv=fail; b=QmSsFAwMm+PSXyoFrFeYwbc9mxGR31/ZW+zCiwTpIopmEQQkDchPSjpQmdNIMA4K0JgR2UMx8zxG0m00dggo2anQkW3EGxayA4016CfbKsc83FUe3+P2poibvrr4p0DJhg3R6PuwmBGKGoOKQeDXwBlJ3WM+CQHQLNu02HcGxQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774356831; c=relaxed/simple;
	bh=vbVj4v65y8plJUl59Jtezo+qC35cWfY1TTxdLl2gc0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=C08LO5elJ1DSCrUlKsaGsgBoHb019WXf2FRlXoh3KPSFYt7Z1N3xPXG95tw8CNkKMQwyi+IRAR/tZQLVFeNE7VpyQBoK5+boAu8TCFUune0BlmVixqPQMP4tQmH7983dIaYL3MaZQbrTi/a4sFfhRamO+PhV8GePKQBiGGbJZVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YIB/EAdn; arc=fail smtp.client-ip=52.101.61.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YIB/EAdn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gzS+vCyD2tlKs2ngZvSWCciqvng0vIjtBakV6fVNQQzFNKk6mV8IBl68iUc8g0ZR6UefVEEnsczEEugXmcHGAS42/EPHqUlNWenqqDmiBAdMwNeDL9/8OpusmM3PKwQD0yHmxzyCbWM7MI72zWiYLze+VFiP8/a7q+mTzpSSq3RZ1jRkuSbj6AloctL1fDUIdoEzsFsSl1oIjBn1L34WDrLUBX6G4eY6Ij/oi+ovx9gvfBLk30JGjuGsdx3S0GiPN0aQUz9UCSeo0YzWovf/5PRP5hf0UuKF9I4/cXDi3o06AeFHmuCwl3L9p1tMjjyHDUyD0Wg46CTN1jcqoD3CjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FwwP5MY5zrm/c2Zgvw9LkyHXhLf2+qAr1LW2ZV6CJMc=;
 b=nU/CpTGyulKH5gNPIO8vBb4mJxM/XjH2XNxHDtiJaumOUqV/oGUu3n2s0kBPLZYGv6mTMbJ5wPPEXa+2NdwCgBI2kYCbXEZvrphQKgxaAEwqQ26BZ7TUxA7lUrB5vTJ0k7rwTZElmZUC8hC7xS3P/RoSZgO8QzakcqPcZsxjme2chNHEjhJgX6VwoW/bXDk8hyd2g/hNNgPdiMMzE5eDKBspz5lZvGI5o8cwPoc6bzAZy+ArtZ3zPhjoozGPp9/gLn58i4iyoYG3+BGEfLlsehHFv9K8Hu/5pYWHrQOLnOO4pd5v5fgU7Gs5RJpw6oE78jyxaeDn5BdDCTvvEgmJ0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FwwP5MY5zrm/c2Zgvw9LkyHXhLf2+qAr1LW2ZV6CJMc=;
 b=YIB/EAdniuR4UzaHYVm3i3vP3EKpK49irkudVEEpFZOcBjZxD7yL38r0wh8buE1ONj5uURiS2o9/d5DgeffkjSmcrftRDMuUuSa7Vne7vYRC57J8cyjjeDfcLHvfvHGYoogSDxVA+O1pQDZtEinf18+u1MAMwZnt8qsJrG+lBClu2zYTh7hqi9A19Sr3g8bysLIGjmElWFAe0R1a3fshjUUNEMgGEO01zMEOwXEbddUenMDXYhgwng2VOf3TSg5ljOrH0Zom7BDplfxJeJiV5J6xXY6WEDJoOhKTq29d/uhQQUB0esDLy9wlPpXFdWRUcrAI1yksLuRyA/92NEBbxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB7616.namprd12.prod.outlook.com (2603:10b6:208:427::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 12:53:47 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 12:53:46 +0000
Date: Tue, 24 Mar 2026 09:53:45 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Dmytro Maluka <dmaluka@chromium.org>,
	Samiullah Khawaja <skhawaja@google.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] iommu/vt-d: Add entry_sync support for PASID entry
 updates
Message-ID: <20260324125345.GA7340@nvidia.com>
References: <20260309060648.276762-1-baolu.lu@linux.intel.com>
 <20260309060648.276762-3-baolu.lu@linux.intel.com>
 <20260309134116.GE3717316@nvidia.com>
 <4fbe6dcf-1105-4efc-b755-81a5bfb74090@linux.intel.com>
 <20260312114438.GG1448102@nvidia.com>
 <5c7503bd-e9e8-41b8-b275-3317912cc83c@linux.intel.com>
 <20260323130700.GE7340@nvidia.com>
 <83d78265-5977-42c2-a9e1-a2bc6f9342a6@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83d78265-5977-42c2-a9e1-a2bc6f9342a6@linux.intel.com>
X-ClientProxiedBy: BN9PR03CA0971.namprd03.prod.outlook.com
 (2603:10b6:408:109::16) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB7616:EE_
X-MS-Office365-Filtering-Correlation-Id: b5a9aae6-4041-4060-176d-08de89a462ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	3EKc0DvwD6VY+KEYQS7YJhImsehrS4/UAkuaKYpkc/ga44aOrLSbSc/LPj/NLr9fpT4dl0FRCY80pw0stYhDVdgqnPu6To/VblDY5q7SnEfCWfNJiqRCoNWIrppFxLumTxf4pfkkrVljnYBLFWA88YHzBhUQ04ql+bGLObLIQgRRIGdUFfa2YWPiIurNYzelapgDaeWm4n+SuTxbKC3O+k7Js2RsRAEVpNqOTW09mKeAeKaZE6qHuczhneb03gkUNy8qKWwolPvob3989XY//ojfzsy9oI1gop0/7/ozKBjRNcml8GvEJkvROK0YOK5H86/h1mRdZlb3LB+vpVUzIHzBbCZMNxYOtOCUenrHnu71kxej4XwM5jaYr7k1dHsj0UdWf6yuFubGUkvsbYo5UnhN4i6FPaMYMWAxwOgIr4MIiiPMSTHEurCj5VQEjhbFvwLYJ/sFdJn30Vmx//dYAI3VIrK9JQ4JQNyCn4SXBdcPgKXWEIsC5KHcq0PpIZvq/VqUnvmRIb8u7xKh4EiYUgBo2NhLOVG4+418CSctUVCdh851Vr4A2koiRvdV7N9Y4pYe3raBjHxzSfzDMj2mKBdWBS9/mgL5wxXL1s09hJ4fi7BJjko2EIxTc/wFzl2YxE7ogvF5FFEn7ssblTVR1m13bIGw9Q5QHjoXsde0Oxnu2maDSX+xqOjHlQoqaTivwH2PGQDVZVEBNwNhlG3gc+IBKcFvR2OA/+K7V/jvOBo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WAnjS+kXIHV489Fa4bLeVpJEIARXDsx3XLMnmtcTAwKwC4jSP1BNJvjUDeV1?=
 =?us-ascii?Q?xYHNpwIxRC9uRyLhqadKMqIKixZhbiSJuDQIrgXSyhRCDxcDHKeZ5/9tYudW?=
 =?us-ascii?Q?zx5IlwOb5gyGIroYjcS8TMFhrDrJgjMKApW69uu5m7Qv8WFN7guDW8q1Zpkn?=
 =?us-ascii?Q?jvsw4Kni9DytD4fkZkWvyIV/zkL2t99HIF7lCC2wUS0ycxkcK11KZsH8PVCZ?=
 =?us-ascii?Q?nhOdZbwR48U1P0rajRRJuFFxczSlsMCFEdnH4yxvQOYX9Ib31frNnS7Dx8XO?=
 =?us-ascii?Q?u5BlaulMCj6gKI/ZQRviD1pYe5peDzFFHBNlTre1edq0qAvpK3QSzlMedRI8?=
 =?us-ascii?Q?WgWLQ4HfRqztOjul1kUlnX4DguVVZK2LO1B4yh1hDJ4ZnWb8RfWAEVsr9aUW?=
 =?us-ascii?Q?U/emyg4bn2IGJcgHuA3Lq/xuxXBTw+wRqVlFmh0/hv/LRQHzCIjZHyo3rba8?=
 =?us-ascii?Q?1axKmj6FsyyTyyEB42iMdO3VEunAd1Ke3oR5f4grV/LcUNrtI1Rtiq8ZoxAB?=
 =?us-ascii?Q?hMOZCbszmW1A/fMVfBm74dp4+/T6Dwu7FAmk8b7TfdwejGz7bp0Ku3p52tGq?=
 =?us-ascii?Q?RWruznmYriRqIWJUPURUXg7yuogHOD78f8OmMtU6S36aHKDpCPaV9lCJmmrT?=
 =?us-ascii?Q?I1Jw7Gm8ji9ar0inLUm2fM7EXrqfp7UGFrxNNN7haaNL+Nl/mdRL4LewvuST?=
 =?us-ascii?Q?MvmQggTX7zU+BlnbQpyv92qAcWHzam/mjpWStFOlAp0NwITZLk5QR0gd+e7O?=
 =?us-ascii?Q?oQDZMNzbXz1qWQ/etBiv6yWExLQr8pyvL16+/VItH05UMY15ZSot9AQk/O22?=
 =?us-ascii?Q?Q08JyJaifJI9Pl3MYY+UIB0CD3mgwF8zUb0AR83bRDdrUgyQRqla7xceb+Cs?=
 =?us-ascii?Q?TU656vkuZs994xc6dD48OlPgNUYARgnbTYtqSAaG8t9a7aeG37PDcuGk7pAf?=
 =?us-ascii?Q?L9s2NGZJAlYixcljUWouFxBMDB0Zr9HxNUcJYWwsFaECdR7nHRzBMW55YOaf?=
 =?us-ascii?Q?CUiG+BxHtD3E0SUJrIYsFYCqHA+kzThIwpMyrEtSr5+1heY4UtvtB7kQvPsE?=
 =?us-ascii?Q?idIu8RtZ59cXW5mlXskEp/GdILzxdF2LHCcEtF7enoWlPOvEaiaTD16u+sTz?=
 =?us-ascii?Q?SMTEjjSr0/waQq32JH+r7G9oJAzgeMNWDIamWzpRZJIcJfpNlP+VQtOMMVY5?=
 =?us-ascii?Q?iwpGXkoG2wP3x8JLSilV0Nn0P7CMDVL4XgsuIazS/M3ImMAXFH5qgNCDc06b?=
 =?us-ascii?Q?QGJD5eOPdgzQvOoqpMa83m4k3LZt5cOt2EveN0rBbhiRjVL5bastOv3QyqfA?=
 =?us-ascii?Q?9QdwIOSn97gVvulk1ddJL8RHGAqUbFAjyts9GBYUnLpNFN/BUW85jSWV8uah?=
 =?us-ascii?Q?OIOU1BTOKpH3EMZ5sidjyJshIk94lGr3tpuQDetXr6E4F34AYaGCEyoOC3i3?=
 =?us-ascii?Q?VIF1TXlm59eCO0rJsk5xAUQU28BG1n/CTrWoNiiYAudFHoPc/AlCTdwOEk5v?=
 =?us-ascii?Q?8p6DLgmoZ1t/50Cuo3GStdBnp79VQQ8sjkCOIl7oibIjBvu4w2d55poz/x8H?=
 =?us-ascii?Q?vDoiDaujeiDFYONDsDpEn9RO0B73P+0/CQDwQ3/Quj3WnQ2jWCqxC2p/BdyN?=
 =?us-ascii?Q?pV1wZomzCPbUTCySlUiaLBRQx39d1Sy+szw8DXqYWD08LOECvyokzW+f2KfP?=
 =?us-ascii?Q?3rjEcDPqYUq0ARPcZKq4EapTfp4uAAHpT1AFCGBWQzCAWjgv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5a9aae6-4041-4060-176d-08de89a462ff
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 12:53:46.7659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sz4qZAOugC305ttABK6YK4g8wCPk0YK9QrGMBVXn/yLJWfkHS6IS91dOpQQtF6gJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7616

On Tue, Mar 24, 2026 at 02:22:21PM +0800, Baolu Lu wrote:
> > A fencing requirement does make sense, but does it have to be done by
> > flushing the entire DID,PASID? It is ugly to have to drop the IOTLB
> > just because a context entry changed.
> 
> I believe the full [old_DID, PASID] invalidation is a functional
> necessity rather than just a fencing requirement. Even though the new
> PASID entry points to a new_DID, leaving stale translations tagged with
> [old_DID, PASID] in the IOTLB is problematic.

You don't know they are stale, the old_DID,PASID could be used by
another context entry.

The proper time to delcare an IOTLB tag as stale is when it is
returned back to the allocator.

The problem in the VT-d design is that it is complicated to manage the
DID lifecycle well - but the driver itself should have a clear idea
when tags are end of life.

Yes, it is a very reasonable simplified design for the driver to say
the DID lifecycle ends at every context entry change, but that is very
different from stating the flush as a mandatory requirement from the
HW spec.

A more complex design could have each context entry request a cache
tag for the context entry, for the specific domain, and share the tags
whenever possible, eg for SVA and S2 domains.

Jason
