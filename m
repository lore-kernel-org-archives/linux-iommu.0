Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=52.101.46.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1795779541;
	b=y26SIiDcfCxQ3upB3X+zK+rH8n1tqdiF94JrD50IC8l4MbqNBtfp/cu0op/pHvhoGjLJ
	 Dap305sYW9tkwx/jR0RBoIdldORSgETd/UVqUaCXzAxUURTGQry9ZbxU3Y+PJ1QM1EwJ1
	 hDDZt+fDIEe44CYnsaoe07tqTqxQ3pKi+guxU4v5BcY93D59JYOH2sVSZ8smH3N0V+U2J
	 Kj+cXpLSeLYCR/JZjKOtQ+RvgwLRcZriGa7plwRyfcO+LKw05KOPMAsWuR4+ihBiwskGd
	 1W+4cM6W838UuV4sghpLn+MYWBkbm9S/iy+XYTYYC8Cbi5z4Eg6I4LktrEs2HDKgR6A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795779541;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=hj0zAgLfohcA932JTr1R5meD74xxFmPvuqEuTxbZU8c=;
	b=DhuQ/CSriapybl/da3BJNb5bzF6pGfCZNer9FCpjQw6drDeSrHE1WUX7qg5LgrvRslF8
	 +LyG6xq2bVu0NinHLKuYuEHt4GxBqJfWoyzfZkVaZM3Yw2h/l14nQwTGiXDlhnCdaRteM
	 AKULSsWpieOgSNBzy17OBaz49K5VWr8oOdU1ViY3+vHwo+fCNIJWeg87KkeBojxiXryE4
	 7XjNj9SoXu/v9muoRI8TBlbMVk6QeLYU3QcCr5wjuZHHMq3GXavM0vl1yOva69Ue0/r8I
	 +yJdo465/zeIK+NqMsFRtjZqXAi1LG/wPzuf9WGfN2Bsz0qU6yQ7EQAAJ1a1MI08yfQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=3b3LaoAy;
	arc=fail smtp.remote-ip=52.101.46.28
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010028.outbound.protection.outlook.com [52.101.46.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC343606A336
	for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 11:39:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC343606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=3b3LaoAy
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tr4mWr+21wrtgB32EhUwC27c73M7kD60ZA7cZLahUW6ZgYALs1zhYUHUmxNsdX7NJzbDOEbFOCkjulqWt50L5ZEVMus/CSV8XxFKxhFSYGYPaWApG2tkBGGBYOW8f3iYvrpIHbhxSpCW9h3WRQaGiVd8LpEUSbCilp5AURN1Na1bTcwTm1nWcs1FiaxAXi3k7Aafzwj+8mukhNlhzH87KgUCADcZ+0xentyFgTHNHv+phU/5x62tBKSPFQ6vPbl4PAqnRjyau2bsRQJxxKue0C2JQZt36jjnhTIGGGVVBbOYw96wVAAo1CskngQnZ6rrpdQkp55MKAG926y2a5YEDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hj0zAgLfohcA932JTr1R5meD74xxFmPvuqEuTxbZU8c=;
 b=trU8RyDFt7q2E1yE/sXf2UvzRv+qDIruPq6quntGySSxFIczMnvgiv4zc2whzQR3d3krkNZc57J/TJ0gNGsrnO0jXhhZvuSLR3UzwEoJV+BcgdBCJzF3+e2Zvj6oqjnDZ4E8s21extzjnyIqaaBGtRD9E3ccB2K07rU3ppXNFyCCe/KazpSZSm0xSvEog0tpyAgc8msRBzFjiVC/WUibWcLi89/jukzgxXNnWEegxItuXZZDNOVpqGovgXxAOkOrtlzbEWlrnYwZGaB21vI9728JSMB9z7hNekWAR/aEfETzKFLldQ9PG5nPoEf5imsjC+j5gnlg3O2PH4r12DDfHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hj0zAgLfohcA932JTr1R5meD74xxFmPvuqEuTxbZU8c=;
 b=3b3LaoAyMtUybqmNYG3VEV+5o2nRmjvqa+X4fo0qUH5irDKc/1ugvhC58903Y0fIYQR3eoPWEToijAk6+F/PD+ts9IOTtxbqKcvnYwNgw1tXJkTDEni4zek/N4LkKTZUEmKXUQYWwO9VsXdlREHQoQh/lj3szjp7jeH/ktrPNOw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 by LV8PR12MB9668.namprd12.prod.outlook.com (2603:10b6:408:295::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Fri, 27 Nov
 2026 11:38:54 +0000
Received: from BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83]) by BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83%5]) with mapi id 15.21.0662.007; Fri, 27 Nov 2026
 11:38:54 +0000
Message-ID: <4b6e95c9-e82c-44f2-8f3f-c9019e65e472@amd.com>
Date: Fri, 27 Nov 2026 17:08:48 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] iommu/amd: Lock the device table by DeviceID
To: iommu@lists.linux.dev, joro@8bytes.org
Cc: will@kernel.org, robin.murphy@arm.com, suravee.suthikulpanit@amd.com
References: <20261127113018.209034-1-vasant.hegde@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20261127113018.209034-1-vasant.hegde@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0113.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::14) To BL4PR12MB9505.namprd12.prod.outlook.com
 (2603:10b6:208:591::16)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9505:EE_|LV8PR12MB9668:EE_
