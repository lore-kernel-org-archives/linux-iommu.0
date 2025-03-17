Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911CD235BF5
	for <iommu@lists.linux.dev>; Mon, 17 Mar 2025 11:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742210626; cv=fail; b=JypdO7oVjXtTYF2vDx9H8M7afLY9DXfbkCMi7js9CxcVbN5vP1bKs/P+kjw7/oo1rvcu5VriB1XsTkaY5/v39qWAb6uDUTvvfCrlzzy3BanmEiAnKa64Ynb/AFIhnZvUZW5n1ZPvwpRRID7ISLSqXWrQTp2irZPuvl3WaNtMxkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742210626; c=relaxed/simple;
	bh=v7QkpFA5DEuY+4PC5NkDvfupkHXw96YYkxypObG/EVI=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F8HIH3r7pheDCZ3CQXwtB35HsF9nDiPgsHVs1LND4lgltw62ek1gXy5iGTjWjGtJHiO90tn+4LLY5tErpGDp4baOZuvdjvQdwwv9s3zp2VEJrlwaj4J7ZNtorkJbxyh5JXJOOPM4nG3JAg47pO8CnBd4TObpv8ek0PogOi9WBy4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=y0aClC08; arc=fail smtp.client-ip=40.107.94.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="y0aClC08"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pL0oVd5sKjo2vTdksobmR0BPQ30ypgNQjrKsNDllKxbOJUlYHfLwuUwlap+omi1YS2ttsyaTbwMt9c34ToCnKYaNFbDi7N0gwq256vk8jhOGP7v9bZ9mKUR2f6cfX4bC0pBalj/IqNTHOPCmx1L1wffUm0UwzcihLqfmva3t5A9kL6xwjP7MKYopw3P3z/f/mgTOglBvfurRMECuzKreMLSHOTgmVWvkwygAQguSX/L3k48WUGhsPSpBsMInpsnp0IuFvGokI7vQeaCncxypSZ1GKOqRXckcQIbVAROHUrWNTPpk1Ie7USPZWcRDhfT9kE4Vtz6ujdzk9zbk0iEAsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ekWqGYqSwL3FAYrbL99baPVvPn2/xcAmnTJWorgMys=;
 b=BQuEtimhfQ8zgy+7pdS1NPo++1uLxYVLNeA+cOgKayFPtAERekmpWoWidTqWxdRaPYclCYNQB7XMGlP1/g17GCZKqsBKToWz5g+dvTXDEQuEm0E4kpYHRRbMiZhB9tgmp8c9cxNjmjqg4U0D9B7vnDc18ivkbgwyaGYOpy89qlKZPn64P1+kWsifenNiSIEIxAobWkQnQrKhwVLS28ERMuwqxaUTbyEai68TKoxEsWFbuYU3msV3cBtTyJh2EdBRbkpkxpI4ixCJGhy7o9vxDz2iJcjEScTvz0FRQHJgCp+XkgUX9IL7VKWMZXuC9GgttMtM0DwCLZLYPD6AdZ4hag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ekWqGYqSwL3FAYrbL99baPVvPn2/xcAmnTJWorgMys=;
 b=y0aClC08qLv8PQxwHdaoAqdIMVjhE53f0hwuZvcjylXlMpAo4k2UjL1lfEqqLZ+yw7lzGJ6O+wRLh+3wRa24xRoJBqs01+fXLDNLZriYARPFp3+RNSagGusgKchRg1yFHZclqquoSapDNaNl258e5bV65huJTMcee2ntvm5PU6U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5163.namprd12.prod.outlook.com (2603:10b6:408:11c::7)
 by CYYPR12MB8964.namprd12.prod.outlook.com (2603:10b6:930:bc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 11:23:41 +0000
Received: from BN9PR12MB5163.namprd12.prod.outlook.com
 ([fe80::61ca:6d43:a98d:3b7f]) by BN9PR12MB5163.namprd12.prod.outlook.com
 ([fe80::61ca:6d43:a98d:3b7f%6]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 11:23:40 +0000
Message-ID: <3c14597f-e5dd-4e43-bd4a-6f7a6d08afa7@amd.com>
Date: Mon, 17 Mar 2025 16:53:33 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/8] iommu/amd: Add debugfs support to dump IOMMU
 Capability registers
To: Vasant Hegde <vasant.hegde@amd.com>, joro@8bytes.org,
 suravee.suthikulpanit@amd.com, will@kernel.org, robin.murphy@arm.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev
References: <20250206060003.685-1-dheerajkumar.srivastava@amd.com>
 <20250206060003.685-4-dheerajkumar.srivastava@amd.com>
 <fbb7d901-25b6-49c7-abeb-4e76451c197f@amd.com>
Content-Language: en-US
From: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
In-Reply-To: <fbb7d901-25b6-49c7-abeb-4e76451c197f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0173.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::17) To BN9PR12MB5163.namprd12.prod.outlook.com
 (2603:10b6:408:11c::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5163:EE_|CYYPR12MB8964:EE_
X-MS-Office365-Filtering-Correlation-Id: 67ed1493-4150-4520-e663-08dd65462b52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V3F3SFgyN25VaWp1K3VDUmRtRlNZVXp2eWI2ZEJjbDRWZVpWMEpUcGplT0Vq?=
 =?utf-8?B?STJJMUxkdSs4YnVRcU5YQnVWL3czN3paaHN3VGZqUFNwN1lKWnBYelRDYVFs?=
 =?utf-8?B?dTdPSENhNGNvMUpqTlYwZ0Q0TjFIb2NLNkJUY2NvYzRNVTJyb3pYZEZLM3Y2?=
 =?utf-8?B?ZVpuZE93aWJ6UHNxUWt1TVZwYit3Z3hDTXNtMXZjdVA0N3BiR0Q3S0lTY1U2?=
 =?utf-8?B?WEQ5Q2NFakZPdnM5OU41R09mczRTWTNJMWl2MXd3SXRWdmJqRVFEeVBSUFFm?=
 =?utf-8?B?dVVEYWlnMFFwcUp0cHR1SmJhRGduWlYvQXJ3L2hERGFpcUdWNFZZYkhxT3N2?=
 =?utf-8?B?NUViQ01UNnVvb01JaHM3aXA5SEFrUW95V1NGdGRObHAvdk91NEk4Z2VnYnlK?=
 =?utf-8?B?Ujd2NEFCd0RoMmM4SjBtYXlib1UrNWM3QTRjS2dzWk5yc0ViK1VSdXFvOXl4?=
 =?utf-8?B?eGk3Ni9wL1BvS1ZMQ1NnNFZRaXZlMFRMZWlLYUw0VHowdmdCZnRKcDFCTWh3?=
 =?utf-8?B?YXNPSzByMktXRGN4UUhmUjk3QWpUUjduQU5PMVNyL0ZjaWx5ZnR4cmJKd1R0?=
 =?utf-8?B?eGFkeUkwQlFSM1NNb0RESlc5Q1BGTXQxRU9nRzJwTlNDdWNoSTFlWTI4bU5V?=
 =?utf-8?B?dUNvZUhQVlRJdXJzdEUvY0xDSCtOcVJ6UG40MEVBZ0hmVHZoWXljTHN6dnVL?=
 =?utf-8?B?eTA1WWlQdGRZV1NGQlJFWDBmaWRsK1EvdW5OREVONHc3NEZqS2tldXZwWVJN?=
 =?utf-8?B?SzdZdStYZ085cnhmZE9mL3Iza0ZidWg4UFEveEJINzlsU1JZY3EvVkhTRTgw?=
 =?utf-8?B?REIyY0tsbGhGN3FxT0ZmbnUzUDl6dlpjSUgvUjc5YThmSDRhZzg0VkRZME11?=
 =?utf-8?B?V3VhckpGVzZBbmMzNFpCWmMzNXJvVk44SE50T3hrNWRuaFFyTTdPalVnbms3?=
 =?utf-8?B?c1dYdzV1VnBzVDVEblJHSHFNUG9oK3RhQ1NyaDZrcUFZSDFrRm81Rjd3QVBj?=
 =?utf-8?B?UVBiMndjdTB1SlAreE01eXN1QjJoYURlbi92MDk5S3FmNGZEUFRYUVcrbTdV?=
 =?utf-8?B?Q2dDU1doZGpSMzlwbmFtaHEyc2tuc2JTdVVkMkY1WHFVVDdMWlViRXMyS0ll?=
 =?utf-8?B?YmtyTldRS3lIUG5jTmlKVnE4ZEdKTDEzZVhyQ2FSSm54dEpZZkxYZ2N1MW9x?=
 =?utf-8?B?TmVPY2NmN3Fvc0djRjUzcFBlbDhBSFJGbmJhREhkcEdYMlZRMTduSUZxam5k?=
 =?utf-8?B?M212VFh0bk1SZTFVUUdrclF1MXNvMjFVYW01WFlrM1ZFbnA5SGNRbFlvTEJa?=
 =?utf-8?B?SWpuTzJENjZ5b1dRc3hHNmpGNFZkcXh4YmJlVmJKSEdVZ25tbG5tcDJqSVlj?=
 =?utf-8?B?Z1I0Q0VNWkI3bTZhdHJNK3JlZXBCRVBYWEpVY3hzQ1Y3dnhZcFdWVjg4R3lC?=
 =?utf-8?B?QWg1USt5YWdlaUVUd1o2ZE5kMVc4N05ET0Y3WWVCWm90WHN2NXAvNC9xSEZj?=
 =?utf-8?B?N3BwallUb0orSXNta3d6Q21jSGxHUFhwVkplbDkrRFptYVZ3Sis2VVMzQmdC?=
 =?utf-8?B?UVlYMWJ1TUlKNHNhMjN3QzZXbVh5cFlXRzVoSVpIWGJ6UTZmY3BzSGlpSWpD?=
 =?utf-8?B?OWpTT0dLTW5UaXpiSVcvczVvUTRGdk9lTDlBZFhQbnpqK3l6a1Zwekxlcyt1?=
 =?utf-8?B?TUpNRkMvbGFteDdwbVJoZTA3VGF4MWhySzZYOGZDekx0aWJpL1Myb1p0Sm1i?=
 =?utf-8?B?c3NsM3ZML1lPNEIvR3VOWG1JNWozUTl0VGpSMGluWktjYThyZW9yYnhFN0Fx?=
 =?utf-8?B?cUFScDRKdVBPYitraGQ4Tm0yWW1KNTNrNy9QQlhlRnUwWXJVOXQ0cHhoLzN1?=
 =?utf-8?Q?JufkdT+zZvywa?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5163.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SklYcVVjZEppeUNrb3VHSVpWVXVUSWhJR091YUdPQUVCbm94aU1UNE9qdDh6?=
 =?utf-8?B?bWxoZVA1VFdldlNXZWc2Y0NraDFKWStNWTRsMUVrTnFlZnZ0SDJOYUthSVg2?=
 =?utf-8?B?NTdVUjZmaEFEUzdWdXRuMExNUjhEbTFTU3VLcXZaNHU1T2JHR3RRcHBjRFFt?=
 =?utf-8?B?Mko0VnQ0cFQzSTYrU2dVS2J0ZW04U090K2NyRFNXbWpmTmJnc3JYWWh5cGJu?=
 =?utf-8?B?RStpL3pvN0VPTHkxaHpaV3BNUFh0SmFhbTBrZ3JkNGVhTHRDZ1F1dDdvMkV5?=
 =?utf-8?B?TmxBS0lITXVHUThKek5HU2pkU3cvdW9MZFpucHY2Z2RDbzBMK0U0bnZSMnZB?=
 =?utf-8?B?bmppWTRncWhKRm5odFp0VERONHBzRTl1YjVNekp3RXdwbXlTTktjY2hmQTcw?=
 =?utf-8?B?NTAvemRUT3hrZFR5eC85Vmt1ZFlNcGQ5cWZRcWRFYzhwdG9GR0RaNm9zWVd6?=
 =?utf-8?B?VTF0N0R5cUdxaElrb2dJU081cFB3RjJSZTEyUElmWXR0R1hkKzROSDVpTFVq?=
 =?utf-8?B?TTh4K1lXa2FkS0NHaFZ3RCtPZ3VhRVVGRGVESG1QWmVnN2h3clhtMktDMTh1?=
 =?utf-8?B?dGNiV0thWkhzTzI5VFhaTm9EcG9HbjMwTDhuMWE1YzN1ZUkreTYreW1Lb29C?=
 =?utf-8?B?R0JaaU5xL3psSlJNRy95Q2R5c3R0RWdUYXNYc3IxcXR5WXdFQWNRc3MyOEEy?=
 =?utf-8?B?aTViQTFFVTRlNkFjZ0JMTFhzLzBUVUpUdkkvK3EwanlLcnluQzc5SitZU3ox?=
 =?utf-8?B?MHVyT3l6T1Bxazh2ZENLaXg0RHBKZnVCbVlGSTNFc2ZFUkpuUmk1RE5ISGpp?=
 =?utf-8?B?NTdqMnIvMHo2UTRFMTFYeHRja1lqUVZxS3JCK3FBelU4YVJSSHlqZ0NOK2xF?=
 =?utf-8?B?aHNGMHNRQmZxdGNIMzE0eStSSkNLU1pQOUdXTUpwaG4wQkVsUEVySnhDS0h3?=
 =?utf-8?B?QVVIbTdzYjROMlU3V1loSzBpbXBGQjFyd2dFKzBDRUk0c3hYUC9CZHVPZFRC?=
 =?utf-8?B?Wk9haTdUaEJjcHhJZ04vd0lGeFdzTis1R3dwclhaOTZjU3MvK1ZpWnZIU2hq?=
 =?utf-8?B?czVQNkY1TlNFcE5TUDJubUtRRmhCYXZQZTlBWDZSZHhzdCsrbW9QSFdUdjRU?=
 =?utf-8?B?aFNsMWlMenhaNUMxeS9qWnJxN0tBWUNRUERIMDBURDNKY1dibFJUVEZmR2o4?=
 =?utf-8?B?SGdKUWVCK2pLSU4yR1FCQ01EWU0zam1DeGExbnFheWhYSFQ0TDJ3azMvbDhm?=
 =?utf-8?B?NkhNVWNYc2xkL0M5ZFowUkFJZjVWZGRNZXJqQ0Y0c0ZWY21CeDdBc0ZkQ1Zz?=
 =?utf-8?B?aWhXN3l3U2FHc2hjYnFOM2c4Y0ZKeUpwcU1RcWpYRDNTdFoyTXJsZzlabFhH?=
 =?utf-8?B?SS9GMG1Wb0twVFhJMDNFckJyVDBSaG55bmZHS0dxa2NRMUtNcGw2QU0xRndC?=
 =?utf-8?B?WnNobWN1UTdyWFNBZ0hNWVlhVVpxMEs2bTA5d2F5T0MyZ2diUXgxdGRrR3ll?=
 =?utf-8?B?T3RVWUswV2xLQmFhNFBYODZ2cEFqTmlndWIwbm5SVDlHSEkrcnJuUk9wcUpU?=
 =?utf-8?B?VGtqNVBVWFIzb1Irc3lReFZ5QkVQQjhaODhDNVRCbXlnMFM0TkFuTmNQamVa?=
 =?utf-8?B?U2tETE51ZFA3WkZETWpyWHVVM1NMczhqN21wQ2xmR3BWRGxOOXp1dkJSWStv?=
 =?utf-8?B?TmhYdTBWNExLTnpUbjhvdXRqSTNIL29pUUJLakx2NHVwMDZQOUdoLzg3c0Z6?=
 =?utf-8?B?QXJ2SzMzUk5OTkZFY054RVJWUG1XcmFwUTZyUDV1UmFTWDdqN0FzU0JudU52?=
 =?utf-8?B?QTYzT1NQMUNqb09TdTJ0UFlmMzE5MEpPb3cyN09ORTVMWCtPVVdrYkJVTjlJ?=
 =?utf-8?B?Z0NlSnZkdEFTNVNTV0dkdEpGdlJGZVFoYzhqYVpkNld5S0gvMzRIZVB2cEhI?=
 =?utf-8?B?ZzliemJvVnA1YXcyY0JqamxBRHNYcmREQkxtN08zWXlRa1dld1FHSkh0Vm5D?=
 =?utf-8?B?Z3piZ2FvMGJpeXpxTlU5WUtmZVVmajVORTgrYTNHOUtaNzdKcnJ5eUZOdnRY?=
 =?utf-8?B?NC9lendobXQzWDZVUjVwM1pIamVZUTFUazl0NTdqWjl3ZjVIZlRJU0dYaUpo?=
 =?utf-8?Q?ktHwpoGcPR1YQEG/ITLTZbxHv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67ed1493-4150-4520-e663-08dd65462b52
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 11:23:40.8671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ib5LlAOxTBKpBzWTQvY3xLBDlPlxS+nT6cqZnri8qaYAEIenO7oTGLngtAw2R8OY4ERiw0b60pZbdHoI8NNCHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8964

Hi Vasant,

On 3/13/2025 4:02 PM, Vasant Hegde wrote:
> Dheeraj,
> 
> 
> On 2/6/2025 11:29 AM, Dheeraj Kumar Srivastava wrote:
>> IOMMU Capability registers defines capabilities of IOMMU and information
>> needed for initialising MMIO registers and device table. This is useful
>> to dump these registers for debugging IOMMU related issues.
>>
>> e.g.To get capability registers value for iommu<x>
>>    # echo "0x10" > /sys/kernel/debug/iommu/amd/iommu00/capability
>>    # cat /sys/kernel/debug/iommu/amd/iommu00/capability
>>
>> Signed-off-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
>> ---
>>   drivers/iommu/amd/debugfs.c | 47 +++++++++++++++++++++++++++++++++++++
>>   1 file changed, 47 insertions(+)
>>
>> diff --git a/drivers/iommu/amd/debugfs.c b/drivers/iommu/amd/debugfs.c
>> index b16b62ae7111..dc5fdc905754 100644
>> --- a/drivers/iommu/amd/debugfs.c
>> +++ b/drivers/iommu/amd/debugfs.c
>> @@ -18,6 +18,7 @@ static struct dentry *amd_iommu_debugfs;
>>   #define	OFS_IN_SZ	8
>>   
>>   static int mmio_offset = -1;
>> +static int cap_offset = -1;
>>   
>>   static ssize_t iommu_mmio_write(struct file *filp, const char __user *ubuf,
>>   				size_t cnt, loff_t *ppos)
>> @@ -58,6 +59,50 @@ static int iommu_mmio_show(struct seq_file *m, void *unused)
>>   }
>>   DEFINE_SHOW_STORE_ATTRIBUTE(iommu_mmio);
>>   
>> +static ssize_t iommu_capability_write(struct file *filp, const char __user *ubuf,
>> +				      size_t cnt, loff_t *ppos)
>> +{
>> +	int ret;
>> +
>> +	if (cnt > OFS_IN_SZ)
>> +		return -EINVAL;
>> +
>> +	ret = kstrtou32_from_user(ubuf, cnt, 0, &cap_offset);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* Capability register at offset 0x14 is the last IOMMU capability register. */
>> +	if (cap_offset > 0x14) {
>> +		cap_offset = -1;
>> +		return -EINVAL;
>> +	}
>> +
>> +	return cnt;
>> +}
>> +
>> +static int iommu_capability_show(struct seq_file *m, void *unused)
>> +{
>> +	struct amd_iommu *iommu = m->private;
>> +	u32 value;
>> +	int err;
>> +
>> +	if (cap_offset < 0) {
>> +		seq_puts(m, "Please provide capability register's offset\n");
> 
> May be you can add last offset details... so that it becomes easy to find out
> the offset range.

Sure.

Thanks
Dheeraj

> 
> -Vasant
> 
> 

