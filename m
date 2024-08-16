Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C38156F34
	for <iommu@lists.linux.dev>; Fri, 16 Aug 2024 12:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723810587; cv=fail; b=hIYPXxrsQT8eqwy4CKCDC92MIrxIszaKweg9LeL++zNvIdjDY7qJ1Xr0/jflg5RMOW/FOiiG11sJVbQFq6gctHyCSu521+ZVglYjGC5PC2QxCsLOA629lpmFnijBV2hwuJnxHBO2+Cunh0/VMJkYoypLLpA6zlrfczOfk8lCOTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723810587; c=relaxed/simple;
	bh=iPUZ8mAHnaZlqsEATSdSpbnDaWMSdcSitAXcNCVdvWA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fEmru+aqHgIds6TdXCLq85VoBG43IyZUiHh88oZ3Zbm6y5xxQWjw/86nYrMPqlVqt0/1jsncoGkAH1vTaG2gMF5mxaqlp8pgBEQnUG7AEfxzjDUv72E4xVKAL9w0IZvMUJQtROk56H4XAlFx+9YjuJ+BiClOJzpjGTL3ANhzy1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=B5x+JGiL; arc=fail smtp.client-ip=40.107.92.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="B5x+JGiL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mbvh69GaGZwaHZYWjQIdlXK8EJamwVqSiV1jAevhCCf13KHCYiYv8VGKU9bI5YArtpIel5dmdbFxX2AkN1mm9vH/ymzKRYEFLJuPMI6FDLK4AiJLyQ+AzMew8HNcNfyt6szdKhpv9WWRkWDPrbqrCrM9xF7hg6EYbGdkwTfirjREyFN//PK2hTjnnESiy8bZPLOayOzMFykL64Yum+12BnhsMkNq0NRZLAs+ya7XIJLq56siwEb1tElROsDupdV4zdaazCJncIeQ3sWW+ykjzLxVTjk6quCg2v/awXKxlJ5cg3cho7SO1eYw5U9CEq3ngg0ynVnsYmEb+ZsD1tahGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iPUZ8mAHnaZlqsEATSdSpbnDaWMSdcSitAXcNCVdvWA=;
 b=qNsuFaiuRQwCpzw6ag1QsKFKb4eKJYJSS4g5bL6acHIJwasJV3LBT6Eh/EFKDHOh59yyNqltxAdeTOBb9uRrzvRw/DCGwOgZpJ+obHctf57wpuACHqwk2bZY+oigaNrjAZd9isBFJX7hMJBwKhkrhbWDQOOFATMNpBe9UVwUBYSzq0HH31Wi8UrMVRDPRUv+Bft4A//AsxwaCEN5RDEQAp+Gy/WR9WffLx6LV1JfSCfGk0ZcbTsJCXMhXRcEO5D1EFxkg5xUYgitPh+elHvwBjEMtJn2e00f34neygByWH2fdOZDRuybNI1iMPeqvhbP3fwt6hkGbvbMthC/4WOdEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iPUZ8mAHnaZlqsEATSdSpbnDaWMSdcSitAXcNCVdvWA=;
 b=B5x+JGiLD4m28F3BLvMltjWoAuZrDkuAfm0s8z6OtqIVQFxjKgdohQygHyWvhaLliXeEvB2s38zB++ttjxw9j1YmvLlZ1Nkkfy/1poZk9bBt1/r/bf2Aj0T2mBKihK59T1VXps6/g9uKE/zFladxz+3guBZdkDRiPYBj4BmB5xU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 PH8PR12MB7158.namprd12.prod.outlook.com (2603:10b6:510:22a::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.19; Fri, 16 Aug 2024 12:16:22 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.7875.016; Fri, 16 Aug 2024
 12:16:22 +0000
Message-ID: <6650ce02-ac85-4cb6-941c-cc7e8b6effc4@amd.com>
Date: Fri, 16 Aug 2024 17:46:13 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] iommu/vt-d: Move PCI PASID enablement to probe path
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
 Yi Liu <yi.l.liu@intel.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240816104945.97160-1-baolu.lu@linux.intel.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20240816104945.97160-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0P287CA0001.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::6) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|PH8PR12MB7158:EE_
