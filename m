Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2064.outbound.protection.outlook.com [40.107.100.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A300248F58
	for <iommu@lists.linux.dev>; Wed, 30 Apr 2025 11:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746013949; cv=fail; b=Ic5raVSHLExaucMbKslFKFaO6fINGTWIDIdboEO+dLFibBgZbjHxBF/hXXwGLuGyVN+D3Tee6arNLhLo+BWGF3sU9Sn68d/fdZN6rUi4aVFfLWgicbo9grOUvc6f4Zs3qB2yGt3KbKplnPZN8KKxUsb94+dPWak321vLdRWmXUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746013949; c=relaxed/simple;
	bh=8rzAmVip2gWIvGj/bZ7KYgfIhpJx790xKlUSoO+3LFo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=htuDJJ6THs/MczdSOC1NREVYUoUMp20Zv06pc6yEjkSt/2dJsE9rVml8nMBA9yX26r2CPi1R7pf1zYVHMEwFD4FaRSlvenJ59piBrBtXy/R5Fk59velMMwnJ3MAUf07VNAxC51oMmF/VZW6gOVB/qz9FpDKfmMw189lAgswokwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Xq3Tq/uq; arc=fail smtp.client-ip=40.107.100.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Xq3Tq/uq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PCIAk3jUTmKWdWSRuH9qfWkbtOkjBRzLf8jYREkIhcT+w8U2rfqVCOwwRKoo+APjmDlltuyN94KTn7q8ULbqfYeQD/ga5DVIRxgJ5Nw1ZFQ8JyqdHCV7pTkGuKmtX0UKfjLApYiBs6rSbRtBNqma9xVavOgwswanm82t6jAwbETmfjqXtwYlAjMDshY+uI8HxQn/wnyCOuF18DrHOIt6nTdZY/k0nbLIbq2PBrBraypTgfmXwTwHa9xaUi4hL9l4AB6zxTPdYmhizHhEOBXXlhAPLViih5+JccRvkOTnLv7BxmwKsFWdjC7BkYVpjJknsfP1hpOPaqaNSUial4NRbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JNC0n5zTFMdh+4FX9TA0K8pD7q/KE4mrReJdEp9s7j4=;
 b=RX+dNQ4gI4cqvIYl+g+tyO2Y7fGdRT7n2cEfpvpZ+x3RhXq0BEHAV3VICvCy7cG/mMGa1fzTdpiFk4UWhRAH/8iCPd2wNZ9mFBf2/cQ0LYYIXu4gJ1m8iOnZ/zZ7X/Ett5UisB8OVqIddB/hRTq4oHbnQP3m3bKVoRBRC49lmok4dMCr0OFj1Jgrd6kDKLyveDrNLbg0dGgvB/VrrXHMhgS17KtJ4WribPi8A6wB1wtLHRrecQAikNf3vjCdeFQArzlkYUjX2rivNmXUwYBE3ms8GBl7vlP2gvHUr2QvInGhMwrtHu8IBfBJfNBhJ1q1QkHfr+JKif6qWOD4HlE7XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JNC0n5zTFMdh+4FX9TA0K8pD7q/KE4mrReJdEp9s7j4=;
 b=Xq3Tq/uqsCowIhJbrzgWxpvcT4JyfH1PK0HkkLeySDV+ft9dGU+GWZjRsK0cfm9WiSLQ8tIGjIUHHrIB58lz3LzkOMdkJU8KkHqCY5lTu7Exs9QEmKYh5QEmeFBCTGmU+zTP/fbss495FTViKVufHB03tOVsHuzbmlKRyrzQGbM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SA3PR12MB7923.namprd12.prod.outlook.com (2603:10b6:806:317::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.31; Wed, 30 Apr 2025 11:52:22 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.8678.028; Wed, 30 Apr 2025
 11:52:22 +0000
Message-ID: <44aa28c7-69fe-4073-bd61-6aca57203c64@amd.com>
Date: Wed, 30 Apr 2025 17:22:14 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iommu/amd: Add HATDis feature support
To: Joao Martins <joao.m.martins@oracle.com>, Ankit Soni
 <Ankit.Soni@amd.com>, iommu@lists.linux.dev,
 Baolu Lu <baolu.lu@linux.intel.com>
Cc: suravee.suthikulpanit@amd.com, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, linux-kernel@vger.kernel.org,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 David Woodhouse <dwmw2@infradead.org>
References: <cover.1745389415.git.Ankit.Soni@amd.com>
 <6282a5c349812a311a67a8522dc5e4aabfe3ec3a.1745389415.git.Ankit.Soni@amd.com>
 <596ed125-c995-4e2b-824c-b7929c852754@oracle.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <596ed125-c995-4e2b-824c-b7929c852754@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0124.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::12) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|SA3PR12MB7923:EE_
X-MS-Office365-Filtering-Correlation-Id: 15fe452b-1090-4544-16ef-08dd87dd778d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dWYrT1ExUWVHRk0vOVpia055azVFbEhqK2hlU3ZQTkgzM3JtR2Jvd0lMc0JP?=
 =?utf-8?B?enlFYlBGcmRETkhuV2FBeFNGRGg1V0xDT0pxWFlFOU5RK0wvUkJsK051cDgw?=
 =?utf-8?B?QzlMTGNDREZrY1M3ckg4VnFoZUIvMnB2NjdvRGplUlQ1bEZtQUllWDVibDBG?=
 =?utf-8?B?ZGxyNFo2cFZBZUQrS1hpd0QzaGFJV2JNSk0ySjd1eWpYL2ZETnJNQ0VveGoz?=
 =?utf-8?B?SnIwa2wzWFJLR3pVZHRTQlVPVkpZc1gxMlMrMUQ3Nm1SVitKaEpwcTZmVzIw?=
 =?utf-8?B?dHQ4WUFHcnM3UXR0a3FuS2Nrb29UZ3pGTUp1UWRDV3BoR2F6TytGb2RUZUFh?=
 =?utf-8?B?TjdzM1IxTlRtelVrUEFGMWlSTE43b0MvLzRPaXJQWkFsME5nT3daVElJSDN3?=
 =?utf-8?B?UVVHdnZEYUwzWFVCYXFseFE1dldXYmlTd2pRR2VrNVU5NENpREpSS2VOZnR4?=
 =?utf-8?B?aDNOcFNVMTk0bUcwTkw0Q0FWQWxSVmZEWDB5bkRQbUw3MFlvK1Nia0phcGdP?=
 =?utf-8?B?UlIxWmZ2QkZjc094NktTRlJ0S0FwNXI2ZFZuTndWUjNhWlJHakE5RXFUOFRX?=
 =?utf-8?B?OFhmL3V5RlMwTlJULzVDaEhuek1tN2Q4c0d2NDV0WGhFNjBLNE5kZ0doL3hD?=
 =?utf-8?B?WnV5TjVtNm5wWmdZY05JT29xSVp3Ulk3WUR1enNyV0RFVWFzbmNEdEttaXFm?=
 =?utf-8?B?cTFCd0dQUFhPQ2duREZrMHQ4UGlEOUdQUXZBZXpLRmJESGREV0VHcFJSSjdM?=
 =?utf-8?B?TmpqdzhDcUppU3ZmRlBtNVlvOWkwRDAyR3V1RVBXcVo5YUVVcGJ4NnJ4L2h4?=
 =?utf-8?B?c2thMXRpTERLYWxlQzVBRGJ3U3RmVytwd0lRbnRDYmxnOGZ2bGRDeW9IVVJG?=
 =?utf-8?B?QzRTRUs3bG5uNXVrT2RWSWFDOEgrdzgrZWp3NTZIRERiYU5WYzJYMG9jeFUw?=
 =?utf-8?B?Y0pUOXhUSDJUdHQyUWl0Z3hpbXZYOWg1QXNoK25ZUDNkbjFlcjQyV1ZlaVJL?=
 =?utf-8?B?QW1KU0FBZXBFK21SVFpwaWdYQ1BjZGFZVGNEL2F0UTE1MHpKZW4yTmthRXJC?=
 =?utf-8?B?Vjl1YnJaNklrRlFXSFlpRkZJbEFnRmhNdDQwdWtqZ3VkNGNjdUlWNWFFcjhE?=
 =?utf-8?B?elljYVZ0UHplQ290alNaMWs4WFF6VVlmZWpOOGhBRnpHcTh2NG95by9yL0tC?=
 =?utf-8?B?U3RRd1RMeVZzQVhSOFdDOXl5MXRmazRYb1c2TzlDZU9obG05d2NXYzkyNGZ0?=
 =?utf-8?B?ak1oUFJIR2xwUXNTeENJbmF1dm5xWlhaQnpJSDA4SFNFYlUwaFhiRUVtbjNB?=
 =?utf-8?B?SVA3Q2NYdHJQZTJ2NFdzNTFQdXo5ZlRvazdzK0FzYko4V0tVdXZWa0ZsL2pR?=
 =?utf-8?B?U3Fnc3l5Qm1OZGNUUy85RzJuUUtEbGdOQjNkb3FxU1ZjQXpaeEpMYWhGV0VQ?=
 =?utf-8?B?TGF3SWVNVk9CWkF4N1V5ODRwWWNxbGY3UGNTLzNtMlNBZU1jNy9SV3NZMUZK?=
 =?utf-8?B?V2Iwd3hUemF4TDY2WnJPNHI4eXZvV05vV280ZFB3NlFZalpVWnVxQUF3ZjJ5?=
 =?utf-8?B?cUZzamtTd2NFRGZwekN4MXV6eEhCakNHZ0VGbklSY2tlRnJkM3UvK2dnL0N4?=
 =?utf-8?B?a3E1Y3YzSExpVUpLMFNMTmkvYnhMTzJudWttYnRwSHFvUm85UFhUS1hiOVhu?=
 =?utf-8?B?anE5a3JDVkpkSGNCK2xMWXJHYms1UVU5R2QrbWtCdk4zcno3SjV4WlNJZVVu?=
 =?utf-8?B?YzBLQ1JjSHpjYUV5b1B4eDBacm9zN3JIbFVUZ0RtY3NaSnFYRjNXQWV1V0tZ?=
 =?utf-8?B?dVd3ZHliNE1PNUVQZ1VlV1J6aER5bS9kdGErS3N1NDl2bjExUXNSenQyZERN?=
 =?utf-8?B?L1NqWEFoOWRnZE10dExyL1JJTnUwR0xMcEN0YWpERFBVZXJ0dmtENDA5QkVx?=
 =?utf-8?Q?Fl22Xaounpo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VjZWQzJJcm9yVGVQM2s2dEdWSW9kMGRLdmZRZ2V0cUlmK09iSmk2RC8yZzJN?=
 =?utf-8?B?MzdSUHBhcXBCZkZWZlZqUGI5Ui9xektjR0RNclc3Q2p5VXFRUGEzZ0pwMFlI?=
 =?utf-8?B?eW9DNGZGbDhFdzBSUXNnTW5haXFiK2NUNUlWZyt3QWhoS25OTzdLeUhOMnhB?=
 =?utf-8?B?eTNtOUVpazcvZVRRTmdkTVhSQjVNNnR2ajJaSDdjOG9MZzlpVFRiRzRhQUcy?=
 =?utf-8?B?VUxEYVc5SVFtaEFjNE9FNGZnWXg4VGh3eEcvYjN4VGhleGp4TGNnY2Q0Vys5?=
 =?utf-8?B?WVZtNUp5UHZldE42Y2l3c20wdXpwQmMwS1ZJTk1nVTE5V3JJazlHVlVZMGgx?=
 =?utf-8?B?bVlnSm5tVUlKSEs2TnY3cTN3UUJVK2JocEd1TmhQa3RLSFJqQ0hDZ0oxWlhv?=
 =?utf-8?B?a2k1WmNyM1VhRTA0TDNjTlVtTi90WmZKMDdYOWxlSXRlZkhMc1VMVVo2ajA4?=
 =?utf-8?B?U3EwejZoQTVEU3lUYytvWitLcWp6b1NNNHVxUndKOVlVbzUyYWdKUXg0T2hE?=
 =?utf-8?B?dGRkcllxWS9sR2duaXFDZTBSeWhYaWZ1LzBkcWRpNGxvMG5vbER5WTNtVnEv?=
 =?utf-8?B?UnhTQjNxRTlkamxoeUZCaFF4NDVDRGhWR09tdHU5YTIyRnlhT0RSU0IxLzhi?=
 =?utf-8?B?VVUwSklYQkY4RUI4aTEyZEJ3QmZqbERoTTRrQXRZd0oyQmxvUlpCUFk1VFFY?=
 =?utf-8?B?aUZFaVhsNmlmdlVqN2llaG5qckJXTkJLZnhxL3JJUjNSd0tVUTFWaXBVSWgw?=
 =?utf-8?B?TXlOTUl6d1lrM24zc0RhTmhZNlVacWRhQ0JxZEtMWm1Cc1BDWkRUbzIwVEhl?=
 =?utf-8?B?TklFUGRPZkJrMVc5SnVXYUdXV3RSVnJEQmdZZDFRL0k4RlAvcjlUb2lTeFFQ?=
 =?utf-8?B?UGlBSmtCeFJtMlpyZnZnZ3FveDVNMGgxSS9FYkZWdFZOUmdFdngveE90Sllo?=
 =?utf-8?B?SWhESVZNMGR6RWxYeUlvWHc0eDhoZllFUzFXRW1lTUJvV0ZMcW8zNWFKaklN?=
 =?utf-8?B?N2xKaHV2dW8vTXVDQ04zVmtNUjUyZjlmd0pNRW5kMHBwbFpkcFpVTTJDNzhL?=
 =?utf-8?B?cnJvWnZ2YVJBaGQxd20zRDROZXZQNjBZUVhwVmE4bHkrd0ZaUjBhRThUYno0?=
 =?utf-8?B?cU51VkZHdzJEQVUybHhweHNZRm9PNm1MVFBkQTk1RUoyVGw1bUFpMkQrbmR6?=
 =?utf-8?B?Wk5Xenk2UGpOeTV0azFQcFdSWGl1NjlncGF4VUhUOEh2RWt2RVZVc3pWWEpU?=
 =?utf-8?B?WitiMncrWkVIRmRWYytLTk5mNlpzQXVYRnZpSkhrZUNJc0xSRnA0TngxRUpj?=
 =?utf-8?B?NUhPRS9aSlE5Mk1uanB3L21CbGNnZXRNTGlieWNod3E4b2plMmRUZVlQZlQr?=
 =?utf-8?B?ajJPc2VCWVN6V0F5endiODVWNzJXS1BzOWpaN1gvTjhzdHk4ajVQbWNtbnRZ?=
 =?utf-8?B?WStncXhYYW9FSzFXckVsUDFBRGFDeVVERlArTG0wL1E1KzNxZGR5MlBiSXl4?=
 =?utf-8?B?T0xsK1pnTGFDVnlOVVhweE9LMWRvdHVoVmZPSjUvMVJjcVdHb0l2bVM4Z2tx?=
 =?utf-8?B?d2lHNlhxaFMvL3FXN0IxSm9pSG9nMWMvdUNBZFVDREFrNzBVcVpxcUpteEl1?=
 =?utf-8?B?N0Y1VUVnb3JLc3pFUm5BQlFsTWJkYnZnVmg0MUZaZStiR29Mc2dlZXZraHZI?=
 =?utf-8?B?ZzJQQVlIczk5NEkzVzUyWHUxTVAyS00vanZxQUEzMUlDZHNjb1BRWE80YnY5?=
 =?utf-8?B?QSt4VHZIODl4ek01U0VIRk5XQTBia3NEa1F0VUhQTkNyNnR2M1MyallPMlBi?=
 =?utf-8?B?S1h4TityLzZHYXZXZ0VHSGFtdDQwdzhVeHozb2FTSWZ0cXFLRTVUOE9zTzNL?=
 =?utf-8?B?ekhnUEFvSStPWWZjT3ptMnZ1V1p0d3U3Q3JUS3J6MUhVeTkyQWlNY3VqUjZH?=
 =?utf-8?B?M2tjbXNia1BpaVhQLzY3L0Q3L254eGcyYmtSL3IzNmpCdXVxWHV0dXFnd1Y5?=
 =?utf-8?B?b2N4WVRPeVY4bnMyMDF2VGowOXhuV1JjbTZjeElSeEh6ZlladDhqNU82Q1Yy?=
 =?utf-8?B?akk0K3VjVmxEK25aYUR4bktMNVcxa3IxRmJIdlRxWmNTMWZsem9qVzlZb21w?=
 =?utf-8?Q?S3y9Dk1HLKat/9VKyxC5xJsOj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15fe452b-1090-4544-16ef-08dd87dd778d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 11:52:22.3092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +HyACFQTjLVw0Ur2+mZB75VEEQfVrexodl8fX90x4i65fntm7oWWxcqUVBInME7fx7VCze05VlXGAGpNqp0U6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7923

Hi Joao,

[+Baolu to get clarification on intel driver behaviour.]

On 4/24/2025 5:49 PM, Joao Martins wrote:
> On 23/04/2025 07:50, Ankit Soni wrote:
>> Current AMD IOMMU assumes Host Address Translation (HAT) is always
>> supported, and Linux kernel enables this capability by default. However,
>> in case of emulated and virtualized IOMMU, this might not be the case.
> 
> +Alejandro as he is filling that gap
> 
>> For example,current QEMU-emulated AMD vIOMMU does not support host
>> translation for VFIO pass-through device, but the interrupt remapping
>> support is required for x2APIC (i.e. kvm-msi-ext-dest-id is also not
>> supported by the guest OS). This would require the guest kernel to boot
>> with guest kernel option iommu=pt to by-pass the initialization of
>> host (v1) table.
>>
>> The AMD I/O Virtualization Technology (IOMMU) Specification Rev 3.10 [1]>
> introduces a new flag 'HATDis' in the IVHD 11h IOMMU attributes to indicate
>> that HAT is not supported on a particular IOMMU instance.
>>
>> Therefore, modifies the AMD IOMMU driver to detect the new HATDis
>> attributes, and disable host translation and switch to use guest
>> translation if it is available. Otherwise, the driver will disable DMA
>> translation.
>>
>> [1] https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/specifications/48882_IOMMU.pdf
>>
>> Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>> Signed-off-by: Ankit Soni <Ankit.Soni@amd.com>
>> ---
>>  drivers/iommu/amd/amd_iommu.h       |  1 +
>>  drivers/iommu/amd/amd_iommu_types.h |  6 +++++-
>>  drivers/iommu/amd/init.c            | 23 +++++++++++++++++++++--
>>  drivers/iommu/amd/iommu.c           | 13 +++++++++++++
>>  4 files changed, 40 insertions(+), 3 deletions(-)
>>


.../...

>> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
>> index be8761bbef0f..0ebc264726da 100644
>> --- a/drivers/iommu/amd/iommu.c
>> +++ b/drivers/iommu/amd/iommu.c
>> @@ -2393,6 +2393,13 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
>>  					     pci_max_pasids(to_pci_dev(dev)));
>>  	}
>>  
>> +	if (amd_iommu_pgtable == PD_MODE_NONE) {
>> +		pr_warn_once("%s: DMA translation not supported by iommu.\n",
>> +			     __func__);
>> +		iommu_dev = ERR_PTR(-ENODEV);
>> +		goto out_err;
>> +	}
>> +
>>  out_err:
>>  
>>  	iommu_completion_wait(iommu);
>> @@ -2480,6 +2487,9 @@ static int pdom_setup_pgtable(struct protection_domain *domain,
>>  	case PD_MODE_V2:
>>  		fmt = AMD_IOMMU_V2;
>>  		break;
>> +	case PD_MODE_NONE:
>> +		WARN_ON_ONCE(1);
>> +		return -EPERM;
>>  	}
>>  
>>  	domain->iop.pgtbl.cfg.amd.nid = dev_to_node(dev);
>> @@ -2501,6 +2511,9 @@ static inline u64 dma_max_address(enum protection_domain_mode pgtable)
>>  
>>  static bool amd_iommu_hd_support(struct amd_iommu *iommu)
>>  {
>> +	if (amd_iommu_hatdis)
>> +		return false;
>> +
>>  	return iommu && (iommu->features & FEATURE_HDSUP);
>>  }
>>  
> 
> It's strange we seem to somehow have host translation disabled, while it
> advertises other translation-related features like the normal case.

I think even if qemu advertises those features we shouldn't hit this code path
as probe() will fail and core shouldn't try to allocate domain, etc.

I was extra cautious and suggested to add this check!

> 
> In any case we should probably follow Intel's example (which does similar thing
> to HATSDis) where we only call invoke IOMMU groups
> iommu_device_register()/iommu_device_sysfs_add() with DMA translation enabled?
> That should simplify most of the patch as those codepaths are not reachable via
> kernel/userspace? Unless I am missing something ofc
> 
> See also commit c40aaaac10 ("iommu/vt-d: Gracefully handle DMAR units with no
> supported address widths"). I am not sure what else is the closest example here
> besides intel-iommu equivalent.

@Baolu,
  Looking into intel driver, my understanding is if DMA is not supported, intel
driver will set `drhd->ignored` to 1 (alloc_iommu()). So iommu_is_dummy() check
will return `true` and hence intel_iommu_probe_device() will fail. But it will
continue to support interrupt remapping. Is that the correct understanding?

-Vasant



