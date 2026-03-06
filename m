Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010020.outbound.protection.outlook.com [52.101.201.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE25D3446CE
	for <iommu@lists.linux.dev>; Fri,  6 Mar 2026 09:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772790920; cv=fail; b=sRc6Dc1EN/fwpHKvfuZiu+uOr2g6Gg3zMc5hw18W3nWiROoXBTgbm0aXDdn/FB25DfTv8IOxPuYfspYsBsdTnBzxn7SrRa4ChWdjRx0Kw/ewI7SiuVQ5n66MNsmQUwuWsZ2s2nMMWYPfvsOjFdi5UHyPoU/D+FzvgazHyBGTSFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772790920; c=relaxed/simple;
	bh=JMVsNFcLwbwNnY0JK7vQg2814DpdevHbQNejSHy7q1o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GccmKwUBv/ixQkgvkNZO04DilcgvDv6uHoFsXfDdDu/UtxStot69qWQFLr/REOhJ289nS3ShuNw9AnhE1Dl6L6OEzAPCBz04ukgdO7i/nKDbFsfT4gmL9osfA1TYgLUFGZ5unYgtCFEGieHivWtzpEJWSCS0I2AboHwDeCFLvlE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LKwA7krD; arc=fail smtp.client-ip=52.101.201.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LKwA7krD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lh9DxOQ3SXTGLSAulA0+HVox1Lj/qB/ENnYDP1loIykq9lgpCwPszTxOu7+6+LdoJilQ+d5EpFQ/gu2D7B8XOl6PrDDDxLgADfUcHecMm4SwBrw4vjUKP5Zwz4EpLbBJtP2PVEHl22/kgNUxFHmpf7HaAPsbZ0m3NcdIuLv7cLXjc28FKHE7qHSyIK5hV4PT9j8Jk48hNBOMaRGSqtzIvlZndRXLwpczs8bAR1ZSlPTKtRSHzZS3kngJP864bVDeJjzFWdHdKKx/gLPbYVG7I7LAVUfH8aFPEFhWilwIq+TVvtSuy3sYNyQMPRGOShXbnsQ1BXEiqn1roaIeDk78Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4C3hSSV5bvJuV61aLG/i82g4fN6aWXyw0SHXqs7xGE4=;
 b=in+EwzgUgoFXEFETIKdz1d9cHW97e0FXl/ZJsf484IcP+RT0e/JRXTr0IqKM+2j9k3+48dFxMZPna2UuoJDZQ3LEYrME91NgMkQJFqG32Ci4Ze+uxMckXSPo5xZbKB8tGegqWAW22UvITgkTA+7hKi9K3EgXKE/YvZwd1j0zBiwg8TILQD5v6wzg0U5I/OK+DxldmkzfvXS8HH5lHElGCkk7TCOipKEjLsRoP/82w5SNYRhzuit2zHkq8kBGgox1Hsmcm3EgsLnH+YVNG9du63rObA+rO2Wa/arZ+tVNGBQYo1frxxb3Nb+iKjh4MthQEPcDvxWPl8W1PNEv6mXjjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4C3hSSV5bvJuV61aLG/i82g4fN6aWXyw0SHXqs7xGE4=;
 b=LKwA7krD5GOf3BwrJGX/A9+doFJaNbH6PC+nnHkAGZrvhO4iMhSQOorx5aAnhd9FZgB7yNLAxonQs6g+jNKsF1ksY8en18tFJVWmW79X1Dvsm8Fyn0MJO20yQxPoRn2PHOxop5rIfZBUA/aF2jZXejlti7uEp0W5FfKf+dIS4us=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB5761.namprd12.prod.outlook.com (2603:10b6:208:374::6)
 by PH7PR12MB7916.namprd12.prod.outlook.com (2603:10b6:510:26a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Fri, 6 Mar
 2026 09:55:16 +0000
Received: from MN0PR12MB5761.namprd12.prod.outlook.com
 ([fe80::b0f2:27be:4ba6:3288]) by MN0PR12MB5761.namprd12.prod.outlook.com
 ([fe80::b0f2:27be:4ba6:3288%4]) with mapi id 15.20.9654.015; Fri, 6 Mar 2026
 09:55:16 +0000
Message-ID: <7ea88734-c1a4-4876-840f-1f27491013aa@amd.com>
Date: Fri, 6 Mar 2026 15:25:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] iommu/sva: Fix crash in iommu_sva_unbind_device()
To: Lizhi Hou <lizhi.hou@amd.com>, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, yi.l.liu@intel.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 baolu.lu@linux.intel.com
References: <20260305061842.3953885-1-lizhi.hou@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20260305061842.3953885-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0205.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::12) To MN0PR12MB5761.namprd12.prod.outlook.com
 (2603:10b6:208:374::6)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5761:EE_|PH7PR12MB7916:EE_