X-MS-Office365-Filtering-Correlation-Id: 72ee42df-f93a-4b2a-c841-08dcbded3d94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VmFQOThNaG1VaTlJV05iK0FsQ0RGSytxaGUvaVVDN3NrWmRlOGc0ejB1SmZD?=
 =?utf-8?B?U0tXcHdDeGNWQW5paU44NlkwY0hBUTJvakNmRUZCczc3ZjZiVExVcDlkWlRz?=
 =?utf-8?B?bm96a0ZvaXQ2M2I0ZFpqWUNhangyclZOcFUxME1yL0tYM2FhYTBPbXppSzd2?=
 =?utf-8?B?Yy9XbWhnWkZPMzRzTTcrUjRPK0Z3dXRFVG9xNElXZVh0T0gxQXFUejN1NS85?=
 =?utf-8?B?MGVwT1Z6bHhlaFpWdHplQmlFOXZjd2VrWklIdURadlZMTDdXd0g4ZEdtQnNW?=
 =?utf-8?B?Nnp2SG56OTg5dGlWZXR0TXFXU1dnYnBMM0tXVWgxTG1zbld1L1BWOE81d0FB?=
 =?utf-8?B?OEdTOW8vYUtWQ21UYlhNUHFXRmFObTN1RzJMeVNZbm1RY0dFa1RnMmVFakow?=
 =?utf-8?B?UnFCVFhPVDBzbUpxWjFSOXJNUndpMUVxOFUwSXMyeUtoU0tHRkt4QzRTL1kr?=
 =?utf-8?B?N05kb04yWHlDc3FwcE9rako2ZGx3VzV3NitjVFppbTdybVkxZVV4OTZkMm1v?=
 =?utf-8?B?cWs0V3pYVTBjcHlObmtDTm01aGVhbWxSUHBMUXRjUVErOWpuYkhXYndzUEor?=
 =?utf-8?B?b0VyWm95aExVcGtjZXduWG1PS1ZaNW9keWt6UEdlUTA1c3U1eVlyQ3RrbnZG?=
 =?utf-8?B?RS9pVmRaZFNscG5DdS9NRVpCaVJLdk5zTW5seEUrRFJsbzQ1RVkzbEZUNjdN?=
 =?utf-8?B?WnZoUld4WWlINTV6TTc2TnVXRjB6ZG1QMHBYeTgvQXRnZ0lMclM3Qjd2MWtm?=
 =?utf-8?B?Z25DUDd6ZEhTanB0MU1EQUZKc0FHYUc4bTh4ek40bjRpckF5cVBEYmc4alo0?=
 =?utf-8?B?OUdpdnYva08yTGx3eVdwTzBkb3M5ZDFsaXNuWkJBZmZUOFI0U2xEZFM1UWQy?=
 =?utf-8?B?SDlLd3B2UzhXbGJ1VExnTFBFKzJ3SGJxK3cxcTVtektnelZsS3JoQ3ZFWnZo?=
 =?utf-8?B?djBieWVjd2ZaTjRMSjEwenEvRS9uc25zcXdxeGtPckxoenFTU0xnR3ROZWM2?=
 =?utf-8?B?M2U1UC9maWlXaXhUbFE4ZEdBcUtBWE9Tc0RzMlE2NndFQzJsME1oSWRlM0Z2?=
 =?utf-8?B?VW1IMVh2bUE3b3JmMmd3c0s0NlZaVzIrWG5BY3pHZFp5WTlJeWs3WUFpZFlq?=
 =?utf-8?B?bS9IaUlMdFVmeFdFRi91WmU0VnZDaTdEalhpTHZpRVhLeXNVbGdPOGl6UUxJ?=
 =?utf-8?B?U1lsZ0VTR1BUblJHN0Ewd3V4ZTQveVVibXNycEh6alBhbnFSR1g5TEU2MmNt?=
 =?utf-8?B?L0xzN1RpakJpOUo3NTMvZHloM1ZiZkg3cUJ4b05pWUxDN3lkemNWaG1NUlg4?=
 =?utf-8?B?b1JDQU1wajdoUW9yUVlaSXRLdGx2K0VaSTJaYlJDWTExTTRuOFppbDY2YjBx?=
 =?utf-8?B?Q1dvL0VlUFVjZVRGVC9XWnEvNEdSeWhyODRDWnlWY0FRL0trRm8yV0x2dDRM?=
 =?utf-8?B?eDRlUWpzYzlGSHF6cTBuN3I5TGNwK3pDZ21GSk5uQXFOVUM4WHJTeFAyOEJH?=
 =?utf-8?B?L2hDd1hYQ1M3Z1ZZSFpjK3l3Sm5zajRudkQ0TWk3NWsxN0IyRFpyWE5uNmZx?=
 =?utf-8?B?cnFQYUxIaTgxVW0vRXNIYzZxekZpWGQ4TGJ5dzBwaHBvWEhqNEowd2dJMWoz?=
 =?utf-8?B?RUUwTzRtYWxOc2FCL0VsenlOMkpFWVcxMUl0dXdLdndyVXh0dmViSjdhc0hZ?=
 =?utf-8?B?eFMxRDdOUm9qV2YzSFRaS0tGZGNFMVNvcTBpRUpjRmpUancwcXN4WERPYkU2?=
 =?utf-8?B?eHcxNVR1Z09sVTJXNi8vVmx5YjBzM01Zbnlpd1VzbTFmYWdVRVFSKzBmNE9v?=
 =?utf-8?B?Z2lKZ3BlR3hZb2xEYlJPQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M1ZDMjFsVm1SNVBnVU5oQVBZWlpTV0M3QWtHMGhpZDZhYi9KWEtoclo4R05s?=
 =?utf-8?B?T3lUZEZ6YnltelgxZ2J2MDRRNFF4aUYvaHMwUmxOT0FZRS9wajR6WG9rclZI?=
 =?utf-8?B?MFh1bmd5T0pCSkZZYTdST1laZ0dIdHFqUWVGbDVLeDMxWjNtTFhTNGVXL2Nh?=
 =?utf-8?B?NzhlVWNoMm9KeHVEOUJTZHhKdHpNUUE0NjBCZEdCRWRKZ2Q4UWljOXM1akFC?=
 =?utf-8?B?RnFjbUJ3YS9CK00yU280RTUxc0U4Q0VIUlBmbWpUaEg4RmRNNk9OZElCZ2hT?=
 =?utf-8?B?a2hoWGlUbkNIQXFZODhFME1WaVVNS2VSTnN3Z0o1ZkQ4OXROL1JUMmtqV09k?=
 =?utf-8?B?UTVKM2h0V3h6L3IrR2YwUXAwM3kwRjBCbVVWQjNJanBvZ2ZpaU9xbnNvY1ZP?=
 =?utf-8?B?S2k1eWcvY2dRZ0ExRzZSaEF0RFpoWkNpdDVLYVh1bnk0UytoRUx5SmxlYTlV?=
 =?utf-8?B?VnR5WVplbzd5dHpuM1JnN2x3cXdyR1Z1VzRlM2Z5NnFWTUpBTWtOazcwTENN?=
 =?utf-8?B?ZlhzMHQrR3pkQ21zRXhGcFhYcVMxc1JPeWQ2cDFqeUxCZkZvRWYvUXh5NHdZ?=
 =?utf-8?B?bEtqa3UrYnRGeTFXMWxTSlZ4UG9VKzJPeStZQ2F3dkFTbndSSkFQTUdVQWI0?=
 =?utf-8?B?U0Z3ajhZTUFuRFJIRmNURlRGRjN4cExZbkd0UURybjlNbGZ5MVozRDJVSU81?=
 =?utf-8?B?am1vV2QxdENpdTJXZmsvbVViNnEzRDlCNVZESHB3VzVNekZiSnZYOHUveFR2?=
 =?utf-8?B?N01FR3ZVRHhUWUhpTXkzZ2ZBL0pINHYyVUEwOHpPMFZsUTg0UHlEOG9TMEdZ?=
 =?utf-8?B?VUhsRjBkTmttYkpJdXVETjhjZDRGYi9ZTStCMXI0TzM5b1Rmc2tzMnhPQnhq?=
 =?utf-8?B?bnhtYTdDaVVuOWI5YVcxVldLRUxtbk1SYjdCYk9FU1FyWlBIbE94anlVd0RP?=
 =?utf-8?B?RmtPWU1SQ00wbURCSFJCbWRVUGxId1JaSUcxNkdzU3kwOUFoZVVnVHplcHhz?=
 =?utf-8?B?SzNWa0FweHhlVzQ3VGNITnJYSVdsSnJRaFlVTmFLSURKVk1od1JVV1JHd0JU?=
 =?utf-8?B?aGJIVXo0YW90V2NURHBvNHZFRGZUTWdOTHpmVS90MTNuKzF2ZWdlMTJlcE55?=
 =?utf-8?B?NmhyMDAzQVhvcjNlUVJCcHhrT3N2Ym1VTzE2T2RDMjhZZ0k0TzVRalB6UlQv?=
 =?utf-8?B?VUhJakozQTNqNnhWaWw0YmpjcVRlSjZib0hyVTdBc05mQVROOU5KNzhIekhH?=
 =?utf-8?B?dGdDT2pHeGVCVHdjN3R4a3pSc2R1MGNWeU1BOFVpVllnSXFrOXZxbGlYTVZa?=
 =?utf-8?B?SkFkK1Rqc0RXTnhqdEpMZUI2ei9uRGp6VktZaGR4NnNhMm1KZDFkcnh4Sy9i?=
 =?utf-8?B?NGoxTlRJU3ZuUjJrR1M5aHZwc01adEV4TGxHWEZvbnlWUkZ4QWRGQm5WWEdZ?=
 =?utf-8?B?SDRsQ1ZDK1lJbW56YTRCbkxQSm00RUJ0cWJDcnVXejUyaVYyMnFxM0dpUk00?=
 =?utf-8?B?dDhyWHRNaGMvdUN5NFNZTitBYzNNNWdQOHVIMXl3aWFRUTVBZVRvZ2hJZDF6?=
 =?utf-8?B?a1VELzQ2a0VWSkJCdEU0Z2RyWUhyNVd1cytuNFk5QVNHRFErQ0ErcVFsbjJV?=
 =?utf-8?B?NEhrcFNhQnp0TUVDV080ZC96aXpNYitzTHZFcThDMUtiTjlLRnBoVkgrd1VR?=
 =?utf-8?B?cUpyTEZTbGNhS1hyRnI3M29OMzdmL3IrdTdXZ252WWI0d3FrM0FHVDh4elFX?=
 =?utf-8?B?TW5BYXM5WDQ3TGpyYk12Q295N3YxclFzZm1jcnhQR2xOR1VYZDdsOEZLYU9T?=
 =?utf-8?B?L1hGRnFtb0wyZmtJU2kxUHBVcElLZmxmNTVyQmZ4WWVac1JhelFSazVUdGJD?=
 =?utf-8?B?SkhCOXltbTdqdmxXNXhtTzhwdFdVRWV5d3ExVXpBcFNxcTdaUHlCVDlsK1U5?=
 =?utf-8?B?dmhKZmY4WEZXaXhHZlltOVJyNVZFa0lFbUJMdUhSL3JNYWZYYjExWi9OcW9s?=
 =?utf-8?B?cmJjbG1FdzFvMFVGUlNoRktPQk9pSkgyN3hNRkZnYXZEMXd3UnM5cWFXS0sr?=
 =?utf-8?B?UVRCVmlDNDFyWUI3Q3YwWWt5UzI4ZHNORi93aE9aa0xGcW9JaEtIOWlsYlBO?=
 =?utf-8?Q?1Ikp+R8wa2Xv95Bwwgb9LYlQm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72ee42df-f93a-4b2a-c841-08dcbded3d94
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 12:16:22.1564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vx275cSxfJ+dJEPHQzfhOd5/gK7dA0BmcEe7htyopda7Z7MBF85h6N/38aPE3ZydK1T8gi9/A1lf959MJ23cZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7158

Hi Lu,


On 8/16/2024 4:19 PM, Lu Baolu wrote:
> Currently, PCI PASID is enabled alongside PCI ATS when an iommu domain is
> attached to the device and disabled when the device transitions to block
> translation mode. This approach is inappropriate as PCI PASID is a device
> feature independent of the type of the attached domain.

Reading through other thread, I thought we want to enable both PASID and PRI in
device probe path. Did I miss something?

-Vasant


