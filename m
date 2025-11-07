Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011028.outbound.protection.outlook.com [52.101.52.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881082ECE91
	for <iommu@lists.linux.dev>; Fri,  7 Nov 2025 01:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762477351; cv=fail; b=GbyJCNdT3oi6fx/xMGXtcyBIfptZYiMqjXD7ljB5AtWFgGlnRwe5vWTSNweslKf0lAs7ZeGqlkCwPnG/Xz0KIUtnZlgYfi2xthNh4VnVcJjva9P0pfv2krHbLFcIKn1dmG6fykpDxKFfvPO+qLeIAG0IUdoYk2lTF9G0UgOC2/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762477351; c=relaxed/simple;
	bh=sW3llKjojLSHZFEErlWRZiF7PrMqB9+diLljQve2yTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jk36g9iH7lKbDhnCOYsrvTq6LswZm3pJiGcREL+t5EAkhXAuU73euN3XcBVjbjmu09xcThrIf2g4CKrJG/tk8N7ssZviAvPzznyTQXA1eoG7K1d5A0B5eGG8k1oMUQE1BrL/U6+wvsr1icgMXR4yd4LgvK+TIa5iw0DaUXIlwC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uqbX8qLn; arc=fail smtp.client-ip=52.101.52.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uqbX8qLn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DgX9zRT95SM4lFjjZ/rzi6CAQvEfCsVS7h+sxj6UfD04V3sRkz3Dk95M4WNJ5w492AEq4hdnsy/Y7SxV1b/jqoGo9p7JwXmE/zgdm19FX7Z8m64NSO80GYFK8MwXwWj78PRiMbxTxZxVX1X7MjwOr1FmmperyS1tObnu1RyieKHO/pYlrt0D+XMbezQ0WtT6vDefSB8arT2ZNx8FMRxFnA8WhIUpdzDq/qcWKbGB1gWiX40ihChjTNDKjkup4cbBqugzdNozjH0DhGrKaGjUBtzs7xYAOKThFZrJIRSrjrVFQFGecKQjpDaYn+AGD/LaRndHN8j7fbcHZ5eDCUMlPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+jHBGF4821NiOHW5jYi8jcQGE6v9Xl6qTWoYfFR1rCI=;
 b=IluvnbrtVXmxNqtHRpiXkbZ7Fe4nRp1kV2Hy6hmTFukPj6pXHvxdw/lJd/yircPFBlCsv4JlELfWHtxeSiaM17tLdSmuz1xmM0i4rXxwY8sWRzzMJPuVK5esA8VqSPZ9DXSGAVcF7LgTSaDgsbU9vR62Sujl3gmb5udeIWvifP9HiL/KKKXG1L6ynXEJnvP6z7JNOymmT0Y+Vwmoqms5y2ziQn7NAUUbR56FUL3KsKfUxUbxXadQ8KSxbphZm99tXPa/nfSEs7jaSomb5hnXDAD+gOquOnEnc+rPtO/qGurYfh1fxYm8MBcTgLWiskXS/OnWD4TwBLIaw8RyDKT6DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+jHBGF4821NiOHW5jYi8jcQGE6v9Xl6qTWoYfFR1rCI=;
 b=uqbX8qLnoLdxOGeohM8uNoD7dZEo7C7PX+NTssptgkq3EirhWABV5VoEBQ/pKJZxmFvHos8OQ0GpYumYOmL2Zm+R2uT3Dkh9Nn34taXdC2dCAD1OWgwCrcIVZww3OXR2eTc5Uahh6aDYnYukK/jITA6E4ixhgdPvbXsH98HYiKPLUl+ZCqZeOFclKA9JRgSMfmd+BWuzkReLeqI8TA3zMHe9X/8/4VJewahwVs8m4RQe25U2Nh18aXhIGFuGHcAcEpVFrL0FFSn5OKSbGzdJUsxk5FHmyMoN7vBehZNzGRAgkMXfNDPY2fC3r3abqnyA2cUMP9PbwMH+5bTJurAeNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by CY8PR12MB7537.namprd12.prod.outlook.com (2603:10b6:930:94::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 01:02:20 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9298.006; Fri, 7 Nov 2025
 01:02:20 +0000
Date: Thu, 6 Nov 2025 21:02:18 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Wei Wang <wei.w.wang@hotmail.com>
Cc: alex@shazbot.org, suravee.suthikulpanit@amd.com,
	thomas.lendacky@amd.com, joro@8bytes.org, kevin.tian@intel.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH v2 1/2] iommu/amd: Add IOMMU_PROT_IE flag for memory
 encryption
Message-ID: <20251107010218.GC1708009@nvidia.com>
References: <SI2PR01MB439373CA7A023D8EC4C42040DCC7A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <SI2PR01MB439351F0B7E54513710BBD3DDCC7A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SI2PR01MB439351F0B7E54513710BBD3DDCC7A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
X-ClientProxiedBy: MN2PR13CA0011.namprd13.prod.outlook.com
 (2603:10b6:208:160::24) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|CY8PR12MB7537:EE_
X-MS-Office365-Filtering-Correlation-Id: 61313f9c-9a97-42b0-2164-08de1d994c93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SE1UOUd6RVpycUVDditVdk9IWXdRdVk1R1R6Ukd1bVMvQmc1N0JnZTdvWFdO?=
 =?utf-8?B?a3doRzluOWYvL1VrK3N1LzBEN3c0YUVCUXVIOTVDZlJSQ3JBSVN1MU5KVVJP?=
 =?utf-8?B?ZkVUNUpzQ2xwa0krWUNYcGJEbUtVL2RmdWFlYzc1YXlQQzBrK2NaSkZsMlFq?=
 =?utf-8?B?WUkybk5sTzJ2WUxObGVGNlY0SHo5VWViYzdFYVJJaWFyTjhyaFQvTnJsWmg3?=
 =?utf-8?B?aUxDVU1YczI2SnZhNVFOWmVia3VzNTdQejBOZnRINngrWXFGdGl6c0k1UlBM?=
 =?utf-8?B?NGpOdUp3dlJpVmFnN3lKejhHOXFWd2xpMXpCdWV4cVhlTTYvVEVZZUxkMHJY?=
 =?utf-8?B?eVVGcHlDaSs0cEVJdU52Q2xua0J4R3p1eldPWjRtWkhrU2lOSVQ3YmNqd00r?=
 =?utf-8?B?RG81a3IrZjRpWld1aGVncFFMcnowWlRxWnltR09YOEZHT21tV29PZTJwb0Ra?=
 =?utf-8?B?d1pBZVZETkJXTzRJWkhSMHJ4UEZJMkl2RkQrUmt6T0psdENVY01udENZTkFm?=
 =?utf-8?B?Q2ZnR2cxaW9qa3hnWlpocDdoK0RwbmJQdDRTL3ZpOEZEOFp3a3oxZ0VPNldu?=
 =?utf-8?B?K0JNa2VnUWJDNHRMb3hMdmd2cDRRZmV0RUpnQ3NNclJLbDg4ZnJidjdXN2JU?=
 =?utf-8?B?RUFBSCtmYlZVeDdIanRRZkc0RmdLUTN6NEQxT2JZRDRIRG0yMmdHQlRkVWZz?=
 =?utf-8?B?bUJQbW1XRlo1eDMwSFpDbGVmdDhEV2VLZkpibGFtUEc3WGdkQXVWWnBkczFp?=
 =?utf-8?B?MUlNTkwyYUhndEJSbklLWEM3bThOSXlOTmpFS1RmNkxSMm9tOS9pZDJGaEEy?=
 =?utf-8?B?enZsRUZzaDNwUlhvTi9HT3BqcDVxeUhKZytNT0h3OUViR1RjczR1dlNaOGpm?=
 =?utf-8?B?L05zUkJYbFFyS1J3L2lHNHk2SFRMUDlWNlBPZDF5bElJQXM3SGU5QmNkM05E?=
 =?utf-8?B?bVFxKzUydkRLQm5nY21qSHhZaHZPMmRpaTQrODFlblUwVWJxU1YrdEUzcTUr?=
 =?utf-8?B?LzBjOXkxQ1VuRE5hcGsrRVFsa29aak94UXhFUldlOXBqS1FXUEo1MUJSTlNS?=
 =?utf-8?B?TzU3UnBnTkprSXdxdDFUdktvcWF3NDZjYWtHZWZ2K0dHbmhlam42U3dBRTQ2?=
 =?utf-8?B?SUJBWlhaVWNBQjhubldUL29SdXhHcEZpMlArQTg5Wlhuc2VBR01tcjNiU0pG?=
 =?utf-8?B?WnRvTFIzRi9kZWdrdVNaUDhCSnlWeXV3c0lRMm5zVi9Ecy92TXI2dHdWVFB0?=
 =?utf-8?B?SE1qYzVrUGdOL09iQm5BeTMwVmRiQkVhb1pKTFlLOWxUVmR5SjRpbGpTSXpO?=
 =?utf-8?B?NitINW1qVTBMZ24zT0JCOHBqZzVER2NwbUcyMGJlTjY1dVdVREUvVFY2NmNQ?=
 =?utf-8?B?bzRJM0ttMTBXUWY1SURhT1R2d3hnNkFlNlRwNjNuaWZiRjF2Yk5ZZ2hCQnQx?=
 =?utf-8?B?Vi9lNjNheXNrTW9XWE9sUVhIT2lnNm9ieWRsQ0k1ajVJSThIcHhEQ1JHWG10?=
 =?utf-8?B?dHBuVHFWdVRNZHlOOXE4OEQ2ZGVIYWFha2NzTU8wUkV4MlIzYWdGcVZzZ2Ni?=
 =?utf-8?B?U01QVENVWk1pYkVERnYxRVVCQ0w1MCtaeEcyUFU3Y0FnL0JiVjV3OFRtaFpw?=
 =?utf-8?B?L1JkV1hPZnBxeThidUU5Z09DZCtuUXZBODIxblhzcnBmek9rZmlObld6WnRD?=
 =?utf-8?B?M0VwSCtNQlROdWtFUFdZb3hodks5RDA2Rm40Q0dTVlNTc1QzbmRlaDRHTWow?=
 =?utf-8?B?bFJTMkVLZXhxc0hyL0ZxOEVTbkp4UTZJWGVRUUNFS0gvcGplTXZHSnZlV2Ry?=
 =?utf-8?B?aklIVUxoVXc1QnpsajRhRVRVZjR4NXFWWmkwalkzcWpNazR6b25UMVJEVk5R?=
 =?utf-8?B?U081eE5qdDgzb1lTanlkam9SZFBsclIzSkt5ekFCRkFIWldJcW1oSElMZDlC?=
 =?utf-8?Q?GpU8soW6UffyMcrFhuOv5J/bvU0d6NUT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K3RDa0gxZmFJOSsrSGQwZTJBZFVlbnQzWVllSjliVXlUWEtKZHZRY29XYnlF?=
 =?utf-8?B?elZtMnU3OEwwbDF4N3JhMGhtZnVOYjZlbnZObklJbHJTOS9JQTAvN1JKUEU1?=
 =?utf-8?B?VnVsTVZJY0NaMUd5OG5hTUZDQnJwcjd1OW5GRnNLaCtUUitjTXFWUVhieE9i?=
 =?utf-8?B?ejc3RndzL01hd2hxOVhCWXB4ZzQvS0llYUFLUVVVbjQzdU1zb1FqTFRlczVS?=
 =?utf-8?B?Z3RaZ2RzWlNNcGVlbEFLaE05c2dPWVlET2h0S28zMHE2cVNsR2pwU0Zlb3No?=
 =?utf-8?B?dThYUzRBT0Rqcm1VdnFBMHR2dWJ3ejhUL0NIZ2Y4VWVJaXI2dFNtejVUTVNz?=
 =?utf-8?B?bm1iNlo0c1Q0YTU1bVJ0Q2FqUkRYb1c0ZjFwK1JoU0NhUzhBNnk2Vy8xVGln?=
 =?utf-8?B?ejZCN3VEc2UvZ0VQeXhIQWpMV3hTZ2NiT2lKbGJ1SlAzU0lML09nUW0xd3h4?=
 =?utf-8?B?YXdZcTdNeWJSSnIzSUdibDlFdmRXek1hKzhhZFYrVlY5NC84V3p6OGlRb08y?=
 =?utf-8?B?d21yUnczWm85WGJkYjVMaXd0NUJtYnR1QzJyVE56ZGVyK0U5UWJsQUJDUFJ0?=
 =?utf-8?B?b21CT0hieEJ4dXNYL0p5M3JDVHFSemtQYUFyQ0lSRTZ1ajRoYmg5VG9JQlJO?=
 =?utf-8?B?eUZQN3AySEtiaWZ4V2JMekpBenVhckR1cmwvZHVpR1Z2cHJGNGNCQWgvZXVj?=
 =?utf-8?B?dFErRE8yOXZYRnhtdDk3cTRmMkFxbHc2eTgySGxHeGp5ZlRRV1FuSWJYTmVo?=
 =?utf-8?B?b1E2UDFvclRDRTNwcDRSQitFd1pmeEQ4MkFLOEdzTTJJczZZdTlnSkhlRXBT?=
 =?utf-8?B?dS8zWm9HNGFnRG5uQk1vc0hpSHZlejgyb0lBQXBCdjVmMWlKNkgwRkFtOHJW?=
 =?utf-8?B?ZnpLTWR3bERTdnF5Mk1vZmhpL01FNWpBbWl1VURDY1lKZmNhZjlYOGJsaCtr?=
 =?utf-8?B?NTR5SmI0SGRjY0kyYm9WNURBZXlWd3dRRWpLYWdWUDNmR0trM1hIWWpqbU50?=
 =?utf-8?B?Q0NjaEptMzIvOFdIZkhrUGwvUndZREVVMFA5NHBqUDlPakR6d2ZRSyszMUF3?=
 =?utf-8?B?QlQ5SnVrYXVHRE5vTTRLS00rWnN1bFVKdnUzUk9VLzU4WE9FRG5oUnBOWWNn?=
 =?utf-8?B?Q2RmVmx0MlFoeW85U3VsV0hrWGtmeWtwaFlwUjlNUjhSYk1sOTJzUjR2MHkr?=
 =?utf-8?B?WmRMZ09rY21Kcml0V3phak9mY1lTVzJ4S1dkN240amRGaWptY1dVV0IwZHcv?=
 =?utf-8?B?MmZsQ2JCN2J5eks1NElpYndaZkVKbThzSXUrMERScFVmTjQ0M0FWM0dpK2lh?=
 =?utf-8?B?UEFpS0QvZmk5NTFtY2REVmJnbVpaVFM3bm5KUkR0NDBvUVQ5T0VCK0hCS3JD?=
 =?utf-8?B?dHoyRFd4RFViNDZNRmNFT2IvNW9CVC80RmFKaXdEODJXQXBpUFhKeU8xS0VH?=
 =?utf-8?B?eThKM3pJOG5UMGhTNHA1VEZ1NkUrVDRjdjQvQnZMdGhTTGxQNFFIOG01R3hT?=
 =?utf-8?B?YVNjUlFJYlZZODhReVp1V2YvdVNnU3VNekN5cVpKdjg5Y3pPc2x4d1VKcVls?=
 =?utf-8?B?aEZHY0JpR1k0TCt5cE02Tk5jU1BZY21kb3AxME1abU9UL1F0MG9oVzdXRHFR?=
 =?utf-8?B?NlVmODllYytHOE5wZWtScGpvL1lGWTZSYnViSFRiTERXMm1mSVprWWZyMnVp?=
 =?utf-8?B?WHhFWitmMmVvdnpoamZmQjVIZXVtdzNFcFZkZUxtY3lOb1hBcE9uallDdThy?=
 =?utf-8?B?TDY1R1JTalJLVzVvWW9saTNyZUVGVFRHOWYyNDJCOUZaenlOeDh5aHltQWtY?=
 =?utf-8?B?N1A2UGdTUm96M3dyV0hDMm9mdk50ZmlWWGVQZVdKRGNILy81a2NRcDdWNkI1?=
 =?utf-8?B?L2FWSmtBV05xbkQrSFlxWGJ0dURKbzh5dmlwVlZ6UG9lRjBaUzF3K0dkQmNZ?=
 =?utf-8?B?dWkvdU9FUjkrd0gyZG9MSWhoZ2hpS2pETnJoWGRybWRxY08xemgzMzdZTTBp?=
 =?utf-8?B?WmVmMzNzeVFtd1pLV25QVElnTFNiTjdQMFNENUQ4eDNoMlZoOXpONWVYbjZL?=
 =?utf-8?B?Y2V6elp3cHV3LzROQW5Hdm8zTjBLZ1oxQWxZK2ZQT2NiYVNoNEc4TUhHTXd0?=
 =?utf-8?Q?LIe4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61313f9c-9a97-42b0-2164-08de1d994c93
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 01:02:20.0644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6AkvB6ok9Emm94fK/jy7PtPDY1PX7TPKbPIXx+MtQR88/rlcioojjDVW5lDNyzsk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7537

On Mon, Nov 03, 2025 at 10:00:33PM +0800, Wei Wang wrote:
> Introduce the IOMMU_PROT_IE flag to allow callers of iommu_v1_map_pages()
> to explicitly request memory encryption for specific mappings.
> 
> With SME enabled, the C-bit (encryption bit) in IOMMU page table entries
> is now set only when IOMMU_PROT_IE is specified. This provides
> fine-grained control over which IOVAs are encrypted through the IOMMU
> page tables.
> 
> Current PCIe devices and switches do not interpret the C-bit, so applying
> it to MMIO mappings would break PCIe peer‑to‑peer communication. Update
> the implementation to restrict C-bit usage to non‑MMIO backed IOVAs.
> 
> Fixes: 2543a786aa25 ("iommu/amd: Allow the AMD IOMMU to work with memory encryption")
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>
> ---
>  drivers/iommu/amd/amd_iommu_types.h | 3 ++-
>  drivers/iommu/amd/io_pgtable.c      | 7 +++++--
>  drivers/iommu/amd/iommu.c           | 2 ++
>  3 files changed, 9 insertions(+), 3 deletions(-)

Since Joerg took the iommupt patches this will need to be rebased on
his tree, I think it will be simpler..

Jason
