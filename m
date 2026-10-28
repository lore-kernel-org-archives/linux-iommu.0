Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.67
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793199147;
	b=5VgpruOR1qCRul4GNX7GyUVGVln9zkUJfkRJ1xot/kzY/exRhG4SpUiRitzH8/aisTaC
	 A0JpocuCIsdAJVLwblwuPY5xq/dZbuJGAdqYcfXDXv67CpoBWI7tBr6BPnoVHZAKvG0m6
	 MHjm48VNUkPIBz6PkTCCyvsNX51hWTGIu1AEviMixM5BC/YrRnmS7JXADoBErXxt7NB4A
	 rXxMZfRMYmWUtd5XXoLPnizV8zrPqfwqA+04TBS5oEp0dhOJpA56HjupPkL56V/z9askm
	 0M0hRyz595n+zgz+XcrK9M/O4xaB0YbkpgXASlo8Yw4cb/jysPgk3TJj+n/v2Wl0VsA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793199147;
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
	bh=DkyJuoGisNxhzVn7dGv0x9W+B+wfsRZWPVd2wZOiIcg=;
	b=2btq8tt9Afje9fIxbxxWIBgsW6PZxyr1DUY8hfMDaNcpG++yRoXBWowO/3bwRRaW/qOg
	 WUuLNXyVzPolQNFo+RxWWZSuvFjeyiD1dsfJ7gDP+TNZb4eMjgd7u5IaLHYqykgjrSTyC
	 3pGvjuV9R8vYiHOMIINxKfkdzqjzt5ZOt95srRoNrBMT5qZwH9/c2Q4TxD2OzQ8c6AWMq
	 +rRTIJlEe5d750GQApVOJNj7mlTryEz5Hv8qp8QffyMMlaUGAj35QBg1D+5tNkBtS8CZe
	 cyG+7Z+B32CuPW9FnoGS8r7PQyt4WsBjkmnsRP2EFmYALZzNKBeoTicQ/QEq5Roz/lA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=3A+cdwE9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.67
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010067.outbound.protection.outlook.com [40.93.198.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33454606A31A
	for <iommu@lists.linux.dev>; Wed, 28 Oct 2026 14:52:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33454606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=3A+cdwE9
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gaPn35DsleTPFcFPjjQRuqmL2nHGZMhvPVAQmi81xUEHCyRH/TlVS1I/SRiUvGdJ1ASr3Jjndhd5dxjU+DBGYL87wNT7Yqn9E5XQuYDGjq+pPUp2ePhl9VMrrRbm2z0WyBBt4CZckIxWE4oemzVSrzyN1m9L0EjBpOzzrsTsm2E67ik/y9/wiAn/RRk8zvF/XhVRY39XV8enF8R4SUBEMqiymG9unEHFwiohWqPI4at2qnl3jXzbfDG8L2Mtpdo5wuSrwDAukfTG7vgT1u4Z52aBFq36/Hd9jJ0K5zy+noyRImU5KpehdPesPx7YlM9vuJzu5OLZrdhxdlM6pQqg9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DkyJuoGisNxhzVn7dGv0x9W+B+wfsRZWPVd2wZOiIcg=;
 b=sXAYuJ5gSrmTv4iW1XDTkBmEKzDtAR3hPn1P/r5FXbgChLljQXYfS/njQCUBJY8Jh5JLPQqzYGPgdceWSaaoaPSSZ7rcFIYx4+nZO8YPXrF+V9rZyG2Z5UgY2td2bkr82iIOtOaBkvpbyXnV3b5MQW63llYl9QaTgi2o0YMpeBwZ+FM7OAkNb0pEqM3tR9hB+BnQs6gbokkKoXt6mvsX15C4XVRSMWewzLnqOnXlsOB0ng0EzMeVm27Su3DGn1djDYTN1ZDgIHVKVZ87WviFZNYcOI4xaRp9ZE2lOV5fKlNunSfeeXsB9kXlUAfeE//WUrAZpmOnAXabYazHXXqYZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DkyJuoGisNxhzVn7dGv0x9W+B+wfsRZWPVd2wZOiIcg=;
 b=3A+cdwE992Jk6K56OxB8rLjwJz0kHNQDnyxkYerOUiHzJcIo6du3P5JEy6SQmot+NjP9LSUN44LVXFas7qb4awW4I4IzRcPNwfSW5BO2Yu9FjbT99dw7GoMo2/1UuuakgNuZPXshINP5wTf93grdCPI/GlK1Qwo9FcMjbbcnLvw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 by SAWPR12MB999141.namprd12.prod.outlook.com (2603:10b6:806:4e1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 14:52:24 +0000
Received: from BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83]) by BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83%5]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 14:52:24 +0000
Message-ID: <a9d4b05f-4935-4c25-9029-2b572a31c314@amd.com>
Date: Wed, 28 Oct 2026 20:22:17 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Remove iommu_group_mutex_assert() from
 amd_iommu_clear_gcr3()
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
 Max Zhen <max.zhen@amd.com>, Liang Wendy <Wendy.Liang@amd.com>
