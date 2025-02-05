Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2044.outbound.protection.outlook.com [40.107.212.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B17A2288C3
	for <iommu@lists.linux.dev>; Wed,  5 Feb 2025 12:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738757042; cv=fail; b=EQAoTCl46UQoSV+FhEC0nraT+TKSzT+IBOjh3e4PxUQOyXvCNV2Ilps7OfHgjPCNZu7uuwFG4cIOkgygtQgO33JzAWH715Lw9pG132uhA653ZSpS5RDb9HOAli7wHlLn0ItsWLE6elH4lKHxL8CqxeUNYxIDgsazjSiFHdsN50o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738757042; c=relaxed/simple;
	bh=yXLkaT/7cSg3GXVxW6UFD6M+UjgVLTzKiC0VR8m5lE0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kqpAM8ch5+fXy5zHs65Ansr10CIoiV9wisV5pu/9ktsakascwl6QGPlI/67wPR1ewsP2ZtyDJ9a6kqmw8OfJ/2P4TcqbScSezYzooWgSARPuwaNWTRpJRa6qJAtTmpZri7zyP2DOwi8nf8OsRVnX9ZS336GgpyvKU7nIYnhQPH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hc2f8kY/; arc=fail smtp.client-ip=40.107.212.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hc2f8kY/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GnfPVWPxoac2TlOl1OGt7+brTA5E+pn2uj7mv1aueKP9547BulGsID6QXz9XwZ3rw1NDMN7H+xTa+HuNSZM/13aPPl74TeKlzoiHs34eTCS2TVmdal0UUGqOnLA0dhs8kocnKQOKyrxvVDt3PmEjVl2Clah1WlNKHHEQA3zv/a+fZI872XONRg8LX7f7jBTamg1BnJJTyG67LzQb85BNovlOG1zbTlEF4+s9KM49QAnC3XCa35Z3GdQapEDaw2X6o0eYBaU8SCgWGN6K28KqAaSPwdUMvmWHuQ/iUemXxYMYa21E/Sg5C7Ky2luIJjd8AEAoTydgFbtJ7mS0EBTesg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QW7gGJdedzf3FWPRxUyNPKgVWsntyjbokLoT8AMiaWg=;
 b=fFm9hGdkthQP4x19S3tz7KCUl4v1to54LFsT39WwtBUmYtDr0Uy8Pa0cB7Hx/9da1wtPitMX/01M0KEwII1PJ9Cj3r0Dh0bSPSV61NmvphQgH0mT3/qw2uQeFqL9PEPnG01nTMBtaEs0yNHqD1KFeCnHA+5nRkrUcPS6VUzenhi7lHhghLIfo0Lr0+JokjdLc6J7Vfr3MtbfCoCUAGRQASTXuc3JA3V+qWRklT/kkg1EFkUm4M7GjiXqUdbfMv+2wi9XeO6acN8IDfSnk0zVcieTj6rQlaheMzTCYp+5ycLgeYG4Ax26+I0gvgHf1APGsXBcfvCHMYvjbkWCMe4WTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QW7gGJdedzf3FWPRxUyNPKgVWsntyjbokLoT8AMiaWg=;
 b=hc2f8kY/YEkTezURCEau+XrZSmlgBQBsifLHe1C/Gi4toSXNEfE+cv+ZCOicIqAgNyPiIfmtQS/skcsPJKR8cOVvmp0ZRmFgSyYyRpK/2v2e9opTN99NfBeumYIXtKNmIcwfkhte2ws5WeCizkx3H95F8rGGRk14mxrwMCY5Uao=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 BY5PR12MB4194.namprd12.prod.outlook.com (2603:10b6:a03:210::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.11; Wed, 5 Feb 2025 12:03:58 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%6]) with mapi id 15.20.8398.025; Wed, 5 Feb 2025
 12:03:58 +0000
Message-ID: <0e4c38a8-3f7c-4cbe-9dd0-9e73d4d947e0@amd.com>
Date: Wed, 5 Feb 2025 17:33:50 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: iommu: flood of ahci 0000:e6:00.0: AMD-Vi: Event logged
 [IO_PAGE_FAULT domain=0x0055 address=0xa14a4000 flags=0x0070]
To: Corentin Labbe <clabbe.montjoie@gmail.com>, joro@8bytes.org,
 suravee.suthikulpanit@amd.com, will@kernel.org, robin.murphy@arm.com,
 iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org
