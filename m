Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010065.outbound.protection.outlook.com [52.101.56.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E5F426697
	for <iommu@lists.linux.dev>; Fri, 11 Sep 2026 10:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789121951; cv=fail; b=topZQBmflSrYxCdF8S7EWY0MZOoJ4ELXrV2gdAJ6g8F+h6L4ATVvUjZlpEg8+rBADv7IPkQvrXM3150zagBq5RWBcySZVGcekwYs3qF8YFN9slOvoTIR6d34vnmkOTJOL7T0pz60KPDIb5Sb2vJvJbWPNyuKol6mdYLI9aa2vEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789121951; c=relaxed/simple;
	bh=FRwQVlO8GAkAymLf+8QXs9AwI7CCs4KSOVp+tvY03Mw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fYCiBcQgRnhQy3BZ2ZKhEfcklq0b6l+z+yEQPNNrW+wtIzsyrpGhlun6VdnUj3W4x6FY1/jVWxrb8PO9nh4bqeq4rSjrPOO5SuiB2C3+sjayO1AOi63wvRs5KSGzmFz5LvCF8ibHe7rh5e+Dl4r60xNfM0nGsmn1gGJx8g4TpZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FzRjp81q; arc=fail smtp.client-ip=52.101.56.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FzRjp81q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CO89OoAJvRod6+Jahj6mqoHzne9JjqOATE2NfzJ7TkmSUXd6qVtBt1tpY+ejBw8F/9ZxN+JcKxyyJKTU715vVAnfggm49cH8bi+vbR+rCXLDwZDdYGtLDO2nDd+IqVGAXbRr0druQBDzGMGePa2I+ZPjYwaUw3zEfXfwZekuCzX2mTyMoYAMEmZcIWJjDhEYrA5Y+gFOqJhRT8xqzv2eWYkGxh8+LoIvc1QjlJ3ME9gQFV6kBI1+NTXzTrkYfi9BnTO5YhJvzYl0dDO5dmhsoainyr5k4ssk8UT9CRQBXTVz6bfkQZDkNtBnkjNJmBmpMULZxqfj4Ek8m+JH3bfpow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FRwQVlO8GAkAymLf+8QXs9AwI7CCs4KSOVp+tvY03Mw=;
 b=nCl2h3Jx+OqUwKHnjwe/aOgsbhwqamh2yezJ3BQ6G9ECnBB/FUMmndfOa+jWO0LuoRI1J9g6j+jxtSnc2BOS0oYkdk9GtoSTFCpFmwGzqHNIWL4p3sZUVRIVUdI9yxMyaMUYOdrNZ5IFvuVrBA6qkl8XhZ8SnebQdS5EJZeTkbENJXHVIKTDtMZppNmcVVDrXAndtfD0zLFsv7jGDdF3glB7EeZOG5LLaKRgHy7DDMMShgPNVo7K6f9AjDN05cy1U8cZtBQuwMnVxbdZdDBMgErQwkR5/o4AKf9WMcT6Y0ts8uycx+iTcA0W/lhBJ8XQ3IA+nMFxcfrMNtOG1HSI2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FRwQVlO8GAkAymLf+8QXs9AwI7CCs4KSOVp+tvY03Mw=;
 b=FzRjp81qktzxpBYJQlSyJiylsJNnCg1kx9ukBxV61HJetK9R3Hpeu2S9Kmwfpa/lOvlwmQ1kq3YV7b5gN1d35dEsTaJP73iuIljfInkrXZh8Uw+D4EaQLDy9lhkPgSW9lo0NEB0A0afaPYCa/IrwIDEs7u1eO0RfCquAym0h+Gg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 by SA1PR12MB6773.namprd12.prod.outlook.com (2603:10b6:806:258::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 10:19:02 +0000
Received: from BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83]) by BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83%5]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 10:18:53 +0000
Message-ID: <8fd5b797-363e-4167-a00b-09bf32c17e1a@amd.com>
Date: Fri, 11 Sep 2026 15:48:48 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] iommu/amd: Cleanup and fixes
To: iommu@lists.linux.dev, joro@8bytes.org
Cc: will@kernel.org, robin.murphy@arm.com, suravee.suthikulpanit@amd.com
References: <20260911083353.4812-1-vasant.hegde@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20260911083353.4812-1-vasant.hegde@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0193.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::22) To BL4PR12MB9505.namprd12.prod.outlook.com
 (2603:10b6:208:591::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9505:EE_|SA1PR12MB6773:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fe05b83-6c9b-4966-6da3-08df0fee14ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|10067099003|22082099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	NtrDm6dRIgPZTOwbc2C60JNwhsho3R/q8L/4/PDsllgAq6kVHa2kdjMB3oOu5PK15ejBrsU4wqMpCIB44mHqlY38ijIFYMWyTClc9wd2nP7wKYyxzEriPio2+ommmxj94mX8PPTUVJAW7v6H93xp/w7/DPWkiXgMi5JSckDGRZM5YgU3hcViez4L/rbHDvx+52RUayAOUszlaZC+LSlvmz7jImKYfMbYeWceJqb+xNE+VGdJrNGlpMooiqXqec14WG4I9SFiSQlLjBObFqlRlxP0L9PezOSUGI26qlRI7WHvlVylkeWAfkU2BkhDR9d86AgmFdmZp85fgJFdLuXodDsathPQK54QH0kaQsGr2n538cMVkWWcDpA8UqTxDNI3apc9SEwHtlUunAoQ+e4t74cZQkvg379z52U+bmeXgyl9r/R4J+BNqfqFQVOA5lkMY9dyFt/+d2N0e6hbvatXjQvgES27M8FfUTaFRZy/XkCAf6hmrKEWiZkWINswm9GCqklkE7HzQSNWwJ20EC2k2myCuGwEyyFzhFePIJ/57qJrYpdSDgbSh/yMQgzdahALe3U3o1MEfV2nDgaqdqn3H6m10FsWC/XYuI2hOXOGQ9X2dj2Tta6QCx635EX/1YzsAtMsMi//0CW81PuComhcO8sFfza6IvUz1uEt00+Q0h4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(10067099003)(22082099003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dVlUTnROOHNXcXFJTVJFQWxWQVJxTTNXR0dqQmo0SnNpTzNnR2ZybmVGamhF?=
 =?utf-8?B?ZmhQM0JzcnRGZlExVTdPM21NSktUWm9PMW13ZVJqamc0c1FETXhzTnVuZ3JE?=
 =?utf-8?B?aU9qMEVhU2lQRWJsVW1sZTFUOUkrU010Zyt3Ri9pZVJmR2U0OHJGR2tIT0J0?=
 =?utf-8?B?cWVTNGtaV2xkZGpFWFpucndkU0Q1aFhJa3hTUytBL0xMaVpCaTJoaFlhdUQ4?=
 =?utf-8?B?UFhieGg1RTF2bXQyT29PZGVTbmlMYWV1TGlOVkFBSjBnZDZUUnlqSDhTb0h3?=
 =?utf-8?B?bGhEanNEeHVTQWFjOFo0Z3ExWnB0QmVWNDhrcm5VeDhOakNob3Z5cy9GbVpZ?=
 =?utf-8?B?OHdZWGdvMW5ORjczNVBRUXR4SE03UHVMSzZBL0t4Z2xYNDRXZGhmL0VERXhz?=
 =?utf-8?B?T0l5WEw2QTJaWjEzWTJnRnBkWm1EVVo1OEdqV0VnQ2U3T3FkMk45N3pvcHZW?=
 =?utf-8?B?U29wbjhzK1YrdFp0K05HaEN4MFF1eWlyajJvUlpvVjJUcFVEQVFsRW45ZWdi?=
 =?utf-8?B?MWVucFhsSGwvL1d2ckNvajZFdVhodlhTTnlLdjdxRFBpSXJyMzhhdnpGeGFX?=
 =?utf-8?B?TSs3dVlFT28rK1MrTUJGYjJVR2tsR1F5SHR5a3J2Uy9SeHFGaFhSV05Pd3Bj?=
 =?utf-8?B?NXhBL0dzT1FVMURaQStSZXQvNmtqTExxY1MrOFZuS2Rhb0ZQUEtUNkdaZWtr?=
 =?utf-8?B?d3dzMnpxY3JYQ3ZEdHkyNUk0SVpMajl5SDgwUTl6VThNalJQK0ZNOXZxbkxr?=
 =?utf-8?B?Y0ZXOEpZc09rZlJ2aHJScVZHNEFURm9laDZyL2FKMkhXem9hZ29mMitTaTQv?=
 =?utf-8?B?dytsci9wOHhXcTFlWGxZamJFRTZOTDJaUkMyTEdpNEhCMVFVemxVN2VNU1Bi?=
 =?utf-8?B?aG9JRUx2ZHZleGVVS1JnQ0UzSVd2SGs2Y3dwWUo4b0dhVWQxM3lxRm9vWG9V?=
 =?utf-8?B?LzFSZ3ljS0Y4Q0sxSHlab1FMc3B1VGFoN3B4UlBUb0FTZkRxY3F4REZlTnlU?=
 =?utf-8?B?VUZpSEMxSU90LzBjMTlvbGp0MUVVVE1mcGJ1cVZjbmJQaXpUeVp1MGRJOS9u?=
 =?utf-8?B?YmN5c2dsVmh1S2dVOFBibkhLMVZnaktyZ1NnQmQ1T2FabVdSWENSdHpwbzdh?=
 =?utf-8?B?aUNHNC9ZMzZkMWhuNmxTT2ZvTHRlVVcwa0VwcVJMSDdsb09PQW9qR1JSWWtv?=
 =?utf-8?B?VzcxNFcyYk9ndksxei9wd1dUNFVic2pTWXNVZkdFYjZ3cjlqS1NSOGRLZm91?=
 =?utf-8?B?TWJhYnNOdEtrOWhzUWliR2o2QmMxMmt4c0NKZFBZb1Nrb1VlQ0ZIYU1qZGFs?=
 =?utf-8?B?d0s3Rmk0SFBqdlowUDR0T0RxeEpFc0FWWUZqMm93RTdybUVRL0hQUWp1aWwz?=
 =?utf-8?B?L1J4bTlZaExoUTdaWjRGUTY1ekp6M09rRnBTMk41anBhVFRmN0pMNDhWTEh0?=
 =?utf-8?B?TFZUQ0hoOStCRWVnTXg1RjR6ZmxBYVA4QzFZTUM3N0pJVlVqa0ltT0FURXVF?=
 =?utf-8?B?Y0pIZmdBeUhSdlc1MEVtak9POUsxWFU3b2k1UzJmUkVXWVFhL3hQblhUSlN3?=
 =?utf-8?B?S05vYTJiNVIyMGVwRkJqeGJNdlZEbEZTVTZJZERkRUs2VE56b3pIUjY3SlIv?=
 =?utf-8?B?WTBwbHJSRlRnZFhQUnlzdzkzeHUzYjZhRUVJQ2tuUWEzTnZ1STR3S0R0aUQz?=
 =?utf-8?B?SHZZdDZBNDB5SGNVOVpVcDFnc2dLQUdtcjdTdFloRzI4K2lZMzFzS2pNUU83?=
 =?utf-8?B?WjRZbWMzbVNMTy9EeTA0RVQwOGxiaXg0U281NWpQdHpIUUFja3h6MDZpR2pi?=
 =?utf-8?B?ZWQrWjNwUThINkNaSmZsN3lscHdnVEpnNEpOcGxqV2Uwa0FLWlZzTmlka2V3?=
 =?utf-8?B?d25SSlBtT3BRcGt5WUxlaTZObDJZQ3JBVkFVWmx3dFluc2FHNVJnUWphMy92?=
 =?utf-8?B?Q0g0eDZEdWNROTg4d2tvNkR5YU81RlFibzNkTnV2MDVLbTRyR2hoUVA4NUdk?=
 =?utf-8?B?VDVFOWFRZHNwYjU1YmNkQmh4QkNUTWNReVBhZ2NlVzlhczNjaGNwbG5aczdn?=
 =?utf-8?B?QXZJTWsyY3l1K0xGVE41a3pYbDl5VVBjQkdENytyeWM3VDZqYTlxZ1UxNUl2?=
 =?utf-8?B?NnJkVEhnVGFhN084Qmt2VkVoNVhRL3RMUTZ6dFh0K29zOXBOL3ZON1BvK1hN?=
 =?utf-8?B?T2ZsSmYvc3ZlU2daK1lnNXVkTTZVeGNlSTNUK0xCVXJCYTkwMjJsc3JLQ21J?=
 =?utf-8?B?am1MYUZ1aU1VUnBWRy9wRjZCY3FEajhYdmFOdWlsa1BNZWM1NDBldlhHS3Rw?=
 =?utf-8?B?Unk1eDJpQXgxLzFIVkkzTWJYRENoOTJ2Sm9ENFBlNDQvRC84Ly9uZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fe05b83-6c9b-4966-6da3-08df0fee14ef
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 10:18:53.8562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rqjCC0cir3v0CU99ETlUZI2GyVnE/Mp1hK51OybPSDZo9QLHWi8e300HdX5SxfKzJTvCq2+emrfd9qdSHWQDAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6773



On 9/11/2026 2:03 PM, Vasant Hegde wrote:
> This series contains few trivial cleanup (like removing redundant
> checks, unsed macros, etc,) and fixes.

Forgot to mention, this patch is based on top of iommu/fixes branch (Commit
adbd8a08208dc6).

-Vasant