References: <20260814104029.71021-1-vasant.hegde@amd.com>
 <20260817135155.GB1415075@ziepe.ca>
 <d5e053c4-34d4-417e-ade5-f7f461f9e426@amd.com>
 <20261027182407.GH1685504@ziepe.ca>
 <63ac9043-0658-4535-b42d-0e29eb37ac88@amd.com>
 <76242acf-e8c3-4c44-9558-2751112fc5dd@amd.com>
 <20261028121701.GM1685504@ziepe.ca>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20261028121701.GM1685504@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0339.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:21f::11) To BL4PR12MB9505.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BL4PR12MB9505:EE_|SAWPR12MB999141:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a1c6357-4487-40e7-0a8a-08df350313ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|261009223027099003|261026140227099003|4143699003|56012099006|11063799006|261022075727099003|261021121427099003|261022105027099003|18002099003|261026121527099003|22082099003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	18qOzX9DFMZTFX+Bg6dqGYfJtxfEfIvefY9RSk8BX+8RjFx5Nj5R33eeegqvMXAG0PLY2NjqC50qQwZGPMymqTnmsNol0jiAC6ixKQm1929p9gdAp+okUDpczIlJBMZN0ZWe7+fvgpe/5t4s08lLlWdZQ+j8qE9ThZ+oVHFgPWyBCs6kl81VQDYNlKzvdMO6UxMYR3oIsnD2aWw1vDYGL4N1QGemXgHZPZy5ZT9O2cgncdytPml1s8RFze6Q6fTZulsRyHnAfkgECOTs+DLGGF//2y/UZiFpaoeelCs5GnhTiL5/xQXrtmxs9p/XtW9szFMvPjTHOseYzWWZXIf6pYCu60vzmq5vAomW+guHB07yewJGXiCZMPIPiLNMsy3Vn0BmnGEQr8oVQA/QQt7XLzxOU6af9ApmXKxIceowX2l+iUIR0SltnC9neAutR17xkz+7inXQtWuJvkmPjPkGwfOjBFLyoUSy+aWLiucozAhiPzUqvz7fcOpqju6q5/fxaa/J52Cfri2nIaS8Q+MMmLOuQ8cEnpNw+SggL9uFvI3Xziqi8Mn+w5DSnCCtIS9PAD35gp+eQmu62m2q4SaSnGd2cL+Zhw01PQCofoQK4io4TobOFKxWbgq5ks0mv4KF2f3d4yazUORImqV0CJuWOfJXc0c6KuoruNM+Ey1jPgA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(261009223027099003)(261026140227099003)(4143699003)(56012099006)(11063799006)(261022075727099003)(261021121427099003)(261022105027099003)(18002099003)(261026121527099003)(22082099003)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UXdsWUhzY2RPdUJPM3hXbUlEOFF5VnovZ0xEVHo1QnVPdzhXUnBkckl2M1NS?=
 =?utf-8?B?T0VNTTF2NnpqUW9Ia2tQdHBNOGFiUjdXQk9wZ0dHbjBaMWJqWHUwT1JKeHRY?=
 =?utf-8?B?eWRCTkp0NmdQKytTK0dWbmJDaUNseCsreWM1SkIrSXhSY3lIM1NlZ1Zld25O?=
 =?utf-8?B?d3V2aDA0V3R6YkhYaDF0YndjbHZ5eW1EMCsyWWtXQ2MzYkIrdnNWUlk5REIx?=
 =?utf-8?B?VnhxK0QxcVZ5aWtqNTdib3pzUEtIanJMUS9WUmdLL2tEYXlSOEQrSHZuNnJ6?=
 =?utf-8?B?VktyVnZ1cWpIT1lUZGF4U3FQQ1M4U3JWNUJrMHYwOEJqaEV2ZUE5YVQ4a2pz?=
 =?utf-8?B?VVUzWDhGby9IK2dyU2ovcnJHck9jVnRidWM4cFFKSVNHN0krQ05vOGV6dEpL?=
 =?utf-8?B?WTJiTEFtSFBuVU94bGZSVFFsTVUrNEdrQ2dKQTI1ZmQ2aTlZaXg4UWZFNTU4?=
 =?utf-8?B?V1FQU1RGV05zd3R1WG03bWVDSFNRN0htTldBL2FqZjBERzdqR1ZQQ3NmUy9G?=
 =?utf-8?B?SEJnNXFQNmdTNWZSZS9XR0U2cm0zY2ltanlGRzI1MjNCZHJTNU5FQzV3VFI5?=
 =?utf-8?B?MjkrUmtRZlpmS3p5bHh5bU5yUGdDdC9uR2UzWW9UV0RPYlpsNFZNWlNTS1Rr?=
 =?utf-8?B?Z2l6Z2lYbllhVSt1czJXSlBKZkVheEdGcUFGRWJQRUVmTWRTTlRpRmU3am1T?=
 =?utf-8?B?QzBZZVM4N1pVMWxIYm1kN2VpSEM3YzFmVER1SFQwUys0bnJpL21KK1NqYjBI?=
 =?utf-8?B?djUzZmgxazFOS2dCWnBOM1RqRy9hbzJjSkRnL3NTZGxhek5CSHRSbGFxOXUv?=
 =?utf-8?B?TEdBQmNUTU9VaE9wMExvTEtzaldqV1JPTFJTbzJTMEJqRDZoeW5EUWNsSG92?=
 =?utf-8?B?V0ZqQWtCWUMzU2xSRzlPSWdHWUZmdXJpSVRGSzc4UXBGRDl2djNZQytYa0Jn?=
 =?utf-8?B?MkIxckc0Z0VxUDlWdzZHU1QxQlZkQ2hSR1grTkROUmVEd1FGaVNibVFyNnNC?=
 =?utf-8?B?NFdPRVovUXdmcVVYYmtTb1BnczFndUVhazFKbnhSRG5EUmdDeENBTFBUcjdn?=
 =?utf-8?B?aHVkNG42bFpCeFAzQUxMckhrTWxiL2M1Wk8rUWtrVHJTQkJUdWJBc3Fka1BJ?=
 =?utf-8?B?dHNSNmxpZHZhOEhvdzZEbkxIWlYvMHVrR01RUmxVWFRTZUdKcFNscW9VbDhI?=
 =?utf-8?B?TTZlTjhJSFBZTE1VaGpVTnFXdDZxSW50SlNCd1R4UGNOaXBMalZKQkRxRVN6?=
 =?utf-8?B?ZXFVT3BKU3o4TG5rVlpNejZXdStSNGxvKzNKZndEams3ZVBHQU1YZ0FhZm5k?=
 =?utf-8?B?bXlTL1NlYnIxT1lDdU00bGs1VkVtZFppL0JybXhwMGRFa3JSS0JYMDVxaUVq?=
 =?utf-8?B?MldtenlvRzlFanYvVWZLd2ZjSW9qV2pwbVRzTFNORWRsUW5JSm1wdThwa2Vj?=
 =?utf-8?B?aXo5VzZrc0kybElFeVJpMkhBcWoyS21KNU5sYzJTWmJNQzlDWEtXd3R0U3d4?=
 =?utf-8?B?SlJ1UDV5RWVycDVZMElLWUxqZE5nVjVFcmhBN1BGbWlKcnJidHNrMkVOSWZw?=
 =?utf-8?B?VDVublFZUFB1L2daWFUvT3h1NXlFWG5mbEJ5YUc1TE9mWTNHbGswRmFCaGVB?=
 =?utf-8?B?bXV4M2U4U0NHL0VDanljUWhFUHpyajdwQ1l3R0pCNzdTR3VkUDhwS1V3RWh5?=
 =?utf-8?B?MjhrOTArTTFuK0N6YmlzQ1lxcUVqNlRkQ1JRd29CNEZjSEtLMXd1aHZnd1B0?=
 =?utf-8?B?N2tIdS9IUzRpMmlZV1piZHVqckJkWG1EclNhbGxLYzJqbXlhVkRtbEhPb3g5?=
 =?utf-8?B?YkJWV0E2WTZYNjZHN0JFb1RwNnJ1eDQxYWhsWXJXNlBtMTlxSnorNDRQMURQ?=
 =?utf-8?B?THllNWkrazFocm5tTjhTZ2tOTmx0SkRhbS93ZFA3bWZPTmFZQnQrVUY1U0NG?=
 =?utf-8?B?TUZ3dFF5c0lHcWZkclVkWTBMSndDMytEYXlwU2NjbncwdS9SNEdSSU42eUZq?=
 =?utf-8?B?M3BqK1dJZ0JBcjZwOFFQekNIWUFyK2JXa0pLMGV2RVFaVS82ZDJJRkcxbjZN?=
 =?utf-8?B?T1FzcE9SaGd5aHlqemJDTjJJWTYvMWZJak5TMExPeHgrcTVLbGZxMnhhYnNp?=
 =?utf-8?B?WUpiVTdRclUxRGxEYlhzYUcwSzVIMWpKQndIdUI0ajRJcGExNGpDMmcrVEZ4?=
 =?utf-8?B?VkdLQUJOS2FZOWdFN0k1byticG5hNVZyWCtMT0FEMVdqbmc4MTJuZDM3b1V0?=
 =?utf-8?B?UnFSYThwaXNBT01Tc0xZdFV1Z1cyN2NIZ3NSUkdycmR0VFlwU050ZWE0QUZh?=
 =?utf-8?B?REVDK3JlM205dGFkaVNYdE9MSDZ3aFlXZnFJazgyMXk2dm83Q2xXdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a1c6357-4487-40e7-0a8a-08df350313ac
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 14:52:24.2534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UOVj42e6+3qMIvY1n0vctNfJnR0mgirghFyTm2vbpZo3eJ1OLfvs1CxE9fH0gDgxONF7n2EnMlim9SNnH/WElw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999141

