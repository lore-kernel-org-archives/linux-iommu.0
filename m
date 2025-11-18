Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010050.outbound.protection.outlook.com [52.101.46.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1212FF64A
	for <iommu@lists.linux.dev>; Tue, 18 Nov 2025 14:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763476623; cv=fail; b=Hp28cDnRWwUbXsdxqSudxJ2C0kS+22sVA14O8M0Ka1pbJHEUkze9XHWL0hkuGQLrlKoH8Arxy/3lw0TFjYSywflTHI5pLQ19APFXR+GDSkxwt/wa9YzdfoUAz++yhKfnFNwYJlrYhpgrbo1thSpT3NV/zzIU6NPlizEDjdZMVkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763476623; c=relaxed/simple;
	bh=3BDxsdu0SjRAts+3TNAfENLAydJMR+CAGyPeauPrhWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=r8deX9/Gl3WA3XhAV6LukEbo38NOcplOnnLmzTUKKJFpvc/f7ltCyUp3jEryU1ZLBwtoWxGfvau8GfId5xsbyfkWOLxaZ9lWAV/CkM1dVBsNIuw+dmanC9u495hoEYBkFHqDZ3E20dKgNRhc5R8ZpRwtIL0VCggUufQ/Y18hcrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TeBAqZPq; arc=fail smtp.client-ip=52.101.46.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TeBAqZPq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xab5GlnLbNarVk+yhUqn8GZ7z9DuSPWNOCN9LwleSrKuwtfUIIhg8owchAIRM23XPMeBUNTGMIkvy2BItU9tQn1J7gX9HCpvliijaNTn6IEEQiSmzznxC9Jb+wtCHJPv9JiO3BmIxL+eb2EBILIuiwX+UMjdfmGS0PT9x5p1cw/zIdcquyLgCabDmIVDIaDWsfFX0MF7sbbC0FDfsJql9tfafeANh4BqJU4hNbF5GTLhj2EyY1BMi6LnN0dYY0oHQm7SGiWLnZn/Pvn0WEHFEVFxYTwWYFaLwKQurgBtyZwzzAJPb8hsnwcLFDLCC2NsFkCpupePKzOa2hFjpEX3Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hhqP6zv229KdUaeZNgVcW2W5IQQCmflZNwDXYhg3Y3Q=;
 b=MJWmlcO27nOj5XeYZfogqDY35yDhxidHfbO4jeBOSO1fxCmmRh/vR9eNoxlIteZIGYoMIn31WJqswSjmaP4ybfYgl/EqnhPqV8qyZ/tO40W8fqvINhMviqyoX6zj9ujdjIeI7I+4SCMIVz7ag6Lv32kmsYtWzh+R/JWz74w1cJDdkFkeHT7yTE1wKtg1t5pg2r+cM2afjEOIp6SpGelzuCubGGJvdUV26hKUL6DB8UlDUQXyuveaexQSZLRJGBy6vYAdisE+NBx9aWXNWMQYl+dlcFIf7NOxSD1MbAInrnDsbt1oU8b1PKz1mAmydV3ve2K8coOClXGV8dtpgcnBhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hhqP6zv229KdUaeZNgVcW2W5IQQCmflZNwDXYhg3Y3Q=;
 b=TeBAqZPqIQngX+yG7Is6RqOo8w+9Y+e6rv/fwHfkamzqNtyL7f+ahEegg6Cbvv1miQGh52Nfbvv7Jwu2vSGOitMzja+SBL53kec0A99vrQHu5pf2AOeXRm1fwwgGBn3WTfEVURvWtAUDS0pMg0c853hxOrLKM2uMtJ/SGYT8+zMve7nB3K3W8OeVDP8Eb7StoJGRHTl7JujlnnRB9cIZUp475XT9WUd43p9YnE52bhj87XFdDa/FYpqNKEfbpp++99Fnni8p6/3DsW4GB9RYySlKE16uVnyCIx1V5uTEcuuxbGH1gM1o7BF1kQeVpHjQ3DNoptGLTy4S8zCxsyrkRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by CYXPR12MB9385.namprd12.prod.outlook.com (2603:10b6:930:e2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Tue, 18 Nov
 2025 14:36:57 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9343.009; Tue, 18 Nov 2025
 14:36:57 +0000
Date: Tue, 18 Nov 2025 10:36:56 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Wei Wang <wei.w.wang@hotmail.com>,
	"alex@shazbot.org" <alex@shazbot.org>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"kevin.tian@intel.com" <kevin.tian@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Alexey Kardashevskiy <aik@amd.com>
Subject: Re: [PATCH v2 2/2] vfio/type1: Set IOMMU_MMIO in dma->prot for
 MMIO-backed addresses
Message-ID: <20251118143656.GL10864@nvidia.com>
References: <20251107010349.GD1708009@nvidia.com>
 <SI2PR01MB43930E5D802B02D3FCD5ED9ADCC3A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <20251107141632.GL1732817@nvidia.com>
 <SI2PR01MB4393E04163E5AC9FD45D56EFDCC3A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <20251107155704.GM1732817@nvidia.com>
 <SI2PR01MB4393E3BBA776A1B9FC6400D4DCC3A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <20251107163614.GN1732817@nvidia.com>
 <087b3567-5c74-4472-827d-e5a47761a994@amd.com>
 <20251107183209.GP1732817@nvidia.com>
 <a63411aa-6590-4bae-a7f7-01be8ba27eea@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a63411aa-6590-4bae-a7f7-01be8ba27eea@amd.com>
X-ClientProxiedBy: BN9PR03CA0171.namprd03.prod.outlook.com
 (2603:10b6:408:f4::26) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|CYXPR12MB9385:EE_
X-MS-Office365-Filtering-Correlation-Id: 891512b3-ce0d-4f08-9456-08de26afed33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dn7pL3clfbFgNXa7IxWfJT97wbOODty6B2SjbHL8lkg30ldyRX3OI7s7GLkq?=
 =?us-ascii?Q?ipppDzTBQadiR7N96/OaNntRHcECKUwiJwg+YWsFxD0Z58CsDaIpA02p6ofg?=
 =?us-ascii?Q?xCVg/k6l8nQGFyup7u8YmuMs4eRntrR9PbeNCv86GVaGiOu3a89yeFNwfADA?=
 =?us-ascii?Q?CeLGfdW1ZSfLJGeVDW8in/8M1Hsl0XJnaMUdFP6Z4WUCpjE+/IDxpqLH/crw?=
 =?us-ascii?Q?D56LPv92w7Y4hBJjYEgeBRLowo7/CgFTouNXHag5UDK/165tBZX9AfOYA+P3?=
 =?us-ascii?Q?t8T8XQIPWulvK00FdyeAKBIdl6m7jRajIo63tTFbnM2G/yKs46wGC/uFuvTi?=
 =?us-ascii?Q?QRfiUNMbFfVj438yDQinfzDxodstZIeBbewic8yP2T+q6K3XxXUxLgt0tCn2?=
 =?us-ascii?Q?TGeVMX0WHS9IKXBtbYdqVCk6whSVDnYPaxKHf4glUhqVeu3eNwQwprzH1HVv?=
 =?us-ascii?Q?8iGaT+jVm0Mn5NwdPLcYVX/6/+mZgMW+z9OR71229fvG2KylpyUf7Vfy/ZGc?=
 =?us-ascii?Q?Ds86QI7ZNRzGexLYP6b0R981GhJCdRmbSPTnv6hp3Wu8YxbMpWdh86/IC/V+?=
 =?us-ascii?Q?nm5pf4NcXz1ECpp8E4IG6FgRcxjgc1TguW+HBXSuGcYjhfEWP/mvA7jHrx4h?=
 =?us-ascii?Q?lCD79e530hM6kloM3IurcaXgbbPb9zdXD+m8fjDEyeb6xOqJO64yZc/SPDr7?=
 =?us-ascii?Q?Kz+8NdNfHHO73R4T1Fyl5gQfPIRoyMh04m+Rt3p7zHOAWl2sHXZzO7stmV1W?=
 =?us-ascii?Q?XajbfKfG3GvVUegguNIX8v4SR8Cv0bKcr/srrX8IHV7oN1NUongMzhyPSTxH?=
 =?us-ascii?Q?Ggs62PVKjTfirt4mGUUv+MMz5GJdpPcrsnR4oU/LIrdcf3LQh3hWTEW9jozY?=
 =?us-ascii?Q?oj2nZ7/4p2oZIrgoavQLyntpIIrqbUukYRrTBeKbVfm1P7XnbGztMhazwGHU?=
 =?us-ascii?Q?f570Ijuj9QBP2+pGu0Ss9xUEHFNV/+6KjE3uvidnMyB3TNSO4GCcpFohwCPp?=
 =?us-ascii?Q?brBX0ZGwng+nDDXyvkvlzse5bGqdmLN9qVvmcq8qW9JvakosBQeYPQpHx89j?=
 =?us-ascii?Q?jN31QXVxCs6tldv8T5NKqEtyVq4sot7lKMrHIgiIaG7PRCIOaW3BdhXuqqpq?=
 =?us-ascii?Q?MynLUrAjWQDs7+MTL1tnq1eGnlZuPWIhTkdmLr3rPA8zSgb1Rn+aTr7OeWVN?=
 =?us-ascii?Q?QJq/32QOmn74fjaxEhVO6IFsbHBe1L092qHEJA2PDCnhd7+ex8T87DLQhZFb?=
 =?us-ascii?Q?pRR3EGhCKm82Ad5tErZz5apbYfZAsttn6MdR/26OAK6nDAroy92V4flnuK3h?=
 =?us-ascii?Q?Myx0EfgSLzeNnpi07Wdo5ebx2DPrwCcHjyObO7hZ7wAh0uBA+Jp7xievBjbg?=
 =?us-ascii?Q?WB2CbFdaYwQ/FLV8rD4489MNkyBcnI+orNes35HEjc2EyB7jdwUvUQm7bfs8?=
 =?us-ascii?Q?WBTAnl5lNbG86BsGc6m5rnHX++LYzyXw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/pB7HqoyJWwNUwGeGX5/yJtrnoY7K7S9EyV3DovLE/aDoyeqjJpeZ69iXm7n?=
 =?us-ascii?Q?UJG4kdhV56IvalCKF4IctRXq6yP7XauKoDM2Lr+R4ucnCzlGUWhPcK/u1Jsx?=
 =?us-ascii?Q?pQa9TE8CL9a2MKe+/BAF+PAy22botENb5+czMfZh+GG0zr0UvVRVsTNviNcL?=
 =?us-ascii?Q?U+dX5QB0eaZHZZ/Zv2hcI7CSb8MQt4Vq0cp3n1bnlFv7jTXSi2+RLcVYU30t?=
 =?us-ascii?Q?/ySW6xs+7Eh94IvSEL03a8Qiclly6+xe5bFMB4m455F2NfqdXzlCeeAJja4U?=
 =?us-ascii?Q?pba4GLWsAvMdEAMEm0R7qmzuCytgLVM+JavlvBQGPoy72uXcrncZDgvenPvu?=
 =?us-ascii?Q?DV4+ZwDSTMzoGwYpG4kmUC4yJ4qrGVr9HTM9mOjaxZh4PVNCUenyojClrFgn?=
 =?us-ascii?Q?A8DjqlSieeh9hA/AFlDG0Tt1z1butXn1z7KaVaU77nbTLowL4Pnxl7jv8mH+?=
 =?us-ascii?Q?CAsYWSZGvWr8iRaav1/J7i5NLbCOlYccnaK8kXbmnPvyUMiO0pVvFFRivKjD?=
 =?us-ascii?Q?m5EeYQoTDLTkOXYpjhUoV/xksZyrmPY1R1oxBiQRcqur974oj0q/BJl/Ev0N?=
 =?us-ascii?Q?0RZdsIXYpshJTLuz2lAtGLGGtehrzTm1KnMRtKhCz9SDaRdAC2jQAbj4xk/9?=
 =?us-ascii?Q?G3LWpg6wk37rKGYKCZc90OmUTnh5t8r8iJ9mRaQhpYthMxFy8GrUiPqgTsmu?=
 =?us-ascii?Q?VoLyUqQcKnJTrtSthj744GDg6xECng21CfmQfyTO2JCuRI8yrgtaBs21NpCj?=
 =?us-ascii?Q?7x91scTTOPEMaUWYPTyp85SkG8EdhuILvU6I4L0+lzcBSVBB5kJJL9czE2Gm?=
 =?us-ascii?Q?vYDlnz4BwKrZi5DzYvLcLl+spymkH6NrqA3PqA1MBctlqUdhGStuPgr7W+B3?=
 =?us-ascii?Q?0g3npc/530zlyUb27TSQbvIpEy1FeagAky8i/DAzHICoOO2tZLF0C5RdNGxm?=
 =?us-ascii?Q?B7D1zefXKK6v5SkTpNiuL3kcEZ9CYN9DyhuaNghsys0BxKSmWd+oTNioqi6U?=
 =?us-ascii?Q?nN0abVSR6ldVeNBer+O2Hnw7tpEM7YQu2xI/qORPyJFfINycRj7hOVmCrLcd?=
 =?us-ascii?Q?wAWrzPoBWyYKdiv18RNSZfgK3uQKhI36E8tqdKI0fZPZ47KwfQEIcI7Na0EI?=
 =?us-ascii?Q?W7CQzydWpCPLxx7FoUbBeTtGeihh6ubYfi90rrJqdu2EOX4jkEsXb9uG1D7T?=
 =?us-ascii?Q?P7NhclhtJAbe3M81blahUZUmFXTw8y4m8/IifYr/QNxzyQ9IRRlDJTRT8fIX?=
 =?us-ascii?Q?sSlXaEXEmSlx9cuuwMuMGiRwyOYBPhlE9dzGCwomrY1HJPZZ7AQLLAwZa04K?=
 =?us-ascii?Q?AR/1php7avtlbn5jP8gs31ZlNh+WlIeUPDS10XePCRdaJeI7wKHU6htJtXNe?=
 =?us-ascii?Q?mhZvCbipR7A3iNzOT0ZLoA3QOfjokJMZmGuqrAMLDh/yG2bkC7t/cOEwKEZN?=
 =?us-ascii?Q?3CJvD7+5U7NW9pGzaa/yl/MzD6kHZWeCigT7fsfXnfORtCelbFto/H+g5Wam?=
 =?us-ascii?Q?cJxoG9wrh4Tq2K47qylZykNQb2Tlk1YTbi0bANIJgb1eOYZOy5/q9QdnUF9O?=
 =?us-ascii?Q?1cUC5xt5K2ubLelmsIA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 891512b3-ce0d-4f08-9456-08de26afed33
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 14:36:57.5999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7hBqIHk1OSM9ZaK9rd3DK5XaGwx+RmSsbZQ31TN9fuxM1iMSef69jzEJaPGYlOOw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9385

On Fri, Nov 07, 2025 at 01:59:00PM -0600, Tom Lendacky wrote:
> On 11/7/25 12:32, Jason Gunthorpe wrote:
> > On Fri, Nov 07, 2025 at 11:56:51AM -0600, Tom Lendacky wrote:
> > 
> >> When you are on bare-metal, or in the hypervisor, System Memory Encryption
> >> (SME) deals with the encryption bit set in the page table entries
> >> (including the nested page table entries for guests). 
> > 
> > So "decrypted" means something about AMD's unique memory encryption
> > scheme on bare metal but in a CC guest it is a cross arch 'shared with
> > hypervisor' flag?
> 
> Note, that if the encryption bit is not set in the guest, then the host
> encryption key is used if the underlying NPT leaf entry has the encryption
> bit set. In that case, both the host and guest can read the memory, with
> the memory still being encrypted in physical memory.

Sure, so in the guest it is simple a 'shared with hypervisor' flag and
does not directly indicate if the memory controller did encryption or
not.

> > What about CXL memory? What about ZONE_DEVICE coherent memory? Do
> > these get the C bit set too?
> 
> When CXL memory is presented as system memory to the OS it does support
> the encryption bit. So when pages are allocated for the guest, the memory
> pages will be encrypted with the guest key.
> 
> Not sure what you mean by ZONE_DEVICE coherent memory. Is it presented to
> the system as system physical memory that the hypervisor can allocate as
> guest memory?

This is an option for CXL memory on CXL type 2 devices - ie GPU
memory. It is coherent but it is managed by a driver not by the core
OS as system memory.

> There was a patch series submitted a while back to allocate the IOMMU
> buffers in shared memory in order to support a (non-secure) vIOMMU in the
> guest in order to support >255 vCPUs, but that was rejected in favor of
> using kvm-msi-ext-dest-id.

Yes, but that was incomplete, it only did the data structures and only
really worked for interrupt remapping. It left the actual iommu
broken since we don't clear the C bit on swiotlb.
 
Jason