References: <Z6CGzUSV7llweytQ@Red>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <Z6CGzUSV7llweytQ@Red>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0112.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::20) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|BY5PR12MB4194:EE_
X-MS-Office365-Filtering-Correlation-Id: a2349251-9ead-49ec-c6fb-08dd45dd2b85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RkdnOUdVTXNWZnhKL1EyVHNxcG5sTVlIdDRVS2JyTzdldmhSQWtaS1NBNnRE?=
 =?utf-8?B?YUxRRnEyNGIxWXhUeTE3N1lXdTZZQ0xPVVprMnRraWlxM2NHMVJodEFYREJU?=
 =?utf-8?B?WUphRldhVTFzT1VOZGdrcmhwN1FJd0MyclFCVUswc3JwekVpb2xiMzhRcUNn?=
 =?utf-8?B?RTNUUVJwSnlIUmxDcSt2MnIydXVpMExMa1FGMi9sRDdqOWpYNWJpK0FiM2tE?=
 =?utf-8?B?S2FxWVIyS3lwNDJ0aUxNM1hKZzZsWmJCN0h5Umc2cFNtZXV6RzF0eDRVNlo5?=
 =?utf-8?B?RjJnMFVkbnY4N3JlM2dMQmxpazM2cjJrWTNweU41RGU2RFRsd3pyMWxWa1Q3?=
 =?utf-8?B?ckpjMHZYK0ZvdHB5UnpaYzVNbGdkUDFCdTV3WEtybzNONXdmQTFEaHF6dk9N?=
 =?utf-8?B?blBQK0ZXcHVxTHdISGgrNmNQVkZRb2VkNUlYSWx0TEMwOEVYT0IvdWtnWC8w?=
 =?utf-8?B?bVRPNEVOMTE3b0EyTW9lT1pBK2h5RzE4TW45RjEyTlFWOFV2UmZUYlZwY0pS?=
 =?utf-8?B?VUpKbFRISVNqdWFCbnhZL3ZvcjVwYjY2T2xHOGlpNzQvOFhwczczbnFENFRR?=
 =?utf-8?B?M1FFM1RiUjU1bkY5MXhJK2Z0dWZwNzRvWkJKUVpDdmU3UjNJUHpzbzgyV1V5?=
 =?utf-8?B?TkNwdmdzWnZkTUo2ekVjVG1hZTc4U2Q4aUQ1emNnU3RiSno1WnFZd3VsdHBo?=
 =?utf-8?B?cVhtMm5HN3ZnMzI1dEU4bGlwWEZ3eFlSV3R2Y3ptZ05FTFhnbGVsMGJQVUZB?=
 =?utf-8?B?cldtUE1qQmJLaTdEQUZHckY5QmVFdkN1c3U2L1ZIelMzdFB3dnU2V29Nb0FS?=
 =?utf-8?B?Rmx5UkQ1NmloUHFuamVWbHJNVGs2ZDAvNzhMb25iM040L21QbDM4QjZUWitK?=
 =?utf-8?B?cjcxZmVKRlpNaU1ZV25INEg4aUpKQWdBN3QyR0pzRWRsK3RoOC9sb09EUWhD?=
 =?utf-8?B?MkFOdkFFM3BDdURvWFBXR2JSUkV1WmpXTmlUSnUzNkhZZE02MlpLdWF1SkpK?=
 =?utf-8?B?cE1iZUl2Sk9CdmtWRDdqd29mRGxnS3lXNnl6aXdrQ1dSdDRlZngxTHZZU3RQ?=
 =?utf-8?B?TmNrREE0ekpNNGR6TXpSelVDc29pd1lQMXBhRys5RWJYZzI2N1RnWVYyTTd3?=
 =?utf-8?B?ZENnaHhMdStaU3ZBay9wYUo0Y3kxV1RwYjZTeGhkVmxNSFBkUHp0T0ljcHln?=
 =?utf-8?B?RnR5d3l2ZTVyK2FSNU5JMjZxYU4rS0RXM3U2ZlIrcGVGQWRFRW1qdjQxK1Bn?=
 =?utf-8?B?WVlySllEb3QxTTd3TGo4ZnJ0VUpqMmoxeGxsSlBqQmMyUWk3RTdhV1o4NDRo?=
 =?utf-8?B?ekdtdXF6WWVWV0hBSzBYWURkMDJrSlMxUnhjVzRhRkh1Y1hzalFESVFyMFhL?=
 =?utf-8?B?MlpuVnlMTVRQSEdhSFdTdGxBaGYrbGp0ZXhOZ0QxbEZaTkpQTlNod3R2SkVE?=
 =?utf-8?B?YWtRZFp5UGoxWUh2VWtUbjhDR0V1aDhoenpMcmtsTlZ5WHlIbUxUMjVKYS80?=
 =?utf-8?B?R0QyYnAyM2pFNzZacFBYRndkMVI4UUtwdnNWSGlxVEFheXZHdW9VaklqNDk3?=
 =?utf-8?B?QjJ5aHVha2hyYzV5S2laUlRrNkxIQ0QrY1B1RmZnY0R0cTY5TkhydnlTUzF5?=
 =?utf-8?B?VUY1a1ZDa3ZIUVNIaXg3QmRnbHBTVndCMXlUVmF1Y0p5eEFuM1U4dEg4MEsv?=
 =?utf-8?B?UHJ0T3RMbkgxUEhGaTl6cGVBVnIyOUFJdHZUMmhTQjdoWXlzazhvNmFhMlZt?=
 =?utf-8?B?cUhyRkgrLzdTSEpKc240VXVBUVc0QTFGa244dWlqRDRoa2wzSlRsTGFFVTVZ?=
 =?utf-8?B?TEVqczEraGtXbTFvYmg3Rjc0OHIvOEFrcDNXdDMvV1J6b2hnbmR3YkZLaDRt?=
 =?utf-8?Q?IoLx5ETchYOap?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dUx2S1FjeXNhbEFZMVNJSWRXWFNOOVBMNTd1ZTN1N0J0U2RJSWVqVTY0V2s2?=
 =?utf-8?B?TkhuTnMvK2F5WVFSSzJCazcrb3JRTmdhakZlcFlVQ25qMks1SnVibTZmQ1di?=
 =?utf-8?B?VE5tKzlZdVA2aHdpZUo0NHIrTXpxdnFvT2hoR1JueHdxWW80UUQ0alFkUHJK?=
 =?utf-8?B?a2Q0eStkL3EwbnJMNkVHYW1vdzFLNFhTZ2R1ekVxTmdRT1lHb1ZtWWViL3c3?=
 =?utf-8?B?K0k2MVNyWHNGeHBod0tDdHNWaEtZcGVnQ00weVQ2cEFHWlVwVmcrY0c4NTV4?=
 =?utf-8?B?d3RWWTUrQjA0MnRXSVg1dWkwYjVTWU9vUFZYeFUveFgyY2pPWjc0VThzaDJY?=
 =?utf-8?B?VlA1K3lycDRVcUNQUTJDWjFaTm5Objh6Ri9lKzZkanR6Y0RXWVRaR0hOMXZ0?=
 =?utf-8?B?MTA1WGM1MmM4Z2wrMjJEYUh2VmRHSXlWazI4VTJMVWtlMlJUZWNObTQ0SGFM?=
 =?utf-8?B?REVpNDhROG5qZEpsRUtXSStrQ0lJMWhXajkvUVZLQmFYdlVuajY3UE5KZG92?=
 =?utf-8?B?LzQwVWExRVYwdzNpTGVZa0dVR1J6ZHZQUHd1R1VCVWh4dWxNTlk2cUxZNTNG?=
 =?utf-8?B?bU9JM2VDMFhyMlQzOFNTQzl3eHJwUm9YdjhSRUVhL2QrTVFnMzVpSUI1Ri92?=
 =?utf-8?B?Nmo0dDdCNUlTSThpY2w0Y3ZiekplOTRteURTYklSQ0pyd1dBVVpZTGV4bkY2?=
 =?utf-8?B?VUY5Q0VzRnVBb2JnSDRreW1MNXBwekRmNnRnd3VkbnJ0ZGZoT0d3Ym5oajR5?=
 =?utf-8?B?UUwxelBaVWtkRFhkTWtJU25tcWtNdXRXWmhyVHVFdmZGdnpZdDgrMnJ6NUQv?=
 =?utf-8?B?OGVKZUUwMXdEUlZyaFI5bHYrS0FFaXNRS3VSYlpEL1lqNXR5ZHRVQ2VyMVRr?=
 =?utf-8?B?bER6U0dlZjJyenozbGsvK0hRcU0zR1oxdjBuTUJNRy9jaW42MEVLSk0waHJY?=
 =?utf-8?B?dmRwSEY2amlqUXd0VWFxWkZ0SzNqZm9FQ1Q1Qnp5UkRGcWdsSGZUZkg0QUxU?=
 =?utf-8?B?MlZUUFpIdit5TGdBNmFwWGJ5VHUwQmpLRnY4b0JIaGVIb1lsTnM4dUJTWGFZ?=
 =?utf-8?B?SFNmb2FLQmU4cldmV2h0WDhvc0ZvLzNMVVFOVkFhclRmNFZ6WW92Nmo5TFIy?=
 =?utf-8?B?YmdHVTdzQXhTUkJ3c2taNThNb1c1UnU4WmtOTmFnZDh3Y3VtZFYrdWlNVWgw?=
 =?utf-8?B?d05UM2tCOE0raHErRFJCV0ZEZFV3SjI2d2lmRTZjYnhZTHRWSFdaUzBHUkdn?=
 =?utf-8?B?R2VtU2thaUEvYVZWU2FJMjB6Q1lSc3NsZ2t0SElLdGV3Z01FU3lyVDQxT0Jv?=
 =?utf-8?B?Vk55dVErR0puQytEai8vN3V5TC9DMVIzZEJqRkdhdFVUcVZobXRIdXMrcGt0?=
 =?utf-8?B?MkRqRWtIbGQxTnNTQ2FZZWNtK2RvN1VSZUVjb0RneC9ucVpwWWNUNGQwRUFM?=
 =?utf-8?B?bEY1MXFCdXJNdXNOTWVQTURtZy8yOHg0bGlmWEg3NXk1ZTUzeWRQWGVYVTBC?=
 =?utf-8?B?blRmWTZPS2NlMXZnNnB5VmdmUTZVVEkra09NeWZUaGY3YWtNalR6SHFXN0I2?=
 =?utf-8?B?Y3pFeTdtV0NhaHJDNlVVZWRwaUJSaytMdDdERDFRUlhLTU9vdFgwc3A1Q1Ir?=
 =?utf-8?B?K2JrQnlaTWZRZ2RpZ0JPc0NSSVRieHZQVW5FWG9EQ29yZzB1V1VhajdWSlFU?=
 =?utf-8?B?UlM2SVE5TWloWEErcW43S1BwQ0VLSW10cXNnQmVnQmgrbGR3Z2ErN2o2QjNH?=
 =?utf-8?B?eGttdXpHNkM3YXlKM0VZYjBPeWlYZ0Vua0c2Uy9SMXk3eW5sbEorRTIxNTJJ?=
 =?utf-8?B?cDQzTVQzV0NTcUt3djVldTZGcHJoSGl0QUhBOE5FMCtxUkwwUytEblMxaGlk?=
 =?utf-8?B?WE1DZ0ViVFZlY0VRbWJmeVdidDBGYXNnUTlkSHpRWEh6eW4zT1gvTUdCdlU1?=
 =?utf-8?B?aGZxOG5oMXdJcERQSGZYMC9HK0FQdjFtQXk2MlhZRU51c1BMbEMwbVZHYTQy?=
 =?utf-8?B?YjVubzZhZGxjcW9RckNuZnpzcGdYUFc2b01halY5ejRES043VHU5U3AxS1Nm?=
 =?utf-8?B?T25rV04vMVVQeURMeVp5YU1kT3JEOHUwN3MzNDVmTktuK2RFeGpaNDZTUlI3?=
 =?utf-8?Q?SDenOE7EB1dz0C7STb87whMtI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2349251-9ead-49ec-c6fb-08dd45dd2b85
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 12:03:58.0548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RMlyD/g3E47iJwheGfQ62p/8o66E7Ogn81UBoPvVLjQ5Sib+Dy6iNiEXhzTUOfgn+oPa6/NuPlMGWeZQHuYKmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4194

Hi,

On 2/3/2025 2:35 PM, Corentin Labbe wrote:
> Hello
> 
> I have a supermicro server which is flooded of kernel message:
> ahci 0000:e6:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0055 address=0xa14a4000 flags=0x0070]

0x70 means, Page was present, its write request, but device doesn't have
required permission.

As Robin mentioned, it could be FW region. Can you please double check?

Also what is the failure scenario? You see as soon as you boot or after running
some tests? Can you provide dmesg?

-Vasant


