Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262E91A00E7
	for <iommu@lists.linux.dev>; Thu, 13 Mar 2025 10:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741861976; cv=fail; b=lO7YuTkCotgvze7aFkWeDFgQJKfGtnQPXDlGuAcesLpXPcydJrJaQjvwNaKKU0dVC/GtSZey6WIF7ItQihBOAYDkRHyIZkC35l9fEAN8flQIV563caYtEFRXmTlfaoEGB6hEI27fBHquiDJLOjjUAHYOmeF7ZyGN72Et14lLdjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741861976; c=relaxed/simple;
	bh=lzwh79WAebUI5Xc0R9IqLBObSIvaoGcd0gG/VUJjLGM=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SM1yp/evFUgy0pnUsMoyCaDwsAiDh7mjtiOJmXZ3yIc0CeGOWOoXziBMSguZmHhhPZoFvQwSx5zgZmNO3BM4jbX5N33OaZyVa5xK0fCAgdLOv4hrLQVOeJnQjwKQuWe9D4vYhEDBbsKU56m/qD+P/1LX7qrVr/YRAySeA5ELBfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SSomU5WT; arc=fail smtp.client-ip=40.107.223.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SSomU5WT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SQLPnmD4dGMY1WT5K1lfNUIwOLNjyHXosc9GTrptcnQOmBlkPrn0RJfvC0pNgntojT9skRzHRjxJvWkgT49q9hKNTat5yvsoc7sj6CfNHkxZc6Siz+hbOSN0fHErSZZl3JGWHNNFQHQbM9AOOyavypxS1FOsf14bJjZwq1oCuywzsznfgsO6dg7qo/rtjdajVi1vLgfzinWXDdz9X2gcOXiF+An9yyNfetOdIRdvavRjb97QcZAZ50iiqnAKcbYa5l5YqStcjG+dcqEITXcP4jTmJoTwXSXoFUJznXQZzVXrWYD1GJUUHCofGue4x3IlXUBlp1RgTwuv02kKJiLSqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vnZZfoLo3Haonc6s3T/opCHgNnfAw5/Ik1IKLUnJkww=;
 b=r4CwiL9XJwI4qiFjVCRkXZ5bErVtkRHzqJWWWutkQJujEYSH/fZW9b0t4qSeUJ2oNt1FC0gAaEw9lnc/mr3mQqsHyYzrwIifTXbRJg83mt5uRHS4xgqHLXUXEWLVAZ6J3gQ9M8KqFQMKvBBrEUpzmjCxBejcrKEYqGeGseUpoDzm/oqP8ziTLNjUHQRrFPGEXUEQ1Dc8gAma1zCIv3h4LDeVhWKK90RjXGDjjj3DvYfomEYDDJ6itBX4kjubtQhIfqUkj28n16Kjj/wDNHMEVXaqVkBMeZbZzjF485BfpjM24uHIz94tOBWrRsq5mNPjEVIQ88BGVyJavzygzOroAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vnZZfoLo3Haonc6s3T/opCHgNnfAw5/Ik1IKLUnJkww=;
 b=SSomU5WTGhePtn/ZlA3KKyCle0iuCYHF9w3Q+REgeqUwXpuh/DeJx1+DMhLRt123zi2cseMSrJOgJaih1UMQ9IS8WcOcqiSq/ddCYNOYQWI5LDSooDrmkAyQypQhBFKdM/58zYVa/nwitJpmnYvaKJ+25XobJYV7aL2Lq8ynu0k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6043.namprd12.prod.outlook.com (2603:10b6:208:3d5::20)
 by IA0PR12MB9046.namprd12.prod.outlook.com (2603:10b6:208:405::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 10:32:52 +0000
Received: from IA1PR12MB6043.namprd12.prod.outlook.com
 ([fe80::73e4:a06a:f737:e9be]) by IA1PR12MB6043.namprd12.prod.outlook.com
 ([fe80::73e4:a06a:f737:e9be%3]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 10:32:52 +0000
Message-ID: <fbb7d901-25b6-49c7-abeb-4e76451c197f@amd.com>
Date: Thu, 13 Mar 2025 16:02:45 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/8] iommu/amd: Add debugfs support to dump IOMMU
 Capability registers
To: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>,
 joro@8bytes.org, suravee.suthikulpanit@amd.com, will@kernel.org,
 robin.murphy@arm.com, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
References: <20250206060003.685-1-dheerajkumar.srivastava@amd.com>
 <20250206060003.685-4-dheerajkumar.srivastava@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20250206060003.685-4-dheerajkumar.srivastava@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0013.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::9) To IA1PR12MB6043.namprd12.prod.outlook.com
 (2603:10b6:208:3d5::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6043:EE_|IA0PR12MB9046:EE_
X-MS-Office365-Filtering-Correlation-Id: 52896a13-3863-44d5-98d1-08dd621a68b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L2VxR2M3NlFQMnZMUFQ5bFZLSm1BdmZ5dzFhM2ZCNm5uVCtoMGc3My83R3U4?=
 =?utf-8?B?YVBVZUJlUkVmOTZUSTQrekNCb285Yjk3ZlFEdHFUcDVVR2t1cE4weTA4cXB3?=
 =?utf-8?B?RG1KWXh1d1FUWUo4bFNMeHlKTGFJK3FKcDU2RUxoNHE0TG9mK0Foc2JNT3pW?=
 =?utf-8?B?NFVzamp0emc4WGhtT3ZQblFKR1hxVi9xSWlvRHk3OUFwNmFYYW9VSmdVOEtw?=
 =?utf-8?B?ZmRNeGtocnVkdEF2bjVQRDhuVTEyamdDRm43SjFqVkpod3NUTEtQOXpmVnA1?=
 =?utf-8?B?dFVIVUppVFFvM09tbUl0bHlQVVZ1QzN2L2xwWFVrNVEraTI1YVJpdmhVM2NJ?=
 =?utf-8?B?Vzh3K3crcmhwYzFOYnR1aG5zcnp1OUVRZXJPL3pJT29XTXJ0b1dPL3RjakFS?=
 =?utf-8?B?Z1NNUUwwZG9XRmhBTXBjVjZvRVdiR1BHcEVyMzlVVWZtamxVNE80QVl1L01v?=
 =?utf-8?B?bDhKYXREbDFLSGdNSlZKMnpzTEtGZnlkeTN4eHdhYnJKRTU3UzJXOXNKRU9Q?=
 =?utf-8?B?TFZkcDYxTU9NVmsxV0I1c2hreUVya0hXUGkrTzhrS0xyeG9rN1poOWZwelVx?=
 =?utf-8?B?Mkx4QVFzMGl6ZmJ1ci94V2dWNUltQU13eENxVnN5OWFLcVpMOE03UUpSN2Nj?=
 =?utf-8?B?VzRqQVRMeEp5K3E2akIxSUdma3ptZ0w1WGZQVnhtZTZEUTJ5U0x6LzdqaHkz?=
 =?utf-8?B?dkxWZkRVdXNjWnpjS0YycmZXVThqSnpTd3RHWFdobUtva0F0a08xd1FzdDRk?=
 =?utf-8?B?NTk3RHNpQmpDcUYyNWdNNFhCbXBxcUZPM25BVkdjOWI1L1BhOFBwY0tHaVpy?=
 =?utf-8?B?M0ZoSnplUG1aWDR6Skt0SFEyamhvdFBvZS9IcFlVcit2Mlk0bG16Z0F0VFY5?=
 =?utf-8?B?bk50OTlwbVBDcGdlR01NSnViajA4RXFzQlArVThDdUxTbk4rTFBMZUJoT0Ja?=
 =?utf-8?B?d1l1L2VpU29weXNzYzlsVlN0UGs5V1ZIdnh4VVM2RlViSnlzL0djdDBuNk85?=
 =?utf-8?B?cU93REQyQmYxYUo2R2llWjQxVmZOYlBjYmhaUjJraXQ4cWh0UnJXQ2xENmxx?=
 =?utf-8?B?cENXM3pwTHIva044Y3ZjV0xNeVM3YXRWb1BRV1F3eG9yWDJMZUl3TEwxS0sv?=
 =?utf-8?B?RkpZTGN3ZXZrdmJnamp1U1JTODhsK0c1TE5NZlFmNkpoYWpLWHY0azN3R2lk?=
 =?utf-8?B?RUl3a2d4VzFWc0h2OHIwUnBlOFZJZktNaVhKZVV0SDV1WGlqVU10WnV4WDEw?=
 =?utf-8?B?aTl4UjVYT3RISHBnNUNWT1YveElnUkpaYTFIWml3RzdoZWIvbCtYUXVvYk5D?=
 =?utf-8?B?QUJTZ2hJelkrNFpKUGZoKzExNnhUY3daUHducTFHYkc1dEhrbUNZTjJlNnM4?=
 =?utf-8?B?TEMxSDVWT08vV3hmYVgrMzhyVFd4VTRTL3VTODlxQkM0R0ROOXZyVUFDbjN0?=
 =?utf-8?B?SHUxSHRoNm5YNkd0TGVOVFBvcVVmK2FLNVI1VysxZExJQzAvbkEyY1g2ZFMr?=
 =?utf-8?B?YUU4YkZjdmx3RGhFYko4TDNiZ3hsUTdqMVBBN2RvK0lMS1pYOEozQjdpV0lo?=
 =?utf-8?B?NXNxZjBLY2pqS3F3YjVINERCa2lSQWhvOUhTSCt6TnZBeWNpUE9oMzQvYkdC?=
 =?utf-8?B?cE9YT0d5ZlR1bjEwRFN3NVA3Y2pyQjk3bEMxY1J2VE5YYkp6VjRNQTNuNjBD?=
 =?utf-8?B?Q2EzbTVGRTFLK2gwYVFOTTVaZitNN2QzWWN5R1U0R0VLTEpaZlpzd0NaSnBr?=
 =?utf-8?B?ZFo4MDAvQmw3eXRwZUdSTk1rOXZlUFY4RGFvQkhpVzZ0VlhtMTdQZFBHTXJZ?=
 =?utf-8?B?RWErUENHbHRsMnRpLzQzT3pBUWVkZ0t1V3JxL3RhQlJKaklyM0VDbUFsMzVy?=
 =?utf-8?Q?T2CF0wbxu9ft8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6043.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Tk9wcjlwa3NGZWx6TTdnYVNvcGlJMDlQOW5hZjhRNzlNR1VwcG1WTmhKcVk0?=
 =?utf-8?B?NHVMbFdTVTFTeEtwZTN0cUZTZG1VUVU2STRJV3hnd3FZZDJJUW85WHFtMExr?=
 =?utf-8?B?REZLb0ZweERxTTVITFliYWw5aFRsOXFQRWNDamJLNUVTYXZaUmg2dVpOQ3Fo?=
 =?utf-8?B?TXI1cWtvWms5NmFTTmNJcGs0K2Z6VnFXei8rdHZyVEdUM2tIaVBBSHdqNGFJ?=
 =?utf-8?B?QnEwZ29BN1RsY3NYQVdBUUU0TjVMby9mRC93ZkhhOUIzVngwZ0VZRTRwRXRY?=
 =?utf-8?B?NnFCRE5FU2dOaW5pZDY2ZGpFazEzejdUWnNjNDQreTl1bk9VVm9WcEUwSXdw?=
 =?utf-8?B?RlUzdy9VUjRyS3VLWkRDZjFkQWgwTVhCOVVkcjFOU3Y0b3U0RzBPZWk1QnBN?=
 =?utf-8?B?aWhTZm9jZWNIb2hUbWFWNkpiTy9FWnFOb2d2RTRydUFBbVBJT2JKMGVobjNo?=
 =?utf-8?B?cVdML1lWN2tIZ0tnS095QWRSNzZGaHdvRldJRE9DSzBsNjR3a1EyMjJuNmhR?=
 =?utf-8?B?M2kyMktiaGwvVktqaCt6Q1lRc0NmM2lyT3dYVy9WT2NLTEJMQmdMRWFWVm1G?=
 =?utf-8?B?TTl0Rkc4MWZUcVRJbXpGOVJDT1lEUWVoY09sWjllVHdTZ0pGa1g3SEcrNFlF?=
 =?utf-8?B?VFpsUi93RUZkVUMrdFpUSktaN0hBNHNVb0x2QTd2WndGYmVud0lFTnMvbENz?=
 =?utf-8?B?eHNyZVJ0SElWeGZMSkIrZ1ZFWm0yQjluNjQxaGNTWHhWTEpEZ1pVeTc2ZnVn?=
 =?utf-8?B?QzhVMGp3VWp3cHY0cENmd0hWRjIwRHZySkt0Y0ROMHpXeVpMYkw0L25uOURU?=
 =?utf-8?B?SnZWODBZZk1wY2NvTGtjVUgxbWlNVUJ1YnFuZHhjWHNrL25WWkRrQ1g5NGZI?=
 =?utf-8?B?aHNtZlFuSU5ieHNodUpaaUxkVjUwcnJvemMrK2NEM3RKaGFlMlR3N0lqUitJ?=
 =?utf-8?B?RmgxNXkxdDZIdC9CVTU3ME9GWVpESFo0ZDJ3RGx4Nlc3U1libURtdkJqbGd0?=
 =?utf-8?B?WnF0dEhFLzlLOVByQ2gxSklGWXRLVDRyT1d5SG80MEtDRmt4WE51cTQ1SHpQ?=
 =?utf-8?B?OFBic2RCd1JadUJScGJMaXRXR1VGa0pMeXhNcStXdklkaGFOcW1hTmpTdE9N?=
 =?utf-8?B?bXdvRWRCekpmR0lodCtlTE11MzQ5VUI5SnZWd1AvSjdualFlRk1DUjVObnln?=
 =?utf-8?B?d2I5TVR6S2lMU2FVRWEvZUFwd3BoUi9HQjNhR1hqTnc1NU1tM2oyb1hMRWdN?=
 =?utf-8?B?R2hiQnUyUFlJZWpiZCt4N2tjMHozSjE0OTlRV2hld0o1YVY0N0pEaFllbktp?=
 =?utf-8?B?RmE3aVBFaktHT21oeUNmcmIxSkxoSGYrTjhkZ1BEWEJFeng0MEdVb2VYK0s4?=
 =?utf-8?B?OFBsSGFLL0xvL0V3SG9mejIvU1llSUdKeHpVNmh0V1VZckhXTHRVTU0xZld5?=
 =?utf-8?B?dmFFYTk0U3dRODZXemtwMkFTWDlUWHE4WkgyTENZb2E3eVNuMngyUHFLQitx?=
 =?utf-8?B?YjFDWWlQcEgwNGNmTjNUREVBZElGRThQZUFEZzlaZHp5RVY5OEN0bkM3TTZV?=
 =?utf-8?B?OTdvbTRmaUpWbG5vTTBZcnlMdWZZVFp6RnZ4SHYvUUJRTWp0NEJidWRuQy9J?=
 =?utf-8?B?VGs5RUxaY0V6STQ2bWM0QS9tR0JNQ2h2UTdEWjVXbVFFNUFMNGtvb2FXN09K?=
 =?utf-8?B?NmtRT1l5Z3h1QWFjZHBXYzJnRnY0eERkSlZyWHBCOG9zcnQzNlJOTFFyS1p2?=
 =?utf-8?B?bVkwcGl3V1E2YzNRK0hmWThxVEc0eXNPMGs5aHhWeENvTGg4Nnl1SVRGZm1Z?=
 =?utf-8?B?T1MxTHJxKzlFK3RSOWF4T3RxRlJaOCs4QjJDc3pLcGorSjlpUUFDNGs3K3dF?=
 =?utf-8?B?RFhnQWRIbTgvSkNPd1pETjhXcFZQWlNmM2pQUjl4d2NlUzVtY2RmMnI5andG?=
 =?utf-8?B?dExuVndUeUdCeWpXUGlyNzM2d0dLQytzbnJxRXQ5YjM2a2Y3VWRZSEUrdHNa?=
 =?utf-8?B?LzNLZ0YrSHFzVVRWSkhRemhsZGhoYU9OVEg1Z0dxeUp6TWRkTjZMU0VSbUVO?=
 =?utf-8?B?VjZGK2dMZVU4bVJlWTJmcHpLZ1hBbkpodW5EeVc0enpQRVVJTGI3THR4MWJJ?=
 =?utf-8?Q?kr2p5Cr6KXecSh6RxxF3UXJnE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52896a13-3863-44d5-98d1-08dd621a68b9
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6043.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 10:32:52.4766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +PsYfmSWUf+EX6HvJX1vZvrqIWslI1XL0D+zQy6RKGn03QPfn3T0UjFFxvOid9YiiDoZbUOzAlPvSYL288OeOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9046

Dheeraj,


On 2/6/2025 11:29 AM, Dheeraj Kumar Srivastava wrote:
> IOMMU Capability registers defines capabilities of IOMMU and information
> needed for initialising MMIO registers and device table. This is useful
> to dump these registers for debugging IOMMU related issues.
> 
> e.g.To get capability registers value for iommu<x>
>   # echo "0x10" > /sys/kernel/debug/iommu/amd/iommu00/capability
>   # cat /sys/kernel/debug/iommu/amd/iommu00/capability
> 
> Signed-off-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
> ---
>  drivers/iommu/amd/debugfs.c | 47 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 
> diff --git a/drivers/iommu/amd/debugfs.c b/drivers/iommu/amd/debugfs.c
> index b16b62ae7111..dc5fdc905754 100644
> --- a/drivers/iommu/amd/debugfs.c
> +++ b/drivers/iommu/amd/debugfs.c
> @@ -18,6 +18,7 @@ static struct dentry *amd_iommu_debugfs;
>  #define	OFS_IN_SZ	8
>  
>  static int mmio_offset = -1;
> +static int cap_offset = -1;
>  
>  static ssize_t iommu_mmio_write(struct file *filp, const char __user *ubuf,
>  				size_t cnt, loff_t *ppos)
> @@ -58,6 +59,50 @@ static int iommu_mmio_show(struct seq_file *m, void *unused)
>  }
>  DEFINE_SHOW_STORE_ATTRIBUTE(iommu_mmio);
>  
> +static ssize_t iommu_capability_write(struct file *filp, const char __user *ubuf,
> +				      size_t cnt, loff_t *ppos)
> +{
> +	int ret;
> +
> +	if (cnt > OFS_IN_SZ)
> +		return -EINVAL;
> +
> +	ret = kstrtou32_from_user(ubuf, cnt, 0, &cap_offset);
> +	if (ret)
> +		return ret;
> +
> +	/* Capability register at offset 0x14 is the last IOMMU capability register. */
> +	if (cap_offset > 0x14) {
> +		cap_offset = -1;
> +		return -EINVAL;
> +	}
> +
> +	return cnt;
> +}
> +
> +static int iommu_capability_show(struct seq_file *m, void *unused)
> +{
> +	struct amd_iommu *iommu = m->private;
> +	u32 value;
> +	int err;
> +
> +	if (cap_offset < 0) {
> +		seq_puts(m, "Please provide capability register's offset\n");

May be you can add last offset details... so that it becomes easy to find out
the offset range.

-Vasant