X-MS-Office365-Filtering-Correlation-Id: 997da2ca-7198-443f-8232-08df4c7b0400
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|10067099003|56012099006|11063799006|261022105027099003|261026140227099003|261026121527099003|261028144727099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	WUPIjFTEsS+T16mrhqxnMoAW9m13CkQn8bD7qaILsWvJ+my9gZnJ75fCAzcipZqA89gk7ET1rPMn+b5mg8lvQ9IomkupVAbi5eYM4QM+EPoI19t47azzvL3qI2LYyBIVdDUVpRjLcfuBWUxxNTiQWYiSnyKZ09gT558LU+UzjaHlVDhJ5F1jeoGOeqe5YBBCOTEl7UsoWRrUsuUOO8D4eaoGfRQigo+3xx2FR+pIO70Eg8A/vaKOGjLVZRXizcYgz6CpvdLCEkRR5ChILAe+J5HB9hq6NvL13TnvnUSy27zA946Ba7m85UARkG2UN7W4pF8HJD4/WWDWCPtd5Vt5skxFqOpEedSNoUMsGT5Mc77P04mblFkmo5Ufmp5z6WxsOyEJ/Vg8v8Ph07kZEpXkLcNTTeA7ayV5WgLv4x+Xoc3m/MiFgCtaL9BaPU3y5PTcE/xibD+kVZlQ3g4Q38w+zRTZ3NLomDeoDjZVh/hsb5x28mWT8AblPO9AHm5Okx0zh15TtJEAEu6BBSn3TdoyO9M2q4a1Em7qR72fLjtqXRfVWLNzw1sa7ZvTWrcpJvgVDKRCYKUNqlsGiDTWnaRO4gnkDTX1/dc7mf5QwgkC0soURaKsYU5QkJEd0+ariV5RTBWpjNMhwGD/k4FoYZJtMP1qiRZJQIFW8M7u4SQSTcs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(10067099003)(56012099006)(11063799006)(261022105027099003)(261026140227099003)(261026121527099003)(261028144727099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bGpJYzhwRWc0c2hFblFFRVpQK2ZubHF2c3ZFMWJ4bGVOYXJlM2t4WkJicFd2?=
 =?utf-8?B?NThJcHVyQ293UWs2K2dMQlQ5T08vaFNyZmd4R254UVNGcVN1ZE5rbENETUx0?=
 =?utf-8?B?a2JaOGhuaUd0N2FzcFFmTDl4QzFyVHVnWTFCVEJjSkZ1dkhkcU83d01wdVht?=
 =?utf-8?B?dVZWeVZBRzhwRjN2R2x1TE15SjRObjZOZkx3MUd0U0N1SXpqSVJYd3dDS1RP?=
 =?utf-8?B?N29nemM0QTZzQXR5OUp1azI2b0tzNzd5NXg0N3lJdjdrVnFScW9sSjF1RGhJ?=
 =?utf-8?B?Mnk4YlJZREVzYVB5UFo0dmhCTHd5cEI0RXNLdWFlLzNjaXp3aHJGaCtRNEJy?=
 =?utf-8?B?V05pQmhWUjFObVZ4cHhWaXdIcGpFdk8zTE4yUWFUakRReGs4eXBwdDJnU1gx?=
 =?utf-8?B?WlpzZ05NcG1TaXA2TTdoWjRNRWFrcWNwRzFGcDc4aExTbkJnblRDN2l2VVo4?=
 =?utf-8?B?enRpUnErVXhpaERFSUd1ZGpEbWNaZnFtL1NNQk5MMVczc24xOG9ndWVzS3Na?=
 =?utf-8?B?S1dhNlpwMW9wMm5PV3lLcFVUQUcraFVjWnc0RFhFNHhHdERPYnRad1Y0Q3Qr?=
 =?utf-8?B?T3RyNXJZbWc0QVZRT3ZxRkZIb2VFSHRYa3NDTkp1NzYzeFNGeDdYdDA2OVAy?=
 =?utf-8?B?c2FWM3FHU1Zka2NieGFpTkwxN2V6WUZOQmNDNFFSMkJNVExLejg1bnBaTk9V?=
 =?utf-8?B?L3ZDMHJaRWdNNU1PYXlaSmpoR1JZaWowMUl0K1pNcG1lSno1bWR1Q2lRWEVG?=
 =?utf-8?B?K2FxVGVwbXR2cnZEWlRBS3dCZkJsN0txNXI4SzE3dlFjb1RxVG1TZXZtRGlz?=
 =?utf-8?B?UXM3eno1bE5kN0JKc21CQkFmeVJCcGcxYkwzNjRrZnNnbkl1bVkzTGxTYmdC?=
 =?utf-8?B?T2gwL3VLWFVWTnhFQkZQejE2SjFuMi9vZWo2cXZTNlNkOWsyRFhVMElKLzM2?=
 =?utf-8?B?WWhqZ3psOXpZM0lrSzJSNHFNaktQd2o0bnJwaEY3c2ZJT1FyaGhFZXJmNDk2?=
 =?utf-8?B?RXcyaDVoQjZlc1JPdWczR29Tbk9XcU5uV25MYWFrZDFVem1WT2tUS3FoQVNO?=
 =?utf-8?B?SFJqT0hjaE0xU0xQeENjeHdaTUlEK0dlYytBc0RtV2o5TGxkajcxVi9YOXNw?=
 =?utf-8?B?TThiUjhJUHdmZnNvYnE1czRld3R1aVlsR0NWaGFhZDVUWlZXQm5UZjNRT215?=
 =?utf-8?B?b0gwNkE5WlVEQ0lYUnhSbWliTmRCVEZBY2w4VFVjdVY3Uyt3QVdqZzdrekRL?=
 =?utf-8?B?U2hmemJaVksrck55bXhhOTZaZFh5SkUydXJnUFZGNE9FNk9oSDQvMFFtZWJK?=
 =?utf-8?B?M1lWeDF6L3grVDRmdldxRG1ubVpTOHRpTlpNcVhRY01EMDBTQVMyZjV1ekdo?=
 =?utf-8?B?SlpvWHhKSW9ZbldRY0tXQ0lWZmczNTNnN0VreDZoL2puQ0d3RzkrckRWUUdK?=
 =?utf-8?B?amFBelJ6R2NqVFdrWjZNSW5yOHhSU2ZPQTVWbzYrSjJtWWRQY1grZmRUazh5?=
 =?utf-8?B?L1dnZzV5SU5qbnlOeVhlbmlqa1ZXTXFubmVjZlA3NS82Wm0yQVd2N1JKRU5r?=
 =?utf-8?B?b2pqOG1laWZHdUsvcW40NnBkVUhXTWlMd3RBMksxbVIrZy9jMDBlM2wvSHRT?=
 =?utf-8?B?cm1JSkw4SEhiOVRkOVZ2NzRjMnFQOG9yU1BjQTVKclhUUzFVbVMreEsra28x?=
 =?utf-8?B?RjhtWmJRMnJOY3hTTGlKbU9pOGZRcGVzQmg1dndsS0xldDVBOGh3bFJ3cGhR?=
 =?utf-8?B?WlcwVk9ZKy9lZlMrNWZjaEd1R0JJU1JJR2hDbkxFa2xSL29JYk5HdUFzaWt4?=
 =?utf-8?B?ZFg4TDFmRFpsRHdSdTljK25TbG11L21Fd1pzVzZjWTdmMUpGTmJlaGdhZ1Bu?=
 =?utf-8?B?S1JBYnk5aVBIMUM2ejFBdE1MUXNXY0lxRWFYOEU5bXdNY1JHb2xON3RMRkJL?=
 =?utf-8?B?YWxPbFRWZEJVYmN6TmlTV1dFeHhMME13ekVIK2VITXBJVjBlZ0xXQVoybGdw?=
 =?utf-8?B?T2RzeEg5Wi9KN1lSS3dEWVBHMGhuNXo2T1JGbGdjMytNdVYwR0Q5VXh1UHZr?=
 =?utf-8?B?SEFzY1J1RGJzR2dGVlZBU1ljMDI5UWxlY0RPMUNqZ3pLeFIvUi9vejJjZGpF?=
 =?utf-8?B?UEhxcm16bHZldktSZjhISitwS0EzNnVjQjlJY2J6K0xUWjFXSGtVZWtUZkc5?=
 =?utf-8?B?UWpReFBYaUFyZ3VOTXY0VmtoVDh5a0J4R29wYUxhZnBUQkFaMHNHSklTd0ww?=
 =?utf-8?B?WHk3NVJTSnZYRGdaemxjZWpWMW9ETnk0T1BUbEZTYUZWejRrV0dqTkM5RW84?=
 =?utf-8?B?dzlmd1JLcThYdTczZ2RtSFB5YmRiQW5FcG95ZzJtOXJMdVY3NGJ6QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 997da2ca-7198-443f-8232-08df4c7b0400
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 11:38:54.4777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IHYnaeWD3kZ3ZipTr+V4yd6c4mMpU5IPZWFn7Yxphy5yYlKtBytGsyFw6rIjy9za6wMXVRm9RNAv4iXYIXzAtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9668



On 11/27/2026 5:00 PM, Vasant Hegde wrote:
> The device table is indexed by DeviceID, but the lock that protects a
> write lives in iommu_dev_data. A DTE can therefore be updated with no
> lock when no dev_data exists. set_dte_irq_entry() skips the lock when
> search_dev_data() returns NULL, and clone_alias() allocates a dev_data
> for an alias DeviceID only so that it has a lock to take. That alias
> object is never attached to a domain and never freed.
> 
> Move dte_lock to the PCI segment so every writer takes the same lock.
> Address each slot by DeviceID instead of by a dev_data pointer, and
> drop the alias allocation. A DTE update is not a fast path, so one
> lock per segment is enough.

For some reason 3/3 didn't hit the mailing list. I will resend this series.

-Vasant