Jason,


On 10/28/2026 5:47 PM, Jason Gunthorpe wrote:
> On Wed, Oct 28, 2026 at 12:28:06PM +0530, Vasant Hegde wrote:
>>
>>
>> On 10/28/2026 11:42 AM, Vasant Hegde wrote:
>>>
>>>
>>> On 10/27/2026 11:54 PM, Jason Gunthorpe wrote:
>>>> On Mon, Oct 26, 2026 at 06:29:39PM +0530, Vasant Hegde wrote:
>>>>> Hi Jason,
>>>>>
>>>>>
>>>>> On 8/17/2026 7:21 PM, Jason Gunthorpe wrote:
>>>>>> On Fri, Aug 14, 2026 at 10:40:29AM +0000, Vasant Hegde wrote:
>>>>>>
>>>>>>> Remove the iommu_group_mutex_assert() call from
>>>>>>> amd_iommu_clear_gcr3(), since PASID teardown via the mmu_notifier
>>>>>>> release path is a legitimate caller that does not and need not hold
>>>>>>> the group mutex.
>>>>>>
>>>>>> Why doesn't it?
>>>>>>
>>>>>> Right below this line is:
>>>>>>
>>>>>> 	gcr3_info->pasid_cnt--;
>>>>>>
>>>>>> Which certainly needs the lock.
>>>>>
>>>>> yeah. I overlooked it. Its part of dev_data and domain lock is not enough.
>>>>>
>>>>>>
>>>>>> In the ARM driver this async release notifier was pretty tricky to
>>>>>> lock properly. It just updates the equivilent to the GCR3 entry to
>>>>>> make it disabled and doesn't touch anything else. This is locked in a
>>>>>> way so that concurrent domain detach doesn't face any races.
>>>>>
>>>>> How about sva_mn_release() path just cleared GCR[PASID]/flush cache and then
>>>>> iommu_sva_unbind_device() path (amd_iommu_remove_dev_pasid), decrements count
>>>>> and removes pdom_dev_data structure. something like below?
>>>>
>>>> One of the considerations here is the release of the SVA should not
>>>> trigger errors from the iommu driver if the device continues to use
>>>> it.
>>
>>
>> Actually we will hit IO_PAGE_FAULT if device tries to do the DMA. One way to
>> solve this is to have dummy page table. During sva_mn_release() will switch to
>> dummy page table instead of clearing GCR3[PASID] and then in
>> iommu_sva_unbind_device() path clear GCR3[PASID]. That way it will not produce
>> the IO_PAGE_FAULT. Does this makese sense?
> 
> Yeah, ARM was going to do something like that too, but it turned out
> there were bits that disabled walking.

Ok. Let me run some tests and see if we have dummy page table with Present=0,
whether we hit PRI fault or IO_PAGE_FAULT.


> 
> When this happens PRI is still enabled, so we need clean logless PRI
> not-present responses.

if dummy page table doesn't work then should we skip clearing GCR3[PASID] in
mn_release path?

-Vasant