X-MS-Office365-Filtering-Correlation-Id: c4e35387-1c27-4d3c-f4ea-08de7b6677b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	/pwQTwwqnWJdZsxq7w0eUsAUtuXOYgCd/eb3pzGPDLLRnhw2mdDAIh6M/o6ZSloT2ynp5OIPN4KhI8VatXvefMgdzG2FgOxTSMGCN/L4eDAUvp+AeHEbSRQkOgtzsYQ4vnhNVP8HVfMsiv6QkjzO6ccN4c2ebhqslwceuvA9NvaPUbEXidlDxkDJAo/1VP+Y4Lz0O/0+tle606HTFq/zSW9+DXkDViksl2KH/usq2zd4W7PnKTirSQetJiju/fB7PDDE1V9q9/RBxpW+RcCd9tVG4cozVb4wW/n1CH4DLiMzLeOe5UPXAe2XxZpxhIiaWtqhrbMIfxPVJGV96GKPlBTPlwGFfOUaXUP4azi6LnQjEuVYWwujRG2cDXCpy2ACT6SpoFUWQH62sPWY3C0vixfYZE1E/9a61tgvnHe97XYqnaRd7PkvLvK0A/MWHHUw4S6sUJed0Sy7HzUve8TN+PFwPaL0TBHbwAXdR4IgMERuc3ct8/KVxJULWUT2qOsOAvHF2vAZX5IZAX3rLXBpcsbAoBebOe1KlnGBl6kxd4uXEj2ja6e5hyc6oQwnrE4ukt672U6aXrr69aBqFg4LU4FTXVtIdYk8DmycB4opqR0VtgqjrHImyz4hw1yhH3lhRD99uOweHb49U+5Ln776jJt0Vb/iAL9rr0EyYSgn612JnSYu+sar8umZpyND/DJJQAUpKBESUOrSPNx/noFlOKsv0R6ZOfgWO/+N0U7hgUU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5761.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MnJRS25yWDcvTVdaNkt5YVRGVU1CMGpDWTdsSlM5SFBRZStzZHRHM29oTkJY?=
 =?utf-8?B?VUVTZHRvREpwbUM2dkE2UWQzQzMvdlVMWEIyOXFydVZkcTNOa3Q4Zmc5UzRE?=
 =?utf-8?B?em9qNzR2T2wydFVaMWxpSkZWUDNQaGhndlR6U2U2Rkt3S0RBVGJpazc3MFNm?=
 =?utf-8?B?UnRjVS9LTk00Q0xJbUxQOXhrNTUxSWZoUS9iYWZqdWIvcnVWTDdpYmwycFFr?=
 =?utf-8?B?dnpNWEVIRkdtMXA3WlE4THlWdkhSMlM5emw0UGtxYVFSbng0dUJUOXN1eng3?=
 =?utf-8?B?bkdNSFl0c1NyKzZrYnFKaGdJKys0S21jcWZNTzZ4d1BqcUw2aHJTYkdGeXRn?=
 =?utf-8?B?cFd6elZlQll6R1dHNWdPcGw2cmJVSm53RGlGcTh4dTdBb09NcnIzMHFOeGlG?=
 =?utf-8?B?TE1HOEk0MktRdXBiai9CRmR4dUZEMXhlK2dKOEVMZG9SY3YvRWtIQkdlOVQ1?=
 =?utf-8?B?Z0RaSmptaUpqaUNoMGNGYWhwTXJpSzJzcjNSM1cvcndyUk95MzFZNklpaVRP?=
 =?utf-8?B?QzFYOVliOElTbFBDUTF6S2ozKzJQb2ZBTDJoaVlPK3owMC9NNFk5TVhvMlh5?=
 =?utf-8?B?TXp6MTB5YUcxRlRrZWZ1Zlc1SDBObE5UZ3AwZk5zWEdwV1kvY2Z2Mk84Wnk1?=
 =?utf-8?B?bmcxWlZQNVpONURweEg2MnltbHpVa0tyOFV5SUlJNEtQSjRCelZ1cWVWTUdo?=
 =?utf-8?B?RzBvc3A4UzJCL2RNbzBVaVlUTUZDTVFERi95cHhUMmR5N1k3UFNieVBaRzRO?=
 =?utf-8?B?Z25VRmZGL2ZlNERQb240Q3JtS3U0cmdDd242UHpIUUREL0J5NEJmU2cxcEhK?=
 =?utf-8?B?V0JsQkp2ZXZCSm5yUmZtWktyTnpNU3psZ2pvKzA4WnlXZ3hVY3RxVUd2VTNF?=
 =?utf-8?B?SzFlY1dVVXpLdEtSc3RMRFVWS3JuY1JVZ1VXdjRRb01nL3hjYldaLytBUHh3?=
 =?utf-8?B?UkQzT2RETE9YTnJzMk83cnVQT3g1UUVoSG5XZnJoeVpBQVhSS215elJJdG4v?=
 =?utf-8?B?ZTU2Tjl5aldMVnJoV0ZBclZ5Yk9WdlA4REdpZ3BUM3ZFaWhrclRyNUpLY1Ft?=
 =?utf-8?B?eEZNaGU1aEJiNTI1RDgvcHZseC85YzFOL0picGhGZC9hdllnRXVCZzRHeVRl?=
 =?utf-8?B?aGRBT05qem14VVg2NkJFM0R3R2p4cmtyQWx1T3NwR0k2T1hlYm9wRVI3ZG9n?=
 =?utf-8?B?a1dvcTNHSFM4clUrTkt5S1l1MEIyQzdqdHFaazVkaDF6azJvbUZRZlhXRWVt?=
 =?utf-8?B?TGZhY1ZwL3RkMW8vRWprU1pZSUxHbkcvazdCM3RyNlIwQm5IdmtwTlBRSXpQ?=
 =?utf-8?B?K1RXcmRoOUNWZjZONG5BV3g2RUZjcnhxK05ETXMrNEgvdjVUZDFTV1Jzc1Bu?=
 =?utf-8?B?V1NxS2x3K3k2S1Z3MmRWWmFNUUlML1V4NWNMSXIyejFFdHBFY1JOMVNhL0Rn?=
 =?utf-8?B?MFNrTUJZRnl1bE9hN09WL0pVdFhBaHVtVWl0TUR3eUdpK1ZhWnpTMFVGK29C?=
 =?utf-8?B?NXFYZTBvLytOanlrb0g1M0tOR0JwbFlTTytqQUNsdTdPeXUrUzN6SmNsK1dV?=
 =?utf-8?B?K00yUXBCd3NkVTlLTTFzRjh4L2o4eFRaQklYMkN4a08vVE1sK05IbUxva29R?=
 =?utf-8?B?NlpadWYwZEdVSHUvMXUrNmRCT1VYNEg2WG9PcjkyN2xBL3puWFlubmtJalcv?=
 =?utf-8?B?eVJ3aFFacnc2Wjg1SnZtNmlpMFRTdmVVSTRxL3NMY2ZrWDgwKzBia0JEMXQv?=
 =?utf-8?B?OVJ1VmpVR2t1ZWlDeGRTWkJZTmJ5MEx0RDZSNjQ0MGhXMU9ub0lxRDh4ZUJy?=
 =?utf-8?B?SDQ3anEwUlRxay9TLyt4UTl0MWk2ckl6RTBkTDdteERBWTkrbXNNNzlmZkh3?=
 =?utf-8?B?WkVNbFBWM01aUmhwek9DdlJnZVJrVlVORkFKYmtBVmN0U0JFWE45RHdab1BW?=
 =?utf-8?B?ZmZvMU1RcklyWEtSZ0IyVE93ZVhPNVRnNko5L200T1RzZGJ4bzBYTFFGd1dV?=
 =?utf-8?B?RTVuUjZnR2FSVUxKUTlkTjREb0oyQXBVNHJ0a0x6citzRytuZ3pMMFJYTzVT?=
 =?utf-8?B?Nnk5bkZMVDhkY3ZIMDBEYjhJMmNOTzZPT1IzMEtsZlV4Y0tYcGowV3lYbThs?=
 =?utf-8?B?a2JlenFOMDBjTGcxNVdQZEdiVkhWbkxJb01ycytvc3Q1Szg5WGFYeGhPM280?=
 =?utf-8?B?am1XaG82V1pMMStTa0cyS1N2YmpuQkJTMHRKU3RramxSWGhYWG1IdHB1VGY3?=
 =?utf-8?B?MGJNbDZsMktmOUxSQWJNNklPb2Z2WnNUL2VPZFlzNERRM3FIRU1aelhlTTVB?=
 =?utf-8?B?eWN1UzA1ci9wTnFnSTAxZml0amxZQjBEV3h3OHpmVnhXdzROZVhxQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4e35387-1c27-4d3c-f4ea-08de7b6677b0
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5761.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 09:55:15.9672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tZZAc25D6Xna58mg2y1Gge0H49vYAOcmGpurXNW3KQQv5XkIa3c5eOU774uHu91S9xqq2U0wMFiGJmixKbVAgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7916



On 3/5/2026 11:48 AM, Lizhi Hou wrote:
> domain->mm->iommu_mm can be freed by iommu_domain_free():
>   iommu_domain_free()
>     mmdrop()
>       __mmdrop()
>         mm_pasid_drop()
> After iommu_domain_free() returns, accessing domain->mm->iommu_mm may
> dereference a freed mm structure, leading to a crash.
> 
> Fix this by moving the code that accesses domain->mm->iommu_mm to before
> the call to iommu_domain_free().
> 
> Fixes: e37d5a2d60a3 ("iommu/sva: invalidate stale IOTLB entries for kernel address space")
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant

