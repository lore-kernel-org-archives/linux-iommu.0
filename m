Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011041.outbound.protection.outlook.com [40.93.194.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D776E4AF165
	for <iommu@lists.linux.dev>; Thu, 24 Sep 2026 18:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790274887; cv=fail; b=O60LIduLI8BDBG+n/BEf22NcVa0iKOrMZuqwUHp8DxzIZnHQsY51vb0YtiMnP7/wRR4DqxrA6U7fokUITohnG/4S1Q5hVlLS3gK4v/r49lIWAq3uEsOVSq+mtQD/K6Au35W1yyjbR400Hgn2jq10wtY6NN9JD6DNtyvGR0d86RI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790274887; c=relaxed/simple;
	bh=EYfoNAiFfc0jwt1Xs0nVMY8IQBIuE6cvlI/+GTviXto=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=j7w2J6ZneBFXz+h12JO6UoG3n/c8KwKJf1sHLi2CkyjyMwb9KkL2AJ3fK8aUCvlU8GxUYoIXbzWn4iMpu6YXx3EOczT5nqDlaCQ8G9p5ogydccmk+TIQXRd0lUzoqJRxCDCU1dfNU2hfoF5ztgGD6RM+6jlpjLxUzdZvghZTIEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qxFR6EWu; arc=fail smtp.client-ip=40.93.194.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qxFR6EWu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GpuVjXqZFs4l+az/DfZuoUB9qXfN1j3rTEBQnp6oi2RIMQ0YCx3TyAmZRRQ2Edx2MQJsQTMoIUYEBCi1+WDCPcF4641W3T+6l4F3rHN4I78r5vVYO+KeyydTvUJ22DJ3sO1OmlTa93w7ViWNcO69a+AKTPQVBYnQ18GvYWwF1vyGFRhE31ufH9tYBP58En/Zw/H4si+jU/fq8dFVT534hYf5F11aUGlEfcPuWs/W7Pi5MiQ+asVe74kM/ixC+NcbvDzxDxcfeYvo06/JMHb2o6YwgqyGF/dRrgPcRifOhaV1e++gcbpkBFS2o88EMYTjTA5yAwWKuTObmYW1xqrYVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VHhTPEWkm9i9vVZC6qawP2mSmA4rZfoRVLGjctUvU1s=;
 b=wcNpjRAmUKF0Z91FofaYblvPH3ALgGh2eqRqsI/SxJjjh+I6yKgpZsEINFpWP5mJAEgdhBC6Ur0EJsCVLqBB3U7w1r/6rx/tJWvpl5C1ZlX55ye6c6o9T3vq/OeCwyoXKgK9frCXZwr+tTXvUWTi1+wxhVa1v+fPbfR4s7+AonQrIv1FO+Uobbff3L7SJqOykDtqJWxln9y8aGq/avJwVq2huoZnK8zVjs8s3JW36XhLodV/9Of3fvZ41LWcOhSyh6vP0V2GcEng63qO5+XTcgLWnYS5WWnNkJGE3nmEDPPrVlHtHrpObS+IWp83860WH6l5IockOYiiAlPEc7+SyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VHhTPEWkm9i9vVZC6qawP2mSmA4rZfoRVLGjctUvU1s=;
 b=qxFR6EWujd6lOcfBZz40RuG2g3QwU17Z+tP9Yq6deDtYtlMAR+44ATGQ7dBRYIWMfUTniyP5LbjAbmRRPvgIMQovJmw6D09GoV9Rjo2ckieTPkE3qRTcaTI2ShG778jAve5UQTvy/fL/8M3dmeUR6qvUloPWQyNn8n9tqM/TVqATq60FM1gPOumYRsgLNVnbNzCwUuxpps/jIlE869l1wzvm1m945UAI/V5w6tSvDDmqMLxiZBDmanQWJMgqjYmegStpzlsB3Z0V9lglGy5bZLLL492vW3niVB/KE3BBdZ8NPgSsDsoz0Yt12otQxuw9Sh6qSzhRdXO2zYGBvn5eNw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by CY8PR12MB9035.namprd12.prod.outlook.com
 (2603:10b6:930:77::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 18:34:40 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 18:34:36 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 0/5] iommu/arm-smmu-v3: Fixes reported by Sashiko
From: Jason Gunthorpe <jgg@nvidia.com>
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, will@kernel.org, robin.murphy@arm.com, 
 joro@8bytes.org, jgg@ziepe.ca, nicolinc@nvidia.com, praan@google.com
In-Reply-To: <20260924085616.300650-1-smostafa@google.com>
References: <20260924085616.300650-1-smostafa@google.com>
Date: Thu, 24 Sep 2026 15:34:30 -0300
Message-Id: <179027487093.16814.5144642113986528242.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: SJ0PR03CA0177.namprd03.prod.outlook.com
 (2603:10b6:a03:338::32) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|CY8PR12MB9035:EE_
X-MS-Office365-Filtering-Correlation-Id: b0a2b779-9542-4c40-e33b-08df1a6a7c81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|10067099003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	oE8ipwHkNhvdW6l75vryNG3fmG1f9L2EHhIDMh2EL1/bP9SizkLdMHZQSCHfibUPcvi/aXvmJDw/XEcpGSVhpC2zroDs9tN34yKiGuY//EWxWDCR7xOJ0FzEqHactCni+YHazgi6N9GV77JmTlANm5geMJXnWatDp/sgNteda2kBEP5eThFkrJRWCFn1VWM4Q39Zwk+kYDnt60kzQDAsRK3z/TVUVMOdUVCsCqmvFA7H5JvR88miQAg/rT4hNDEgqAAqjmh8ZlhgfLUO0b0knjrfITkjvISTxvOnJ3DJ2iZJsPokDeV8Yx/mWITYmGt7qELEEdLDkMxAMNMya2Q8UbW8OY4fyr41p1T7/kKB9ndO7o07RlHT9hVcnWUfjwf7Oz6c2B4jkqKRu/gSctYJwxadWx4iFwN7GLRUlj4EW1KYjCZmDcMxz5HgeJb5jysDE/Br1MDmZyYcGswh0BFAPuOgRnnQqqK102FVRz2lBwnjr7OT7yGMv98gqM5POqbgkAgTUiyBwhBqpxzLfRnoutr5aT12DYeVxkdnpasj8qV2nmzl1NSIVBVOVSgHPa+eHgzaU7ub4eJ5YuHGuZNdqF7DkQo9SAeXhJkwern150dAAmlS/7PaqHxLXgTO5UHrsgbKzrKC6Wll2mHRSND3tii2D5NgU9W8Vf0/A2+UnAc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S2JsNExDN0VsdFZHZlVkRG1OZ2RUWnREYUE2UXU3ZllsR2pQR0dEN2xTVlZq?=
 =?utf-8?B?Rm5oSVM0U3Y4K0ZQeG9jYWo5THJYTWk0MHN4bEdiMlhWY2pWOXMrYjBkMm0r?=
 =?utf-8?B?a0Z3a3YvREd4RldhNFhpZTlrYmdIbjF3ZHBEZ21rZVV6UkhjSUIyVW9YNGZW?=
 =?utf-8?B?M2JrTDBoUmYybEtuMTJSZCt0ZXUyT09tMGZicXJkUjUyamt6Vi9YcUZVcW5l?=
 =?utf-8?B?Wmpvc2xQcDhOaHNiMVFYWGYyNnp6SjBJNC9mU0NCWjV4Mnp6YkhKOTlJZkkx?=
 =?utf-8?B?dDFMcXkwa3l0WXgrMWZhVlpLU1lTU3o0VXBMNnJTVU5OTGJteXRoVlBMUVF2?=
 =?utf-8?B?TDBWa0Evc2dsZEdFWnphSXJKdVB3ZExsUVhrbVRuYUxpeEJaRkZFK2Fka1FT?=
 =?utf-8?B?bG1ialJRQ2xwVGV3NTRRQjZXQmtZQUhTVzhiSG5WSzNGalhXREh6RDJycFhx?=
 =?utf-8?B?SXQ4NldjU3Y5dHRka281QUFpRjcvUFBCWDhhakdPMm55alB5a0tjLzJaeUR1?=
 =?utf-8?B?Q0lNb2NEWXdralNlRklUdlBMUWg4Si9pM0M3RzJWTkpNdUJPc1BUdEtuUFZ4?=
 =?utf-8?B?TmNJa2tzRlRIMWxXZXNidjRuWnN0OEZRODFrODk4eDBJcEdlK3U5eG1NcEtY?=
 =?utf-8?B?aU9KWUc1OU5mdnN0Zjd1V0pLTStkRVQ2WGxRM0pWQ3NUUjNsNEhYTVpTNXc0?=
 =?utf-8?B?SExHM09KdUNxV1VZYm9rZE8vZUdaOUpsWGNLSnl2K2pXRWpKcG1WNUNOdWNU?=
 =?utf-8?B?OUl1UHQ0U2dUV1dxQWlVL0M3NFZicnp6RnNGdzZJZGZiMHRJcDFnVE4vYTd3?=
 =?utf-8?B?OStNbm1PUkVYOGV6MVZYSEhkTFk5U0hmdlNWbEt4NjJFODgwQll0eDhFcTZK?=
 =?utf-8?B?a1dBaWlEMjFlUHBjcTJtdlN6OUlEdnpMcXlGc3ExY0wxU1BtOXpydmNUNGwv?=
 =?utf-8?B?b2loSmNxRitTTEVsWlcyOW9WOHRrS0t4c2pKQW1zNGNmWktyOGVRMC9sZzFV?=
 =?utf-8?B?Y3pMYVBXdFMvU3pDS1FZalZXYkIrSDVSZ3hkR2U0WVJEb0EwMjZScXM4WnFE?=
 =?utf-8?B?bXVSYzJmZ0p5VWwrMkpFZEVXWWwwOXJVRDBVdks5bGpMRjI0MUJ1K2NHcjVG?=
 =?utf-8?B?SXhiN2Nxc3VpYkpZMk5URFloR2ZmWlk2T3VZZ1dyVFNJcStjNkIyWXRIUzZF?=
 =?utf-8?B?eko5YmhwNVd1UlRwWU0zeTJmRWFTdjZET2xrOVRwUzVUY1dUbzQ0YmlONE4x?=
 =?utf-8?B?Y0t1RlhuL3BlU0p5Wm5wSDc5aFpMb25SeW95NW5IQjhZZysyTm1wYTNnUWtq?=
 =?utf-8?B?T2dmQjIxbStaSTZkQXNoU2NVV0E0NnpBeXZ0N0lGZzBsSmpNRkpVTnBmS1I3?=
 =?utf-8?B?VXJrNzJ0MUJDZFRDU3VRRlhVeWlqMnYxY2VBM053RjF6NGpKQjFxaktvUGlN?=
 =?utf-8?B?KzRlRGJWV1hFRTNjWDgwb01qNXF3UTVFKzl4eUJLa0pzdkJ0eFZRNm5tbDBN?=
 =?utf-8?B?YVhqZXFrSk1kdFBIYjNPc2FJV2ZnNStRVWtSNFhxR3A3eGdzblF1TG5HL1Ba?=
 =?utf-8?B?Q1dnQ3VmajBzQ3BiVERvV3Exem5Tb0lFMU5RVGsvbkphajdRM0FqbUE2aUpP?=
 =?utf-8?B?T2tqRDVxOWFaU04wL1lwbWthd1lLKzA3WkNxOWFKUWJYdncwQkRNVVhSaXh2?=
 =?utf-8?B?N2FXWm9RcFVCQ3hsQTZYYXQwWWJ2akVhbVpyRlN4WUlOWGtxSmFYd3FIeWlN?=
 =?utf-8?B?M1dRRlppcjgrekg5aXJuSWU1SVkrY1FhekJlT3VQdTY3U05ucWtMZ3lQNFNm?=
 =?utf-8?B?YmE1dFBBUlRHUUl6ZHkzbTFtV3VHK3pwL3RoU0J0K1hKNnpwK2pmRHB0bmdu?=
 =?utf-8?B?RUUxMW52UlkyQU4rbEVxWWxHQ1k1TDR5Nmg2LzZTdHlOMWQrTDVvR090Ry9s?=
 =?utf-8?B?bUkrdkRldHcxUXJyLzZHbDJyZU54Y0JUbE9XRENabitaSjVYY2FrL29pVDEr?=
 =?utf-8?B?K0lOeklmSjVNaU9uS1dwWDArelU5RGFuME1PK1Q1N2cxbEpYWncvMVErazFm?=
 =?utf-8?B?Mno1YklJMUJaOWFEZ05wTnBHSk9BSWRsS2FXaTFob1pJa2dDMFVBQXN3U0Nq?=
 =?utf-8?B?ZnZLbStTQWZibWk3ZWJYOFgvbVJYTXVlVXRQeXNUM28xeGRnb3hFd0g3bnFT?=
 =?utf-8?B?dUlqZk9GaFVRWGZPZWhNUWN3ZDU4Wm5QR09oNEIzZEdQMVo4WGhLWXdWM1BD?=
 =?utf-8?B?dzlDbHhRblZsUERtZVNpN0hCRWNvQWhXc0dQMFFQWG9Hd0pCWjJoSHNveE1F?=
 =?utf-8?Q?zc3iZN0kMKLI5wClkp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0a2b779-9542-4c40-e33b-08df1a6a7c81
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 18:34:36.8503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8eWwmWUDPlNLHHDbyBkZbLSiI1RlnwXf98ehA5I2iOQagjlPbFCgwGKfcQToOulw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB9035

On Thu, 24 Sep 2026 08:56:11 +0000, Mostafa Saleh <smostafa@google.com> wrote:
> iommu/arm-smmu-v3: Fixes reported by Sashiko
> 
> While running sashiko locally on the pKVM SMMUv3 driver patches, it
> reported some pre-existing issues in the SMMUv3 driver (the RB tree
> corruption and a missing NULL check) and given that this is not the
> first time a pre-existing issue appears in the driver from sashiko,
> I went ahead and passed the whole driver to Sashiko which reported a
> dozen of other issues(except the last one in this series), I included
> fixes for bugs I believe are true or worth fixing (others were mostly
> missing NULL checks or bizarre HW/FW configs I don't think are needed).
> 
> [...]

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

-- 
Jason
